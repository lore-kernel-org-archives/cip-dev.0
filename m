Return-Path: <SRS0=K/uD=6A=lists.cip-project.org=bounce+64572+4582+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF0DC2BB85
	for <cip-dev@archiver.kernel.org>; Thu, 16 Apr 2020 08:18:15 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98D142078B
	for <cip-dev@archiver.kernel.org>; Thu, 16 Apr 2020 08:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="B5YWAHaT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98D142078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4582+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id NK8eYY4521723xcbpmMCNWMp; Thu, 16 Apr 2020 01:18:15 -0700
X-Received: from APC01-HK2-obe.outbound.protection.outlook.com (APC01-HK2-obe.outbound.protection.outlook.com [40.107.130.132])
 by mx.groups.io with SMTP id smtpd.web12.2549.1587025093491550618
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Apr 2020 01:18:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=beB6AhGo8ZWPnRE1laBIQcgMZSNzSJu5XY2LoAqpatGEb5h3c+GK+7CckkFBwWQYd2jZwwPl6FQTJKUsLp1+RBH2TXOjv6VNF3hcbblVx/Y7q1on4a2vYJrUwQc5eKzV6uMzJrdT4gmOTEo/Qau8rMPmtOfWnqvfJE6pKROKdL0yT0l3xIkVuY2bz860KnUR02fqCcds24hwK/qhjEg0H0p4f2iK0eFglc66GNLzybcrgfAPlzc3zV4EI6U1qEcw5NnsP9M9cB6w7IGdRiQ99vUnJRP78z638Y2K/747duiJ9MrJBPafRdv3Rc30vLyRQtHsSbKCOWqrf4arrgr25w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XqV7KYX6P4I9w3u63zMAuF7lKfLzrq8rMUm7kQyd9Q=;
 b=mXUidDg79iOLqEaTi8SqSbwUEJaPBD85AT0eXbq5GpSL+KiwpnYbieG2Fb9pMPCIzUw7K42zo3/ZcNE3BNjnGzjhzMoFe0jlH/ZFGAd0vdEnyU64eu7PXoboLqxUyPnVD9186LX+i5Pjh5gqs8T8ujclV19cbzIzVRCHoqBeYpsCvGGDqlxvOBDS+9KWev0geKOpFWIaoLbeeSS5N/85jFF04gE7NQ3Du0+NrxihYebL8Kw4VHvGMEgp3w9/TyoWdLpy7RjMOc1fEY9ITeGcHvHr/USwJtZz0jOlkGeB/1NaPpuvYVKgbqeS9fBhHanR1oZmPfWhC6gBWv+LJrY+QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (20.179.172.148) by
 TY2PR01MB3130.jpnprd01.prod.outlook.com (20.177.99.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.20; Thu, 16 Apr 2020 08:18:10 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::e845:c7d4:4f:c3cc]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::e845:c7d4:4f:c3cc%7]) with mapi id 15.20.2878.023; Thu, 16 Apr 2020
 08:18:09 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: [cip-dev] CIP IRC weekly meeting today
Thread-Index: AdYTkwPVJpEHHN+iQmCdazHKo4mwewANAr4GAAAQoAA=
Date: Thu, 16 Apr 2020 08:18:09 +0000
Message-ID: 
 <TY2PR01MB49729AE1CA852AC36C2F57FCA0D80@TY2PR01MB4972.jpnprd01.prod.outlook.com>
References: 
 <TY2PR01MB497244C4E5B3D48167AFF5ADA0D80@TY2PR01MB4972.jpnprd01.prod.outlook.com>
 <OSAPR01MB227422068AA5F1DBFDF37DA2B7D80@OSAPR01MB2274.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OSAPR01MB227422068AA5F1DBFDF37DA2B7D80@OSAPR01MB2274.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 92bf750a-125f-4e36-a504-08d7e1deb30f
x-ms-traffictypediagnostic: TY2PR01MB3130:
x-microsoft-antispam-prvs: 
 <TY2PR01MB3130544C7941FDADB46FEF94A0D80@TY2PR01MB3130.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
received-spf: None (protection.outlook.com: cybertrust.co.jp does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 nnZv0yANZ7/kluEAe7GY8RRhhfnf2/0ztOHS6q5dT1TkiKAN80CpLPByVo2bauwFNEy7eNgrzFtXEazA8h4I37mI8Kr2Q06b3dDly8qGRJicVDV8HQck8FwPrkkKhGYoKbupYOu6la/5aVVmHW7ryWcvnhPaCOxK+3YfNAMpCq7Gd0zILrK8AwZhBVzkX2zBxOv9EHKnOa9vno43fPqMmY262CChOOT/IQkFJSJHU77D/YUY3FFQ2p8vxYFRAPoLGGfXVoNTmWe0xjGo6+oVFc3gvgcDk4tPqlEaZCRySqmwICbtuV5AehzzJJypPOxTb2xmUOsunKm9ulzFc3yV25cNMG51RjEM3+X5m0DxNA00pi21ZAYZnSy8ARNkGtT4nuIb0vxJQWXnFhEQYBvcRKUu1g2vBhqvrkFnk4lbyPUf/pgbsjpnDOSebOdXPgTZmD/R+KuSsqxHWjNRA1hfCudGd3cpdAQ7KaOOnq2V0zuOV6E9mOpOeU31c1o5f05qn+oAJD9IIucfzobLR7oozQ==
x-ms-exchange-antispam-messagedata: 
 mvzr/MkeUkKr/98vbI9XHcVdN22fnQb+rXccQko3sgbtS11YCPVfvIRjHgDxsQgeFYEVqmAfXjGpexi2jrnnkhafIf2O93GVjahgsR6djIue+A7xAybUxMZjvkHWUe48lsfzR8T9Wr9uf6nmec1ZZQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 92bf750a-125f-4e36-a504-08d7e1deb30f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2020 08:18:09.8671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cVSJO1WAl0ZL+2k6A+K5E84A0a1za4I6SzfvlT/89Iti+Qbr0jnhHy4J6+3vij0n/pe1F+McTJ7TNVR7bOvgTkJk7lr4+6dt3s/uXJQUHO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3130
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: bngSswKDy3fSpbmJELFneKyPx4520388AA=
Content-Type: multipart/mixed; boundary="ZSnJVmISl6D1nzFmd7OH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1587025095;
 bh=olZjUNRwECHxnQpeH05tyrZLjH6t+Jnkl2AMFAYtNVE=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=B5YWAHaTGyqwbtQwjthNYgS1CWGH9C3tjioS3zq+pVoLWGb6ZxWui2Aiwa3KxNmngo/
 f5moPnP8m/DB7p1tn3D1u5CcKFWSp6whCelZscOzBttEPMoUMq0hTa0NU+6JQulFS8WJI
 U52UUBdqe0uUZ/j/Cgh7VdXBDJg9LwkVZj0=

--ZSnJVmISl6D1nzFmd7OH
Content-Language: ja-JP
Content-Type: multipart/alternative;
	boundary="_000_TY2PR01MB49729AE1CA852AC36C2F57FCA0D80TY2PR01MB4972jpnp_"

--_000_TY2PR01MB49729AE1CA852AC36C2F57FCA0D80TY2PR01MB4972jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi, Chris-san,

Sure, please rest at ease, and stay safe. See you next week.

Best regards,
--
M. Kudo

From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Beha=
lf Of Chris Paterson
Sent: Thursday, April 16, 2020 5:16 PM
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] CIP IRC weekly meeting today

Hello Kudo-san,
Please accept my apologies for today's meeting as I am on leave this week.
No major updates to report from the testing working group.
Kind regards, Chris
________________________________
From: cip-dev@lists.cip-project.org<mailto:cip-dev@lists.cip-project.org> <=
cip-dev@lists.cip-project.org<mailto:cip-dev@lists.cip-project.org>> on beh=
alf of masashi.kudo@cybertrust.co.jp<mailto:masashi.kudo@cybertrust.co.jp> =
via lists.cip-project.org <masashi.kudo=3Dcybertrust.co.jp@lists.cip-projec=
t.org<mailto:masashi.kudo=3Dcybertrust.co.jp@lists.cip-project.org>>
Sent: Thursday, April 16, 2020 3:02:49 AM
To: cip-dev@lists.cip-project.org<mailto:cip-dev@lists.cip-project.org> <ci=
p-dev@lists.cip-project.org<mailto:cip-dev@lists.cip-project.org>>
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

--_000_TY2PR01MB49729AE1CA852AC36C2F57FCA0D80TY2PR01MB4972jpnp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:=1B$B^b%4%7%C%/=1B(B;
	panose-1:2 11 4 0 0 0 0 0 0 0;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@=1B$B^b%4%7%C%/=1B(B";
	panose-1:2 11 4 0 0 0 0 0 0 0;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0mm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	mso-margin-top-alt:auto;
	margin-right:0mm;
	mso-margin-bottom-alt:auto;
	margin-left:0mm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.19
	{mso-style-type:personal-reply;
	font-family:=1B$B^b%4%7%C%/=1B(B;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:99.25pt 30.0mm 30.0mm 30.0mm;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026">
<v:textbox inset=3D"5.85pt,.7pt,5.85pt,.7pt" />
</o:shapedefaults></xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"JA" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:=1B$B^b%4%=
7%C%/=1B(B">Hi, Chris-san,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:=1B$B^b%4%=
7%C%/=1B(B"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:=1B$B^b%4%=
7%C%/=1B(B">Sure, please rest at ease, and stay safe. See you next week.<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:=1B$B^b%4%=
7%C%/=1B(B"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:=1B$B^b%4%=
7%C%/=1B(B">Best regards,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:=1B$B^b%4%=
7%C%/=1B(B">--<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:=1B$B^b%4%=
7%C%/=1B(B">M. Kudo<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:=1B$B^b%4%=
7%C%/=1B(B"><o:p>&nbsp;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0mm =
0mm 0mm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US">From:</span></b><span lang=
=3D"EN-US"> cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-project.org=
&gt;
<b>On Behalf Of </b>Chris Paterson<br>
<b>Sent:</b> Thursday, April 16, 2020 5:16 PM<br>
<b>To:</b> cip-dev@lists.cip-project.org<br>
<b>Subject:</b> Re: [cip-dev] CIP IRC weekly meeting today<o:p></o:p></span=
></p>
</div>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span lang=3D"EN-US" =
style=3D"font-family:&quot;Arial&quot;,sans-serif;color:black">Hello Kudo-s=
an,<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span lang=3D"EN-US" =
style=3D"font-family:&quot;Arial&quot;,sans-serif;color:black">Please accep=
t my apologies for today's meeting as I am on leave this week.<o:p></o:p></=
span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span lang=3D"EN-US" =
style=3D"font-family:&quot;Arial&quot;,sans-serif;color:black">No major upd=
ates to report from the testing working group.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Aria=
l&quot;,sans-serif;color:black">Kind regards, Chris<o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center"><span=
 lang=3D"EN-US">
<hr size=3D"2" width=3D"98%" align=3D"center">
</span></div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"color:black">From:<=
/span></b><span lang=3D"EN-US" style=3D"color:black">
<a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.cip-project.=
org</a> &lt;<a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.=
cip-project.org</a>&gt; on behalf of
<a href=3D"mailto:masashi.kudo@cybertrust.co.jp">masashi.kudo@cybertrust.co=
.jp</a> via lists.cip-project.org &lt;<a href=3D"mailto:masashi.kudo=3Dcybe=
rtrust.co.jp@lists.cip-project.org">masashi.kudo=3Dcybertrust.co.jp@lists.c=
ip-project.org</a>&gt;<br>
<b>Sent:</b> Thursday, April 16, 2020 3:02:49 AM<br>
<b>To:</b> <a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.c=
ip-project.org</a> &lt;<a href=3D"mailto:cip-dev@lists.cip-project.org">cip=
-dev@lists.cip-project.org</a>&gt;<br>
<b>Subject:</b> [cip-dev] CIP IRC weekly meeting today</span><span lang=3D"=
EN-US"> <o:p>
</o:p></span></p>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;<o:p></o:p></span></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Hi all,<br>
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
Cybertrust Japan Co., Ltd.<o:p></o:p></span></p>
</div>
</div>
</div>
</body>
</html>

--_000_TY2PR01MB49729AE1CA852AC36C2F57FCA0D80TY2PR01MB4972jpnp_--

--ZSnJVmISl6D1nzFmd7OH
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4582): https://lists.cip-project.org/g/cip-dev/message=
/4582
Mute This Topic: https://lists.cip-project.org/mt/73047683/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--ZSnJVmISl6D1nzFmd7OH--
