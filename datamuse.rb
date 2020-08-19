require 'httparty'

module DataMuse

    class Request
        include HTTParty
        
        def initialize(path)
            @path = path
        end

        def fetch
            response = HTTParty.get(full_path)
            response.parsed_response
        end

        def with_similar_meaning_to(phrase)
            self.class.new(@path + "&ml=#{phrase.gsub(/\s+/, '+')}")
        end

        def syn(phrase)
            self.class.new(@path + "&rel_syn=#{phrase.gsub(/\s+/, '+')}")
        end

        def limit(max_result_count)
            self.class.new(@path + "&max=#{max_result_count}")
        end

        private

        def full_path
            "http://api.datamuse.com#{@path}"
        end
    end
end