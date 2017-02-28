require 'socket'
require 'json'               # Get sockets from stdlib

server = TCPServer.open(2000)  # Socket to listen on port 2000
puts "Listening on port 2000"
loop {                         # Servers run forever
  client = server.accept       # Wait for a client to connect
  request = client.gets.split(" ")
  request_method = request[0]
  request_path = request[1]
  case request_method 
  	when "GET"
		  path = request_path
			body = ""
				if File.exist?(path)
					body = File.read(path)
					status_code = 200
					reason_phrase = "OK"
				else
					status_code = 404
					phrase = "Not Found"
				end

				client.puts	"HTTP/1.0 #{status_code} #{phrase}"
				client.puts(Time.now.ctime)
				client.puts	"Content-Length: #{body.size}"
				client.puts
				client.puts	"#{body}"
		when "POST"
			body = request.last
			params = JSON.parse(body)
			file_template = File.read("thanks.html")
			page_content = "<li>Name: #{params["viking"]["name"]}</li><li>Email: #{params["viking"]["email"]}</li>"
			thanks_page = file_template.gsub("<%= yield %>", page_content)
			client.puts thanks_page
		end

	client.close

}

