require "base64"
require "dotenv"
require 'httparty'
require 'json'
Dotenv.load

module SpotifyCommunicator
    @SPOTIFY_BASE_URL = "https://api.spotify.com/v1/"
    @ENCODED_SECRETS = Base64.strict_encode64(ENV["SPOTIFY_CLIENT_ID"] + ":" + ENV["SPOTIFY_CLIENT_SECRET"])
    @AUTH = "Basic " + @ENCODED_SECRETS
    @AUTH_RESPONSE = HTTParty.post('https://accounts.spotify.com/api/token', body: {grant_type: 'client_credentials'}, headers: {Authorization: @AUTH})
    @ACCESS_TOKEN = @AUTH_RESPONSE.parsed_response["access_token"]
    @TOKEN_TYPE = @AUTH_RESPONSE.parsed_response["token_type"]
    @HEADER = {
        'Authorization' => ''+ @TOKEN_TYPE + " " + @ACCESS_TOKEN
    }

    def query_encoder(wanted_words, unwanted_words = nil, additional_word = nil)
        full_query = ""
        full_query += wanted_words.join("+")
        full_query += "+NOT+" + unwanted_words.join("+NOT+") unless unwanted_words.nil?
        additional_word += "+OR+" + additional_word unless additional_word.nil?

        full_query
    end

    def _search(q, type = [])
        search_query = {
            :q => q,
            :type => type.join(",")
            # :market =>
            # :limit =>
            # :offset =>
            # :include_external =>
        }
        response = _get_search(_search_path, search_query)
        puts response
    end

    def _recommendations(seed_artists, seed_genres, seed_tracks)
        return if (seed_artists.split(',').length + seed_tracks.split(',').length + seed_genres.split(',').length) > 5
        recommendations_query = {}
        recommendations_query[:seed_artists] = seed_artists unless seed_artists.empty?
        recommendations_query[:seed_tracks] = seed_tracks unless seed_tracks.empty?
        recommendations_query[:seed_genres] = seed_genres unless seed_genres.empty?
        response = _get_recommendations(_recommendations_path, recommendations_query)
        puts response
    end
    
    def _search_path
        @SPOTIFY_BASE_URL + "search"
    end

    def _recommendations_path
        @SPOTIFY_BASE_URL + "recommendations"
    end

    def _get_search(path, params)
        HTTParty.get(path, :query => params, :headers => @HEADER)
    end

    def _get_recommendations(path, params)
        HTTParty.get(path, :query => params, :headers => @HEADER)
    end
    
    def _post(path, payload)
        ###
    end
    
    def _put(path:, payload:)
        ###
    end
end