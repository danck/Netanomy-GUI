# require 'connector/sender'
# require 'connector/receiver'

# Interface for the connection to the 'Master' program
class Connector #< ActionController::Base
  	include ActionController::Live
  	# include Singleton
	
	@@only_instance = nil

	def Connector.get_instance
		if (@@only_instance == nil) then
			@@only_instance = Connector.new
		end
		return @@only_instance
	end

	def send msg
		# @@sender.send msg
		@s.print msg + "\n"
		@s.flush
	end

	def get_info_stream
		return @info_out
	end

	private

		def initialize
			puts "Hi, this is Connector startup"

			# The socket that talks to master man
			@s = UNIXSocket.new("/tmp/test.sock")

			# The pair of pipes to pass the INFO messages
			@info_out, @info_in = IO.pipe

			puts "Socket: #{@s.peeraddr}"

			# Dispatcher of messages sent by the master
			@receiver = Thread.new {
					puts "Receiver thread spawned"
					loop do
						begin @s.each_line do |line|
								puts "Ich bekam: #{line}"
								@info_in << line
							end
						rescue Interrupt, IOException, IOError
							puts "FATAL: lost connection to master"
						ensure
							# s.shutdown if s != nil
							# serv.shutdown if serv != nil
						end
					end
			}
		end
end