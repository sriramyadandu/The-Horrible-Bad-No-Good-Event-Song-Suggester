require "base64"
require "dotenv"
require 'httparty'
require 'json'
Dotenv.load

module MusixMatchCommunicator
    def get_lyrics(tracks)
        return if tracks.length == 0
        
        tracks.each do |track|
            matcher_lyrics_query = {
                :q_track => track.title,
                :q_artist => track.artist,
                :apikey =>ENV["MUSIXMATCH_SECRET_ID"]
            }

            response = _get(_matcher_lyrics_path, matcher_lyrics_query)
            response_obj = JSON.parse(response, object_class: OpenStruct)
            track.lyrics = response_obj.message.body.lyrics.lyrics_body.gsub("\n...\n\n******* This Lyrics is NOT for Commercial use *******\n(1409620512350)", "")
        end
    end

    private 
    
    def self._matcher_lyrics_path
        ENV["MUSIXMATCH_BASE_URL"] + "matcher.lyrics.get"
    end

    def self._get(path, params)
        HTTParty.get(path, :query => params)
    end
end

