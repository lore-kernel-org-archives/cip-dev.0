Return-Path: <SRS0=HGQX=FO=lists.cip-project.org=bounce+64572+5948+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224D6C4361B
	for <cip-dev@archiver.kernel.org>; Thu, 10 Dec 2020 01:21:47 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E369239FD
	for <cip-dev@archiver.kernel.org>; Thu, 10 Dec 2020 01:21:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E369239FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5948+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id NovGYY4521723xp6E2l1FwbF; Wed, 09 Dec 2020 17:21:45 -0800
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.120])
 by mx.groups.io with SMTP id smtpd.web10.6516.1607563304072233347
 for <cip-dev@lists.cip-project.org>;
 Wed, 09 Dec 2020 17:21:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kTc9wjO9yKu9dhUYNkSQI82k3NxMgKILSJkUle8Q2tUnIzvdWGvx9enJsougtXU6C/jz2rhtQ1XKUPDmRguk0KzR88A8x7holL7usDZp8zguYFDmNTO13sDRZ3dv3j3b1yoZXjLEGKz1vpHWBMKpuyMztn/ydJqhQtWWK/KfaI499C4rofVzrBvmO3kLLB4lnabFVjrrt1DNtm6/vy0t01hJVJm+S52b6sIDZhcPQZg3FQvQN+AvAzQFoP4audCF44GDHnJodc8DH4qhRnzVkVS58xVn8MUcvFqacw3tRoMwBBr7CRL2B0zsY+nqHi80oWw1kzHsMYlulhnwV9v+qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KubdBCD+3adI1mC9GKFNXnF4C6563RiO9oqxKwPBZyc=;
 b=Ipvx832Vm/iVRQZDKza4PxnWug6Rfe7hPr6ZtxxtrqWjnDvcXtRtPmbEthexn12f4FbJwQbATq0mbrg25y9ma0AdcWAif8lRzwnC20jnhp/KxzMGySiFcd6NmeEUMl2yD18tXQ9iKGd7E8NxvdGwo4bne/9wP8dPFJdlXA8jjURzCUjGl0FOjCY7KDv7CXGTvRrBQe1UiI22rsP434eeoLZPzIJYo/mOAVrwRYEO0uOes1HgY10bLb40WhSOF54RgfPHNyNDgX7HI9KgSL91JZ3eg7lBCH5jJw2m4gH1kttawaC2g/1MvFEs8EC6GHOXFdZLgs4XZ3J9XvPkl890cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TYAPR01MB5929.jpnprd01.prod.outlook.com (2603:1096:404:8054::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Thu, 10 Dec
 2020 01:21:24 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::bc60:b903:db5a:4abe]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::bc60:b903:db5a:4abe%2]) with mapi id 15.20.3632.024; Thu, 10 Dec 2020
 01:21:24 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdbOh96KpBLgrw9OT9+pkllubqDboQ==
Date: Thu, 10 Dec 2020 01:21:24 +0000
Message-ID: 
 <TY2PR01MB49724D3FA4C85D6F56BDA0E7A0CB0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3964731e-159c-4f97-d1ff-08d89ca9e8cb
x-ms-traffictypediagnostic: TYAPR01MB5929:
x-microsoft-antispam-prvs: 
 <TYAPR01MB59299B8B12141EF74D5823FAA0CB0@TYAPR01MB5929.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 nyV/JOrk3wTwP4FXZKJyi4+QbiNNnI/vBrtVYtpT3TmwypWpJ0dvFnUizLtzvxNawB9cWM3lO0KMFgkwfu4M7IQVHpydVcvjGHRcyCiQu99PQg5VLetlSdDlqx8UEYGLL63urpgGlUENXNmsJO3anWxv86zWf/HKArEwKfZg0ysPH6gkVbG1CwCtDVfbKwedZ0SkyoD/Lr8REIvfJj8WXSYSoLZ2svAMO8i7//s2dM7H2N3iCVBdxPSvxvOBG17sfe3kwGlHilfoHwH1yGq+M/8DyjE4zuHb0R6lc6UuzlSl/tgOLkXnN8Lf3xPEcEck6nwcGRgfJd26oZRv15PrLhGOFcc/XHGNggstwa0T2GnKz1IQk9RKrG+pyCVnFDhHS6ADFj6iwPvL8eX/meI3Rg==
x-ms-exchange-antispam-messagedata: 
 =?iso-2022-jp?B?MkVjRmpTNWl1RG9CMG5uTVB6SGs5VXM3djR5c1NUSmx4eTh1c2pIRTFh?=
 =?iso-2022-jp?B?TUNEdEpoVmRyYWdLZHhTT0dVSllnbk41U1dhZW54RXJlODV1OHpiVy9x?=
 =?iso-2022-jp?B?ZzBCTDFETktJWnp6QVFGZXNFVVlsQ2JRemRMcTJodU5nVm5VczBpSEI5?=
 =?iso-2022-jp?B?WFZHUGo1YjByb3lWVmRVWTNzOFpYZkp5U0o4OFBEemRuUXZuQnNibmRS?=
 =?iso-2022-jp?B?ZFVPRzFIRGVBUk13T3dwOVBlUjRxY2dKY1NpVkcvSWg2eEdGMUs0R2JZ?=
 =?iso-2022-jp?B?L3l4RGZlbkI0RkJHT1FMVEFwTStobWh4YXNzMTdGdWQvbGhxTlZ4Z0RC?=
 =?iso-2022-jp?B?QXk3WTg3YkxIR1ViRmRDOFYvY29uQ1YvV2NGQWxoa0x3c21wdVR5a3Ji?=
 =?iso-2022-jp?B?Ym5uRHJtSGQzWlZyVmJ4MEp4OWRsWWFnTWR1czRBUWpHS05Vc1ZyYzFq?=
 =?iso-2022-jp?B?ajgwYVlKQzl5NG80N0lyeGpOYzVVeVV2S3MzbFVHMXVKaU5iWjZKdXN3?=
 =?iso-2022-jp?B?dUtrZnFQbXdqN2ZCZ0d4bXdtb0tnYUtUZWN3MUZYeWlKSlFTNTRIUW1p?=
 =?iso-2022-jp?B?UDhmL25FdERhS3Buem1zS3RoNXZyaFUvSTZ4dU1oeTBFRzNzU2gxcE1x?=
 =?iso-2022-jp?B?aWI4bUZ5d1hrWDJGcXBnc3dBbW1TVkUxZmlUSGpRR2lRZzBoMzd1MUVZ?=
 =?iso-2022-jp?B?N01OWHlYZElzNFdYQytYc3FMbHlpd0E0SFJKMm9iclBxQ2ZDZFhVMnJw?=
 =?iso-2022-jp?B?UVBjOTE3d1FwK3F3MzVnNTcwUlUyelgzQnVPUmtoUEdUY1M5b2E1WXBk?=
 =?iso-2022-jp?B?bHBMR21ua2w1WUYyeHlTWlJZLzBIS3BLalFtQmtaUlkzQ0x3cFlyZUlt?=
 =?iso-2022-jp?B?WCtKay9SUEVyVUhFK1lhaVcxWEVsK3o1ZXdSQzhLaFdnTkl4SUd1MDlo?=
 =?iso-2022-jp?B?UnA3RExrT1UwbzdYWG0xZ0xOWTZheDY3L0VOTUN1a3hrajNQSHo0Y1Iv?=
 =?iso-2022-jp?B?Qlo3bnVaL1JSdDNLUStkTGE1Wk1NanA2Zm1tL1VkaE95dmJzY3NkVDU4?=
 =?iso-2022-jp?B?NGMrNFo3VjdUTGdHRThwSmJUdkVXUUVHVmhQR0JZTzVXNmE2SEF0SVRn?=
 =?iso-2022-jp?B?ZDFRamwwZDJHbTRwMDB5S204Nkx3ZjVjTUxGS1FkMUFFWUUyckxBWFpj?=
 =?iso-2022-jp?B?Y0lndnphSS8xamM3bzRtU0hNWThqb1BpSEF3OEVpQmhrNHY1Zmp1dWxM?=
 =?iso-2022-jp?B?TjdzeGVSYlJRNDF3ZTVzVkM5UDNvWENndEtXS2wyWGNIK3gzaHh4b2V0?=
 =?iso-2022-jp?B?RTczVTRsd1dyZTd4ZityM2N0NmtVZG93MEFuUlZHWUI3eE12WnNBVlFx?=
 =?iso-2022-jp?B?VS9nVlQ3L01wSkdVMmpRcVI2dnZGTUNCRnpYcEIxK0lRVjdsOD0=?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3964731e-159c-4f97-d1ff-08d89ca9e8cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2020 01:21:24.0783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lg8Eo5o+A4t3ihss+VmXz69AyegT+nK0hmP9ewCPvXZwcq41JwHcQBnTWvjSAMqyBUxGoiRWaZhgrvhUx/JQcexo8F3XGmjj+bFGHBoRz6U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5929
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: ZTcYwZUExKyIZbObtZSHy2NTx4520388AA=
Content-Type: multipart/mixed; boundary="E1DxIFlpntFkBHykm5P4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1607563305;
 bh=BY5bJkMl2dWfzXMsWAkNEq9S+oL6ImBa1D8ZCq8bxEI=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=JUf4ha8+4DJRa6aa3AFQ1f6vo+sNoGi8dBKKJNJQ9oZNbx3lSmdKpUFBUIbvd9/q5iG
 Yp4Hth8tSGiWdAEERS17Y4rVN8slDJuG0DXfmTM9P4PqhGW1r5sCkNRKLw4n4qI4+BmWK
 URb8rSeMtQ/c3/NojFnc7BBs61RR1FjU6As=

--E1DxIFlpntFkBHykm5P4
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2020&mont=
h=3D12&day=3D10&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37=
&p5=3D241&p6=3D248

USWest	USEast	UK	DE	TW	JP
01:00	04:00	9:00	10:00	17:00	18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2020/12/cip.2020-12-03-09.00.log.=
html

Agenda:

* Action item
  1. Combine root filesystem with kselftest binary - iwamatsu=20
  2. Do some experiment to lower burdens on CI - patersonc

* Kernel maintenance updates
* Kernel testing
* CIP Security=20
* AOB

The meeting will take 30 min, although it can be extended to an hour if it =
makes sense and those involved in the topics can stay. Otherwise, the topic=
 will be taken offline or in the next meeting.

Best regards,
--
M. Kudo
Cybertrust Japan Co., Ltd.

--E1DxIFlpntFkBHykm5P4
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5948): https://lists.cip-project.org/g/cip-dev/message=
/5948
Mute This Topic: https://lists.cip-project.org/mt/78844943/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--E1DxIFlpntFkBHykm5P4--
