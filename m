Return-Path: <SRS0=oKJD=MO=lists.cip-project.org=bounce+64572+6626+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA24BC6377A
	for <cip-dev@archiver.kernel.org>; Thu, 22 Jul 2021 01:31:03 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47E8761263
	for <cip-dev@archiver.kernel.org>; Thu, 22 Jul 2021 01:31:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47E8761263
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6626+4520388+10495289@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id FdK8YY4521723x21El1UugEH; Wed, 21 Jul 2021 18:31:02 -0700
X-Received: from ss11.sbt-mailgate.jp (ss11.sbt-mailgate.jp [202.241.206.52])
 by mx.groups.io with SMTP id smtpd.web09.2199.1626917460516300148
 for <cip-dev@lists.cip-project.org>;
 Wed, 21 Jul 2021 18:31:01 -0700
X-Received: from mail.sbt-mailgate.jp (sagproxy-out12.sbt-mailgate.jp [10.16.47.42]) (envelope sender: <masashi.kudo@cybertrust.co.jp>)
	(not using TLS) by ss11.sbt-mailgate.jp (Active!gate) with ESMTP id WKYx14190A;
	Thu, 22 Jul 2021 10:24:49 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YPc58I0hAdfwcpld+Ja2YzpTieGcLr1h0nzZaUvmjXhLgrXRudKamfRtgqLDs/KLmxGNrRnobPdgLGrniuIhkBnYZVOLo4W4QAZQZ8nZIjVvSS5IKib/uuhvLHe/p9tc3xxeQXBlI96Hh/4FbJ9+RUihD6DfxUWIJpw8D7g6eEzJoK87ed2Psav22ulHwjhqGeWGcck5bBuxocssLhrbyB5llFJxABoR262b9X2B9RzNtlsjj7sQX3Wyh9jKZRr5LWPmQSH0gAk34PMdVKGdKyLfPyz7qWLNgEJHpGt1MsPuUi33v7WgC7IEY80hOx4ZRZ1EqLRzf+nYVJk0sg9SAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=721b975siNl2/f9mwQysfifJdkjhIzijDeKDGdIqHaA=;
 b=LyCKvqbjlsLYOoePKy1ZsNZJIhUXqNBa4t8pK7MtreA2R24K46yYqON90lxy7niBZKPuOrtTFX32HEgsqvnxS2by2YQ6wEkY4Jar6EaFxLXe6RbCvp9fWZL0yPDZy8OYwObFaGXWv/RNsRB/UE+DKpg1kd8o7HJhMh8xiY+uQXCnTNhreVQi0LuYV3sW9WhYP4WHuxffpNrrW323y3osaPjE4FdaSKgy1z0N2PVk46RQaxwuHqLEHVNxbwC7w2L4xzawbZopMjVb94p3xPm5wTJs9Qzf1DQWs+kr9wqIf6au6ZPHZynXewlnd0WANEIPLghC5U/WrtgS9NpJQo8XpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TYYPR01MB6960.jpnprd01.prod.outlook.com (2603:1096:400:d7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25; Thu, 22 Jul
 2021 01:24:38 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::f937:86f8:a385:7913]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::f937:86f8:a385:7913%4]) with mapi id 15.20.4331.034; Thu, 22 Jul 2021
 01:24:38 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Topic: CIP IRC weekly meeting today on libera.chat
Thread-Index: Add+mFWFx+SdGxRhTnau8QR58ynREA==
Date: Thu, 22 Jul 2021 10:30:54 +0900
Message-ID: 
 <TY2PR01MB497226E82228DF0B542A4B9AA0E49@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c60b4226-aea1-4f54-f17d-08d94caf78f9
x-ms-traffictypediagnostic: TYYPR01MB6960:
x-microsoft-antispam-prvs: 
 <TYYPR01MB69601BBD56E910E94573BD3AA0E49@TYYPR01MB6960.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam-message-info: 
 XYAZe+WtKGZ0MSZkOUfjZEeKkCCfzyXf2NLizEq3r5hgSDoDrM0RmExpvPagca41HBuwFQ6q4uEcit6MQtOCN+UpRAYqHCdmHk9ROna3rEUYAmf2HZ5w1n7OaXVm2zEIAxTeGq/+C6LZ6S/UA5FLHrVjNY+zQGwtR3zEMsi0wJV5aM1hpCA2eSrRb69LovJg3GAGEkqLqPSqkUussmK+1I7GUtytYR05IMJF07J37d+K3gS4tB4ywg/qEWbFp8IDkn+2yP9xiv4rZp1yimD7M1/MoEd2T14LeN6642xNran150f/Pr1pl4QXNbNjzjXddSetemYeHQLbZ0+Dgm64uOCaTsfwLIHdgnPFjQRH+o2U8Iyj4BxTN259S94WtMz/2CtONWsjJhFojwIwjlx0PPqgEtDJIQA5ErX6S6goeIwnPw8vk31pM8H5U7T3JpvzSAt+/ImjtX1LAQJolL9GELdQC4DeeHe8W1s8A1W9o05/5TlJVvG8fsonnsSbRKtEiDHl1PCke7xaLUMA4XdtIdn3/xmQJ5Jm2ZWRiLdrqk3Ma1tT7au9eqVFREgCc4zxi83mSdPHrlzlnFv0iPEqFK3dhhv/ns1R3eY54tdRHJL8oGtzjcoIgDE6Y3N40jMn0CwCR/VynxNL5gNV+u/7aqHLO6Puj+tC9XWh60/6D/ikrnGrP1cZBEPBBDuKAYsB7i5/FaMLhfRB6w0qgqF5NTKolB8BIblnamd2HpCgvPqbNTAl/Mr6UY0b6KsxnrY5SYNXMWJ8p/td8lMhuxW/0YZq39v0XNjlMMo4PNfPd3i/KVr63dMX/F7xFp6XsQaYnix1EOXA2it9RgyHUTwZQcQmMMqVhEE4dE9gO8Wdx8c=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?TDVac0JnYWNpY3lhRElOaGhYY1ZySHQ1ZU9KQXB5TzJUN3NQbmJpTGdW?=
 =?iso-2022-jp?B?NVJCd0VNVTZhNmhVZW0vK3R2N2g5bWRoN0xsd1ByM21OWEdrS2VSOWVw?=
 =?iso-2022-jp?B?aFRhbHlpMy9jditkKy8ydVE5a3JUTDFuUjZ4czdtQk93WnZCMDdIaGlW?=
 =?iso-2022-jp?B?V0xBTGQ2TllzeDNPcWQ2UEhWK25wZVdrNlkwcXczU3NHaFpjak44aEZR?=
 =?iso-2022-jp?B?UEo3YjFsNjE0bmd4bytmQ2E0ZlU1cE55Z21Tb1lheDJDMDBGYklHOVo4?=
 =?iso-2022-jp?B?eElucG9qNUc2VHpxVDJhY1Fpa0d0OE1EeUcxVUhFUnNJU0Y2RVVXbFFF?=
 =?iso-2022-jp?B?V1NXN3MxQUZZR0NlL2FYdlJxbWNaN1pkWDluN1I3WkZySy9EVlpDaEZK?=
 =?iso-2022-jp?B?aldMWStRUU9JU3NrQjlicHRUajRSbnh2WmsvSEhuUTd0S1dJY1hoME55?=
 =?iso-2022-jp?B?cTRHSythelUxbFcxdHlDdlZBeGVMYmM3SzYwRm9EQ0kzZ25zVE4vODZE?=
 =?iso-2022-jp?B?a29PdXdZeEJqRnlMMmlxTzBVOG1XRlpNcHRIcVVjb2pDMHU1WVJwRHpL?=
 =?iso-2022-jp?B?WHNSZXh2dWJuZ3lhRU9Xa1VOUHdhdUhOQXlvbFBBcDlkUnI5dDRuL2hu?=
 =?iso-2022-jp?B?YUFjU0ZuQUZjRDY0UGYrMkZuL3l4ZjhCQllLNkZUVWhIS2VYUVdLZ1RW?=
 =?iso-2022-jp?B?a1hVSkVxTTk0VjRsSnZ3bVJmU3Y4YzhDMStwM3psOHE0a0txS2p2dFNX?=
 =?iso-2022-jp?B?cHJmeHM0dVZyT0NXNmlFTGYxSWhTRjJKdk9pSGp5L3ZoRzZ4dDFRR0FF?=
 =?iso-2022-jp?B?T0JpUndKUXBiTm1zMHNXQkFpOERkWDVmWDVvNzU3VFpydEdKbEtqUlJj?=
 =?iso-2022-jp?B?eC9DL1U1YXNNOWo2amxZc2VSZHR4Mm12RzlkTHJEdmdYREJQM2E3ZVh4?=
 =?iso-2022-jp?B?dTg3TmhsNWxNRXRaK24yZlBXc05FRmJEYUx3QThoQnRTTldsejRrRFBI?=
 =?iso-2022-jp?B?QmI1S01qWXlTREwzZDFCc0d2SVBEczNiT2tNQTdGYlc5QS81N2M2ekdz?=
 =?iso-2022-jp?B?WWFBOWVTR052bFUrV25Kd1ZGNzF5SGhjY2NEeW9VeVFoNjlWNjNPM0wz?=
 =?iso-2022-jp?B?OFBmTExLNWdCR0NqKzFEaEFGdzZJOGZiNE9rSys5OEpXYjUyaUNVbkNp?=
 =?iso-2022-jp?B?N1d3OUlQeDJRZ2pIeWNmakVlY01laTgwK29QY0RRRVdxUCtHaVFHejNI?=
 =?iso-2022-jp?B?ejZVOFBvT0NlWEtQL2tQbkoyWTFHWkdxNm1IY1RGMDFQS3FWQkZwa2Vs?=
 =?iso-2022-jp?B?MHNQZHRyUm00aDViaExEUmlGOTVoZmtDcHYyZTJabWUxc2ZCeXQwRmVp?=
 =?iso-2022-jp?B?SlZlQ2Q2ZXlRNzRlc3hDcXdRMEFWZU9TamFpclNCZmVXdEJiaDI2bWpz?=
 =?iso-2022-jp?B?RWZabDJkcVJJSzNXMUlYWHd6Rm0rS1ZtWnpTTC9UR2cwZmxQR1dhaU9w?=
 =?iso-2022-jp?B?UWVtVm5xY04wT2kxRWNrVDcxbUM2aGkzc0tWZjl5Q3IxanNLM0RjZjY3?=
 =?iso-2022-jp?B?VkJwcm9qZDhQekZkZGJkUE8zaWpqY3JEOVZ5cHZJdU85U0tPUWI3L1Vj?=
 =?iso-2022-jp?B?YTQ2RWNLcWRPKzY1NExjcFJoeG1FRkdmYlpwbEdiMlNkaUQrZ25TLzBz?=
 =?iso-2022-jp?B?L2JIZHluQlhNTEJleUthZHdSVlU5ZVA2RHN6L3A3cFhQNFliSWt1WUJP?=
 =?iso-2022-jp?B?d1ZvaEtJdERZOW1ycjNYUHRMblZzem8yamZPQzdUNS85aVMzbnhZZkE5?=
 =?iso-2022-jp?B?dCs5cHF3SzNFemdLTS9DQnd6eURPWnIxZlg2VDdUVy8rN2U5eW1icUd0?=
 =?iso-2022-jp?B?clk1dW9DakdONVZyeUFVQ1VicUZYU0p3cmNzME40alZDWmRKMitucFBN?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c60b4226-aea1-4f54-f17d-08d94caf78f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2021 01:24:38.1730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1W9lVKTWi71tKiBfipCjonJuRNnNBLy3GAQ0qUYYQ67ogirUpbm57aKdSOQ+KCXL+u8pm/RU3u5IP9ezfYyhPGdEy0ttXTXnlsHlblFvk2I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB6960
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: lJ9C5CzKTbx9dgDIaH544zhjx4520388AA=
Content-Type: multipart/mixed; boundary="knQBXaWOULBPj6aROk1l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1626917462;
 bh=t6fNapaCFNgUPA32L0/dnkq1jpVQHfuGUWctwtx80rI=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=Ob5/5sN47pAXaAqYheFW0gzqiFDUj+tttGYHiOq6JpgOJ34vn/A2R4ATLq3AGzu4iCC
 BhdyI5fgBUCgnDMmyrg+ITDL9PZaoJDX5XVo4HX89ms/XBDtbEp2QHlDKtmflIQ6AFkcc
 SjyQRKvAFIAF3fbgu3GAZBsHsqVqzG8ynvw=

--knQBXaWOULBPj6aROk1l
Content-Language: ja-JP
Content-Type: multipart/alternative;
	boundary="_000_TY2PR01MB497226E82228DF0B542A4B9AA0E49TY2PR01MB4972jpnp_"

--_000_TY2PR01MB497226E82228DF0B542A4B9AA0E49TY2PR01MB4972jpnp_
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
h=3D7&day=3D22&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&=
p5=3D241&p6=3D248

USWest USEast  UK         DE         TW        JP
02:00     05:00     10:00     11:00     17:00     18:00


Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2021/07/cip.2021-07-15-09.00.log.=
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

--_000_TY2PR01MB497226E82228DF0B542A4B9AA0E49TY2PR01MB4972jpnp_
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
h=3D7&amp;day=3D22&amp;hour=3D9&amp;min=3D0&amp;sec=3D0&amp;p1=3D224&amp;p2=
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
s://irclogs.baserock.org/meetings/cip/2021/07/cip.2021-07-15-09.00.log.html=
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

--_000_TY2PR01MB497226E82228DF0B542A4B9AA0E49TY2PR01MB4972jpnp_--

--knQBXaWOULBPj6aROk1l
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6626): https://lists.cip-project.org/g/cip-dev/message=
/6626
Mute This Topic: https://lists.cip-project.org/mt/84370852/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/452038=
8/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--knQBXaWOULBPj6aROk1l--
