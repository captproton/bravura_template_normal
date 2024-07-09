# frozen_string_literal: true

module BravuraTemplateNormal
  # Base class for all models in the BravuraTemplateNormal application.
  # Establishes connection with the database using ActiveRecord.
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
  end
end
