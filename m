From: agustin.benito@codethink.co.uk (=?ISO-8859-1?Q?Agust=EDn?= Benito Bethencourt)
Date: Tue, 03 Apr 2018 11:39:51 +0200
Subject: [cip-dev] Codethink: complete report weeks 11 to 13
Message-ID: <1759977.bORSjIyXzy@linux-if6s>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

now the complete report.

## CIP kernel maintenance

* Participation at the 4.4-stable process.
** Patch review.

* Reviewed more patches from Renesas

* Discussed TFTP boot problems on the iWave board with Robert and Zoran

* Kernel configurations sent by Moxa to be reviewed.

## CIP kernel testing

* CIP 4.4.120-cip20 tested with B at D
** Build/boot reports sent to cip-testing-results
** Reports now include the kernel version.

* B at D Support for Renesas board
** Remote PDU controlled (#166). Timeout issues under investigation (#167) 
*** Link: https://gitlab.com/cip-project/cip-testing/testing/issues/166
*** Link: https://gitlab.com/cip-project/cip-testing/testing/issues/167

* Improvements in the network configuration of B at D to ease the usage.  
** Link: https://gitlab.com/cip-project/cip-testing/testing/issues/159

* B at D now includes a new version of kernelci #139
** Link: https://gitlab.com/cip-project/cip-testing/testing/issues/139

* Robert provisions B at D box every couple of weeks. This tasks needs to be 
automated in gitlab.
** Link: https://gitlab.com/cip-project/cip-testing/testing/issues/149

* Documentation improvements
** Documenting the improvements on the wiki is in progress: #177
*** Link: https://gitlab.com/cip-project/cip-testing/testing/issues/177
** Improvements in the documentation to configure reports through mails.

Once B at D supports Renesas board, we will look into moving B at D from VMs to 
containers, if kernelci container is already available.

## Other topics

* Meeting between Moxa and Codethink. The goal was to put Moxa up to speed and 
find a place for them to start.
** Recommendation of kernel activities were sent prior to the event to SZLin.
** Decision: have a sync meeting about kernel technical activities every week 
through IRC.
** Based on the outcome executed by Moxa, it seems the meeting was useful.

* In order to share the journal at least with Moxa, the wiki page was moved: 
#179
** Link: https://gitlab.com/cip-project/cip-testing/testing/issues/179

* Content about kernel maintenance and testing sent to Yoshi to be included in 
the ELC talk.

* Paper to talk about CIP kernel maintenance presented to OSSJ. Maintainers 
involved.

* CIP Spotlight: Codethink article finished, reviewed, published and promoted.

Best Regards
-- 
Agust?n Benito Bethencourt
Principal Consultant
Codethink Ltd
