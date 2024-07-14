# frozen_string_literal: true

# spec/support/dummy_models.rb

module BravuraTemplateNormal
  class Account < ApplicationRecord
    self.table_name = 'accounts'
    has_one :settings_general, class_name: 'BravuraTemplateNormal::Settings::General', dependent: :destroy
  end

  module Settings
    class General < ApplicationRecord
      self.table_name = 'settings_generals'
      belongs_to :account, class_name: 'BravuraTemplateNormal::Account'
      has_one_attached :favicon
    end
  end
end
