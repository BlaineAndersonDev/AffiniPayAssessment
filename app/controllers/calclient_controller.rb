class CalclientController < ApplicationController

      # render :status => 500

  def index
    return "Hello World"
  end

  def call
    valid_servers = ["sum", "subtract"]
    valid_numbers = /\A[-+]?[0-9]*\.?[0-9]+\Z/

    # Check that params are what we want (Valid server name & two valid numbers).
    return @information = { message: "Invalid server name." } if !valid_servers.include?(params['server'])
    return @information = { message: "Num1 must be an integer." } if !valid_numbers.match(params['num1'])
    return @information = { message: "Num2 must be an integer." } if !valid_numbers.match(params['num2'])

    # Convert our two valid 'numbers' to Integers.
    updated_params = { server: params['server'], num1: params['num1'].to_i, num2: params['num2'].to_i }

    # Identify the server to communicate with.


    # Return information to the User.
    return @information = { message: "Server name: '#{updated_params[:server]}'.", value: (updated_params[:num1].to_i + updated_params[:num2].to_i) } if updated_params[:server] == 'sum'
    return @information = { message: "Server name: '#{updated_params[:server]}'.", value: (updated_params[:num1].to_i - updated_params[:num2].to_i) } if updated_params[:server] == 'subtract'
    return @information = { message: "Invalid server name" } if updated_params[:server].nil? || updated_params[:server].empty? || updated_params[:server].blank?

  end
    

end
