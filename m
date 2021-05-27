Return-Path: <SRS0=Up2v=KW=lists.cip-project.org=bounce+64572+6471+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39633C47082
	for <cip-dev@archiver.kernel.org>; Thu, 27 May 2021 01:09:46 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57E20613C5
	for <cip-dev@archiver.kernel.org>; Thu, 27 May 2021 01:09:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57E20613C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6471+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id N7SMYY4521723xYhlX63492Z; Wed, 26 May 2021 18:09:44 -0700
X-Received: from ss11.sbt-mailgate.jp (ss11.sbt-mailgate.jp [202.241.206.51])
 by mx.groups.io with SMTP id smtpd.web08.1063.1622077782492064814
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 May 2021 18:09:44 -0700
X-Received: from mail.sbt-mailgate.jp (sagproxy-out11.sbt-mailgate.jp [10.16.47.41]) (envelope sender: <masashi.kudo@cybertrust.co.jp>)
	(not using TLS) by ss11.sbt-mailgate.jp (Active!gate) with ESMTP id bKDe27586A;
	Thu, 27 May 2021 10:03:31 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GgiEoCtgsdsqYptYQzvdKwzBPJhPGJ4pYxMbeBSvmstrfG8CYiEcX2G0ruo6SeYCEKK8UDA8NYJGxNT2OF9maucBrF9MMHpWQYe4tZkgkBPTqtPtCG/Z42IiF9CjUdK2d+ITt9RNHXLbTUV2L6rSVgVmGs6q1zGvf9H6460sZ0LC7xKPiIDPMauDOtX3J5zKtpjvl61Zg4LH0CBOEMx3TMavsHUIckbuy6zJ6/nDkckT466BNK9KMibhxVum9YT2nIfknUGnHXNPJZJe4JXD9cF1CfzKyN5/+eWt8y3M1szU7Ooqbz7VkM7TH4pToIhfWrdR42+8ulQmlVjnTuEXqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UMFZAy6CgBNNAHzDo64FWOCHaLJhxsqBd4kpel212eQ=;
 b=K6Vp2jsj7CGGnF7+WsCkzKrEqRupnxWd38TT/N0EoPcnvnfMKhWpgbcSN9XLqCG41ozE5qZmyz5gqhA/rKc8xjQZkFZhq3a7Tc0XUljZCsCqkbOKyKHH7/dBqtjLbR2uUU1MvJlaL3yl5xDG993h+rX82dxlsJJ/+tzeDCRRndIz6f3qHXt2yz891HRyK9TrSKTqJM54MTOM7zjlrWZYOZiMO6RHweup7U3eQPtTbOpz5DArUuaMBSwOGtw+LRqTstpGyOeh8WcRe9YoOiAu95vXBAVPGlef6BdQ+xCUsf28uwCnt397xaOZdqd0BVYx14ta+tGUxhul3PzcBvp3ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TY1PR01MB1657.jpnprd01.prod.outlook.com (2603:1096:403:3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Thu, 27 May
 2021 01:03:25 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::4cee:d78:d8e9:8a0]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::4cee:d78:d8e9:8a0%5]) with mapi id 15.20.4173.021; Thu, 27 May 2021
 01:03:24 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AddSlBMPrYwUnUoRQr27IsfFgmvpSg==
Date: Thu, 27 May 2021 10:09:32 +0900
Message-ID: 
 <TY2PR01MB4972D72BA28167827F3DDC92A0239@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c02d14c9-0242-464b-4d2f-08d920ab3aee
x-ms-traffictypediagnostic: TY1PR01MB1657:
x-microsoft-antispam-prvs: 
 <TY1PR01MB16579E3F308D0248827927D9A0239@TY1PR01MB1657.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 BAkLtmPLF44av0rvkg501qDQ+5iv+V7b4JKeaBtnmyYoJezhknevV9ZI6NeWKDNio46MAKuykjkfzvb+pb0ozUZpU/RwFTHibqDecrAP6nw8KoE1PynoF9arlytFORXE0PcEApVdRmWzqohz6Iau4VgkCuLUvggCHdto1d1DdrCEeFUFH80mKJFwrdSGCOThcKsHsKHOudQcS+G4PO/MOWZQ3mkhwXyiWXNXkBIfAZmLOWOx4bMuPymabM5ovndf6k1vLcKmfiAtIHrtmaVXcQxzV7T/gNL8R94G0epS6YAezKtxdXsm8G2RwEIHos4Hds7wDu7baCrjKYqkFCKNrMudNUw1b1BQLhGf+92RxmCRdK7CEBgOTteYTwfpXYhjEKagAvQX+mX0MP+eBbfoVIFLQa5oqe2EzVkCI5OndKDCqTYfE/m5vYZ3Tbv3+EVRP6FiOC3TyCZWOrxkZvdd/7bG3ZqoogQqtAgKR/2NFecYoIGeFo7ZV5uPZfWQxwBJQ/RY/USWDUq60onv07BOPzjN82i/RowRbE/yVm7dmMPif8gViVMzJ29KXFkPpjVpVoPUPHmUkstRXdyOqDzmg9pDe3UHIy/3i/OCyqGMlZ97ocj0dMsY1ADmpS8DZ/DpvnTKIohGb+Cybr/79YprfOmXBERhnhSnn33PQK7UtG9RteT/73N2NOSQDg7TxSDvFUv8VYlWKYISrgy9Y5/eB2owH16Cmc2UottiUJKvfubMwcecU5nfipVuOG/PJp4odvVfN0ChYvF7LuCEiZJbJQ==
x-ms-exchange-antispam-messagedata: 
 =?iso-2022-jp?B?OStIR1VYeXlqM0hrdTBrV3FqN2d6RkxnN3ZQeXYzZFAzOTl6RFQ5YUl0?=
 =?iso-2022-jp?B?eGV1VXcwMnorUldPdXdxU2IvU0lTZjB1NXZyKzdYTU5WSDlVVWlQV203?=
 =?iso-2022-jp?B?S1RLamRCYVo0UEZ2aDFkbTFwNS9MSXJ3UnJBYnBObXBYcG9rcE9iVytC?=
 =?iso-2022-jp?B?V3JRaFhsRisvMjRWN0ZHbm1qcnhyQTBXRW51K1dMYWhsWWxPcmxYSy9S?=
 =?iso-2022-jp?B?K2xYUTZzeEExVUl2Rmp3Mm9QQ24wMGZVMVF2b24vWTFPTTduTzRUc1JK?=
 =?iso-2022-jp?B?Q3lTbDB5WWdQejlFRDJ0eVVhaDEwNlYxM25VVFFuRkpDWFpNMHgrR0tt?=
 =?iso-2022-jp?B?Q2w2S3ptaWhacERlMEJGNlFKSWtoSEptcFNQU09heEpwSWZodTN4NTYz?=
 =?iso-2022-jp?B?dWRuZWRzTUZjc0ZOOG9SK0N4M20rVmZGdTZuU0tGNHpOWFRPb3FZTm4w?=
 =?iso-2022-jp?B?UGpJdnBVekdXV251TnRmbFFFMTBGREh6RTc3M1U1NEFFV0xhY2NyVkhz?=
 =?iso-2022-jp?B?RDgrRWU0TlhISngxc2s5anZvc2N6UU5hZFBQbDh1MGwzVzhGTG44WnVh?=
 =?iso-2022-jp?B?MWFBaGpXejFKSkFSYmk4WjdPaWlHZVhua09tc3NYNDhuZEZlSlk5aGNI?=
 =?iso-2022-jp?B?bENPWW40STJsY2Z6TEttK0FRcENpRTdiWFYvRWc1ZjBTemNTNHRmTVdh?=
 =?iso-2022-jp?B?WlFMOERLRzhKM2FGM1oyOVk1RkJMN1BTRklPNmsrd2lxN0Y0YTZzYmZV?=
 =?iso-2022-jp?B?blNYeHdrczVOYWhqTW1uazkwcXBHZy81ZlJZSTRrZE9CcURlc2NBMUlQ?=
 =?iso-2022-jp?B?Qk5pWXRaVUw0ZEtGR3p3bGpIZ1lUTEIzR0ZnR3MySmcwNTUrS2JRbklW?=
 =?iso-2022-jp?B?d2x4aVkxVzZjS3VEYVlRVlVWT3BEQUJ0YStLbUFSOG94azNwelRoMjBB?=
 =?iso-2022-jp?B?N2JlQ3F0WG1nSHY2TWtXaENoL1VmT0RaeGZhUFhBeXU1c3Boa3Q1bFNY?=
 =?iso-2022-jp?B?V0piRHdndUJZNThlWXlMK005VlNMQzNUUDlVTDVONldpNUZPbWREVTlC?=
 =?iso-2022-jp?B?ekhUNi9QU3NZVllNU0N4L3NORlpqM1VqZ0JaOW44TmF1NStNakx4em03?=
 =?iso-2022-jp?B?NkNqbGNpTGY0VjhpcitvZDFHNEMrNWRETEFDemppc3Q0QUN1K3JXamZt?=
 =?iso-2022-jp?B?SThLYkdTZFFHMVFHSU1CY01LOGhjMXkxUG05ajl0dnR4QzlxdC9Qekgz?=
 =?iso-2022-jp?B?NEJ5NGcrL05rTkIyNjVSR2FrTUdib3dXYXgxdWwrLy9jSDQ5bjk1U3dT?=
 =?iso-2022-jp?B?L25FWXdsdzhVb2N3YW9vQUp5d0Q3YzFVTVBlWG85dkZ6N0JiOXc0ZkRn?=
 =?iso-2022-jp?B?NzBBNEtOTUhnY016clRXVkdITGNCVWJXVXl6QnpWblh1SWt6K09XeVVU?=
 =?iso-2022-jp?B?VzJBald5RXVhR2I0bGMzMDBYQ2p1b2w2dXY4SzlYTFRoVklzR01TZnJL?=
 =?iso-2022-jp?B?N3Bjd2xONVhtYzRMckdpbzBPcEpITU1pYUNWWkwycTY5WmNuT2kySXJn?=
 =?iso-2022-jp?B?bDlmcXNidktlUXFLV28zS3hzQnUrODZCQ1FhR0ZicGRaRkZQeDFSZkVt?=
 =?iso-2022-jp?B?aStySWlhdUs1ZkdmUllyVGlGU1l0SmczSVRKTy9RUHIxWTloZ3RuOHZL?=
 =?iso-2022-jp?B?Q1Rab0Jjc1p2cG9EVDE3b3p4U3ZNdUFmVjJsQlBlR3ZRRFVKOGY5SDBU?=
 =?iso-2022-jp?B?Qk9Pd09ML2RUQzVxVzdtaU0rbVQyMGY1NVVOTDk0S01WUVo5dlRIbTFs?=
 =?iso-2022-jp?B?bXlBUmxxZkVWWkxkcjdKaHBFZXNOTnFpUXhXekUraWNubWVlck9pRlVT?=
 =?iso-2022-jp?B?dDlUWnFmY3FkY2hlMWtrcGE4b3krcWlBY3lUWllwcnlZR2M1bGJva1N0?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c02d14c9-0242-464b-4d2f-08d920ab3aee
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2021 01:03:24.9028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OXXcnBkP2o5Rxik2EVdOT/mtZhuAJBGNF19xHUq9G0lzP2tPSqpIrEwRBH5k8xcb9UkzDUu1rbWcxKw9frn8NFI//uCCzxyKGGMMAB5xEQk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1657
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: aqk7RZDXtStrFaaJyKccMevux4520388AA=
Content-Type: multipart/mixed; boundary="AXQZ7vSugEr1vy8Lpy9c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1622077784;
 bh=BA5QXiJj+vu1SJT9yv5z2yCXqBlMwO9WP0w6E2/3+eg=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=gNBcv/qUUPj8Qp5VC6lL2M2znFUrdwVMgZ80cnIgZ0BbytZOk344gXCoR5x5omFafZa
 K+lBCphKDnyYtLEzGxdq9jR/LJxI4BrbsTRVzDdoiKhVQJzhQZ+HMLsGaO0SXdsquOy2j
 c049f4TVoxs025UNX/y9bg6iYeF3P14L4Cs=

--AXQZ7vSugEr1vy8Lpy9c
Content-Language: ja-JP
Content-Type: multipart/alternative;
	boundary="_000_TY2PR01MB4972D72BA28167827F3DDC92A0239TY2PR01MB4972jpnp_"

--_000_TY2PR01MB4972D72BA28167827F3DDC92A0239TY2PR01MB4972jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2021&mont=
h=3D5&day=3D27&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&=
p5=3D241&p6=3D248

USWest USEast  UK         DE         TW        JP
02:00     05:00     10:00     11:00     17:00     18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2021/05/cip.2021-05-20-09.00.log.=
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

--_000_TY2PR01MB4972D72BA28167827F3DDC92A0239TY2PR01MB4972jpnp_
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
h=3D5&amp;day=3D27&amp;hour=3D9&amp;min=3D0&amp;sec=3D0&amp;p1=3D224&amp;p2=
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
s://irclogs.baserock.org/meetings/cip/2021/05/cip.2021-05-20-09.00.log.html=
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

--_000_TY2PR01MB4972D72BA28167827F3DDC92A0239TY2PR01MB4972jpnp_--

--AXQZ7vSugEr1vy8Lpy9c
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6471): https://lists.cip-project.org/g/cip-dev/message=
/6471
Mute This Topic: https://lists.cip-project.org/mt/83115707/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--AXQZ7vSugEr1vy8Lpy9c--
