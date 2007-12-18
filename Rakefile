require 'rubygems'
require 'hoe'
require './lib/super_rewards.rb'

Hoe.new('SuperRewards', SuperRewards::VERSION) do |p|
  p.rubyforge_name = 'superrewards'
  p.author = 'Shane Vitarana'
  p.email = 'shanev@gmail.com'
  p.summary = 'A Ruby client for the Super Rewards web service'
  p.description = 'A Ruby client for the Super Rewards web service'
  p.url = 'http://shanesbrain.net'
  p.changes = p.paragraphs_of('History.txt', 0..1).join("\n\n")
  p.remote_rdoc_dir = ''
end

desc 'Tag release'
task :tag do
  svn_root = 'svn+ssh://drummr77@rubyforge.org/var/svn/superrewards'
  sh %(svn cp #{svn_root}/trunk #{svn_root}/tags/release-#{SuperRewards::VERSION} -m "Tag SuperRewards release #{SuperRewards::VERSION}")
end