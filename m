Return-Path: <SRS0=jio8=LL=lists.cip-project.org=bounce+64572+6524+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865C3C48BE5
	for <cip-dev@archiver.kernel.org>; Thu, 17 Jun 2021 01:29:49 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B10F7611CE
	for <cip-dev@archiver.kernel.org>; Thu, 17 Jun 2021 01:29:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B10F7611CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6524+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id MrDkYY4521723xS0hvocu3ze; Wed, 16 Jun 2021 18:29:48 -0700
X-Received: from ss11.sbt-mailgate.jp (ss11.sbt-mailgate.jp [202.241.206.55])
 by mx.groups.io with SMTP id smtpd.web09.1868.1623893385651817511
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Jun 2021 18:29:47 -0700
X-Received: from mail.sbt-mailgate.jp (sagproxy-out11.sbt-mailgate.jp [10.16.47.41]) (envelope sender: <masashi.kudo@cybertrust.co.jp>)
	(not using TLS) by ss11.sbt-mailgate.jp (Active!gate) with ESMTP id RKXn26749A;
	Thu, 17 Jun 2021 10:23:39 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d02bIa6m0B4IBafgMB7SuOPBc9YFETEmiYQWu0lqR7aBeQDPpTGeY528+bn3kggxJEVd4CI31XLB99oua7cRcvF0uFqHZaBpXsI6z6Ql498w3IuwY2jqTQ9CnnCnzL/nOzgeI+FisxZsB6PKhV5TAxuyAIzMQgT3VCc05fPuD35k+aOCdAbDtNiGSnbml2qqZftJRn40gQTf8AV8Z1PZ+ILY9Nh/eV7nl/tLXivQe6tP6lcHsVNaFEhDPXLlKjJxK2NmubPmaR3IRpsf6nU28Rki6YM3tQHr/S9OX4c8J+9EsiYp9v3nSzcNFzMBYwQbDhUaxE00ZJGMk+fyT3bxhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jqi25Dzrlkr78eftIBSzpj5OtwTJASSMlab3SxO+O+I=;
 b=jKdEaad9alKvN8wEKha7UONMBc61vwXFJiVbQ2B3j2Sa6l8C9gD33Nj42Np/nyTfHkSa2dbNZDPVvD7sFjZTq2hhoPvbppgxVSCmDVG+LWLTgM0nuNS+VneAYb02V5UkJ9YBafhRCOYXA7kkXXFZOOoOUxXGxkFdu0d/IqMq5wwX+C7Lcj4Qx+H3fYIpFcdeEjzTHckTgFTLJ1SxL1jcA0NuO/S7eyqBL2S6KODB4VdoR6A4ctWgz6il7j0oIaV52Q5TIyTL+fgs6P8t6vlRv8KdQxgOtsX4qSW4fT6oTlj5hyPskbinNZmSWCfBjFhLU2ZIeXfmydjZ5Kp/Xf7XPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TYAPR01MB5338.jpnprd01.prod.outlook.com (2603:1096:404:8030::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Thu, 17 Jun
 2021 01:22:28 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::4cee:d78:d8e9:8a0]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::4cee:d78:d8e9:8a0%5]) with mapi id 15.20.4242.019; Thu, 17 Jun 2021
 01:22:27 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Topic: CIP IRC weekly meeting today on libera.chat
Thread-Index: AddjFzvPEhGjS8y0TN+M1Z5qlVWVLw==
Date: Thu, 17 Jun 2021 10:29:42 +0900
Message-ID: 
 <TY2PR01MB49722592CFA2D688628B3328A00E9@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f050f65-31e0-4214-4a33-08d9312e5eda
x-ms-traffictypediagnostic: TYAPR01MB5338:
x-microsoft-antispam-prvs: 
 <TYAPR01MB5338FD720654DAB63607E011A00E9@TYAPR01MB5338.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 6vCv9Xn3caDz2/d+j8dDGScaQU4zIFeS2kw5EzCNIYHxhxBNqlSz7LS6eRYi6mD3EHvLULYe0j7GQt/rTiUM2Vq16S88JTPveBlZmedd72y5O7Fj1f72rfUvKK6U2CretfikW+24HmEdbKB8LsvYVcQD+IAaN5VejrWILmGKa62ACpoZhDbyAQXfQEQPaCFj+kcjfT1wSwGoAkioGCSIkJSQtotdw3FDlpzxcmP98Ctm530GdJyD1HjtZ18tRn22B64jaHs2lAHwG0hV0dKaVhqnwC0C7Q1y9M1abyMxrYa4FVhGe7s+AyziMessOhNi6VauFl0Ab0pcT3uRg0cWrYn8Gi/cyX839SdxYdbpxU6Z/I/HNq8zNitYROZDcVNqYjA+0WRTc7H+CxdQXff8+s0BDQI+HAxwqntoOIxbFCSnAzGJfqzL7nVRC28s0tfIHjkNDBRHFdZEaTwCVi849bUxX6DdLfWdZyAmdwhAsNcvrhchjFzLtQagaJgqsGeQGzuvaLhdoq88AxWdAaZ4AJvOHv14wktAFiirF9MqwRXxvjUbZUlUEkuwuKftC1WEvhNJzUrQFJwPcNrYQbZ4OrSS+JvM9odDBoerj0puXEKao/JVk5yOhuaU7XJEa0nqf6pVgeBp7nm2CZqZHw/Uom0kolRwHGvBZOnjxIurrgVLTi+SZsvrfxqZAuBr50W0b1sUEblTRTLVgHCuVKXMsFk3tcXSaVJ34dW0XrW1XN2tOFzfOFJ2YHc9xvg5F+CgoaPoYnI/Xtkk1xcO64axf23QMHS9dPdgJLOVY5Pi7ImUzHpmYwGDsP3BMPEC4tlS
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?VTd5aFVOL01EM2Y2TEZaTGJKNWpZM2dad3pqYzJzMVd1YW93ckdLSlhM?=
 =?iso-2022-jp?B?WU14SXU3bXRRQUREMVV3WUUxRVdCdW84MzZWMVJRN1RHUnlGYlZ5TDRq?=
 =?iso-2022-jp?B?RTlJQ2oyMFhkTEpCOXU4cG43ZEV3cEpmYkc5cHQyZkpHc2FOTExTOUZr?=
 =?iso-2022-jp?B?cHFJYkdXUUdaVHdCOWtLbXJuSUluaGg2TjFhek9PL21EZCtoa3V1bXNi?=
 =?iso-2022-jp?B?MDN0czd1eTh3TmVBVXdoY1BVSXNubUVNOHdCZnNuMWNha0JpUmpXYkRD?=
 =?iso-2022-jp?B?UjhISC95WG5Ma1ptTlgyK2lPY3RuNk9RajUzS1pmWlhGMkxpcWFDdXgr?=
 =?iso-2022-jp?B?T29zZTVuYzNEdThTYWx2TC9YL0tDcXV0Q0g4Wm1naEpFbEU5cyt5a24z?=
 =?iso-2022-jp?B?NUQzblBuMktsSC9IRTZBbWlLWEhBMWN5blV5V1g2N2pMKy8raXhJQ0tY?=
 =?iso-2022-jp?B?MU56YnVJSW5mcFVZcm1wNUVXNU9NemNjKzdCbjhERUdUalZHUDhqczll?=
 =?iso-2022-jp?B?bjJNdEpiTTJ6VElSZmpRNmZicUxMQkhVNGZkNkdwYVlsaUVia01qdEs1?=
 =?iso-2022-jp?B?Z1pOMkM5aVcvRnFPVys1ZU5FTllnNGltb05ueWVvOXNkQWtWdEhWdFRm?=
 =?iso-2022-jp?B?ZEFpZFVGQ0M3VU5MTitLdElvKzl0Nld4VGpMSFhLZzdBN0JuemxXNytJ?=
 =?iso-2022-jp?B?OENNcmxlTWNVQWVueDBRQitpVWpudldvQ3NVL2dkVUwydVhZQzFJcGNJ?=
 =?iso-2022-jp?B?Q3B5aWxaUWUyUU1XaVdNMDVEZU9UcDZnRDhIK1IwV1E0SzFSK1pYQ1Yy?=
 =?iso-2022-jp?B?a2g4RHZ5U0RKbC9KV3JkNUVhblNqYmZMcDYwdXFqNjdNNC8zdW54cW9l?=
 =?iso-2022-jp?B?VmNIUmp0YXh3V3pWaGhXb29vWGRTcnFLKzhNaGtKRENtYm5CcGROMXVB?=
 =?iso-2022-jp?B?bTlVSUVtOWc1VXhDMnVxY0hkSnhFYXV1WExHSmtYS05MRXZkSCt6Yjcv?=
 =?iso-2022-jp?B?ZTRZUVR0YnNyU1UrVWNBR09iNXhmYnh4VUlKQndyWUJkejl4RWVPa0Y0?=
 =?iso-2022-jp?B?cFRNNHloenZ2SVEzcW1kakV5aUkvbkxzcjdQa2lDOVJFSzJ1K0RjeUNC?=
 =?iso-2022-jp?B?RWJ5dnZaaUc3RWtKWlU1YnVvSUJpakdpZVpRamtpSW5qUzdvcFNTRHdr?=
 =?iso-2022-jp?B?M0FEYkRNVnNTUlI3Qm9DdDkwVVJNQ1FKUmkyMTc3U1VtUklLVnBML3I5?=
 =?iso-2022-jp?B?VmlkWE1Ec0Uzb0htU29DNlRzQVE4c1hCdDZSOUIwY09lYWg0ZGhVMk5p?=
 =?iso-2022-jp?B?TVlub0JCVnJMUjROaTVqZlBJYmxOWGVoaVoyaDg4Q21pcjhRYURmMmI1?=
 =?iso-2022-jp?B?cDNubUJJUnNEZG8zVzVTVG5scnkwZ094dHhIRVVjL1ZnQlNSUHBzemgr?=
 =?iso-2022-jp?B?V2hOMExhR1ZTUnh3N3huR1lsazdRdWt2cnFGRlRMQzRYeGc0M0lHVFpu?=
 =?iso-2022-jp?B?c2QzRTN3WFpBZDJHdTlINVBjOWpQUVhLbW42ZU5STmYzaEl2VWhqZDRE?=
 =?iso-2022-jp?B?cUJUUXo0NUg3b3E3eFNUbllkb0tnWVdJdzFqWFZ6VFRJTmh2cVJhOFRD?=
 =?iso-2022-jp?B?RDRxWVBGVmNDRUYreS9yWFJPS05temU1ZytTUW5MY29xbkoxNlhkWWw3?=
 =?iso-2022-jp?B?UmY0Lys2Q2U0RHJ3OUlDQ25mV1hFZ3JsQmJMS3lDcXRuR2ZjRjBteHBl?=
 =?iso-2022-jp?B?QThwMVBCSlBZNCtBU2RQSHBzSTFUT1VMNERubXRZbU9oblh6SmpXWHdR?=
 =?iso-2022-jp?B?aG9XakZHUVJZYTczMVQ3UE11RXZHS0xDUWpSOS9DWUV5VUphQm93YXdV?=
 =?iso-2022-jp?B?RWpzdGZKaTV0MGJaTTFBdmxQWitIOWl6NUpwOTlCVHppK2tXMUZyZDc0?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f050f65-31e0-4214-4a33-08d9312e5eda
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2021 01:22:27.7887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: thN2WaoncyovfshSKNggHmtjdcuVeDHgrsKjwx8Czb72brKop5aWhHwmRajKC1nW1NxPOd/sRd86Rj1ZNhudcDHU+zAGVvm2KDuohK0GQMI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5338
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: PSCZQpIRXdBSxmoFRW54drHKx4520388AA=
Content-Type: multipart/mixed; boundary="jZfH0nMlRoeA4a3LmvWl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1623893388;
 bh=56DclIUdbblFEZxTeU5I+TjyRvMAYmmzk6dtPfU/svw=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=GqnwTiKF3Qm2EhEkPP327PC+6L9SyFfYDZXJZcvzLrfITTfkzLGculYtm/npjlZ7Geb
 snvEYnmpMYqxHSxDuQ6GAulq/pdq7DRas6QFgOa4g3ergiGXwDJ/xdQSXnVxPgcsOt1Br
 LxiodyUIB9FdkOSKcTYi5Azy0T9D5D+GssA=

--jZfH0nMlRoeA4a3LmvWl
Content-Language: ja-JP
Content-Type: multipart/alternative;
	boundary="_000_TY2PR01MB49722592CFA2D688628B3328A00E9TY2PR01MB4972jpnp_"

--_000_TY2PR01MB49722592CFA2D688628B3328A00E9TY2PR01MB4972jpnp_
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
h=3D6&day=3D17&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&=
p5=3D241&p6=3D248

USWest USEast  UK         DE         TW        JP
02:00     05:00     10:00     11:00     17:00     18:00


Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2021/06/cip.2021-06-10-09.00.log.=
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

--_000_TY2PR01MB49722592CFA2D688628B3328A00E9TY2PR01MB4972jpnp_
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
h=3D6&amp;day=3D17&amp;hour=3D9&amp;min=3D0&amp;sec=3D0&amp;p1=3D224&amp;p2=
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
s://irclogs.baserock.org/meetings/cip/2021/06/cip.2021-06-10-09.00.log.html=
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

--_000_TY2PR01MB49722592CFA2D688628B3328A00E9TY2PR01MB4972jpnp_--

--jZfH0nMlRoeA4a3LmvWl
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6524): https://lists.cip-project.org/g/cip-dev/message=
/6524
Mute This Topic: https://lists.cip-project.org/mt/83595580/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--jZfH0nMlRoeA4a3LmvWl--
