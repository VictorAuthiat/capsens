class BillsController < ApplicationController
  require 'date'
  def show
    @bill = Bill.find(params[:id])
    @amount = @bill.content['DeclaredDebitedFunds']['Amount'].fdiv(100).round
    @fees = @bill.content['DeclaredFees']['Amount']
    @currency = @bill.content['DeclaredDebitedFunds']['Currency']
    @bic = @bill.content['BankAccount']['BIC']
    @iban = @bill.content['BankAccount']['IBAN']
    @ref = @bill.content['WireReference']
  end
end
