Return-Path: <SRS0=qqwH=MV=lists.cip-project.org=bounce+64572+6638+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27AFC4338F
	for <cip-dev@archiver.kernel.org>; Thu, 29 Jul 2021 01:30:54 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E144D6101C
	for <cip-dev@archiver.kernel.org>; Thu, 29 Jul 2021 01:30:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E144D6101C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 67wGYY4521723x4ygJOq3ZMV; Wed, 28 Jul 2021 18:30:53 -0700
X-Received: from ss11.sbt-mailgate.jp (ss11.sbt-mailgate.jp [202.241.206.53])
 by mx.groups.io with SMTP id smtpd.web09.3619.1627522250613037788
 for <cip-dev@lists.cip-project.org>;
 Wed, 28 Jul 2021 18:30:52 -0700
X-Received: from mail.sbt-mailgate.jp (sagproxy-out12.sbt-mailgate.jp [10.16.47.42]) (envelope sender: <masashi.kudo@cybertrust.co.jp>)
	(not using TLS) by ss11.sbt-mailgate.jp (Active!gate) with ESMTP id dKYq07180A;
	Thu, 29 Jul 2021 10:24:42 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lh5zSq11mUXzhVaM0YMLNw72Z/zY+TQ/0UoqsKff5z7v/WkhHxxqMCSxRNf+bD1fwG/S+faWPESGlxGexEm2AYRjdZK3xRcTqU59N3IU/tKdbpnMdNQ+cHYr14+XNqciKsV4u0rc4K/vJ3cJRRzFIY/CX6zvPaYRVrgFb8OntsuAny5+YeSRazOaLS+LIQSXM1yxBk6f/MWOFh9EbuskcumsxjsnFUdY/9LrdT0nOeODF1qwNl/n7nPwfMzab64M4O59qsLph3EwvHSiPsQusDGBV0YybqYSYD40UuY6xQS15HfZkbzL29+N+tmpFotHS33bqUM6qy5Rx58ZcCcWXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lMNJwBsDiR0t3sL/g63tvuq+vqWY00WxbOACN//sz98=;
 b=PthO0KVzR0nO/HJybJU+FUz+udH5tm6HJCYoWGi2+L26Q6Nwn/465nwUGXEQzU6kplPGK34bvQr9bnnOlgIJZr4K5FNyjpqFXbnoH3ayU9VqmNMugMoo2wUqbkacSTNpRC7dSEelIxIujdlaOE2U80sJogIY4PLF9UGqXGgZyDDNxOLIqxV1IAaOWgy6WkGDDEeFndmBDZ3A99Ypx0B6SgcxMYFedkq09M5ZS8lhcu/47olwevFMtxdlsp2FHFaR8t2RfxEnkWezAuNyN1m7zGttmYa+y6948OjGRiPQRZ+8u8UWBsSXsSQy68VSEvUWwAEjoo8DpvIPap3+wYxftQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TYCPR01MB6704.jpnprd01.prod.outlook.com (2603:1096:400:9f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Thu, 29 Jul
 2021 01:24:32 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::f937:86f8:a385:7913]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::f937:86f8:a385:7913%4]) with mapi id 15.20.4373.021; Thu, 29 Jul 2021
 01:24:32 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Topic: CIP IRC weekly meeting today on libera.chat
Thread-Index: AdeEGGvF9ElJIwglSbuCxrrHwRO74Q==
Date: Thu, 29 Jul 2021 10:30:47 +0900
Message-ID: 
 <TY2PR01MB4972838A2133F687D990E622A0EB9@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: affddbcd-c681-4d71-424b-08d9522f9e33
x-ms-traffictypediagnostic: TYCPR01MB6704:
x-microsoft-antispam-prvs: 
 <TYCPR01MB6704B7E24F044D3466D12577A0EB9@TYCPR01MB6704.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam-message-info: 
 bw0MV8Y9zP7WGkGBsc5G3yQu0+WfM2KTzduaxhFFnBpZWFpjNwGe6Y0/HcToVVBUXcW9m5HCFyVGDIgHihfyMdQ78aCHjpuVHbDIPdl3ls+bfGVP5KV9CQhPp95RUG8udAoHs6qrubPTw8PYUaH8TRwa/JTdK+xTBsSgJjusr4O25JxzxsMlk0uRyZ8cwSdcMY/+TS3xElToxOOIGmlMHy3GWMmtQyB/db4c5xuYSoiqJvNPke1adUEnoxqLJ6+mOIv8h6Bwu2fljn6mFr6roqqa2qf8LJfW5Nb5AxFRoBbTJkKE3Jz+0m3jAIwvCs5M6GL7s2FGkwoJHFc2bXJ6u6ky6RBjwYyMDTZ8xnfB2bhnAb/uDY11wMokx58OJKMVqv5wuz+1LVfOPReL40jzZ2cI9GBFaq5ui+dyB6Cn9rDjFVoPZxqd+PCuwKBhIQMic7X6Q3/rPO/nWEvrnVb7z+7vzUonPcU+eU1k9FNOY4Q/E/k+/V5GJuhdilZeKamM6N9FSdRG4lnu3gjM9z6sRyBS8dZ2fD1N+ikfH6l+p9hx57NKGfwC/yeabcMy6b6ePSvozkDEnEKpZtbkvI6fG590bbJdF1wsTdyPFBcBwpL4jBNVWx7yXUntiqAU26Ykvx+UnFxNy2NJUosoTKjkyQzbm9H1LmVFAYccBOVZh6g2ktN34MJZzRBtbS8hCDvouB1jbYbYYaakjAXlz7C6TfqgUKx+Q+ypBXvI1SYxQ5bbSfd3WuPP37fdNbPui2/2NGOeri7XNdgo50piP+mC26BEV5SHfwNTHU6IdlEsPO9HKlwire1OzYRfV2wXX5gMAC9oCP0DKaaN8dhwfJ1yoHMQZwzoR5A/PzAcaPJGUBs=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?TlNRV1ZqVTlVNlVOM0F3R2hYU1QzKzNYcHdtaTRZSm5LdFdzcmNYdkYv?=
 =?iso-2022-jp?B?YkxFNWpVMExuRHFqelVJS2xiZFdUSFVuTFZjajZGdnJHSXlRU0FrcG1h?=
 =?iso-2022-jp?B?NERuQjVXcnhKRWRyMTdqL1RBOElsOGtybVhSYUYwWjFGb3dBU2lZcCtI?=
 =?iso-2022-jp?B?MEp2M3NIbi85QWxQQVZXZkc3TUZ6b0FNeU9paFFZVS9OUDRKL05Vdk1K?=
 =?iso-2022-jp?B?K0wzTGpTaC92OWg5SjNGcUI0RVd5dnpnNG1RZ0tuOUdlQnkrVmJhMC96?=
 =?iso-2022-jp?B?enlKL3dmTEVlL1pONXdqZGJYeFpPa2dDdlozZDUxUWlOajFRa2wwVlo1?=
 =?iso-2022-jp?B?VWlIMU1XRnJXZlpDQnRGVWFmRkppSGFvMktxcnZkUTJVMTZKYUZBSHZh?=
 =?iso-2022-jp?B?VEE2UUwvazJ6QVJzQnM3K29pa1dmbVJKMzZ5SUJ4MVZ1NW84Z2RiS05U?=
 =?iso-2022-jp?B?dCs1ZnVMQzl2dmlOSXdOQjNwdWJrYWl3S1ZWNUJXWVJ4T2FkN2hORHY4?=
 =?iso-2022-jp?B?ZnZyNkFwc0VUUytDT3RjdEZJVlBBTTlhV094TkVwTDR1NGpjZjZIQU5z?=
 =?iso-2022-jp?B?Q04rNlhrMWtySlhyS0xUclFBa2RHeU40M3pLalJVNis5L1Q0SytqLzg2?=
 =?iso-2022-jp?B?Y0tZanJKdURhQW11LzNIUWM0UjhVSUNMbE9vNy9PdGU0cEVhZTcyOUhS?=
 =?iso-2022-jp?B?NXVXZmhpZkZsa09zQmhKcWtpZ0dmSXJoOGs1NExIQUpWL2duVU1DUDZI?=
 =?iso-2022-jp?B?YXVnYisyNkNlalNCQUFTOUJrQUs1c3JKRTFwRmJnNDcrbWdMNEI4RG5Z?=
 =?iso-2022-jp?B?TFZ3WGw4Nlc3VlZ0alNCRnVBL0VnKzEzamMwNkJES0kvN1FTajM3NTI5?=
 =?iso-2022-jp?B?NmxjQzJEN1JzcXlUUnQ4ZEZrK3FIY3dnS3JqdDhHbnp5UDVCTEVXaUxy?=
 =?iso-2022-jp?B?ZmdNZTFtNXpjNk13a2xQY0tHWGRmYmlnU2dHbnNUeURyQTNmSTgwbUxQ?=
 =?iso-2022-jp?B?NG53R21GWEgyK0MrVGVzazNwV096alFWOTZQZlA5YlVlcy9iellsOER2?=
 =?iso-2022-jp?B?QTFFZ0tNU2Flcis4NE5wTkRBbXBZM2RMRXgrVS9jQlNGV2hvK1puSCtT?=
 =?iso-2022-jp?B?b20xNi9qVXVyNmF2NHUwTG8rbFZ1c1NRamdSSUFHdEdDby8vWmMxcG9L?=
 =?iso-2022-jp?B?R1hSaXlnSk1rdUl2dzhoS3VaODk2RjBvSTg2UEtacFh3aW0xc00wMFk4?=
 =?iso-2022-jp?B?LzVId1R4a2wzcWpPRndsK0hPcWtvSE1qUzF6cCtya1NUaDU1Wi90VXYw?=
 =?iso-2022-jp?B?cUd5RmdNZDRnbUNSYjJTYUZlUEQva2NrNXNnRzFOcjBXN3NBd2lLRkRG?=
 =?iso-2022-jp?B?WlpEdVl2dHQxczFubUhMZktZUDNoWU9rSklVYm1nSDFnWG5xeSsxRG5G?=
 =?iso-2022-jp?B?RWcwSHZ3a1Uzc2RWZnQ0VXA2dnNTazBLdEdSQTFkY3h0aEh1dkcrN2Fy?=
 =?iso-2022-jp?B?Ylp5bHVsTmxTQnd1NTlkOWkwRnI3WDM0SnZ0UDFKWGJBVndaMWh1d0xq?=
 =?iso-2022-jp?B?RzZqN1NRT05pVk9tbXdFVXE0bXoxc0VoYU16Mm4xTFJnSzViMG8vUnBi?=
 =?iso-2022-jp?B?YTlSQlRiSXZ1UkF4cHl1dkoybGVMNlNKb1ZmVC80NmhaUDdjbFkxUmpj?=
 =?iso-2022-jp?B?L0hCM3lSSnZzanVGYXY0cTgrb3F0ZVRSRmVRYkpmSFNnUzBYaHcvcUQ5?=
 =?iso-2022-jp?B?YmQ0R3dLeUR2Yy93a2V0OEtpRTBjUFNUNFkxSTRBUXpXd3VtL1l3ZXdH?=
 =?iso-2022-jp?B?RjJhMENGUXpCVUZ0aWRHbXhNZE5GblhyaDd4STMzWnlWL0dNbEtJOE5a?=
 =?iso-2022-jp?B?cjYweFdHd3Z3TW5XZm5vMDJLZUl1eFBXa1lRTFFlYzAxNUVHQUU3K1BD?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: affddbcd-c681-4d71-424b-08d9522f9e33
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2021 01:24:32.0126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u0kzyE4GQLVJImLLi7c/wTvJ6sAIerqgpOxVxxSK6mw1OI1OMb2zyXTgXo0iirH/uNnV8cvxLOPrvNbt5qRk+VwQBxT1vUz+xVjf5+0ordI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6704
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: pMEwCd9PmuRgs9IvM5OYsmDNx4520388AA=
Content-Type: multipart/mixed; boundary="HkNyDZ5wbrNadOWhUZWC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1627522253;
 bh=y0CNmkUpij2EMi8ch0DWg13JVroSb1p+phIwBQ0v8AE=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=Gw4FRiwo++/4wdlIxALQEBtRNqtYpVmrcK47975cXXW1K4ExU6pW8mKyI9EQMIUIKYa
 FpI8dpa5TFo5IKBynxeHdWaL2AmNgDD6jVBNMEkDomGWum4fG0jjfYFq9lccFS1SXelIW
 0O5vuXGRRppwW3hPfbJsL5H7378SUEwxMdg=

--HkNyDZ5wbrNadOWhUZWC
Content-Language: ja-JP
Content-Type: multipart/alternative;
	boundary="_000_TY2PR01MB4972838A2133F687D990E622A0EB9TY2PR01MB4972jpnp_"

--_000_TY2PR01MB4972838A2133F687D990E622A0EB9TY2PR01MB4972jpnp_
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
h=3D7&day=3D29&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&=
p5=3D241&p6=3D248

USWest USEast  UK         DE         TW        JP
02:00     05:00     10:00     11:00     17:00     18:00


Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2021/07/cip.2021-07-22-09.00.log.=
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

--_000_TY2PR01MB4972838A2133F687D990E622A0EB9TY2PR01MB4972jpnp_
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
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">*Ple=
ase note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starting f=
rom the first week of Apr. according to TSC meeting*<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><a h=
ref=3D"https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D20=
21&amp;month=3D7&amp;day=3D29&amp;hour=3D9&amp;min=3D0&amp;sec=3D0&amp;p1=
=3D224&amp;p2=3D179&amp;p3=3D136&amp;p4=3D37&amp;p5=3D241&amp;p6=3D248">htt=
ps://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2021&amp;mon=
th=3D7&amp;day=3D29&amp;hour=3D9&amp;min=3D0&amp;sec=3D0&amp;p1=3D224&amp;p=
2=3D179&amp;p3=3D136&amp;p4=3D37&amp;p5=3D241&amp;p6=3D248</a><o:p></o:p></=
span></p>
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
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><a h=
ref=3D"https://irclogs.baserock.org/meetings/cip/2021/07/cip.2021-07-22-09.=
00.log.html">https://irclogs.baserock.org/meetings/cip/2021/07/cip.2021-07-=
22-09.00.log.html</a><o:p></o:p></span></p>
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
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><a h=
ref=3D"https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptest=
ing/centalisedtesting/cioverview">https://wiki.linuxfoundation.org/civilinf=
rastructureplatform/ciptesting/centalisedtesting/cioverview</a><o:p></o:p><=
/span></p>
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

--_000_TY2PR01MB4972838A2133F687D990E622A0EB9TY2PR01MB4972jpnp_--

--HkNyDZ5wbrNadOWhUZWC
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6638): https://lists.cip-project.org/g/cip-dev/message=
/6638
Mute This Topic: https://lists.cip-project.org/mt/84520003/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/452038=
8/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--HkNyDZ5wbrNadOWhUZWC--
