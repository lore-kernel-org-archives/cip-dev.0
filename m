From: akihiro27.suzuki@toshiba.co.jp (akihiro27.suzuki at toshiba.co.jp)
Date: Thu, 4 Jul 2019 06:38:34 +0000
Subject: [cip-dev] CIP IRC weekly meeting today
In-Reply-To: <HK0PR01MB2979096ED8E9CDE62672611AE2FA0@HK0PR01MB2979.apcprd01.prod.exchangelabs.com>
References: <HK0PR01MB2979096ED8E9CDE62672611AE2FA0@HK0PR01MB2979.apcprd01.prod.exchangelabs.com>
Message-ID: <TYAPR01MB470306E689DA232F49A00E46D9FA0@TYAPR01MB4703.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi SZ,

Today, Daniel-san takes a day off because of sickness.
And I won't join the meeting because I have an another plan.
Sorry about that.

So I'll describe the update of SW Updates WG here before the meeting.

> * Software update
* We are preparing a software update demo for OSSJ.
* We had a meeting with Christian of Siemens and he shared a sample script
  that could manage the state of software update.
* Suzuki implemented the state management into the u-boot script of the demo
  and now BeagleBone Black can switch back to old root filesystem if the update fails.
  We call it "rollback".
* Now we can give the demo of raw image update only.
  If we can make it in time, we will give the demo of binary delta update using librsync.

Best regards,
Suzuki


> -----Original Message-----
> From: cip-dev-bounces at lists.cip-project.org [mailto:cip-dev-bounces at lists.cip-project.org] On Behalf Of SZ Lin (??
> ?)
> Sent: Thursday, July 04, 2019 10:00 AM
> To: cip-dev at lists.cip-project.org
> Subject: [cip-dev] CIP IRC weekly meeting today
> 
> Hi all,
> 
> Kindly be reminded to attend the weekly meeting through IRC to discuss technical topics with CIP kernel today.
> 
> *Please note that IRC meeting was rescheduled to UTC (GMT) 09:00 starting from the first week of Apr. according to TSC
> meeting*
> https://www.timeanddate.com/worldclock/meetingdetails.html?year=2019&month=7&day=4&hour=9&min=0&sec=0&p1=241&p2=137&
> p3=179&p4=136&p5=37&p6=248
> 
> US-West US-East?? UK???? DE???? TW???? JP
> 02:00??? 05:00?? 10:00?? 11:00?? 17:00?? 18:00
> 
> Channel:
> * irc:chat.freenode.net:6667/cip
> 
> Agenda:
> 
> * Action item
> 1. Provide the script for CIP kernel config collection - bwh
> #link https://lists.cip-project.org/pipermail/cip-dev/2019-June/002506.html
> 2. List real time kernel questions to ask Daniel Wagner - szlin
> 3. Try updating CIP RT kernel to 4.19.50 - Pavel
> #link https://lists.cip-project.org/pipermail/cip-dev/2019-June/002548.html
> 4. Work out a solution for LAVA master backups - patersonc
> * Kernel maintenance updates
> * Kernel testing
> * CIP Core
> * Software update
> * AOB
> 
> The meeting will take 30 min, although it can be extended to an hour if it makes sense and those involved in the topics
> can stay. Otherwise, the topic will be taken offline or in the next meeting.
> 
> Best regards,
> 
> SZ Lin, Moxa.
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev
