require "windows_store/version"
require "windows_store/push_notification"
require 'rest_client'
require 'xmldsig'
require 'json'

module WindowsStore

  def self.verify!(reciept, secret, app_id)
    reciept     = reciept.gsub(/^\s+/, '').gsub(/\s+$/, '').gsub(/\n/, '')
    signed_doc  = Xmldsig::SignedDocument.new(reciept)
    cert_id     = signed_doc.document.css('Receipt').first['CertificateId']
    begin
      response    = RestClient.get "https://lic.apps.microsoft.com/licensing/certificateserver/?cid=#{cert_id}"
    rescue => e
      raise StandardError
    end
    certificate = OpenSSL::X509::Certificate.new(response)
    
    signed_doc.validate(certificate)
  end

end
