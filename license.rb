require 'openssl'
require 'gitlab/license'

name    = "My Name"
company = "My Org"
email   = "mymail@example.com"

if ARGV.length == 3
    name    = "#{ARGV[0]}"
    company = "#{ARGV[1]}"
    email   = "#{ARGV[2]}"
end

private_key = OpenSSL::PKey::RSA.generate(2048)
public_key  = private_key.public_key

File.open("license_key", "w") { |f| f.write(private_key.to_pem) }
File.open("license_key.pub", "w") { |f| f.write(public_key.to_pem) }

Gitlab::License.encryption_key = private_key

license = Gitlab::License.new
license.licensee = {
    "Name"      => name,
    "Company"   => company,
    "Email"     => email
}

license.starts_at = Date.new(2024, 1, 1)

license.expires_at       = Date.new(2050, 1, 1)
license.notify_admins_at = Date.new(2050, 1, 1)
license.notify_users_at  = Date.new(2050, 1, 1)
license.block_changes_at = Date.new(2050, 1, 1)

license.restrictions = {
    ## active_user_count: 10000
    plan: 'ultimate'
}

data = license.export
File.open("Gitlab.gitlab-license", "w") { |f| f.write(data) }
