class UpdateUserCounterpartsCount < Transaction
  step :update

  private

  def update(input)
    user = input[:user]
    user.counterparts_counting += 1
    if user.save
      Success(input)
    else
      Failure(input.merge(error: 'Can\'t update counterpart count'))
    end
  end
end
