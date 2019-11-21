From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Thu, 21 Nov 2019 08:53:42 +0000
Subject: [cip-dev] CIP IRC weekly meeting today
In-Reply-To: <HK0PR01MB2979A8112F8575E1248E5D25E24E0@HK0PR01MB2979.apcprd01.prod.exchangelabs.com>
References: <HK0PR01MB2979A8112F8575E1248E5D25E24E0@HK0PR01MB2979.apcprd01.prod.exchangelabs.com>
Message-ID: <TYAPR01MB228559D37ED211E00F559B5EB74E0@TYAPR01MB2285.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello SZ,

> From: cip-dev <cip-dev-bounces@lists.cip-project.org> On Behalf Of SZ Lin (???)
> Sent: 21 November 2019 00:30
> 
> Hi all,
> 
> Kindly be reminded to attend the weekly meeting through IRC to discuss
> technical topics with CIP kernel today.
> 
> *Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starting
> from the first week of Apr. according to TSC meeting*
> https://www.timeanddate.com/worldclock/meetingdetails.html?year=2019&m
> onth=11&day=21&hour=9&min=0&sec=0&p1=241&p2=137&p3=179&p4=136&p
> 5=37&p6=248
> 
> US-West US-East   UK     DE     TW     JP
> 01:00    04:00   09:00   10:00   17:00   18:00
> 
> Channel:
> * irc:chat.freenode.net:6667/cip
> 
> Last week's meeting minutes:
> https://irclogs.baserock.org/meetings/cip/2019/11/cip.2019-11-14-
> 09.00.log.html
> 
> Agenda:
> 
> * Action item

To save some time during the meeting, here is the latest status from me...

> 1. Test LTS (pre)releases directly - patersonc
Everything is working and we've found a few issues that have been reported to stable.
Remaining tasks are:
* Add a way to identify in GitLab what commit is being tested.
* Move everything from cip-playground to cip-project/cip-testing.

> 2. Ask KernelCI for recommendations on what tests to run - patersonc
I can't remember the background behind this, but I think we have a long enough list of tests to support for now.
I think we can close this.

> 3. Create a way/process to run LTP only for release tests - patersonc
Technically this is now possible due to updates to linux-cip-ci.
We just need to decide the best method to define 'release' testing.
I'll propose a method of how to do this to the maintainers soon.

> 4. Combine rootfilesystem with kselftest binary - Iwamatsu-san
> 5. Document a process on how to add tests to the CIP test setup - patersonc
No updates.

> 6. Split out non-Kernel config sections from gitlab-ci.yml - patersonc
Prototype complete. I just need to move from cip-playground to cip-testing.
https://gitlab.com/patersonc/linux-cip-pipelines/tree/initial-work
https://gitlab.com/cip-project/cip-kernel/linux-cip/blob/ci/patersonc/linux-4.19.y-cip/.gitlab-ci.yml

Kind regards, Chris

> 7. Do we want to go with the current approach where GitLab CI is run ?out of
> tree?- Kernel team
> 8. Ask RT admin to put CIP RT kernel to their CI-RT - Kernel team
> 
> * Kernel maintenance updates
> * Kernel testing
> * CIP Core
> * Software update
> * AOB
> 
> The meeting will take 30 min, although it can be extended to an hour if it makes
> sense and those involved in the topics can stay. Otherwise, the topic will be
> taken offline or in the next meeting.
> 
> Best regards,
> 
> SZ Lin, Moxa.
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev
