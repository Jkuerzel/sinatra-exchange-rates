require "sinatra"
require "sinatra/reloader"
require "http"
require "dotenv/load"
require "json"


get("/") do

  raw_response=HTTP.follow(strict: false)
                      .get(
                        "https://api.exchangerate.host//list",
                        {
                          :params => {
                            "access_key" => ENV.fetch("EXCHANGE_KEY"),
                          },
                        }
                      )
  parsed_response = JSON.parse(raw_response)
  @currencies=parsed_response.fetch("currencies")

  erb(:home)
end

get("/:first_rate") do

end

get("/:first_rate/:second_rate") do

  @exchange_rate=HTTP
                  .follow(strict: false)
                  .get(
                    "https://api.exchangerate.host//convert",
                    {
                      :params => {
                        "access_key" => ENV.fetch("EXCHANGE_KEY"),
                        "from" => "USD",
                        "to" => "INR",
                        "amount" => "1",
                      },
                    }
                  )

end
