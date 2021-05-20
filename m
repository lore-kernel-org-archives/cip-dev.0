Return-Path: <SRS0=CBEG=KP=lists.cip-project.org=bounce+64572+6468+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37B2C433ED
	for <cip-dev@archiver.kernel.org>; Thu, 20 May 2021 02:45:58 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6C57610CD
	for <cip-dev@archiver.kernel.org>; Thu, 20 May 2021 02:45:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6C57610CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6468+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id L8R0YY4521723x2BVZPSmBvt; Wed, 19 May 2021 19:45:57 -0700
X-Received: from ss11.sbt-mailgate.jp (ss11.sbt-mailgate.jp [202.241.206.53])
 by mx.groups.io with SMTP id smtpd.web08.3230.1621478754528465426
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 May 2021 19:45:56 -0700
X-Received: from mail.sbt-mailgate.jp (sagproxy-out11.sbt-mailgate.jp [10.16.47.41]) (envelope sender: <masashi.kudo@cybertrust.co.jp>)
	(not using TLS) by ss11.sbt-mailgate.jp (Active!gate) with ESMTP id ULnt11135A;
	Thu, 20 May 2021 11:39:45 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M84c4oET9JIQ8RuRv0Uqd1klAHvMCTsVlTzB+5AA5cqAZpB4PlaKQFMEdoT0eie9NsD15pSGGNWeFDDr3bCmTVLc9MydQ21iIdG7M9BZbv2PPNJNgcHVh5tQ0FJyNVNVEQU9D2OK061QIWJv10M+zqYiST64AvPP/78A0GeS5HBJd7mFxD9g2PENFQWHv8JY7IsbEjBw9FZXMKJPSUafD5G+nnNm70DMBq26Ar00FIVXX9xQdZs6z2dlcJPt5+Nw86ACrq2tuIhgv4OSp7HtIHX8v1uzRDyFiWnFNDOP7hla9ioWzP323uRnhRrOjkIOINF2xXmmZesCrwlYUZax8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yfTPEaD77TksmQTLmn7pAxpSoBGy2LPX44mH5jOhDqM=;
 b=ebNzFRPUqXigkMzkHiqdTNmKKIwAS929VMjsxCfqdCFplHWlx7Q9lVSqKnFTdQ0hv7qXWfbzO3J+K3FjKx0o1onI6T+ZmelUJXHg1Urd+5chJg3vLNftkak0sKmFbxhpl2jTHxUNDRBQccdV6t9o8DWWKtT0/c0j8CRa8YTgY1ojZKY+N+cA78fimYh0fqWfa78w0/M4nJauFcKlN+HbuMDgVt53Y3zps1WQxNWo4Hy2VqFXZRYGSRFGOIuBlNxUzl+r8DhYnX79tk6bloi6xYqhF1SSTutP/R/TReSU2jAnNGnXNttTDbMFe2Fk+fdkb95vURyJFnmm17ZfDAiTVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TYAPR01MB5338.jpnprd01.prod.outlook.com (2603:1096:404:8030::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Thu, 20 May
 2021 02:39:39 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::4cee:d78:d8e9:8a0]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::4cee:d78:d8e9:8a0%5]) with mapi id 15.20.4129.033; Thu, 20 May 2021
 02:39:39 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AddNITZ/wlNnVxTiR7Sk6vRRDAXyew==
Date: Thu, 20 May 2021 11:45:48 +0900
Message-ID: 
 <TY2PR01MB4972884F2C226E1D81FD7F7EA02A9@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c65b3711-bed8-49c5-5585-08d91b3883bd
x-ms-traffictypediagnostic: TYAPR01MB5338:
x-microsoft-antispam-prvs: 
 <TYAPR01MB53386B34B80248607D4B783BA02A9@TYAPR01MB5338.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 fvOkIg7svU2ww9eiRpeYljWBWunDIw5qG1gNBdqX+4ZVErpuIWxguCx0u5ZfQGp+oYtvsfhy7wTVEqEk0TRIoCKjurYBhGFqx6yLzEcK+d93jN09Ns1+9n/Jm79YOJGTrcWpA+YhAiAGR1df8vUMxyhw0gtImhFJ2wmFjAhrnmRdLeVmk0aOm1DuNwhy1OrZ209q1f1R9Wv9ECAs0mAFxGz78JGklmPYfCbs7X8tg5S+LIMxbeJM/j5ZbObfLiawXsIcP9lTQuMc1OXi3YbiX3k3s3Ddqi8h56OjLee8SRAOc1pdVXL2tFR8xOg/L0Q7zJgnXYAjN9Hi4BSnEn3oH2rIPU0NOahECq1vPBF5NDIf9pyrADiBzMDkaDFzezZ26MChdImx4uzgps/LXLcGnEKg20KmBYI6OETytwvB0qT/WoImVcmPksdy4Q4hIDhIu/TEZz3N2nt7IfkXSnhTJj99EHDFsYo1sCAorVSXSH695poCmSvbQnSFMLswz1vkkPMaN+LRoogYhDPOXlFPwCWMXrBbZLt02N4SdpxIZUv3ML7f+pulfnKlIGS4zPGhw8Pa01rf3R2DoMsi4cHnr0LLRD3o/we+gzONcMn7gJQh3iyMj6EYMtZt7smH8YJ6JoRaQ4/DdOcc2nxvliBYRonO5rb0WIJario0GM0d6Su8uWhRHr1hXCc8phNpwO7kCWX1y02c2J6EfYwsViUTFGtCFBFwVr2DiQmfg7fNZtT797DW0BxdKlEgoPLW36A7
x-ms-exchange-antispam-messagedata: 
 =?iso-2022-jp?B?cWRGUE1LcmRqeGl2MkxCWVpYWUwrcEZSRWJDZ216Vjh2Ym9zN3BsYTZ1?=
 =?iso-2022-jp?B?eGRFUTZSUlU5d3JMbVlZV2RuKzhXZXBUdkpZUU1ZeW96MTcxMmI3bkhz?=
 =?iso-2022-jp?B?OUNLSnNMcm1sOE1MS1FRSzJUWitzd3JZM1ViQjhVQmlwOW5PYlZaWXZP?=
 =?iso-2022-jp?B?N1B0Qy9PWWxqYThyMStwU0F6UllKZDlkeHljWmpCd2FweXVrdFc1WXVT?=
 =?iso-2022-jp?B?YzVwbFhPblU5eE43SEpuRldwQ0hhL01paUttMmpjQ2xtclMxMUVQNDhw?=
 =?iso-2022-jp?B?bmdRdGQzL0poWHBIL3Y0VVVLVGUvTmNSZ1JBTXZkTEhjdS84ZlAxS0Fl?=
 =?iso-2022-jp?B?bTZLS2FvOWpMbkhJV00vQUlXemZSZ2tzSTJGL0oxWG13OFRhajBIM2tv?=
 =?iso-2022-jp?B?YUJRRm1FZEUwbVFQckpmWURkK3RNVWZpYjgvdGw2bnM1SFZsb09EenVq?=
 =?iso-2022-jp?B?WDRIMDYxRHpmWjdVTTVKUVlmWnVLK1F1WmRXaVUxUHVlM1VHMjBOVDJr?=
 =?iso-2022-jp?B?Sm85OVBodmJaMWdSVGJqTVEvMUZ4Unc1ejQ3Q29DNUVzc2ZKNTFQZHlL?=
 =?iso-2022-jp?B?WlVubG5uYmJBQVJaNnB6Y1c2Ykh6MGhWRk9sWDlwZFdMZXdhQWRJemJi?=
 =?iso-2022-jp?B?dHVVeFk5bmt5MFBaNEVuRURsUVJVbjZvbzFKMWZxWlVGUVM0MDlxNFVl?=
 =?iso-2022-jp?B?cGZWUzV0eHpzUEZpOFZUSkJuMXhCQkgranFaWU52MEEyTnlENGlReFRC?=
 =?iso-2022-jp?B?blBWLzNtWjk1V2VRUWtHUjZFZ0F4ZWZUNjhtRDQra3JoVkF3Rk5ZMXN6?=
 =?iso-2022-jp?B?TElkcTBTZlFOMGYydEJmdFRtK1RsU1l5aGdtRWtINVJBMUxHVDlQY1Z5?=
 =?iso-2022-jp?B?OG9hM2FiQ1NzSEpYLzVJR21PNTZ2WnZKTDluYnFybmRJT24yaFloN1lz?=
 =?iso-2022-jp?B?Q2ZmenArby9mR29aZWx6TzFuY3drY0hxZmJWVmZGNE1pZ1paczNJMTlu?=
 =?iso-2022-jp?B?eHd4bWw4YUZRalVKb2U3bTFXWlpWVngreEtBaE4ySFR2bWMyc1RUU2ty?=
 =?iso-2022-jp?B?eVNNYU03Ymp2VXpldEc4aVFCT3VTdnVvMHYwc0p6bDl4ZFAzL2hPR3o4?=
 =?iso-2022-jp?B?RTRtWnFvQ1d2VlcrUGFLempocmJHRGc3eDYxTjFxdkkrQ21meXpYRk1n?=
 =?iso-2022-jp?B?SDhlRFRDRGpwWXBUdkFYbEtHMHN4UUYwVG4zMlkxcjM1RCswUGtaNm8w?=
 =?iso-2022-jp?B?S24zRDRNRHJCTzhkYXhWemU4MlpuNndObDl5NEJHREdmaGwrSDNCUTMv?=
 =?iso-2022-jp?B?aHcrN2JFVWZjNlBsK2NiQjE4TDByblI5aENVMUkyVGZoSk5EcVlCZk53?=
 =?iso-2022-jp?B?RXVpbllpRWU1ZEljZEhqc1FqWC9tem9SMFo4VXkyME8rUFhOUG5wMERN?=
 =?iso-2022-jp?B?SWFFNVRlNlN3Q2JKdHFKNjBYQ3pnODdLRWE0UWNZa0kvNE9wOHJ4Y2VW?=
 =?iso-2022-jp?B?L0t4MXhjTnZsR0JpcmJKSTdCM080QTNWaVI4M2x2QXdtM3BiQ05JYUpu?=
 =?iso-2022-jp?B?MFlkMTNIWCt3aEV1VWM1Mmx5WWFFUnl3QzU3RHlKaEtVaktDRk42ei9J?=
 =?iso-2022-jp?B?Y3ZNZmY3KzdqbVB3ZGpqN3Y2UDlTb3k5cXIxOFJjV0dFUytSU1lkckdB?=
 =?iso-2022-jp?B?QkNLanJ5Vko3VmxjcTk3Vy9SVzRvZjIyS3g3WG1mMnFVV0YxUEx3VE9S?=
 =?iso-2022-jp?B?QnIyMDBjYTZJUjVCR05YVDFnQzR1czNUZ281bGIzSThHZ2RObEFHRHFa?=
 =?iso-2022-jp?B?OEhiUVVJZEI1Y0V5eThJR2szck9iQ05iT0s0RDVsWTFFaDc0aGdsSk9N?=
 =?iso-2022-jp?B?WWl0VEU3eWw0TEdCRFc0MlFxS052TGdkTFczd2xhdEhxdW43RTZsc2FM?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c65b3711-bed8-49c5-5585-08d91b3883bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2021 02:39:39.1468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y67pUwma6cTbG6Hb8ZfljlwFqoFUAyjz0sWPeLHF/sTvdnQauNXfwsJzXylAugijl3sd9M2p7mEAhATNn8qBRQIpbR484voiLWXLTXmTyu8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5338
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: jaRkMoyelewyqd0Ybxgl7TI5x4520388AA=
Content-Type: multipart/mixed; boundary="alf4321WWalpuwLcKHbV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1621478757;
 bh=o7f5NMqtFNrM2OLaDfwoPgwKgWjqX0UiUaMunDkBB7Y=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=aJnEsx+4u19TYNr3ippgNKo7oduCh53tw7OZkQwYy6IMZEoYf4hR8E5VglLwp50hCsE
 JyuAyQvYKkmBeL9O/ujBTV/zRqKrBDl4ougQZfxZpvPV/7di8QnFV+4qhslc3yB5vPNHo
 3SAPPwJEZb+QYAkzSezYEfBCrHLZl7r8usk=

--alf4321WWalpuwLcKHbV
Content-Language: ja-JP
Content-Type: multipart/alternative;
	boundary="_000_TY2PR01MB4972884F2C226E1D81FD7F7EA02A9TY2PR01MB4972jpnp_"

--_000_TY2PR01MB4972884F2C226E1D81FD7F7EA02A9TY2PR01MB4972jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2021&mont=
h=3D5&day=3D20&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&=
p5=3D241&p6=3D248

USWest USEast  UK         DE         TW        JP
02:00     05:00     10:00     11:00     17:00     18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2021/05/cip.2021-05-13-09.00.log.=
html

* Action item
  1. Combine root filesystem with kselftest binary - iwamatsu
  2. Do some experiment to lower burdens on CI - patersonc
  3. Monitor the status of CVE-2021-3444 and CVE-2021-20292 (3/25) - Kernel=
 Team
  4. Monitor the status of CVE-2021-29650 (4/1) - Kernel Team
  5. Update Testing table below with 5.10 info - patersonc
      https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptesti=
ng/centalisedtesting/cioverview

  6. Decide the go/nogo of CVE-2021-31916 backporting (5/6) - Kernel Team

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

--_000_TY2PR01MB4972884F2C226E1D81FD7F7EA02A9TY2PR01MB4972jpnp_
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
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">*Ple=
ase note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starting f=
rom the first week of Apr. according to TSC meeting*<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">http=
s://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2021&amp;mont=
h=3D5&amp;day=3D20&amp;hour=3D9&amp;min=3D0&amp;sec=3D0&amp;p1=3D224&amp;p2=
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
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">Chan=
nel:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">* ir=
c:chat.freenode.net:6667/cip<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">Last=
 meeting minutes:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">http=
s://irclogs.baserock.org/meetings/cip/2021/05/cip.2021-05-13-09.00.log.html=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">* Ac=
tion item<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">&nbs=
p; 1. Combine root filesystem with kselftest binary - iwamatsu
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">&nbs=
p;&nbsp;2. Do some experiment to lower burdens on CI - patersonc<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">&nbs=
p; 3. Monitor the status of CVE-2021-3444 and CVE-2021-20292 (3/25) - Kerne=
l Team<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">&nbs=
p; 4. Monitor the status of CVE-2021-29650 (4/1) - Kernel Team<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">&nbs=
p; 5. Update Testing table below with 5.10 info - patersonc<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; https://wiki.linuxfoundation.org/civilinfrastruc=
tureplatform/ciptesting/centalisedtesting/cioverview<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">&nbs=
p; 6. Decide the go/nogo of CVE-2021-31916 backporting (5/6) - Kernel Team<=
o:p></o:p></span></p>
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

--_000_TY2PR01MB4972884F2C226E1D81FD7F7EA02A9TY2PR01MB4972jpnp_--

--alf4321WWalpuwLcKHbV
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6468): https://lists.cip-project.org/g/cip-dev/message=
/6468
Mute This Topic: https://lists.cip-project.org/mt/82953874/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--alf4321WWalpuwLcKHbV--
