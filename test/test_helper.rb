require 'rubygems'
require 'test/unit'
require 'mocha'
require 'lib/saasu_connect'

module TestHelper
  def load_xml_mock(name)
    File.open(File.join(File.dirname(__FILE__), 'xml_mock', "#{name}.xml")) do |fh|
      return fh.read
    end
  end
end
