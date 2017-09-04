From: agustin.benito@codethink.co.uk (Agustin Benito Bethencourt)
Date: Mon, 4 Sep 2017 10:39:34 +0100
Subject: [cip-dev] CIP testing and kernel maintenance report week 34 and 35
Message-ID: <59AD1F56.1090407@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

a couple of weeks with some tangible results.

++ Kernel maintenance

* Renesas latest patch series review
    * In progress
* Kernel features analysis.
    * Ongoing discussion with several CIP Members through the cip-dev 
mailing list
* How to back-port upstream BSP patches to CIP kernel
    * Support provided through cip-dev mailing list. Ongoing.
* New version of CIP Linux kernel published
    * Linux 4.4.83-cip8
* ELCE: Talk about kernel maintenance approved.
    * Check 
https://osseu17.sched.com/event/ByYa/maintaining-a-linux-kernel-for-13-years-you-must-be-kidding-me-we-need-at-least-30-agustin-benito-bethencourt-ben-hutchings-codethink-ltd

++ CIP testing project

* LAVA has been updated to 2017.7 version which will allow us to close a 
couple of issues that appeared in older versions and has been fixed in 
newer ones. #114 
https://gitlab.com/cip-project/cip-testing/testing/issues/114
    * MR under review and initramfs issues created.
    * One of the issues that the new LAVA version fixes in this one, 
notified by us several weeks ago #84 
https://gitlab.com/cip-project/cip-testing/testing/issues/84
    * Status report sent a few days ago to the cip-dev mailing list
* Modifying the script to populate initramfs now that LAVA has been 
updated. #111 https://gitlab.com/cip-project/cip-testing/testing/issues/111
    * Script is under review.
* Using the verbose mode in LAVA reports to provide more detailed info 
#115 https://gitlab.com/cip-project/cip-testing/testing/issues/115
    * In progress.
* Bug. kernelci build of cip8 runs out of disk space #130 
https://gitlab.com/cip-project/cip-testing/testing/issues/130
    * Fixed
* B at D works behind a web proxy so #99 and #128 has been closed
    * Error in kernelci with csrf token #128 
https://gitlab.com/cip-project/cip-testing/testing/issues/128 closed
    * Issues with installing when running behind a web proxy #99 
https://gitlab.com/cip-project/cip-testing/testing/issues/99 closed
* As part of our contribution upstream, we keep notifying Linaro 
developers issues with the licenses files they are fixing diligently.
* B at D introduced at the AGL CIAT Meeting  #132 
https://gitlab.com/cip-project/cip-testing/testing/issues/132
    * Discussed at the CIP testing tech meeting last Thursday
    * Slides published on the wiki.
    * Report sent to cip-dev mailing list
* New B at D release schedule #134 
https://gitlab.com/cip-project/cip-testing/testing/issues/134
    * In progress

++ Other tasks

* B at D 101 training session at CIP workshop during ELCE #126 
https://gitlab.com/cip-project/cip-testing/testing/issues/126
    * Preparation in progress
* Y2038 related meeting and CIP Kernel maintainers meeting at ELCE
    * Preparation in progress
* CIP testing project journal started (experiment). Check 
https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptesting/journal


Best Regards

-- 
Agustin Benito Bethencourt
Principal Consultant - FOSS at Codethink
agustin.benito at codethink.co.uk
