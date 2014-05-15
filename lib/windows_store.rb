require "windows_store/version"
require "windows_store/push_notification"
require 'rest_client'
require 'xmldsig'
require 'json'

module WindowsStore

  # SECRET = 'KABs25LN%2FbQ6ZOPKAHTAmACnNnhxEso2'
  # APP_ID = 'ms-app://s-1-15-2-2687536063-3587835031-342050253-1892685130-1179825253-3067520980-1590187497'

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
