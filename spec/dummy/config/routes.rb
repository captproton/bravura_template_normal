# spec/dummy/config/routes.rb
Rails.application.routes.draw do
  mount BravuraTemplateNormal::Engine => "/bravura_template_normal"
end
