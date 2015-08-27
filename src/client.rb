require 'adapter'
require 'observable'

class Client

  include Observable

  HOSTNAME = 'localhost'
  PORT = 1337

  # @param args [Hash] user provided arguments.
  # The following hash keys can be set:
  #   :debug => selected debug mode.
  #   :game => selected game id.
  #   :multiplayer => selected multiplayer mode.
  #
  # @param hostname [String] ip address of target server.
  # @param port [Integer] port of target server.
  def initialize(args, hostname = HOSTNAME, port = PORT)
    @hostname = hostname
    @port = port
    @adapter = Adapter.new(self)
    start
  end

  private

  def start
    connection = TCPSocket.open(@hostname, @port)
    while line = connection.gets
      puts line.chop
    end
    connection.close
  end

end
