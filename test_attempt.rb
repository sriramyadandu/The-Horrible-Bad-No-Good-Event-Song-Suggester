require_relative "spotify_communicator"
require_relative "musixmatch_communicator"
require_relative "merriam_webster_communicator"
require_relative "input_process_service"
require 'string/similarity'
require_relative "datamuse"
include SpotifyCommunicator
include MusixMatchCommunicator
include MerriamWebsterCommunicator
include InputProcessService
include DataMuse

words = DataMuse::Request.new('/words?').syn('birthday').limit(2).fetch
words << {"word" => "birthday"}

if words.length < 3
    temp_words = DataMuse::Request.new('/words?').with_similar_meaning_to('birthday').fetch
    temp_words = temp_words.select do |word|
        duplicate = words.find do |elm| 
            elm["word"].eql? word["word"] 
        end
        duplicate == nil
    end
    words += temp_words[0, 3-words.length]
end

puts words

# tracks = SpotifyCommunicator::search(["birthday", "celebrate", "party"])
# MusixMatchCommunicator::get_lyrics(tracks)

# similarity = []
# tracks.each do |track|
#     track.similar_word_1 = String::Similarity.cosine "birthday", track.to_s 
#     track.similar_word_2 = String::Similarity.cosine "celebrate", track.to_s 
#     track.similar_word_3 = String::Similarity.cosine "party", track.to_s
#     puts track.title
#     puts track.similar_word_1.to_s  + " " + track.similar_word_2.to_s + " " + track.similar_word_3.to_s + "\n"
# end

#SpotifyCommunicator::recommendations("4NHQUGzhtTLFvgF5SZesLK","classical,country","0c6xIDDpzE81m2q797ordA" )

# MerriamWebsterCommunicator::dictionary("Spicy")
# MerriamWebsterCommunicator::thesaurus("Spicy")

#puts InputProcessService::word_information("Spicy")

