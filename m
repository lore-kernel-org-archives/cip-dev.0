From: masashi.kudo@cybertrust.co.jp (masashi.kudo at cybertrust.co.jp)
Date: Tue, 1 Oct 2019 02:47:06 +0000
Subject: [cip-dev] CIP IRC weekly meeting today
In-Reply-To: <OSBPR01MB24239C49F9038EB86299B8D4A0860@OSBPR01MB2423.jpnprd01.prod.outlook.com>
References: <HK0PR01MB2979E0408AE1A9C1323DCEFDE2860@HK0PR01MB2979.apcprd01.prod.exchangelabs.com>
	<CAFa_k0gBzv-2bOF_pGbpvZQyQ1ocEu-bsBNT_JsWi12cxrK-Pg@mail.gmail.com>
	<OSBPR01MB24239C49F9038EB86299B8D4A0860@OSBPR01MB2423.jpnprd01.prod.outlook.com>
Message-ID: <CAFa_k0gKU3eudKOK-txbprBA4=B+9RnJXs5VX18GXxvr2SqPYg@mail.gmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi, Pavel-san,

At the CIP kernel meeting, there was the following conversation regarding the Cybertrust proposal.
(BTW, 'masashi910' is me. )

[18:43] <pave1> masashi910: We don't need working version at the moment. But if you could mail the patches, or post pointer for them, or at least diffstat... That would help.
[18:44] <masashi910> pavel: Thanks. Our work is currently being done locally. I will discuss our team how to share the patches with you.

The current work which contains all CIP kernel files is compiled into a tar ball, and I uploaded the ball under the following repository.
https://github.com/masashi910/tmp-cip-xilinx-mpsoc/

Please let me reiterate the following:
 - Cybertrust so far identified patches (in BSP) to be applied to CIP SLTS4.19 for some use cases
 - Those patches were from BSP, and our next step is to figure out which patches are actually in Mainline tree.
 - In another word, some of the current identified patches may not be in Mainline tree, yet.

If you have any questions, please let me know.

Best regards,
--
M. Kudo

2019?9?26?(?) 12:01 <masashi.kudo at cybertrust.co.jp<mailto:masashi.kudo@cybertrust.co.jp>>:
Hi, SZ-san, All,

Cybertrust would like to propose some contribution as described in the attached material.
I would appreciate it if this topic can be discussed in AOB.

Best regards,
--
M. Kudo
Cybertrust Japan Co., Ltd.

---------- Forwarded message ---------
From: SZ Lin (???) <SZ.Lin at moxa.com<mailto:SZ.Lin@moxa.com>>
Date: 2019?9?26?(?) 11:46
Subject: [cip-dev] CIP IRC weekly meeting today
To: cip-dev at lists.cip-project.org<mailto:cip-dev@lists.cip-project.org> <cip-dev at lists.cip-project.org<mailto:cip-dev@lists.cip-project.org>>


Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss technical topics with CIP kernel today.

*Please note that IRC meeting was rescheduled to UTC (GMT) 09:00 starting from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=2019&month=9&day=26&hour=9&min=0&sec=0&p1=241&p2=137&p3=179&p4=136&p5=37&p6=248

US-West US-East   UK     DE     TW     JP
02:00    05:00   10:00   11:00   17:00   18:00

Channel:
* irc:chat.freenode.net:6667/cip<http://chat.freenode.net:6667/cip>

Agenda:

* Action item
1. Provide the cases to cip-testing to build up the test environment - Iwamatsu-san

2. Test LTS (pre)releases directly - patersonc

* Kernel maintenance updates
* Kernel testing
* CIP Core
* Software update
* AOB

The meeting will take 30 min, although it can be extended to an hour if it makes sense and those involved in the topics can stay. Otherwise, the topic will be taken offline or in the next meeting.

Best regards,

SZ Lin, Moxa.
_______________________________________________
cip-dev mailing list
cip-dev at lists.cip-project.org<mailto:cip-dev@lists.cip-project.org>
https://lists.cip-project.org/mailman/listinfo/cip-dev
_______________________________________________
cip-dev mailing list
cip-dev at lists.cip-project.org<mailto:cip-dev@lists.cip-project.org>
https://lists.cip-project.org/mailman/listinfo/cip-dev
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191001/c9da90b5/attachment-0001.html>
