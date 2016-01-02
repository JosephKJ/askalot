Askalot::Application.routes.draw do
  mount University::Engine => Rails.application.config.relative_url_root || '/', as: 'university' if Rails.module == 'university'
  mount Mooc::Engine => Rails.application.config.relative_url_root || '/', as: 'mooc' if Rails.module == 'mooc'
  mount Shared::Engine => Rails.application.config.relative_url_root || '/', as: 'shared'
end
