require 'test_helper'

class TestInvoice < Test::Unit::TestCase
  include TestHelper
  
  def test_contact_find

  end

  def test_contact_insert
    contact = SaasuConnect::Contact.new
    contact.salutation = 'Mr.'
    contact.given_name = 'John'
    contact.family_name = 'Smith'
    contact.organisation_name = 'Saasy.tv'
    contact.organisation_abn = '777888999'
    contact.organisation_position = 'Director'
    contact.email = 'john.smith@saasy.tv'
    contact.main_phone = '02 9999 9999'
    contact.mobile_phone = '0444 444 444'
    contact.contactID = 'XYZ123'
    contact.tags = 'Gold Prospect, Film'
    contact.postal_address = SaasuConnect::PostalAddress.new(:street => '3/33 Victory Av', :city => 'North Sydney', :state => 'NSW', :country => 'Australia')
    contact.other_address = SaasuConnect::OtherAddress.new(:street => '111 Elizabeth street', :city => 'Sydney', :state => 'NSW', :country => 'Australia')
    contact.is_active = true
    contact.accept_direct_deposit = false
    contact.direct_deposit_account_name = 'John Smith'
    contact.direct_deposit_bsb = '000000'
    contact.direct_deposit_account_number = '12345678'
    contact.accept_cheque = false
    contact.custom_field_1 = "This is custom field 1"
    contact.custom_field_2 = "This is custom field 2"
    contact.twitterID = "Contact twitter id"
    contact.skypeID = "Contact skype id"

    SaasuConnect::Tasks.expects(:post).with(load_xml_mock('create_contact'), {})
    contact.create!
  end

  def test_contact_update
    contact = SaasuConnect::Contact.new
    contact.uid = 22730
    contact.last_updated_uid = "AAAAAAAVA8A="
    contact.salutation = "Mrs."
    contact.given_name = "Mary"
    contact.family_name = "Smith"
    contact.organisation_name = "Mr. & Mrs. Smith"
    contact.organisation_abn = "67 093 453 886"
    contact.organisation_website = ""
    contact.organisation_position = "Director"
    contact.email = "mary.smith@mrandmrssmith.com.au"
    contact.main_phone = "02 4444 4444"
    contact.home_phone = ""
    contact.mobile_phone = "0444 444 444"
    contact.tags = "Customer, IT"
    contact.postal_address = ""
    contact.other_address = ""
    contact.is_active = true
  end

  def test_contact_delete
    contact = SaasuConnect::Contact.new(:uid => 12345)
    endpoint = SaasuConnect::Contact.send(:endpoint, :uid => 12345)
    SaasuConnect::Contact.expects(:http_delete).with(endpoint)
    contact.delete!
  end
end
