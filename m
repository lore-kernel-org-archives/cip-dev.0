Return-Path: <SRS0=K9NK=BD=lists.cip-project.org=bounce+64572+4994+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3FDC433EA
	for <cip-dev@archiver.kernel.org>; Fri, 24 Jul 2020 08:27:59 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D32AC206EB
	for <cip-dev@archiver.kernel.org>; Fri, 24 Jul 2020 08:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="B4HaZ29E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D32AC206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4994+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id HJv4YY4521723xMzDa2mBcjU; Fri, 24 Jul 2020 01:27:58 -0700
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.105])
 by mx.groups.io with SMTP id smtpd.web12.2015.1595579276626875593
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jul 2020 01:27:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJ3yN23q+v11lU86R87igYM7eOypDmeCKYvrHWS6ccXteS9GVfUyEZiG4QbZQoIiIux31aWy3LY4jM7h4MSL9vxhlEMwX16HXjjCiYRmZtYS5m4BCcVXXuetwN88d9t2W3uI7S5uohCGfsn8+Sy83UhilROWV65X1n3np3GDAKZO91fiGaO9uHoipeU3oYtyHvmbK96nW5bmlf6h+YnVwpw4pMXNmTw51qaeugrAkOZOKNABN9w19LgK+pp5wdl/Wu8yyRvoQHN+BdDupS8q4349zOjAY4W7PE1ZgMnX1k07khXlQaHagzWAnKg1k0+KWtaS6lRXgDTtqci9OAL0gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wi6G5r8j4raLJMDtal/T4VF950sh/CC+gwWBnPD7D70=;
 b=HQNtR57P1bw4vQ0Lhre3X71DPevmzerG98gsLsIsP+hQzB2mbuSgqr4hB7C8IVq1VflcDTuKX8BoKUErC5/mipcxj1R4yr2/HtuTCshMqZl6NYYXPuEsH/+nM7Ido3aw1t4NVXPHuLDdc8Ga+M+e8q/Y8wilkchSNrX3OU3NimBpYhCp2LyZjluqnJvyeOFv/xVMUfQ2LYJkrcLvZxXysUDffMtDXSbQgAx7cAAhlpjNb6ch3buA9GduipXFChiATL8gQvN0lxV02m2wzjO+FghWVJrLK1Rc621veWUNtsNNuiLvqLrIoXcTW4gRU+WFZOO37usmU0nVGgekTEjbgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
X-Received: from OSAPR01MB2385.jpnprd01.prod.outlook.com (2603:1096:603:37::20)
 by OSAPR01MB2786.jpnprd01.prod.outlook.com (2603:1096:604::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.23; Fri, 24 Jul 2020 08:27:53 +0000
X-Received: from OSAPR01MB2385.jpnprd01.prod.outlook.com
 ([fe80::9dba:6049:dd66:3c70]) by OSAPR01MB2385.jpnprd01.prod.outlook.com
 ([fe80::9dba:6049:dd66:3c70%7]) with mapi id 15.20.3216.023; Fri, 24 Jul 2020
 08:27:53 +0000
From: "Chris Paterson" <chris.paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdZgnINE0GQldgftRamowlp9iRaMFwA94zMQ
Date: Fri, 24 Jul 2020 08:27:52 +0000
Message-ID: 
 <OSAPR01MB23857705B82D0D163B5E5211B7770@OSAPR01MB2385.jpnprd01.prod.outlook.com>
References: 
 <TY2PR01MB49725D13A78694E61A9E03B7A0760@TY2PR01MB4972.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TY2PR01MB49725D13A78694E61A9E03B7A0760@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [176.27.142.92]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c37db442-ab27-450a-b569-08d82fab7588
x-ms-traffictypediagnostic: OSAPR01MB2786:
x-microsoft-antispam-prvs: 
 <OSAPR01MB2786450AF92F64CD0647A1CBB7770@OSAPR01MB2786.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 y0N0STlBe0BJw6O2R697GEvwDBsbdexvZcHDl6Jl+W2oZsPdcDczy05fI34yeuYxWuWwmMzJbZnQGuhUozA1W1fQfk0SX7HJ78LtmSAEbrwX7m/cSWbwL1GDmBaZJfhyxlmdLoh8510HzNqGoMPAlXIvcic9ufmDlCDi7a2ATanlNaqatfCDBdbelJg0zNJtcECoO+lc9nuhwl+ZgCGMGQAAyS/dkIAYgUxvkETFBAIlNBSafBeALif3I4P//ClDSwz5NnyfaWio/nJWdoAa7sUad+AlSGEM1cGMRzEG0dtAoccadNCltbRq3b4woM2X7MhyGFEUAZHbaLxmcT8ufx5pFpo6xuDa1278bLV9QPxfkI2y6N7VhHL4mEcx6JULfCdPhxDZccD/mVwQJOH4zw==
x-ms-exchange-antispam-messagedata: 
 KNhHgpTLbbed0lL6D6akiks6l5gM9T+NUioKwlhr67AjDhQB0PP9qS/gHPCUWUp/jC5XDUCUG04yiVdj2liKDX1Zkmdyf0WCqNKD3d5u44I2yzuf88RgDjJ2gZLyRMky6NNgSlAZ9ZJRvYsz8YnqcAnj2Y0XWH4YmXcoiy14xZzunWX9RkCK9XExQEQtb6K9/X/jFimR1RHBx66sRZffs/fU1KOwB1C/HHFbT8DWW+3+oN7oT0q7xx4cfHHvfY/jmya9ub/IFS/LMn3J8fuIuTbtISJ1BrZ1gtVSXzEVmvpQNwmhFMLF5OKDQayFgEWK47vdD3NnoOYHpBlkTPdKKST8PYCOBT6j6023R7fbeg1ICgxdbmHC1ULUgFOx4gGUn03zIrviCrVhF5TEyuv2dqsmhDH+m1EXHRaM+Kv6xSnYBWCKdBw9OX/5Cw8lqqC7+5k/+wE/B7hRhZomcsFBPYw3BZH3bqNoUHHw1ECCAh8E4NnNl4Z2ccPOqrGmADfR
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB2385.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c37db442-ab27-450a-b569-08d82fab7588
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2020 08:27:52.8882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a2ojGW8dNmI13N239c1Noqz4GGJ101X5HdYlmIXrqFu07NnBmAcY0TP3Gxm7tDZkkaoI6LvP6dSMnJKNSEfUpHcxkqy77/q0/IJjAsFS5Qo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2786
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 9vOmQwN6HFHFLywOyxL9h6Xfx4520388AA=
Content-Type: multipart/mixed; boundary="dWmqdSgHs17Mua54qQgs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595579278;
 bh=hmKaBJmRJg2KpMYa8dAIoVDQqos5oUuP2GHee6WSsXo=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=B4HaZ29EccoHXSZVXFzZKsWx7/ouVQS6l9hP8Jdh2PHgsHOitsnJz2Lm0AjvDHgK8i3
 Uc5FhQSWOQlc4TM9Sta6o3c237RrnxM2uf1Tqfj8IQfRFTX3H0fmZS9o7oHUT763gcP6B
 +mrISIzx1KbbvA8alXGRhElVOwBCtknUAPs=

--dWmqdSgHs17Mua54qQgs
Content-Language: en-US
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hello all,

The IRC logger was down yesterday, so please see a dirty copy/paste from th=
e meeting below.

Kind regards, Chris

/start log

patersonc
Hello
wens
hi
szlin
hi
suzuki
hi
paveltest
hi
patersonc
I'm in charge today - sorry in advance!
#startmeeting CIP IRC weekly meeting
bwh joined the room.
bwh
hi
patersonc
#topic rollcall
Say hi etc.
(Doesn't look like the logger is working for me?)
dineshk
Hi
patersonc
I guess everyone has said hi already ;)
bwh
patersonc: It's not in the channel
patersonc
Ah
szlin
patersonc: it seems like the bot is not around
paveltest
Umm, I guess we can just pretend it works and create the logs manually or s=
omething.
patersonc
Sure
#topic AI review
Combine root filesystem with kselftest binary - iwamatsu
Any updates iwamatsu?
szlin
patersonc: Today is the national holiday in Japan
paveltest
I don't think he is around... did not say hi.
patersonc
Ah is it? I didn't realise :(
Moving on...
Post LTP results to KernelCI - patersonc
No updates from me
Issues to be fixed for swupdate "copyright correction and salsa CI testing"=
 - iwamatsu
szlin
Done
patersonc
Huzzah. Thanks szlin
szlin
I uploaded the new version of swupdate few weeks ago.
patersonc
Thanks. It could be that the action list I'm using is out of date...
Moving on...
#topic Kernel maintenance updates
wens
3 new CVEs, all fixed and backported (if needed); 3 old CVEs fixed.
paveltest
I have reviewed patches for 4.19.134.
bwh
I have reviewed kernel-sec updates by wens
patersonc
I have a question for the mainainers
Is anyone maintaining the CIP patchwork?
(or using)
paveltest
Hmm... We used it some time ago.
...but then I somehow forgot it exists.
patersonc
#link https://patchwork.kernel.org/project/cip-dev/list/
I wonder if someone should take ownership of it?
paveltest
Ammount of patches on the list is quite low, so patchwork is not really use=
ful.
I believe we cna
can simply declare it dead.
It is currently not useful.
patersonc
Would it become more useful when LTS support ends?
paveltest
I don't think so.
It would become useful if we got a lot of patches
from participating companies.
patersonc
Any thoughts from anyone else?
paveltest
Currently we are just getting patches from Biju and ammount is quite low.
patersonc
Okay. Thanks=20
paveltest
bwh
I don't have experience using patchwork, so I don't have a feel for when it=
's more or less useful
wens
I guess it really depends on the maintainers? It's less common for patch su=
bmitters to go on patchwork to update status for their own patches
(hence the unmaintained mess for lakml patchwork)
paveltest
I see patchwork as a service for patch submitters. If they are okay without=
 it, it is easier for maintainer.
patersonc
I know that it's useful for those who want a nice URL to their submitted pa=
tch before it gets merged
wens
paveltest: I always thought it was the other way around.
patersonc: I believe lore takes care of that now
patersonc
I'll send an email to the wider maintainer/cip-dev group to see if everyone=
 agrees that we should kill it, or leave it running (un)maintained
#action patersonc: Email Kernel team/cip-dev about patchwork usage
paveltest
Wens: well, if there are so many patches maintainer loses track, it is usef=
ul for maintainer too. But that is not currently the case.
patersonc
Any other topics/comments for/from the Kernel team?
5
4
3
2
1
#topic Kernel testing
KernelCI have agreed to add the CIP trees to kernelci.org
I've submitted a PR accordingly: https://github.com/kernelci/kernelci-core/=
pull/448
Fix renesas-soc repository and add CIP branches.
We also plan to have our own instance, initially running on KCI's servers a=
t cip.kernelci.org.
Any testing related topics/questions from anyone else?
wens
are the instances completely separate, or sharing data / control?
patersonc
Separate. If we add any useful features on our fork we'd aim to upstream th=
em back to kernelci
Initially we'd be using KCI's build infrastructure, with the aim of integra=
ting it into our own
If anyone is interested in helping out with this effort please let me know.
Anyone for anymore before the next topic?
5
4
3
2
1
#topic Software update
suzuki
Hello.
I had found some problems with the current software update mechanism upload=
ed to cip-sw-updates-demo repository.
paveltest left the room.
suzuki
The problems had been that some needed files and settings didn't exist in t=
he root file system.
I created gitlab issues about them: https://gitlab.com/cip-project/cip-sw-u=
pdates/cip-sw-updates-tasks/-/issues/15, https://gitlab.com/cip-project/cip=
-sw-updates/cip-sw-updates-tasks/-/issues/16
And I'm working on them. One of them has been already done.
Apart from that, Mohammed is working on the task which is to support HTTPS =
connection between SWUpdate and hawkBit: https://gitlab.com/cip-project/cip=
-sw-updates/cip-sw-updates-tasks/-/issues/8
That's all from me.
patersonc
Thank you suzuki-san
Any queries from anyone?
5
4
3
2
1
#topic CIP Security
dineshk
hello
I guess Kent is not around so I will update
patersonc
Thank you
dineshk
Completed verification of single node security requirements on CIP LAVA
 Working with Chris to verify multi-node security requirements on LAVA
SOW signed with exida for CIP gap assessment for IEC-62443-4-2 & IEC-62443-=
4-1=20
Kick-off meeting with exida held for Gap assessment yesterday
That's all from security WG
patersonc
Thank you dineshk
Any comments/queries?
5
4
3
2
1
#topic AOB
Any other topics from anyone today?
If not, then I guess we'll close for today.
Thank you all for your time!
#endmeeting

/end log=20

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of masashi.kudo@cybertrust.co.jp via lists.cip-project.org
> Sent: 23 July 2020 03:59
>=20
> Hi all,
>=20
> Kindly be reminded to attend the weekly meeting through IRC to discuss
> technical topics with CIP kernel today.
> I cannot attend the meeting today. Chris-san will host the meeting instea=
d.
>=20
> *Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00
> starting from the first week of Apr. according to TSC meeting*
> https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2020
> &month=3D7&day=3D23&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p=
4=3D3
> 7&p5=3D241&p6=3D248
>=20
> USWest	USEast	UK	DE	TW	JP
> 02:00	05:00	10:00	11:00	17:00	18:00
>=20
> Channel:
> * irc:chat.freenode.net:6667/cip
>=20
> Last meeting minutes:
> https://irclogs.baserock.org/meetings/cip/2020/07/cip.2020-07-16-
> 09.00.log.html
>=20
> Agenda:
>=20
> * Action item
>   1. Combine root filesystem with kselftest binary - iwamatsu
>   2. Post LTP results to KernelCI - patersonc
>   3. Issues to be fixed for swupdate "copyright correction and salsa CI t=
esting"
> - iwamatsu
>=20
> * Kernel maintenance updates
> * Kernel testing
> * Software update
> * CIP Security
> * AOB
>=20
> The meeting will take 30 min, although it can be extended to an hour if i=
t
> makes sense and those involved in the topics can stay. Otherwise, the top=
ic
> will be taken offline or in the next meeting.
>=20
> Best regards,
> --
> M. Kudo
> Cybertrust Japan Co., Ltd.

--dWmqdSgHs17Mua54qQgs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4994): https://lists.cip-project.org/g/cip-dev/message=
/4994
Mute This Topic: https://lists.cip-project.org/mt/75739176/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--dWmqdSgHs17Mua54qQgs--
