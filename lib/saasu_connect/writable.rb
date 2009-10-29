module SaasuConnect
  module Writable
    def create!(options = {})
      Task.run options do |task|
        task.add_task(self)
      end
    end

    def update!(options = {})
      Task.run options do |task|
        task.add_task(self)
      end
    end

    def delete!(uid, options = {})
      delete({ :uid => uid }.merge(options))
    end
  
    def build_xml(&block)
      klass = self.class.to_s.split('::').last
      if self.uid
        action = XML::Node.new("update#{klass}")
        action << parent = XML::Node.new(SaasuConnect::Rest.underscore(klass))
        parent['uid'] = uid.to_s
        parent['lastUpdatedUid'] = lastUpdatedUid.to_s
      else
        action = XML::Node.new("insert#{klass}")
        action << parent = XML::Node.new(SaasuConnect::Rest.underscore(klass))
        parent['uid'] = '0'
      end

      if block_given?
        yield(parent)
      else
        self.class.fields.each do |v|
          if v != :uid && v != :lastUpdatedUid
            p = send(v)
            p = p.strftime('%Y-%m-%d') if p.is_a?(Date)
            parent << XML::Node.new(v.to_s, p.to_s)
          end
        end
      end
      action
    end
  end
end
