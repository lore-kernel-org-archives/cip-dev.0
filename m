Return-Path: <hunterrafuse@outlook.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C021C07CA9
	for <webhook@archiver.kernel.org>; Thu, 30 Nov 2023 12:59:53 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (NAM10-BN7-obe.outbound.protection.outlook.com [40.92.40.32])
 by mx.groups.io with SMTP id smtpd.web10.71476.1701349187875966269
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Nov 2023 04:59:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@outlook.com header.s=selector1 header.b=ouqMbbfe;
 spf=pass (domain: outlook.com, ip: 40.92.40.32, mailfrom: hunterrafuse@outlook.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WvYd5tHz7xuSTxbxUl453t057uGIAAFNl6Erognmcfi1koxbzPv7Iuz+DJTbqgDNAhqAQAmNWxJBn1TF6lulHJC7drPgqT2aKgsRoMNnVL+FWgevbh5cgkK8f6eOcgL7H/Mrp6e3fflGPKoPgTunDLz+CimXZiZCu97ESIVEH9DVUdWLFfc1h1nEu75xHLqYcDY09ijN1i3kbDsSVfuLNjBKdpSprPhVH95Rb/8v1yrjOd/29pIHh6U9NnvqumI/czlztdfSdSe+Wxddd3KYwNR/b7RyY9YP6FLAtudUFTW5M1tCCh9uvbyVsmPwmigGo2/FLDZqjwP6VfOTiLcIzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jiFznIWdHzqvOCju7F285MNp1eF/0njnzrhyOhd1tw8=;
 b=lF7sTWOa7l1EIftp0khLYNvKugnSX51EKI2kYjla4lcsITXnMN6bjUEclCgD2wFA1IDE3/lXYH8zJkrSkUS7DnkpsljGcgpSEiNiw2pH/hArDFmLN85aexI4WpjfuNoOWk9Z54phb/c1axMU8OYsnCBh4CcM61exa+h5L3pLDV3f0188fUYhkqXtbXUamV8MENf+e2T63o6O8u+e2JYmf2PMoaCynU40U46x3ZNjm4u5+478zhVbUcX+bcmDt6Mk0cSEC+gjaZBYCZenfI0/p3w6RirCLhkLSnda4C7/EQIDW+VY/zkSrpslcY2Q0GPhb2Q8hquvegE0HPi8mGLjkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jiFznIWdHzqvOCju7F285MNp1eF/0njnzrhyOhd1tw8=;
 b=ouqMbbfe9/Z+uSjYxqeZNoAtwXGy5EE5B3cMOj4g1inuTtw6++PjPIOd0N9Z+pDro2r8nRXRXtuXc76DFyzs2XO7TkHpqHR23psbt6GxOrsOTs/yq2OszJSCjk9EVYyTGa/EYq97Pnarq4yzkPnoBwhZh47O8wIHbYLB26J21iUthpRdh0P3wLrq78Z9EXePO+onQbIgwXpyv5u5NCwfA/3KkaMFOe6a2CsZwLPiEJbrl3gckTsRrWJtQtC9x8T0t850itMXrcbslyqPvQmFf5L8z/09JdJS+cv1V478KAVSuqOpdcS3h42wyBQc8N+yZ2v6Kje5LyYzHDJmNw7lzQ==
Received: from PH0P221MB0829.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:fb::19)
 by BL3P221MB0308.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:353::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 12:59:45 +0000
Received: from PH0P221MB0829.NAMP221.PROD.OUTLOOK.COM
 ([fe80::c243:482e:36be:2c72]) by PH0P221MB0829.NAMP221.PROD.OUTLOOK.COM
 ([fe80::c243:482e:36be:2c72%3]) with mapi id 15.20.7025.022; Thu, 30 Nov 2023
 12:59:45 +0000
From: Hunter Rafuse <hunterrafuse@outlook.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: CIP IRC weekly meeting today on libera.chat
Thread-Topic: CIP IRC weekly meeting today on libera.chat
Thread-Index: AdojIMCACGW8+6s9Sn+/g1KMONtdJQAbDIKK
Date: Thu, 30 Nov 2023 12:59:45 +0000
Message-ID: 
 <PH0P221MB08291DD20079EFF580ECFFDADA82A@PH0P221MB0829.NAMP221.PROD.OUTLOOK.COM>
References: 
 <TYVPR01MB11245D394C0EABD39E9241E149282A@TYVPR01MB11245.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYVPR01MB11245D394C0EABD39E9241E149282A@TYVPR01MB11245.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-tmn: [z/7S1J/z3Wf7Yw4iWx6wP+bgf0jwkWW1]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0P221MB0829:EE_|BL3P221MB0308:EE_
x-ms-office365-filtering-correlation-id: dcaa1228-c384-44f1-7143-08dbf1a439d6
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 7nSOmBsyGvSHw9FajkILhLtXwetfeIETCHJKhZ6kGPbSjPyu+/Ih+C+RlZQPH3ciKwutZVyFu4BFRLqAxP9Lzx7G5/ccXtKG5fHQQp+57ibEfGX2OQD9j/ETLa1VUYk5+lQFpg+DicDyMYAr88r/46tJpnsPk//jfMz4H/4k7tTLF96wkn9tJpIOlygV3Fxl1EIj6rvcDqQ7efPaW+Cd2Tsa8vPzyMj8cVTBd6+7Zcx4dirFkNWpBkZIRccsTk6aJQ/GK4ONsbB5qcAjQOMagLgmlHwCkLUqYMAnI/bhP0sRTrToamnJK3ZRukEaC7B8F6f+54R2EfhYz00TdR1ZkcMQLYhM73IfDKReNZtdHetGj0EO59s0XpckbRRqIt3Juii5G2QUtQMWedJZV0RxDwj9O0aItGId0CO5Pwjf+Vw7Mp6sPCsq/nbaK6YAH0N6gh+uyx0v+br+4nfgxQ9nXyr5vsszrjdUTo01Jj/o1zC3NBblDEQrkcOW6ZGXQS9LxFpSNX9nFZZoQiQfuDFuFhPHp794pCpOySWcmLsbVxJkJuO9d15HneOEKtMcQBn0EcRvn+FoWr/hMH5qJUnFyKOJPU7ywF8cxJ2OWLseOjxsLrXRT3ZxvuJ2OoAnuN3r
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?qKj0tczpJ8mROSrMSKOEiyjcui+5hmx+8ma+ymL4pZvX/WuoSY39mm/qX2Us?=
 =?us-ascii?Q?CThTuxpozhgScE2DuYjZeOMCHKv1VjoYOG+2sx7VJttJvYcL611o9MSRf1Kh?=
 =?us-ascii?Q?L+iSbTpmJwzF6Tp7Gwa7Q3Oys7Wczge7iiQn05xo0hO4/rSopVbyfo5AxDmM?=
 =?us-ascii?Q?2d+G4osV/0KGmdhDx3oTt8BTNUHKeaWPWOk/4qSqF62mKYVKI321d/S391k7?=
 =?us-ascii?Q?uO/MAe3ikKZxlLdHgfKA0KIUj3uLWfLYQpgzVa67npIoGjAKPxofnuA17N/v?=
 =?us-ascii?Q?1B1Nf9Qo7ucvLZlVa9etyxkrBqxdTqBb8cCZtCSaUVo5XWiy/fomO48RBKNc?=
 =?us-ascii?Q?V192ObJSkKlrRklGCAQBB/B5we90RCyFVcUpIXgmlCJdEuO7hldZL0pPK4eN?=
 =?us-ascii?Q?9IkDyH76gN7nBy2JwJPNsOHFbX+RKCZ7CtLA4Ym7ZiTbMjMFjXEVAXUKhIE9?=
 =?us-ascii?Q?q7FlMfBItJ08zMEoP9ywWYsytlAZf+wtDmJTsW0OKvRMiRct9GXAQqhFtu7D?=
 =?us-ascii?Q?toNy6PjAO8NyBXS33muZMsYcrDTh55h6CfAuKSqB71g2/JMu6cWd4NFGHhym?=
 =?us-ascii?Q?Fglx2Xzr+uLKS+P9InCdH28a0khA9rfLihGzI6a0N+b2HQTtKXvLRNzren/U?=
 =?us-ascii?Q?WXAKT2YHW+jpWstCAovNjGUphsMH0M4FK/Vdzaw0HYkBRG5zDEQNdxTTNJN0?=
 =?us-ascii?Q?3HVFycsofmTNcxiRBC6jcEQcmXyM63+LeeV2e31eE/yHTjgYaTG8mluWWU5+?=
 =?us-ascii?Q?YjNPufvvLgPQ+hrT2dMiyatUq+EOStMWW9ITjcF8KxG8krgLpu5w1hlkMdMI?=
 =?us-ascii?Q?ToxraHOrrY8EhvwWhtKh5vjvqo7Brk2sONSSgsje63m+F2HZO98RnTT6LKaA?=
 =?us-ascii?Q?dsGX7xF3WM/9ssZNaBpyB8AFEF5pO65zXNrg1z3IHkJFuTZDxw5kYJBBI/li?=
 =?us-ascii?Q?3EW2xmfVq/hnrAkIrSm3a3gE1sPnbAA4NpibD0UgkGRNnz3U7IOESnaZ+p5e?=
 =?us-ascii?Q?Br7aRRoVLucSzTh2nt0lrNp7SqTWmIpwfZRodBHXiX1+4TaKsshTpQBffBRT?=
 =?us-ascii?Q?K4XHJu6y6ng+OtON1yHlxNYvf8cI0n9YdzIEZzfBqg05ukEG4fNGhY7otWEC?=
 =?us-ascii?Q?8lhT3QYYjSyXlYisIfA3j62PwTGa4mTbBJmt4paZv3XHC2coisMahcNl/hL4?=
 =?us-ascii?Q?EZf2DfpHNvIAiF6ectmykyAHr1VbtNh3jiXWJ2Rg1EPrmOV5rfLkrkjf5MU?=
 =?us-ascii?Q?=3D?=
Content-Type: multipart/alternative;
	boundary="_000_PH0P221MB08291DD20079EFF580ECFFDADA82APH0P221MB0829NAMP_"
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0P221MB0829.NAMP221.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: dcaa1228-c384-44f1-7143-08dbf1a439d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2023 12:59:45.0108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3P221MB0308
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Nov 2023 12:59:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13764

--_000_PH0P221MB08291DD20079EFF580ECFFDADA82APH0P221MB0829NAMP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,

I will unfortunately not be able to attend today's meeting.

With friendly regards,
Hunter Rafuse
________________________________
From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> on beha=
lf of Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Sent: Thursday, November 30, 2023 2:05:22 AM
To: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today on libera.chat

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2023&mont=
h=3D11&day=3D16&hour=3D13&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D3=
7&p5=3D241&p6=3D248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2023/11/cip.2023-11-09-1=
3.02.log.html
* Action items
* Kernel maintenance updates
* Kernel release status
  - 4.4
  - 4.19
  - 5.10
  - 6.1
* Kernel testing
* AOB

Best regards,
  Nobuhiro


--_000_PH0P221MB08291DD20079EFF580ECFFDADA82APH0P221MB0829NAMP_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<div dir=3D"auto">Hello,</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">I will unf<span>ortunately not be<span> able to attend to=
day's meeting.<span></span></span></span></div>
<div dir=3D"auto"><span><span><br>
</span></span></div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto">
<div dir=3D"auto">With friendly regards,<span></span></div>
<div dir=3D"auto">Hunter Rafuse&nbsp;</div>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> cip-dev@lists.cip-pro=
ject.org &lt;cip-dev@lists.cip-project.org&gt; on behalf of Nobuhiro Iwamat=
su &lt;nobuhiro1.iwamatsu@toshiba.co.jp&gt;<br>
<b>Sent:</b> Thursday, November 30, 2023 2:05:22 AM<br>
<b>To:</b> cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-project.org&=
gt;<br>
<b>Subject:</b> [cip-dev] CIP IRC weekly meeting today on libera.chat</font=
>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi all,<br>
<br>
Kindly be reminded to attend the weekly meeting through IRC to discuss<br>
technical topics with CIP kernel today. Our channel is the following:<br>
<br>
&nbsp;&nbsp;&nbsp; irc:irc.libera.chat:6667/cip<br>
<br>
The IRC meeting is scheduled to UTC (GMT) 13:00:<br>
<br>
<a href=3D"https://www.timeanddate.com/worldclock/meetingdetails.html?year=
=3D2023&amp;month=3D11&amp;day=3D16&amp;hour=3D13&amp;min=3D0&amp;sec=3D0&a=
mp;p1=3D224&amp;p2=3D179&amp;p3=3D136&amp;p4=3D37&amp;p5=3D241&amp;p6=3D248=
">https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2023&am=
p;month=3D11&amp;day=3D16&amp;hour=3D13&amp;min=3D0&amp;sec=3D0&amp;p1=3D22=
4&amp;p2=3D179&amp;p3=3D136&amp;p4=3D37&amp;p5=3D241&amp;p6=3D248</a><br>
<br>
USWest&nbsp;&nbsp;&nbsp; USEast&nbsp;&nbsp;&nbsp; UK&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; DE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TW&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; JP<br>
05:00&nbsp;&nbsp;&nbsp;&nbsp; 08:00&nbsp;&nbsp;&nbsp;&nbsp; 13:00&nbsp;&nbs=
p;&nbsp;&nbsp; 14:00&nbsp;&nbsp;&nbsp;&nbsp; 21:00&nbsp;&nbsp;&nbsp;&nbsp; =
22:00<br>
<br>
Last meeting minutes:<br>
<a href=3D"https://ircbot.wl.linuxfoundation.org/meetings/cip/2023/11/cip.2=
023-11-09-13.02.log.html">https://ircbot.wl.linuxfoundation.org/meetings/ci=
p/2023/11/cip.2023-11-09-13.02.log.html</a><br>
* Action items<br>
* Kernel maintenance updates<br>
* Kernel release status<br>
&nbsp; - 4.4<br>
&nbsp; - 4.19<br>
&nbsp; - 5.10<br>
&nbsp; - 6.1<br>
* Kernel testing<br>
* AOB<br>
<br>
Best regards,<br>
&nbsp; Nobuhiro<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_PH0P221MB08291DD20079EFF580ECFFDADA82APH0P221MB0829NAMP_--

