require_relative "spotify_communicator"
require_relative "musixmatch_communicator"
require_relative "merriam_webster_communicator"
require_relative "input_process_service"
include SpotifyCommunicator
include MusixMatchCommunicator
include MerriamWebsterCommunicator
include InputProcessService

# SpotifyCommunicator::search(["birthday", "celebrate", "party"])
#SpotifyCommunicator::recommendations("4NHQUGzhtTLFvgF5SZesLK","classical,country","0c6xIDDpzE81m2q797ordA" )

# MerriamWebsterCommunicator::dictionary("Spicy")
# MerriamWebsterCommunicator::thesaurus("Spicy")

puts InputProcessService::word_information("Spicy")

