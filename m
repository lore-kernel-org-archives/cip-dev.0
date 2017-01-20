From: agustin.benito@codethink.co.uk (Agustin Benito Bethencourt)
Date: Fri, 20 Jan 2017 17:00:27 +0100
Subject: [cip-dev] CIP update 08 WK 03
In-Reply-To: <87a8b4e479.fsf@codethink.co.uk>
References: <87a8bo0y12.fsf@codethink.co.uk> <87a8b4e479.fsf@codethink.co.uk>
Message-ID: <5882341B.50201@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

this is the report from the activities that Codethink is driving on and 
or involved. This week is not that we worked more but that we completed 
more tasks.

++ Meetings

* Members meeting on Monday January 16th
** ELC booth/sponsorship logistics as main topic
** Report about testing and kernel maintenance efforts.

* Next Members meeting on Monday January 23rd
** Ben Hutchings attending to provide update about the kernel 
maintenance effort

++ Kernel maintenance

* 4.4 CIP kernel updated to the latest LTS.

* Backported patches being merged.

* Kernel maintenance policies under review.

The goal is to arrive to ELC with the policies finished and the 
backported patches merged. Some additional tasks might be done meanwhile.

++ Testing: Board @desk - Single Developer

* KernelCI Virtual Machine Setup & Configuration Howto published[1]
** You can follow other tasks related with the beta release in the 
ticket #10

* Improvements in the Kernel CI & LAVA v2 configuration.
** LAVA v2 Web Server now sees the devices that are available in the 
application #4
** LAVA v2 tests now complete #5
** QEMU health check are executing and does not get a KVM kernel module 
related error any more. #8 #9
** KernelCI VM now boots in Debian Jessie #12

* Beta release initially set for February 4th #10
** The plan at this point is to release right before ELC.

++ Other topics

* Robert Marshall has is no longer part of the team. Christos Karamitsos 
has substituted him. Chris is also based in Manchester. He will be 
focused in the issues we have in the kernelci front and back-en related 
with DDBB.
** Thanks Robert for your effort in pushing the development further. 
Welcome Christos. Please introduce yourself to the audience (when you 
recover from that flu).

* Ben H. and Don Brown has now edit access to the public wiki. If you 
have a Linux Foundation ID, please review if you have them too. If not, 
please let us know through this list. #11

* Agustin (and Yoshi) will attend to FOSDEM. What about you?

++ Coming activities

* Investigate DDBB related issues #2 and #3

* Consolidate the KernelCI & LAVA v2 servers into one VM #12

* Add documentation #10

* Preparation of the slides for the Open Source Leadership Summit 
(Agustin and Nori).

#2 https://gitlab.com/cip-project/testing/issues/2
#3 https://gitlab.com/cip-project/testing/issues/3
#4 https://gitlab.com/cip-project/testing/issues/4
#5 https://gitlab.com/cip-project/testing/issues/5
#8 https://gitlab.com/cip-project/testing/issues/8
#9 https://gitlab.com/cip-project/testing/issues/9
#10 https://gitlab.com/cip-project/testing/issues/10
#11 https://gitlab.com/cip-project/testing/issues/11
#12 https://gitlab.com/cip-project/testing/issues/12

[1] 
https://wiki.linuxfoundation.org/civilinfrastructureplatform/testinglavav2vmsetup

Best Regards

-- 
Agustin Benito Bethencourt
Principal Consultant - FOSS at Codethink
agustin.benito at codethink.co.uk
