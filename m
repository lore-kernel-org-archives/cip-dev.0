Return-Path: <SRS0=jA0H=5Y=lists.cip-project.org=bounce+64572+4568+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E976EC2BA2B
	for <cip-dev@archiver.kernel.org>; Wed,  8 Apr 2020 23:24:14 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 783732087E
	for <cip-dev@archiver.kernel.org>; Wed,  8 Apr 2020 23:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="O6Aydh3H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 783732087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4568+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id I2vyYY4521723xkGuB6ONMBO; Wed, 08 Apr 2020 16:24:14 -0700
X-Received: from APC01-PU1-obe.outbound.protection.outlook.com (APC01-PU1-obe.outbound.protection.outlook.com [40.107.132.133])
 by mx.groups.io with SMTP id smtpd.web11.1562.1586388252538934532
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Apr 2020 16:24:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AT4D39eywYMB6ksgQMcjDtFpjtERa3ffoOrQGheWbW1bQX5Mon9nUmA/DNkqS3xGVscQ9leDtYyLap0qa9UrWSYl8mXobcX8dFSGPG+UZEuDJ2bhpc0L3njoJI7KCE4SP4Avu6+a5OPdBUcCZFyRp/XQrSv/2S6B3+Ajy15GlB/cwGfwcHKTu4b6YK/0u1+wR+L6vPC1gNQqKYDyYOjiOn3sI6m+MMXjeoy39oFnTJC6xGn1LJFfkdvFlIePng91rJbdisdyt3h0DfiAtiGdkv72Yzmr/tF4jdFBdapc9YoKnhr0e020zTBK+ZdLxO1+VnR/9ppVbRzNGVRAQSdXng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P8T0ADgUFDBeusCTr8nfLwPqzhIBsXKMB8NJCOsku/o=;
 b=G9DycctjoK/huTP9vVPy9PSSi0ZuMeTHFllISyAhyuA43bhfQhLF+KN0KOVTBkYfOGl7O7EzqPXifgqfvKqoQbiWxLUSvElCvu5K3FTl3SlgIrNyw3/Mcyt0wWC1H6n9TwocH3mGdvIh93Djd/t4BncMlA4GMoqBfy09kn0ubYHFxyk1lnMFaCZp+Xo8X0raEtf+2gGvyYf9YUxO86271wlD53bSVBe0wJ7LGu22/FMumqHHNEhPt1klBH4Z0Yb58daxPzAjyK75O3MslGMAj17LeQXCKkKvZdaIJZC+zaJMhhy1C10lHhlfVgQZm/x9OsjZeVuPz2Gt8lTCPMQzzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (20.179.172.148) by
 TY2PR01MB3692.jpnprd01.prod.outlook.com (20.178.142.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.15; Wed, 8 Apr 2020 23:24:07 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::e845:c7d4:4f:c3cc]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::e845:c7d4:4f:c3cc%7]) with mapi id 15.20.2878.023; Wed, 8 Apr 2020
 23:24:07 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdYN/LPnEOA8oZrPT6yhRsAobarbfg==
Date: Wed, 8 Apr 2020 23:24:07 +0000
Message-ID: 
 <TY2PR01MB4972F65EEBA6627C5D5AF693A0C00@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3995ecfb-61bc-4ea9-07e0-08d7dc13ef45
x-ms-traffictypediagnostic: TY2PR01MB3692:
x-microsoft-antispam-prvs: 
 <TY2PR01MB36929BE6E152955BA9B3578FA0C00@TY2PR01MB3692.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
received-spf: None (protection.outlook.com: cybertrust.co.jp does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 //4GPbdtaPBNXy1C1wlY+sCRTWhzClI6/qJVqAnh0Ti/eB4R99fD1A2MD50Pqdrc/5S7mP2QFrzqjpIq9NCTieqn959QluCyT2CWbQRP0Vjx+vkIe5rRLT2QzKaU3GN8wwFITBgVxW5SR7fA7txY2AfoxWU4QYGgrWONz4goe12edU5gE0IMYq3nLfwF03/s85Z6H/0+IxfOPg9aRVHMQC84+ymllpGwanH3Ip/vUxtKVWVa5i1d/eevc3B+eVTmqlGDqRKMH9W14S6m9Y1O+IuL8xvM5nk6uWUht35KTwb+Xi4bP1/6EmIg3rYz754O2t73AU30z0Lq/oYq7CVgMsjKtPpr38Ml23tm2Ey+g8tdga64QWnfrYVfOTgYZuDb9AdWEU5rIjdpfqVTfOmPoy1hwvk5yFZlfWJhC0yWTZXLrMQvvUpCsxeebIwJByN/0x3VHUkc95wsxFlsM4Ky8s+FpctlbyyKpugi1mZKL/N8T2KM3yoaC8EI7MJwEJFeF+gEPrD74UbtafsDzPvfJA==
x-ms-exchange-antispam-messagedata: 
 umCVAXzS73NwpABCUjr9J/e+tXFJDhJgmMQMR+kIsg0pOLA6KM50kySphT6/U10vVJ4b6ineXaYvetUNNlmFlvdLFl3FePq4N6b9tfTzuyOJ0wmn5nA+XZIyv+zec+RrhnjnGkw92/32SzWB6+Lblg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 3995ecfb-61bc-4ea9-07e0-08d7dc13ef45
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2020 23:24:07.1713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aR5V6sCsuapKd7Bl6R8hh1XhxJwrlXYNDeBPRzN+dSYWRArqyXUi9ZcHH11Eua3UkEoHvbitrW/44BoPslBhpqv7MW52+zLklzJ1JeiWJWw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3692
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: cyaZPOPZ9mTjyLwNHWA5Rnqnx4520388AA=
Content-Type: multipart/mixed; boundary="l5K8fAD3S8JfrkiqWZHv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1586388254;
 bh=FMYByAZEnen6haFSNPZ+UBdnnQL76mt4NsxhvuuvkwA=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=O6Aydh3HKzhuK5qUYBzObym0bFyzAQQ7GtqdxFSiNNmv7TrDOuUg5cDajQKoTBJrXFR
 mGmW5nw+HN2MXUxdxryuqZQgIOKHAk2SoSr8kV2e9t5Wbg0XSCrQqXXUe/uxN39Xf5Mfj
 RDz1PfUPBnqVwZjv9YF8koaZybS43F/wyD0=

--l5K8fAD3S8JfrkiqWZHv
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2020&mont=
h=3D4&day=3D9&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&p=
5=3D241&p6=3D248

USWest	USEast	UK	DE	TW	JP
02:00	05:00	10:00	11:00	17:00	18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2020/04/cip.2020-04-02-09.00.log.=
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

--l5K8fAD3S8JfrkiqWZHv
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4568): https://lists.cip-project.org/g/cip-dev/message=
/4568
Mute This Topic: https://lists.cip-project.org/mt/72886394/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--l5K8fAD3S8JfrkiqWZHv--
