module SaasuConnect
  class QuickPayment < Base
    fields [ :datePaid, :date ], [ :dateCleared, :date ], [ :bankedToAccountUid, :integer ], [ :amount, :float ], [ :reference, :string ], [ :summary, :string ]
    include Writable
  end
end
