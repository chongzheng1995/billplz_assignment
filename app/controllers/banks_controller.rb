class BanksController < ApplicationController
  def index
    @banks = Bank.default_listing
    @banks = @banks.where(bank_type: params[:bank_type]) if params[:bank_type].present?
  end
end
