require 'socket'

class Server
  PORT = 1337

  def initialize(port=PORT)
    @port = port
    puts "starting server listening on port #{@port}."
    start
  end

  private

  def start
    @server = TCPServer.open(@port)
    loop do
      Thread.start(@server.accept) do |client|
        client.puts(Time.now.ctime)
        # subscribe client to game list
        # wait until two players have connected
        client.puts "Clossing connection"
        client.close
      end
    end
  end

end