Return-Path: <SRS0=mLzr=MH=lists.cip-project.org=bounce+64572+6622+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88490C12002
	for <cip-dev@archiver.kernel.org>; Thu, 15 Jul 2021 02:34:54 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE589610CB
	for <cip-dev@archiver.kernel.org>; Thu, 15 Jul 2021 02:34:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE589610CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6622+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 7Ge6YY4521723xhot2iW3hfg; Wed, 14 Jul 2021 19:34:53 -0700
X-Received: from ss11.sbt-mailgate.jp (ss11.sbt-mailgate.jp [202.241.206.53])
 by mx.groups.io with SMTP id smtpd.web09.2862.1626316490478992303
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Jul 2021 19:34:52 -0700
X-Received: from mail.sbt-mailgate.jp (sagproxy-out12.sbt-mailgate.jp [10.16.47.42]) (envelope sender: <masashi.kudo@cybertrust.co.jp>)
	(not using TLS) by ss11.sbt-mailgate.jp (Active!gate) with ESMTP id PLcq00300A;
	Thu, 15 Jul 2021 11:28:42 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IK32CeDo6jK1jcqW3/0tvkvLZoIt2oBT6s9rKm+O6RuQKff6drnLFVRQjW4nvqQB+hiO8KPWWrzevPF0W8VrZavXGht7Qj9rzgF9hIWKW5M7ABo8QOwXYsU6I7N9jtHGQLFzufXpzVuspTVOHK1rLs+QT5yXdcsS7ea4Ur16gR/XWKNMqeOb/GGqdrRUNV+t+ksfcE6LE+d3kZYlM7nd/HTGgQYxsqMLe3zZS08gvZPYDm5z4M6sHjZY3qmihJsUqXgm8L8mIug3mcJh5XHwWUs7tuUIc9R+qNmGChQT/7NpEbFVMCjgQxzmh1nuEKg61aIShDA/fyHeAstaihZ4Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXrb3FndDBnLofR/VAAByKKr6Mp/svKQ9g9uvKV0sZs=;
 b=JJB7mpYUf8S1WpMCvKJpIcmxRWDlPgWpFdGavOlV10ggjxCbGwMFsK8LsDhzk7uu42HJZShOBcT7SDH9tu3+B5HBHja9UKDJcaRKbFSkpuoW1Y6wU6PSIrb3tMx/6wKSH3zYhkU1yZ4vUERfPf6OSW001Pyfs3PC+Pn/5jJV1APb1VDz2I+6/CV73Jks9TG3BMzpr+/JrlonYpZn79lAEgr1Vc1kRCYocBiFb1R4CKWxAp164li5ayyYdzReIjRju4ND7gDl5GxawDumCKIo2cYRQbBUpm78nHP+L8PYeXWLfQqF9tca6imdaE1Gnol0FM4OtZcDUS5tOcbKSYOPYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TYCPR01MB5853.jpnprd01.prod.outlook.com (2603:1096:400:b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Thu, 15 Jul
 2021 02:28:32 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::f937:86f8:a385:7913]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::f937:86f8:a385:7913%4]) with mapi id 15.20.4331.023; Thu, 15 Jul 2021
 02:28:32 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Topic: CIP IRC weekly meeting today on libera.chat
Thread-Index: Add5IQribyGyIPQWS6WDd4dBoRnLoQ==
Date: Thu, 15 Jul 2021 11:34:46 +0900
Message-ID: 
 <TY2PR01MB4972D0C6047430EB9C93E2B1A0129@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 192c9b6d-6007-49a5-a6a9-08d947383d36
x-ms-traffictypediagnostic: TYCPR01MB5853:
x-microsoft-antispam-prvs: 
 <TYCPR01MB585379FEEA52512C6BCB0360A0129@TYCPR01MB5853.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 almmJMaDL5XnLhYCvgvP93u63CdoTxe2cY3W0qphLvWyeQncAaVD7A53jd8gQ6OHuIIutxBbc/ioL6LZBq4Pk4Inb1FhLdt62FzgG6KEnBDFgz7sPxUC97ewRFZQ7bcdgKnHWXY9s2uJvDoSECQ0ItBITET/t3EzTS+RiE43BFmb8GRBFzJuIycTuf64LeCj6Z5v8AFgZ+oaIbRGB4vz1D2lNuZKchw3ArQ8SwL/d78zpw1W0hDHNCfNyZnEST5K1e+vHJt7BooRGYxRdOlezUa3nsLEZ6zz2UhSAmcvtiLiEm198rcUacWoNYOMXdgfvdl6YCON+eoZmYfVk+T/GfCZ/5G+RWAEdHzgjY5ZqN4xW6A/7A2ONbJOlpnB9uqBXPSi5FLqHWqVqQsirw53MZ073U6i/t3ZXdctTzXyG9ITwqaQuhtBojxh3A2zdPTBMzuN88mmDcsOWEeYCrrPRoz5HOaZK1CDyDTzHh9/7TYaLA14zSv+o2ZiJiyeIjjzI4rQQv0TgCKZdmdYrD4FrPN32QbfcD+2JVhb0b4OHv+IpM8YoFyP41IeLE8oWwWz0m3vvzZHGv3GHc15DQFQdDnzI2liP2AtvKdN6j3lv3GUgiKdsqbE3J0UAscAxe43IQ6krlfheGYLP4tzC/Y5eO1edTVNuvIjKGofvCGVwnoIOOoLuRke4JmC5STvnCMlSQE5fPc61rXrCDoR+J6Vsjfjw7Ms43XcwXaJajBy7LZxM01qKaRXIKvqY0TQTuSb7PuGJ8ddE6JiwD9zFyd7GGWaXCjz8wnoqRsJEP4/VoRdRTdb/EQ/ZsLuXewFadHS+xy/BiVcn+643qnVWD0YSgWnSCt+FyRtm41irktCf3A=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?dTdzQ25yNTFyeml3SWJ5aXdublQ3LzBkM2oreU05STVKQ05keU1FNG1m?=
 =?iso-2022-jp?B?U3haeDRPblNtbkFrNm9sTjErd29kR0V1QmhVa3UvdG1RTUxyU1dFZXd1?=
 =?iso-2022-jp?B?TlNZWVFLT1NRVmNaNWY0YTZRajRta0NtcmVOR0F2dC9Gc29VS1ZRd292?=
 =?iso-2022-jp?B?Vk5BY1poSGVwWjc4STNDNjYwTm5BZXA5Zlg0WmlkKzhacnF1YXBhUzN0?=
 =?iso-2022-jp?B?T3FxRlprSGhLbzNtUGZYN1F3RVFWUGt5UDZmZHoyTy8rd0l1WGE5YTVB?=
 =?iso-2022-jp?B?cCs4WmdTVnBNT0N2Y1QyeFgxYVNpVlM2UWtNdDh3RGlsVTB1MUZmeXVW?=
 =?iso-2022-jp?B?MTFwbFNwclhpVHdKSG9rem12UUpMNGtBaXk4V0dudHl5eEtUQzlSSm5Q?=
 =?iso-2022-jp?B?cUxuUGlDL1Q2NEJkWEVFQk9QTHI4YStPdnBnZHp2a21MY2o1c1JhL1k3?=
 =?iso-2022-jp?B?WWdpUjFBWU51ZHNCNlVSLzFxNEhrT0NwTjVCaFpZdjJwNkhxRG1kL0tW?=
 =?iso-2022-jp?B?N1U2dll4aWFnQmNHYnF6YnVydWJMNVpkYVl5dkRIRkU3akRBWEhUWjhn?=
 =?iso-2022-jp?B?cERnZjA2MVBjWE5tL3FnSkZGbGRhSWhJOUNic2FSdzJjVjhIbkV1a3Zq?=
 =?iso-2022-jp?B?bSszNWYreVdhdk9TbHVsV2IvQW5DeHo1dVJRZFVJTlNHb3VrTHIzZm44?=
 =?iso-2022-jp?B?QkNNZm0vZTZER2tiR1MwMEVUQ0NCcG84eWVRMTJWRTU3RXNOcFpoNXRQ?=
 =?iso-2022-jp?B?YVk1Y2p1d0FXcktGVEJsN04vNmVCdXVya3Z4K0lqekdybks5aHprUXNt?=
 =?iso-2022-jp?B?YzFNZkRxc0kyK05FZnJ0aHJhK1k5emkrSm9ZVXR6T0V6Y3ZFSXo0K3pP?=
 =?iso-2022-jp?B?MjJvbVA1a1lNMExpcGZ5YXhieG5Ob3Q0OTVwVjYzajlqTldyQnphS3E2?=
 =?iso-2022-jp?B?WUw1RlBoY0x4aGJoemZpYllXMmF1YWJoSUVYSnFSNzRFY0NzbXpaT3Bh?=
 =?iso-2022-jp?B?TytHSGEvUW8rdWkzNEVHZWkraUtCZzd2MldRUlJwL3pCSDQ2amhEY1U3?=
 =?iso-2022-jp?B?SUV5TUhycFhLT2lTRVBsdVBuK09FYjI2R3hmQlV4R2t2c2FwQkZOSFRu?=
 =?iso-2022-jp?B?ZW02SDRlUUZCZDNIa0tOZzBNQi9nQlFMVEhXdmZjYjBibUJVRENIaW5p?=
 =?iso-2022-jp?B?L0hpM0pZdXd1OW4yOVg2TnhYSk9laXl2Zkg4SmNVcVFVQTVVQlpxQ3pK?=
 =?iso-2022-jp?B?cVBFUnM4aGEwbTQ5N1Q5ZUdnNHZEeThpcC9NeGxVZHQvNEtzeGxrc3M1?=
 =?iso-2022-jp?B?NXJPaTNjcUpLSThJbitvUzVLVXBzelVOaXdOQWxpUUl2RUVnVlhUUlZn?=
 =?iso-2022-jp?B?ZEs2YXlZb1VGTGQ3VjlVdVlWL0NBMEcwZUIrdGZWT1hkSUFFRGpZZzk3?=
 =?iso-2022-jp?B?RnIxYnl5R253OWhzcERoSEpEcGowUXhIS2dNZUZyZDhkTEs2bVFQZ2JC?=
 =?iso-2022-jp?B?bnJySS9QTFVJNW5oQ01PMDB3ZnpJemVSRUYwTlB0UVVCQ0x1QlFubzUv?=
 =?iso-2022-jp?B?Undhb24yVFlMUkQ4cFRObEtiQlZZclBtRzBleTBrMGJDM3lNb3lwcWE1?=
 =?iso-2022-jp?B?YXNkbkZDTmpvUVhybFZDUHF5bkFvbVpwZ1FzcnVBS1lxSDNUamhCUUVm?=
 =?iso-2022-jp?B?ek5qUzJHWjYyanIzR2oxdWNjbU42MDUvVnFyYlZCYS94L3JRSGw1QnBR?=
 =?iso-2022-jp?B?UldVSnhkaDZzeXFEN2RGcm9sQVJDNUlWY1ppSHRzTmlwd0JCaVBsSExp?=
 =?iso-2022-jp?B?N200TEVvWkc1dmJCT25DNHk4dkI1TjVMVjZCZ1ZtMDhKSWgyNGZkYlhL?=
 =?iso-2022-jp?B?bGNKbFdUMHh0OGhEbWNKZFlMR2JjaG1oRlRGdXNjRHBVZU9udkNFTEti?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 192c9b6d-6007-49a5-a6a9-08d947383d36
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2021 02:28:31.9758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FbzoIiglSrL8xsllq6FlncOlxRDO6zwb33wsrYD58uzzneqYD47ARReYt0nugZoM3URhtSi4Rz0pN69Ba3aa5r4h+dx99x5VNuAsEuJlE/U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5853
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: DmVTH9TUPsalbXlVtkOSsmTex4520388AA=
Content-Type: multipart/mixed; boundary="tq9y7lCMICa7KkDg2cGW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1626316493;
 bh=CASp+gQTPHeKZg6mTBRSq8c4WxP5jftXHQANDj0K8mI=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=fRBErpbTX4EJGdT5QtI+QVUz3EHCstY4QmR+J+NR71NKpTbkQGPXzmT4faM0NABLJmu
 ZHnQgENBQMEONGrZOSemf7io8D/v0T9eWQxfuD+KQ0bOIRGIljIQPe2pKHqiMW6RbDxse
 300Rw3ysKAgGo4hMbcwmqX0d4UYBcK3gx24=

--tq9y7lCMICa7KkDg2cGW
Content-Language: ja-JP
Content-Type: multipart/alternative;
	boundary="_000_TY2PR01MB4972D0C6047430EB9C93E2B1A0129TY2PR01MB4972jpnp_"

--_000_TY2PR01MB4972D0C6047430EB9C93E2B1A0129TY2PR01MB4972jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.

Please note that we already moved from Freenode to libera.chat, and our cha=
nnel is the following:
              irc:irc.libera.chat:6667/cip

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2021&mont=
h=3D7&day=3D15&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&=
p5=3D241&p6=3D248

USWest USEast  UK         DE         TW        JP
02:00     05:00     10:00     11:00     17:00     18:00


Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2021/07/cip.2021-07-08-09.00.log.=
html

* Action item
  1. Combine root filesystem with kselftest binary - iwamatsu & alicef
  2. Do some experiment to lower burdens on CI - patersonc
  3. Update Testing table below with 5.10 info - patersonc
https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptesting/cen=
talisedtesting/cioverview


* Kernel maintenance updates
* Kernel testing
* AOB
1. 5.10/5.10-rt kernel configs

The meeting will take 30 min, although it can be extended to an hour if it =
makes sense and those involved in the topics can stay. Otherwise, the topic=
 will be taken offline or in the next meeting.

Best regards,
--
M. Kudo
Cybertrust Japan Co., Ltd.

--_000_TY2PR01MB4972D0C6047430EB9C93E2B1A0129TY2PR01MB4972jpnp_
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
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">*Ple=
ase note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starting f=
rom the first week of Apr. according to TSC meeting*<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">http=
s://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2021&amp;mont=
h=3D7&amp;day=3D15&amp;hour=3D9&amp;min=3D0&amp;sec=3D0&amp;p1=3D224&amp;p2=
=3D179&amp;p3=3D136&amp;p4=3D37&amp;p5=3D241&amp;p6=3D248<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">USWe=
st USEast&nbsp; UK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DE&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TW&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; JP<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">02:0=
0&nbsp;&nbsp;&nbsp;&nbsp; 05:00&nbsp;&nbsp;&nbsp;&nbsp; 10:00&nbsp;&nbsp;&n=
bsp;&nbsp; 11:00&nbsp;&nbsp;&nbsp;&nbsp; 17:00&nbsp;&nbsp;&nbsp;&nbsp; 18:0=
0<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">Last=
 meeting minutes:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">http=
s://irclogs.baserock.org/meetings/cip/2021/07/cip.2021-07-08-09.00.log.html=
<o:p></o:p></span></p>
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
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">&nbs=
p; 3. Update Testing table below with 5.10 info - patersonc<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">http=
s://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptesting/centali=
sedtesting/cioverview<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">* Ke=
rnel maintenance updates<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">* Ke=
rnel testing<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">* AO=
B<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">1. 5=
.10/5.10-rt kernel configs<o:p></o:p></span></p>
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

--_000_TY2PR01MB4972D0C6047430EB9C93E2B1A0129TY2PR01MB4972jpnp_--

--tq9y7lCMICa7KkDg2cGW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6622): https://lists.cip-project.org/g/cip-dev/message=
/6622
Mute This Topic: https://lists.cip-project.org/mt/84217417/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--tq9y7lCMICa7KkDg2cGW--
