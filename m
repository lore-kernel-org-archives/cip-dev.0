Return-Path: <SRS0=CaVU=CF=lists.cip-project.org=bounce+64572+5273+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3DFC433DF
	for <cip-dev@archiver.kernel.org>; Thu, 27 Aug 2020 00:59:05 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9A0A20825
	for <cip-dev@archiver.kernel.org>; Thu, 27 Aug 2020 00:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="gV5P3+SJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9A0A20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5273+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 55kAYY4521723xB4O6JvklNx; Wed, 26 Aug 2020 17:59:04 -0700
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.124])
 by mx.groups.io with SMTP id smtpd.web12.9018.1598489942288261171
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Aug 2020 17:59:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H8igy4C8BRmVadau6cfjWKukFdb24jn71vkp3GDGUFgMo+gK2ilINuGR7Vgcf8ZdAQbmgk+yIj3STuPQU0ANd7p7ddv0IrZahOWpGPiNgOC3w7GN7BVAw20cFtbwTsX5BNRt7rb2v3CMDPCTbZcsnhlfKP+oBe0zPa0JoGhT9kUTBiTJJZB4Fz6+ADCurisCB53V9uUVliMTWuwiyxRUh82uXU2yKoRhRHypSEksWEYxKQWaME3sNzQyQk5tgZH62Q6hVePBykkHo3D0NTSlpA/VHOtQ+hThGPpQSA13qxXxoKq4ymGXPNdk5LlO7aXPl1CMrzck23vVWlpSU4voVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDTtMoiDxpE5rlpc3FGn+9+8H3AK+3KFcQFdmudjwyo=;
 b=EtGS5T/BBlBBsD6HZDqVAW9ZZNv6LNNts77o8VYS0i+IwQ1NZQb8zhC4sb13rUR/R8bE1nqm5piGqfmEf//meWsXEXxkAOTIHFwQp3onqh54nsQ7oNC3w9kkhIN5kePLhJ8qWWN8ETwxHWXPzFjdfNA/BhHegmw5UxKP761NGu2JPn2dYa7CILWe24VvN5iwewoYfFH2Ih2SuxxhvnaWnkS1RDsYnGrc6efTotl7Z7voVJno3vrQmKMtDvPJhZFy/43h2g8GOZWWMEVr/QEkisT1eRjxgaWahJeyzMliqccj8RHQ6MgyhRYPiWB9m00/orXOe2YKPciQyeS74f0PgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TYAPR01MB4413.jpnprd01.prod.outlook.com (2603:1096:404:12f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Thu, 27 Aug
 2020 00:58:59 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::fdf6:bf77:e369:aa20]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::fdf6:bf77:e369:aa20%3]) with mapi id 15.20.3305.032; Thu, 27 Aug 2020
 00:58:58 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdZ8DTHOsyIx03xlQJKy1N+xqwWDuQ==
Date: Thu, 27 Aug 2020 00:58:58 +0000
Message-ID: 
 <TY2PR01MB4972E3A628C466B108A02A7CA0550@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [219.123.27.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5eef7015-2152-43cf-8a0c-08d84a24619e
x-ms-traffictypediagnostic: TYAPR01MB4413:
x-microsoft-antispam-prvs: 
 <TYAPR01MB44132F2A89ED805453591297A0550@TYAPR01MB4413.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 LZhmTG2BLOafr7PrvkAYw/uAdx5boJLXpurh5b80D0LI+05M7KZzceumPPjQCxHo3d98nszsFgjfg/gr+3u0vhqP3kwVoGRHYFij9p1uKTKpNgLQsziz78VvBczY2TiRz0a5XFX3h+9idELPOkuO1xUoqSIRL9AKi0fsEnnFTvu456x6iqbufWmf3ogvNHTXhY1ZZoH1ncKNXQyW7NqfGwSco14yPy5737EVAUdRm5WFh+7qbuYJrGX1DwikGWuM2O2lSKod5Rm3//boEHJ8Q9qYjzRZqjH9OCrKbgF9GAeD0JTPvH20oAtGVYVNmIMAvK/GJk6heuglHNFIWm9gMQlKmKNhPYsIHLgvFOsNqu4LZ4+1cqjyqTWN85VQejvHB2ZkKsspvjsEO7ue+1u8Hw==
x-ms-exchange-antispam-messagedata: 
 PDDCkLtBqHsZryq5zuI4bbSMakshCfNTfUiIZVG0gFvDb6gOrpp36xclyi77Y0NAYrnBefHUZN37KtWtI9hfwBSxzrYELcjoIuKRFSRwWmEukhcMqvLs1tvvaqxnJ+TdLkM2wGL3vMN8ItiRmFZnXwH3Frl85X5BMbISCQx10bOXcBFe8l/e0FNmIUTmGHdsJ9N4e2MzNWSaE2HnOqWTxozEcX0v/Csl6nKYHr29vb21EBKDKoer3efF8FeKxbRDbEiKtg+Yjimdh7GKY/kUQ0BCIvGlxlZrM8Kf8mnujxVJ3MXg/8KtWdUGeI4lx7G1vTTg6S+bvVKjy26dK8bZvNL5qbwB6c0eRZkZpRLaPm06Q+PUZpAt2wj68EBdo42gb0HXns//wmJh3Z4TiLW7GZaCjCNH8waouYGInbp4fzJ8ZldVv56e4as7g0BS67NAyRnY6SKSvi5/WeA2dX2/YlKyNOqksaHBLKzLjVuZjjU9NpXkbAAO7RHBp7q+0bVgod5R7W7qevZKyRZifHisSpIec3wq6OYy2H0beWc5Nn5T0l3qxqp1Sn8nqYYHr8KuPDB1Qf8Tf8HexBVH0YHTGJCuaw5UtxUy5GE+G+OB9NTe+LSYTkGnnka1+f0Qjj+81XtnVdvdVPCq0G4KUYTDZA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eef7015-2152-43cf-8a0c-08d84a24619e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2020 00:58:58.9603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t01XbpEwKDbxuP+ZI9yaKnB5H930SDGuwt34mV9MFvZ4JKmPEYJ4XBh+x2wXGirR2YvBiQGEEFtp+dV6KaujRwW8ibqVJ+yPEDmPOcMqFC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4413
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: yAa9ZSCVzExtBTyGco5IQfqjx4520388AA=
Content-Type: multipart/mixed; boundary="qpgWlHRYluNjY8rk9mC0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598489944;
 bh=HqjsAzFgvQuvhHKuNXd2Ov8Io6EaODHDQrRlofNZJjw=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=gV5P3+SJNa6wYq+TJbNdBJ9QUruaTSSsuoNcfioclHqQz+vNuGB5483l82OZSpmMaUv
 xELVoS7kgM3aNRJokq5ZNJ9AZHwCKeAjVeqrcaS9UMu6qwLPrPPegNjqcnonQlFZ6jdjh
 f/wgOgksUrPOiEzIiBZEGxqPOcXPuLMTd1g=

--qpgWlHRYluNjY8rk9mC0
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2020&mont=
h=3D8&day=3D27&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&=
p5=3D241&p6=3D248

USWest	USEast	UK	DE	TW	JP
02:00	05:00	10:00	11:00	17:00	18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2020/08/cip.2020-08-20-09.00.log.=
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


--qpgWlHRYluNjY8rk9mC0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5273): https://lists.cip-project.org/g/cip-dev/message=
/5273
Mute This Topic: https://lists.cip-project.org/mt/76442001/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--qpgWlHRYluNjY8rk9mC0--
