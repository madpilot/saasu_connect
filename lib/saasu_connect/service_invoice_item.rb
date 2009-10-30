module SaasuConnect
  class ServiceInvoiceItem < Base
    fields [ :description, :string ], [ :accountUid, :integer ], [ :taxCode, :string ], [ :totalAmountInclTax, :float ]
    include Writable
  end
end
