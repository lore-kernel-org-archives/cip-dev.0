Return-Path: <SRS0=33MV=LZ=lists.cip-project.org=bounce+64572+6588+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFAD4C11F68
	for <cip-dev@archiver.kernel.org>; Thu,  1 Jul 2021 01:51:55 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30E2B61474
	for <cip-dev@archiver.kernel.org>; Thu,  1 Jul 2021 01:51:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30E2B61474
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6588+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id VR2BYY4521723x8GpumvvolY; Wed, 30 Jun 2021 18:51:54 -0700
X-Received: from ss11.sbt-mailgate.jp (ss11.sbt-mailgate.jp [202.241.206.54])
 by mx.groups.io with SMTP id smtpd.web10.1547.1625104312134427455
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Jun 2021 18:51:53 -0700
X-Received: from mail.sbt-mailgate.jp (sagproxy-out11.sbt-mailgate.jp [10.16.47.41]) (envelope sender: <masashi.kudo@cybertrust.co.jp>)
	(not using TLS) by ss11.sbt-mailgate.jp (Active!gate) with ESMTP id BKts23044B;
	Thu,  1 Jul 2021 10:45:44 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J5kv89A1PR7Ql6dDmJeGH/5mTtcmbY1I+xwBn/pd1MAGl0US/w6QvQQaE16l8E0UUNWlZajelTLh6AqDjgZceUllsPf/ICnMJhQ/QFbHMTB2IYZr0sylfjQbruzgWggHTwZhQb8Ff91d8ythF6fNEto4yS2hN6rIbgChScSOnk5cnpJAv5OhwbQ3aQBEbw7Zq6x3BlDV7JcWdKWaUQ4F0tf9EAHUcFvejI1yDF3IckmiZxw97DbtXyiVeJbfeyHhGYeaGkrbrEWzinCZ2Hb/BqIRDVE1+eqBXDLGK4+BPJsf3tqsGwQr8x3G5C62WzMIU/o7O27g9rkyJPVwjJGQ0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESGj+FFuBgdilBEzvfP9MzId3O0mpUQ7/S0O8H7R/pg=;
 b=kQGSTtMKu/zdGacTWkoM+BPMCDfBJhoVdfLdCEiIgr1Zy7GZw4ol/OfLRVQAg6vaFOcRqCaiLChE1ASvmayTzi0mm/h41DgkfKsDGhY1JtPwvI7h0ZgW1RNah4y4IFmuN5fYUSWcL+H23MXMqPyoy+m7AnUfoxAVLsOhsl2KTYb/IUIO+chL/pCjwTAdfLtKPP2l9xawzDc6ei6uxX132plCmFR8Jv71kVQ0RVFD8NQI3Qf/9Ieam5yhjGAKDZRuxiDz8hYuWNHFFfP4Qij1bwDo/kbTMsuVn3UAlPnOUqxqH/BFQTsnObiSqBrbpIDB3meBrdnS8pyMEu+EAyo7NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from OSBPR01MB4967.jpnprd01.prod.outlook.com (2603:1096:604:7d::19)
 by OS3PR01MB5606.jpnprd01.prod.outlook.com (2603:1096:604:c5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22; Thu, 1 Jul
 2021 01:45:43 +0000
X-Received: from OSBPR01MB4967.jpnprd01.prod.outlook.com
 ([fe80::80ab:d59a:b7f3:82e0]) by OSBPR01MB4967.jpnprd01.prod.outlook.com
 ([fe80::80ab:d59a:b7f3:82e0%7]) with mapi id 15.20.4287.023; Thu, 1 Jul 2021
 01:45:43 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Topic: CIP IRC weekly meeting today on libera.chat
Thread-Index: AdduGr595fPr8FZSSP6LYxNqhHb4Og==
Date: Thu,  1 Jul 2021 10:51:49 +0900
Message-ID: 
 <OSBPR01MB4967581AE568B6B1C169194DA0009@OSBPR01MB4967.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7c06390a-c514-4e84-98c1-08d93c31f043
x-ms-traffictypediagnostic: OS3PR01MB5606:
x-microsoft-antispam-prvs: 
 <OS3PR01MB5606CF53C147A3AEF5F2ED59A0009@OS3PR01MB5606.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 pkg8AoIGWf0PUJyZNE3BEdIrRFKk5t5mo3MsCFd/wPsBsJmhMlWHXGvJRnYKjwjkaT2D2Y7xZNrTsPSN5gVICbfx3eJe2P5yn1mscb5C3de1Zi0tdUWcpl+cfrsmw/3D96htq/aAE0HEanE7zFcHgbR+CZ/Ekpy7kYBXZckcANsjt6x/spNmA1N1RE0TMpCj9ZvapU2NbY6/IhUP6BeOLqXCkfr0UrLLTlTx2c8Tf76WD+odpI7JUBoKRbJvbN9k1zV0RtgI0k7aZ52IFUZ2QTQlFI39rFwDRQBpFja/RGvhs5wAfBdDzdIxvZ4KpeJzNEo3iUDeaHtcDRxTtbwpQmLjq9Xp4SMLx8Fi2EUaapShzNqYX065hdylU3zDeRNAB45qyfoy36mHZjtokoQe/B5o5/lMelnM6gnaHAgGnsZ87dAQ1u3AqMsUPVDYh7iFX3qxOlA6uXrPvuPC2xpPcqQAXGRhUyUKeKZBGrlG/JOA0ikWRiR1jDvjU2B9TC8fdXWvZhYOfiZR363ilfhtR8DWgjeKvLqy/0khgbnPRqeQDgOgKwrfZfDfSUzg3cZK7Xx6isrrJalW9kdoWMnIUOFGQyNsXRIxFnMeMwsVQ1ApU+kGctg701ZHMUc704xnoq/sAqSatBzYxJV80yC2ReeFD0uI1dPQa9abIIMZGkfAbk3sRzF4tCsmSxck7CL0rRj+Pt7TpMra4huDU7pP3csVji5quiDmNZPyQqmcp/sw1CJktDYvTuodyna9QFmwzhtqIH47XHKMvLHs4yZU5LlkxybJoxdBbWoYNdGYroAttoLDJb5rJz7Naglude0w4NUhtbivH4d9R7UgtF6gfMY3S8883VAVY2lpY+if7gWopB+XQw742e2EqbPK6d6W
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?OEY5TmNKaTAyYU9NbFNNVzUzVXp1RHVuNlREV0RZLzNGSzhBd1IyRllI?=
 =?iso-2022-jp?B?YytuS1pNanJUYmgxT01KVkhoZE9iYzVQZjh2L3JvNXM3a3pPOHd5SmUw?=
 =?iso-2022-jp?B?MEcwVm55cVMxT0FPSXk0YUZzK1JMQ0Y0K0tSUlJZQVhnWVhPdDFoMXND?=
 =?iso-2022-jp?B?Q2ZsTW1NRlVjNjErZDBpQ0lYenRVcHUrVFlPSjUwbDkxUEVYQXFrUWVm?=
 =?iso-2022-jp?B?eTB3aXJCL0V4RDhTVTNoQ2RNMmlsdGhuNzV6RjVNS1ExYUdvbHhhMWt4?=
 =?iso-2022-jp?B?R0JSSGhjVFRZRktuRmR0TXhWc21BV3J5azdMNm1IQXVqdDJiOVdCQnpx?=
 =?iso-2022-jp?B?YUZubHA4YThmRXBhNTQ0Sk5NREFjQ2lRYTd2TjExeEhyVzJMcWh6M2J6?=
 =?iso-2022-jp?B?dzg0ekV0YUZNOCt0TlVpeEhmTHYvUEIzYmFiYWk2eENjNk1DSTRhSnln?=
 =?iso-2022-jp?B?eXlqNFFTQTRVc204R1VCb25OazBPQ01VQ01JdGV6OFRBMTFkYmVjcGtz?=
 =?iso-2022-jp?B?NHI5UzQ4M1I0VmtIWWFyL0tzN2pBd0kyQWZ6U2JRWU1QNWtIM21RbEw1?=
 =?iso-2022-jp?B?NE1sSjhtY1BiY0ZwNkttRVZsM1lXY1dSTTdnQjdKdE5FYitZTkFLR1BR?=
 =?iso-2022-jp?B?RmFOZkJ1MjhlTlc5TTE3bFVjRU51ZG5UUm5MNzRVTEFzb085SFJYbjZR?=
 =?iso-2022-jp?B?TGQxUE0zVTRjZHNrSUZpVXRQUlFQdnhvb0htNUhFS0x5VHpwazlkOWxn?=
 =?iso-2022-jp?B?QUl5TXVtUFkxOHlQSFlTRWg3TnVmQVI0bFZwWWtlTXBYMFdsRm1mRFFK?=
 =?iso-2022-jp?B?YU1oTGFWTUJnSVpzK0xXc3o5Qlltd0NzY3VsOEdTZ0ZJcG5CakFZM3o0?=
 =?iso-2022-jp?B?S0xzL25rdXJsVnBZaTBaTVcwMWJTK0UzM3NUbDFnSmYrejhxZTgwWkhp?=
 =?iso-2022-jp?B?MXBUWFE4NmJOc2NrMVdBNE1xUEt4N25XTmNkYXFQZmdSMEVhMEZIVWQ5?=
 =?iso-2022-jp?B?bkNFSWtNQ3gxb0ZCaE4rdEpxK0lueFJ1N3NtQTR0MmFoejJQNTdDWWpO?=
 =?iso-2022-jp?B?a05LVlNJSGM3WDh4QTlybFg3RitBY1ZkSHZsK0NrVFV3UlhqdnZsTkVL?=
 =?iso-2022-jp?B?aW8wcENiaUZ2bjJVYWZYSUZxQ25QRGNvdVJKRFdjWnRQZXd5WmNPV2o5?=
 =?iso-2022-jp?B?ZVN6Mm1TS0txNWNZaDYzc2pNNXFLdmlnbnRnNk1zeEtUYVhzZ2RFYWox?=
 =?iso-2022-jp?B?cityaWRtVzAzYWQ4UWlraGVOVSs3OEU1V1c1RGc3WndiOUhHSVd2a3lW?=
 =?iso-2022-jp?B?Nm1KYll0d1NFWktkUUVhbkladnFRdkd2eUdpNWR2TUhKT096ZDV6WDB4?=
 =?iso-2022-jp?B?T3o2elhydithL3BJY01tN1VxM052SkM5WnNwV09kaVB0V2lNa1g5RlE2?=
 =?iso-2022-jp?B?ZjVHSTFEUEhVMk9xQlB1dk9QREcveHhVQ0FOV0V5d2I3bmdaUWJhK2hF?=
 =?iso-2022-jp?B?WmZKelYyVkl4TDRrSVo5MGJtdVBWdmVCMkdMUTNqQU02dG9odVpnZ21U?=
 =?iso-2022-jp?B?MVMyajZ2dUhYaHdUMW1QaW9KK1R3WVQ5b2I0aVpUcm5kcENQNFFwTlNK?=
 =?iso-2022-jp?B?ZWYrWnRhMUF6YU1XbkhrTjhUSENtWlZPNFFFSFJyaXVLQVhKSys0eFM1?=
 =?iso-2022-jp?B?K3pPM2E2bUxsSTZiWERzdU5MVk1sSzhyOXlvN2srcWZUenJ1bGJrTjJh?=
 =?iso-2022-jp?B?Ukh6empOM3JtMTRxaldiNnhYem1ERHdrT050aWRMS1liUjVZejFvYWUx?=
 =?iso-2022-jp?B?bjFIVk8xbEc1RE5Td25mOFpQZk9id0llbzFaOFdKSmdMVTJoK29KY3Yx?=
 =?iso-2022-jp?B?Zm5MY3VuY1h4UXlwNWNVZU1HcVd6MjhuMXZiNTNrZmtGWnhFZHByVnRN?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4967.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c06390a-c514-4e84-98c1-08d93c31f043
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2021 01:45:43.0862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CkHFUNAZmYZXxF+tfjW5lfmV8bA/4BujKXKuOZcUX2oV1Vz4d/ui5bSiQfSX7oz6KcXhDxDYtyL/HySFg89JXR0Jf3u8Ugd80crnk/AEhXs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5606
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: u7EKggB67IwpNIef6mtiiUtAx4520388AA=
Content-Type: multipart/mixed; boundary="jcXDn2MdSeOHORx5wSDU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1625104314;
 bh=s5gUnIk7ewlFB85XqfyW60qymU95yaQROkB/EJUlpgo=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=kYFpgIa/uelDRmxt97MrcXQ4H+sWYiM1/FRw4pXLNpTJ0T4LkL1FfLEwzRWjSPnJnXf
 0DepmyjfVo5lWnh3jbKyrTKIDjTsioofjBQjgYMH+WGvOJvUb+XvwqjGfRrrh/A4cGBb6
 bRnsgyYT/SkZCZkPWII76zUl7KUmMTlLNB8=

--jcXDn2MdSeOHORx5wSDU
Content-Language: ja-JP
Content-Type: multipart/alternative;
	boundary="_000_OSBPR01MB4967581AE568B6B1C169194DA0009OSBPR01MB4967jpnp_"

--_000_OSBPR01MB4967581AE568B6B1C169194DA0009OSBPR01MB4967jpnp_
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
h=3D7&day=3D1&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&p=
5=3D241&p6=3D248

USWest USEast  UK         DE         TW        JP
02:00     05:00     10:00     11:00     17:00     18:00


Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2021/06/cip.2021-06-24-09.00.log.=
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

--_000_OSBPR01MB4967581AE568B6B1C169194DA0009OSBPR01MB4967jpnp_
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
h=3D7&amp;day=3D1&amp;hour=3D9&amp;min=3D0&amp;sec=3D0&amp;p1=3D224&amp;p2=
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
s://irclogs.baserock.org/meetings/cip/2021/06/cip.2021-06-24-09.00.log.html=
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

--_000_OSBPR01MB4967581AE568B6B1C169194DA0009OSBPR01MB4967jpnp_--

--jcXDn2MdSeOHORx5wSDU
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6588): https://lists.cip-project.org/g/cip-dev/message=
/6588
Mute This Topic: https://lists.cip-project.org/mt/83907709/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--jcXDn2MdSeOHORx5wSDU--
