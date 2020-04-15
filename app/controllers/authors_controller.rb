class AuthorsController < ApplicationController
  include HttpAuthConcern

  # GET /authors
  # GET /authors.json
  def index
    @authors = Author.all
  end

end
