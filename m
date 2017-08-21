From: agustin.benito@codethink.co.uk (Agustin Benito Bethencourt)
Date: Mon, 21 Aug 2017 10:33:39 +0100
Subject: [cip-dev] Kernel maintenance and CIP testing report weeks 31,
	32 and 33
Message-ID: <599AA8F3.5040302@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi all,

these are the main tasks done in the areas where Codethink is focusing 
the effort the past three weeks (Weeks 31 to 33)

++Kernel maintenance

* The review of the LTS patches to update a CIP kernel is ongoing. We 
are expecting an update soon
* Some support through the mailing list to pending questions has been 
provided. Question about BSP patches backport pending.
* The following needs has been identified as coming tasks: Implement 
kconfig support checker and Implement mapping from kconfig symbols to 
source files.
* Ben Hutchings will participate at the Maintainer Summit on Oct 26th 
http://events.linuxfoundation.org/events/linux-kernel-summit/program/about
* Talk about Kernel maintenance using CIP kernel as example has been 
approved by the ELCE content committee.

++CIP testing project

* Focused on LAVA update in order to fix several issues. 
https://gitlab.com/cip-project/cip-testing/testing/issues/114
** QEMU health check works. 
https://gitlab.com/cip-project/cip-testing/testing/issues/121 Focus now 
is making the health check works on BBB with updated LAVA.
** Discussions with upstream on some of the issues found.
** Summary about the work done sent to cip-dev mailing list.
* Progress on having B at D working behind a web-proxy 
https://gitlab.com/cip-project/cip-testing/testing/issues/99
* Daily health checks sent to the cip-testing-results mailing list
* Build artifacts referenced in the Beaglebone black health check are no 
longer accessible. Issue closed
* Issue in kernelci with csrf token is under investigation 
https://gitlab.com/cip-project/cip-testing/testing/issues/128

As usual, for a fine grain tracking of this project you can check the 
CIP testing project progress board: 
https://gitlab.com/cip-project/cip-testing/testing/boards

++Other tasks

* Data flow diagram for B at D (level 0) sent to cip-dev ML
* B at D planning and progress added to the wiki: 
https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptestingmanagement
* ELCE workshop
** ELCE 2017 workshop page created: 
https://wiki.linuxfoundation.org/civilinfrastructureplatform/cipconferences/cipwselce2017
** B at D 101 training session proposal sent. To be confirmed by TSC/Board 
https://gitlab.com/cip-project/cip-testing/testing/issues/126

Best Regards
-- 
Agustin Benito Bethencourt
Principal Consultant - FOSS at Codethink
agustin.benito at codethink.co.uk
