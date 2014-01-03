require 'connector/connector'

class RealtimeController < ApplicationController

	include ActionController::Live

	def connect
		# sse = Connector.get_instance.get_stream
	end

	def master_messages
		@out_stream, @in_stream = IO.pipe


 		response.headers['Content-Type'] = 'text/event-stream'
		Connector.get_instance.register(self)

		while true do
			begin
			@out_stream.each_line do |line| 
				response.stream.write("event: INFO\n")
				data = line
				puts "##### Publishing: #{data}"
				response.stream.write("data: #{data}\n\n")
			end
			rescue => ex
				Connector.get_instance.unregister self
				puts "########### IOERROR"
				break;

			# ensure
			# 	puts "########### IOERROR 2.0"
			# 	response.body = []
			# 	# response.stream.close
			# 	# @@running = false
			end
		end

		render :nothing => true
	end

	def run_test
		sender = Connector.get_instance
		sender.send "#{params[:request][:plugin]} #{params[:request][:domain]}"
		redirect_to root_path
	end

	# Callback fuer Connector
	def feed msg
		if @in_stream
			@in_stream << msg
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