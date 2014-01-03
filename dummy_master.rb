require "socket"
require "thread"

file = "/tmp/test.sock"

# File.delete(file) if file.exist?

File.unlink(file) if File.exists?(file) && File.socket?(file)

begin
	serv = UNIXServer.new(file)
	puts "=> Ctrl-C to shutdown server"
	puts "=> Listening on #{serv.path}"
	s = serv.accept
	puts "Connected to #{s.peeraddr}"
rescue Interrupt
	print "\nShutting down..."
	serv.shutdown
	puts "OK"
	exit
end


Thread.new do
	prng = Random.new
	loop do
		seconds = prng.rand(5)
		puts "sleeping #{seconds} seconds"
		sleep seconds
		msg = "#{Time.now}: Blaa Nachricht"
		puts msg
		s.print msg + "\n"
		s.flush
	end
end

loop do
	begin
		s.each_line do |line|
			puts line
		end
	rescue Interrupt
		print "\nShutting down..."
		s.shutdown
		serv.shutdown
		puts "OK"
		exit
	ensure
		# s.shutdown if s != nil
		# serv.shutdown if serv != nil
	end
end
