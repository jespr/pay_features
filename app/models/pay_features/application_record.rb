# frozen_string_literal: true

module PayFeatures
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
  end
end
