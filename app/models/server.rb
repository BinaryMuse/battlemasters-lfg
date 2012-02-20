class Server < ActiveRecord::Base
  attr_accessible :kind, :name, :slug, :battlegroup
end
