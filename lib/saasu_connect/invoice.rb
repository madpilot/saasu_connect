module SaasuConnect
  class Invoice < Base
    fields [ :uid, :integer ], [ :lastUpdatedUid, :string ], [ :transactionType, :string ], [ :date, :date ], [ :contactUid, :integer ], [ :shipToContactUid, :integer ], [ :folderUid, :integer ], [ :tags, :string ], [ :reference, :string ], [ :summary, :string ], [ :notes, :string ], [ :requiresFollowUp, :boolean ], [ :dueOrExpiryDate, :date ], [ :layout, :string ], [ :status, :string ], [ :invoiceNumber, :string ], [ :purchaseOrderNumber, :string ], [ :invoiceItems, :array ], [ :quickPayment, :quick_payment ], [ :payments, :payment_list ], [ :isSent, :boolean ]
    attributes [ :emailToContact, :boolean ]
    
    include Writable
  end
end
