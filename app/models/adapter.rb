class Adapter < ApplicationRecord
  before_update :convert_to_json

  protected
  def convert_to_json
    self.data = JSON.parse(self.data)
  end
end
