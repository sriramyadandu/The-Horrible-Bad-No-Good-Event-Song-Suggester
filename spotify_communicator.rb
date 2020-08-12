require "base64"
require "dotenv"
require 'httparty'
require 'json'
Dotenv.load

module SpotifyCommunicator
    @ENCODED_SECRETS = Base64.strict_encode64(ENV["SPOTIFY_CLIENT_ID"] + ":" + ENV["SPOTIFY_CLIENT_SECRET"])
    @AUTH = "Basic " + @ENCODED_SECRETS
    @AUTH_RESPONSE = HTTParty.post('https://accounts.spotify.com/api/token', body: {grant_type: 'client_credentials'}, headers: {Authorization: @AUTH})
    @ACCESS_TOKEN = @AUTH_RESPONSE.parsed_response["access_token"]
    @TOKEN_TYPE = @AUTH_RESPONSE.parsed_response["token_type"]
    @HEADER = {
        'Authorization' => ''+ @TOKEN_TYPE + " " + @ACCESS_TOKEN
    }

    def search(q, type = [], limit = 20, offset = 0, include_external = nil, market = nil)
        return if type.length == 0
        
        # Required params
        search_query = {
            :q => q,
            :type => type.join(",")
        }
        
        # Optional params
        search_query[:limit] = limit
        search_query[:offset] = offset
        search_query[:include_external] = include_external unless include_external.nil?
        search_query[:market] = market unless market.nil?
        response = _get(_search_path, search_query)
        puts response
    end
    
    def recommendations(seed_artists, seed_genres, seed_tracks)
        return if (seed_artists.split(',').length + seed_tracks.split(',').length + seed_genres.split(',').length) > 5
        recommendations_query = {}
        recommendations_query[:seed_artists] = seed_artists unless seed_artists.empty?
        recommendations_query[:seed_tracks] = seed_tracks unless seed_tracks.empty?
        recommendations_query[:seed_genres] = seed_genres unless seed_genres.empty?
        response = _get(_recommendations_path, recommendations_query)
        puts response
    end
    
    private
    
    def self._query_encoder(wanted_words, unwanted_words = nil, additional_word = nil)
        full_query = ""
        full_query += wanted_words.join("+")
        full_query += "+NOT+" + unwanted_words.join("+NOT+") unless unwanted_words.nil?
        additional_word += "+OR+" + additional_word unless additional_word.nil?

        full_query
    end

    def self._search_path
        ENV["SPOTIFY_BASE_URL"] + "search"
    end

    def self._recommendations_path
        ENV["SPOTIFY_BASE_URL"] + "recommendations"
    end

    def self._get(path, params)
        HTTParty.get(path, :query => params, :headers => @HEADER)
    end
    
    def self._post(path, payload)
        ###
    end
    
    def self_put(path:, payload:)
        ###
    end
end