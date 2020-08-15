require "base64"
require "dotenv"
require 'httparty'
require 'json'
Dotenv.load

module MerriamWebsterCommunicator
    def dictionary(word)
        _get(_dictionary_path(word))[0]
    end

    def thesaurus(word)
        _get(_thesaurus_path(word))[0]
    end

    private
    
    def self._dictionary_path(word)
        ENV["MERRIAM_WEBSTER_DICTIONARY_BASE_URL"] + word + "?key=" + ENV["MERRIAM_WEBSTER_DICTIONARY_SECRET_KEY"]
    end

    def self._thesaurus_path(word)
        ENV["MERRIAM_WEBSTER_THESAURUS_BASE_URL"] + word + "?key=" + ENV["MERRIAM_WEBSTER_THESAURUS_SECRET_KEY"]
    end
    
    def self._get(path)
        HTTParty.get(path)
    end
end

