require 'net/http'

class GifSearchController < ApplicationController
  before_action :authorized, except: [:search]

  # @route     GET /gifSearch
  # @desc      Register new user
  # @access    Public
  # @params    searchTerm
  def search
    return render json: {data: []} if params[:searchTerm].blank?
    
    url = URI.parse(ENV["GIPHY_SEARCH_URL"].to_s + "&q=" + params[:searchTerm])
    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }

    gifList = []
    JSON.parse(res.body)["data"].each do |result|
      gifUrl = result["images"]["original"]["url"]
      puts gifUrl
      gifList.push(gifUrl)
    end

    render json: { data: gifList }
  end

end
