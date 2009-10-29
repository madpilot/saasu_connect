module SaasuConnect
  class InvoiceList < Rest
    def invoices
      @invoices
    end

    def create!
      raise NotImplementedError
    end

    def update!
      raise NotImplementedError
    end

    def delete!
      raise NotImplementedError
    end
  end
end
