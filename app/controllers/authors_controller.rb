class AuthorsController < ApplicationController

  # GET /authors
  # GET /authors.json
  def index
    @authors = Author.all
  end

end
