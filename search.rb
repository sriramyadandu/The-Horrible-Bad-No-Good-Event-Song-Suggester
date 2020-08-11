require 'httparty'
require 'json'

client_id = '966ad292feb1482199f7e3679ad30202'
client_secret = '5de2a4bf4f6943fea9f312915f5560fa'
encodedSecrets = Base64.strict_encode64(client_id + ":" + client_secret)
auth = "Basic " + encodedSecrets
auth_response = HTTParty.post('https://accounts.spotify.com/api/token', body: {grant_type: 'client_credentials'}, headers: {Authorization: auth})

access_token = auth_response.parsed_response["access_token"]
token_type = auth_response.parsed_response["token_type"]

search_url = 'https://api.spotify.com/v1/search'
search_query = {
    'q' => 'pablo',
    'type' => 'artist,track,album,playlist'
    # 'market' =>
    # 'limit' =>
    # 'offset' =>
    # 'include_external' =>
    
}

header = {
    'Authorization' => ''+ token_type + " " + access_token
}

get_response = HTTParty.get(search_url, :query => search_query, :headers => header)

response_obj = JSON.parse(get_response.body, object_class: OpenStruct)

puts "Artists"
response_obj.artists.items.each do |artist|
    puts artist.name
end

puts "\n\n\nTracks"
response_obj.tracks.items.each do |track|
    puts track.name
end

puts "\n\n\nAlbums"
response_obj.albums.items.each do |album|
    puts album.name
end

puts "\n\n\nPlaylists"
response_obj.playlists.items.each do |playlist|
    puts playlist.name
end


