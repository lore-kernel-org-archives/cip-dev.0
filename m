From: agustin.benito@codethink.co.uk (Agustin Benito Bethencourt)
Date: Mon, 18 Sep 2017 12:27:41 +0100
Subject: [cip-dev] IP testing and kernel maintenance report week 36 and 37
Message-ID: <59BFADAD.3000702@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

this is a a summary of the main tasks performed by the Codethink guys 
during the last couple of weeks.

Week 36 and 37 2017

++ Kernel Maintenance

* Renesas patch-set merged

* Siemens patch-sets reviewed.
** Patch-sets merge is in progress. One re-submission by Siemens required.

* Discussion about CIP kernel into an x86_64 debian9 in progress.

++ CIP testing project

* B at D with new LAVA works. #114
** In order to merge the new version, we ned initramfs to work which is 
the current focus.
** link https://gitlab.com/cip-project/cip-testing/testing/issues/114

* Currently facing issues with locally built initramfs #136
** Asked upstream
** Link: https://gitlab.com/cip-project/cip-testing/testing/issues/136

* As usual, we are sending the outcome of the daily health-check to the 
cip-testing-results mailing list for the latest CIP kernel.
** Link: 
https://lists.cip-project.org/pipermail/cip-testing-results/2017-September/thread.html
** More verbose mode implemented. More improvements required.

* Other tasks

** Improvements on the the device dictionary for BBB to remove 
unnecessary commands. In progress. #138
*** Link: https://gitlab.com/cip-project/cip-testing/testing/issues/138

** #127 bug closed
*** Link: https://gitlab.com/cip-project/cip-testing/testing/issues/127

++ Other tasks

* B at D and AGL lab in a box
**  Incorporate notification callbacks into b at d #137 would help AGL
** Link: https://gitlab.com/cip-project/cip-testing/testing/issues/137

* We are starting to be involved upstream not just by requesting help 
but also providing it when it comes to our use case. Small but 
significant step.

* We have started to check how to improve reports/notifications.

* ELCE

** B at D training session
*** Doing some tests useful to preparing the set up at the CIP room 
related with wifi and cable connectivity
*** Schedule set. Needs announcement.

** Kernel maintenance meeting schedule set. Needs announcement.

** Waiting for confirmation about the Y2038 meeting. Room availability 
known.

** To follow closely the work done in the CIP testing front you can 
check the project journal. Feel free to add your bits there if you 
anything related with this effort so the rest of the team read it.
*** Link: 
https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptesting/journal

Best regards

-- 
Agustin Benito Bethencourt
Principal Consultant - FOSS at Codethink
agustin.benito at codethink.co.uk
