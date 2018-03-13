From: agustin.benito@codethink.co.uk (=?ISO-8859-1?Q?Agust=EDn?= Benito Bethencourt)
Date: Tue, 13 Mar 2018 15:58:45 +0100
Subject: [cip-dev] Progress on the CIP kernel maintenance and testing for
	your ELC talk
Message-ID: <52450414.TvpEuUOuAV@linux-if6s>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Yoshi,

since you usually provide an update of the technical work done within CIP in 
your talks, here are some bullet points you can add in tomorrow's talk at ELC 
if you like.

## Kernel maintenance

* CIP 4.4.120-cip20 released last week.

Link: https://gitlab.com/cip-project/linux-cip

Comment: Ben Hutchings, from Codethink, releases a kernel version every 4 to 6 
weeks approx., depending on the amount and relevance of upstream patches 
landing on 4.4 LTS. Ben H. collaborates in the 4.4 LTS process directly.

* Effort in ensuring Meltdown and Spectre fixes land in the CIP kernel and CIP 
Members are informed about the current situation.

* Review of platform specific backported patches, specially from Renesas 
platforms.

Comment: Renesas backports patches to 4.4 from mainline that are reviewed and 
merged into CIP kernel when appropriate.

* CIP 4.4.120-cip120-rt13 released

Link: git://git.kernel.org/pub/scm/linux/kernel/git/wagi/linux-cip-rt.git

Comment: I would name Daniel Wagner, Siemens, as maintainer and say a few 
words about the release process if you have time.

## Kernel testing

* B at D is being updated to include the latest kernelci

Link: https://gitlab.com/cip-project/cip-testing/board-at-desk-single-dev/
merge_requests/53

* Work in progress to support Renesas iw20gm in B at D in the coming weeks. 

Link: https://gitlab.com/cip-project/cip-testing/testing/issues/167

* Improvements in networking and Vagrant configurations.

* Next steps: deployment through containers.

* B at D description and deploy.

Description: https://wiki.linuxfoundation.org/civilinfrastructureplatform/
ciptestingboardatdesksingledevfeaturepage

Deploy: https://wiki.linuxfoundation.org/civilinfrastructureplatform/
ciptestingboardatdeskdingledevdeployment#b-d-deployment-method-2-building-vm-
from-scratch-using-vagrant-15

Any additional feedback from participants on this list is welcome.

Best Regards
-- 
Agust?n Benito Bethencourt
Principal Consultant
Codethink Ltd
