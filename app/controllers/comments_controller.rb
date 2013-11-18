require 'connector/connector'
require 'sse/sse'

class CommentsController < ApplicationController
	  include ActionController::Live

  def index
		@comments = Comment.order('id desc').limit(5).all.reverse
  end

  def create

  	Connector.get_instance.send params[:content]
  	redirect_to comments_path
  end

  def send_message

  end
end