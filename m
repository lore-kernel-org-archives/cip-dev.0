Return-Path: <SRS0=r9of=DI=lists.cip-project.org=bounce+64572+5485+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61B1C4741F
	for <cip-dev@archiver.kernel.org>; Thu,  1 Oct 2020 00:27:28 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36E7D21D80
	for <cip-dev@archiver.kernel.org>; Thu,  1 Oct 2020 00:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="aqkhH1J6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36E7D21D80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5485+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 18DeYY4521723xwQHyrLBKkJ; Wed, 30 Sep 2020 17:27:27 -0700
X-Received: from APC01-HK2-obe.outbound.protection.outlook.com (APC01-HK2-obe.outbound.protection.outlook.com [40.107.130.114])
 by mx.groups.io with SMTP id smtpd.web10.1320.1601512045108246907
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Sep 2020 17:27:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H3NHWZWRyTqohI0+x9qG3/lkItN9A1MQHRrM2lr5gho7nST1pzgrJ2JGVCIH/IrHlf3llG4R5XmwdKLhGXO14+S6c1aQNnfR2/eHtApkPEHEbHEjvQz5dY4pp1ui7/EjMMI8zxJTqvDgseagG6WYHXkN+EQp7cDx433zj1pwM713TX2cjeuCS4JcAC+V22dkQUpTEpMYiBC9JZpYHQF/fHT92XQtxXOjAEFWYpKJajWQGxLQ6IbAQdOH8590kmlo63HiN98o4twqWF5SceHnjLIKAWDPl4sYKq3ecyBGBsxNc2ldQBoi9G8oLkFk3Fw79jvJXdXA/dcg+XUWXmtlLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOGgXzybeH0jECVI5x/ReKrFzTMcSNRBSIjMMaTewGk=;
 b=LVCDwV22ADRjn/Lf9n+EJ1mwW+i8KRYxlgn2zgFC9X3vVsZDTL/wPD/iyUSQz2zurqEBs9lg2xbWeC6P8pWMXJeX/dRyo037Z3eeSVIFQ94ZBKQJnK5EtuYtUXjTA/bn3RnREX5p4UkQxIozdDMIGbD5SceuU2fbisPzlCwmHkUynIdw1Wp6SJUQIt5FqNWXmk9yCtmDC5e3bfkZSVN1Dz3FqL2OYRHqg+/SAVO7plWwlZf4uBliMuo6rGrY3lPKZ9p2uuy7asVVubpVZJW2p7nBDhD5jl4mSoigK5WEDgQaUz850imqHnzX8qgAZPRCqmvNQAwZlAqU7Kq7Gg+C4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TY2PR01MB3786.jpnprd01.prod.outlook.com (2603:1096:404:de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34; Thu, 1 Oct
 2020 00:27:22 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::141:efe3:1485:80fa]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::141:efe3:1485:80fa%7]) with mapi id 15.20.3433.034; Thu, 1 Oct 2020
 00:27:22 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdaXiZ+Ncf8e9QV9SjqAlwe7oZ9AYA==
Date: Thu, 1 Oct 2020 00:27:21 +0000
Message-ID: 
 <TY2PR01MB49725DFFB3B4CD4E0A1777E0A0300@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f4239cd1-3136-4b37-749a-08d865a0c36a
x-ms-traffictypediagnostic: TY2PR01MB3786:
x-microsoft-antispam-prvs: 
 <TY2PR01MB3786C90E88278CBEA28A9453A0300@TY2PR01MB3786.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 +uJLIWV1IfLFwd5OcIYWk29dwmqeK7UwITYhRAPm8p2a9JedmuJLqARQo1gKwwmC2C8ehOdZuLsa4EeXykvphBzQ3W6YCHjg7vbpZGMwgSRCskz8uQm9a0f+XPpadIyuLK4NOoy7zjUZ3KsIMqfB/dh44g4hg4vrBTtbMPuc+N1a3LHf/M7S0/E6pEGuaqnW2mvEbUBlRdt/RxRiyhU1t+SbVhwqjU7wrvZV8ya4DZg9hoZFyB6GBKeYq3Oxp3hmGF2QbTEggSFKycgfGKpXKR8fDE/zt6THpIHHkzH5CgCCjucyrsN9FKzPba8NGc9MWRUL4vEkQtkRhtFZHnIjwXrUyeJ0JB+tOR++YycPkR+Vv5mL97TnYAYpvR8zUYFoZaDFmcOp9OG4tnl9jUQHmQ==
x-ms-exchange-antispam-messagedata: 
 qr6QC1p7bKU6zE5ZAn2e/95RagCy8F7spBSv/B4iLM0CPXUgm0HhpTsxHZDr23qnxkX066knVV120KgxSM8DBIh+AHQKKBRXXyD/S5yRJzWLbrgwVVKtl3EkBego4T4vqPwfoNzXDD5SXHMqf5rw8PYSobUgrsJDp3w1ohqn+AQ9W3pPBDWKLjaxGjD0l6Q2HKHbb4Z42JWjr7XvG4h2toc14oQYscQUP7i1O9jh7q3qPjTfy5vNyJsdC56woJ6HR31fugRn0VEP6ddOXX0Pt85FLyqNq1jVjCwidmzWUSTkYzVQqU3Oe0LF5Ef9QwfeSOA39LWztUK8Y8xHdV2IeFkeT5nDHwSCYkNkZO9dUm7zk1fHcWkaRORFNwVVLMF4eO/AyOLbvqx3MgcgCCO5Rr7wJYdd8frFsm7AkXAdXTW9+EHQqHS9SUbR/heWHF2bcYGWEpuu0A3TWq8LU/i4TMySjrqGVxy+hQFUlmV2Ou3Jnx63htP9NNhyyX0NeWkixvPHneR+VYGTvplIrJdg2UiOhXez44RuUVaRKOac+5YnoG1hJTsJl4nv1EgPGOH8bVED9f+ryuSx8WZP4vtRoTw6XCJGjIBzWy9/3ATqfXRdnxD4d3oaArlB2gAyRIjqy/GjMCvlXNce8GsB0LZEjw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4239cd1-3136-4b37-749a-08d865a0c36a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2020 00:27:21.9252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ssb0fqN+Wr7IgjPqclNnTw2DZHOqTzxJcygU11nk/iIIRWiLe5hHrjaGZA7o1+LX5jjDeMfGJ0VE02MjAwVuI6ZNW2E4if9r5ecQ+xXov8o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3786
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: PCh93lkKilNiB89dzi5ttXF0x4520388AA=
Content-Type: multipart/mixed; boundary="hvitVw67bEgiPHb8l8ev"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1601512047;
 bh=a46gvEiNCl38y2O/Tf3nOPPLdK6TPOqElxBUva9JQM0=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=aqkhH1J6P+I0QsMzqF6Gxi9ZIqmLoGJyOWr3dC1GUB7TxZ0HNAnrn1hY6qec+l6makP
 //Y6EHMzhvAtTvtuu47whqr27Hqel1bhaTxYcPFow8GT11boBnfgLbIHNn3lxuTGkqG8/
 ZAeGn9YiPXuIJv6lagA4otTFTKEpDrY18QE=

--hvitVw67bEgiPHb8l8ev
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2020&mont=
h=3D10&day=3D1&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&=
p5=3D241&p6=3D248

USWest	USEast	UK	DE	TW	JP
02:00	05:00	10:00	11:00	17:00	18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2020/09/cip.2020-09-24-09.00.log.=
html

Agenda:

* Action item
  1. Combine root filesystem with kselftest binary - iwamatsu=20
  2. Check whether CVE-2020-25284 needs to be backported to 4.4-rt
      ->  Delete rbd ( Ceph block device ) from 4.4-rt x86 config - iwamats=
u=20

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

--hvitVw67bEgiPHb8l8ev
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5485): https://lists.cip-project.org/g/cip-dev/message=
/5485
Mute This Topic: https://lists.cip-project.org/mt/77230659/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--hvitVw67bEgiPHb8l8ev--
