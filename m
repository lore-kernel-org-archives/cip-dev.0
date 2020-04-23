Return-Path: <SRS0=BFF7=6H=lists.cip-project.org=bounce+64572+4597+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D1DC2BA19
	for <cip-dev@archiver.kernel.org>; Thu, 23 Apr 2020 08:41:17 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D395E20781
	for <cip-dev@archiver.kernel.org>; Thu, 23 Apr 2020 08:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="LY7bFpZW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D395E20781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4597+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Jgj4YY4521723xXj9baTagda; Thu, 23 Apr 2020 01:41:16 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web10.2693.1587631273367739582
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Apr 2020 01:41:15 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 03N8fAWQ026939; Thu, 23 Apr 2020 17:41:11 +0900
X-Iguazu-Qid: 34ts1iCWKBisRSB0hL
X-Iguazu-QSIG: v=2; s=0; t=1587631270; q=34ts1iCWKBisRSB0hL; m=MsLJa774L8XG+ClFrwyOfa3fH34ZC6Tf+3LZhWs+Zng=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1513) id 03N8f991013834;
	Thu, 23 Apr 2020 17:41:10 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 03N8f9fi012276
	for <cip-dev@lists.cip-project.org>; Thu, 23 Apr 2020 17:41:09 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 03N8f99D008908
	for <cip-dev@lists.cip-project.org>; Thu, 23 Apr 2020 17:41:09 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HKbjAh9aWa+C84JYAaPyvI2fW/P5LCTi4PrjOyA4lA8SbMfqAA6J+AWhK9v+yUUHorBxwxR7Wa5SLpxzluA9tF/EI0Sbzu5bisXZXhJiskK92VtguZ+Uv0P35WSQ5L4E3XPsKin3NO4OHQFlm0yCAVMHUXVrySpcYzi23M7XnSIx/mL5srI9Lpboi9VbjwgCzzx24RRV1NS6RGMhFS13fCTLP4rRMwJFj5dzxuUM09aictbE1NR0cGrzSdhXbAXiuXwcJEHr6NodUljK04E9Mo/bCJ3aQAfq6q50yLwfKDGg2cHY+7oJektk+KXJzA/y9c1p+0ism8V0h6CF3XJuJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mmiGPKGHWO2ydnqSHc2QoPW0L5ucOwhAi1kCT43d/L8=;
 b=dnMRd9U1ruaX6o0jGSh/Y6XjdUALJu8qG1qnQBtNlRGFJAEzAsuDVNrjSNDikSJxIGxZH3xfZJ4T0yoK56QxF38McpDf8LUNvCRehF6wRA6/nYfAzrir+ODYzDRL4QeIM3Xo0LbnnjQKBxeIdOKDahXgM0b9ZRf5QBN/sA/Yt3mNBwCs1G0WBxgFYmepyVa6gSaUmga4rhmYXnIt1dTTfESsahArvvgt0ooZdevnKtJTeZxvuzzp2BiA2pUFofljpwG91SIWFZtysOTiD+/6IHlScOZu0zUrZhGZdg6jSxkkglVw/LeEvpwmLoCnv6bMUf7lg2krUv69r11FWXuh6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Akihiro Suzuki" <akihiro27.suzuki@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdYZAw/dNE7M/n10RWOLa0W5ttoGLAARwqNw
Date: Thu, 23 Apr 2020 08:41:08 +0000
X-TSB-HOP: ON
Message-ID: <OSYPR01MB5334F4029238416971E73FA4D9D30@OSYPR01MB5334.jpnprd01.prod.outlook.com>
References: <TY2PR01MB4972C9832D1CE44EC15964F8A0D30@TY2PR01MB4972.jpnprd01.prod.outlook.com>
In-Reply-To: <TY2PR01MB4972C9832D1CE44EC15964F8A0D30@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [124.215.4.49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9f41f3b2-d1a8-4a87-c7c6-08d7e762119b
x-ms-traffictypediagnostic: OSYPR01MB5496:
x-microsoft-antispam-prvs: <OSYPR01MB5496E2396831635CD9F9B22AD9D30@OSYPR01MB5496.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
received-spf: None (protection.outlook.com: toshiba.co.jp does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EjIaWnkLJX+NMW1RNuTE8o6zvTLjugqPpRuRT1BOtIqHwPs/z3RL0GKs2EI6myazGf34uGc/HdWVpzsKC+C2L4mkyDSP/cg8kuLYEJXROpBaiilAT2UEfOGrWZZMjw7qZAKckuE3poZIwKsF/Xch5ZT6bOAKr3CWCYzHfW0So5PzKMl2zqU9wE9u6fMEig5H8CXjf0B2tyHNccgYJ2fK6pO+n7Y/d3MiVyV4s4fKVGffSzjzOMmtyEOESz6VE6rxyKe9crAWwSbi+8pneFPO1cIKI/RQ/UbIPiFWC4yvnZWywMqlcJQIg1LjzRd9IqAIVxQvBq1uJ5zMADqq8NXeB9MEZvwdPFoGeTmthQy6Dzb5ylpCOhYVsFMbRTmyW0tY4/M5qIJ6xcOj/YR3ZXlSqZE+9HdDrxeps931+5Od9wEm8b8mkQpTs5cRIY8hPHTsIciQxJBP6TGQX/c1ruilnXHoIOdEvcxfcyq8pNWMp3GRbnaXiU2vca+minQQaPTzuWylOBtshUZAtd7WaqkRpw==
x-ms-exchange-antispam-messagedata: /owXbNIVJeqmFnA4O2mzbLUtoVl7dxjhHwHU4nJVMTNPnxHoOpy/sTkpMZS8vXA3iW4Hd0eSqYicVq9v2y24OOnOjLjIyRtRAY0uZZlwVA5PX09KD4Peq7xqlS6taUdbFrSujC1kC/czqYA0RdX/rg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f41f3b2-d1a8-4a87-c7c6-08d7e762119b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2020 08:41:08.3760
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V4YT/0QeN3LldEuYWOtgVE4j40gLRXWSiX06GBhlyaIK4dwATYAwiGyPtenxrh9bcmAgvvoe76Ma2VmRFodx/Hgo7Z5bIohK9Lf8nMCEWwE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5496
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: VxDMAKyibbYegPCitEUrzJIvx4520388AA=
Content-Type: multipart/mixed; boundary="uvPp4PL2nWYCMqxdgvli"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1587631276;
 bh=ACtthgUEe5wKbjgAHKv3ABHeaA2rzZM3UZqDSN7TW0s=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=LY7bFpZWLjaKYXAM3H/k98S/yASA9LC1g35+GSRHQrOE80DT/rmn99TPqxuTrcZ0bJl
 xEp7ZCX3VGG4fWDrv2wR1eeitn9LX1VXWLuqTjCBv1lZJGKtdqLjyRnc6E+0AMgiz2RN7
 52izsJEVvoPBDA2Vce5g6Dvc91cLjb/Tgo8=

--uvPp4PL2nWYCMqxdgvli
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi Kudo-san and all,

Sorry, I've got a plan already today. So I'll be absent from today's IRC me=
eting.
SW Updates WG don't have any progress this week.

Best regards,
Suzuki


-----Original Message-----
From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Beha=
lf Of masashi.kudo@cybertrust.co.jp
Sent: Thursday, April 23, 2020 9:07 AM
To: cip-dev@lists.cip-project.org
Subject: [cip-dev] CIP IRC weekly meeting today

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2020&mont=
h=3D4&day=3D23&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&=
p5=3D241&p6=3D248

USWest	USEast	UK	DE	TW	JP
02:00	05:00	10:00	11:00	17:00	18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2020/04/cip.2020-04-16-09.00.log.=
html

Agenda:

* Action item
1. Combine root filesystem with kselftest binary - Iwamatsu-san
2. Strengthen sustainable process to backport patches from Mainline/LTS - K=
ernel Team
 2-1. Workflow for identifying important fixes, backporting, and reviewing =
them
 2-2. Prepare the tools to be used for this workflow
 2-3. Get practice in backporting patches
3. Upload a guideline for reference hardware platform addition - masashi910
4. Identify target boards and configs for RT kernel testing (4.4rt and 4.19=
rt) - masashi910

* Kernel maintenance updates
* Kernel testing
* CIP Core
* Software update
* CIP Security
* AOB

The meeting will take 30 min, although it can be extended to an hour if it =
makes sense and those involved in the topics can stay. Otherwise, the topic=
 will be taken offline or in the next meeting.

Best regards,
--
M. Kudo
Cybertrust Japan Co., Ltd.

--uvPp4PL2nWYCMqxdgvli
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4597): https://lists.cip-project.org/g/cip-dev/message=
/4597
Mute This Topic: https://lists.cip-project.org/mt/73209616/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--uvPp4PL2nWYCMqxdgvli--
