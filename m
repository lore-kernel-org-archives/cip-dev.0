From: agustin.benito@codethink.co.uk (Agustin Benito Bethencourt)
Date: Thu, 22 Sep 2016 14:56:12 +0200
Subject: [cip-dev] Maintenance policies and early considerations III
Message-ID: <57E3D4EC.2080008@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

the below considerations were discussed during the Members meeting. 
There is no conclusion yet about how to proceed.

++ Security fixes

+++ Out-of-tree drivers

The embedded systems that CIP will be used in will also often require 
out-of-tree drivers and will sometimes include other changes of unknown 
quality to their kernel.  It needs to be made clear to members that 
these modifications are unsupported, and that when they want the CIP 
core team to address a bug found in such a modified kernel they must 
first demonstrate that it exists in the CIP source release.

+++ Security updates

Commercial Linux based distributions like RHEL/SLE typically has 
security updates available for the most serious issues (such as 
privilege escalation) within a few days of them being publicly known, if 
not on the first day.

CIP may be able to achieve this with its source releases but its members 
may take much longer to release and deploy binary updates, maybe due to 
valid concerns about the risk of regression or limited opportunities to 
deploy updates.   In the worst case, they may use CIP as an 
advertising/compliance point but rarely bother to update.  For this 
reason Ben H. thinks it's important to draw on the work of the Kernel 
Self-Protection Project to add mitigations against common types of 
vulnerability.  That work is slowly filtering into mainline and at least 
some of it could be backported.

+++ Request to members from maintainer

During the meeting Ben requested CIP members to provide him some 
guidelines or policies currently followed to choose security patches. 
This information will hopefully provide some light that help maintainers 
to define some basic policies for choosing security fixes. This policies 
need to be tested over time.

Due to the length of the maintenance period, it is unlikely that the 
same person/team maintain the kernel for the entire life cycle so the 
main policies at least need to be left written.

Best Regards
-- 
Agustin Benito Bethencourt
Principal Consultant - FOSS at Codethink
agustin.benito at codethink.co.uk
