Return-Path: <SRS0=cfpT=B6=lists.cip-project.org=bounce+64572+5157+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 761BAC433DF
	for <cip-dev@archiver.kernel.org>; Thu, 20 Aug 2020 00:21:41 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D80AA207DA
	for <cip-dev@archiver.kernel.org>; Thu, 20 Aug 2020 00:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="lg4yPwTS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D80AA207DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5157+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id gjzDYY4521723xwfC2Eea8oS; Wed, 19 Aug 2020 17:21:40 -0700
X-Received: from APC01-HK2-obe.outbound.protection.outlook.com (APC01-HK2-obe.outbound.protection.outlook.com [40.107.130.102])
 by mx.groups.io with SMTP id smtpd.web10.101616.1597882897644268955
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Aug 2020 17:21:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e7jt6/V6YfKXvlrPK3D6T8X/lP4jsB7RNrvN/622dfzSVmG0tqseRQwpG14CWTWAnMq+VKXnRSOEkSH4uRSMrXz5TF77MrmM+pPJsM/KBG1eFn/G4cIt+BOrTYIQbJ+YL7nn+OrzcuU/q+4buNf/+ZgEGsD2C2TFHFan37O0C1SrOEwaBnupg+eqT9x9v45R9VbIW7YeXIFZuXV1bv5hkhKyFUt+QNxUp9sbNPKHrWFv1u0XiTrXMQc8dgMFub6dUtisrwa8Y6o+K//IOZnIYYDYtIEFyb51JIuN1kq1AtlW30Ap79rypttiWArmjwPjJQElD2bPo6mFxzfb+c55lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/UMntMndizE1ubE0Vw+b1GcGrb+S+dxYV5ds0i+KbmE=;
 b=obHygv/ij5B9/SwjrZHWiDGijsPkaxKFlXxEqpP9p520UtRQJECmSM8srNwF6CXFF8uqWAKl1TMnrBgZmEBuwO/LI+rKT4lV7dnVwzXfooIxZjTbRmrNYn0U0uMb3BE0IkPp5GzuwgLcTjquAIhnuXxBg8oxcVCfvfY6n/mZ77Yy3j2v1rp58CMqthU0q0tCvraSO6axvtXBg1dl9tdTIqxqBUMBPI5IrGGNP6OcFkFaw+cv4juhj9lK/SkWVXk3MeohINQdsEmOLIvJLfLlqyKviTeBcbmHrcNbFhPX9SB3P2cLdg+l3PUyWsJBcKwFm5b1qk+C4K+Wa1eXy/72Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TY2PR01MB4393.jpnprd01.prod.outlook.com (2603:1096:404:115::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Thu, 20 Aug
 2020 00:21:21 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::fdf6:bf77:e369:aa20]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::fdf6:bf77:e369:aa20%3]) with mapi id 15.20.3305.024; Thu, 20 Aug 2020
 00:21:21 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdZ2h9Q9VwaXCcQDTX2cv8hYQW6m9A==
Date: Thu, 20 Aug 2020 00:21:21 +0000
Message-ID: 
 <TY2PR01MB4972C863C35805A499377765A05A0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3a41d80c-77fd-4507-efb9-08d8449ef6f4
x-ms-traffictypediagnostic: TY2PR01MB4393:
x-microsoft-antispam-prvs: 
 <TY2PR01MB439305F85B9F86BFA7E43BEFA05A0@TY2PR01MB4393.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 YJwerFAIlOQvQ1ZBhL1Dm8uGUy/L4ez9wD8LKY4SJK74NRSl9mYm+1f8eyiC/RK7GD+s+T5a/Hoe9Pg7yLPraNXmfPqSYm+TtqLIwmLASZlPCbSwG8Qmnfjde8PMI3QghEGl+9lwGKHwthbSFszgiglZBJUVeNdp7JJD6cSnMbvo4yhFE5fcQbzZ8VoXnJtF4TIdHrbZHt7xEYi9sNSPWwCVOs/AjYDP9Ff8geoEZ8Ig0sVS2HAmJ1sau05jEctgrKbK+crdmiwCpz5NOgZD86QL9eLrsTjF8aGHDZEm7IPRPNEMvXf4apQ5/CugUkQc2YdKYG3aLessf9a+/GrnnHuuyzm/Si6zAcuUeyauOiR8RvIjqeLvwvPN+8loTGF5nVDXzEAQYe1ALKvpAhcsRw==
x-ms-exchange-antispam-messagedata: 
 uEtrchPQ2+GXB4A8HrPanliGXZySeTaGhVD/08cd8XVCiajCscwMpzfLj2munX1H9z3uLDbl78Dl/OhtDvAiFAU4LGlNaq/fr0RL6tAnEm1DyvI4UJNPyxMGi+46Qf9MJQVAwZLHDWj3zLdxscRhgWlgTmN9mc0PX3ZusqvfI2K6QJxW7Mo3XgFdgw/rfmKDJTOJTNg99SVG87PamLko7SBH99TA8NeoQ9fuB0pnvx4Hruw4N8WBKHWGesVm7k1VSSlC4iJBC86FnuF/UBEPOoFEMsy0VXf0b7Godmxsnz6vgZflCPFcBEHkMZ9NOoJhdI1yK0UbdpoIj7C9DRdxU0uH+cePkpBfxwsW7dSLdipvl3PoSreNcHbiigz9RVLEyf4W2q7Fwx93h8mYRMdWTpTnM8BPYJn6xZLT6q1EJtTR9YOMLWoSvvrKnSUXKjE5EQw6F/zOl2YWZE7eowObaqQ20V4N0imwlK/+02/iMJI5gHGfxOJz8QIg9KqE2/YhAi50HBwTQeV09tPyXkGnqIxYetNX4sJTG7SftOWowfX++SQ9rFgEdPOIi0056aiVsEy20FZ84jn5Br6NSKqz16MOLRHWOhZjh5GJSqQZUH0IiqEXEIIEE9J5GrGYB3FCsxpAoAhhMZYUYsjN4ekzEQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a41d80c-77fd-4507-efb9-08d8449ef6f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2020 00:21:21.0434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ekZLI+AAJQHzPWmpXWIgEtM+2jI6mW6gnJ1aZh6hzO/3g2i0wcylQBqibLZqH8YehPfuKMTZmb4tkS1V3Z2l9KBUFcEssmNrijHijdMG9Tg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4393
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 3qzetPFO1LiqwjWBZGkarPo0x4520388AA=
Content-Type: multipart/mixed; boundary="AWtHiPzZs1hxziFIMx7M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1597882900;
 bh=BsWj6bdGgvajMEiijKDpuliesn05UoiwLlEYSrOJn8s=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=lg4yPwTSFV/eiFE4cGYpPdg/ZWmHaIdUtRCc54bO/ppy1WUgScc/hfDVx5XL7zwiZAp
 92lSCQtZKknQgQ1rtzKv3Uwmr/EY26xBBkRM62r/wKBU2xjZRHGxI5j8xAKLQWviKxERW
 uXIP6QcYW+P8JeOdrO87GQ5a4mAq0kUQVhw=

--AWtHiPzZs1hxziFIMx7M
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2020&mont=
h=3D8&day=3D20&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&=
p5=3D241&p6=3D248

USWest	USEast	UK	DE	TW	JP
02:00	05:00	10:00	11:00	17:00	18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2020/08/cip.2020-08-06-09.00.log.=
html

Agenda:

* Action item
  1. Combine root filesystem with kselftest binary - iwamatsu=20
  2. Post LTP results to KernelCI - patersonc=20

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

--AWtHiPzZs1hxziFIMx7M
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5157): https://lists.cip-project.org/g/cip-dev/message=
/5157
Mute This Topic: https://lists.cip-project.org/mt/76298885/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--AWtHiPzZs1hxziFIMx7M--
