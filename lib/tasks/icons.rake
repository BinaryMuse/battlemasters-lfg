# encoding: utf-8

require 'net/http'
require 'uri'
require 'json'

def download_icon(name, path)
  jpg_file_name = name + '.jpg'
  png_file_name = name + '.png'
  jpg_file_path = path.join(jpg_file_name)
  png_file_path = path.join(png_file_name)
  http_path = "http://us.media.blizzard.com/wow/icons/18/#{jpg_file_name}"

  system "curl #{http_path} > #{jpg_file_path}"
  system "convert #{jpg_file_path} #{png_file_path}"
  system "rm #{jpg_file_path}"
end

namespace :icons do
  desc "Download the spec icons"
  task :specs => :environment do
    downloaded_specs = []
    dir = Rails.root.join("app", "assets", "images", "blizzard-icons")
    system "mkdir -p #{dir}"

    Wow::SPECS.each do |klass, specs|
      specs.each do |name, icon|
        download_icon icon, dir
        downloaded_specs << "#{klass}-#{name}"
      end
    end

    puts "Downloaded #{downloaded_specs.uniq.count} spec icons"
  end
end
