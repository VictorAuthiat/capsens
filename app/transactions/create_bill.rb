class CreateBill < Transaction
  tee :init_bill
  step :validate
  tee :create

  private

  def init_bill(input)
    @bill = input[:bill]
    @contribution = input[:contribution]
    @user = @contribution.user
    @project = @contribution.project
    @bill.user = @user
    @bill.project = @project
    @bill.contribution = @contribution
    @bill.content = input[:content]
    @bill.name = 'Bill n°' + (@user.bills.count + 1).to_s + "#{@user.first_name}"
    @bill.amount_in_cents = @contribution.amount_in_cents
  end

  def validate(input)
    if @bill.valid?
      Success(input)
    else
      Failure(input.merge(error: "Can't create bill!"))
    end
  end

  def create(_input)
    @bill.save
  end
end
