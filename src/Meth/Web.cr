require "http/client"
require "json"

module Meth
  module Web
    extend self

    private def curl_connect(host, port, https)
      HTTP::Client.new(host, port, https) do |client|
        begin
          yield client
        ensure
          client.close
        end
      end
    end

    def curl(url : String)
      server = url.split "://"
      https = server.first == "https"
      host = server.last.split("/").first
      port = 80
      port = 443 if https
      path = "/" + server.last.split("/")[1...server.last.split("/").size].join("/")
      curl_connect host, port, https do |client|
        response = client.exec("GET", path)
        [response.headers, response.body, response.status_code]
      end
    end

    def ip
      x, y, z = curl("http://canihazip.com/s")
      y.to_s
    end

    def location_by_ip(ip : String)
      x, y, z = curl("http://api.db-ip.com/v2/b95014c58e3cf1af36f9f5b57d70b1e49225ff38/#{ip}")
      res = JSON.parse(y.to_s).as_h
      Meth::Misc.hash_snake res
    end

    def weather_by_location(location : Hash)
      x, y, z = curl("api.openweathermap.org/data/2.5/weather?q=#{location["city"]},#{location["country_code"]}&units=metric&APPID=b110f9476d2a84b1a2c4dcd870f9f1d6")
      res = JSON.parse(y.to_s).as_h
      Meth::Misc.hash_snake res
    end
  end
end
