module SleepServices
  class Wake < BaseService
    delegate :record, to: :context
    
    def call
      if record.sleeping?
        record.wake!
      else
        context.fail!(error: "User still awake")
      end
    end
  end
end