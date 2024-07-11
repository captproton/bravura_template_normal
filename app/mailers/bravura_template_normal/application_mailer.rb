# frozen_string_literal: true

module BravuraTemplateNormal
  # Base mailer class for the BravuraTemplateNormal application.
  # Sets default from address and layout for emails.
  class ApplicationMailer < ActionMailer::Base
    default from: 'from@example.com'
    layout 'mailer'
  end
end
