From: robert.marshall@codethink.co.uk (Robert Marshall)
Date: Fri, 18 Aug 2017 11:37:30 +0100
Subject: [cip-dev] LAVA upgrade to 2017
Message-ID: <87k22188lx.fsf@ctlt579.codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi

Progress has been made on the upgrade of B at D to use LAVA 2017-7 (#114) -
once this is complete, issues #84 and #115 will also be resolved.

I have a https://gitlab.com/rajm/board-at-desk-single-dev/tree/lava2017-fixes
branch with my fixes for this upgrade. With these changes the beaglebone
black health check runs but fails at the reboot point - complaining that
soft reboot isn't defined. In my work-in-progress b at d virtual machine
the QEMU health check runs ok but in a fresh install it complains about
a missing arch parameter.

Work is continuing on resolving these two issues at which point a merge
request will be created.

Robert
