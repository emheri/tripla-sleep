class BaseService
  attr_accessor :context

  def self.call(*args)
    new(*args).tap(&:run).context
  end

  def initialize(context = {})
    self.context = Context.new(context)
  end

  def call; end

  def run
    context.result = call
    context
  end

  class Context < OpenStruct
    attr_accessor :result

    def failure?
      @failure || false
    end

    def success?
      !failure?
    end

    def fail!(attributes = {})
      attributes.each { |k, v| self[k.to_sym] = v }
      @failure = true
    end

    def exception
      StandardError.new(error)
    end
  end
end