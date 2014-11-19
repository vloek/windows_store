require "windows_store/version"
require "windows_store/push_notification"

module WindowsStore

  def self.verify!(reciept, secret, app_id)
    # reciept    = reciept.gsub(/^\s+/, '').gsub(/\s+$/, '').gsub(/\n/, '')
    reciept    = reciept.strip.gsub(/\n/, '')
    signed_doc = Xmldsig::SignedDocument.new(reciept)
    cert_id    = signed_doc.document.css('Receipt').first['CertificateId']

    signed_doc.validate(
      OpenSSL::X509::Certificate.new(
        RestClient.get(
          "https://lic.apps.microsoft.com/licensing/certificateserver/?cid=#{cert_id}"
        )
      )
    )
  rescue => e
    $stderr.puts "Error #{e}"
    raise StandardError
  end

end
