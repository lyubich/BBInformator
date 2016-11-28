
class DefaultStrategy
  def self.default_strategy(apiai_data)
    apiai_data[:fulfillment][:speech]
  end
end