module SaasuConnect
  class Tasks < Base
    def self.run(options = {}, &block)
      doc = XML::Document.new
      doc.root = @task = XML::Node.new('tasks')
      yield(self)
      self.post(doc.to_s, options)
    end

    def self.add_task(obj)
      @task << obj.to_xml
    end
  end
end
