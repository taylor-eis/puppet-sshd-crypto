class sshd_crypto (
  Boolean $manage_sshd_crypto  = $sshd_crypto::params::manage_sshd_crypto,
  Boolean $manage_sshd_moduli  = $sshd_crypto::params::manage_sshd_moduli,
  String $crypto_policy        = $sshd_crypto::params::crypto_policy,
  Integer $minimum_modulus     = $sshd_crypto::params::minimum_modulus
) inherits sshd_crypto::params
{
  if $manage_sshd_crypto {
    file { '/etc/crypto-policies/back-ends/opensshserver.config':
      ensure    => file,
      content  => "CRYPTO_POLICY='$crypto_policy'",
      notify    => Service['sshd']
    }
  }
  if $manage_sshd_moduli {
    exec { 'strong_moduli':
      command => "/bin/awk '\$5 >= $minimum_modulus' /etc/ssh/moduli > /etc/ssh/moduli.safe && mv -f /etc/ssh/moduli.safe /etc/ssh/moduli",
      unless => "/bin/awk '(\$5 < $minimum_modulus && \$1 != \"#\") {count++} END {exit count}' /etc/ssh/moduli"
    }
  }
}
