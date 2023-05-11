class MessagingComponent < ViewComponent::Base
  attr_reader :flash

  def initialize(flash: nil)
    @flash = flash || {}
  end
end
