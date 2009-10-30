require 'cgi'
require 'net/https'
require 'xml'

module SaasuConnect
  class Rest
    def self.camelize(lower_case_and_underscored_word, first_letter_in_uppercase = true)
      if first_letter_in_uppercase
        lower_case_and_underscored_word.to_s.gsub(/\/(.?)/) { "::#{$1.upcase}" }.gsub(/(?:^|_)(.)/) { $1.upcase }
      else
        downcase_first(camelize(lower_case_and_underscored_word))
      end
    end

    def self.underscore(camel_cased_word)
      camel_cased_word.to_s.gsub(/::/, '/').gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').gsub(/([a-z\d])([A-Z])/,'\1_\2').tr("-", "_").downcase
    end

    def self.downcase_first(camel_cased_word)
      chars = camel_cased_word.split('')
      chars.shift.downcase + chars.join('')
    end

  protected
    def self.get(options = {})
      begin
        http_get(endpoint(options))
      rescue SocketError
        raise ConnectionException
      end
    end

    def self.post(data, options = {})
      begin
        http_post(endpoint(options), data)
      rescue SocketError
        raise ConnectionException
      end
    end

    def self.delete(options = {})
      begin
        http_delete(endpoint(options))
      rescue SocketError
        raise ConnectionException
      end
    end

    def self.parse_response(body)
      document = XML::Document.string(body)
      if SaasuConnect.const_defined?(model = camelize((root = document.child).name).gsub("Response", ""))
        klass = SaasuConnect.const_get(model) 
        obj = klass.new

        root.children.each do |child|
          child.attributes.each { |attr| obj.send("#{attr.name}=".to_sym, attr.value) }
          
          child.children.each do |inner|
            if inner.first? && inner.first.text?
              obj.send("#{inner.name}=".to_sym, inner.child.to_s)
            end
          end
        end
        return obj
      end
      nil
    end


    def self.endpoint(options = {})
      options = {
        :access_key => SaasuConnect::Base.access_key,
        :file_uid => SaasuConnect::Base.file_uid,
        :resource => self.to_s.split('::').last.downcase
      }.merge(options)

      options[:wsaccesskey] = options.delete(:access_key)
      options[:fileuid] = options.delete(:file_uid)
      
      SaasuConnect::Base.test? ? test_endpoint(options) : live_endpoint(options)
    end

    def self.live_endpoint(options)
      resource = options.delete(:resource)
      "https://secure.saasu.com/webservices/rest/r1/#{resource}?#{expand_options(options)}"
    end

    def self.test_endpoint(options)
      resource = options.delete(:resource)
      "https://secure.saasu.com/sandbox/webservices/rest/r1/#{resource}?#{expand_options(options)}"
    end

    # Does an HTTP GET on a given URL and returns the response body
    def self.http_get(url)
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      response = http.get(uri.path + "?" + uri.query)
      
      case response
      when Net::HTTPSuccess
        response.body.to_s
      else
        raise HttpException, "A error occured while trying to retrieve the resource: " + response.code + " " + response.message
      end
    end

    def self.http_post(url, data)
      uri = URI.parse(url)
      
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      response = http.request_post(uri.path + "?" + uri.query, data)

      case response
      when Net::HTTPSuccess
        response.body.to_s
      else
        raise HttpException, "A error occured while trying to retrieve the resource: " + response.code + " " + response.message
      end
    end

    def self.http_delete(url)
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      response = http.delete(uri.path + "?" + uri.query)
      response.body.to_s
    end

    def self.expand_options(options)
      params = []
      options.each do |key, value|
        params << "#{key}=#{value}"
      end
      params.join('&')
    end
  end
end
