Return-Path: <SRS0=tHwj=LR=lists.cip-project.org=bounce+64572+6575+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB521C48BC2
	for <cip-dev@archiver.kernel.org>; Wed, 23 Jun 2021 23:49:21 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 021C060249
	for <cip-dev@archiver.kernel.org>; Wed, 23 Jun 2021 23:49:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 021C060249
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6575+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id UGVaYY4521723xb92gkTyhZN; Wed, 23 Jun 2021 16:49:20 -0700
X-Received: from ss11.sbt-mailgate.jp (ss11.sbt-mailgate.jp [202.241.206.54])
 by mx.groups.io with SMTP id smtpd.web08.170.1624492157941054216
 for <cip-dev@lists.cip-project.org>;
 Wed, 23 Jun 2021 16:49:19 -0700
X-Received: from mail.sbt-mailgate.jp (sagproxy-out11.sbt-mailgate.jp [10.16.47.41]) (envelope sender: <masashi.kudo@cybertrust.co.jp>)
	(not using TLS) by ss11.sbt-mailgate.jp (Active!gate) with ESMTP id YIsO08644A;
	Thu, 24 Jun 2021 08:44:17 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iY3QTjo2iny+s3sWaxEfWZ7bQpbBrrshKnaqx66NCQzQV1xRQf9bJPcdZLpA7rjbWwwO52OCKsHz25+fxFnvGr/AYAfS/WqiEqSDfZEr5nKMeWHm6vIp9gHnInTufqGEzfMk9ULXTJUnw9vIXEvgXMczCf1BL1M+u7Vbii7jw/1c9649Qx0nIBdgVQwOr1kDkg49Z6vDB4HSaIYSknwrV0FfrwmUy3YW00sgxilY03B0nz6BN2H97GRlmCuQ5SdRw50UYIiIzY6HchgrsyHS8O7Qf1JL/x2K8TDQF/055hF+RkvxHa18dCIrip5DpRNjPMxfTCGTssDw3pWzFfWgCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4zqQZgJRN+GjNvt1qBV70s0kwmFDd77eE8uU1B5664=;
 b=C1RLs5oP9/YBxxBPMu5ZJLCri4InNb+bphvv0b4hkCuPrfayE+ARX4GxrvevcRfgimbAsfu9OkaBworAFhdlB+2igi3DXMCM8suwloGcp6aEOiSkHrhAW/dhGUaKtaCgaZMQ7CYvgYxWNlmwbVxJJC8oavzrEbLysGFOb7ucRLLG+dX0+2BJf4mMbdTW5DAlqGv+BDU3YZI6LIMbDwjwoh52Dr96dqOTd0w4Lg6rr7O2k7s3Q+JWKaHAn1IZNiJKODNVljHEyWteQWyuiWwAtPEx9HnyqjFyTq5f72+rltAe7YRzsuQ3Hn3sS8sHLPKjCAV46ZMlu6JZcCtv0HRNyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TYAPR01MB2477.jpnprd01.prod.outlook.com (2603:1096:404:81::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19; Wed, 23 Jun
 2021 23:44:01 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::4cee:d78:d8e9:8a0]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::4cee:d78:d8e9:8a0%5]) with mapi id 15.20.4242.023; Wed, 23 Jun 2021
 23:44:01 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Topic: CIP IRC weekly meeting today on libera.chat
Thread-Index: AddoiZ4sZ+0OqvyATsuQtNtTFcEGWQ==
Date: Thu, 24 Jun 2021 08:49:15 +0900
Message-ID: 
 <TY2PR01MB49721789814EFAA7D00B8CE5A0089@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 49d9e1a2-f172-4f03-47e4-08d936a0c71b
x-ms-traffictypediagnostic: TYAPR01MB2477:
x-microsoft-antispam-prvs: 
 <TYAPR01MB247770366A013AFD663BF715A0089@TYAPR01MB2477.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 CkZwhWmARsh53Udsb5+nY2SpoYLLA3dHeVPDTDr+ml18M2R86HAuk9xofIG2cn9N1BF/SYhnAUYVLCIvzbS7rTYsWe7zHyLeRC4Pd6uhGkUSO21SwNper+Kf8iOk9ubXRSul1BDK4RFrQEhyvqhV7JLLnVZBegpkXXs65SELFppvDOg30gGs1GLlz1njkkMUKkbzUOD4qbgGNKJ5BpZgq25DJ1aCt5YB/DQSlg+f40/GGLGZ21hPzDGjmOl0cn7RRWsPdAZwozD7cR3AdNandWUPDetmwfAPilHyquDLYOc25o2fJXfavO6mZfwkEhv0V9rxWVb4laKocuVJDEaU9VXcpl2Mi6+evZmloRXmujGklTiyK8F3lr+IjDKuYmOJqhUqAB7YfiiqJ0z8gZVNpoXAh0nWBhIz1UM27Z2dp/lvhqDfZLZMCjLbAa6qdX5CCoke3amMVXWumrOGdZo4xGfHvN6lTmknaNS7AyD2s1PebFaCaa8c+Vxd83IuKKLAo31lZDg/lF89iIx3Q23e1B/du4z1BdSn4cVV+tES8reQ1T0B6s68syFO6qYmiHjeM7wLwgxcRjv2D1C3zVs2I80aohGy06y5khbNzTZHM1rroBhvrmF0f4iii+NoeOWs27dt3Q2n5n1SU8DqrRkMrvj6LhqvP0rzqClhOmDsMWL3h4LWdnUiJvzVqsjI8bXn6siPr/rTAztAZ/VNPbKA9w9BYlxBUXvLfIg7u56tWK4OcTo6g09BPQREekgsmXP/xqxUrBWWg43WSK9P2EjMo/8of41sOyJ7D4+Kyo8ylZn4nHv63f/nZrGABoOp9KaB
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?UlcxWlFiWGhobjJVMWRmM0liU09VQjlnYUNFckhXRWwxeTZWVEY5Y0dz?=
 =?iso-2022-jp?B?cDFoR0kzT0hKdk5EV3VSM1hVUHJPZ21ZM29VcWd4d3FoY1d3bmIxNHlM?=
 =?iso-2022-jp?B?dHp4dzhoalQwc1hFa05ZZjNsbW9qbysrWkk2RTVGWHJwU1djemxheUg3?=
 =?iso-2022-jp?B?TWdHZnVDUEtiVGU4ZlBxMldhRG5aa2VTZ0UxUzAxTVRKZHE0RmlRYm8y?=
 =?iso-2022-jp?B?bnRwUXppdE9BUFNhMDBMTERhSVRzZGVtQzYwYXRjS1ZIZVNLajlNdjcy?=
 =?iso-2022-jp?B?S3krWHhINGh6ZWpOcGdBclBUdzIwb0t3VkdFSjNqQnkrR1o4NHAxYzJx?=
 =?iso-2022-jp?B?TDl2SFo2T0FuU2IrbHlsTXNHTXdGc1hxb1FqVHRFR0pBTmhJYlA2MWx5?=
 =?iso-2022-jp?B?djV2MklkQjhKNGNiK2syNmVyYm1zcUw2Q0xLK2hrVzY2YjRNRDJ3QlRU?=
 =?iso-2022-jp?B?SHAvV3JlanpLVGIzZnF5Myt4OEJRMk1hTEdFZjZOOTc5QlRhUWlMdkNL?=
 =?iso-2022-jp?B?dW1BbndwWG15K3g4VjBGQThHTWRQUTVGbkZJQTRGZVd1bndNOTFNK1ht?=
 =?iso-2022-jp?B?ODRyUjlPU3QvQ0kyT3d1Y05QbFhra2ZLaUI5V1BpbFgvTm9oVi9nSkFS?=
 =?iso-2022-jp?B?VWxIaXBta3lOMkdZdUtvR2JKNUROSTZvdElEMENYcUVqdGFFZ0gzaGJs?=
 =?iso-2022-jp?B?ZkRjdDllUmtvUTk2a2VWKzl5cFcvdGpiZ21KVFZ4Rkk0RU5kMWJGZDBx?=
 =?iso-2022-jp?B?QUx1MFZYM21DYTFENTI4N3NKSmZNZ2ltRkRNK2lHSm9xbWIxZ1FlRGN2?=
 =?iso-2022-jp?B?aVVQTGNhSFAyNTJrcVlIN0ZXMDZpWkJ6OWhFQURXK2JkZ3ZNNEZPZ1N3?=
 =?iso-2022-jp?B?dExCNjRNNUxBUlBkYjA1azNLNm5qbEswTXlnMWZldlFxQ0ZkSlQzbVdN?=
 =?iso-2022-jp?B?UFA0U2tRWmp1T3dvK1N0dFZmSWZUTUpteENpN1RMdFhscHFTNFg1OVM3?=
 =?iso-2022-jp?B?aUQyRnFvN1BlOEYzYmt0Z2FVMDVUNmFuV0tPR3B4QncyM2phd2YyaDho?=
 =?iso-2022-jp?B?cnpKMmZ3bVNsSjZPUGZmSnNwN29pSnZXaHlaYjF6bWVyTGRtMDU1K05G?=
 =?iso-2022-jp?B?K1R5WFhOS2tZemwwTzhscHloTjdnRE5wUzhzejB5cE5NVnB3TjhJdEpz?=
 =?iso-2022-jp?B?S0F5YmNIQjRsMFJmL2lPR0hXeW42S1hXMXIrczBkT0R6VGFCOVNYbU8v?=
 =?iso-2022-jp?B?cmpmbG1Kb28welFWWHp4bkhLRHJZU013cGozYjdlWWNlWWdQc093SEJL?=
 =?iso-2022-jp?B?THlNRzQ3T3hNZnhhRVNpREJuUFBjdU5ZcnkyQkx4MGh0Y3dmSjZYL1kw?=
 =?iso-2022-jp?B?cDFpWk1NSktpeGt6bG1xbkhoeDV1UzJDZDBUNGxNVEJHWWdqa1NGYUZ5?=
 =?iso-2022-jp?B?ZU1DVjVneTE2UXFMK1EvTlZyQnF2R0F3bXYwbFVZczNyU25HT1JvdnRk?=
 =?iso-2022-jp?B?dWZ0emtVQzFLNDIvWXBLWUxyWTIvb2Y5dStaUkM4VGlDQVBKSHUxTytv?=
 =?iso-2022-jp?B?TGVGZlRrdTFINklyMHEwQ2tsNTUwOHEzalFnRkdXWUd5UTVlL1VUU3U5?=
 =?iso-2022-jp?B?NGpwUm81UVJVUFh3UVp5RE5RdzdOdEtHL01LUEN2bFNMY0tVakNjdEVI?=
 =?iso-2022-jp?B?alNRTTQyY0x5SzdLQ0VNMUFTK3p1M0VPNngrNVNNd2FxOVcwME45V2xQ?=
 =?iso-2022-jp?B?cE5rdHhNYmtPbEY3eC9CNHFOOGtVbVkrUXZERE5IcW4xTFZMczZ1TzBT?=
 =?iso-2022-jp?B?MGMxdHQvSFc0UkNqSSs0cVVXVmtBaitkTjNYOWNPQkFHcWt1bm5jTVZC?=
 =?iso-2022-jp?B?bEUrVDlwZHZYTVJDTkNJZzRUY2dyL1l5bUtkcm5vcktWSmJVemVyN3p1?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49d9e1a2-f172-4f03-47e4-08d936a0c71b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2021 23:44:01.2297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qqmj5UAbeRD6x1qPlqtNQXgPyMnQebq+2DB58++CYtl1BER3o/pgZaHx6XEHQw9MvAwQIxxGGj3W0pio2lt499poVUNFDeG/7k2N2LGf0go=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2477
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: nO1ZquU8bfC8Ds4vIGoljZXHx4520388AA=
Content-Type: multipart/mixed; boundary="YcH7AVcB8omoe8dYtxHj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1624492160;
 bh=2ZtrwrWe0/RwzxdTRH/FUTns6LOvXYSd8PAP/hAmNO8=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=quzpOFcDJLbhzRWlPv1TO4C85A9x6qJFjuAPGU2118cER+fOnt0rYX9shCsgc5owOhA
 nwP0wNmeWkLL8WoIXMvHhM2kJcaSvx6GJJjUrXEqi2y1rv5eCJwrbehqnwwF9E7TC+O0c
 VydmVd6hlWuf83h0BIKUtdCGPVR69N5Aq5c=

--YcH7AVcB8omoe8dYtxHj
Content-Language: ja-JP
Content-Type: multipart/alternative;
	boundary="_000_TY2PR01MB49721789814EFAA7D00B8CE5A0089TY2PR01MB4972jpnp_"

--_000_TY2PR01MB49721789814EFAA7D00B8CE5A0089TY2PR01MB4972jpnp_
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
h=3D6&day=3D24&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&=
p5=3D241&p6=3D248

USWest USEast  UK         DE         TW        JP
02:00     05:00     10:00     11:00     17:00     18:00


Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2021/06/cip.2021-06-17-09.00.log.=
html

* Action item
  1. Combine root filesystem with kselftest binary - iwamatsu
  2. Do some experiment to lower burdens on CI - patersonc
  3. Monitor the status of CVE-2021-3444 and CVE-2021-20292 (3/25) - Kernel=
 Team
  4. Update Testing table below with 5.10 info - patersonc
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

--_000_TY2PR01MB49721789814EFAA7D00B8CE5A0089TY2PR01MB4972jpnp_
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
h=3D6&amp;day=3D24&amp;hour=3D9&amp;min=3D0&amp;sec=3D0&amp;p1=3D224&amp;p2=
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
s://irclogs.baserock.org/meetings/cip/2021/06/cip.2021-06-17-09.00.log.html=
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
p; 4. Update Testing table below with 5.10 info - patersonc<o:p></o:p></spa=
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

--_000_TY2PR01MB49721789814EFAA7D00B8CE5A0089TY2PR01MB4972jpnp_--

--YcH7AVcB8omoe8dYtxHj
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6575): https://lists.cip-project.org/g/cip-dev/message=
/6575
Mute This Topic: https://lists.cip-project.org/mt/83750375/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--YcH7AVcB8omoe8dYtxHj--
