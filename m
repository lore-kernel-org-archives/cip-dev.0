Return-Path: <SRS0=IUQJ=7X=lists.cip-project.org=bounce+64572+4793+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1400CC433DF
	for <cip-dev@archiver.kernel.org>; Wed, 10 Jun 2020 23:56:03 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6187E206D9
	for <cip-dev@archiver.kernel.org>; Wed, 10 Jun 2020 23:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="BNOAs0l8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6187E206D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4793+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 0dALYY4521723xHKAimWwMQA; Wed, 10 Jun 2020 16:56:01 -0700
X-Received: from APC01-SG2-obe.outbound.protection.outlook.com (APC01-SG2-obe.outbound.protection.outlook.com [40.107.131.100])
 by mx.groups.io with SMTP id smtpd.web12.739.1591833359817763906
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 Jun 2020 16:56:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NnCzaCtyS2NQ2iTiN0N6l8sjBGH/0RYAEfooZU1O/gorm4r9N4etu6ao8WKvQrCkw+k7hnsRziQOFEkPUpmQtAYB6P0Jr0SBxN4m+aWGdW/fKtJH7r7Z3RjdADy26jTAgRh3K4/07RMP1/Shu015rAPI8a2hzKXIFh9BwHmMj3kyIGn66LSYEA2Pw8iIaHWINcwXKBbE6qPSZP8YLw+7sZBdmaz8DakRd6YD8Wc99QX7QfBaHvyb5gQDRlgw7DLm69kUSLvKZm/HRgIzZKwDdk51mWy9juBEVrZwibnKFgM22YW9nWGx7lVIvf2GD5qeeNX/sCyF/9Tkj1CTJA0+aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TNq0M7au0m9PDyB3tQTLb/tXJlupIpoEp1zRT5B3L9k=;
 b=W1DDq0mm/BU4eorIy3S3zFYbHPdop+2zAwQi7SkqSJPK4Ve+OAfDeWtxc5DLVW3qJzIcRBSI4/9sC8/CRZYJ6NRQ2vKQHXp1r8B7V1eMIpSOR4t5ai3YFyL7sYM8F4tY1CxKd34ABoOnw9jrXifiD7uuTAIk+7bElTNihSPV2YJHSKINYUOaNM/Vt5/iVTeb6nzUex2xjC4RYP4FtsDFbnRohKQKYTl8/Fi3QKqh6zvbQ8lOwXTouIrgkn6HIzISFu+72vK+Q2PH+4K2aMeA8O20HgJtfeWkqsnnaiqew2PDZdbUNRqk6POisavvMC+5n3JDxbQbjCqg/IfXz0DnZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TY2SPR01MB0005.jpnprd01.prod.outlook.com (2603:1096:404:61::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Wed, 10 Jun
 2020 23:55:56 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::d9d9:60fe:a138:6752]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::d9d9:60fe:a138:6752%4]) with mapi id 15.20.3066.023; Wed, 10 Jun 2020
 23:55:56 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdY/gpn435E1FFPtRxC0bLACZq1qzw==
Date: Wed, 10 Jun 2020 23:55:56 +0000
Message-ID: 
 <TY2PR01MB49724F8BC9AB8EF4DBB23A7DA0830@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 98b220a2-89b3-4c2d-e053-08d80d99d184
x-ms-traffictypediagnostic: TY2SPR01MB0005:
x-microsoft-antispam-prvs: 
 <TY2SPR01MB000564A36DEEC630B8D04B93A0830@TY2SPR01MB0005.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 k1MXk2yT62Ekb8TsmdKGDdJSORXBPDl917V6reHaaOhRizmG2PZqq4fnXL3fH6jUzkJ5C6cuIX5DB9T9URp/fcRFZhSGnvmDphJuxkYw4ZzdfDumPHCOgYfHAJwNKz5ECDET3TEmprCQMBlb+5bAlfr9kzBzquQqMAC68x3fSNxzgXWsRvNEB1tOAYoP21gGCsEXsjNtzEW+Z6MYKPRar/14EHACRsWHSpivJbBu0hcTEDOS2trGqfGJ3pExhGJj9xcGhfQuAYDcvXv76Rj/9DaP4GJQcBiL+5/P2rlixq2lsmt/B9sJEi918nD5g5tamcI5kvmlP/pgSs378mu2ZbC5tAdOHQT32bXdl3liEvwHqjHnchVN6QW+bUoqD6FIOA7Cc/ECqd3zZhbBadZjvQ==
x-ms-exchange-antispam-messagedata: 
 kXFMG/rTJ9DLjeNmqTZ4qzyDeWDE7gMD4cdxo2Iz0HQXja6YtvHpSca6NeQukdDp7trKe487ICmh+n8351gwUHhCrYTzEoc8CWv6A+lf4CKf9FYLbyN8B8lUDfr98a5M8mYwDn6Un/IHUnJnQoXt1rs4A25Z1Uyi20tRCTIOv3io5DgVae32oZoerrU6RNRqV/KJKEyOzSQZp5m6eZxemeO+3Z3l/KdNj0wcjAuwdwddalfLyy2BTkvUqqOWzGIuD/3fs6J7AWMfm802/YY4hCa9OFSapRSzVL+713bcJy1DLAdpXl6vY8UuyxIoOMNckZP5cPMMZW5zG4y1UBVfy66R/ICpZyxMW5g8Y+fuN4D9uE8Z0e0oO91/tSNnogrnpVNmNOt9T2ssHdGOYncoMMJCh//NSMvaPlkIxko4A4XIQRi43sJtis/NGq2zTQoxQUVoIuG2efOpNC9clV8J63eaR/VsKYlU+m6iqUupapGj/8QRbIT2p9as6lvhtoVr
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b220a2-89b3-4c2d-e053-08d80d99d184
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2020 23:55:56.8189
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sw9+CwVlDUgqHTLN0T8meiwW6UcPrutlblCtd4ka+5Y7i6uPFz5DBuZc+DQ4PXmvj/Sy9nM2YyutHGvjZ1FtXHn4JS5kZIZdYblGfjpqV+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2SPR01MB0005
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: VwDadEqdjGu3LlZ02bn1AI2ex4520388AA=
Content-Type: multipart/mixed; boundary="k4Ao7m43IR6MaK4gLzaL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591833361;
 bh=sdrL/rYh0ToRNkQDo4O+zrJs1aVNN458997ixSzArvM=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=BNOAs0l8VJ3fHrJOVx5hfseMT0wE69xcwIrbXpCKG8MbobfiHS3vw7MZPmdhv4IKAUE
 //sTR8eo3onT/1u8NTfCGpCmsDOHgldyAZzt/hZzt6y763hyQTvXJ/VpuP5PTcobsMFct
 Vjo1PHU+5wU4DBdrTDaDBSeORvQLlcPJX6Q=

--k4Ao7m43IR6MaK4gLzaL
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2020&mont=
h=3D6&day=3D11&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&=
p5=3D241&p6=3D248

USWest	USEast	UK	DE	TW	JP
02:00	05:00	10:00	11:00	17:00	18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2020/06/cip.2020-06-04-09.00.log.=
html

Agenda:

* Action item
  1. Combine root filesystem with kselftest binary - iwamatsu=20
  2. Strengthen sustainable process to backport patches from Mainline/LTS -=
 Kernel Team
  3. Upload a guideline for reference hardware platform addition - masashi9=
10
  4. Post LTP results to KernelCI - patersonc=20
  5. Ask board owners to review reference platform configs to optimize back=
porting - masashi910
  6. Check CVE and Patch, Bluetooth BAIS attack (CVE-2020-10135) - iwamatsu

* Kernel maintenance updates
* Kernel testing
* Software update
* CIP Security=20
* AOB

The meeting will take 30 min, although it can be extended to an hour if it =
makes sense and those involved in the topics can stay. Otherwise, the topic=
 will be taken offline or in the next meeting.

Best regards,
--
M. Kudo
Cybertrust Japan Co., Ltd.

--k4Ao7m43IR6MaK4gLzaL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4793): https://lists.cip-project.org/g/cip-dev/message=
/4793
Mute This Topic: https://lists.cip-project.org/mt/74808947/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--k4Ao7m43IR6MaK4gLzaL--
