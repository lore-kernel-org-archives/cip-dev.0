From: agustin.benito@codethink.co.uk (Agustin Benito Bethencourt)
Date: Wed, 18 Oct 2017 14:24:43 +0200
Subject: [cip-dev] New CIP releases: CIP kernel 4.4.92-cip11 and B@D v1.0
Message-ID: <59E7480B.50405@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Dear CIP friends,

CIP is happy to announce the release of a new CIP kernel (v4.4.92-cip11) 
together with a new version of the testing environment B at D v1.0

++ CIP kernel v4.4.92-cip11

The Civil Infrastructure Platform project[1], a Linux Foundation 
Initiative, is happy to announce the publication of a new version of the 
CIP Kernel, based on 4.4 LTS, labelled as v4.4.92-cip11.

Ben Hutchings, the CIP kernel maintainer, has merged changes from the 
stable 4.4.y branch up to v4.4.92. He has also added a few further fixes 
and tagged the result as v4.4.92-cip11[2].

The main changes since the last announced update are:

  * Many fixes from 4.4.y, including security fixes for:
   CVE-2017-9984 CVE-2017-9985 CVE-2017-11600 CVE-2017-12134
   CVE-2017-12153 CVE-2017-12154 CVE-2017-12192 CVE-2017-14051
   CVE-2017-14106 CVE-2017-14140 CVE-2017-14156 CVE-2017-14340
   CVE-2017-14489 CVE-2017-14991 CVE-2017-15537 CVE-2017-1000251
   CVE-2017-1000252
  * Fixes for some regressions Ben Hutchings found when reviewing the 
above changes.
  * Support for the Renesas RZ/G1M SoC and the iWave RZG1M Qseven SOM
  * Support for the Siemens IOT2040 board
  * Support for EFI capsules, including the variant used for the Intel 
Quark SoC

[1] https://www.cip-project.org/
[2] https://gitlab.com/cip-project/linux-cip

++ Board At Desk (B at D) v1.0

The Civil Infrastructure Platform project[1], a Linux Foundation 
Initiative, is happy to announce the publication of a new version of 
Board At Desk v1.0, a customised and easy to deploy instance of the 
kernelci.org[2] and LAVA[3] projects that should allow developers to 
test Linux kernels on boards connected to their own development machines 
using the tooling provided by one of the most successful Open Source 
testing projects.

Board at Desk (B at D) v1.0 is provided in two forms:
   * As a vagrant VM recipe.
   * As a VM image, widely called a "B at D box".

Please visit the CIP Testing project Download page[4] to download the 
latest Board At Desk (B at D v1.0).

Some of the most important new features shipped[5] with this B at D v1.0 are:
   * LAVA has been updated to 2017.7 version which will allow in the 
future significant improvements in the reporting area, among others.
   * B at D now works on Windows 10 as Host OS which increases the number 
of potential users, including engineers from several CIP Members..
   * B at D now works behind a webproxy which is a common use case among 
CIP Members.
   * initramfs is now built locally, increasing reliability and opening 
the door to use B at D in the future to test the CIP core system, not just 
the CIP Kernel.

In addition to the above, other features has been added and several bugs 
has been fixed, making Board at Desk more robust and reliable than 
before. Further information about this new Board At Desk (B at D v1.0) 
version can be found at the B at D Feature Page[5].

With this release, the CIP Testing Project covers a key milestone which 
is releasing a working testing tool to be used locally by kernel 
developers from any CIP Member. In the current strategy, the following 
key milestone refers to setting up the conditions and technical measures 
that would allow all those developers to share and analyse the test 
results at any point in time within a fully distributed environment. 
This version of B at D includes some initial steps towards achieving that goal.

Find more information about B at D v1.0 reading the web release 
announcement: 
https://www.cip-project.org/blog/2017/10/18/cip-launches-bd-v1-0

If you are interested in testing kernels using Board at Desk, meet the 
developers at the cip-dev mailing list[6]. If you find bugs in KernelCI 
or LAVAv2 themselves, please report them upstream. If you find them in 
the configuration or any of the previously described features, please 
report them in the CIP-testing bug tracker[7]. More general information 
about the CIP testing project can be found in the CIP wiki[8].

[1] https://www.cip-project.org/
[2] https://kernelci.org/
[3] https://validation.linaro.org/
[4] https://wiki.linuxfoundation.org/civilinfrastructureplatform/cipdownload
[5] 
https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptestingboardatdesksingledevfeaturepage 

[6] https://lists.cip-project.org/mailman/listinfo/cip-dev
[7] https://gitlab.com/cip-project/cip-testing/testing/boards
[8] https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptesting

Best Regards
-- 
Agustin Benito Bethencourt
Principal Consultant - FOSS at Codethink
agustin.benito at codethink.co.uk
