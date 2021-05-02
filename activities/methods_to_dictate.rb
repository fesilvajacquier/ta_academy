## CONTEXT ##
# The context may not be mentioned to peers

# No context needed

def block_splitter(array)
  first_half = array.select { |element| yield(element) == true }
  second_half = array.reject { |element| yield(element) == true }
  [first_half, second_half]
end

################################################################################

## CONTEXT ##
# The context may not be mentioned to peers

# `db` is an instance of `SQLite3::Database`
# `genre_name` is an instance of `String`

def top_five_artists(db, genre_name)
  db.execute("SELECT artists.name, COUNT (artists.name) as c
  FROM artists
  JOIN albums ON albums.artist_id = artists.id
  JOIN tracks ON tracks.album_id = albums.id
  JOIN genres ON tracks.genre_id = genres.id
  WHERE genres.name = '#{genre_name}'
  GROUP BY artists.name
  ORDER BY c
  DESC LIMIT 5")
end

################################################################################

## CONTEXT ##
# The context may not be mentioned to peers

# No context needed

require 'open-uri'
require 'nokogiri'

class Browser
  def fetch_content(url)
    html_file = open(url).read
    html_doc = Nokogiri::HTML(html_file)
    html_doc.at('body').content
  end
end

################################################################################

## CONTEXT ##
# The context may not be mentioned to peers

# Ignore the commented lines

def analyze(text)
  {
    character_count: text.size,
    character_count_excluding_spaces: text.count("^\s"),
    line_count: text.lines.count,
    word_count: text.scan(/\b(\w+)\b/),
    # sentence_count: text.scan(/[^\.!?]+[\.!?]/).size,
    # paragraph_count: ,
    # average_words_per_sentence: ,
    # average_sentences_per_paragraph:
  }
end

################################################################################

## CONTEXT ##
# The context is not memayt tooned to peers directly

# This method belongs to the `BaseRepository` class
# `build_element` is defined by the `BaseRepository` subclasses
# `@elements` is an array

def load_csv
  CSV.foreach(@file_path, headers: :first, header_converters: :symbol) do |row|
    row[:id] = row[:id].to_i
    @elements << build_element(row)
  end
  @next_id = @elements.empty? ? 1 : @elements.last.id + 1
end

################################################################################

def save
  if @id
    DB.execute("UPDATE posts SET url = ?, votes = ?, title = ? WHERE id = ?", @url, @votes, @title, @id)
  else
    DB.execute("INSERT INTO posts (url, votes, title) VALUES (?, ?, ?)", @url, @votes, @title)
    @id = DB.last_insert_row_id
  end
end

################################################################################

def better_refrain(lyrics, options = { vibrato: 0, number_of_times: 1, strong: false })
  song_refrain = []
  lyrics += lyrics[lyrics.size - 1] * options[:vibrato]
  lyrics.upcase! if options[:strong]

  options[:number_of_times].times do
    song_refrain << lyrics
  end

  song_refrain.join(" ")
end

################################################################################

def most_common_words(file_name, stop_words_file_name, number_of_word)
  src_str = ""
  File.open(file_name, "r").each_line { |line| src_str << clean_str(line).gsub(/\.|,|:/, "") }
  src_arr = src_str.split(" ")
  stop_arr = []
  File.open(stop_words_file_name, "r").each_line { |line| stop_arr << line.delete("\n").downcase }
  na = src_arr.reject { |w| stop_arr.include? w }
  hash_a = {}
  na.uniq.each { |char| hash_a[char] = na.count(char) }
  (hash_a.max_by(number_of_word) { |_, v| v }).to_h
end

################################################################################
