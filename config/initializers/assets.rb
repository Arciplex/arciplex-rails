["jquery.fullpage.css"].each do |file|
    Rails.application.config.assets.precompile += [file]
end
