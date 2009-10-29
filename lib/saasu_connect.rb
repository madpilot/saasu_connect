$:.unshift File.join(File.dirname(__FILE__))

require 'saasu_connect/rest'
require 'saasu_connect/base'
require 'saasu_connect/invoice'

module SaasuConnect
  VERSION = '1.0.0'
end
