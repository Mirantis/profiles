##2015-05-14 - Release 0.1.17
###Summary

Travis CI deploy module and cicd firewall

##2015-05-13 - Release 0.1.16
###Summary

Integrate with Travis CI

####Features
- Add Travis CI integration
- Configure Rakefile for default rake tasks
- Add cicd firewall profile

##2015-05-11 - Release 0.1.12
###Summary

Add server parser options in puppet profiles

##2015-05-10 - Release 0.1.11
###Summary

Add gitlab profile

####Features
- Add profiles::gitlab

##2015-05-10 - Release 0.1.10
###Summary

Add gitlab firewall profile

####Features
- Add profile for gitlab firewall

##2015-05-07 - Release 0.1.9
###Summary

LDAP instaed of IPA

####Features
- Change IPA profiles over to ldap

##2015-05-07 - Release 0.1.7
###Summary

Add IPA master profile and firewall profile to match it

####Features
- New profiles::ipa::master profile for configuring an IPA master
- New profiles::firewall::ipa::master profile for configuring IPA server firewall

##2015-05-07 - Release 0.1.6
###Summary

Re-order firewall rules and defaults

####Features
- Reorder firewall rules
- Add SSH rule to default rules
- Add profiles::firewall::default class to just add default rules
- Use hiera_hash instead of hiera for deeper merging lookups to support application_tier based rules

##2015-05-07 - Release 0.1.5
###Summary

Fix many bugs relating to typos and dependency problems

####Bugfix
- Fix ordering issues with firewall profiles
- Fix syntax errors

##2015-05-07 - Release 0.1.4
###Summary

This release adds firewall profiles for foreman and puppet as well as default firewall rules

####Features
- Add profile classes for managing firewall:
  - `profiles::firewall::puppet` for puppetmasters
  - `profiles::firewall::foreman` for foreman servers
  - `profiles::firewall::pre` for default first rules
  - `profiles::firewall::post` for default last rules

##2015-05-06 - Release 0.1.3
###Summary

This release adds a redis profile

####Features
- Add redis profile

##2015-05-05 - Release 0.1.2
###Summary

This release provides policy-based autosigning for Puppet

####Features
- Add template for autosign policy and csr_attributes.yaml
- Add files to puppet profiles to use autosign and csr templates

##2015-05-04 - Release 0.1.1
###Summary

This release updates the puppet profiles to include support for a ca_ttl and ca_autosign feature

####Features
-Update profiles::puppet::ca to include ca_ttl setting and autosign_file and autosign_mode setting

##2015-04-13 - Release 0.1.0
###Summary

This is the inital release of the profiles module and contains profile classes. Profile classes configure pieces of technology. i.e. apache, mysql, puppet, user account setup, etc

####Features
- Initial profile classes
  - `profiles::common::packages`
  - `profiles::common::sudo`
  - `profiles::common::users`
  - `profiles::common::users::install`
  - `profiles::common::users::shells`
  - `profiles::common::yum`
  - `profiles::hiera`
  - `profiles::install`
  - `profiles::foreman::server`
  - `profiles::foreman::proxy`
  - `profiles::puppet::master`
  - `profiles::puppet::server`
  - `profiles::puppet::db`
  - `profiles::puppet::agent`
