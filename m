From: agustin.benito@codethink.co.uk (=?ISO-8859-1?Q?Agust=EDn?= Benito Bethencourt)
Date: Mon, 19 Feb 2018 09:53:28 +0100
Subject: [cip-dev] Codethink: report weeks 6 and 7
Message-ID: <6359446.CMKDBkSaUH@linux-if6s>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

this is a summary of the CIP related work we've done the last couple of weeks:

## Kernel maintenance

* Reviewed patches from Renesas to add support for SMP and I?C masters
on R8A7743 SoC, and applied them to the CIP kernel branch

* Reviewed Robert's merge request for B at D

* Discussed opportunities for CIP member participation at DebConf

* Reviewed the changes in stable release 4.4.113 (but didn't yet merge
them)

## CIP testing

* Went through the open tickets and sent to backlog all those that are related 
with B at D development.
** Confirmed #157 is still an issue: https://gitlab.com/cip-project/cip-testing/testing/issues/157
** Unable to replicate #170 so far: https://gitlab.com/cip-project/cip-testing/testing/issues/170

* Working on #173 opened by Zoran: https://gitlab.com/cip-project/cip-testing/
testing/issues/173

* B at D working with new kernelci version. Consolidation required.
** Latest kernel tested and report by e-mail sent to mailing list.

* Relaxed permissions in /etc/linaro to adapt them to B at D use case #165: 
https://gitlab.com/cip-project/cip-testing/testing/issues/165

* Busybox updated to a newer version.

## Others

* Updated milestones in the CIP testing project to adapt them to the new 
maintenance mode.

* Although our participation was approved, in the last minute a collision in 
my schedule prevent me from attending to OpenExpo in Madrid. No one else can 
so I communicated to the organization we cannot attend.

* Open question: should we send Gitlab notifications to the mailing list?

As usual you can fin more accurate info about our work by reading the journal: 
https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptesting/
journal

Best Regards
-- 
Agust?n Benito Bethencourt
Principal Consultant
Codethink Ltd
