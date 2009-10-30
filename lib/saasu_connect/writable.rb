module SaasuConnect
  module Writable
    def create!(options = {})
      Tasks.run options do |task|
        task.add_task(self)
      end
    end

    def update!(options = {})
      Tasks.run options do |task|
        task.add_task(self)
      end
    end

    def delete!(uid, options = {})
      delete({ :uid => uid }.merge(options))
    end
  
    def to_xml(&block)
      klass = self.class.to_s.split('::').last
      if uid != 0
        action = XML::Node.new("update#{klass}")
        action << parent = XML::Node.new(SaasuConnect::Rest.downcase_first(klass))
        parent['uid'] = uid.to_s
        parent['lastUpdatedUid'] = lastUpdatedUid.to_s
      else
        action = XML::Node.new("insert#{klass}")
        action << parent = XML::Node.new(SaasuConnect::Rest.downcase_first(klass))
        parent['uid'] = '0'
      end

      if block_given?
        yield(parent)
      else
        build_xml do |node|
          parent << node
        end
      end
      action
    end

    def build_xml(&block)
      self.class.fields.each do |field|
        if field[0] != :uid && field[0] != :lastUpdatedUid
                    
          value = send(field[0])
          if block_given?
            yield cast_for_xml(field[0], value)
          else
            return cast_for_xml(field[0], value)
          end
        end
      end
    end

    def cast_for_xml(field, value)
      value = value.strftime('%Y-%m-%d') if value.is_a?(Date)
     
      if value.kind_of?(SaasuConnect)
        value.build_xml
      elsif value.is_a?(Array)
        node = XML::Node.new(field.to_s)
        value.each do |element|
          klass = element.class.to_s.split('::').last
          
          node << parent = XML::Node.new(SaasuConnect::Rest.downcase_first(klass))
          element.build_xml do |n|
            parent << n
          end if SaasuConnect.const_defined?(klass)
        end
        node
      else
        XML::Node.new(field.to_s, value.to_s) unless value.nil?
      end
    end
  end
end
