require_relative "spotify_communicator"
require_relative "musixmatch_communicator"
include SpotifyCommunicator
include MusixMatchCommunicator

SpotifyCommunicator::search(["birthday", "celebrate", "party"])
#SpotifyCommunicator::recommendations("4NHQUGzhtTLFvgF5SZesLK","classical,country","0c6xIDDpzE81m2q797ordA" )
