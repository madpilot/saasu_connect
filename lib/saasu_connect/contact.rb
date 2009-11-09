module SaasuConnect
  class Contact < Base 
    fields [ :uid, :integer ], [ :lastUpdatedUid, :string ], [ :salutation, :string ], [ :givenName, :string ], [ :middleInitials, :string ], [ :familyName, :string ], [ :organisationName, :string ], [ :organisationAbn, :string ], [ :organisationWebsite, :string ], [ :organisationPosition, :string ], [ :contactID, :string ], [ :websiteUrl, :string ], [ :email, :string ], [ :homePhone, :string ], [ :mainPhone, :string ], [ :fax, :string ], [ :mobilePhone, :string ], [ :otherPhone, :string ], [ :tags, :string ], [ :postalAddress, :string ], [ :otherAddress, :string ], [ :isActive, :boolean ], [ :acceptDirectDeposit, :boolean ], [ :directDepositAccountName, :string ], [ :directDepositBsb, :string ], [ :directDepositAccountNumber, :string ], [ :acceptCheque, :string ], [ :chequePayableTo, :string ], [ :customField1, :string ], [ :customField2, :string ], [ :twitterID, :string ], [ :skypeID, :string ]
    include Writable
  end
end
