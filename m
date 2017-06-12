From: robert.marshall@codethink.co.uk (Robert Marshall)
Date: Mon, 12 Jun 2017 11:34:22 +0100
Subject: [cip-dev] The Beaglebone black health check supplied in b@d 0.9.1
	will no longer run
Message-ID: <877f0hbikx.fsf@ctlt579.codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

The 0.9.1 release of b at d contains a health check for the beaglebone
black which uses various build artifacts on the linaro website at:

http://snapshots.linaro.org/components/lava/standard/debian/jessie/armhf/4

this directory has been moved and the files are now at

http://snapshots.linaro.org/components/lava/standard/debian/jessie/armhf/1

If you have the Vagrant install you will need to change the suggested
test at tests/bbb_debian_ramdisk_test.yaml to reflect the new location
and edit the BBB health check if you have already installed that.

    https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptestingboardatdesksingledevsetup#configure-the-lava-health-check-jobs-for-both-devices

bbb_debian_local.yaml makes one reference to the linaro location which
will also need changing if you use that file in association with
lava-tool.

    https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptestingreferencetestcases#test-5use-lava-tool-utility

The issue https://gitlab.com/cip-project/cip-testing/testing/issues/103
has been created to track this issue.

We intend to update the git repository and release a new provisioned box
later this week to resolve this issue.

Robert
