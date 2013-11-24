require 'connector/connector'

class RealtimeController < ApplicationController

	include ActionController::Live

	def connect
		# sse = Connector.get_instance.get_stream
	end
	def master_messages
 		response.headers['Content-Type'] = 'text/event-stream'
		stream = Connector.get_instance.get_info_stream

		begin
		loop do
			stream.each_line do |line| 
				response.stream.write("event: INFO\n")
				data = line
				puts "##### Publishing: #{data}"
				response.stream.write("data: #{data}\n\n")
			end
			sleep 1
		end
		rescue IOError
			puts "########### IOERROR"
		ensure
			response.stream.close
		end
	end

	# before_action :setup_stream

	# def comments
	# 	begin
	# 	# 	@redis.subscribe('new comment') do |on|
	# 	# 		on.message do |event, data|
	# 	# 			@stream.write(JSON.parse(data).to_json, event: :new)
	# 	# 		end
	# 	# 	end
	# 	# ensure
	# 	# 	@stream.close
	# 	redirect_to comments_path
	# 	end
	# end

	# private

	# 	def setup_stream
	# 		# response.headers['Content-Type'] = 'text/event-stream'
	# 		# @redis	= Redis.new
	# 		# @stream = Sse::Writer.new(response.stream)
	# 	end

end