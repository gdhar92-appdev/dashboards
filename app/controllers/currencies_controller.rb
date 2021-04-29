class CurrenciesController < ApplicationController
  
  def first_currency
    @raw_data = open("https://api.exchangerate.host/symbols").read
    @parsed_data = JSON.parse(@raw_data)
    @symbols_hash = @parsed_data.fetch("symbols")

    @array_of_symbols = @symbols_hash.keys
    render({ :template => "currency_templates/step_one.html.erb"})
  end

  def second_currency
    @currency = params.fetch("from_currency")
    @raw_data = open("https://api.exchangerate.host/symbols").read
    @parsed_data = JSON.parse(@raw_data)
    @symbols_hash = @parsed_data.fetch("symbols")

    @array_of_symbols = @symbols_hash.keys
    render({ :template => "currency_templates/step_two.html.erb"})

  end

  def third_currency
    @org_currency = params.fetch("from_currency")
    @conv_currency = params.fetch("to_currency")
    @raw_data = open("https://api.exchangerate.host/convert?from=" + @org_currency.to_s + "&to=" + @conv_currency.to_s).read
    @parsed_data = JSON.parse(@raw_data)
    @rate = @parsed_data.fetch("info").fetch("rate")

    render({ :template => "currency_templates/step_three.html.erb"})

  end

end