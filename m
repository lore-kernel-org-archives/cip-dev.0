From: robert.marshall@codethink.co.uk (Robert Marshall)
Date: Fri, 30 Jun 2017 09:13:07 +0100
Subject: [cip-dev] B@D on Windows 10
Message-ID: <878tk97v1o.fsf@ctlt579.codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

The B at D development team has been investigating if there are any issues
with the use of the B at D VM on Windows. The ticket
https://gitlab.com/cip-project/cip-testing/testing/issues/106
is being used to collect information and workarounds.

Briefly the current issues/state is as follows:

- We are using virtualbox rather than rsync for config.vm.synced_folder
- core.autocrlf=input is needed in the git settings for the scripts to
  run under Debian (and an ssh client either via git or another route)
- We need to look at a substitute for ser2net running on the host in
  order to open a connection from the VM to the BBB
- The VM installs and both the KernelCI webserver and Lava2 run
- Having built a kernel the build does not appear in the KernelCI web
  interface, there's a long delay before it times out
- Health checks can be created but they don't appear to run, the admin
  interface knows about the devices but they don't appear in
  Scheduler->All Devices

This testing has been carried out directly from the pure Vagrant install
- once this is running the pre-loaded Vagrant box will also be tested.

Further work is continuing to get B at D fully operational on a Windows 10 host.

Robert
