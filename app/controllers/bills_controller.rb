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
    @date = DateTime.strptime((@bill.content['CreationDate']).to_s,'%s').strftime("%A, %-d %B %y:%d")
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: 'bill'
      end
    end
  end
end
