require "httparty"
require "dotenv/load"

class ReadwiseCleaner
  BASE_URL = "https://readwise.io/api/v2"

  def initialize
    @token = ENV["READWISE_TOKEN"]
    raise "READWISE_TOKEN environment variable is not set" unless @token

    @headers = {
      "Authorization" => "Token #{@token}",
      "Content-Type" => "application/json",
    }
  end

  def fetch_all_highlights
    highlights = []
    page_count = 0
    page = 1

    loop do
      page_count += 1
      puts "Fetching page #{page_count} of highlights..."

      url = "#{BASE_URL}/highlights?page=#{page}&page_size=1000"

      response = HTTParty.get(url, headers: @headers)

      if response.code != 200
        puts "Error fetching highlights: #{response.code} - #{response.body}"
        break
      end

      data = response.parsed_response
      new_highlights = data["results"]

      if new_highlights.empty?
        puts "No more highlights found."
        break
      end

      highlights.concat(new_highlights)
      puts "Retrieved #{new_highlights.length} highlights (total so far: #{highlights.length})"

      if data["next"]
        page += 1
      else
        break
      end

      # Add a small delay to avoid rate limiting
      sleep(0.5)
    end

    puts "Finished fetching all #{highlights.length} highlights"
    highlights
  end

  def delete_highlight(highlight_id)
    response = HTTParty.delete(
      "#{BASE_URL}/highlights/#{highlight_id}",
      headers: @headers,
    )

    if response.code == 204
      puts "Successfully deleted highlight #{highlight_id}"
    else
      puts "Error deleting highlight #{highlight_id}: #{response.code} - #{response.body}"
    end

    # Add a small delay to avoid rate limiting
    sleep(0.5)
  end

  def delete_all_highlights
    highlights = fetch_all_highlights
    total = highlights.length
    puts "\nFound #{total} highlights to delete"

    highlights.each_with_index do |highlight, index|
      puts "\nDeleting highlight #{index + 1}/#{total}"
      delete_highlight(highlight["id"])
    end

    puts "\nFinished deleting all highlights"
  end
end
