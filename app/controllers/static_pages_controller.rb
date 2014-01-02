class StaticPagesController < ApplicationController
	def dashboard
		@request = Request.new
	end

	def results
	end

	def configuration
	end
end