Return-Path: <SRS0=fxYo=NR=lists.cip-project.org=bounce+64572+6704+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03B6C432BE
	for <cip-dev@archiver.kernel.org>; Thu, 26 Aug 2021 00:04:59 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C9DF610A1
	for <cip-dev@archiver.kernel.org>; Thu, 26 Aug 2021 00:04:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1C9DF610A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id PfoIYY4521723xPovl7o6zoj; Wed, 25 Aug 2021 17:04:58 -0700
X-Received: from ss11.sbt-mailgate.jp (ss11.sbt-mailgate.jp [202.241.206.52])
 by mx.groups.io with SMTP id smtpd.web09.23701.1629936294850294908
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Aug 2021 17:04:57 -0700
X-Received: from mail.sbt-mailgate.jp (sagproxy-out12.sbt-mailgate.jp [10.16.47.42]) (envelope sender: <masashi.kudo@cybertrust.co.jp>)
	(not using TLS) by ss11.sbt-mailgate.jp (Active!gate) with ESMTP id aI6r23738A;
	Thu, 26 Aug 2021 08:58:43 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LDLFyk5fA3t1IzKpdtLWe7EzFwybxHOECbXMWb7YJoHRkYdsLG7Rm5Nb6HUm5w5c6O1z8utaJE75q384gcmREkqIAglN8+0mHpDv8rQmfXqsOny39If5282262jS0UuQxZ4N6u5kpsjixMNkiTMcfdPrzaOKEPdYHvyikTrYClIrIJhuXITozmrszuDKa1ZnaTvyIINpxl0ISvlnib2ailK3uhLZhRMuAjSBGsm7kHD43PpME9RZyWtAe7YCPBjLI+WtgxG31YMlrxisZrdFNgtCUrWVhckB7LBgVwKRmVXY+orzoY2hEz6cROoYQUtosC+dS39YZ9xVIz3peQwIzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AnKszIqdJUJVmvB8il4MFQE1XFX7voQm5Vy5fpZVOcI=;
 b=H0rkBfULH+tkXz9Z8GZZ9RGgaoaiFueT4MetnmaOPtqgEDqb+oER9CEQ/TwKjDfNTJfMcO06u9Bk/z3NKdaiOcGNWliryj87okLDb7r8Y/+qutDhkGp6VT+8nH5aWMfE50/PB5/yJyNeV2qYG4SkfvjgRUE4U6HvtLshfAGFS99iuvx6ZvrDrCDQq2Vna0NL10iFgwIYrzgmgrAUMBOhlSDnATww59I+grrmFHCMQxZn13ZYVvGuSzgo5U/iDWGr24BIi+xvJ0u769oUrxgmEFePuKR+IWrxankKGCJt08FpAP519OU8rzKKurO4lwBVZKirHKD4tvcfurMh7yQXmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TYAPR01MB6139.jpnprd01.prod.outlook.com (2603:1096:402:37::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Wed, 25 Aug
 2021 23:58:40 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::f937:86f8:a385:7913]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::f937:86f8:a385:7913%4]) with mapi id 15.20.4436.024; Wed, 25 Aug 2021
 23:58:40 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Topic: CIP IRC weekly meeting today on libera.chat
Thread-Index: AdeaDQIpFK/RQTjfTSaej3D1Fuul/Q==
Date: Thu, 26 Aug 2021 09:04:47 +0900
Message-ID: 
 <TY2PR01MB4972B3EDFE8D7B0958416ED1A0C69@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 259e4cca-61cb-4e51-b20b-08d968244357
x-ms-traffictypediagnostic: TYAPR01MB6139:
x-microsoft-antispam-prvs: 
 <TYAPR01MB613987AE9E87EBBA24E28CEAA0C69@TYAPR01MB6139.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam-message-info: 
 Kff6ITbGxGNFrYBWtbrsujuDzX4FMK0VNRF1eiYsguJAn9kTDWK0iTwjvmEc32yHTLP61vvOa0lpe9bzxpMX8umJnO37lr3gb1KfKDepILYZ8KURezmzDCEQWFqrC7KrLMDZ/LYIdTeBtFZj0mAWRwp7wyKE9W5eFv5Y1wmlR4tjmbb9Cv6yRW+9B++JLdTU3ZUgMYIfzNVfvK0H4Kw/qvhI+WG0k8TazWIbA8aELDuzMmKF6Z4H2wU3k9p/Gy2mmOXiMiF3yoZaE2Rf1OAJF9CpssJ5omU2jogGUak6k+gh8o8rKCL4GpCOqAOPIHhgOzb5/AhnWmbQx9wmT7IADInXowwViDa5z4eCtu5m0l8RZlckRHMZR0rkdIrt79IGUonDlDookdPx5kHk5kMqsRAN+/zwNogULq3sIbfvxdDB89yS75i1DQlPfErZbmLEX1wCMAwnffpoOjZqu0S8HDXrrzkoAIMNaw/6tjH4N+zBZHHtEl3Qvc+qUwfKJW3c/IudWZIqu+oSobYM1b8XP3TYz9kqFiGoXhYull8+6GC2kTANA+ntzzgshxaGyuE2jX+maS7IS7NXqrhAWJWvNEMSPO/L6C1bMGctopCzYPorwY7B49o18IcCimpzzhouzCysPFwiE/LEp7f9OQBOxtPdkfPvMLER56zC0jdQMk9DWdWPVjwbSwF9Z6iylv2BpCICKhBDzY0CoSgbjkPotFuSl8u3o97iGJEsuJeuCPYmb7HW1lnHuCUarhVLrXL4gTEXo2sk+SWMOaF2mQdX9zgyxJrQJkiKGVOaBmPD4dESkSLoujkFvnycLmDIdfjwdTdP62LQWDcm1TbQOZmow3JlQ1pWI8mkiudWhjcaEx4=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?ZXJWMGh6UkV2aGprWlVYVTN4SGw4V2VuejVGaVdSTEdBQjIrMEF1Qnhw?=
 =?iso-2022-jp?B?d2NSeEFCUEsvb08wbmpKaEpscUhjakpIL3h0TXJzWjAzd3ROTDBHaEEx?=
 =?iso-2022-jp?B?WlFFRXF4bVpINGEwNlZ0M0dWM0FnQyt4WWFKRFEzNDZkVHgxeE0wbUMy?=
 =?iso-2022-jp?B?c3Rxc2s0U3BQbS9GSG9SK2ZaRUUwU2JjSXIxcHRUdG9BaWJHOHprNjRQ?=
 =?iso-2022-jp?B?MHM4T3FMM2htb0FIQ0pyaTFiRnFBQ05TSjVEbkU4QnF3NURIVGVwQkJp?=
 =?iso-2022-jp?B?aXp4VnUrMTZPOVEwdHEyY3pYY200VWVKYnpMUEVrTWE1RmZlSklSYXBq?=
 =?iso-2022-jp?B?eDBSanhXVStpeldTbGp0bmgwdGVWV3p0b1pYNWpFajBpVjhaN3pPa3dX?=
 =?iso-2022-jp?B?NEdaeUNmRUJpbHMwV3Z0UFRWaGYrZm8xR2xJMEJ6aVRlcVpISE5ENGZ0?=
 =?iso-2022-jp?B?U01iWFVsMVRDSTJtMENtQkpHNWFSQ0V1bGtiK2RNaFI4K3Z6TW1DdVcv?=
 =?iso-2022-jp?B?UEcvdksvZHVFc1RpMFBodGR1SFQyQzlpdFNMN1ZZN1NNWXI3T3hGNjlo?=
 =?iso-2022-jp?B?UEl6WmdKTHpvYWZNUjB3NTdWN1M1cHJGS2JzTW9ESStNanlJUVdZcHFV?=
 =?iso-2022-jp?B?aDVwU1JUbWUxblFPRSthREJFbTRCNGlPY1pPVGR5d1U2WGxzdmdaamxU?=
 =?iso-2022-jp?B?c1crYkN5OWczMitoTFRTa2NmL0VXZUtZZnZqTkx6TWxjN0FnWDYyYmdr?=
 =?iso-2022-jp?B?NHF0R1FmcWxPODU4ZVNTS2R1UjA2ci9JZFNhLzZ6WUkzd1Y4djI0M3U1?=
 =?iso-2022-jp?B?UmpPVkhWMW9MVXJsM2k4WTB2Rks0QmNMb1JGZkdkVUdlKy9xaWRwazJX?=
 =?iso-2022-jp?B?cWN4dzcxRVFGeGNGOHhpVERaTC9PZi9SOEZnWGswWURmVTM3ZStLbDR2?=
 =?iso-2022-jp?B?dDBhLytBZlh0Q2FmZTh1THNFRUwybExYMnUzOXNaOXAzU2F6YS9zR1Zn?=
 =?iso-2022-jp?B?MTk5NGpMbFlJUVJTYUxHa3NENEhNVjZUYzlndmNqTkFsN012Sy9Eb1VB?=
 =?iso-2022-jp?B?SDdvS1BVREgwS05VcWM2azN1MHlJWFhxMGNVOHZpSk1XUkhKNEJNWG9l?=
 =?iso-2022-jp?B?WFo1L1pHSUw2UUJ6OUFETXVnOFgzRE9QeTY0VXh4ckdZaFkzMVMvN3N6?=
 =?iso-2022-jp?B?MGFRUXNvb2dIOXB4ckpUMWU2ZEc2TVVIZTdRVnJzZjNERGM1c1RiaUlL?=
 =?iso-2022-jp?B?SHZKcHZoMDdscldCZ2N0Qm5TejA4WVlVL3FaVWw3dE9XVWZtRUtTY2pn?=
 =?iso-2022-jp?B?aXV2enNHaDlDQmR5VnBUK2U4NkhmaS9XQVZCMkZXUkVJNFpvUitvWDVu?=
 =?iso-2022-jp?B?aEFUYVhnK3pPbWdPZUJjV3ZrVGthekRMbWYzb0JFR3dWc3NzM0FueVpT?=
 =?iso-2022-jp?B?Qm9TWWxhUzFRZ0FndWp0eW93NXdwY2ovK1FQRXFaLzRzYy9GNlpsem1J?=
 =?iso-2022-jp?B?bWMrN3lvOVVYOFBHYzNUREtza05ObE5qZ0pNS3ZVQXlHOVN4OGw4VC8v?=
 =?iso-2022-jp?B?K093TTdGRGY0V0QyWFNNYnJRbXQ0UjFOWE8zaGZuZHU0aTdjYndDcXB4?=
 =?iso-2022-jp?B?WWYrTG9uay9SaGluVkZabjBWSGMxQktsN3o0SmRIRnRlNzEwZXlTVFBX?=
 =?iso-2022-jp?B?R3RweXlXbmlScklzeW5Pdi9IaHRDYmR0bStYUldra1J5TXg3TU01ZUlr?=
 =?iso-2022-jp?B?VGtreE9JVzQ0MHpPVVdnRHIrZk45emd5ZlAxc0FsRGdDaDZHWWNLRzZ2?=
 =?iso-2022-jp?B?cWZLclc3Wi8zSGhGS3BPdktjMmFqNnVkOWdHek5Hd2Fhd1BnZGI2TUJ5?=
 =?iso-2022-jp?B?MHNEMjNsdldVZW5NcUI4b2JjTjZpVmdPbXEzeDNRaGUrNTJRczNMejVV?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 259e4cca-61cb-4e51-b20b-08d968244357
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2021 23:58:40.6548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yCN9Le9kGoBA2ljs9BmIqS6766zXEGQXzuiZqVWlAiekiCDtbYprmUicrv9DtoKNKV2mJdxtvFX9cH9wSnyHrXKZ3xXv5MFY6g39qPitWVw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6139
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: oJUGwuk8iQp0nVa4deRnrFZox4520388AA=
Content-Type: multipart/mixed; boundary="pO9f7EW2mL1wj2ZFChqW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1629936298;
 bh=zCF6Y++L9UXGdvCSwNLU8eM8hkZ1sYY0v0DdNK+isWU=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=ZHY97Bq56Fjb9BUtgzJSaXa/SctgvVqSTWH//tI4mCZc6We76bZ5JsDMw0MLtsakcW0
 fiTPXPwuztl7lQ1i9lawLUq/PCvd556hH1tNkFaSdxo90F+dME3g8vQDW1Nn1iMQSWcLa
 6J/EMu5+9sI/VutGvU+DlJ5tegullYBokKE=

--pO9f7EW2mL1wj2ZFChqW
Content-Language: ja-JP
Content-Type: multipart/alternative;
	boundary="_000_TY2PR01MB4972B3EDFE8D7B0958416ED1A0C69TY2PR01MB4972jpnp_"

--_000_TY2PR01MB4972B3EDFE8D7B0958416ED1A0C69TY2PR01MB4972jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.

Please note that we already moved from Freenode to libera.chat, and our cha=
nnel is the following:
              irc:irc.libera.chat:6667/cip

Please also note that the IRC meeting was rescheduled to UTC (GMT) 13:00.
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2021&mont=
h=3D8&day=3D26&hour=3D13&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37=
&p5=3D241&p6=3D248

USWest USEast  UK         DE         TW        JP
06:00     09:00     14:00     15:00     21:00     22:00

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2021/08/cip.2021-08-19-09.00.log.=
html
https://irclogs.baserock.org/meetings/cip/2021/08/cip.2021-08-19-13.00.log.=
html

* Action item
  1. Combine root filesystem with kselftest binary - iwamatsu & alicef
  2. Do some experiment to lower burdens on CI - patersonc

* Kernel maintenance updates
* Kernel testing
* AOB

The meeting will take 30 min, although it can be extended to an hour if it =
makes sense and those involved in the topics can stay. Otherwise, the topic=
 will be taken offline or in the next meeting.

Best regards,
--
M. Kudo
Cybertrust Japan Co., Ltd.

--_000_TY2PR01MB4972B3EDFE8D7B0958416ED1A0C69TY2PR01MB4972jpnp_
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
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:=1B$B^b%4%7%C%/=1B(B;
	panose-1:2 11 4 0 0 0 0 0 0 0;}
@font-face
	{font-family:"\@=1B$B^b%4%7%C%/=1B(B";
	panose-1:2 11 4 0 0 0 0 0 0 0;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0mm;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:=1B$B^b%4%7%C%/=1B(B;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.17
	{mso-style-type:personal-compose;
	font-family:=1B$B^b%4%7%C%/=1B(B;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:=1B$B^b%4%7%C%/=1B(B;}
/* Page Definitions */
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
<body lang=3D"JA" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:bre=
ak-word;text-justify-trim:punctuation">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">Hi a=
ll,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">Kind=
ly be reminded to attend the weekly meeting through IRC to discuss technica=
l topics with CIP kernel today.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">Plea=
se note that we already moved from Freenode to libera.chat, and our channel=
 is the following:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
irc:irc.libera.chat:6667/cip<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">Plea=
se also note that the IRC meeting was rescheduled to UTC (GMT) 13:00.<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><a h=
ref=3D"https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D20=
21&amp;month=3D8&amp;day=3D26&amp;hour=3D13&amp;min=3D0&amp;sec=3D0&amp;p1=
=3D224&amp;p2=3D179&amp;p3=3D136&amp;p4=3D37&amp;p5=3D241&amp;p6=3D248">htt=
ps://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2021&amp;mon=
th=3D8&amp;day=3D26&amp;hour=3D13&amp;min=3D0&amp;sec=3D0&amp;p1=3D224&amp;=
p2=3D179&amp;p3=3D136&amp;p4=3D37&amp;p5=3D241&amp;p6=3D248</a><o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">USWe=
st USEast&nbsp; UK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DE&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TW&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; JP<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">06:0=
0&nbsp;&nbsp;&nbsp;&nbsp; 09:00&nbsp;&nbsp;&nbsp;&nbsp; 14:00&nbsp;&nbsp;&n=
bsp;&nbsp; 15:00&nbsp;&nbsp;&nbsp;&nbsp; 21:00&nbsp;&nbsp;&nbsp;&nbsp; 22:0=
0<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">Last=
 meeting minutes:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><a h=
ref=3D"https://irclogs.baserock.org/meetings/cip/2021/08/cip.2021-08-19-09.=
00.log.html">https://irclogs.baserock.org/meetings/cip/2021/08/cip.2021-08-=
19-09.00.log.html</a><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><a h=
ref=3D"https://irclogs.baserock.org/meetings/cip/2021/08/cip.2021-08-19-13.=
00.log.html">https://irclogs.baserock.org/meetings/cip/2021/08/cip.2021-08-=
19-13.00.log.html</a><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">* Ac=
tion item<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">&nbs=
p; 1. Combine root filesystem with kselftest binary - iwamatsu &amp; alicef=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">&nbs=
p; 2. Do some experiment to lower burdens on CI - patersonc<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">* Ke=
rnel maintenance updates<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">* Ke=
rnel testing<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">* AO=
B<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">The =
meeting will take 30 min, although it can be extended to an hour if it make=
s sense and those involved in the topics can stay. Otherwise, the topic wil=
l be taken offline or in the next meeting.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">Best=
 regards,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">--<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">M. K=
udo<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">Cybe=
rtrust Japan Co., Ltd.<o:p></o:p></span></p>
</div>
</body>
</html>

--_000_TY2PR01MB4972B3EDFE8D7B0958416ED1A0C69TY2PR01MB4972jpnp_--

--pO9f7EW2mL1wj2ZFChqW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6704): https://lists.cip-project.org/g/cip-dev/message/=
6704
Mute This Topic: https://lists.cip-project.org/mt/85150283/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--pO9f7EW2mL1wj2ZFChqW--
