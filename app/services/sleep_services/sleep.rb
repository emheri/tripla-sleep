module SleepServices
  class Sleep < BaseService
    delegate :record, to: :context
    
    def call
      if record.awake?
        record.sleep!
      else
        context.fail!(error: "User still sleeping")
      end
    end
  end
end