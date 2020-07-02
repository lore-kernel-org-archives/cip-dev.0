Return-Path: <SRS0=Kz6h=AN=lists.cip-project.org=bounce+64572+4882+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A56C433DF
	for <cip-dev@archiver.kernel.org>; Thu,  2 Jul 2020 08:49:52 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4436E2088E
	for <cip-dev@archiver.kernel.org>; Thu,  2 Jul 2020 08:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="RwyZDs0i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4436E2088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4882+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Tq0rYY4521723xBOvLjgXAch; Thu, 02 Jul 2020 01:49:51 -0700
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.137])
 by mx.groups.io with SMTP id smtpd.web11.2447.1593679789494651894
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Jul 2020 01:49:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dhNmZuHi1N6I/O0Z0Ik3fQRV7ML2bqNcXwHFKv8inFxVL03jFE6NPZX80jbfkZ9d1C0zT+pqnj4ClPSUm02AzABGVGDne/fGpL/IRJfKQoEVgRZ94zS0IhK3Tx8V9sQYeGwFrwot5cfI2CwuEQTCki4yLoPx8Arksy8y++FGVlHk4ijbvCba/ialfhkrzmGL6i0xUEz4jZdSAaLAfSDKoweYTn8nReqEzAZHFYEOc+bXLVqN2HyAvNKYeYuQgMpqN4aqQgEz0O25xZ+4no9Mx0/SVV8HjbhInL1X/OfSuQLvRgJy+yCRZmMACoVZwm5MD8JmF4fk0J9mp6u0z9NbRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4MsrIFU94qCUHjWV8PhAiwszNIa7sIRZU3fu2ZiFmNE=;
 b=UGwg5hHO3rSBjlhVEMt0GpF9X5oHNDtZq/W+NT+HYPuv6cGj4hq4ZNSrX9X4PRGdvVEOq/l55MumaXoXAQUGtqJbOV+08hcUhNNASQLvA8tYpS3XHq8+8MKQBjHNZvgdQRwCfqh39hd0KV3ARWZUo6SZEm5ueAzqxT+9kDs2sJ6NNunTaUkc2TQI0xFKW4D080DMt6/gW8kV7mv27husAoSCrPYWB4vzfjZ3BQAigzGn/Ov/uER1iil9CgwoM6B2llNLc/jGf/nujz3QCisuM05SejtULOFte7lVdWHlGAomOiZAE7Eoyo2nGkfNVQKhLZhi/bsa2LhVuwgIODOj+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TYAPR01MB3213.jpnprd01.prod.outlook.com (2603:1096:404:8b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Thu, 2 Jul
 2020 08:49:43 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::fdf6:bf77:e369:aa20]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::fdf6:bf77:e369:aa20%3]) with mapi id 15.20.3131.033; Thu, 2 Jul 2020
 08:49:43 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: [cip-dev] CIP IRC weekly meeting today
Thread-Index: AdZP+jmloosxvgoUTESSo9C2ia6xIQAUoNSVAAA58QA=
Date: Thu, 2 Jul 2020 08:49:43 +0000
Message-ID: 
 <TY2PR01MB49725C6F7497024A49DA9397A06D0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
References: 
 <TY2PR01MB4972E7064886814AAF9B745EA06C0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
 <OSAPR01MB23850FE26978DA32103B17DCB76D0@OSAPR01MB2385.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OSAPR01MB23850FE26978DA32103B17DCB76D0@OSAPR01MB2385.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1725c63f-a7bb-408a-e3a8-08d81e64dda2
x-ms-traffictypediagnostic: TYAPR01MB3213:
x-microsoft-antispam-prvs: 
 <TYAPR01MB32138D4363DBD2038F57F9BEA06D0@TYAPR01MB3213.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 tmb1ObyNT2tGMRWd9wvGH+vBeYCJL+rTlXQdNJqa34kDrFbPam3/yWTnrlBDEZv92Sh5TyzZLiwTpqoaInIo4qt9JiRjZaZPJNIIwHMkiQbGnMSjQueYJjY7qRZ7yL7aHatSjwYnGOGAF3FrhYtpyrEqTVbcVj6hQxghIyZIm/A/+GFmCIt6Bsi4FHu9Py2j1TKhi3grbMsOlVLbZv211sBFIvhnYFHzYuXAG0kwobYEQqw8ESs0tRdkB3V5Tyn0ywTyUhi6t9pPxkHeQaMkxOLiE9fJoD8EGuVItK80JPaxrbTrW4pEO9RDXSKxEM+N9US76KZ7f6wDcQu5r9CSIQVoPrW9Fg46Vq2X4zhr5QJb9tKuaPFuHOPS/oIQJEoRh7z5IcLoS9IY2oUba9E7VA==
x-ms-exchange-antispam-messagedata: 
 VfdW9HhCPkxNpb3A0rv6+4GZ1JMgasbHbTXlxDRPyd98roX2Rzj4oUL49rIcUwCLuz4Hj4dSV8Mfzf4ed79nMBinEkgOUf1cKdxYgATDzwFH6pWUIScqL313byTGXTm/PSE35alSHwVTH12xHb9OVvcAYg60rKPRlhWllmhNTVSfz67pKTmDOWt0eUFhfXFbc4DjWkheZcH7VJpnKflEhLHDy2whJqK5WJ7iP2Z/voiNQD7hZ+P+Y99fx5HWOGG3W2ZVWp+OIPA9IQtKLCLofGnhBAKMZ8BI+YGGT9T8yCYHcqI7FKGO99HR0WFsmSnIGQeeozdD1PM/3k1kYvd9UD01ztjejGOUZ7lZnih590U2hb7vGNkpnQZOTmtSgeDg2W9jOd9T7EBZTDK1heaH+dIH2qs31MM5C14qPOJWkiiTJeiqiX3C8w+hXsI/xRY8ZD7w5VbXWFALHu1Y1v18BgMYc9t4mNqQFMni1J15fLdUUf8WZju6d0Q6VLbGzRPs
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1725c63f-a7bb-408a-e3a8-08d81e64dda2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2020 08:49:43.6548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4TKhusU71GV9KQwtGi4CIwIv7BEkx8o610EJ4kmcbLYt2r/Lmx+j3XA4PHc+uwQXi3Zxn3LX/AFORKNQs9aUQ83Wd595qXxwpRnUlAaxv1w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3213
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: kupwETgfd2uuWWZNdPIDdNJHx4520388AA=
Content-Type: multipart/mixed; boundary="sWn7JhQ9EQBrK2BRFnZk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1593679791;
 bh=1pZ+vLVmvVfVXO2hIlDqDQUST+Lw/NG6cNFz3bQQkE4=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=RwyZDs0i2pRccqpwfXNqLfB/JGmT4PYGtNFhjm6Wtq8GQ6Vz3a1klUBwMQFbAyP9oYR
 CAi4vcRSwuWMgzOJJuExloeiBvIT0r7WTBYMTnhK1PQc2M5JirgB+EM4ogEXjKkHVezyL
 ZtVCsVMmZRiH9vpCZNHGp/MM2OIoLyromxg=

--sWn7JhQ9EQBrK2BRFnZk
Content-Language: ja-JP
Content-Type: multipart/alternative;
	boundary="_000_TY2PR01MB49725C6F7497024A49DA9397A06D0TY2PR01MB4972jpnp_"

--_000_TY2PR01MB49725C6F7497024A49DA9397A06D0TY2PR01MB4972jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi, Chris-san,

Sure, then see you at the CIP mini summit!

Best regards,
--
M. Kudo

From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Beha=
lf Of Chris Paterson
Sent: Thursday, July 2, 2020 5:44 PM
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] CIP IRC weekly meeting today

Hello Kudo-san,
Please accept my apologies; I can't babe the meeting this week.
Kind regards, Chris
________________________________
From: cip-dev@lists.cip-project.org<mailto:cip-dev@lists.cip-project.org> <=
cip-dev@lists.cip-project.org<mailto:cip-dev@lists.cip-project.org>> on beh=
alf of masashi.kudo@cybertrust.co.jp<mailto:masashi.kudo@cybertrust.co.jp> =
via lists.cip-project.org <masashi.kudo=3Dcybertrust.co.jp@lists.cip-projec=
t.org<mailto:masashi.kudo=3Dcybertrust.co.jp@lists.cip-project.org>>
Sent: Wednesday, July 1, 2020 11:53:32 PM
To: cip-dev@lists.cip-project.org<mailto:cip-dev@lists.cip-project.org> <ci=
p-dev@lists.cip-project.org<mailto:cip-dev@lists.cip-project.org>>
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

--_000_TY2PR01MB49725C6F7497024A49DA9397A06D0TY2PR01MB4972jpnp_
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
7%C%/=1B(B">Sure, then see you at the CIP mini summit!<o:p></o:p></span></p=
>
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
<b>Sent:</b> Thursday, July 2, 2020 5:44 PM<br>
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
t my apologies; I can't babe the meeting this week.
<o:p></o:p></span></p>
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
<b>Sent:</b> Wednesday, July 1, 2020 11:53:32 PM<br>
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
Cybertrust Japan Co., Ltd.<o:p></o:p></span></p>
</div>
</div>
</div>
</body>
</html>

--_000_TY2PR01MB49725C6F7497024A49DA9397A06D0TY2PR01MB4972jpnp_--

--sWn7JhQ9EQBrK2BRFnZk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4882): https://lists.cip-project.org/g/cip-dev/message=
/4882
Mute This Topic: https://lists.cip-project.org/mt/75247269/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--sWn7JhQ9EQBrK2BRFnZk--
