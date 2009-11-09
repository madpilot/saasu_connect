module SaasuConnect
  class OtherAddress < Base
    fields [ :street, :string ], [ :city, :string ], [ :postCode, :string ] , [ :state, :string ], [ :country, :string ]
    include Writable
  end
end
