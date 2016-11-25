class User < ApplicationRecord
  before_update :convert_to_json

  protected
  def convert_to_json
    self.profile = JSON.parse(self.profile)
  end
end
