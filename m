Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06A6C54E49
	for <webhook@archiver.kernel.org>; Mon, 26 Feb 2024 12:18:39 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.65])
 by mx.groups.io with SMTP id smtpd.web10.19069.1708949912778029158
 for <cip-dev@lists.cip-project.org>;
 Mon, 26 Feb 2024 04:18:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=Tg/Ys/r4;
 spf=pass (domain: renesas.com, ip: 40.107.114.65, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KpvQrE/a7XmWHXnUktaX4iEPMsKJg0galI5IDpSpJ8ABbIG0RNZNDBHqjposbwk6H0JE9TIjOZycnsLhlbnif/fgnng1gKVX+VgMoh6eavJkOuVCe1B1efazox3uXb5CxRTqbzPcRRxrN0UF/sNmJRmfng9/TRB+ihiaZQvoYzsl94PvT5JHiyQxux9LYNRf7ZacjvmoJJ8/Jo/6OSdOa1QLWmAjB9ejHuZtiVn+9/ztVAK4O/5vKWc1vNEBRRRSQgubTuLhWRdAY48zbPYecGPqH58IkCW8CCsUTIfHBnk06U4iMfcVL9rgpw5raUsqEsGVIEYNH2i2tfQ99E/Yjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZrQIS5XWjGfUkWUjUi7Lzw4kjLWtTQTbaSdLV9UXFY=;
 b=oL38SRgC9S6z0XWBn+DtRol2hxbDYHFxmjhWsIaihoYHzRG+EOfuO9JuYVa6wsyHG2KvUzWUneV34sDmKKYeVxn5n7FZwiKvsSv/OQebLWZeByPAMCjA3avfYUNEJRmn8pl5rz/inMahvYD5/qWPDXOQIfIL/kIgMfzsKzCvAc6MRJB1YkxDnyDCaE2PE9+jBt3j4M4S3OYkPEbQfjniFG/SCDoM1aZ9GGYlW8pzPjMYyNVen9SLRGulLemlJaVsFtlr0eRbcUbaiCe3avkKOija4+BuG9IgndenFUzLGwpQX+lR+OQHdwhMzBvTc0DWIeICy8sf5exMbY7BaWAzAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZrQIS5XWjGfUkWUjUi7Lzw4kjLWtTQTbaSdLV9UXFY=;
 b=Tg/Ys/r4nXirjZbxFHf4CTVqOEsa9atIK+mLqAGjjvisc5zaZGmOLtuJcYGYIxwWll81S4eUwBOM2cYPgXqOkTfqnvxMM/BJ45UcEyB5eLtOoTFh48xPNgEUFPW50fU+iF1flNkVs9vsy/1V+JtW6op4UMbqa2HYTSjycrtNubk=
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com (2603:1096:400:3fc::6)
 by TYCPR01MB10086.jpnprd01.prod.outlook.com (2603:1096:400:1eb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Mon, 26 Feb
 2024 12:18:27 +0000
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::e2dc:b904:635f:ba5f]) by TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::e2dc:b904:635f:ba5f%4]) with mapi id 15.20.7316.034; Mon, 26 Feb 2024
 12:18:27 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "uli@fpond.eu"
	<uli@fpond.eu>, "masami.ichikawa@cybertrust.co.jp"
	<masami.ichikawa@cybertrust.co.jp>, "van Buuren Sietze (XC-CT/EMT2)"
	<Sietze.vanBuuren@de.bosch.com>
Subject: RE: [ANNOUNCE] Release and and v6.1.78-cip15
Thread-Topic: [ANNOUNCE] Release and and v6.1.78-cip15
Thread-Index: AdpoQf4KVYZKcHo4TqmVXGd1zVw9KAAWP8jQAARCbgAAAB8/0A==
Date: Mon, 26 Feb 2024 12:18:27 +0000
Message-ID: 
 <TYWPR01MB11862BFA542FA685652E73FA8B75A2@TYWPR01MB11862.jpnprd01.prod.outlook.com>
References: 
 <OS0PR01MB638897353A24F4F48F8E0819925B2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
 <TYWPR01MB11862EE8B1050FA1EC2B312B4B75A2@TYWPR01MB11862.jpnprd01.prod.outlook.com>
 <Zdx+bq+O5nbxh/0J@duo.ucw.cz>
In-Reply-To: <Zdx+bq+O5nbxh/0J@duo.ucw.cz>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB11862:EE_|TYCPR01MB10086:EE_
x-ms-office365-filtering-correlation-id: 857595fb-65f8-412e-5c2c-08dc36c50970
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 7NexkGqWChRon+/g8/Kc9p4lpncQZRLABi3/jov9E9xPuBWmJUELikytg7Eki25jeTYsdSuSKG3j5jwQGKb1F8gCl5/zco85h6pmnOHtaeFvXzVfdwhc8Lsq6oU4PON0fDmvsIYY1Lldiz53P0wE4dUaDuQzLophC31yMocBXgCxkCKh6kGSOH/Hi0YiTmP0PqW7j63Z5F1upePLqGb7VplftNX2c02tRUzm5ePMv17kktTDYv5ofU4mWPMARkJQINl7+bj/z0Ioz9PtZz208YBAjpmJTUqtvwo2md8NncvZ7afqeOHKP37NU1K9DV6RgaNUGLGiMiXtTREhK0c6LM/OMCbGywi7XOXSBvQCppNbujyNYK5TJ7yNjErTUqKZ+40bsxo9jHVHI1BUU+SdqLWsRAKMtP2nldBBDEVlDwyKZPxk//0rj0/ZWvhSkph28fNp6IzczQgm5SY6/2O+QkUJQt+uCAbl4XO7B8vLYcjeeLJCn3gsR1LXIB5JOGjnO3kpJ+J6Qhv03F7RDguFbKXosHGo90m8/mcH3nWBwud+qYh4Yt7pGzIsqvsCAS0r9b1Ag4H2eUAHwEYtpWFCX8F+IkQEG7ExNIPt8LJOTLaR+PWjrL++PfTL3Gj073rCx5Da+r4BuTZ+LMqTuZGFyeX4yzQ5EjDAXErYMS7VLih01tvp0pLncFILbzw+8oCUW3BOdjbg+DY1WHw4j+fZDw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB11862.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?GKK/KEoPv+PWsa9ZjMMu+J3KROp+0wIx4BcxhKhdsnsdK34LkAqG4nwh?=
 =?Windows-1252?Q?D7IU8tvOiC3NE48VMMGy5d2QanMryWqNFlrT++r3kNIblZwRRVyiFcQe?=
 =?Windows-1252?Q?ZILfQwGQTkvcxxbGgnwuObt1wHfxekUl7wsSlhiXv5MaU/xNGFrBsbTq?=
 =?Windows-1252?Q?OBrQ8ETVtTmkOnJc/DsHMDhVDgDdq4AlDxkWn139bvSoGFrN4EZj22/7?=
 =?Windows-1252?Q?CsVqvCkO4k88vhnEjYlW6CBKXL7vxeDh0OvHjajHi1kNBmTQpwbbBsYo?=
 =?Windows-1252?Q?set0ULWmj4alo649NgaFAG04XueG9culgYLahJtXeP2flK0VakkrRo4P?=
 =?Windows-1252?Q?nlaMgBmxpDvYrzuAG0oCfyrcyEVZfCSmdHN1iT15d0GEFWXb6juGJI7D?=
 =?Windows-1252?Q?lW80Dz7X6XgKuwWRN4kgYXohYkTN2myJNU8jAWjgfNtUNW7pXMFvdKY/?=
 =?Windows-1252?Q?0gNTxkFtzTg7ABZSb2hofjgWslzhxKHKgdhmkbueb9l5D7shlOwxJuOU?=
 =?Windows-1252?Q?IO7A/hxY9wD5OQe9thfr7AG89JBkt97uivqKEAvwnmsKbjWR0suiVHH4?=
 =?Windows-1252?Q?YTnLfCNyRzq2Ps7LW/ddCBrle1UfJ0c+DhoHYuTBlEBil2pBePuKoRsS?=
 =?Windows-1252?Q?IU7QqppDb5Wkzwq7uf1Bd6rI0wrm5MeAwwr3FIDKAbtaq9pxMb99wcj+?=
 =?Windows-1252?Q?5NYxSgXk4AgheQQyXGWs291bRTkmUIgjwxLKki0L0oa6wpchFAJBfgoY?=
 =?Windows-1252?Q?84kH+9ROav9cHyrAA/Y9TNoSoUPeVVaOSRxftOCD2CSA9WJ0HCIx05i2?=
 =?Windows-1252?Q?EEE8BBTw/HMS/2CjtY9WR8Uv5OAs6NrT32gftwEwPqmKC3oYoTQ0RvCI?=
 =?Windows-1252?Q?V4M6qUwa9BJ38klNHmsLqdxA3i8eaVOWyCYJwCofVjKrml/TnySIXvVk?=
 =?Windows-1252?Q?49qq9NuHPqDgh25CE9xk2F7sU46ED/xa/OoHW+7pCRW36JXarnBASUab?=
 =?Windows-1252?Q?+hBUZnOorW8bQg5dGWB+mQYtUp50ckkoQekE8EMH8eeAHh7vg6YlpEtX?=
 =?Windows-1252?Q?4RlXQj1Ca4wXPChpw6+0//bzRr1Ykqdhbz7tB6Ke4iw5+4uyvBy3Dbq5?=
 =?Windows-1252?Q?N6z4HInmktCXzr9TdYWpcOEVhIGqc4SgWA2ePHAqtyXKEtFh5S1Dj38w?=
 =?Windows-1252?Q?b9UeyQa3dGu7RfB3Sb5hvsw1iXphnmOQXtKYu0VojDl0viazPQifQzKR?=
 =?Windows-1252?Q?9SXjzkVtoDVUi1zdViUYQMUY5knoZhuL/rBErYle7gASYSndQpWxNtD/?=
 =?Windows-1252?Q?FPJbyUElLH0kFUBeWecjOW7emUByZ06abQVOWMDuNXJAOCwiiMMjMSTA?=
 =?Windows-1252?Q?jrNYEbbntDOjYpF8BsBy7tNkWKyW7LHWn3FubW9s2/lBLQzfoX7LiVc3?=
 =?Windows-1252?Q?uyWhHzyMzprqY/aRqFARgJcMYWghQIGAup2HDNBizq3QJVOdeCf5J0Pr?=
 =?Windows-1252?Q?FYWVmgqetsFjQDN7xKcPIog24GoHMBROG8ekFKLCIyP/vWeNfysEqw1V?=
 =?Windows-1252?Q?teY00H7NZFX9syD1Jkkp1TJcsjdtZubfy6Oi+byV/lIyCVlKx/MzTAFE?=
 =?Windows-1252?Q?6B/tV1SeUJ0O+2j2BOpFF5gtR5vwl8lR4Ky6J38MV3SoMXctc1onoQF4?=
 =?Windows-1252?Q?qRe8nFBmTXC3EF7SNciljZhd0ao3X62HzvlRMIDYRNwxjMqPo1GS6w?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: multipart/related;
	boundary="_005_TYWPR01MB11862BFA542FA685652E73FA8B75A2TYWPR01MB11862jp_";
	type="multipart/alternative"
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB11862.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 857595fb-65f8-412e-5c2c-08dc36c50970
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2024 12:18:27.4077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ppCYcvKn+U3RZn4AR4F+P0yDmTdeuo+qrBoTb6uNgRN8EVSJMkg19VNd8KQ2eXgX1/LsvqQyUP4aUdSlElGFmoEper1BuTixMC/CQY+H6Ak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10086
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 26 Feb 2024 12:18:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15098

--_005_TYWPR01MB11862BFA542FA685652E73FA8B75A2TYWPR01MB11862jp_
Content-Type: multipart/alternative;
	boundary="_000_TYWPR01MB11862BFA542FA685652E73FA8B75A2TYWPR01MB11862jp_"

--_000_TYWPR01MB11862BFA542FA685652E73FA8B75A2TYWPR01MB11862jp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hello Pavel,



> From: Pavel Machek <pavel@denx.de>

> Sent: Monday, February 26, 2024 12:05 PM

>

> Hi!

>

> > Test results:

> > - Dashboard: https://squad.ciplatform.org/linux-cip/linux-6.1.y-<https:=
//squad.ciplatform.org/linux-cip/linux-6.1.y-cip/build/6.1.78-cip15_8e0cf03=
5f/>

> cip/build/6.1.78-cip15_8e0cf035f/<https://squad.ciplatform.org/linux-cip/=
linux-6.1.y-cip/build/6.1.78-cip15_8e0cf035f/>

> > - Results comparison with previous release:

> https://squad.ciplatform.org/_/comparebuilds/?project=3Dlinux-cip/linux-<=
https://squad.ciplatform.org/_/comparebuilds/?project=3Dlinux-cip/linux-6.1=
.y-cip&baseline=3D6.1.75-cip14_f555c0a7f&target=3D6.1.78-cip15_8e0cf035f&co=
mparison_type=3Dtest>

> 6.1.y-cip&baseline=3D6.1.75-cip14_f555c0a7f&target=3D6.1.78-<https://squa=
d.ciplatform.org/_/comparebuilds/?project=3Dlinux-cip/linux-6.1.y-cip&basel=
ine=3D6.1.75-cip14_f555c0a7f&target=3D6.1.78-cip15_8e0cf035f&comparison_typ=
e=3Dtest>

> cip15_8e0cf035f&comparison_type=3Dtest<https://squad.ciplatform.org/_/com=
parebuilds/?project=3Dlinux-cip/linux-6.1.y-cip&baseline=3D6.1.75-cip14_f55=
5c0a7f&target=3D6.1.78-cip15_8e0cf035f&comparison_type=3Dtest>

> > - Summary: No new regressions

>

> Ok, so I'm looking at squad to see if it is feasible to decode the

> results.

>

> I assume testing starts automatically at the push?

>

> I see "Test jobs progress 31 / 31 (100%)", but the bar above it is

> partly red. What does the red part mean?



One of the LAVA jobs failed to complete.



>

> It lists incomplete test jobs at

> https://squad.ciplatform.org/linux-cip/linux-6.1.y-cip/build/6.1.78-<http=
s://squad.ciplatform.org/linux-cip/linux-6.1.y-cip/build/6.1.78-cip15_8e0cf=
035f/testjobs/>

> cip15_8e0cf035f/testjobs/<https://squad.ciplatform.org/linux-cip/linux-6.=
1.y-cip/build/6.1.78-cip15_8e0cf035f/testjobs/>

> . Is that expected? How should we deal with those?



If the "incomplete" LAVA job has a green ticket next to it (as in this case=
), the job has already been resubmitted and successfully run again.

If there is a red cross, a LAVA job failed to complete and hasn't been resu=
bmitted yet.

SQUAD admins (me & Sietze) can resubmit these LAVA jobs directly from SQUAD=
, then SQUAD automatically keeps track of it all.



>

> Could we add big, green "This is okay to release" text somewhere, that

> tells me that everything is okay without going through all the

> details?



There are two options.

1) You can look at the top level (https://squad.ciplatform.org/linux-cip/li=
nux-6.1.y-cip/):

[cid:image001.png@01DA68AD.90D6AD30]

If in the circled section it is all green and =93pass=94 =96 there are no i=
ssues.

If in the circled section there is a red =93fail=94 bit, there have been bu=
ilds or tests that have failed.



2) Look at an individual build (https://squad.ciplatform.org/linux-cip/linu=
x-6.1.y-cip/build/6.1.78-cip15_8e0cf035f/)

If you scroll to the bottom there is a =93Test results section=94.

By default a =93failures only=94 tick box is selected.

If there are any build or test failures then something will be shown here.

Or you can unselect the =93failures only=94 tick box and you=92ll get a vie=
w of all of the passed builds/tests as well:

[cid:image002.png@01DA68AD.E510B800]

Again, there will be red =93fail=94 items here if there are issues.



Hopefully that clarifies things a bit.



Kind regards, Chris

--_000_TYWPR01MB11862BFA542FA685652E73FA8B75A2TYWPR01MB11862jp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:x=3D"urn:schemas-microsoft-com:office:excel" xmlns:m=3D"http://schema=
s.microsoft.com/office/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html=
40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
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
	{font-family:Aptos;}
/* Style Definitions */
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0cm;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:"Times New Roman",serif;
	mso-ligatures:none;
	mso-fareast-language:EN-GB;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 125.95pt 72.0pt 125.95pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-GB" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoPlainText"><span style=3D"mso-fareast-language:EN-US">Hello =
Pavel,<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"mso-fareast-language:EN-US"><o:p>&=
nbsp;</o:p></span></p>
<p class=3D"MsoPlainText">&gt; <span lang=3D"EN-US">From: Pavel Machek &lt;=
pavel@denx.de&gt;</span></p>
<p class=3D"MsoPlainText">&gt; <span lang=3D"EN-US">Sent: Monday, February =
26, 2024 12:05 PM</span></p>
<p class=3D"MsoPlainText">&gt; </p>
<p class=3D"MsoPlainText">&gt; Hi!</p>
<p class=3D"MsoPlainText">&gt; </p>
<p class=3D"MsoPlainText">&gt; &gt; Test results:</p>
<p class=3D"MsoPlainText">&gt; &gt; - Dashboard: <a href=3D"https://squad.c=
iplatform.org/linux-cip/linux-6.1.y-cip/build/6.1.78-cip15_8e0cf035f/">
<span style=3D"color:windowtext;text-decoration:none">https://squad.ciplatf=
orm.org/linux-cip/linux-6.1.y-</span></a></p>
<p class=3D"MsoPlainText"><a href=3D"https://squad.ciplatform.org/linux-cip=
/linux-6.1.y-cip/build/6.1.78-cip15_8e0cf035f/"><span style=3D"color:window=
text;text-decoration:none">&gt; cip/build/6.1.78-cip15_8e0cf035f/</span></a=
></p>
<p class=3D"MsoPlainText">&gt; &gt; - Results comparison with previous rele=
ase:</p>
<p class=3D"MsoPlainText">&gt; <a href=3D"https://squad.ciplatform.org/_/co=
mparebuilds/?project=3Dlinux-cip/linux-6.1.y-cip&amp;baseline=3D6.1.75-cip1=
4_f555c0a7f&amp;target=3D6.1.78-cip15_8e0cf035f&amp;comparison_type=3Dtest"=
>
<span style=3D"color:windowtext;text-decoration:none">https://squad.ciplatf=
orm.org/_/comparebuilds/?project=3Dlinux-cip/linux-</span></a></p>
<p class=3D"MsoPlainText"><a href=3D"https://squad.ciplatform.org/_/compare=
builds/?project=3Dlinux-cip/linux-6.1.y-cip&amp;baseline=3D6.1.75-cip14_f55=
5c0a7f&amp;target=3D6.1.78-cip15_8e0cf035f&amp;comparison_type=3Dtest"><spa=
n style=3D"color:windowtext;text-decoration:none">&gt; 6.1.y-cip&amp;baseli=
ne=3D6.1.75-cip14_f555c0a7f&amp;target=3D6.1.78-</span></a></p>
<p class=3D"MsoPlainText"><a href=3D"https://squad.ciplatform.org/_/compare=
builds/?project=3Dlinux-cip/linux-6.1.y-cip&amp;baseline=3D6.1.75-cip14_f55=
5c0a7f&amp;target=3D6.1.78-cip15_8e0cf035f&amp;comparison_type=3Dtest"><spa=
n style=3D"color:windowtext;text-decoration:none">&gt; cip15_8e0cf035f&amp;=
comparison_type=3Dtest</span></a></p>
<p class=3D"MsoPlainText">&gt; &gt; - Summary: No new regressions</p>
<p class=3D"MsoPlainText">&gt; </p>
<p class=3D"MsoPlainText">&gt; Ok, so I'm looking at squad to see if it is =
feasible to decode the</p>
<p class=3D"MsoPlainText">&gt; results.</p>
<p class=3D"MsoPlainText">&gt; </p>
<p class=3D"MsoPlainText">&gt; I assume testing starts automatically at the=
 push?</p>
<p class=3D"MsoPlainText">&gt; </p>
<p class=3D"MsoPlainText">&gt; I see &quot;Test jobs progress 31 / 31 (100%=
)&quot;, but the bar above it is</p>
<p class=3D"MsoPlainText">&gt; partly red. What does the red part mean?</p>
<p class=3D"MsoPlainText"><span style=3D"color:black"><o:p>&nbsp;</o:p></sp=
an></p>
<p class=3D"MsoPlainText"><span style=3D"color:black">One of the LAVA jobs =
failed to complete.<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"color:black"><o:p>&nbsp;</o:p></sp=
an></p>
<p class=3D"MsoPlainText">&gt; </p>
<p class=3D"MsoPlainText">&gt; It lists incomplete test jobs at</p>
<p class=3D"MsoPlainText">&gt; <a href=3D"https://squad.ciplatform.org/linu=
x-cip/linux-6.1.y-cip/build/6.1.78-cip15_8e0cf035f/testjobs/">
<span style=3D"color:windowtext;text-decoration:none">https://squad.ciplatf=
orm.org/linux-cip/linux-6.1.y-cip/build/6.1.78-</span></a></p>
<p class=3D"MsoPlainText"><a href=3D"https://squad.ciplatform.org/linux-cip=
/linux-6.1.y-cip/build/6.1.78-cip15_8e0cf035f/testjobs/"><span style=3D"col=
or:windowtext;text-decoration:none">&gt; cip15_8e0cf035f/testjobs/</span></=
a></p>
<p class=3D"MsoPlainText">&gt; . Is that expected? How should we deal with =
those?</p>
<p class=3D"MsoPlainText"><span style=3D"color:black"><o:p>&nbsp;</o:p></sp=
an></p>
<p class=3D"MsoPlainText"><span style=3D"color:black">If the &quot;incomple=
te&quot; LAVA job has a green ticket next to it (as in this case), the job =
has already been resubmitted and successfully run again.<o:p></o:p></span><=
/p>
<p class=3D"MsoPlainText"><span style=3D"color:black">If there is a red cro=
ss, a LAVA job failed to complete and hasn't been resubmitted yet.<o:p></o:=
p></span></p>
<p class=3D"MsoPlainText"><span style=3D"color:black">SQUAD admins (me &amp=
; Sietze) can resubmit these LAVA jobs directly from SQUAD, then SQUAD auto=
matically keeps track of it all.<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"color:black"><o:p>&nbsp;</o:p></sp=
an></p>
<p class=3D"MsoPlainText">&gt; </p>
<p class=3D"MsoPlainText">&gt; Could we add big, green &quot;This is okay t=
o release&quot; text somewhere, that</p>
<p class=3D"MsoPlainText">&gt; tells me that everything is okay without goi=
ng through all the</p>
<p class=3D"MsoPlainText">&gt; details?</p>
<p class=3D"MsoPlainText"><span style=3D"color:black"><o:p>&nbsp;</o:p></sp=
an></p>
<p class=3D"MsoPlainText"><span style=3D"color:black">There are two options=
.<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"color:black">1) You can look at th=
e top level (<a href=3D"https://squad.ciplatform.org/linux-cip/linux-6.1.y-=
cip/">https://squad.ciplatform.org/linux-cip/linux-6.1.y-cip/</a>):<o:p></o=
:p></span></p>
<p class=3D"MsoPlainText"><img border=3D"0" width=3D"1210" height=3D"196" s=
tyle=3D"width:12.6041in;height:2.0416in" id=3D"Picture_x0020_1" src=3D"cid:=
image001.png@01DA68AD.90D6AD30"><span style=3D"color:black"><o:p></o:p></sp=
an></p>
<p class=3D"MsoPlainText"><span style=3D"color:black">If in the circled sec=
tion it is all green and =93pass=94 =96 there are no issues.<o:p></o:p></sp=
an></p>
<p class=3D"MsoPlainText"><span style=3D"color:black">If in the circled sec=
tion there is a red =93fail=94 bit, there have been builds or tests that ha=
ve failed.<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"color:black"><o:p>&nbsp;</o:p></sp=
an></p>
<p class=3D"MsoPlainText"><span style=3D"color:black">2) Look at an individ=
ual build (<a href=3D"https://squad.ciplatform.org/linux-cip/linux-6.1.y-ci=
p/build/6.1.78-cip15_8e0cf035f/">https://squad.ciplatform.org/linux-cip/lin=
ux-6.1.y-cip/build/6.1.78-cip15_8e0cf035f/</a>)<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"color:black">If you scroll to the =
bottom there is a =93Test results section=94.<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"color:black">By default a =93failu=
res only=94 tick box is selected.<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"color:black">If there are any buil=
d or test failures then something will be shown here.<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"color:black">Or you can unselect t=
he =93failures only=94 tick box and you=92ll get a view of all of the passe=
d builds/tests as well:<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><img border=3D"0" width=3D"1183" height=3D"348" s=
tyle=3D"width:12.3229in;height:3.625in" id=3D"Picture_x0020_2" src=3D"cid:i=
mage002.png@01DA68AD.E510B800"><span style=3D"color:black"><o:p></o:p></spa=
n></p>
<p class=3D"MsoPlainText"><span style=3D"color:black">Again, there will be =
red =93fail=94 items here if there are issues.<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"color:black"><o:p>&nbsp;</o:p></sp=
an></p>
<p class=3D"MsoPlainText"><span style=3D"color:black">Hopefully that clarif=
ies things a bit.<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"color:black"><o:p>&nbsp;</o:p></sp=
an></p>
<p class=3D"MsoPlainText"><span style=3D"color:black">Kind regards, Chris</=
span></p>
</div>
</body>
</html>

--_000_TYWPR01MB11862BFA542FA685652E73FA8B75A2TYWPR01MB11862jp_--

--_005_TYWPR01MB11862BFA542FA685652E73FA8B75A2TYWPR01MB11862jp_
Content-Type: image/png; name="image001.png"
Content-Description: image001.png
Content-Disposition: inline; filename="image001.png"; size=23959;
	creation-date="Mon, 26 Feb 2024 12:18:26 GMT";
	modification-date="Mon, 26 Feb 2024 12:18:26 GMT"
Content-ID: <image001.png@01DA68AD.90D6AD30>
Content-Transfer-Encoding: base64

iVBORw0KGgoAAAANSUhEUgAABLoAAADECAIAAAAXnd+VAAAAAXNSR0IArs4c6QAAXVFJREFUeF7t
nQt8VMXZ/w+3cA2XBKPCX0kUCCKmscALJoCSUmPBl6go+pdAa0RfLhpS1EBbgm+JthYEE94KFGP8
F4PViGBSoaTFoMCm0qSVLoiE2yK8BAlZIIRrIMn/mZlzds9ec3az9/2dT1w358w888x3ZsL5nWdm
TruWlhYJBwiAAAiAAAiAAAiAAAiAAAiAAAhYEmgPICAAAiAAAiAAAiAAAiAAAiAAAiBgSwByEb0C
BEAABEAABEAABEAABEAABEDADgHIRXQLEAABEAABEAABEAABEAABEAAByEX0ARAAARAAARAAARAA
ARAAARAAAW0EEF3UxgmpQAAEQAAEQAAEQAAEQAAEQCDMCEAuhlmDo7ogAAIgAAIgAAIgAAIgAAIg
oI0A5KI2TkgFAiAAAiAAAiAAAiAAAiAAAmFGAHIxzBoc1QUBEAABEAABEAABEAABEAABbQQgF7Vx
QioQAAEQAAEQAAEQAAEQAAEQCDMCkIth1uCoLgiAAAiAAAiAAAiAAAiAAAhoIwC5qI0TUoEACIAA
CIAACIAACIAACIBAmBHwiVzckzeCH/NKjWGG1051jaXzBIySWu/B0MvEV+pNZSjl5plPtVK+sSST
e5pZgmbzXlPBMgiAAAiAAAiAAAiAAAgELAGfyEWf1b62snDlVj9om4bqkteLNMswn+FAQSAAAiAA
AiAAAiAAAiAAAiDgPoHQkYuGjzLGT5y96vA192G4lbNhx9LUSdNyN9W5lRuZQAAEQAAEQAAEQAAE
QAAEQCBACYSOXGw4rW/wB+TG8yeNl/1RsLMyE7Kq+JGZEGiewR8QAAEQAAEQAAEQAAEQAIFgIRA6
cjFYiMNPEAABEAABEAABEAABEAABEAgKApCLQdFMcBIEQAAEQAAEQAAEQAAEQAAEfE0gsOViY42+
dNWiudNSx4mtVUckTZw27ZW8kj0W29noV7JLGes4u4rcVAe7sBr3lKxaPPuJCcLS+CfmLlpVVt3Q
5ID4+eqtaxbNfjo1SSl39uJVVuWKvUZTl+i4iaIMYVi1GWnrjVlbWaS4RFXLfqO40t52qaKCDnYo
tbt/qZ2dUZ0502Ss3LA0W64skVlavNfphkEa4LRed6QAARAAARAAARAAARAAARAIbAKBKxdrtuVO
mzA5Y0nh1t3VpsWBjbXV1duLcmemjl+4tcaR0rMlftlQvHB86szcwi2VhvPicoNh99bCX01LnZ5b
XmOdoXHPqmmTpy0q2Fp50NjIL1K5lVsKXS7Xads3fLVq2uOz8xSXqIjyDUtnTxyfvcEgCvXN0Xik
ODs1dfYbxeVyZYlM8dJn/jPjvUq7a0F9A8c3dUcpIAACIAACIAACIAACIAACTggEqFxs3Ltq3sKS
atpCpvfIOa8Xfrxl+/Zt27dvWp+/OH1kb672ti3K2ybLmYSZ7Gr+k7yaI7LXU8pt2197KFqudlNN
yaJpS3niyFHpOQWlwtRrs0ZGkg48WJKdmadX71VTu/WVzEIqOmJwWvaK9aXcWum61+aMouSs3Hnr
qoXl6Ideo0vrXxnJf5uaz1Nun6lxdxld3hIqJXLkrNfWb6KMpetfn8Or1lD+xrQlStW83nepss8s
LT/P2CielH28IisltlH/9qK8CpvyNcPxuucoAARAAARAAARAAARAAARAwMsEAlMuNpSvLzRQzbsl
56xbnZGaEBcTGdk7MvK2+OTJWavX5SRzKOU7lPBXN361Mz8b0bkvfaefCJlczaZFuTtYuC5uRmHZ
21lpif2EqYdmri77KDu5myQdK5q1UmcK6NXoSnRMPaYtK8iZOi6+H7fWb+hDGSvX5yQxm4b3/qIX
gc0IdqlvV1FSBDNLP2RQ6xGXXlC2euZD8bdRxn7xqRmrN61Oj6XMjVuXrK70RYSxsfKPS3hl1Z5E
x41LX7pu/Zx77FTDBThaISAdCIAACIAACIAACIAACIBAgBIISLnYWHOhKT4+NrLfjDlp/WzA9RuT
wmWb1NDQuqRq0heLxYT3ZC+dm6BISNlmxJ1Ts+ayYGDjhuK/KIsG605Ussv9+vcV+tN0dOiXMvmh
yNj4+HsirnnizRkJryzNSrT0KHLknPlT2anLxSU7vP9akIZdJR8xhBFPZs+x8qRbfMar2bZxUp/B
CdDhArdAAARAAARAAARAAARAIJwIBKRcjIifumz9+g3bS2fG22uLyL62GtJRmx2pKufSbuTkMXEd
7CSKG/UQL0NXXiVv7tI/lgcva1Yter2kWl66KGeMnPDa9g3r1789h01jbeuRnDY+ztZGxKjxU/nZ
rVX61sVw23xo3Fu1lVmImPrjkVZCmp2OHfnQUOsCfAWnbRVDbhAAARAAARAAARAAARAAAU8QCEi5
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
3Ylu4IuwEAAAAABJRU5ErkJggg==

--_005_TYWPR01MB11862BFA542FA685652E73FA8B75A2TYWPR01MB11862jp_
Content-Type: image/png; name="image002.png"
Content-Description: image002.png
Content-Disposition: inline; filename="image002.png"; size=26221;
	creation-date="Mon, 26 Feb 2024 12:18:26 GMT";
	modification-date="Mon, 26 Feb 2024 12:18:27 GMT"
Content-ID: <image002.png@01DA68AD.E510B800>
Content-Transfer-Encoding: base64

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
Gt0519r5anlF1uDJX//rHMdzaQkuVfafo8/P6SfncvZ+WmAU5u6VuY39ZpnF1fnMjRL1FWZtVLGB
dX6WKp65/2ijXs8tH5ssr5PHLl/3XFojR8VmsWHtCz/9RFVm3mOduipzg88VerrY0jGqupycW1UN
y80fTp6V70f3SkCVPGa5rkndNGdZptsiukZpz5nlVWef69WocMcG1WLrEvMt83Dvi9n3LRskhmzb
WV7m7M0tNAo+VQr65pL0O7pfRVBdOzr7Z3q6Ns9tlKxbu9pu2euSbLSGY44KJsvt3eFMFfG6dkGP
kePYu1SHr/1mmWN6I22zPUPdg7v2w/S4SNQn7w5ra8axMpqaWdBylmaWttzqkX5T1dN2mKmnh3hY
+1IEefiBm0jpD1eOvTdtnxpQ6+jZWLJ0RfFdzWjMirX0SRW/qcNjOuX6hZLjMwxVj+T0Bk6WWC9/
nyT49ufLv31Ysdz9t9e7orKBcqPEzlKnxI37VPL27D4VPfYYleZ4P99I7OJjuqZHF2wx35ZdZSdV
9nnstfk97pIXznfPnZV4b8fceRNGzZvwG52ms1blfbFp1Jt/aPbYa79Kkd65rtZTFNuNjsunLlJV
HXntHQmhjAu7NknhRcunvjatnfHZrj/sLLAbX2yae0TuuGj5U0/cU/CH3+2+IPUc2/zadqPXNH2t
FNtVYGbX3FYD2mLccnffxtRRJVQh2SfT+d0wEu6a/+x9D6jmuJ7Xrwuy35Nft4TG8kFzXnVzSp9f
JBh/3vj+uk0f/9mI/8VjPW5u+/D8nmpe5QOPjRqfkvDlpo9P9/zpimdHq5OHP1531PnMCF2n/ghY
tbm3R1ro4/PDaQQQQAABBBBAIGACQY3uiq66/UFWthPXr6p/I7/hYUYsMlnR24TG5DEPmn/rt+2n
gjQVaeSfVGGNpOb0oZdUqQjHPN2vq/kXvIQEZeOE0qY4ijkqk2l76tAJKx0ueZttaOaUEm69VdVj
1tDo1u85Ki34+mt18bLRuiYzQ/X16cJyum+1+DEz5mx0bzdHeGdGbslj+lnRSGnfjVtaaoV846zq
br/+Khzde9jM4916qzMqTu56r3rtUqd7j46bWJ0tW42lcmvWYV1uJKq76cNH7wpPq047coYSvko9
LsF5To6OQJNbWtMUraEro23dxNGe0lmvapqm+zYz5h1VMlMz62yqTmYm3NtVGqtmb7pOWPXJL8+1
8/rehgUvrthV9p3E+IvmzMzELiq31rN9C0ndqfBMYjZJuOl8m9djYCvp+9mvNsib67+SD1Z8Y0dJ
CfVeGJW/QM3rVO+WOcz3F8r7C7y+b3h0ocS4rtJdNp1kcnxv2H3kwNvl+X2OjJw6f/x/jxhGu/HL
piyY1+P7n+2a+c5RR/nbH1n2zHhj469Hbz7uXo+6vE/726Tmht3u7yOR3qFjsn9LypMLBjbZs2Te
ryWi09Ga1KNKbt848Z2CH42bsmBc94aqHtU1CSY35Xd7atkzI1Ma62SdeztLotyjO3u0lS4zk2Z2
Xdre7qcjUuLd0ovmeSlzeN3KQ58ZRofvt2tYWl7ON0m5r4VhnPqzfIradUppospb6UlD1ZzUf9S4
bmfXvbJ8yk71PyuVSVRf6qVOLKqmy38cd3Ek8ey2b+1B/Z+tz88xbyCAAAIIIIBARAsE9Q+OA2te
slYd6T97TVjzL17zKP/RCKUDoSMxM8OmJjS6/UFvJo5ueJiTFQN0/N/XhQGqSQeKFT+sANLbhVYM
s3eNStb16/qgCr++3p+posEbTGiseDNudIU/vUtOVtHosj/53u4yANrmh8SMLc1MnQ7/qr7zZ6mA
NTPz/L8kY9eifQ+XKZo6Zqt3s5pW6eXQy/PUfEt1qLmXuuTOFZ/rD4Y5j7lsaLhrxUH9sff1vtdb
qZVyKjBx7Cvp9lpdYb1lv+2nU+Yv7d9Kfoxve08Hwzh97qLLta06tTOMI3875l6PdbkOfBwZrbz1
8yePeTO304j5r6R+3ypw54+HNlH32r5p0pj5k9fLJieGPanHYLmLYfxlnpR/dYuq2Vs7XTull7qp
7Jm1iK7MazMR6ShTsOvNndvl+iZ3Deue4HntHd10k+KH9mhnldd30hm5gp0rV4x5daf90VFLH5Ug
sLROq35d0mcbvA85ZxFAAAEEEEAAgYAJBDW6C1irdUUyhdIxN1LNqHRW7nh9NFNlw1QWyEwoOWZm
mlMqJV9knnbMq/R3R36rMmtmpqOyRlaoYNXdyJ+umiGZY2amWZPnJEP3eqwWq2mlcpgdNA/9TunE
ztK+O9Jxet1gcstEHezlbMlUeTwrEeerrWbwY/WojYll3dpMVPrYUcasz0fvGjVXnXbOjbQ2R3Fm
25LHjH1urJpxqqeVWv1yzoMt1S7TZjP1qg/X6ZTqc6Lv6JiZWbaMTMVU/1agbuo2R9TzFg0aNPBn
VKXMzm9KU9D5F61/xfDzWmPXeXWxzLd0HmYibr3KycnETBXk1bs9rUzqb4PK6enEoPl+6e6dpXf2
7EJJlM47WbtLur125u50Rsq1jCNN5Tx/4ZQElk0Sm7jVo0s5rlUtkNdHcz80jN4DRnSXXJyeRKnT
XQ26P/nq65PnzU1VeecPN2cek3oadxk7ed7rk2cOUVHWX17dkle2nUaJ2zPNo3SOTcIqr9/N8NL5
7rEt72aclxMtpoxIaVjmqsLd2/W7RRkbd6ulgXoTGN0du63gSM554+7Uxx67w8zXmdvOmBk7K6iz
SpZpibTQ388A5RBAAAEEEEAAgcoK1MTozm3DTHNupFugYs210zMw9YzBRh3VFDzHzEznlo+N0h7T
S/PMOXvmci9r0qPi1OfL7phizl1UCUPnUdknzuktTxwzM83pgd534DSnoWbImsCBusXmZE7XXfut
vrjNPu0/0FyOaHZfYag9VJxTQ51zTf367LjfWs9vdNTv43ofvWvfTy8XtADVpjKlE0rNmsy+mOm7
qmmrT8LLWbd0VdVZMzMt5kK5j+uGmeaMTcf8Ut0M1ULX7UObNWvml5QUUtm5erd3lc1NzAmZpw7v
sp6YoCZZqj1XjHw99dLbseErCZZuaaV2Rhmknqqg193ppymo1XQbFur4regbtVFL6eEsuX6hXgFY
dN7LZFHDowvRNnnmpM7dqfjEzLE5X6u6HedPvLtg6tNbTkiZi0c/+9xo/4O2DS98smrcgjd3n5ft
NA8dkIDn++3i3epRl3+0638uGrYLn3wkQd397W8zEm6528r7nfgwWwX0Ur+znvhuj6tYrsktTYyL
2aueGfeWXNswZcAgueTuW+QB5Z7tjC6xHphpItSRmY9mB7x9mWWst774YL6aFxo/ZMRDrcsWPr87
I7vIaNfzP1PjjfOHMvbI0kDnyjrD3iRBPgSfnzsnSbzdO085q3Wtv/RG7pVLC32MOKcRQAABBBBA
AIGACYQsunOuwfNzrZ1Lj517jVjnJC3jmq7pp3M/+ug3x9wWJSHtOXNrE/OQdJm5D4dz+w3ztKMe
K5LxgezcdsWqzP3uFRqZtkPX6W1IHM21thJxrcMK2xyn2g4r7Ui/MdbcVP1mmb6UpgEd8zZvba4w
9KpFncerUFtLtxtxN/RdiY/eeQyfY4xc62k/TLHo9F0lta0Y0qzUuVGK+aPjju5ipeetFZueHWvT
po3fYBsWvnfsippdqfdHUXtm7lzxkXo4gppX2TlRZiN7PBFh599PXdF7rsikyw0L9Go9t5LOCtXl
ktnTl5txoBScNFDvy5LYWc/mvEWeu+B9YZ5HF2K/vcmRlLP2mHTuOin5KLmB3TDP3/po/57G0dd/
ueDZ57IPp/X/RbfGJfFdf/rzJofXvvXsuLfWf9527JiuDaxdKvVeleayvbT29owFz/579uG7U/79
0TtstsY/TG9rfJ49+5cL3jjTRGZzHj5dIPX8YlJbXc+C2WvPt/t5/x/G2xt0+7exaefXP7dgqqq8
ycCfd21Qtp2x38a5DsdNtqv6xubtPb6rpyPIYZ4/9nczKitau2rlL+fL1weyItB51bFdhz434v9f
97YNu97//5pIa/eqd0tX07XtJfvHHNn5y/kb1xrxsvPM6bP62X/O+nVJry2RFvr9+aEgAggggAAC
CCBQSYEox6yiClzva2v4slUsX768AvX6KDp69Gg/KzEfMCAzMD3m5vl5OcUQKF8gMzPT1yPvwp+u
efPm/fqZawxLj0t1z12PcXu0QGA68uUH47fsSuv/n4/eEZj6PGqJLYlrcLWpx8mzsY2uRYXpvpQ3
2b+95XphtVhQKQIIIIAAAgjUcIGKpBBu3NWQ5e5u3DRKIBBmAt27d4+OrpG/MtJsaXxZzrrFN+vE
VcC/1K2sB9MFvnKbNLtsX75T8i/zQXNh+CVtC7PPMs1BAAEEEEAAgcgUqJF/qkbmUNCrsBdo2rRp
nz59alyAJw2WZkvjywLH2OIaXNPPeyvzQLkqnbkjfdGvZ/e/Qy/kC2zNhr3htQRpdtm+xNmvNy2R
zTzL3NLc+jN056VV0raw/3TTQAQQQAABBBCIBIGImpkZCQNCH8Je4Ny5c3v27KkpUzRlQqZk7byG
dk7p69HFl2K/uR5zVaKgqCgVC4Xn9zh73frfNo71Fto5+3LNiC2Irn/VCIspmnWNbxNsl28yCO3C
/reaBiKAAAIIIBA6gcDOzCS6C91IcueaLPDVV1/JAtQzZ87II8LlSdth1RVJ1snDD2SHTPmfRatW
rfxsW3HM5WvRlyXGk6ecG/K4Acl2hcf3GFtsrL3uTdfrx9nq+9mXS1Fxl4y4q1F1rtuj7VYvzLDV
7Fc1vpaH4sVG2erav21gFDewV8OaRj8JKIYAAggggAACNUSA6K6GDBTNRAABBBBAAAEEEEAAAQTK
FahJ0R1DiQACCCCAAAIIIIAAAggg4EsgsNEdu6rwSUMAAQQQQAABBBBAAAEEIkGA6C4SRpE+IIAA
AggggAACCCCAAAJEd3wGEEAAAQQQQAABBBBAAIFIECC6i4RRpA8IIIAAAggggAACCCCAANEdnwEE
EEAAAQQQQAABBBBAIBIEiO4iYRTpAwIIIIAAAggggAACCCBAdMdnAAEEEEAAAQQQQAABBBCIBAGi
u0gYRfqAAAIIIIAAAggggAACCETZ7XYUEEAAAQQQQAABBBBAAAEEaroAubuaPoK0HwEEEEAAAQQQ
QAABBBBQAkR3fA4QQAABBBBAAAEEEEAAgUgQILqLhFGkDwgggAACCCCAAAIIIIAA0R2fAQQQQAAB
BBBAAAEEEEAgEgSI7iJhFOkDAggggAACCCCAAAIIIEB0x2cAAQQQQAABBBBAAAEEEIgEAaK7SBhF
+oAAAggggAACCCCAAAIIEN3xGUAAAQQQQAABBBBAAAEEIkGA6C4SRpE+IIAAAggggAACCCCAAAJE
d3wGEEAAAQQQQAABBBBAAIFIECC6i4RRpA8IIIAAAggggAACCCCAANEdnwEEEEAAAQQQQAABBBBA
IBIEiO4iYRTpAwIIIIAAAggggAACCCBAdMdnAAEEEEAAAQQQQAABBBCIBAGiu0gYRfqAAAIIIIAA
AggggAACCBDd8RlAAAEEEEAAAQQQQAABBCJBgOguEkaRPiCAAAIIIIAAAggggAACRHd8BhBAAAEE
EEAAAQQQQACBSBAguouEUaQPCCCAAAIIIIAAAggggADRHZ8BBBBAAAEEEEAAAQQQQCASBIjuImEU
6QMCCCCAAAIIIIAAAgggQHTHZwABBBBAAAEEEEAAAQQQiASB/w9EozVlMjr49gAAAABJRU5ErkJg
gg==

--_005_TYWPR01MB11862BFA542FA685652E73FA8B75A2TYWPR01MB11862jp_--

