require 'jumpstart_auth'

class MicroBlogger
  attr_reader :client

  def initialize
    puts "Initializing..."
    @client = JumpstartAuth.twitter
  end

  def dm(target, message)
    puts "Trying to send #{target} this direct message:"
    puts message
  end

  def tweet(message)
    if message.length <= 140
      @client.update(message)
    else
      puts 'Warning: Will not post, Status is over 140 characters'
    end
  end

  def run
    command = ""
    while command != "q"
      puts ""
      printf "enter command: "
      input = gets.chomp
      parts = input.split
      command = parts[0]
      case command
        when 'q' then puts "Goodbye!"
        when 't' then tweet(parts[1..-1].join(" "))
        else
          puts "Sorry, I don't know how to (#{command})"
        end
    end
  end
end

blogger = MicroBlogger.new
blogger.run
