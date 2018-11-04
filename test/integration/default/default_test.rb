# # encoding: utf-8

# Inspec test for recipe ssm-agent::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

unless os.windows?
  describe command('ps -aef | grep ss[m]') do
    its('stdout') { should match ('/usr/bin/amazon-ssm-agent') }
  end
end
