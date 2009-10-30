$:.unshift File.join(File.dirname(__FILE__))

require 'saasu_connect/rest'
require 'saasu_connect/writable'
require 'saasu_connect/base'
require 'saasu_connect/tasks'
require 'saasu_connect/invoice'
require 'saasu_connect/service_invoice_item'

module SaasuConnect
  VERSION = '1.0.0'
end
