# frozen_string_literal: true

Rails.application.routes.draw do
  mount PayFeatures::Engine => '/pay_features'
end
