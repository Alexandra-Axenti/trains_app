require("rspec")
require("pg")
require("train")
require("town")
require("stop")

DB = PG.connect({:dbname => "trains_stops_test"})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM stops *;")
    DB.exec("DELETE FROM trains *;")
    DB.exec("DELETE FROM towns *;")
  end
end
