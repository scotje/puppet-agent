component "facter" do |pkg, settings, platform|
  pkg.load_from_json('configs/components/facter.json')

  pkg.build_requires 'ruby'

  if platform.is_rpm?
    # In our rpm packages, facter has an epoch set, so we need to account for that here
    pkg.replaces 'facter', '1:2.4.2'
    pkg.provides 'facter', '1:2.4.2'
  else
    pkg.replaces 'facter', '2.4.2'
    pkg.provides 'facter', '2.4.2'
  end

  pkg.install do
    ["#{settings[:bindir]}/ruby install.rb --sitelibdir=#{settings[:ruby_vendordir]} --quick --man --mandir=#{settings[:mandir]}"]
  end

  pkg.link "#{settings[:bindir]}/facter", "#{settings[:link_bindir]}/facter"
end
