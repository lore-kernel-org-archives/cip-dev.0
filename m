Return-Path: <SRS0=0PoC=BP=lists.cip-project.org=bounce+64572+5100+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDAD4C433E3
	for <cip-dev@archiver.kernel.org>; Wed,  5 Aug 2020 09:23:48 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 622CB20792
	for <cip-dev@archiver.kernel.org>; Wed,  5 Aug 2020 09:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Ia1qNTcu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 622CB20792
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5100+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id idhCYY4521723xcs4ypW7Q4T; Wed, 05 Aug 2020 02:23:48 -0700
X-Received: from gw-eagle1.siemens.com (gw-eagle1.siemens.com [194.138.20.72])
 by mx.groups.io with SMTP id smtpd.web11.3538.1596619426095046641
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Aug 2020 02:23:47 -0700
X-Received: from mail1.dc4ca.siemens.de (mail1.dc4ca.siemens.de [139.25.224.78])
	by gw-eagle1.siemens.com (Postfix) with ESMTPS id 338C04F00BD;
	Wed,  5 Aug 2020 11:23:42 +0200 (CEST)
X-Received: from DEMCHDC8A0A.ad011.siemens.net (demchdc8a0a.ad011.siemens.net [139.25.226.106])
	by mail1.dc4ca.siemens.de (Postfix) with ESMTPS id CBA1815E93800;
	Wed,  5 Aug 2020 11:23:42 +0200 (CEST)
X-Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Wed, 5 Aug 2020 11:23:40 +0200
X-Received: from DEMCHDC8A0A.ad011.siemens.net ([139.25.226.106]) by
 DEMCHDC8A0A.ad011.siemens.net ([139.25.226.106]) with mapi id 15.01.2044.004;
 Wed, 5 Aug 2020 11:23:40 +0200
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: "daniel.sangorrin@toshiba.co.jp" <daniel.sangorrin@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Kiszka, Jan" <jan.kiszka@siemens.com>
Subject: Re: [cip-dev] [isar-cip-core] remove remaining configs from isar-cip-core
Thread-Topic: [cip-dev] [isar-cip-core] remove remaining configs from
 isar-cip-core
Thread-Index: AQHWahpuSfjftSSrQEiDDzc9LDN4Vakn8ROAgACodwCAAKZ3zA==
Date: Wed, 5 Aug 2020 09:23:40 +0000
Message-ID: <f8f989ef-7ee2-42ee-a922-f53c6d2b07fe@siemens.com>
References: <20200804044724.629026-1-daniel.sangorrin@toshiba.co.jp>
 <0eca9df0-675d-ab68-f199-d029f4d779aa@siemens.com>,<OSBPR01MB2053E648BDBD2C9934BAD1A8D04B0@OSBPR01MB2053.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB2053E648BDBD2C9934BAD1A8D04B0@OSBPR01MB2053.jpnprd01.prod.outlook.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-tm-snts-smtp: 7C17DBBA97B6E2CB80EA283D3B4BD674E8E972C7DCE6A8D452B221C2A5F17FA62000:8
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: FLh2wYoNTEo4nicVqS8U1KjRx4520388AA=
Content-Type: multipart/mixed; boundary="3u1ijGcao9tri87F6ttj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1596619428;
 bh=gCpGsOwAHETJiNCHjci0qjp8iQIDY100898aTGugoBQ=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=Ia1qNTcuBuyzJ7nppMJ+3imLooDyj/Lx+As5yG+fDbPLtDJqdSK26o7liBhBoRBf726
 p3BgzTrdyccJEXgcmm7ZXVcpjyZUy+vqgwhg328J2uo7keTMcXD2usOG31d0dNzFncc2T
 u7PTRSKPBhjdRUee7h/gGvwuip9gZBbnwak=

--3u1ijGcao9tri87F6ttj
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_f8f989ef7ee242eea922f53c6d2b07fesiemenscom_"

--_000_f8f989ef7ee242eea922f53c6d2b07fesiemenscom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Sure, i will look into it. You get a Patch if something is missing.

Quirin
________________________________
Von: daniel.sangorrin@toshiba.co.jp
Gesendet: Mittwoch, 5. August 2020 03:28
An: cip-dev@lists.cip-project.org
Cc: Kiszka, Jan (CT RDA IOT SES-DE)
Betreff: RE: [cip-dev] [isar-cip-core] remove remaining configs from isar-c=
ip-core

Hi Quirin,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Quirin Gylstorff
> Sent: Tuesday, August 4, 2020 10:25 PM
> To: cip-dev@lists.cip-project.org
> Cc: jan.kiszka@siemens.com
> Subject: Re: [cip-dev] [isar-cip-core] remove remaining configs from isar=
-cip-core
>
>
>
> On 8/4/20 6:47 AM, Daniel Sangorrin wrote:
> > Hi Jan,
> >
> > This patch just removes the already unused defconfigs from
> > isar-cip-core
> >
> > [isar-cip-core] kernel: remove configs that are already in
> >
> > I didn't know what to do with bbb_defconfig because it does not seem
> > to be used at all by isar-cip-core (maybe it is in a rather obscure way=
).
> > However, that should also be removed and use cip_bbb_defconfig.
> >
> > Thanks,
> > Daniel
> >
>
>
> In
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/tree/cip-sw-updat=
es/swupdate
> bbb is used as demo system.

Thanks, I guess I was confused because there were no KERNEL_DEFCONFIG defin=
itions.
But it seems that linux-cip-common.inc sets up one by default if you dont s=
pecify it
KERNEL_DEFCONFIG ?=3D "${MACHINE}_defconfig"

I see quite a few differences between
https://gitlab.com/cip-project/cip-kernel/cip-kernel-config.git's cip-kerne=
l-config/4.19.y-cip/arm/cip_bbb_defconfig
and isar-cip-core's bbb_defconfig.

Could you try using cip_bbb_defconfig and see if you need some extra config=
uration for software updates to work?

Thanks,
Daniel


--_000_f8f989ef7ee242eea922f53c6d2b07fesiemenscom_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12.=
0pt; line-height:1.3; color:#1F497D">
<div>Sure, i will look into it. You get a Patch if something is missing. <b=
r>
<br>
</div>
Quirin<br>
</div>
<div id=3D"x_quoted_header" style=3D"clear:both">
<hr style=3D"border:none; height:1px; color:#E1E1E1; background-color:#E1E1=
E1">
<div style=3D"border:none; padding:3.0pt 0cm 0cm 0cm"><span style=3D"font-s=
ize:11.0pt; font-family:'Calibri','sans-serif'"><b>Von:</b> daniel.sangorri=
n@toshiba.co.jp<br>
<b>Gesendet:</b> Mittwoch, 5. August 2020 03:28<br>
<b>An:</b> cip-dev@lists.cip-project.org<br>
<b>Cc:</b> Kiszka, Jan (CT RDA IOT SES-DE)<br>
<b>Betreff:</b> RE: [cip-dev] [isar-cip-core] remove remaining configs from=
 isar-cip-core
<br>
</span></div>
</div>
<br type=3D"attribution">
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">Hi Quirin,<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-project.org&=
gt; On Behalf Of Quirin Gylstorff<br>
&gt; Sent: Tuesday, August 4, 2020 10:25 PM<br>
&gt; To: cip-dev@lists.cip-project.org<br>
&gt; Cc: jan.kiszka@siemens.com<br>
&gt; Subject: Re: [cip-dev] [isar-cip-core] remove remaining configs from i=
sar-cip-core<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; On 8/4/20 6:47 AM, Daniel Sangorrin wrote:<br>
&gt; &gt; Hi Jan,<br>
&gt; &gt;<br>
&gt; &gt; This patch just removes the already unused defconfigs from<br>
&gt; &gt; isar-cip-core<br>
&gt; &gt;<br>
&gt; &gt; [isar-cip-core] kernel: remove configs that are already in<br>
&gt; &gt;<br>
&gt; &gt; I didn't know what to do with bbb_defconfig because it does not s=
eem<br>
&gt; &gt; to be used at all by isar-cip-core (maybe it is in a rather obscu=
re way).<br>
&gt; &gt; However, that should also be removed and use cip_bbb_defconfig.<b=
r>
&gt; &gt;<br>
&gt; &gt; Thanks,<br>
&gt; &gt; Daniel<br>
&gt; &gt;<br>
&gt; <br>
&gt; <br>
&gt; In<br>
&gt; <a href=3D"https://gitlab.com/cip-project/cip-core/isar-cip-core/-/tre=
e/cip-sw-updates/swupdate">
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/tree/cip-sw-updates=
/swupdate</a><br>
&gt; bbb is used as demo system.<br>
<br>
Thanks, I guess I was confused because there were no KERNEL_DEFCONFIG defin=
itions.<br>
But it seems that linux-cip-common.inc sets up one by default if you dont s=
pecify it<br>
KERNEL_DEFCONFIG ?=3D &quot;${MACHINE}_defconfig&quot;<br>
<br>
I see quite a few differences between <br>
<a href=3D"https://gitlab.com/cip-project/cip-kernel/cip-kernel-config.git'=
s">https://gitlab.com/cip-project/cip-kernel/cip-kernel-config.git's</a> ci=
p-kernel-config/4.19.y-cip/arm/cip_bbb_defconfig<br>
and isar-cip-core's bbb_defconfig.<br>
<br>
Could you try using cip_bbb_defconfig and see if you need some extra config=
uration for software updates to work?<br>
<br>
Thanks,<br>
Daniel<br>
<br>
</div>
</span></font>
</body>
</html>

--_000_f8f989ef7ee242eea922f53c6d2b07fesiemenscom_--

--3u1ijGcao9tri87F6ttj
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5100): https://lists.cip-project.org/g/cip-dev/message=
/5100
Mute This Topic: https://lists.cip-project.org/mt/75981585/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--3u1ijGcao9tri87F6ttj--
