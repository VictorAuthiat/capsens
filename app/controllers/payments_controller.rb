class PaymentsController < ApplicationController
  def payment
    @contribution = Contribution.find_by!(mango_pay_id: params['transactionId'])
    transaction = VerifyPayment.new.call(contribution: @contribution)
    if transaction.failure
      flash[:error] = transaction.failure[:error]
      redirect_to(contribution_path(@contribution))
    else
      flash[:success] = 'Payment succeeded'
      redirect_to(contribution_path(@contribution))
    end
  end
end
