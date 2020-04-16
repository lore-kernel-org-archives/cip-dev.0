Return-Path: <SRS0=gzRl=6A=lists.cip-project.org=bounce+64572+4581+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C38CC2BB85
	for <cip-dev@archiver.kernel.org>; Thu, 16 Apr 2020 08:16:02 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABCF221655
	for <cip-dev@archiver.kernel.org>; Thu, 16 Apr 2020 08:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="ELme7XnZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABCF221655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4581+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id rAqfYY4521723xPem6KpSldy; Thu, 16 Apr 2020 01:16:01 -0700
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.97])
 by mx.groups.io with SMTP id smtpd.web12.2531.1587024960237187388
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Apr 2020 01:16:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lXaoRpOArlpgvt0ty9np/B0Na6YZlRTRt0Tg1yPymihafqxZHOlvsOsVm7a/iHfdWzLhOyu5pvKAlImQRmyVenSDUWfO9tKLnpc/KsQuXel6u8DD/V/Ts74s0SHQgW/jFVL+SmYYDJqMZAXeZFW9srs5G3aH/Q9JWUNEvetc972uB421WkdIvFi3pjPxX8fx9I3+deueRg4hBL0UmvcUTMyAIvgdm8AviaqaX6y2LKc5Od/EGlluZjBFqFtfBeBbtSsbpxSb36i7SDoC+Vw2vouebDRkETHoUsE0o51uq+BwaxaFXa6Y1gs1V427UqeJc30vP42jsUDm6Kx0XavHmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c05SnldjDGzYvtEY2tG/fXhOyuvDs//GUt70gufr+1Q=;
 b=CvW4jqietrmb8x7TIPBkBTGuhsfEKj4AG3g3mSOFAx2Vj2lBLU3i++7N4zs5uH3EfSyyEmroFGSd0U/d3oOy7DEm1i+6eWfIC+xleKmedolu6CU/RVv0qXFfKCBaGRLzv6KVAJtkWm34yt36iiWsMKfW517hisorBYcjzkQ03Mpj6arrGYTkyMwU0pHnq+GNfTm9QwF87iGEF5m1KGqJwCftEdZrOlq7iRN7IhaR/6IZdDDwVc96EYJMsTnStEiwyRswEh/j0C825cNkG7DyA8C3CC4MhnX1FemLN6owV7SzsrjaUleiTP0YPAUEe2rHuciSr1N4+nC7j/qW2YxZJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
X-Received: from OSAPR01MB2274.jpnprd01.prod.outlook.com (52.134.237.151) by
 OSAPR01MB4658.jpnprd01.prod.outlook.com (20.178.129.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.19; Thu, 16 Apr 2020 08:15:56 +0000
X-Received: from OSAPR01MB2274.jpnprd01.prod.outlook.com
 ([fe80::5408:e563:4528:4b92]) by OSAPR01MB2274.jpnprd01.prod.outlook.com
 ([fe80::5408:e563:4528:4b92%5]) with mapi id 15.20.2900.028; Thu, 16 Apr 2020
 08:15:56 +0000
From: "Chris Paterson" <chris.paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdYTkwPVJpEHHN+iQmCdazHKo4mwewANAr4G
Date: Thu, 16 Apr 2020 08:15:56 +0000
Message-ID: 
 <OSAPR01MB227422068AA5F1DBFDF37DA2B7D80@OSAPR01MB2274.jpnprd01.prod.outlook.com>
References: 
 <TY2PR01MB497244C4E5B3D48167AFF5ADA0D80@TY2PR01MB4972.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TY2PR01MB497244C4E5B3D48167AFF5ADA0D80@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [151.224.220.27]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 462859f5-183c-45db-45dd-08d7e1de6359
x-ms-traffictypediagnostic: OSAPR01MB4658:
x-microsoft-antispam-prvs: 
 <OSAPR01MB46587F2BAA6075D84AA6C4E0B7D80@OSAPR01MB4658.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 AEC2sKFssR5Hf5vOu6fPgs8nJ13im0QXKCE0jd/AXfDsLrawNPcSCswF4lNMVLuhmsbMFdbfNx0z0brFuqxU9VYBTCP4eEaWYFBaDXotaWYSoEWxDip+JSSjHWUJ+e2RE4VSe+2ifkmeiBBkjKx2BQimJnfWOn8TNzLUdHC6RVCYv6g+qhRIX1QVQExNUmsIK1kNtRGBDzx87XzoJZ8lJki9EKwtw64HEr7VanOP501vURLw8/B5+vfaAL7C0yDDvATuTT3apqid81HRsI8yb3n5IO+HwnawZ3eUxyDpekTzFZkyQoIcWYfVBAFMklNJzRI/DQTCWuwvCTZvdKcRsRFD06Y4ykHNGOLAoGxawIZEvkFGEHHMcSwEqyKwAbWL++GjL8cJ0OgotQCrZCKOVOEonn/b/TUsi5J8+ckU48zyt/gucyHLA9OCSThY9DFC7a1VOd+3lC6+O5EQ7p9RD5/9GHjv/FQgV+b5S09wOeFz439zMEpwUeAu/dZxgspJHwywHS3K/kcFKIpaCb7GZQ==
x-ms-exchange-antispam-messagedata: 
 3BVCSdq1ajznZNokgoYsoxom8T07lsFIYftVn2/vUUxuftPwfx1zkiiyBd9ko+iPv+NuuX9IXgUs5MF9vO4pTLuiKcw7njVYTsuGwTL7xTWWA5xm/YexWv9q2sLf0gQflwcdCXEZIOvjyZPRMEKvYg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 462859f5-183c-45db-45dd-08d7e1de6359
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2020 08:15:56.0299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L6457GW2zeZNL8NdrqrVpFgfUhRFNz2PVxTWzVG0QljepMu3xGiXZfbTBupvtqdME7pg17jZMQ3VKJ0Jv+ozW9LKcgLuEklCM4ymTtobr9U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4658
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: KokaUfSFAzO6CfH6Y7KxRZElx4520388AA=
Content-Type: multipart/mixed; boundary="RSNpOfwxC0ptztMotynS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1587024961;
 bh=sc/FQ9Qzw9SlVWx7Sa8M/nSjxeX/lpfVv0dJ9UzFHiQ=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=ELme7XnZM9Kw4P75Akp9h11L3scedTpwVEow6U2h+bLAZ0xfVYQhOiBgbeuusRD4syF
 T/CcXDm6FVDBQaIZ8VRvmEBu0RLW1btPhv3sL39tFYAWcwC7Rk+3hbv+4ZQQ9FWJ5XSEb
 3gS9wlFnFdhR2gS5ruBoWA4m05RPNO6Pu94=

--RSNpOfwxC0ptztMotynS
Content-Language: en-GB
Content-Type: multipart/alternative;
	boundary="_000_OSAPR01MB227422068AA5F1DBFDF37DA2B7D80OSAPR01MB2274jpnp_"

--_000_OSAPR01MB227422068AA5F1DBFDF37DA2B7D80OSAPR01MB2274jpnp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello Kudo-san,

Please accept my apologies for today's meeting as I am on leave this week.

No major updates to report from the testing working group.

Kind regards, Chris
________________________________
From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> on beha=
lf of masashi.kudo@cybertrust.co.jp via lists.cip-project.org <masashi.kudo=
=3Dcybertrust.co.jp@lists.cip-project.org>
Sent: Thursday, April 16, 2020 3:02:49 AM
To: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2020&mont=
h=3D4&day=3D16&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&=
p5=3D241&p6=3D248

USWest  USEast  UK      DE      TW      JP
02:00   05:00   10:00   11:00   17:00   18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2020/04/cip.2020-04-09-09.00.log.=
html

Agenda:

* Action item
1. Combine root filesystem with kselftest binary - Iwamatsu-san
2. Strengthen sustainable process to backport patches from Mainline/LTS - K=
ernel Team
 2-1. Workflow for identifying important fixes, backporting, and reviewing =
them
 2-2. Prepare the tools to be used for this workflow
 2-3. Get practice in backporting patches
3. Upload a guideline for reference hardware platform addition - masashi910
4. Identify target boards and configs for RT kernel testing (4.4rt and 4.19=
rt) - masashi910
5. Clarify the requirement about system-backup - Yoshida-san

* Kernel maintenance updates
* Kernel testing
* CIP Core
* Software update
* CIP Security
* AOB

The meeting will take 30 min, although it can be extended to an hour if it =
makes sense and those involved in the topics can stay. Otherwise, the topic=
 will be taken offline or in the next meeting.

Best regards,
--
M. Kudo
Cybertrust Japan Co., Ltd.

--_000_OSAPR01MB227422068AA5F1DBFDF37DA2B7D80OSAPR01MB2274jpnp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
Hello Kudo-san,<br>
<br>
</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
Please accept my apologies for today's meeting as I am on leave this week.<=
br>
<br>
</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
No major updates to report from the testing working group.<br>
<br>
</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
Kind regards, Chris</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> cip-dev@lists.cip-pro=
ject.org &lt;cip-dev@lists.cip-project.org&gt; on behalf of masashi.kudo@cy=
bertrust.co.jp via lists.cip-project.org &lt;masashi.kudo=3Dcybertrust.co.j=
p@lists.cip-project.org&gt;<br>
<b>Sent:</b> Thursday, April 16, 2020 3:02:49 AM<br>
<b>To:</b> cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-project.org&=
gt;<br>
<b>Subject:</b> [cip-dev] CIP IRC weekly meeting today</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi all,<br>
<br>
Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.<br>
<br>
*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*<br>
<a href=3D"https://www.timeanddate.com/worldclock/meetingdetails.html?year=
=3D2020&amp;month=3D4&amp;day=3D16&amp;hour=3D9&amp;min=3D0&amp;sec=3D0&amp=
;p1=3D224&amp;p2=3D179&amp;p3=3D136&amp;p4=3D37&amp;p5=3D241&amp;p6=3D248">=
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2020&amp;=
month=3D4&amp;day=3D16&amp;hour=3D9&amp;min=3D0&amp;sec=3D0&amp;p1=3D224&am=
p;p2=3D179&amp;p3=3D136&amp;p4=3D37&amp;p5=3D241&amp;p6=3D248</a><br>
<br>
USWest&nbsp; USEast&nbsp; UK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DE&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; TW&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; JP<br>
02:00&nbsp;&nbsp; 05:00&nbsp;&nbsp; 10:00&nbsp;&nbsp; 11:00&nbsp;&nbsp; 17:=
00&nbsp;&nbsp; 18:00<br>
<br>
Channel:<br>
* irc:chat.freenode.net:6667/cip<br>
<br>
Last meeting minutes:<br>
<a href=3D"https://irclogs.baserock.org/meetings/cip/2020/04/cip.2020-04-09=
-09.00.log.html">https://irclogs.baserock.org/meetings/cip/2020/04/cip.2020=
-04-09-09.00.log.html</a><br>
<br>
Agenda:<br>
<br>
* Action item<br>
1. Combine root filesystem with kselftest binary - Iwamatsu-san <br>
2. Strengthen sustainable process to backport patches from Mainline/LTS - K=
ernel Team<br>
&nbsp;2-1. Workflow for identifying important fixes, backporting, and revie=
wing them<br>
&nbsp;2-2. Prepare the tools to be used for this workflow<br>
&nbsp;2-3. Get practice in backporting patches<br>
3. Upload a guideline for reference hardware platform addition - masashi910=
<br>
4. Identify target boards and configs for RT kernel testing (4.4rt and 4.19=
rt) - masashi910<br>
5. Clarify the requirement about system-backup - Yoshida-san<br>
<br>
* Kernel maintenance updates<br>
* Kernel testing<br>
* CIP Core<br>
* Software update<br>
* CIP Security <br>
* AOB<br>
<br>
The meeting will take 30 min, although it can be extended to an hour if it =
makes sense and those involved in the topics can stay. Otherwise, the topic=
 will be taken offline or in the next meeting.<br>
<br>
Best regards,<br>
--<br>
M. Kudo<br>
Cybertrust Japan Co., Ltd.<br>
</div>
</span></font></div>
</body>
</html>

--_000_OSAPR01MB227422068AA5F1DBFDF37DA2B7D80OSAPR01MB2274jpnp_--

--RSNpOfwxC0ptztMotynS
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4581): https://lists.cip-project.org/g/cip-dev/message=
/4581
Mute This Topic: https://lists.cip-project.org/mt/73047683/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--RSNpOfwxC0ptztMotynS--
