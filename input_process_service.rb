require_relative "merriam_webster_communicator"
include MerriamWebsterCommunicator

module InputProcessService
    def related_words(word)
        MerriamWebsterCommunicator::thesaurus(word)["meta"]["syns"]
    end

    def word_information(word)
        MerriamWebsterCommunicator::dictionary(word)
    end

    def word_short_def(word)
        MerriamWebsterCommunicator::dictionary(word)["shortdef"]
    end
end