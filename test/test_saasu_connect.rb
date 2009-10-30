require 'rubygems'
require 'test/unit'
require 'mocha'
require 'lib/saasu_connect'

class TestSaasuConnect < Test::Unit::TestCase
  def test_endpoint
    SaasuConnect::Base.access_key = 'test-888-888'
    SaasuConnect::Base.file_uid = '888888'
    #assert_equal "https://secure.saasu.com/webservices/rest/r1/invoice?wsaccesskey=test-888-888&fileuid=888888", SaasuConnect::Invoice.send('endpoint')
    SaasuConnect::Base.mode = :test
    #assert_equal "https://secure.saasu.com/sandbox/webservices/rest/r1/invoice?wsaccesskey=test-888-888&fileuid=888888", SaasuConnect::Invoice.send('endpoint')
  end

  def test_proxy_methods
    SaasuConnect::Rest.expects(:get).returns(load_xml_mock('invoice_s'))
    invoice = SaasuConnect::Invoice.find(:TransactionType => 's')
    assert_equal 1952687, invoice.uid
    assert_equal 'AAAAAAF8O28=', invoice.last_updated_uid
    assert_equal 'S', invoice.transaction_type
    assert_equal Date.parse('2009-09-30'), invoice.date
    assert_equal 216883, invoice.contact_uid
    assert_equal 2493, invoice.folder_uid
    assert_equal 'MadPilot Productions', invoice.tags
    assert_equal false, invoice.requires_follow_up
    assert_equal Date.parse('2009-10-14'), invoice.due_or_expiry_date
    assert_equal 'S', invoice.layout
    assert_equal 'I', invoice.status
    assert_equal '951', invoice.invoice_number
    assert_equal false, invoice.is_sent

    invoice = SaasuConnect::Invoice.new
    invoice.uid = 1952687
    invoice.last_updated_uid = 'AAAAAAF8O28='
    invoice.transaction_type = 'S'
    invoice.date = Date.parse('2009-09-30')
    invoice.contact_uid = 216883
    invoice.folder_uid = 2493
    invoice.tags = 'MadPilot Productions'
    invoice.requires_follow_up = false
    invoice.due_or_expiry_date = Date.parse('2009-10-14')
    invoice.layout = 'S'
    invoice.status = 'I'
    invoice.invoice_number = '951'
    invoice.is_sent = false
    
    assert_equal 1952687, invoice.uid
    assert_equal 'AAAAAAF8O28=', invoice.lastUpdatedUid
    assert_equal 'S', invoice.transactionType
    assert_equal Date.parse('2009-09-30'), invoice.date
    assert_equal 216883, invoice.contactUid
    assert_equal 2493, invoice.folderUid
    assert_equal 'MadPilot Productions', invoice.tags
    assert_equal false, invoice.requiresFollowUp
    assert_equal Date.parse('2009-10-14'), invoice.dueOrExpiryDate
    assert_equal 'S', invoice.layout
    assert_equal 'I', invoice.status
    assert_equal '951', invoice.invoiceNumber
    assert_equal false, invoice.isSent
  end

  def test_invoice_find
    SaasuConnect::Rest.expects(:get).returns(load_xml_mock('invoice_s'))
    invoice = SaasuConnect::Invoice.find(:TransactionType => 's')
    assert_equal 1952687, invoice.uid
    assert_equal 'AAAAAAF8O28=', invoice.lastUpdatedUid
    assert_equal 'S', invoice.transactionType
    assert_equal Date.parse('2009-09-30'), invoice.date
    assert_equal 216883, invoice.contactUid
    assert_equal 2493, invoice.folderUid
    assert_equal 'MadPilot Productions', invoice.tags
    assert_equal false, invoice.requiresFollowUp
    assert_equal Date.parse('2009-10-14'), invoice.dueOrExpiryDate
    assert_equal 'S', invoice.layout
    assert_equal 'I', invoice.status
    assert_equal '951', invoice.invoiceNumber
    assert_equal false, invoice.isSent
  end

  def test_invoice_create
    invoice = SaasuConnect::Invoice.new()
    invoice.transaction_type = 'S'
    invoice.date = Date.parse('2005-09-30')
    invoice.contact_uid = 22735
    invoice.folder_uid = 0
    invoice.summary = "Test POST sale"
    invoice.notes = "From REST"
    invoice.requires_follow_up = false
    invoice.due_or_expiry_date = Date.parse('2005-12-01')
    invoice.layout = 'S'
    invoice.status = 'I'
    invoice.invoice_number = "<Auto Number>"
    invoice.purchase_order_number = "PO222"
    invoice.invoice_items << SaasuConnect::ServiceInvoiceItem.new(:description => 'Design and Development of REST WS', :account_uid => 10555, :tax_code => 'G1', :total_amount_incl_tax => 2132.51)
    invoice.invoice_items << SaasuConnect::ServiceInvoiceItem.new(:description => 'Subscription to XYZ', :account_uid => 10557, :tax_code => 'G1', :total_amount_incl_tax => 11.22)

    SaasuConnect::Tasks.expects(:post).with(load_xml_mock('create_invoice'), {})
    invoice.create!
  end

  def load_xml_mock(name)
    File.open(File.join(File.dirname(__FILE__), 'xml_mock', "#{name}.xml")) do |fh|
      return fh.read
    end
  end
end
