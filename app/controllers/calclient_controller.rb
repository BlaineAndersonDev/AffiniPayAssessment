class CalclientController < ApplicationController
  # Developer note: To extect functionality to another "server", add the server name to the `valid_servers` array, and include the required server + parameters in the `if..then` statement at the bottom of the `call` action. Don't forget to update tests!

  # Live version of this app can be found at: https://radiant-fjord-19093.herokuapp.com/

  # Developer notes for Goal 2:
    # I had named my two value parameters "num1" and "num2". Goal 2 requires that I rename them to fit more types of variables so I went with 'value1' and 'value2'.
    # My logic was based on always having two integers, so it had to be reworked slightly. This actually reduced the code footprint, so it was a good thing.

  def index
    @information = { message: "Hello World!" }
  end

  def call
    valid_servers = ["sum", "subtract", "concanate_upcase"]

    # Refute any nil, blank or empty 'server'.
    return @information = { message: "Invalid server name." } if params[:server].nil? || params[:server].empty? || params[:server].blank?
    # Convert the provided 'server' to lowercase.
    params['server'] = params['server'].downcase

    # Identify the server to communicate with & return information to the client.
    if params[:server] == 'sum'
      return @information = { message: "Value1 must be an integer." } if !value_is_integer(params[:value1])
      return @information = { message: "Value2 must be an integer." } if !value_is_integer(params[:value2])
      return @information = { message: "Server name: '#{params[:server]}'.", value: (params[:value1].to_i + params[:value2].to_i) }
    elsif params[:server] == 'subtract'
      return @information = { message: "Value1 must be an integer." } if !value_is_integer(params[:value1])
      return @information = { message: "Value2 must be an integer." } if !value_is_integer(params[:value2])
      return @information = { message: "Server name: '#{params[:server]}'.", value: (params[:value1].to_i - params[:value2].to_i) }
    elsif params[:server] == 'concanate_upcase'
      return @information = { message: "Value1 must be a string." } if !value_is_string(params[:value1])
      return @information = { message: "Value2 must be a string." } if !value_is_string(params[:value2])
      return @information = { message: "Server name: '#{params[:server]}'.", value: (params[:value1].upcase + params[:value2].upcase) }
    else
      return @information = { message: "Invalid server name." }
    end

  end

  private
    def value_is_integer(value)
      valid_integers = /\A[-+]?[0-9]*\.?[0-9]+\Z/
      if !valid_integers.match(value) 
        return false
      else
        return true
      end
    end

    def value_is_string(value)
      valid_strings = /^[A-Za-z]+$/
      if !valid_strings.match(value)
        return false
      else
        return true
      end
    end

end