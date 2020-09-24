Return-Path: <SRS0=yoa3=DB=lists.cip-project.org=bounce+64572+5468+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0717FC4363D
	for <cip-dev@archiver.kernel.org>; Thu, 24 Sep 2020 00:58:57 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12BC823119
	for <cip-dev@archiver.kernel.org>; Thu, 24 Sep 2020 00:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="miNFErPb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12BC823119
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5468+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id txfHYY4521723xPcsg1dlqaa; Wed, 23 Sep 2020 17:58:55 -0700
X-Received: from APC01-HK2-obe.outbound.protection.outlook.com (APC01-HK2-obe.outbound.protection.outlook.com [40.107.130.101])
 by mx.groups.io with SMTP id smtpd.web10.5730.1600909133294324569
 for <cip-dev@lists.cip-project.org>;
 Wed, 23 Sep 2020 17:58:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Go9lDCHR9QG97l1sPXdIY1SMO/ADc6c4CtVaW0ZIG/UaYOOP7LSZz3V3GViFa38M1E5OWG29DHsfYFo3g6BLFrwj6KuzG6+EzglAqlnXXFP8WL3dl6Squ9B7FLHoVNE97tuJaWzmSax9qj1r3rikNk85cB1109kHKom0CwJYyfi4GuJBxxFB+5UCs4WPpZSARAaBcnFCbIV+5v/KW9lfHfwykfNrWeh5QeL/EXp2fJznft/h7YvJ9IVDwQI5bWfBQi2T+Cvi4rWnYakCTOM7/sTTSgRL3uL9jNh9aaKw79++rAZc5gyxRZKKB2RngoFu6TP9etulN5SWcqNiT4/Rhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/88QBGBdlEC9wD3QXkbcXOwc1N5M1ggd1DLlKtTUImM=;
 b=W8Oyxfo+tqSc6wYmqee5BIfBfhTN9HneUuVUQrExgJqrmKrRmAT/AF/zjWoif8R886qz0aBmRflZyLyCYWhHI22y1FfXcP1WNQ5+fACLq/ZjeWFsgvmvB4btrn+cjL8IEWjQ37ojXD0e2ewGGHq3AK5Mf+ohGH8SGkVDf1IwPmZqOXQe4wF6QPDAAtYNO+/HLBQSluLZJE5QGoxp3rgOZAX2pLmhaA0jOH3NsGJD7jOtD43IzAtBphMu1517GdRjcYA2fsWGa7ytDgvFkyLZUqpoC5qc4VlgY7mmkplwHsERToUsrC+HEeutojn7GiLtC3q8+kM92ghDY9jdwF/zmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TY2PR01MB4603.jpnprd01.prod.outlook.com (2603:1096:404:10f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Thu, 24 Sep
 2020 00:58:50 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::141:efe3:1485:80fa]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::141:efe3:1485:80fa%7]) with mapi id 15.20.3391.027; Thu, 24 Sep 2020
 00:58:49 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdaSDc5NDwr+9dkBQiyt3ZfZmv1ZpA==
Date: Thu, 24 Sep 2020 00:58:49 +0000
Message-ID: 
 <TY2PR01MB4972CF1EA6B8B5A991132052A0390@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bdd48487-efef-4b59-1cdf-08d86024ffcf
x-ms-traffictypediagnostic: TY2PR01MB4603:
x-microsoft-antispam-prvs: 
 <TY2PR01MB4603259931B0385A932F9217A0390@TY2PR01MB4603.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 YStsL0jIDa5QqSpy7I/RpMIcGQRyO2xQ7ikZwEGgQ76sxpseWIv/oCvQFVrU6bBSCBv4hdHFSs8XtxRartmHHi/S+cc0evlpEiTYccFtsaOBLLFGlaSIXUvkt8pRWPp4obzTAQS8YjPJ+q40Dn5DTgh3JYfVHs1ghQ5i8yZKapa9FZZWcMt1Y9xn24F8VOFq+xHvwq0UQLXg9XqANcvToClQ/2FjmngEgDSVnd0E/6fyPGmNp5SrjPdSFLso39EaFx4Oc6BeTBZXhyRe3YSsV58jhTsEi/U3Xj/to+FwrwEbDx1xcmyvk7yeIw8XNHrJdXHm2ijZq0yVToXlzWZigNi1bPAzzSU+RRtVXc3uB7AioRBTIGU9bX5EWQKYrmlIiNakgjG+XjqwMAruvuixfg==
x-ms-exchange-antispam-messagedata: 
 yZZTuzsc0kH2abbwSgTThNRXgSJc1Z1xv02fdTe3VCmJTOc9neQL6t/c9mMZHu+YdaggeRuYp9+lE2cioliNd/bKbxy1RjPL9TW/llccykNsVUb+i/9XKcnAFlyUpkDb55A7mqFtkXpy97MDPODG+NlcyjmSsNZNBYKDYCG2hjryVGmGDW1xSw8Wb4oZtQwv9zPk0OIanwdeot4bFJn7WAZf8tpB4lZ8UiRCET3TEx3DR8sc6oEJUAmet8nVPuscyHELntBlpohNSqwpJOSQ7t39ekQrw+hvpsJnQO4uo/mw1JQbP3JsRkdNyb0U32/AofG6v81mSSZdspROxnIyRkAI8SRDV6RQ5gfR4aMPmmUShmH/g+jOfxI0dVjjEPwyY9nO4a0+aielD1YNFFdHzLY5p1cFl0aFfm9C9YM3jnGOy5gSqu10CU2ECp1DYFSr/D/cdgD7IU/tPcjIuugkQ3KhDUJLXCa4yc2AjzDBeLCVdRW9aImv46nr/G1qf58bEfitLYkzZC2cBQwWbTr1GLiUqe0TVwwyuObVm3py0a7qa8Crz04ro54L8Djp32IF7xkLBcZNyB01mt6W7y6606wzDwkAhm3RukFDI4KF2HNwsr0l6ccr/rBAJftIfhVYzMH5+JmgQDTFjGbq0ym6AQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdd48487-efef-4b59-1cdf-08d86024ffcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2020 00:58:49.8978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5fOGcqrwQWyPq910IYMOmf4HSpUGGwLJhmUhfJfKE2hFXl5mfpnqLREa0mbw7jzh7bnFPxXuiHKzfWCyW19VQ/EP1GMaW0V12Q4D82ZlEEc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4603
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: T0ijFqr8oSLhC0Y6iiZ8GJPgx4520388AA=
Content-Type: multipart/mixed; boundary="idPGIhmfEiJNXsXjQ3FO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1600909135;
 bh=Rj84yA76mWu/U155InJqiCWGNEIGbxxEAGdOfmmdo48=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=miNFErPb8ZCEs51p89TQy9PglezfU+5IhBL5yCZ0I0vwaE6joYy52EQBSFKcXTVaOaU
 kx3D15dpRs88mps/z+e5Y6xZVgypfcu6p0l7gnPC6pfM8szVxZ3vuyeAhlRIosQK2GGTk
 vWzZTuNCcWeMHOYdN1YbKlv80HjiOjbQxOw=

--idPGIhmfEiJNXsXjQ3FO
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2020&mont=
h=3D9&day=3D24&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&=
p5=3D241&p6=3D248

USWest	USEast	UK	DE	TW	JP
02:00	05:00	10:00	11:00	17:00	18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2020/09/cip.2020-09-17-09.00.log.=
html

Agenda:

* Action item
  1. Combine root filesystem with kselftest binary - iwamatsu=20
  2. Check whether CVE-2020-25284 needs to be backported to 4.4-rt - masash=
i910=20

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


--idPGIhmfEiJNXsXjQ3FO
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5468): https://lists.cip-project.org/g/cip-dev/message=
/5468
Mute This Topic: https://lists.cip-project.org/mt/77048514/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--idPGIhmfEiJNXsXjQ3FO--
