require "windows_store/version"
require 'rest_client'
require 'xmldsig'

module WindowsStore

  def self.verify!(reciept)
    reciept     = reciept.gsub(/^\s+/, '').gsub(/\s+$/, '').gsub(/\n/, '')
    signed_doc  = Xmldsig::SignedDocument.new(reciept)
    cert_id     = signed_doc.document.css('Receipt').first['CertificateId']
    response    = RestClient.get "https://lic.apps.microsoft.com/licensing/certificateserver/?cid=#{cert_id}"
    certificate = OpenSSL::X509::Certificate.new(response)
    
    signed_doc.validate(certificate)
  end

end
