module SaasuConnect
  class PostalAddress < Base
    fields [ :street, :string ], [ :city, :string ], [ :postCode, :string ] , [ :state, :string ], [ :country, :string ]
    include Writable
  end
end
