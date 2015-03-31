class Client
  HOSTNAME = 'localhost'
  PORT = 1337

  def initialize(hostname = HOSTNAME, port = PORT)
    @hostname = hostname
    @port = port
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