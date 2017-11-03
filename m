From: agustin.benito@codethink.co.uk (Agustin Benito Bethencourt)
Date: Fri, 3 Nov 2017 16:44:00 +0100
Subject: [cip-dev] CIP kernel maintenance and testing report. Weeks 43 and 44
Message-ID: <59FC8EC0.8090007@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,


this report covers the activities done by Codethink that are not related 
with B at D v1.0 release nor our presence at ELCE. This is why week 42 and 
most of week 43 are not included.

++ CIP Kernel maintenance

* Renesas supported Kernel build for using it at B at D v1.0
** Decided to take the same approach as BBB kernel. #167
** Link: https://gitlab.com/cip-project/cip-testing/testing/issues/167

* Further review of watchdog core triggered keepalive infrastructure 
backports.

++ CIP Testing project

* Renesas board support
** Remote power cycle of Renesas board done using IP Power 9258 Remote 
PDU. Working on remotely power cycling BBB. This is a request from 
Daniel W. and a suggestion from AGL CIAT folks. #166
** Link: https://gitlab.com/cip-project/cip-testing/testing/issues/166
* Renesas supported Kernel build for testing it at B at D v1.0
** Decided to take the same approach as BBB kernel.

* Our daily reports sent to cip-tests-results mailing lists are now 
referred to the latest CIP kernel 4.4.92-cip11

* Several bugs and improves in configurations has been added to gitlab 
out of the demos and suggestion at ELCE 2017. The most relevant are:
** B at D should use its own test-definitions repo and should be local #158
*** Link: https://gitlab.com/cip-project/cip-testing/testing/issues/158
** kernelci webserver should start at VM boot time #160
*** Link: https://gitlab.com/cip-project/cip-testing/testing/issues/160
** Builds older than 5 days does not appear on kernelci #164
*** Link: https://gitlab.com/cip-project/cip-testing/testing/issues/164

* Several small improvements in the documentation as consequence of the 
ELCE demos like #120
** Link: https://gitlab.com/cip-project/cip-testing/testing/issues/120

* Some support actions taken after ELCE 2017.

++ Other activities

* Preparation of an online training session.

* Trying out CIP Core to evaluate future challenges for testing it with B at D
** Discussion about the challenges that dependencies bring for testing 
the kernel and/or  system when the underlying OS is not Debian, the CIP 
default distro.

* Planning the coming key actions for the CIP Testing project based on 
the input got at ELCE 2017

Tom Pollard is still helping us in different areas, focused in the 
coming online training session.

Best Regards
-- 
Agustin Benito Bethencourt
Principal Consultant - FOSS at Codethink
agustin.benito at codethink.co.uk
