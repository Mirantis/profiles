# profiles

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with profiles](#setup)
4. [Limitations - OS compatibility, etc.](#limitations)

## Overview

This is a special module for defining profiles.  Profiles define a particular piece
of technology by passing parameters into component modules.  The profile is where
org-specific data lookups (via hiera) are done.  This information is then passed into
component modules as parameterized classes.

## Module Description
This module contains public subclasses that are profile classes.  For each piece of
technology that you want to configure, you would have a profile class for it.  A good
way to think of it is a real world example.  Raise your hand if you've said to a 
co-worker, "Hey, you know that box with apache, mysql, redis, and memcache on it?". I
didn't think so.  What you have said is, "Hey, you know the frontpage app cluster?"

In this case, you would have a single role defining what the system is in a friendly
way: roles::frontpage::app or something.  Then the app you referred to there would
have a profile associated with it: profiles::frontpage::app.  This profile would
configure all of the pieces necessary to make that app work, such as mysql, redis,
apache, etc.  It would do any org-specific data lookups (passwords, ip addresses, etc)
 and then pass that information to component modules for each bit of tech configured
 for that app.  You would call a mysql module, then maybe call a defined type to setup
   a  database and then populate it with data.  You'd do the same stuff with apache,
   redis and whatever else was part of that app.

   You would probably have other profiles that would be included in the
role such as user management, common packages, etc.  Those aren't part of the app in
question so they'd all be under different profiles.

## Setup

Since your configuration is almost certainly going to need to change at some point,
clone this repo into your own new project somewhere (github, gitlab, etc) and then
modify it as needed.  Add it to your Puppetfile if you're sane and using R10k or
otherwise move it into your modules directory.


## Limitations

This is a special profile module and has no special limitations. Each class will
be different and compatibility is largely dependent on the component modules called.
