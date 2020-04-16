Return-Path: <SRS0=fBB/=6A=lists.cip-project.org=bounce+64572+4578+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7B0C2BA19
	for <cip-dev@archiver.kernel.org>; Thu, 16 Apr 2020 02:02:56 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06CF32072D
	for <cip-dev@archiver.kernel.org>; Thu, 16 Apr 2020 02:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="L3K84SEu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06CF32072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4578+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id zmTLYY4521723xzkp7RtxnoE; Wed, 15 Apr 2020 19:02:55 -0700
X-Received: from APC01-PU1-obe.outbound.protection.outlook.com (APC01-PU1-obe.outbound.protection.outlook.com [40.107.132.121])
 by mx.groups.io with SMTP id smtpd.web12.2447.1587002573363662375
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Apr 2020 19:02:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TSx0YIwQKLib7n9B7EYbJ0ny+kk8WhpaVrK1pDm1Gag61/Eud1StwFeIx0foegPuZhNioCL/8brw2KFL7a7H5cplaS1nAjRBLp6KMyWBVgll/5PJq1UQwAhT4Dah2Q7tEI/tRlMr8+02X/mbsfOsTl/OMkF76oJCUpQku5xt6OmuQ9yLawIZzbUbWfmTnfaxypYZITlYqR57yJvT3cLOwyQ1EXJd3wOAvSp3SnHYl6FgwxCQ79IEQlWUiCnXTRkDSIM4ZYzLSv8tp+mc/jYlarGp/uN7oWKBtd8il370hzjMxBv9G+ZQti0n4pqbHg987rEPMgqgiW2QsKaNkceP+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ldyqRi4Ar4u0yDzOWeTwpEg1NnerBl/y/jAb8ZVoVwQ=;
 b=Nck4R/MbJEIQkpJhtikvcXTqIYqG2ejzVAVcJPCEURK2NWHKDZZKq5FV9N0rJ2IkIuLlfzq2jhXWpbOnCxt7S8KnfELeLY1f24nxD37ARcXGa9UXmeZ8L+BpqkFeuIuk6CYAsf/sqzvnc17zN0Bd6su0eFcsDDzx/smtRgioMEDOQiuFhU0kjsnUpxrFR00aSEAWKZ+pW61sFuDH+eJCW3f+YoQ3zgZfZTi9Nf2+GizrOJTaAeh6u13C6FBvvbUcZrsiv/wziFy3vDBHao295tJY2JACtR7vEWZnM1fHYNpGhMAJGFDB8/da/iRuetDsp7L3+4RDlZoLLlaLVGfKNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (20.179.172.148) by
 TY2PR01MB4201.jpnprd01.prod.outlook.com (20.178.142.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.19; Thu, 16 Apr 2020 02:02:50 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::e845:c7d4:4f:c3cc]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::e845:c7d4:4f:c3cc%7]) with mapi id 15.20.2878.023; Thu, 16 Apr 2020
 02:02:49 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdYTkwPVJpEHHN+iQmCdazHKo4mwew==
Date: Thu, 16 Apr 2020 02:02:49 +0000
Message-ID: 
 <TY2PR01MB497244C4E5B3D48167AFF5ADA0D80@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e99c48a0-bb0c-4ab7-134d-08d7e1aa4420
x-ms-traffictypediagnostic: TY2PR01MB4201:
x-microsoft-antispam-prvs: 
 <TY2PR01MB4201190204B18D8ED89A40FDA0D80@TY2PR01MB4201.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
received-spf: None (protection.outlook.com: cybertrust.co.jp does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 bMG/sUwAfgvAYEBKrB79lpLE8p8y7NadLP2S0ri+G/VEtORBVTKbyuflzq+z4bn4W6KRRDzV6BWVDfFFu/C2/uXBC5gLOaPSkFQEoTEw0DkMwMLYNso4U1ngfhg112vBkA+cLVZWBuHn90SBTXhveGkG4FPL34beR/pvxuHELfidHnJfQVf1MnheAZf7PlHNnax9AUkjY5tRVFHKkrpsu7HnCX1XVFRPmb71twxLEHIw3WcI/0J18kMQW6grwQ1IW200772omiIFAnuRMLXhh5tKXSorSylaPN2c4F+2EmiJ9XYMGfek4/wKK3lnb5kYU5yCm57t2jKH6NZ7uth+07bYktu+9T+KuwYWOE94y8J5WuIAD+6ZIDGUDNGJ/ObCZPSUxmXyeIyl7WtJ+p6ptIMhz++lEsagnio6BaEDJRkchFBQMFCWGYzvo/+5NvPVc+Wud5Sbnu6XXckx6M91GXr1y/MuNESEkSNNRBkRxipzPcGLmyBqFXoLsA69Vqnx8NVadxRh4yD/ZMKfJCnILQ==
x-ms-exchange-antispam-messagedata: 
 zowY5OwG1YzauQTBa64UUOzS0FziSGvH2UKdYZGlZDHD663Nl4xNb0yHLIT6Rd0V+PDbLSL2J6XYnDYptlKf/YzrRALLr4JpRDZcMLxYzGhaiYKfogXbYmqLaKjWEf2MEuhNxnS7EFzRXJP1Yhrg6A==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: e99c48a0-bb0c-4ab7-134d-08d7e1aa4420
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2020 02:02:49.8747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cl4g0wAzrJFQo09oRirHT6tdozKwBDxlrMy6MLHH8y32WkQBhSZ7Dt2/QT4ENTJ/8Z+jokK9AWIfypDOardh6lS5sxQE93F440O9+fpeJ2w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4201
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: QrzHS0MqN7xIzxSJg69Y6Adgx4520388AA=
Content-Type: multipart/mixed; boundary="UCDlbMqJbaX5rCOYFbF6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1587002575;
 bh=2txC7lszA2AoecFv80x6WfhFGPZSaJdN0sUlNzzyHO4=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=L3K84SEu6dhnUTAt0pb+FztgNggzi/XIoO9SuY04aztGLhIp426HTdKXj2cvqkVNJCV
 IGOP6YjLyyUPnGR7QOBY3Lg+afqgtc3W+bF+nSu6MZ2dIW8B3uvwDIi1LoN2dpOYTuj8u
 cEbPSWBzPOX+rp5WnuQ1dhD8jYtxS/kzmR4=

--UCDlbMqJbaX5rCOYFbF6
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2020&mont=
h=3D4&day=3D16&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&=
p5=3D241&p6=3D248

USWest	USEast	UK	DE	TW	JP
02:00	05:00	10:00	11:00	17:00	18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2020/04/cip.2020-04-09-09.00.log.=
html

Agenda:

* Action item
1. Combine root filesystem with kselftest binary - Iwamatsu-san=20
2. Strengthen sustainable process to backport patches from Mainline/LTS - K=
ernel Team
 2-1. Workflow for identifying important fixes, backporting, and reviewing =
them
 2-2. Prepare the tools to be used for this workflow
 2-3. Get practice in backporting patches
3. Upload a guideline for reference hardware platform addition - masashi910
4. Identify target boards and configs for RT kernel testing (4.4rt and 4.19=
rt) - masashi910
5. Clarify the requirement about system-backup - Yoshida-san

* Kernel maintenance updates
* Kernel testing
* CIP Core
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

--UCDlbMqJbaX5rCOYFbF6
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4578): https://lists.cip-project.org/g/cip-dev/message=
/4578
Mute This Topic: https://lists.cip-project.org/mt/73047683/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--UCDlbMqJbaX5rCOYFbF6--
