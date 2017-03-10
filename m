From: agustin.benito@codethink.co.uk (Agustin Benito Bethencourt)
Date: Fri, 10 Mar 2017 16:16:38 +0100
Subject: [cip-dev] Update 2017wk10
Message-ID: <58C2C356.8060301@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Dear CIP friends,

here is the report of those tasks related with Testing and kernel 
maintenance that Don, Ben, Robert and myself has been working on the 
past two weeks:

CIP Testing

* Investigation is ongoing on issue #16
* Continued work on Issue #30 the ArduinoPDU to control the Soft Reset 
and the Power On/Off commands to the Beaglebone Black (BBB).
** We are able to command it using the low level relay-ctrl.py command, 
but the pduclient command is still not working. I've reached out for 
help on the linaro-lava IRC channel with no success.

* Investigated Issue #31 incorporating QEMU/KVM as a second hypervisor. 
I want to avoid having to support two versions, so it will be a 
side-by-side "option."

* Started Issue #22 adding the required build tools for different 
architectures: The goal is to include tools for: armel, armhf, arm64, 
and i386 & amd64 at some point.

* Investigated "weird mixture of Debian versions" Issue #33  and from 
this work, we will solidify the base from which future version will be 
created.

* Determined to distribute the CIP-Board-at-Desk VM to anyone who cannot 
build the VM from Vagrant due to software versioning issues in Issue #34 .

* Closed several issues as they were solved:
** #35 Consolidate all the instructions on the wiki
** #29 Beaglebone Black's Debian doesn't give standard Shutdown Message
** #32 Could not access KVM kernel module
** #21 qemu01 health check fails

* Space requested to deploy the VMs for the release.
** LF is working on it
** Size reduced from +4GB to aroind 2GB using different techniques.
** Still unknown how we will deploy it.

* Tested the health check on the beaglebone black

* Created a export of the virtual machine and am currently   debugging 
issues around the re-import on other user machines

* Support Ben H. with several issue he has found with Board at desk - 
Single dev since he is trying to set it up in his machine to test the 
CIP 4.4 kernel.
** The current setup depends on the Vagrant version that each distro 
provides for certain configurations.
** Reported some issues with the build process.
** Identified and reported changes needed to allow running the box under 
older version of Vagrant for, in this case, Debian Stable.

* Created new milestones for the project.
** Link: https://gitlab.com/cip-project/testing/milestones
** Processed the requests we've got after the Beta release and moved 
them to the right milestone.

CIP kernel maintenance

* Going through several questions raised by Members after ELC
* Reviewed changes in Linux 4.4.49-4.4.52 stable releases
* Question to Members about 4.4 features to include in CIP in cip-dev 
ML. Please take it in consideration.

Remember you can:
* Download the beta version of Board at Desk - Single dev VM at the CIP 
testing Download page: 
https://wiki.linuxfoundation.org/civilinfrastructureplatform/cipdownload
* All issues/tickets referred in this report can be found in our 
gitlab.com testing project: https://gitlab.com/cip-project/testing/boards

Codethink has published a blog post related with CIP: 
https://www.codethink.co.uk/blog/articles/2017/why-codethink-founding-member-civil-infrastructure-platform/

Best Regards

-- 
Agustin Benito Bethencourt
Principal Consultant - FOSS at Codethink
agustin.benito at codethink.co.uk
