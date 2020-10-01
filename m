Return-Path: <SRS0=jHfX=DI=lists.cip-project.org=bounce+64572+5488+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CA6C4727C
	for <cip-dev@archiver.kernel.org>; Thu,  1 Oct 2020 05:37:47 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EC6221D7D
	for <cip-dev@archiver.kernel.org>; Thu,  1 Oct 2020 05:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="r49vxEwV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EC6221D7D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5488+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 08YZYY4521723xlzdCudqzE9; Wed, 30 Sep 2020 22:37:45 -0700
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.90])
 by mx.groups.io with SMTP id smtpd.web11.5799.1601530663888252936
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Sep 2020 22:37:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W1Q2uyXC0KypBl8PUxv+p2b52GzvTM7EECEYFVunONtrbTuWgxUMpiYm7N2CiR04prrAgRnR69lHG0XHnDAKG2jim6SresnBstrmFxjh63fRQPDgCkgJGyqW6IRtBnFlMgwAdshPeq3vtb9H49dlORFZEXGqArNLXpNNmVqBK8zLCLMpzNlA/Qgz1DXVtJlLLzLKhLqgWPZcXC5bHV6E4/LNjY5kNTP7zCQHth82jjyrwFrYXdBxWETn3LK3aOmXjCRLqr5dMCkVZ8PT+wkhUjvlc7mIqft8mUk03+ECubMHlUvadT5XVoNmM/7eG1XRzSpBK0SuqGOQquFjbIvIog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/i9NDaHLH+AR/KtwaX6roC7M+oIrq/fbWdlJSFehYI=;
 b=OVxKI0ftEDIYVcffut33rg4QjH6R0gK10tdgQ5pDNj7bQpWntFRnCBT85FtkJv+SnSEd3wUTtjOh1Hf+zlMVXUJ6KbgMqa2mU8CPGtgsJftATkuqCDlUVZ65lc/rAMdiyMBlmiF8FOC5GbHgmqhNSx8O7TnRnKIM6rQBoK1/tFwOo25m+6aNGw8QSpulAH94n7V0yPVWGJOnEQSbByc2ivpO4X1tvHDE3nlNccgrk+ZmoCBDEOt1KuxgFciDHNBfNdv6avhd33aWpoT3z0UjkdTgY8TwLJzbYZX/9VShtgcmula+z6E3LqtUvImQzTIwSrMsRH5HwZ4m/XiKnvvHYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
X-Received: from OSAPR01MB2385.jpnprd01.prod.outlook.com (2603:1096:603:37::20)
 by OSAPR01MB3188.jpnprd01.prod.outlook.com (2603:1096:604:6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34; Thu, 1 Oct
 2020 05:37:40 +0000
X-Received: from OSAPR01MB2385.jpnprd01.prod.outlook.com
 ([fe80::75bc:81cc:bb5:7d50]) by OSAPR01MB2385.jpnprd01.prod.outlook.com
 ([fe80::75bc:81cc:bb5:7d50%6]) with mapi id 15.20.3412.029; Thu, 1 Oct 2020
 05:37:40 +0000
From: "Chris Paterson" <chris.paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdaXiZ+Ncf8e9QV9SjqAlwe7oZ9AYAAKyK7Y
Date: Thu, 1 Oct 2020 05:37:40 +0000
Message-ID: 
 <OSAPR01MB2385CE58C8633519AE64B0C9B7300@OSAPR01MB2385.jpnprd01.prod.outlook.com>
References: 
 <TY2PR01MB49725DFFB3B4CD4E0A1777E0A0300@TY2PR01MB4972.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TY2PR01MB49725DFFB3B4CD4E0A1777E0A0300@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [31.54.191.121]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5054b369-c035-4cb6-15a8-08d865cc1ca9
x-ms-traffictypediagnostic: OSAPR01MB3188:
x-microsoft-antispam-prvs: 
 <OSAPR01MB3188A74FD111EBFE64730451B7300@OSAPR01MB3188.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 KUzbnR5fVK4fgBWqI1lMgMlc4XHwLgjRdOe20VPV1Nt9isY1xHmtKDcAnTnB9gp2S9o/lSJA6euBcR1TKdZqvsCN/DnouJQLLMBdGVZBHOron2LQXWTOMpsa+fdn8jgT/HeFzsGu2j/f0DGYcKM8ZUnYVreJH7TIE/Dd47dliwNM6OTsD3WyEF1vvIDPX882YwTyQ0z062j+1XQpVCVNGqNkKYt1k/wXztBniUJvtq/IwlZdvV8MnXGArul9FwfEbZgyFlGU58jm2riDVNOiAXRC6/kGk4XVUeMQggkP2k/cIDxlm0QH51no7+QQVyarsrgpMmURIHePNGW/ftplwXzIzB4ybT2bUZ1LmFvTKIDNCmvS/kk26DolUO3JTKwr9GkBdf6xhfVKz3S77ZLuDw==
x-ms-exchange-antispam-messagedata: 
 4NLllwWZW+HDe2bkMIFiXyrKTbT94ha5/pc/sfOSuPwHZtRauxVLKSon2uwWCIJNPRhImzQRoqWIuiHixeHabqgY4lp4GpMaG9LIJa8VqdYtKa3Jj5t9aRo9YG8xw1Sh1A/aaNfs3LdTK1XSP6homs4Gx7f6hlxRQQNiUWA1l3ujRCqAm4To/h4JcfEPnjXeaUQmPJpmuuAgW1sLsNg4PORRRXUV4Lz+pngMUa9wlUyw0mpskyfzwDGWu2sn9vxt5UFx1eyFbpxQyPaOWz8knR+A562lTwkLCGUI/0nXrATtVWarpS2dv1LLty+1LFlafSzq1EvEDBeAGgjKWi+gphTZa9RbMWlADBvQF+OEAkm3q2B3RnNPYQEft64YocUb1WqTmx6TBD4rubnjQb9DnM40G2Myn1FWqY0y+DUTaHnA3fE/ZMu4iOyaWX8rawpUtGjohIK6lD0Sc5rrtc7lEQdg7INioejOmBlKiPUNjTjrL53jqH2RMARMuL3j3NU0MsX/40A0O5BtC0NoVgFZUuzCRh3FCYFVRM3B7bnVa2Ts43FDXctjDAggDhh+JWopx6PPwz5aJRM48HZPl/OiJ/ErDlC327cZLOWWIryt1jpw8Iw0+phoOHm/7U5wlTLO7pVU9v4G5OWC5+4Az2Vjiw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB2385.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5054b369-c035-4cb6-15a8-08d865cc1ca9
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2020 05:37:40.0422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gmuKX5MsRieyWdiHvks19yw10MUuhvD9MM9xCePfQLbYdYurI3gwk3yaWujhahf4LDfd+ElG72UlhQEKDo34R4MbKQdeB4tJrDKM0wTh+rw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3188
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: wVxIkUlFPQx9nd2O5tqFEoLDx4520388AA=
Content-Type: multipart/mixed; boundary="QLDksUUvzhrPLzIJJd6Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1601530665;
 bh=J71t5v+1RA8Z0W8yNGh85ZPmYPfWvsc4nuwtH1iVYdw=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=r49vxEwVby/NyMwCREkz0paK4ZvAWUCUirGB5S8EE9Sdm/6ZCCbmYOppD849hTfay3c
 HHk7P1RX8BjUJur262dr2mp1vqos8u+hbKKvlkZbiXi/HVVQSRtHtXIOfPKZpy0vWM0Pv
 Kc/VqDHc/ddRNL03jF6SWHiyWe8tNsSRzks=

--QLDksUUvzhrPLzIJJd6Y
Content-Language: en-GB
Content-Type: multipart/alternative;
	boundary="_000_OSAPR01MB2385CE58C8633519AE64B0C9B7300OSAPR01MB2385jpnp_"

--_000_OSAPR01MB2385CE58C8633519AE64B0C9B7300OSAPR01MB2385jpnp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello Kudo-san,

Please accept my apologies for today's meeting.

From testing the only update I have is that lab-cip-renesas is back online =
now.

Kind regards, Chris
________________________________
From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> on beha=
lf of masashi.kudo@cybertrust.co.jp via lists.cip-project.org <masashi.kudo=
=3Dcybertrust.co.jp@lists.cip-project.org>
Sent: Thursday, October 1, 2020 1:27:21 AM
To: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2020&mont=
h=3D10&day=3D1&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&=
p5=3D241&p6=3D248

USWest  USEast  UK      DE      TW      JP
02:00   05:00   10:00   11:00   17:00   18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2020/09/cip.2020-09-24-09.00.log.=
html

Agenda:

* Action item
  1. Combine root filesystem with kselftest binary - iwamatsu
  2. Check whether CVE-2020-25284 needs to be backported to 4.4-rt
      ->  Delete rbd ( Ceph block device ) from 4.4-rt x86 config - iwamats=
u

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

--_000_OSAPR01MB2385CE58C8633519AE64B0C9B7300OSAPR01MB2385jpnp_
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
Please accept my apologies for today's meeting.<br>
<br>
</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
From testing the only update I have is that lab-cip-renesas is back online =
now.<br>
</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
<span id=3D"ms-outlook-android-cursor"></span><br>
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
<b>Sent:</b> Thursday, October 1, 2020 1:27:21 AM<br>
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
=3D2020&amp;month=3D10&amp;day=3D1&amp;hour=3D9&amp;min=3D0&amp;sec=3D0&amp=
;p1=3D224&amp;p2=3D179&amp;p3=3D136&amp;p4=3D37&amp;p5=3D241&amp;p6=3D248">=
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2020&amp;=
month=3D10&amp;day=3D1&amp;hour=3D9&amp;min=3D0&amp;sec=3D0&amp;p1=3D224&am=
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
<a href=3D"https://irclogs.baserock.org/meetings/cip/2020/09/cip.2020-09-24=
-09.00.log.html">https://irclogs.baserock.org/meetings/cip/2020/09/cip.2020=
-09-24-09.00.log.html</a><br>
<br>
Agenda:<br>
<br>
* Action item<br>
&nbsp; 1. Combine root filesystem with kselftest binary - iwamatsu <br>
&nbsp; 2. Check whether CVE-2020-25284 needs to be backported to 4.4-rt<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&gt;&nbsp; Delete rbd ( Ceph block device )=
 from 4.4-rt x86 config - iwamatsu <br>
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

--_000_OSAPR01MB2385CE58C8633519AE64B0C9B7300OSAPR01MB2385jpnp_--

--QLDksUUvzhrPLzIJJd6Y
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5488): https://lists.cip-project.org/g/cip-dev/message=
/5488
Mute This Topic: https://lists.cip-project.org/mt/77230659/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--QLDksUUvzhrPLzIJJd6Y--
