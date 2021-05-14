Return-Path: <SRS0=ldVT=KJ=lists.cip-project.org=bounce+64572+6457+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTTPS_HTTP_MISMATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D64CC433B4
	for <cip-dev@archiver.kernel.org>; Fri, 14 May 2021 10:09:15 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63835613DE
	for <cip-dev@archiver.kernel.org>; Fri, 14 May 2021 10:09:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63835613DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6457+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id rGs3YY4521723xq90KswKPuO; Fri, 14 May 2021 03:09:14 -0700
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.97])
 by mx.groups.io with SMTP id smtpd.web08.6772.1620986951903639422
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 May 2021 03:09:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QsH8dBhZiw+V1i/+j2RiBXq64J0FSBEwfkBpBgWbQIVE1zOBAuYvAXm0eAbk0WrD/fFghx8teX6gbgFdolopKz8qovw50LFvj7+Dy/pGG8PLY2PVMWjh85R4P6V93A8KLRwdc0FWlUOryf4J2jG3xnCPy5O+OLI6nYvrR/NPUOjxbe7UReuRkN0QfOzcCtsJJCnd4aEK5ZD15MYQXVOQZmfu7dxCOOV3hrHxbUAImqpJWDFAiqSYZkA2brWKbnUflqwWbo09QsqFvfyrF7Wxb8MKpThrUed9RaeVgFetMZJMGoUX/8PxnE9KD8TgqbJYli3m8ep0C+eIqhkRIvsOug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCx5wgrZrNwshXHkHOHiMHVeYHDB5EGwSV4oO94Gt3c=;
 b=l/7adhrgX2YCxdYAi0mum4bLUSoMaFSCql3HsZqBH5+Q/kfCSf/L6lnnOZdq6lbzcOsJ02lFws8iwebTUrJR1Uz09boaFRIHCJYM/jlloHcizoEE4UjAOakgOlOBsFqHqT48nrtafmFm1PAvWuozs7MT4j4RNiGzgK6LVbIScSWtTkLS76YRFKq3q3nP65yh1EysmCPx0D2QCZDoLLAirdU1HDmeHnao+2x+sO0BpV+rnlZmbNb2M92qyrxREpNPXIrW3UvNixZcazFYiuL0QOiRQdzkEB9PPsaUSuEz94j28eT/8iViLlpVIr/R2J/nYUSrMc84ls3YEAPTHEbctA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
X-Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com (2603:1096:604:13d::6)
 by OSBPR01MB4085.jpnprd01.prod.outlook.com (2603:1096:604:4c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Fri, 14 May
 2021 10:09:07 +0000
X-Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::a947:6ea:f448:49d7]) by OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::a947:6ea:f448:49d7%7]) with mapi id 15.20.4129.026; Fri, 14 May 2021
 10:09:07 +0000
From: "Chris Paterson" <chris.paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] lava.ciplatform.org offline lab
Thread-Topic: [cip-dev] lava.ciplatform.org offline lab
Thread-Index: AQHXSHytt0yvaBucYEOkQDTtCPsqpqriwQkg
Date: Fri, 14 May 2021 10:09:07 +0000
Message-ID: 
 <OSZPR01MB6877C5FC46CF1D5583F09531B7509@OSZPR01MB6877.jpnprd01.prod.outlook.com>
References: 
 <CANgtXuNnyyN4cNCUmE_1-uZwGfgj4V-DVrYDCbgicdA0UJpAjA@mail.gmail.com>
In-Reply-To: 
 <CANgtXuNnyyN4cNCUmE_1-uZwGfgj4V-DVrYDCbgicdA0UJpAjA@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.219.20]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 10f660ea-d28d-4db7-350f-08d916c04f78
x-ms-traffictypediagnostic: OSBPR01MB4085:
x-microsoft-antispam-prvs: 
 <OSBPR01MB408570E7B110CD861F985C22B7509@OSBPR01MB4085.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 WKbYUctkzO94rAPJdHclToTxaf5Kc0LR+YmgOHqmqUAhFS29S/VPGntCwZ6NC03hHbO5lPdFVwhdusmVTGaLFwnq5I0kyCJ80tIKRfSfauXXz/a5aTC6qvJG6o3ZUPj8qOljmv+KamLNeXptcMygyPcR56BnH7K/5lzCqIDi70h012rmPidfiGkSxK10EyqVLF0uCwSA3Ho6JPuqSvLVHbJulcqZN+6cCV2gdwdBgh5OSoZ81ChbQxCEfIMRgzL+4nFZlickiW/c1Nk/NqrXMKTtqKorvKfZkxryX43i/IB+6QKG0fDhIip/7DLW2C8dzscuLWkjulgBG9S4T0IC95xPs5cnSsPolkIA4hJ66/HASOZ5Qdz5dGjuGZpk5jf1Krkbas3BShCnI6Jec6/8STTfgmiVYE6C2KlmuGAWap3r2gyV43+E9jMDlRxtTR2RW6up/2Xy57M1wBPzHsmHrHsWzVwv+QB8OoE/x1kqLtcUP8fV3/dSvhnpFEdNBd3IbUh6ubVl8O2kLDIXyOGysMP9DsYq5y5sF3YfYMzFDsHPOdB7yeMjQFaeUGN1P5Ne4T2Dw+psb4lXSGkCju1Ajl4wuwf8t+zKzv9n1kWALNYxWNlr+aNGpyqmZQTOaw4CMqvM6r7aQsQ8/Zi4yxdlPpiM8pSxFL7TgXKCTTf+p9xEli4E2cu544eyYy6/spgj
x-ms-exchange-antispam-messagedata: 
 =?Windows-1252?Q?/3EPqPgZOvU9yv2K+OCfcgX2MkhBdV6vakNk0ZiZXtcnTsWukAgmo6F/?=
 =?Windows-1252?Q?gORN0LLhwB5wln4iPLT4Z3A6k5QYQLcNzgo28wZRnFHn7R6B60GrA39s?=
 =?Windows-1252?Q?35vK83ltTr3xDzMNWl1aAPM9aDfHNfIETZ98E0aIIfjBbKYxsot4djrV?=
 =?Windows-1252?Q?QEw0JuqQLpn3eljrWrcIh2VONP7eBsth9wslUCoMcu4AuHoimzwSGq09?=
 =?Windows-1252?Q?iEkrXK8f2TwQBC5icV3cPeeSLbl+DeS2S4Y99FtCX6zPkJPYd36Vej6G?=
 =?Windows-1252?Q?q3wAqJgK5SN5WtF/mPqqWOsWB/Nktidhd55SSKCH2ZDVTRcscNzB2M3z?=
 =?Windows-1252?Q?YavFXuHGNzP5naWoeDssrVYC+OzlQADYd2lx5eEgkiV7JVt8LYOFDLIj?=
 =?Windows-1252?Q?uY6xCWx0t3hA0lcvGwTCAEUM95APb83JA7h8xfFSLtuCZtukNjxKUntd?=
 =?Windows-1252?Q?sUvBRDbFpmaXaEbgUy66L4NrTjohOE9IrwNVj+gfBn1PpUi7kP/L1igV?=
 =?Windows-1252?Q?UT+9LklLKJRkCLJK+OiskrS6teHijaed3nUtesrY4nsgKwTdtmmw1v7b?=
 =?Windows-1252?Q?B0VVikJnystQlrMLRTc3BYjbnUCqaTbMVDUkauloYoMp0IgN5K5ZFPLH?=
 =?Windows-1252?Q?1Z8osok8IZXf5lOtswGVrmdqHi6S+emtxnaI9+vfKJ8S3rAuekbU8kJY?=
 =?Windows-1252?Q?mIy8xusL8SLzTWcKQf0xbD8VuUk9ws6wsMmTZDSUkc91LkhmPFIfc3KA?=
 =?Windows-1252?Q?Qc9Bf4EeMO+wik3SvfC/0Fry4g3vRbQibZTH2o4/bQwD+rVRdFMI7+q9?=
 =?Windows-1252?Q?7C9bOF/n14N6b3sLqh9cJjF0umKXpG55HYQLzR2D1qcHU3hsKGUm48JF?=
 =?Windows-1252?Q?akvMqbMmYS4oBBMi50aSlXCwFh5bGyBfUGYtu3pVBJKvsRAQpyaMXMnc?=
 =?Windows-1252?Q?6LIiyIswsVPJLgJIJ08mTFdjLPcMSjl7Y9hucLU2MYVWBe31Ou1XoRfQ?=
 =?Windows-1252?Q?AMePQrD+60fEOzryU0M7o7YmULznaRd93diUiMMiSwAn7f9Gv0M/NtTz?=
 =?Windows-1252?Q?42xlGV6GsoGoV85qwtMgXKnKH646JEitdQeeMYna2bYA9LNeRU2rQ8LC?=
 =?Windows-1252?Q?2PI4bYtQZRG1tfU5LlOwpycXuvT6/6lTtcejd9QIdG+HFGwtEW8le6/r?=
 =?Windows-1252?Q?OnSoQhiRgCHjvApj1oM9S+8U0AX1ATdlEzjSMPLGg/3z/vGr4GWP8+BN?=
 =?Windows-1252?Q?Uk/ct7Dmt9/oRKwDuQjX6SzMnXx/FjKwFrHpo1JOYAQeeGT5ih21BTyS?=
 =?Windows-1252?Q?VA+2shA6Dcu5mS4+7dPp8qb5nrjT88ky4naEfaBpFwE9irzmXk3158qI?=
 =?Windows-1252?Q?QwPM/UGx6BJrFvkwgmBRwT2BBjyCvDl2VCsSwSaAgPgRwuD7xw7iuMPd?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6877.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10f660ea-d28d-4db7-350f-08d916c04f78
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2021 10:09:07.1031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y7/5OcIW7w1s2l6TAgtmwL/xpF4rarzptnHLuW5Oj5pd3QNDbQ5ZI2vQR7j0z64TzCE8eNByNkI2M1EY2KBj1nR0pe3DD/xxkLltxa3WAtk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4085
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: ILPAdtWq4RFIEdAPE2mYnfIjx4520388AA=
Content-Type: multipart/mixed; boundary="JbOLQ0ghQlsplknMQJ0b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1620986954;
 bh=YnsT9k3JCJh5OJOz+Pg9F1vFiL6eGDJn8JVdGHR9sGg=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=p7/Z5ZjI41sazDHDGCOj24mEPZYpAlSSKVNcMyWu6I+bfEUp1InFFx1BFIf/AhdDpsn
 2ba5DUTa3BOXRJZfcHZqHU3b4dzhJyITJGFF9W3k1oRsTWFIx0VR3ttVCngCCfAzJ3M9X
 +ZFiKtoWQNqmcdkQZzy9983nEti3MIcOyxA=

--JbOLQ0ghQlsplknMQJ0b
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_OSZPR01MB6877C5FC46CF1D5583F09531B7509OSZPR01MB6877jpnp_"

--_000_OSZPR01MB6877C5FC46CF1D5583F09531B7509OSZPR01MB6877jpnp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hello Alice,

Thank you for reporting.

I=92m not sure why all the labs got disconnected from the master, and I cou=
ldn=92t see anything obvious in the logs.
Perhaps there was an AWS networking issue.
All labs apart from lab-cip-mentor are back online.

Kind regards, Chris

From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Beha=
lf Of Alice Ferrazzi via lists.cip-project.org
Sent: 14 May 2021 05:50
To: cip-dev@lists.cip-project.org
Subject: [cip-dev] lava.ciplatform.org offline lab

Hello,

the laboratory on lava.ciplatform.org<https://jpn01.safelinks.protection.ou=
tlook.com/?url=3Dhttp%3A%2F%2Flava.ciplatform.org%2F&data=3D04%7C01%7Cchris=
.paterson2%40renesas.com%7Cfb00c6c7a66f4530bfe308d91693ceb7%7C53d82571da194=
7e49cb4625a166a4a2a%7C0%7C0%7C637565646351810270%7CUnknown%7CTWFpbGZsb3d8ey=
JWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sda=
ta=3DLFoGy0ZpLVDbKshUg7y903%2BT%2FMLyFZo93yELGE7vfBM%3D&reserved=3D0> excep=
t for lab-cip-cybertrust are all offline.
https://lava.ciplatform.org/scheduler/allworkers<https://jpn01.safelinks.pr=
otection.outlook.com/?url=3Dhttps%3A%2F%2Flava.ciplatform.org%2Fscheduler%2=
Fallworkers&data=3D04%7C01%7Cchris.paterson2%40renesas.com%7Cfb00c6c7a66f45=
30bfe308d91693ceb7%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C63756564635=
1810270%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI=
6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=3DpaQ8OvQ0TPXkSa5Z7AC88Knlex0Aij4c4sWh=
sgCmXJ0%3D&reserved=3D0>
any information on this ?

thanks,
Alice

--
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Cybertrust Japan Co.,Ltd.
Alice Ferrazzi
alice.ferrazzi@miraclelinux.com<mailto:alice.ferrazzi@miraclelinux.com>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

--_000_OSZPR01MB6877C5FC46CF1D5583F09531B7509OSZPR01MB6877jpnp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:#7030A0;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-GB" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"color:#7030A0;mso-fareast-language:EN=
-US">Hello Alice,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#7030A0;mso-fareast-language:EN=
-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#7030A0;mso-fareast-language:EN=
-US">Thank you for reporting.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#7030A0;mso-fareast-language:EN=
-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#7030A0;mso-fareast-language:EN=
-US">I=92m not sure why all the labs got disconnected from the master, and =
I couldn=92t see anything obvious in the logs.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#7030A0;mso-fareast-language:EN=
-US">Perhaps there was an AWS networking issue.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#7030A0;mso-fareast-language:EN=
-US">All labs apart from lab-cip-mentor are back online.<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"color:#7030A0;mso-fareast-language:EN=
-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#7030A0">Kind regards, Chris<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#7030A0;mso-fareast-language:EN=
-US"><o:p>&nbsp;</o:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0cm 0cm 0cm =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US">From:</span></b><span lang=
=3D"EN-US"> cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-project.org=
&gt;
<b>On Behalf Of </b>Alice Ferrazzi via lists.cip-project.org<br>
<b>Sent:</b> 14 May 2021 05:50<br>
<b>To:</b> cip-dev@lists.cip-project.org<br>
<b>Subject:</b> [cip-dev] lava.ciplatform.org offline lab<o:p></o:p></span>=
</p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt">Hello,<o:p></o:p></=
span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt"><o:p>&nbsp;</o:p></=
span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt">the laboratory on <=
a href=3D"https://jpn01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%=
2Flava.ciplatform.org%2F&amp;data=3D04%7C01%7Cchris.paterson2%40renesas.com=
%7Cfb00c6c7a66f4530bfe308d91693ceb7%7C53d82571da1947e49cb4625a166a4a2a%7C0%=
7C0%7C637565646351810270%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIj=
oiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DLFoGy0ZpLVDbKsh=
Ug7y903%2BT%2FMLyFZo93yELGE7vfBM%3D&amp;reserved=3D0">
lava.ciplatform.org</a> except for lab-cip-cybertrust are all offline.<o:p>=
</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt"><a href=3D"https://=
jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flava.ciplatform=
.org%2Fscheduler%2Fallworkers&amp;data=3D04%7C01%7Cchris.paterson2%40renesa=
s.com%7Cfb00c6c7a66f4530bfe308d91693ceb7%7C53d82571da1947e49cb4625a166a4a2a=
%7C0%7C0%7C637565646351810270%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiL=
CJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DpaQ8OvQ0TP=
XkSa5Z7AC88Knlex0Aij4c4sWhsgCmXJ0%3D&amp;reserved=3D0">https://lava.ciplatf=
orm.org/scheduler/allworkers</a><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt">any information on =
this ?<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt"><o:p>&nbsp;</o:p></=
span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt">thanks,<o:p></o:p><=
/span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt">Alice<o:p></o:p></s=
pan></p>
</div>
<p class=3D"MsoNormal"><br>
-- <o:p></o:p></p>
<div>
<div>
<div>
<div>
<div>
<p class=3D"MsoNormal">=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
Cybertrust Japan Co.,Ltd.<br>
Alice Ferrazzi<br>
<a href=3D"mailto:alice.ferrazzi@miraclelinux.com" target=3D"_blank">alice.=
ferrazzi@miraclelinux.com</a><br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_OSZPR01MB6877C5FC46CF1D5583F09531B7509OSZPR01MB6877jpnp_--

--JbOLQ0ghQlsplknMQJ0b
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6457): https://lists.cip-project.org/g/cip-dev/message=
/6457
Mute This Topic: https://lists.cip-project.org/mt/82817310/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--JbOLQ0ghQlsplknMQJ0b--
