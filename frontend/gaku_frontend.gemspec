# encoding: UTF-8
version = File.read(File.expand_path("../../VERSION", __FILE__)).strip

Gem::Specification.new do |s|
  s.platform     = Gem::Platform::RUBY
  s.name         = 'gaku_frontend'
  s.version      = version
  s.summary      = 'GAKU Engine is a student/assignment focused student and school management system'
  s.description  = "It allows for full student management, grading etc. It's basically what all student grading tools are with some unique features"
  s.required_ruby_version = '~> 2.0.0'

  s.authors      = ['Rei Kagetsuki', 'Nakaya Yukiharu', 'Vassil Kalkov', 'Georgi Tapalilov']
  s.email        = 'info@genshin.org'
  s.homepage     = 'http://github.com/Genshin/gaku'

  s.files        = Dir['LICENSE', 'README.md', 'app/**/*', 'config/**/*', 'lib/**/*', 'db/**/*', 'vendor/**/*']
  s.test_files   = `git ls-files -- {spec}/*`.split("\n")
  s.require_path = 'lib'

  s.requirements << 'postgresql'
  s.requirements << 'postgresql-contrib'

  s.add_dependency 'rails',                          '~> 4.0.0'
  s.add_dependency 'rails-i18n',                     '~> 4.0.0'
  s.add_dependency 'coffee-rails',                   '~> 4.0.0'
  s.add_dependency 'sass-rails',                     '~> 4.0.0'
  s.add_dependency 'uglifier',                       '>= 1.3'
  s.add_dependency 'turbolinks',                     '~> 1.3'

  s.add_dependency 'pg',                             '0.16'

  s.add_dependency 'gaku_core', version

  s.add_dependency 'slim',                           '~> 2.0'
  s.add_dependency 'responders',                     '~> 1.0'
  s.add_dependency 'paper_trail',                    '3.0.0.beta1'
  s.add_dependency 'globalize',                      '~> 4.0.0.alpha.1'
  s.add_dependency 'draper',                         '~> 1.0'
  s.add_dependency 'paperclip',                      '~> 3.5'
  s.add_dependency 'ransack',                        '~> 1.0'
  s.add_dependency 'kaminari',                       '~> 0.14'

  s.add_dependency 'devise',                         '~> 3.0.0'
  s.add_dependency 'devise-i18n',                    '~> 0.9'
  s.add_dependency 'cancan',                         '~> 1.6.10'

  s.add_dependency 'rails4_client_side_validations', '0.0.3'

  s.add_dependency 'phantom_helpers',                '0.11.0.alpha4'
  s.add_dependency 'phantom_forms',                  '0.2.0.alpha4'
  s.add_dependency 'phantom_nested_forms',           '0.2.0.alpha4'

  s.add_dependency 'nested_form'

  s.add_dependency 'jquery-rails',                   '~> 3'
  s.add_dependency 'jquery-ui-rails',                '~> 4'
  s.add_dependency 'jquery-minicolors-rails',        '2.1.1'
  s.add_dependency 'bootstrap-sass',                 '~> 3.0.2.1'
  s.add_dependency 'font-awesome-sass',              '~> 4.0.2'
  s.add_dependency 'bootstrap-datepicker-rails',     '~> 1.1'
  s.add_dependency 'nprogress-rails'
  s.add_dependency 'underscore-rails',               '~> 1.5'
  s.add_dependency 'momentjs-rails',                 '~> 2.2'

  s.add_dependency 'thinreports-rails',              '~> 0.1'
  s.add_dependency 'localeapp'
  s.add_dependency 'highline',                       '1.6.11'
  s.add_dependency 'rubyzip',                        '0.9.9'
  s.add_dependency 'ffaker',                         '~> 1.19.0'
  s.add_dependency 'rake-progressbar'




  s.add_development_dependency 'rspec-rails',              '~> 2.14'
  s.add_development_dependency 'factory_girl_rails',       '~> 4.2.1'
  s.add_development_dependency 'capybara',                 '~> 2.1'
  s.add_development_dependency 'database_cleaner',         '~> 1.1.1'
  s.add_development_dependency 'selenium-webdriver'
  s.add_development_dependency 'poltergeist'
  s.add_development_dependency 'launchy'
  s.add_development_dependency 'handy_controller_helpers', '0.0.3'
  s.add_development_dependency 'shoulda-matchers',         '~> 2.4.0'
end