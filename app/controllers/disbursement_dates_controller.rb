class DisbursementDatesController < ApplicationController
  def generate_disbursement_date
    disbursement_date = DisbursementDateGeneratorService.new.call(Date.parse(params[:disbursement_date]))
    OpenStruct.new(success: true, disbursement_date: disbursement_date)
  end
end
