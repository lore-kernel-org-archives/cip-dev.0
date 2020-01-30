From: masashi.kudo@cybertrust.co.jp (masashi.kudo at cybertrust.co.jp)
Date: Thu, 30 Jan 2020 08:05:15 +0000
Subject: [cip-dev] CIP IRC weekly meeting today
In-Reply-To: <TYAPR01MB228507ADF78BD2F15FB91F8BB7040@TYAPR01MB2285.jpnprd01.prod.outlook.com>
References: <TYAPR01MB5135EC53C53F84613B963113A0050@TYAPR01MB5135.jpnprd01.prod.outlook.com>
 <TYAPR01MB228507ADF78BD2F15FB91F8BB7040@TYAPR01MB2285.jpnprd01.prod.outlook.com>
Message-ID: <TYAPR01MB5135DDC6E78841CDE0363529A0040@TYAPR01MB5135.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Chris-san,

Thanks for letting us know your status.
Then, see you next week!

Best regards,
--
M. Kudo

-----Original Message-----
From: Chris Paterson <Chris.Paterson2@renesas.com> 
Sent: Thursday, January 30, 2020 4:36 PM
To: ??????CTJ? <masashi.kudo@cybertrust.co.jp>; cip-dev at lists.cip-project.org
Subject: RE: CIP IRC weekly meeting today

Hello Kudo-san, all,

> From: cip-dev <cip-dev-bounces@lists.cip-project.org> On Behalf Of 
> masashi.kudo at cybertrust.co.jp
> Sent: 29 January 2020 22:55
> 
> Hi all,
> 
> Kindly be reminded to attend the weekly meeting through IRC to discuss 
> technical topics with CIP kernel today.

Sorry for not joining in with last week's meeting. I was online, but Matrix was playing up and no messages were getting through.
Please accept my apologies for this week's meeting. I'm on annual leave today.

> 
> *Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 
> starting from the first week of Apr. according to TSC meeting*
> https://www.timeanddate.com/worldclock/meetingdetails.html?year=2019
> &month=11&day=28&hour=9&min=0&sec=0&p1=241&p2=137&p3=179&p4=
> 136&p5=37&p6=248
> 
> US-West US-East   UK     DE     TW     JP
> 01:00    04:00   09:00   10:00   17:00   18:00
> 
> Channel:
> * irc:chat.freenode.net:6667/cip
> 
> Last week's meeting minutes:
> https://irclogs.baserock.org/meetings/cip/2020/01/cip.2020-01-23-
> 09.00.log.html
> 
> Agenda:
> 
> * Action item
> 1. Combine rootfilesystem with kselftest binary - Iwamatsu-san 2. 
> Document a process on how to add tests to the CIP test setup - 
> patersonc

No progress from me.

> 3. Arrangement of F2F Kernel Meeting in Nuremberg - masashi910 4. Add 
> config for BBB to both 4.4 and 4.19 (done for qemux86-64)  - 
> Iwamatsu-san
> 
> * Kernel maintenance updates
> * Kernel testing

Not much to report this week:
* I switched the remote PDUs in the Renesas LAVA lab with new (hopefully) reliable ones. This should improve uptime.
* In the last week for cip we've tested the 4.19.98-cip19 release, and the latest commits to the 4.4 and 4.19 branches.
  * https://gitlab.com/cip-project/cip-kernel/linux-cip/pipelines
* In the last week for linux-stable we've built/tested 4.4.211, 4.4.212, 4.19.99, 4.19.100 and many variants of the release candidates.
  * https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/commits/linux-4.4.y
  * https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/commits/linux-4.19.y

Kind regards, Chris

> * CIP Core
> * Software update
> * AOB
> 
> The meeting will take 30 min, although it can be extended to an hour 
> if it makes sense and those involved in the topics can stay. 
> Otherwise, the topic will be taken offline or in the next meeting.
> 
> Best regards,
> --
> M. Kudo
> Cybertrust Japan Co., Ltd.
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev
