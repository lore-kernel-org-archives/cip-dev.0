Return-Path: <SRS0=ptB1=L7=lists.cip-project.org=bounce+64572+6607+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379E3C07E95
	for <cip-dev@archiver.kernel.org>; Wed,  7 Jul 2021 22:55:09 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BFDE61C37
	for <cip-dev@archiver.kernel.org>; Wed,  7 Jul 2021 22:55:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BFDE61C37
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6607+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id DE1NYY4521723x2ZJQZ11GvX; Wed, 07 Jul 2021 15:55:07 -0700
X-Received: from ss11.sbt-mailgate.jp (ss11.sbt-mailgate.jp [202.241.206.52])
 by mx.groups.io with SMTP id smtpd.web11.4654.1625698505504408420
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Jul 2021 15:55:07 -0700
X-Received: from mail.sbt-mailgate.jp (sagproxy-out12.sbt-mailgate.jp [10.16.47.42]) (envelope sender: <masashi.kudo@cybertrust.co.jp>)
	(not using TLS) by ss11.sbt-mailgate.jp (Active!gate) with ESMTP id IHw403634A;
	Thu,  8 Jul 2021 07:48:57 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ahnG7KMQaCI1z10uB12Sx3QzSdjy9GuVZhvcIDQo55IFfUmHnGi/MxAek3aOBOlMAMf49Zn4x+ueEhTJ5jdU+R6hzHmSfglLIWxNAtq0uzL2Ogjv4Qguz+wFXSedsbPV6WKcBMz4wkH79oWgD4oSpXpFrXHOy6RL2d6Dq/vVYlFgSzDgqkt6BbWW5YqmtTP1hSZj7IHTxL1nVZn1QjpgEgnxDwBZbWRjjlB1ZgqUEc1w410idDKpoOm3iCaqr9TuhmJ/EJShcBSL/8A9VMA4lu4NmHo1i084xgZ1rw2I+uocWorvUFulii7Qu+E13jMVtu2zRYNtmir/UVzZTtQBHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPcygihf6kMl9K5UR3+Sxwogsr0mKUBe8ugbYN9vsEg=;
 b=Bb8E4Jw5Ed7uiuN3myUjt1hsMyIuP3wLlhA662FDxf1Hzd7Yz3Kslyna09K/vVtgZsvIDLScvToUsem9WGHMiKZ8KgjY2CBkwZcZGnagbVnccDCrQiOyfj2XL4WV0n2kfKiDR46hsIO4MKIomh0xg3546nMUiOWdtqIccT8FTQolLAugBnXZD6LGLxKhmijQeVtcphcrFTj8qm2nJivb1eOcKwveXm3SogtrDkwWGUrOklUxQV31/p6tcM7hRSb6g5yAt8gOuAz/zQorn/ge5ss3n9kTgxVdJ/2M1kJt+Oqa5jgu+qms6yaBNcM7PaNAfaY9TtI8vD0IYyAMAIQz7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TYAPR01MB3616.jpnprd01.prod.outlook.com (2603:1096:404:c4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Wed, 7 Jul
 2021 22:48:52 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::f937:86f8:a385:7913]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::f937:86f8:a385:7913%4]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 22:48:52 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Topic: CIP IRC weekly meeting today on libera.chat
Thread-Index: AddzgkE0peyPf29rQuuDrcZl5FPpCQ==
Date: Thu,  8 Jul 2021 07:54:59 +0900
Message-ID: 
 <TY2PR01MB4972CB38AB3FB4929740EC29A01A9@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a6163448-20cd-4cf7-dd95-08d941996469
x-ms-traffictypediagnostic: TYAPR01MB3616:
x-microsoft-antispam-prvs: 
 <TYAPR01MB361636E022BF10C62962AAAAA01A9@TYAPR01MB3616.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 xjhVylFm8jIvsSw26zZ2AUfb6IAL6mwE7AJsNEoJ6xO0F3S2eShysGJ/g2NlKsdLxM19YZoh61pZZH5o4WiNvzbLtGSrLiF5zUe6nQwS79vs/TdPx2KkgXxQoi8yLnJRNiKP/p2w8Rnm7FBvl81ZMsWHxHT9n1o8/9xTZlIZVr/Susq+OHMBWCh1lpdOVP4/HkHqcDKZYajsprSxf6V6a/eQC1j5UvTqk683TSyRBPoc6h2VxZdRqnpRDBvh0TMvlLi3eGaQyDiBgSU0LtwdMi233gGEKjRdFl/LLwhhHvCrMb0QWbPyMRzJY8DSgEzlCCqRibw0ixo4zymXtx8G+0gmzx/4NJT1ikguU5EsmXiOnYCru1i/2xwCPOn2zKKC7hGTDTTESimlL4S6cnAEEm6wkqzMtuDFpzpPto7DT4/yWLMLI8DG+hDsXHUq/FTscHYpKqGIgh2A0SpEpAc2XQAKuMfNEIqnUnBIiw5HIhQxk0ESN+F9Z4yOZEz2XeSX989QDSe82iv5od9Nbn3nPyPJKxvmFQGYu+C82ww2TflI+3nhffCTzIh5TgyCyd77npjPm4ozcxu3q6JoBn3JsTf9xMaWsn6jEOwkxRZkX9JNDakgqigByAoENfHT0QP8yVmN6ehCZZAIo7+rmxtLEMFR7ApYQ4u4oqMeHaB3uHDyVGSGjaxD/Syh1hC/e3lMXhyDCpc6bk9OpQaHP4t4DqVmmFn8K+kugPnaahnYY0H+nJCvJ6ihXHMX9BGfr+nQlCDwXQDi6lEbsMQzDd6RzSZ/4sd+9g4RXHYqvfj7DN2rfKbbUl0Xu3kc2GU4AHB4aQGoAMINN5TLY0MNal+SZQ==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?U3U0aE5wRFJpM2ZBMHJiSUppbUdKMVkwYVp4c2FnUjFXZGxyemc0ZCta?=
 =?iso-2022-jp?B?dTkwZG5ya0N5UFpaMnZ4aVNGSUFxNzBOVXVpOVQ4U0J2dU9kaFl3QWsz?=
 =?iso-2022-jp?B?ZnQ5RDJtVVRnR0ozM3pRZUZPbnFQR2E5RlNrVERJc0JpWjdsUkw4Mk81?=
 =?iso-2022-jp?B?TlQrZW1RdkdVd1Fkb09wKzhuY2xkRjNQbjc1bmtrWFlNelFZODdNOHQ4?=
 =?iso-2022-jp?B?ektQSEFnUGIyUTJ2azFteEZmYWNuQzRkdnBEeUJQTm9NbThmanBHc2hL?=
 =?iso-2022-jp?B?ZTBOK1YremVqNVlybnRzNTYxN2F4TlQxaVdWZEFxMGREcDYxSkNvcTQ2?=
 =?iso-2022-jp?B?bW5zSnVuLytabG5MazJ6dDduVEN0M24zR2RrOFBzSFNWb09kUXVHNTBT?=
 =?iso-2022-jp?B?K25rTjJUeUlvcldmZW5RMytmekV5Z3E0eThmT0orUUlDSk10Zzkrbk9W?=
 =?iso-2022-jp?B?U1RiZGpNYlkvWFNhQ3E4b1k0UXBpNmg0NXNpWERaY2t5Rk1VUGFSUTMw?=
 =?iso-2022-jp?B?WFg3ZXIwUHZVcVphcDNUWXNpcWRYR2s0WFNEalhBb1VJK0JKdVp5K1Y2?=
 =?iso-2022-jp?B?UXVEMVhZM3VsdjRpVzM0RXdCY3VSME1QREtXRXRKWFZkV3V6Qk1ub2ts?=
 =?iso-2022-jp?B?dlFvSWJvcldHUmZUelhlYUM2RzVBQXRzR054SGJBVFhvcEg4aVBxN1E0?=
 =?iso-2022-jp?B?MWZJSXJLNVUxcEtqQk9nakRIanN0WnE1eExVVnNTMFpNZVpBVUMrWkRL?=
 =?iso-2022-jp?B?RnU0Rm02a0V5ajVkem9KUmtBNUxuNisxS3U1eUJjTmpwdloxSTg0UU8w?=
 =?iso-2022-jp?B?UkwzRGV0amtDWS9Kc2t2U0NEMUdOc2JnV1gxazhQNnJlMDJhWEo1MjRR?=
 =?iso-2022-jp?B?K1hBN3JjMlJZRU51SmRRUk1NRWJ2Q2M3Vk5sVDVoQXpVSDIvRVl6NkUy?=
 =?iso-2022-jp?B?MlExWklEZkQ2SVVCdlJ3d01XMExSQXB2ckNGRUlXbUhnNXZSV0ZaRzNz?=
 =?iso-2022-jp?B?eDFubEtIL0Nid1Jvcnl1dGwrMVJqVzI0QThOTzdiUDFLd205NjBWRllF?=
 =?iso-2022-jp?B?UmQrNjQwV0k2bEN3MkV4aStmbVpnZFZLRytOakhmN1BwK1phRit6QUJj?=
 =?iso-2022-jp?B?eFVOTVI4VkhabWdZTzdaZ3kza3J1M3BhRy9DVlgzc3VPRFE4YWF1WlVh?=
 =?iso-2022-jp?B?Tittcm5XQXBSRUJHa29NK1kvSmdkdmRwdEFsQndQcVNHWXBveGJ6YzFj?=
 =?iso-2022-jp?B?cTVPZm9wOHpTc3hkTzNBVTlBZWlLaVpZYm1EdkxaSGFFbVhRQmRlMjY0?=
 =?iso-2022-jp?B?VlpuS291d0doQjVjRS9DS05qcmVqbDJhRWpMRjNITm5tT0dzYUExakpI?=
 =?iso-2022-jp?B?cGNtRHBLVkwwdmVHRTNKeTNPZHJsekxhK0hxY0U3VmJWR2NEMjVVVXFZ?=
 =?iso-2022-jp?B?RjhIQjkvajNFQUgvZ2NzWEx4V3dORmNvTUN3NjlBZjB4WWxpSW9BZ01V?=
 =?iso-2022-jp?B?L0NGYWxIbVNONHJkakZsVnZSeU1FVGozbXU4c2dOTXFTMFQzT3hRVmUx?=
 =?iso-2022-jp?B?c1kvdGdaY1RTaUpja3VWWEErZ012Ukk5Q1dyUG9pMHgrYlNaNGk3YWdB?=
 =?iso-2022-jp?B?YlBQZGtkdnkvdWhDcUcrOVJUWk8wUnlNWUpzeTZBY2kvTEtUKzZMMG40?=
 =?iso-2022-jp?B?TWRmR1BGdEoxTVJnaGFoaDIrcnY2aWpZbEdqS2RMT3FUSDRiMWFqMVhD?=
 =?iso-2022-jp?B?cHVyNzk4T1pFeEhmeTBWU2QzajlCRUtSNzBhWnFBTlpsMEZnZFlIa2Rj?=
 =?iso-2022-jp?B?Y1c3bnBpR1JobkZiUXYwZ2k2TXArM2FRMExEd3RWaEs0VStOWjBSNU80?=
 =?iso-2022-jp?B?WDY5MGZBRzBQVGZ6cnNiM2FEcnVJZEpjbUxFcGNhcy84K0pMbEw0VTls?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6163448-20cd-4cf7-dd95-08d941996469
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2021 22:48:51.9477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OrckiGn5MOyPSLpWtS8os2bjuUExwSmKc1CczQnjri99DR1dce9KLaJ+17Ry6tDE7txFAZtwoAlKIl+I7LlEoGk8EixjCDlF5HJeqoVN2Ms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3616
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 6inpGH6ScrKxvMeld67wkFtwx4520388AA=
Content-Type: multipart/mixed; boundary="QMZXODM0VoyjNb8V8CFH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1625698507;
 bh=aLU8fS0UzkFl7rL3SzihLwQSSfHjv62CNBS3KEnSnSU=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=hh5gqotdTArJr3v9ootFRhMVa3ZLYSDVE+rdaIcyD6Lv/4Yt7hp6+9/Tfl3ka8tsI+v
 LbsbCPuHexyAj3QQv0FwK0jrBGvvYapRyPqglitbxdJxFq4MeuEktvPKYZG3dZAsy1Y3J
 twmQ2XhAnb+OdxtlngFr9JJXaEoJdt8prZ0=

--QMZXODM0VoyjNb8V8CFH
Content-Language: ja-JP
Content-Type: multipart/alternative;
	boundary="_000_TY2PR01MB4972CB38AB3FB4929740EC29A01A9TY2PR01MB4972jpnp_"

--_000_TY2PR01MB4972CB38AB3FB4929740EC29A01A9TY2PR01MB4972jpnp_
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
h=3D7&day=3D8&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&p=
5=3D241&p6=3D248

USWest USEast  UK         DE         TW        JP
02:00     05:00     10:00     11:00     17:00     18:00


Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2021/07/cip.2021-07-01-09.00.log.=
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

The meeting will take 30 min, although it can be extended to an hour if it =
makes sense and those involved in the topics can stay. Otherwise, the topic=
 will be taken offline or in the next meeting.

Best regards,
--
M. Kudo
Cybertrust Japan Co., Ltd.

--_000_TY2PR01MB4972CB38AB3FB4929740EC29A01A9TY2PR01MB4972jpnp_
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
h=3D7&amp;day=3D8&amp;hour=3D9&amp;min=3D0&amp;sec=3D0&amp;p1=3D224&amp;p2=
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
s://irclogs.baserock.org/meetings/cip/2021/07/cip.2021-07-01-09.00.log.html=
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

--_000_TY2PR01MB4972CB38AB3FB4929740EC29A01A9TY2PR01MB4972jpnp_--

--QMZXODM0VoyjNb8V8CFH
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6607): https://lists.cip-project.org/g/cip-dev/message=
/6607
Mute This Topic: https://lists.cip-project.org/mt/84056769/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--QMZXODM0VoyjNb8V8CFH--
