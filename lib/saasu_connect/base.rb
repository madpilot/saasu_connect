module SaasuConnect
  class Base < Rest
    def self.fields(*args)
      @fields ||= []
      
      args.each do |a|
        @fields << a
        attr_accessor a
      end
      
      @fields
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
