
	
require 'socket'
require 'json'
 
host = 'localhost'     # The web server
port = 2000                           # Default HTTP port

puts "Which type of request you want to send? (GET or POST)"
user_request = gets.chomp.upcase

case user_request 
	when "GET"
		path = "./index.html"                 # The file we want 
		request = "GET #{path} HTTP/1.0\r\n\r\n"
	when "POST"
		path = "./thanks.html"   
		puts "Please enter the following info for register:\n"
		puts "Name: "
		name = gets.chomp
		puts "Email: "
		email = gets.chomp
		body = {:viking => {:name=> name, :email=> email} }.to_json
		request = "POST #{path} HTTP/1.0 Content-Type: text/json Content-Length: #{body.size} #{body}"
	else
		puts "Sorry that is not an option"
end

socket = TCPSocket.open(host,port)  # Connect to server
socket.puts(request)               # Send request

response = socket.read

puts response
socket.close


