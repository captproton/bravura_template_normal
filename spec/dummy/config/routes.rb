# frozen_string_literal: true

Rails.application.routes.draw do
  mount BravuraTemplateNormal::Engine => '/bravura_template_normal'
end
