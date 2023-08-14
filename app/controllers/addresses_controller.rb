class AddressesController < ApplicationController
  def find
    return render json: { message: "CEP can't be nil" } if params[:cep].nil?

    cep = params[:cep]
    begin
      address = Address.find_cep_and_create(cep, @user.id)
      render json: address
    rescue RuntimeError => e
      render json: { message: e }, status: 404
    end
  end
end
