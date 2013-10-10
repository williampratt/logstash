require "logstash/codecs/base"

class LogStash::Codecs::Rate < LogStash::Codecs::Base
  config_name "rate"
  milestone 1

  public
  def initialize(params={})
    super
    @counter = 0
    @last = Time.now
  end

  public
  def decode(data)
    raise "Not implemented"
  end # def decode

  public
  def encode(data)
    @counter += 1
    t = Time.now
    duration = t - @last
    if duration > 2
      @on_event.call( (@counter / duration).to_s + "\n")
      @counter = 0
      @last = Time.now
    end
  end # def encode

end # class LogStash::Codecs::Dots
