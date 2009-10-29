module SaasuConnect
  class Task < Base
    def self.run(options = {}, &block)
      doc = XML::Document.new
      doc.root = @task = XML::Node.new('task')
      yield(self)
      self.class.post(doc.to_s, options)
    end

    def self.add_task(obj)
      @task << obj.build_xml
    end
  end
end
