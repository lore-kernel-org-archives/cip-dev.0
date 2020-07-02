Return-Path: <SRS0=O2/L=AN=lists.cip-project.org=bounce+64572+4881+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3854C433DF
	for <cip-dev@archiver.kernel.org>; Thu,  2 Jul 2020 08:43:38 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 713CA20884
	for <cip-dev@archiver.kernel.org>; Thu,  2 Jul 2020 08:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="j/2YR/jy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 713CA20884
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4881+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id cy81YY4521723xQavBSeQ69n; Thu, 02 Jul 2020 01:43:38 -0700
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.122])
 by mx.groups.io with SMTP id smtpd.web10.2311.1593679416791625141
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Jul 2020 01:43:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+JVUbsySlcbAF5KD7XGRAQpnZ0EDBkXxr61Jzz0EfQucDqCIXZW5MzmsZDLRPailM6iIGUlp63g5SRSqc+L6vyv4Ayg7hj3WMDldy/u2k9YW2NNW1odd2uS2BcCwabVcRDRu8uLNG2V0e3SAd+7JaHa/irUzxoqDLjs8v4243o+IenirhmZBtTyGM+8DfUK5sMS2ikvwBNyzAg63wG2TewfZ+bPmVNfQnUG/B8oTKiWQBuf9mrmy9AD9Z28Gw0rFB3Y38l49dwLR7asqlwyvjwuOxnFAtGZaOILjMR5SK7x72/Amy9hhYl4ZzlgLukHh61SAiecN4szlGqCkHeCrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wXVr9ugUWAdIVEH67Vx6DyGmFttRyJc71cSGoKlpy+4=;
 b=Am5M6W8VqwiR4Sd0XJPQpbsLxUtfbOZKiXQQvAttyc+Nin4RTYwb1eubYs3YKpwo30ABj5KfdXfyFdp8t5/aT7g3DxFTRwzDlvEcB24KpBWSnqoB8UEMYy8tEBcEY9HWj0mAE8LT9vv+vU704D/BDF2hHyTMixXhmOLKJxzD++rxLkZdPhorv/meXqjtcMjOAcdQPCd4aGXNe7pBW8zy6IwpgbGZfb0Sw/rMMkE73Nxs0i9Lull+M3Z3UZj7I6AjOk/yquLzUuyuXjmmRJR8KBroWvsbx7N1M+z15EyLfQEsXINH+7UuPGwRqczXxozXIQ5Tt1s9yMEU6Odl1vhSlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
X-Received: from OSAPR01MB2385.jpnprd01.prod.outlook.com (2603:1096:603:37::20)
 by OSAPR01MB5105.jpnprd01.prod.outlook.com (2603:1096:604:6c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23; Thu, 2 Jul
 2020 08:43:34 +0000
X-Received: from OSAPR01MB2385.jpnprd01.prod.outlook.com
 ([fe80::c44c:5473:6b95:d9fd]) by OSAPR01MB2385.jpnprd01.prod.outlook.com
 ([fe80::c44c:5473:6b95:d9fd%6]) with mapi id 15.20.3131.026; Thu, 2 Jul 2020
 08:43:34 +0000
From: "Chris Paterson" <chris.paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdZP+jmloosxvgoUTESSo9C2ia6xIQAUoNSV
Date: Thu, 2 Jul 2020 08:43:34 +0000
Message-ID: 
 <OSAPR01MB23850FE26978DA32103B17DCB76D0@OSAPR01MB2385.jpnprd01.prod.outlook.com>
References: 
 <TY2PR01MB4972E7064886814AAF9B745EA06C0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TY2PR01MB4972E7064886814AAF9B745EA06C0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [90.202.152.31]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1f2260f4-4625-4ed7-6520-08d81e640187
x-ms-traffictypediagnostic: OSAPR01MB5105:
x-microsoft-antispam-prvs: 
 <OSAPR01MB510564BB2C7FB1373CCC6E79B76D0@OSAPR01MB5105.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 r7+FZVKPDl0/VKaBQ7gxeJCLB/G5Es1x/huFDVepmmSbcxEFYbSn12GAL7OYaSUIqtZRmQv0VNm+voGOQ+OpuaJNE9i1MOIPlpuKWpmi+ZFHwBX4OwUEaKjO+F+L3PpNJSDG+urGWDGaPbB5/YlBBeUQ9HlwqgE//9E3333oGhHA0x6zx/9OydVR2LRisxQ6bf/7Lo9DgR0+9uaIkw7OvPpFW09bSqsHkokQfy/ShytYRQByuG6FDREuXzpNa/4AoV+zgtuBMoE8qzPaYji2WReGLborwJB4Wbwa25+pyl+UJHt54K9/66TNcKTT9gFKp0pnLQJnKrVzxOR1hne0366tsub7kb5RvOjsHigIZWuujMEvMGOpMNH/2Oi5Ul0JiV7dGhbuV21hXDHS4marKA==
x-ms-exchange-antispam-messagedata: 
 ATM4nCFas7F0RTHUknlzhOej3zszUoFHCqv18AvLWR2noTTU8cKeBz82tcV8rEAdP7cgNehoHUeI8jYbitvR9hOnz06dKiqrwxEt+BqS6zmA1qe7tyEu++KZqoXjcN5d+u6v7+qegPUPFm/cfJZY9p7BKWMgifp/nykTiqhbIE5+AsxTCEBk2P4CuW3sBs3pd6NLqcdyIW+z6tUmGdhYnGSd/+4U/QcW/V81Fclq0OlffWnSVjlIxLk6/HMoDYoCmfqFrR/lUMxYvl5kW16vzl5HGqYdhkK/XLp0hS6vKnbMLR/B5hsI0xMrHWFaUBd9TACgUrgGsZ+7lJ6SatzzPvOmyk/XcjWfzdLhl2JRh7HnlZnIP7EhmenS6gJnpPtHN1xDJVwwA/mnw1yuuEOSuSgS4p8lMSKp5RUnAVGkFVPrxA11ifQkJtXmqcGZSYb8rk3H2+TovflG8EkY+INBre8+bN7XclP4zOEzeiHlzHHoYlfCzrssnR5t20kU46Ur
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB2385.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f2260f4-4625-4ed7-6520-08d81e640187
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2020 08:43:34.2549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UoiB14rHzoRiHsVagVRiXfCnQ0qHLKCPY8Hs3y0MOmzffdVoCvtzGyWFL9J/fY3MzcUsA163XLUAaKTfyKGmFA4Fxb2FoLJj0fjq721uV+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB5105
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: qVwCYdOcEg9keuy1fCC1Kmvcx4520388AA=
Content-Type: multipart/mixed; boundary="vymCxUFOZGOkiu2XmB7N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1593679418;
 bh=6ecmK2Nejxpu2iemmAx92Vdsk/PgR6pFAQuWSwoP3ik=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=j/2YR/jyLhsKqgRHDYJKZdTCSG5GjWRKQ9BqzYD6DPX6YcVyEuBnIXSv8hkerzRKd1Y
 KbYDEwHLOM44F3ZcQMFFSComTAvPBFDVKMeGJ8Pq+K8t/tHkOVAvzqMsifrgvh6AHj9b7
 79G4cfGGiKinM81ADeA96lEgzfQO8H4FAdw=

--vymCxUFOZGOkiu2XmB7N
Content-Language: en-GB
Content-Type: multipart/alternative;
	boundary="_000_OSAPR01MB23850FE26978DA32103B17DCB76D0OSAPR01MB2385jpnp_"

--_000_OSAPR01MB23850FE26978DA32103B17DCB76D0OSAPR01MB2385jpnp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello Kudo-san,

Please accept my apologies; I can't babe the meeting this week.

Kind regards, Chris
________________________________
From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> on beha=
lf of masashi.kudo@cybertrust.co.jp via lists.cip-project.org <masashi.kudo=
=3Dcybertrust.co.jp@lists.cip-project.org>
Sent: Wednesday, July 1, 2020 11:53:32 PM
To: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2020&mont=
h=3D7&day=3D2&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&p=
5=3D241&p6=3D248

USWest  USEast  UK      DE      TW      JP
02:00   05:00   10:00   11:00   17:00   18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2020/06/cip.2020-06-25-09.00.log.=
html

Agenda:

* Action item
  1. Combine root filesystem with kselftest binary - iwamatsu
  2. Post LTP results to KernelCI - patersonc
  3. Issues to be fixed for swupdate "copyright correction and salsa CI tes=
ting" - iwamatsu

* Kernel maintenance updates
* Kernel testing
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

--_000_OSAPR01MB23850FE26978DA32103B17DCB76D0OSAPR01MB2385jpnp_
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
Please accept my apologies; I can't babe the meeting this week. <br>
<br>
</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
Kind regards<span id=3D"ms-outlook-android-cursor"></span>, Chris</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> cip-dev@lists.cip-pro=
ject.org &lt;cip-dev@lists.cip-project.org&gt; on behalf of masashi.kudo@cy=
bertrust.co.jp via lists.cip-project.org &lt;masashi.kudo=3Dcybertrust.co.j=
p@lists.cip-project.org&gt;<br>
<b>Sent:</b> Wednesday, July 1, 2020 11:53:32 PM<br>
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
=3D2020&amp;month=3D7&amp;day=3D2&amp;hour=3D9&amp;min=3D0&amp;sec=3D0&amp;=
p1=3D224&amp;p2=3D179&amp;p3=3D136&amp;p4=3D37&amp;p5=3D241&amp;p6=3D248">h=
ttps://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2020&amp;m=
onth=3D7&amp;day=3D2&amp;hour=3D9&amp;min=3D0&amp;sec=3D0&amp;p1=3D224&amp;=
p2=3D179&amp;p3=3D136&amp;p4=3D37&amp;p5=3D241&amp;p6=3D248</a><br>
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
<a href=3D"https://irclogs.baserock.org/meetings/cip/2020/06/cip.2020-06-25=
-09.00.log.html">https://irclogs.baserock.org/meetings/cip/2020/06/cip.2020=
-06-25-09.00.log.html</a><br>
<br>
Agenda:<br>
<br>
* Action item<br>
&nbsp; 1. Combine root filesystem with kselftest binary - iwamatsu <br>
&nbsp; 2. Post LTP results to KernelCI - patersonc <br>
&nbsp; 3. Issues to be fixed for swupdate &quot;copyright correction and sa=
lsa CI testing&quot; - iwamatsu<br>
<br>
* Kernel maintenance updates<br>
* Kernel testing<br>
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

--_000_OSAPR01MB23850FE26978DA32103B17DCB76D0OSAPR01MB2385jpnp_--

--vymCxUFOZGOkiu2XmB7N
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4881): https://lists.cip-project.org/g/cip-dev/message=
/4881
Mute This Topic: https://lists.cip-project.org/mt/75247269/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--vymCxUFOZGOkiu2XmB7N--
