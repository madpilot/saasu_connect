module SaasuConnect
  class Base < Rest
    def initialize(data = {})
      data.each do |key, value|
        self.send("#{key.to_s}=".to_sym, value)
      end
    end

    def self.find(uid = nil, options = {})
      self.parse_response(SaasuConnect::Rest.get({ :uid => uid }.merge(options)))
    end

    # Rubify the camelcase methods
    def method_missing(method_name, *args)
      if method_name.to_s =~ /_/
        camelized = SaasuConnect::Rest.camelize(method_name.to_s, false).to_sym
        if self.class.method_defined?(camelized)
          if method_name.to_s.split('').last == "="
            return send(camelized, args.first) 
          else
            return send(camelized) 
          end
        end
      end
      super
    end
 
    def self.fields(*args)
      @fields ||= []
      
      args.each do |a|
        @fields << a
        field_accessor a
      end
      
      @fields
    end

    def self.field_accessor(*args)
      # Create mutalators for all of the fields. This will also cast the variable if needed
      args.each do |a|
        case(a[1])
        when(:integer)
          class_eval <<-END
            def #{a[0]}
              @#{a[0]}.to_i
            end
          END
        when(:float)
          class_eval <<-END
            def #{a[0]}
              @#{a[0]}.to_f
            end
          END
        when(:date)
          class_eval <<-END
            def #{a[0]}
              return @#{a[0]} if @#{a[0]}.is_a?(Date) || @#{a[0]}.to_s == ""
              Date.parse(@#{a[0]})
            end
          END
        when(:array)
          class_eval <<-END
            def #{a[0]}
              @#{a[0]} ||= []
            end
          END
        when(:boolean)
          class_eval <<-END
            def #{a[0]}
              return @#{a[0]} == "true" if @#{a[0]}.is_a?(String)
              @#{a[0]}
            end
          END
        else
          class_eval <<-END
            def #{a[0]}
              @#{a[0]}
            end
          END
        end

        class_eval <<-END
          def #{a[0]}=(v)
            @#{a[0]} = v
          end
        END
      end
    end

    def self.mode
      @mode ||= :live
    end

    def self.mode=(mode)
      @mode = mode
    end

    def self.test?
      @mode == :test
    end

    def self.access_key
      @access_key
    end

    def self.access_key=(access_key)
      @access_key = access_key
    end

    def self.file_uid
      @file_uid
    end

    def self.file_uid=(file_uid)
      @file_uid = file_uid
    end
  end
end
