class User < ApplicationRecord
  before_update :convert_to_json

  protected
  def convert_to_json
    self.profile = JSON.parse(profile) if profile.is_a?(String)
  end
end
