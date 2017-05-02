From: agustin.benito@codethink.co.uk (Agustin Benito Bethencourt)
Date: Tue, 2 May 2017 17:41:50 +0100
Subject: [cip-dev] Update 2017wk17
Message-ID: <5908B6CE.5080802@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

++ CIP testing

Release plan

* The tentative release date is May 16th.
** There is a label called "release" that will make easier to follow the 
release specific tasks.

* High level release plan #37 
https://gitlab.com/cip-project/testing/issues/37

* Currently Robert Marshall and Don Brown are focusing on the release. I 
will take care of the some non-technical together with the management tasks.

* Some improvements needed in the wiki has been identified before the 
release:
** Wiki content improvements #44 
https://gitlab.com/cip-project/testing/issues/44
** v0.9 release: feature page #38 
https://gitlab.com/cip-project/testing/issues/38
** v0.9 release: Technical documentation #39 
https://gitlab.com/cip-project/testing/issues/39
** Version numbers of software in wiki incorrect #72 
https://gitlab.com/cip-project/testing/issues/72

Download service

* We have an issue with the certificates of the S3 service. Codethink 
operations team is looking into it.
** The service works but it would be ideal to fix the issue before the 
release #69 https://gitlab.com/cip-project/testing/issues/69

* Instructions for downloading the VM box #74 
https://gitlab.com/cip-project/testing/issues/74 ---> Feel free to 
download the VM and test it!

kernelci update

* As reported, we updated kernelci to match upstream which impacted us. 
We have fixed all the issues so we will ship the VM with the latest 
version, specially the blocker described in the previous report:
** Web server issues after the update fixed #65 
https://gitlab.com/cip-project/testing/issues/65

Vagrant / VirtualBox

* Lachaln joined the team for a few weeks to help us with some issues 
related with VirtualBox and Vagrant (provisioning/deployment).

* Some issues fixed by the team in this area has been:
** Import of box fails if vagrant instance already running #71 
https://gitlab.com/cip-project/testing/issues/71
** Write script to create the supporting files necessary to run the vm 
from the downloaded machine #50 
https://gitlab.com/cip-project/testing/issues/50
** Import of box fails if vagrant instance already running #71 
https://gitlab.com/cip-project/testing/issues/71
** Vagrant bring-up of VM slow or stalls #66 
https://gitlab.com/cip-project/testing/issues/66

ser2net and health check: connection between LAVA and the board

* Fixed integration script fixed #58 
https://gitlab.com/cip-project/testing/issues/58

* Prior to Health Check, you must telnet into the BBB as root, then quit 
telnet without logging out. Fixed #28 
https://gitlab.com/cip-project/testing/issues/28

* Different Shutdown Messages between sysvinit and systemd #73 
https://gitlab.com/cip-project/testing/issues/73

Testing

We are starting to face the last stage which is running tests on the 
board. We are working on this issue:

* Integrate lava-ci tool into board-at-desk-single-dev VM #20 
https://gitlab.com/cip-project/testing/issues/20

Decision to take

* We have been discussing which version of Vagrant/Virtualbox will we 
recommend to users.
** We had conflicting requirements between what Ben H. recommends, based 
on what is available in Debian,  and what the rest of the team consider 
ideal in order to support other users.
** The discussion is being held in #34 
https://gitlab.com/cip-project/testing/issues/34
** We will come to a conclusion during our next team meeting this coming 
Thursday May 4th.

OSSJ

We will work on demoing the VM at OSSJ
* High level overview of the work needed for the demo #70 
https://gitlab.com/cip-project/testing/issues/70

* A new group label has been created in gitlab to take care about 
events/conferences related topics, like demos: event: 
https://gitlab.com/groups/cip-project/labels

++ Kernel maintenance

* cip-kernel-sec project created to keep track relevant CVEs across 
mainline and stable branches: https://gitlab.com/cip-project/cip-kernel-sec

* Keep reviewing features from kernel configs sent by members.

* Reviewing 4.4.60 changes before upgrading the CIP kernel.

Best Regards
-- 
Agustin Benito Bethencourt
Principal Consultant - FOSS at Codethink
agustin.benito at codethink.co.uk
