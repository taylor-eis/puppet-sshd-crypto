class sshd_crypto (
  Boolean $manage_sshd_crypto  = $sshd_crypto::params::manage_sshd_crypto
  String $crypto_policy        = $sshd_crypto::params::crypto_policy
) inherits $sshd_crypto::params
{
  if $manage_sshd_crypto {
    file { 'etc/crypto-policies/back-ends/opensshserver.config':
      ensure => file,
      contents => "CRYPTO_POLICY='$crypto_policy'"
    }
  }
}
