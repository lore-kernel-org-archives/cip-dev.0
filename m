From: agustin.benito@codethink.co.uk (Agustin Benito Bethencourt)
Date: Fri, 7 Jul 2017 13:16:36 +0200
Subject: [cip-dev] Kernel maintenance and CIP testing report weeks 25 to 27
Message-ID: <595F6D94.4040401@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

Kernel maintenance

1. We have a new CIP kernel v4.4.75cip6 As anecdote, the kernel includes 
two patches that fix two regressions introduced by LTS patches. These 
fixes will be part of the next LTS version.

2. Ben is focused now on the evaluation of the kernel features. The goal 
is to send the evaluation by mail and then attend to the CIP TSC 
bi-weekly call on July 24th to answer questions.

3. Ben keeps reviewing 4.4 LTS patches on ongoing basis.

Testing

1. As informed this week, Robert has been for some weeks now running the 
health-check on daily basis, building and booting the CIP kernel on the 
BBB, including the locally built initramfs.

2. Don's last task was to investigate how to configure LAVA API to send 
mails. Robert will pick up this task in the coming weeks. 
https://gitlab.com/cip-project/cip-testing/testing/issues/102

3. As reported by Robert, he has been focused in making B at D work on 
Windows 10, which was a request from Hitachi. There is significant 
progress in that front. 
https://gitlab.com/cip-project/cip-testing/testing/issues/106

4. After some discussion within the team, we provided a workaround to 
overcome the webproxy issue reported by Daniel Sangorrin. We will find 
out if the workaround is a good one or we need to put more effort on 
this topic. https://gitlab.com/cip-project/cip-testing/testing/issues/99

5. After going through the TSC request/approval process some new 
repositories has been created to overcome past issues with B at D and to 
start working on Action 2. In a couple of cases we have submitted 
upstream the license file which has been merged right away. 
https://gitlab.com/cip-project/cip-testing/testing/issues/100

6. Other topics
* Now the creation of initramfs is manual. Robert is working in 
automating the process 
https://gitlab.com/cip-project/cip-testing/testing/issues/111
* Addressing a contribution from Daniel Wargner 
https://gitlab.com/cip-project/cip-testing/testing/issues/107
* The testing team is starting the discussion about how to technically 
implement the check required to achieve the fully distributed service 
architecture, specially focusing now in the health-check. An e-mail has 
been sent about it to the cip-dev mailing list.


Other topics

1. Don is no longer working at Codethink, I would like to take this 
opportunity to thank him for his effort, commitment and contributions to 
the project. The engineering team behind CIP testing is now limited to 
Robert Marshall.

2. Ben H. and myself created an abstract that we have presented for ELCE.

3. CIP is a DebConf sponsor. Plat'Home was last year and Codethink is 
also sponsoring this edition.

Best Regards
-- 
Agustin Benito Bethencourt
Principal Consultant - FOSS at Codethink
agustin.benito at codethink.co.uk
