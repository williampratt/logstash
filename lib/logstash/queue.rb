require "logstash/namespace"
require "logstash/logging"

if RUBY_PLATFORM == "java" && ENV["QUEUE"] != "Sized"
  java_import java.util.concurrent.LinkedTransferQueue

  $stderr.puts "Using LinkedTransferQueue"
  class LogStash::Queue < LinkedTransferQueue
    alias_method :<<, :transfer
    alias_method :push, :transfer
    alias_method :pop, :take
  end
else
  require "thread" # for SizedQueue
  $stderr.puts "Using SizedQueue"
  class LogStash::Queue < SizedQueue
    def initialize
      super(20)
    end
  end
end
