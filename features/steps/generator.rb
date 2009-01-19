Given /^a Cocoa app that does not have an existing Rakefile$/ do
  Given "a safe folder"
  setup_active_project_folder "myapp"
end

Given /^a Cocoa app that does have an existing Rakefile$/ do
  Given "a Cocoa app that does not have an existing Rakefile"
  in_project_folder do
    File.open("Rakefile", "w") do |f|
      f << <<-RUBY.gsub(/^      /, '')
      require "rubygems"
      require "rake"
      RUBY
    end
  end
end

Given /Rakefile wired to use development code instead of installed RubyGem/ do
  in_project_folder do
    force_local_lib_override
  end
end

Given /Rakefile constants rewired for local rsync/ do
end

Given /^a Cocoa app with sparkle_tools installed$/ do
  Given "a Cocoa app that does not have an existing Rakefile"
  Given "I run local executable 'install_sparkle_tools' with arguments '.'"
  Given "Rakefile wired to use development code instead of installed RubyGem"
  @remote_folder = File.expand_path(File.join(@tmp_root, 'website'))
  FileUtils.rm_rf   @remote_folder
  FileUtils.mkdir_p @remote_folder
  Given "Rakefile constants rewired for local rsync"
end