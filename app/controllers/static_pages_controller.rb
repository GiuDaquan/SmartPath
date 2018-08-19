class StaticPagesController < ApplicationController

    before_action :authenticate_user!, only: [:search, :result, :token]
    before_action :check_car_presence!, only: [:search, :result]

    def home
    end

    def about
    end

    def search
    end

    def result

        res = HTTP.get(MAPBOX_GEOCODING_URL + ori, params: { access_token: ENV["MAPBOX_TOKEN"], country: "it" }).body
        @origin_coord = (JSON.parse(res))["features"][0]["geometry"]["coordinates"]

        res = HTTP.get(MAPBOX_GEOCODING_URL + dest, params: { access_token: ENV["MAPBOX_TOKEN"], country: "it" }).body
        dest_coord = (JSON.parse(res))["features"][0]["geometry"]["coordinates"]

        @res = get_waypoints(@origin_coord, dest_coord)
        q_str = q_string(@res)

        @route = HTTP.get(MAPBOX_DIRECTIONS_URL + q_str , params: { geometries: "geojson", access_token: ENV["MAPBOX_TOKEN"] }).body
        @route = JSON.parse(@route)["routes"][0]["geometry"].to_json

        @token = HTTP.post(MAPBOX_TOKEN_URL + ENV["MAPBOX_USERNAME"], params: { access_token: ENV["MAPBOX_TOKEN_GENERATOR"] },
                 json: { scopes: ["styles:read", "fonts:read", "datasets:read", "styles:tiles"], expires: get_expire_time }).body
        @token = (JSON.parse(@token.to_s))["token"]

    end

    private

    MAPBOX_GEOCODING_URL = "https://api.mapbox.com/geocoding/v5/mapbox.places/"
    MAPBOX_DIRECTIONS_URL = "https://api.mapbox.com/directions/v5/mapbox/driving/"
    MAPBOX_TOKEN_URL = "https://api.mapbox.com/tokens/v2/"
    APPROX_CONSUMPTION = 0.187

    def get_expire_time
        full_time = Time.now.utc.to_s.split(" ")
        time = full_time[1].split(":")
        threshold = (full_time[1].split(":")[2].to_i + 25).to_s
        time[2] = threshold
        res = full_time[0] + "T" + time.join(":") + ".000Z"
    end

    def ori
        params[:user_input][:origin] + ".json"
    end

    def dest
        params[:user_input][:destination] + ".json"
    end

    def autonomy
        #in media un auto elettrica usa 187.5 Wh/km
        #facendo la divisione con la capacita della batteria ottengo quanta autonomia ha la macchina a batteria completamente carica
        params[:user_input][:battery_capacity].to_f / APPROX_CONSUMPTION
    end

    def q_string(vec)
        s = ""
        for i in (0 .. vec.length - 1)
            s += vec[i][0].to_s + "," + vec[i][1].to_s
            if (i != vec.length - 1)
                s += ";"
            end
        end
        s
    end

    def queryfy(vec, index)
        vec[index - 1][0].to_s + "," + vec[index - 1][1].to_s + ";" + vec[index][0].to_s + "," + vec[index][1].to_s
    end


    def get_waypoints(origin, dest)

        current = 1
        res = [origin, dest]

        while (current < res.length) do
            response = HTTP.get(MAPBOX_DIRECTIONS_URL + queryfy(res, current), params: { access_token: ENV["MAPBOX_TOKEN"] }).body

            if ((JSON.parse(response))["routes"] == nil)
                return -1
            end


            if ((JSON.parse(response))["routes"][0]["legs"][0]["distance"] / 1000 <= autonomy)
                current += 1

            else

                max_lon = res[current - 1][0] >  res[current][0] ? res[current - 1][0] : res[current][0]
                min_lon = res[current - 1][0] <= res[current][0] ? res[current - 1][0] : res[current][0]

                if (res[current][1] > res[current - 1][1])
                    min_lat = res[current - 1][1]
                    max_lat = res[current][1]
                    sector = 0
                else
                    min_lat = res[current][1]
                    max_lat = res[current - 1][1]
                    sector = 1
                end

                query = "longitude >= ? AND longitude <= ? AND latitude >= ? AND latitude <= ?"
                middle_lat = max_lat - (max_lat - min_lat) / 2
                ch_po = sector == 1 ? ChargingPoint.where(query, min_lon, max_lon, middle_lat, max_lat) :
                                      ChargingPoint.where(query, min_lon, max_lon, min_lat, middle_lat)

                if (!ch_po.nil?)
                    elem = sector == 1 ? ch_po.min_by { |elem| elem.latitude } : ch_po.max_by { |elem| elem.latitude }
                    entry = [elem.longitude, elem.latitude]
                    res.insert(current, entry)
                else
                    return -1
                end

            end

        end

        res

    end


    def check_car_presence!
        if (current_user.cars.empty?)
            flash[:danger]= "Add a car model to your set first"
            redirect_to new_car_path
        end
    end

end
