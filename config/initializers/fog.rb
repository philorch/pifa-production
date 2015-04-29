CarrierWave.configure do |config| 
	config.fog_credentials = { 
		:provider               => 'AWS', 
		:aws_access_key_id      => 'AKIAJGYMGQO62EWOISQA', 
		:aws_secret_access_key  => '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', 
	} 
	config.fog_directory  = 'pifa-2013-dev' 
	config.fog_public     = false 
end 