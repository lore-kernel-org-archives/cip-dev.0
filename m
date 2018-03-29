From: gitlab@mg.gitlab.com (Robert Marshall)
Date: Thu, 29 Mar 2018 14:56:22 +0000
Subject: [cip-dev]
 [Git][cip-project/cip-testing/board-at-desk-single-dev][master] 2 commits:
 Use private network for the connection to the board
Message-ID: <5abcfe96d52d2_d65f3f8db78d1970396635@sidekiq-asap-01.mail>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Robert Marshall pushed to branch master at cip-project / cip-testing / board-at-desk-single-dev


Commits:
b47a5eea by Robert Marshall at 2018-03-29T14:56:07Z
Use private network for the connection to the board

- - - - -
4ca4eaa4 by Robert Marshall at 2018-03-29T14:56:07Z
Merge branch &#39;usePrivateNetwork&#39; into &#39;master&#39;

Use private network for the connection to the board

See merge request cip-project/cip-testing/board-at-desk-single-dev!55
- - - - -


2 changed files:

- Vagrantfile
- integration-scripts/configure_lava.sh


Changes:

=====================================
Vagrantfile
=====================================
--- a/Vagrantfile
+++ b/Vagrantfile
@@ -1,5 +1,5 @@
 # Copyright (C) 2016-2017, Siemens AG, Wolfgang Mauerer <wolfgang.mauerer@siemens.com>
-# Copyright (C) 2016-2017, Codethink, Ltd., Robert Marshall <robert.marshall@codethink.co.uk>
+# Copyright (C) 2016-2018, Codethink, Ltd., Robert Marshall <robert.marshall@codethink.co.uk>
 # SPDX-License-Identifier:	AGPL-3.0
 # This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, version 3.
 
@@ -47,7 +47,9 @@ Vagrant.configure(2) do |config|
   config.vm.network :forwarded_port, guest: 443, host: 4443
   # Configure network accessibility for tftp server
   config.vm.network "public_network", use_dhcp_assigned_default_route: true
-
+  # route for connections to the board - change this if you're using that address!
+  config.vm.network "private_network", ip: "192.168.22.10", netmask:"24"
+  
   config.vm.provision "shell" do |s|
     s.privileged = false
     s.inline = $build


=====================================
integration-scripts/configure_lava.sh
=====================================
--- a/integration-scripts/configure_lava.sh
+++ b/integration-scripts/configure_lava.sh
@@ -1,4 +1,5 @@
 #! /bin/sh
+# Copyright (C) 2018, Codethink, Ltd., Robert Marshall <robert.marshall@codethink.co.uk>
 # Copyright (C) 2017, Codethink, Ltd., Don Brown <codethink@codethink.co.uk>
 # SPDX-License-Identifier:	AGPL-3.0
 # This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, version 3.
@@ -43,7 +44,7 @@ sudo DEBIAN_FRONTEND=noninteractive lava-server manage devices add --device-type
 cd ~
 echo "{% extends 'beaglebone-black.jinja2' %}" > mybbb.dat
 #echo "{% set connection_command = 'telnet localhost 8020' %}" >> mybbb.dat
-echo "{% set connection_command = '/vagrant/scripts/connectBBB.sh localhost 8020 root lavauser123' %}"  >> mybbb.dat
+echo "{% set connection_command = '/vagrant/scripts/connectBBB.sh 192.168.22.1 8020 root lavauser123' %}"  >> mybbb.dat
 
 # Import the Beaglebone Black Device Dictionary file into the LAVA2 Server
 # needs authentication token setting up



View it on GitLab: https://gitlab.com/cip-project/cip-testing/board-at-desk-single-dev/compare/1002fb7a6e3b63983f3e315030809fa54fc6c019...4ca4eaa4a004fc10aa046bf150a1940cb26fb77f

---
View it on GitLab: https://gitlab.com/cip-project/cip-testing/board-at-desk-single-dev/compare/1002fb7a6e3b63983f3e315030809fa54fc6c019...4ca4eaa4a004fc10aa046bf150a1940cb26fb77f
You're receiving this email because of your account on gitlab.com.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20180329/c4ee88c4/attachment-0001.html>
