require File.join(Rails.root, "lib/concerns/response_template.rb")

lib_api_dir_path = Rails.root.join("lib", "concerns", "response_template").to_s

Dir["#{lib_api_dir_path}/*.rb"].each {|file| require file }
