class sshd_crypto (
  Boolean $manage_sshd_crypto  = $sshd_crypto::params::manage_sshd_crypto,
  String $crypto_policy        = $sshd_crypto::params::crypto_policy
) inherits sshd_crypto::params
{
  if $manage_sshd_crypto {
    service { 'sshd' :
      ensure     => 'running',
      enable     => true,
    }
    file { 'etc/crypto-policies/back-ends/opensshserver.config':
      ensure    => file,
      content  => "CRYPTO_POLICY='$crypto_policy'",
      notify    => Service['sshd']
    }
    
  }
}
