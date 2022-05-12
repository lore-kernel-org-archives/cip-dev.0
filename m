Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1253DC433F5
	for <webhook@archiver.kernel.org>; Thu, 12 May 2022 06:51:51 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.118])
 by mx.groups.io with SMTP id smtpd.web09.1269.1652338306107994300
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 May 2022 23:51:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=jeSo/PtV;
 spf=pass (domain: renesas.com, ip: 40.107.114.118,
 mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eebt2DWUtRD+jKAxUyioN+Azo+RfoorjV9rKMBxSg9PzD7wq5FoeqQBiEvKp9XQtPj4e8oLr6NCMXPFvcHg5PVr1LljEbrz9U9Wxoq9IHdyPJieW9UYQLCgN6eobgV/2GsDVVZQzpzIyXckMoiIw9Unfao1ucrhmxHNRC2u+mFivlftFyVlbBlVl4/2cG0Vg1Ob7wzmL3vkkakVcU3BsdHbXgrJR682Z0TV727G5/VXBtoLhepT27biSWMMq0LF2qpBKJ3LOme7B+VlW51JnV04BZlezaxJz4l1jYxtLBMKq5WxWT7QRJYAtlrz1CQjpl9C5hvpu5jsYC1ISHiOERQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L33ys80wJsGvd/ZWAtBKNIPlGsV6ZChDCFF9Tdp8sAc=;
 b=D6auAJlIMXfXw3dbnFRo2DYTA6QTEDklrVBoLp8VdpVVedQHEGBYgleAqCqFfU5n6IlG7OhEnbAjgEXI7w/zFQxPq+yGNwl+m6T7pTDPfB5D7AqeYgV9gz9UIxJFRwD7vpsKVG8TvAOs0qcFuPV9Azfxf9ZwxKoMdutn1MaSii1UKjrjybRpN+36HSJ0Jpikx3xrn7jegKkb78FIPTYH7XR1Swt6BDDZ420+hVlww3bBplvLHNPUvLL4Nmk3HyKH0OrWi+CAJcPKRMojBKWD7D8eFzGxnFn7ZhPUWnap7Rp6insuKiYnieMNKgZVvd5w4RG9LuZ9uiKF2vvu2hDLHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L33ys80wJsGvd/ZWAtBKNIPlGsV6ZChDCFF9Tdp8sAc=;
 b=jeSo/PtVrgC8BVYC91SisQg0waLzzrBiSfaLWAvkLYwO7cD7ggvmbda0EO/U11INEjKXIVPwG5FFFmjwa5KlvZtYvuYNzDl8IkIrXv71MiY7XDQUqiraTa8WPefXcfKVT0wdkCO2BraCSBK3Uu65qlElN6L2yROL0XNVe1TTHtg=
Received: from OSZPR01MB8124.jpnprd01.prod.outlook.com (2603:1096:604:164::6)
 by OSBPR01MB3093.jpnprd01.prod.outlook.com (2603:1096:604:17::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Thu, 12 May
 2022 06:51:41 +0000
Received: from OSZPR01MB8124.jpnprd01.prod.outlook.com
 ([fe80::9198:5a5e:9c13:9227]) by OSZPR01MB8124.jpnprd01.prod.outlook.com
 ([fe80::9198:5a5e:9c13:9227%5]) with mapi id 15.20.5250.014; Thu, 12 May 2022
 06:51:40 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Topic: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Index: AQHYZccX4oAbXHY3qEqsjfgO9OedzK0azaeA
Date: Thu, 12 May 2022 06:51:40 +0000
Message-ID: 
 <OSZPR01MB81244D16871FED4B2C444138B7CB9@OSZPR01MB8124.jpnprd01.prod.outlook.com>
References: <3ce4350a-d5a9-0d46-56c0-efcc76d53ed2@siemens.com>
In-Reply-To: <3ce4350a-d5a9-0d46-56c0-efcc76d53ed2@siemens.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 744ceda8-f195-4100-4c52-08da33e3de16
x-ms-traffictypediagnostic: OSBPR01MB3093:EE_
x-microsoft-antispam-prvs: 
 <OSBPR01MB3093AB08DE85864437D17F85B7CB9@OSBPR01MB3093.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 3KEvK3RCaTJWPd5Q5QeOU2E9DRWpEfTrnVd1TbUzNx2RPfYscdlAd4gqCJfg6FYiMJlmkthtN1rd3i95ZPIqNnrG0F5c5kz1DTIZ6ww5GpceKMliJidEnNiUEuLNriOuifaY/RsyQserNvDwhDDOjXRKwhCIgk+NZjxmZOJRlvPHgJPJPJK+7LNm/ROABH61MP4hILzu6lluRQn1BgVFuUPZqWurpq9V7NaxqeZC/HWQUe2gfR3iQSFodcpCzAqFAwEPI+HBlpCke1VHcqySL8XippyhH7AT09NvvvPUbZp+lUElNEf8Qx9zVKCuj/DUBHq42ayiA3tWJx4JaHg82w96SpNgLw86pBUMv+wS7WDHWnitogQyGpEulfW0vUfNDt8w2YKqntROo+YBtKnDvo75OnkNO9Sd2eCWXQFvmrNSDM7TIVpUVnaI5Ylc/NbiFuw7YHIA46md/CJ99ipf5aNwH3rTSeCNk/G3z8BJzeqM2lsFy1ecGIHqzUTewTnnSBWxv5KbYwTCfjgDfr6p/bLuXa3e7XummoyPPIpGBUBoYcz7DVNofkrNcLNH513BfX4+7T8Ib3Tt3x7zCGv+JkN6XJl81JKqQHszXDGZ+ywp5KQqRJLrKk3QzLZ0zzr4rbdQo6p9HoEsGSLEMlTXQwfpNxjyvyRd66qhHvgIontzJj37tYNfftHwIKRw77S348wqQ5ccKq06KxygyvbTWrV36ME5YUrdXN51nobEs88ZgId2RtHSt+JwdYj5uPxJ4JJOvDDx2s3kKzdC0sYZ076gmfauQsNtbfTY9+ZG2BU=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8124.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(91956017)(8676002)(55016003)(71200400001)(508600001)(45080400002)(316002)(966005)(33656002)(86362001)(83380400001)(66946007)(76116006)(66476007)(66556008)(66446008)(64756008)(8936002)(166002)(5660300002)(38100700002)(122000001)(26005)(186003)(9686003)(7696005)(6506007)(52536014)(38070700005)(2906002)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?oGfamqOtO2iL306CJqSIwT7conyRQLHY0Hgh4OWeYBTgrEIQuBtAIVRHYwjI?=
 =?us-ascii?Q?N4ArCk6Vd++4w734U9BJ/2hRLj4nIAQP5AWXbRGRnr0u/BfNhBDIsCQKz9vf?=
 =?us-ascii?Q?KYgkSKEwCKbqKBDsA0ZGMXU+8pT/j0F0HiIbD5YsGA6nOUOhbQIjkZZc/xoR?=
 =?us-ascii?Q?kVOi1tnmQlRfHw/SjQYoV8ii2Y6qL6tWZUwKtZfddwkEyAsizLRFe55/Bl6P?=
 =?us-ascii?Q?86qMCKNadDgeFCk/j7iaQNit1TJK12fwukhgxJ+AAwpwSrwJA73jqY+iej8p?=
 =?us-ascii?Q?54uzNUTsxh/lm8QWrhSN3h7PxxE7VZKI6V5yIFF8bR+Xh1bOS3spczI3nvtK?=
 =?us-ascii?Q?elpHrY8fetWlUEtUQkOQ6YAqFaYagKqmQiE2iksLAzJBCuZl/ca8N+FfEYLA?=
 =?us-ascii?Q?2pFiht+ae/xLijdpA6WIOEukR7SXp43s0K/1abR7FRCJkz0eG9naULtOlqig?=
 =?us-ascii?Q?i/CYXwdNFEBbUlKYJJF/BsMHaD7sYjIa/37AbXy9pnlrS/6xF/HMa2kTTVDc?=
 =?us-ascii?Q?hjMeKe9JiK+XdALh4wU+KnUmMzqan/DJ1d9rD6aLYgya3r4FceGFN9DgmYRW?=
 =?us-ascii?Q?vY6t3L4fxt/IFlAuReJ0aYnjbT3fUDAVidRAgMUICRsDaaX+F57s7nGxdjxB?=
 =?us-ascii?Q?Nb9kht0Pcu8JdYmf5G/tNNAjqpf1u25/rieUhlUgQ7DemrzgJI3cq+47Geyi?=
 =?us-ascii?Q?dKT76UcYTJnWjjQCWBk1DUEhSJRxyXw9MpK+T0aL+M3Kw0I1CoJD4+Y6W3uz?=
 =?us-ascii?Q?XIwpnVA0BGJ6gS2y1XtfWgKsKJwQP9jvvpt01RiorSpFySFs9u5lj9Fad1/7?=
 =?us-ascii?Q?XGo9o3uFOxnguh1fsDxob0KzNlke+fheXwGlCn7rBH1T1ut6nnnCWlmhr4w0?=
 =?us-ascii?Q?UO5HVoxCxms9ddPQQ72/UcKhZrs+m4JC5TsPajF8HdBze7UGTpDcSmvAgFKI?=
 =?us-ascii?Q?feSkOQKnSMS6XvKP9oGWVl87iUKld0dVhUU2bV5/Zlwfu2lMDMZIB+o2Z7aC?=
 =?us-ascii?Q?eOfxPY2UaoyRydABAlz5kVd8NRcM9WHhYawfIXUCZGeFzUMi4PYoIMUAry9I?=
 =?us-ascii?Q?aFnuwHiqayRX/IUAh3EXTK4pqBgN1sFShUdUI3devj6h6mE9t1Yw7VGKG4QN?=
 =?us-ascii?Q?vNZWi1ECHschl6+R11mP4dcgLRsACuBq7fcRWye1solgARr3C0VbUxx39p9T?=
 =?us-ascii?Q?G6UbgcJm1JA8FAZlk2ky5I6VUtR9/kyxpeffRc0NbWwufZ1dm57SvPt94md/?=
 =?us-ascii?Q?FNc8dJROBt/hywER34gh4UzauUE4lbmqcdlSIeFINCLDH0pbBuikvNtiqUD0?=
 =?us-ascii?Q?dPQQ1h68NNH2k89fFYHxrhI1Jxs7gwDfjHNSXYlQ2CZIvsBmDRcIeayOillJ?=
 =?us-ascii?Q?5x+9eECyWvZWgDr2Ztg1Luuq/hTUSKeHhcNYm6GJdEbIdYSFT8Nc4sXx87tB?=
 =?us-ascii?Q?zxW+mNvU5+utJEc6sBWgkOvOG8xKamJyodDGrEvrybqUX1W76sj6KCAii7rH?=
 =?us-ascii?Q?Y+2ohKBEDQ41Pzf3mw1zLH2RYbzTz3oPV9Wjn99uEteP9rd9v1GW4FCwIvtv?=
 =?us-ascii?Q?fUXYlajGVbcZMnXRz++2CcMJSBfuyVDXTWKh8cacqdusJxPJwj8FCKBY5atD?=
 =?us-ascii?Q?Q9C/9dVXg3zwXm+k8f7+zQ5ZaGQKC8ZABT4u3YDfdTalBRZQZa2PPb0McPKn?=
 =?us-ascii?Q?rguP7+UMq5o8DCsu0dy38yItrotGo+5dE4hmg5fppYFnbD0vUusujfbmDsFq?=
 =?us-ascii?Q?Yb39Ruba0JMXw2F2OCij2MXcig/sXb4Kgp/seO0Lp9KznYjUpinW?=
Content-Type: multipart/alternative;
	boundary="_000_OSZPR01MB81244D16871FED4B2C444138B7CB9OSZPR01MB8124jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8124.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 744ceda8-f195-4100-4c52-08da33e3de16
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2022 06:51:40.2786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 FdaCTTCs1DVTOsdsaT1d0eKkcywO/bpKY8L8+jU0AF1O6GYiTligqTQuxHo/g9YzKUHP4RU6G4OG8971RN7uclWu8dN1pH+HVdLqO4HyNhs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3093
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 12 May 2022 06:51:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8325

--_000_OSZPR01MB81244D16871FED4B2C444138B7CB9OSZPR01MB8124jpnp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello Jan,

Please accept my apologies for today's meeting. I am on leave today.

No major updates from me.

Kind regards, Chris
________________________________
From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> on beha=
lf of Jan Kiszka via lists.cip-project.org <jan.kiszka=3Dsiemens.com@lists.=
cip-project.org>
Sent: Thursday, May 12, 2022 7:10:53 AM
To: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today on libera.chat

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.tim=
eanddate.com%2Fworldclock%2Fmeetingdetails.html%3Fyear%3D2022%26month%3D5%2=
6day%3D12%26hour%3D12%26min%3D0%26sec%3D0%26p1%3D224%26p2%3D179%26p3%3D136%=
26p4%3D37%26p5%3D241%26p6%3D248&amp;data=3D05%7C01%7Cchris.paterson2%40rene=
sas.com%7C1be4f5b4803246505a0e08da33de38f5%7C53d82571da1947e49cb4625a166a4a=
2a%7C0%7C0%7C637879326780814444%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDA=
iLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=
=3D9SSJ98WptpMp6Oc58X7BhAexTPVOLJbFuLGZZoUNYeY%3D&amp;reserved=3D0

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fircbot.=
wl.linuxfoundation.org%2Fmeetings%2Fcip%2F2022%2F05%2Fcip.2022-05-05-12.01.=
log.html&amp;data=3D05%7C01%7Cchris.paterson2%40renesas.com%7C1be4f5b480324=
6505a0e08da33de38f5%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C6378793267=
80814444%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTi=
I6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DnS1YpXxrEz0w%2FbiSLjTk=
IQIwSpbwWBV17H5e%2FLp66xA%3D&amp;reserved=3D0

* Action items
  1. Resolve/filter irrelevant failures of KernelCI for 4.4-cip - patersonc=
 & alicefm
  2. Document CIP kernel release cadence in wiki
* Kernel maintenance updates
* Kernel testing
* AOB

Jan


--_000_OSZPR01MB81244D16871FED4B2C444138B7CB9OSZPR01MB8124jpnp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<div dir=3D"auto">Hello Jan,</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">Please accept my apologies for today's meeting. I am on l=
eave today.</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">No major updates from me.</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">Kind regards, Chris</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> cip-dev@lists.cip-pro=
ject.org &lt;cip-dev@lists.cip-project.org&gt; on behalf of Jan Kiszka via =
lists.cip-project.org &lt;jan.kiszka=3Dsiemens.com@lists.cip-project.org&gt=
;<br>
<b>Sent:</b> Thursday, May 12, 2022 7:10:53 AM<br>
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
The IRC meeting is scheduled to UTC (GMT) 12:00:<br>
<br>
<a href=3D"https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Fwww.timeanddate.com%2Fworldclock%2Fmeetingdetails.html%3Fyear%3D2022%26=
month%3D5%26day%3D12%26hour%3D12%26min%3D0%26sec%3D0%26p1%3D224%26p2%3D179%=
26p3%3D136%26p4%3D37%26p5%3D241%26p6%3D248&amp;amp;data=3D05%7C01%7Cchris.p=
aterson2%40renesas.com%7C1be4f5b4803246505a0e08da33de38f5%7C53d82571da1947e=
49cb4625a166a4a2a%7C0%7C0%7C637879326780814444%7CUnknown%7CTWFpbGZsb3d8eyJW=
IjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C=
%7C&amp;amp;sdata=3D9SSJ98WptpMp6Oc58X7BhAexTPVOLJbFuLGZZoUNYeY%3D&amp;amp;=
reserved=3D0">https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3=
A%2F%2Fwww.timeanddate.com%2Fworldclock%2Fmeetingdetails.html%3Fyear%3D2022=
%26month%3D5%26day%3D12%26hour%3D12%26min%3D0%26sec%3D0%26p1%3D224%26p2%3D1=
79%26p3%3D136%26p4%3D37%26p5%3D241%26p6%3D248&amp;amp;data=3D05%7C01%7Cchri=
s.paterson2%40renesas.com%7C1be4f5b4803246505a0e08da33de38f5%7C53d82571da19=
47e49cb4625a166a4a2a%7C0%7C0%7C637879326780814444%7CUnknown%7CTWFpbGZsb3d8e=
yJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C=
%7C%7C&amp;amp;sdata=3D9SSJ98WptpMp6Oc58X7BhAexTPVOLJbFuLGZZoUNYeY%3D&amp;a=
mp;reserved=3D0</a><br>
<br>
USWest&nbsp;&nbsp;&nbsp; USEast&nbsp;&nbsp;&nbsp; UK&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; DE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TW&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; JP<br>
05:00&nbsp;&nbsp;&nbsp;&nbsp; 08:00&nbsp;&nbsp;&nbsp;&nbsp; 13:00&nbsp;&nbs=
p;&nbsp;&nbsp; 14:00&nbsp;&nbsp;&nbsp;&nbsp; 20:00&nbsp;&nbsp;&nbsp;&nbsp; =
21:00<br>
<br>
Last meeting minutes:<br>
<a href=3D"https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Fircbot.wl.linuxfoundation.org%2Fmeetings%2Fcip%2F2022%2F05%2Fcip.2022-0=
5-05-12.01.log.html&amp;amp;data=3D05%7C01%7Cchris.paterson2%40renesas.com%=
7C1be4f5b4803246505a0e08da33de38f5%7C53d82571da1947e49cb4625a166a4a2a%7C0%7=
C0%7C637879326780814444%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjo=
iV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;amp;sdata=3DnS1=
YpXxrEz0w%2FbiSLjTkIQIwSpbwWBV17H5e%2FLp66xA%3D&amp;amp;reserved=3D0">https=
://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fircbot.wl.li=
nuxfoundation.org%2Fmeetings%2Fcip%2F2022%2F05%2Fcip.2022-05-05-12.01.log.h=
tml&amp;amp;data=3D05%7C01%7Cchris.paterson2%40renesas.com%7C1be4f5b4803246=
505a0e08da33de38f5%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C63787932678=
0814444%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI=
6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;amp;sdata=3DnS1YpXxrEz0w%2FbiSL=
jTkIQIwSpbwWBV17H5e%2FLp66xA%3D&amp;amp;reserved=3D0</a><br>
<br>
* Action items<br>
&nbsp; 1. Resolve/filter irrelevant failures of KernelCI for 4.4-cip - pate=
rsonc &amp; alicefm<br>
&nbsp; 2. Document CIP kernel release cadence in wiki<br>
* Kernel maintenance updates<br>
* Kernel testing<br>
* AOB<br>
<br>
Jan<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_OSZPR01MB81244D16871FED4B2C444138B7CB9OSZPR01MB8124jpnp_--

