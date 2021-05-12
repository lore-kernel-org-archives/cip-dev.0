Return-Path: <SRS0=mw5H=KH=lists.cip-project.org=bounce+64572+6452+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB165C433B4
	for <cip-dev@archiver.kernel.org>; Wed, 12 May 2021 23:27:08 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 394D8613CB
	for <cip-dev@archiver.kernel.org>; Wed, 12 May 2021 23:27:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 394D8613CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6452+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id lUgBYY4521723x46XJwe5U3D; Wed, 12 May 2021 16:27:07 -0700
X-Received: from ss11.sbt-mailgate.jp (ss11.sbt-mailgate.jp [202.241.206.52])
 by mx.groups.io with SMTP id smtpd.web09.5859.1620862025009430219
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 May 2021 16:27:07 -0700
X-Received: from mail.sbt-mailgate.jp (sagproxy-out11.sbt-mailgate.jp [10.16.47.41]) (envelope sender: <masashi.kudo@cybertrust.co.jp>)
	(not using TLS) by ss11.sbt-mailgate.jp (Active!gate) with ESMTP id NIU510164A;
	Thu, 13 May 2021 08:20:58 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VaQeWfox+/OafmGETmQWNHZEBtl9xyblwY9985zwkcdURLpJMgIjGlk29eIp0/zXgQ7mgY27dVAP+aGuV1c0QSayxCthOzGZxOtwuyeCDCexX9FwN9w4gQLCzbmMWo/hnFSceL+rDQglfFlrwLhDt3j3/Esh3B9d/5RHfp7GtvlNLX2jVtugdY5gSWvYEXUG/vFNWRWKrmvGVeoBngOPJ4pKawX9W/Eh1uY50Toc17i1JMdOmlaBAE85YMzIJa9FzZAKp3WPfvXYBtJ/o/wwpumu8HBCWxfrk5zjYcyXh8aNTLUrLU4fMy6/wCenxky4PRj2UANU+30tPu08Nu041Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unfnOj1XaWxVaPQ4LsEXHXnLQZQ5sUbVALZe+4xfESc=;
 b=IEuoPPXye5KOFvm/KcFZf507M9f5NoZjh0MVYpuUKKhRCPdID+lnDZq8cAicr5bSLOahTY+2vYkf1JjX7MmDb2lIQoZVdtfsJvpJQgpnlDU/dBvJBpCt2Ps8PS7k8M7oI8Bo6i8Hg0QutnmP/Lm08S7xz74y1uvolwD0N+3d1eL85rWSfrTyr9jS8snhwkdI0PmlU7OhyrwSXJFYJJskEn90V52y4zyaz0dQZQgL70HRdrHiD/FUW4+iUhulbK6fXPfx6IVPKk6k2hcY/JUbYhxfZp0w7Bh24Baa/nsBCKfdwD37dEw+Q5/TFCUUb7JpNfpsbWKngfqpSdyDrduz5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from OSAPR01MB4961.jpnprd01.prod.outlook.com (2603:1096:604:61::22)
 by OS0PR01MB5588.jpnprd01.prod.outlook.com (2603:1096:604:be::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 12 May
 2021 23:20:41 +0000
X-Received: from OSAPR01MB4961.jpnprd01.prod.outlook.com
 ([fe80::d4a8:8e2b:514d:5c04]) by OSAPR01MB4961.jpnprd01.prod.outlook.com
 ([fe80::d4a8:8e2b:514d:5c04%2]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 23:20:41 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AddHhUdEZiUlA78NSR6G0mONoKVAwA==
Date: Thu, 13 May 2021 08:26:58 +0900
Message-ID: 
 <OSAPR01MB49613C0D1AC267BED8A51D59A0529@OSAPR01MB4961.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ebba58d-8934-44c1-bbb4-08d9159c8f25
x-ms-traffictypediagnostic: OS0PR01MB5588:
x-microsoft-antispam-prvs: 
 <OS0PR01MB55886FF06800C15DA3F5638DA0529@OS0PR01MB5588.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 NpV9+T6CA/Xg8i8E4V8q/GkrwLFZhwjkyq0tf1qJXf8/8cf9czFNWXOFc/Y+vmBozzdmNX/NuE0WrBQKhSnZhpOoEokOP/TCD8ZlRVvvxrSmV6MOiHkQpKNEhuksdeN0dJsDfv+un9UQ8SCJTpinlziD2YxkVuyHD31DL3sUj+u/kB1trK9d0YdyM8mhmuzWzJwLWOyfOpJ356PMmtItvTa2n34Km8plRJim7Lp2PElMdav8G9Rz2DA7J1X3sf4+ETuhcvlVTsBUbjtA9Dr8QyaUj4PbpNbQRRd09aCeWBXooG6eZv31SsHsyouA/dwprORX9R4k9N2lx+lQrjnobYW2UFfYElI39oz4f0YMYhIbRY6yCwwplhfBupNXZE8axOr+xzAoTT6FsvE1U4lpTsQ66bRLe21ulJWQ9l79Z/vnwpmRTYVFxt33RB8QHCQYvd27h/0tXOTEPLqC0cZvXecYAfxmiRBQclTEnUslfoZtn9HOD3E57VUwl5OQ3gmiMK/8Mt7OWGUKBROjrNdPHtRGG82W038FahgUVM31FlqlIyqxg5ysYwRQlT6q9alIsNIIzr00wKZDr2xGCXndIhwtm9H34Gg50aSLccTa9HUvBTzgQba3wsBinHHw7NnvzPRZhiBCeZGpmDXjEUnrVZ2gYlwD8lu7iOG2BKE6tDYLXFncQ73+ECKeRasgZRXDfoyb0XMqaAQsCpl8GYuDnSmO3O/lGDJsTyzUus0kgQla22ZPcXeWfyFhRk6db2hc
x-ms-exchange-antispam-messagedata: 
 =?iso-2022-jp?B?TzdRQllTeDFzb09HL3F6SVZ2RzZ1aDhVOWZ0RkIwMEtHSUk3bkxCTlFu?=
 =?iso-2022-jp?B?cnNyM2VTK1hRUU9MK1B3VHJOOEp1MG5kdWxaUWpkSklzTGdkd2dVa3FV?=
 =?iso-2022-jp?B?QjNLTnZEWk4zVm8vbWZZZHNvYjlpbzA4TUcraU5NbEp4QVR5T1ovZU1v?=
 =?iso-2022-jp?B?MWJKZ2hMaHZITVRHZHRiRkoydjlycitkMm9LdWwyamJONWVrRUxQWEJz?=
 =?iso-2022-jp?B?Szd2TUFIc3hyY2MzYnJ5aUdBdFdtd3Qrbk1mK05JbmppZm1QTGhwQ3Ju?=
 =?iso-2022-jp?B?ZHVGbWVuak1rc3dzTUk1TkhkRmVYMCttakMzb1ltQ1FaS0w3L3Jpakx0?=
 =?iso-2022-jp?B?cFJQc1djVDVjRGFpSExXVmE0Q0JWNW92UUx4SkVKdThOd1pPaWJ4U2hL?=
 =?iso-2022-jp?B?NkpRY2J3VU5zTnVMVlBiWDY0T0ZidVdGNWt5VEJmcVJvSUEycktVL2hn?=
 =?iso-2022-jp?B?WHVFWit3Zm1HSHlOWXdUZnVRMW9FdUlwS1o2blVoQTllME0xTHhsTHM0?=
 =?iso-2022-jp?B?bUNSRTEySERkaVVRcVQvQzNGSi9kc1FISDNSeko2RVRDbFlpamJjcTJq?=
 =?iso-2022-jp?B?YkVHNjNQTjkvSTltbUlTM1JmSTJ6akdhR09RTThudThOUGpEOHluWTdE?=
 =?iso-2022-jp?B?NW9Zb1BHaW1aY2JqbEFvd1gxUU5ybSs4VXU2VXNHY29OeEVPMGdJMXIr?=
 =?iso-2022-jp?B?ZE5HbzNHYk9zTkROTGQyM3luQlB1a3JwZ1JnaC9QektzV2JBU1RKT0lN?=
 =?iso-2022-jp?B?cVZTdWppVjdLQTFPZzRGT0lHazB1UGw3SlJHaEJ5UmdHM0pvWVB6M1I3?=
 =?iso-2022-jp?B?L0NseG5vT0E1TGkxY01WL0JrSS9jV2JqZFVjWUYxTlZkN1dHZ21NSDYr?=
 =?iso-2022-jp?B?bXY2Mm5Sc3VUd1ZpdTNJK2c3WTNaaE0wMGhac1FGUWNIbnV1WkUvWHNZ?=
 =?iso-2022-jp?B?Vm5abE9DRTVaK2dRQmY4ZEZzcUY2UStZL2xGeVhFRXBvNW5nTDhEeitT?=
 =?iso-2022-jp?B?TlhESHpQeVZXcFo5NmRDbVY5bEgxekZoSDJFQ3V2ZG9sR3YyVXhQamEz?=
 =?iso-2022-jp?B?VGJsTGUwN0YrYkxkSGdwNXRJa1E1SERyc3NGdm5UTmRQK0tWejFXbDNM?=
 =?iso-2022-jp?B?ZVd5TkRqd3V1a0dQTlBCa0NDQXhka3pwRmcrSUQzZGVKZC8xdHlBQTZE?=
 =?iso-2022-jp?B?Vmo4cXk1QUdKc29seE5lMVZYOE9kNTVBZHhNVnFLUFNRdGN1RzRiRUVu?=
 =?iso-2022-jp?B?UkpveWJJKzF4bDRGemMvZk9SRDV3aEU2ZGV5OTdvS2czeUxJQVZtVFIv?=
 =?iso-2022-jp?B?R0JZbGdPNEN1VVNIZ0ZuS2xoeVFMUStmMUZHVmZFd1BKVHVzenk5MFlk?=
 =?iso-2022-jp?B?NDRFMjdsU0xWZ09oeGxRcVFrM2tvaG1ZMzZTU3kxWjdRNUg0ckpyZ3Fw?=
 =?iso-2022-jp?B?aXNOZnpBMUVEV2FpWm83RngvSWpHd1p0WkgwaUdGbUFFWVZ5UjJPbXhD?=
 =?iso-2022-jp?B?NzF2R0ovNTFEQ0k2YUZxNDF4U0tnN3NJUHJvYWhVaFpqcHNuVDJheW93?=
 =?iso-2022-jp?B?SXh6dWNEWGZrb216NW4rcUNVOEJPZkR0YllYT3VpK1QwblQvcmdDMGlr?=
 =?iso-2022-jp?B?K05mQ2h2dllRZ2NWTXU5MUVJSUM1STlGT1FsS25ZWGV3eEJWKytrQ29o?=
 =?iso-2022-jp?B?R0p2OUJmKzFnTE1wVDAyNGF0VjdnMkF3YzlUTzBGUnIwL0tzTlBLT1kw?=
 =?iso-2022-jp?B?cE8xazJqMXd2M3lxWVdjNktqbGNTbys5UE1LWHJJUmtjMmJJYk5peWxo?=
 =?iso-2022-jp?B?MVZIV3VIakNLMG5pY2pTLytDYys1cWxDdk50M202UjN1T0s0c2IzVEhl?=
 =?iso-2022-jp?B?dWlnYXJSNFhoL01md25FVmZXQjlXTTYyaTA5NXJSNE9TTHpuTFNjMVhl?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB4961.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ebba58d-8934-44c1-bbb4-08d9159c8f25
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2021 23:20:40.9012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q23Eg9R3Y2Az/HPgI/mzIQ36nnVIR6Z778d7kElI9kmNxHgNebYTTH1nXxiQIG8Z3xF6QSrN1d5lyP4DE5Plf7+5Cy2DOKRIDOSd6OtspcI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5588
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: oAmDpTSdiu28eKm5UU6uUjuyx4520388AA=
Content-Type: multipart/mixed; boundary="hctgM5tqE65ZCoSMO9g8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1620862027;
 bh=84srCZYqknvl77MQDMvwy1DUTXiV3H4nns8Sx144D8k=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=sjFiddcoxGvvmAUaQxJ6t5ddhgAsI8MMu2/J0k2xEEuuHpc9gz7rMBiq6kYM10IN4n0
 t1QD0Odwli56FbSNupqoN+lA8ARJAHMfNyusMkTb2oXgL5JPJVClUmMPwJhRtASH2Z12J
 fKUoJcijlUDQ4WYXD80yJ11f9ot/k+cyqR0=

--hctgM5tqE65ZCoSMO9g8
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2021&mont=
h=3D5&day=3D13&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&=
p5=3D241&p6=3D248

USWest	USEast	UK	DE	TW	JP
02:00	05:00	10:00	11:00	17:00	18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2021/05/cip.2021-05-06-09.00.log.=
html

* Action item
  1. Combine root filesystem with kselftest binary - iwamatsu=20
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

--hctgM5tqE65ZCoSMO9g8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6452): https://lists.cip-project.org/g/cip-dev/message=
/6452
Mute This Topic: https://lists.cip-project.org/mt/82786911/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--hctgM5tqE65ZCoSMO9g8--
