Return-Path: <SRS0=tKdf=7Y=lists.cip-project.org=bounce+64572+4795+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B2FC433DF
	for <cip-dev@archiver.kernel.org>; Thu, 11 Jun 2020 11:47:55 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84F2C2072F
	for <cip-dev@archiver.kernel.org>; Thu, 11 Jun 2020 11:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="aLQ8n/OM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84F2C2072F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4795+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id IvuSYY4521723xjI4cO2xYXt; Thu, 11 Jun 2020 04:47:55 -0700
X-Received: from APC01-PU1-obe.outbound.protection.outlook.com (APC01-PU1-obe.outbound.protection.outlook.com [40.107.132.105])
 by mx.groups.io with SMTP id smtpd.web10.5566.1591876073260833484
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Jun 2020 04:47:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fIsp85+JEoSCrofVu3FZquJEZ80JStaAe12yD2opSndRqofLDaUpsk8ACW7BOm8/dLhz2rxrd0gu1cRRrvsidtX7VJUembYj0cmkcrpgdIXdutgYIbBWs360/buhZAAUBOb3C63hGw/GA39nZOsOncRcPB/w1A+XYxPEemVwiA3lmJJwjx7WXYJZHgunOCPazcZyXNr3Rc1BiRIqxo9ym3bpqlySetjHQIVGB7Dg0hi4ascLf1jEMZUCmniZO6rV/IeiGkHHHOe2nKjjknG+tF6OHY+GFzZofhQNblif9GRUrRo3Tvp83ZwHwXRx44kNIe4i2PBrDk2Ss4F8IABI0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rD+EMBowwZULgFQ4boo0J8fpBialT5ksoN5TiYiKcdo=;
 b=Z2ItEDciot1CdJ8q8uTUVxny2btBt6EuDF9+GRbAteCwNkO3M5bfi0w0r5Q051tSs2d9v/+rEpXorzuvLjFuGx5qxsNirPb3qAk+O1OOlCSeFZhLG46Z37APz6lS5Xo4ULJcGTnbl6ziGNl1xr4AIq126SPjM43R767G+U+pHGIdn/tvAe10qnti4rAEt85gU7SsHD/ftpdgiBLNedc5iXHe3lXDoeCtW8SOTR3e53DXy4i9bsJXT0Czeu+ktar6dvhHyOiQMWDSd9aOFLXB6XNUPLqDAzf67Gl0mJnACGbRqWViLKQvovVekd6vChWQL+0fno5+pW8j0Z6EoRjY3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TY2PR01MB3916.jpnprd01.prod.outlook.com (2603:1096:404:e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21; Thu, 11 Jun
 2020 11:47:36 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::d9d9:60fe:a138:6752]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::d9d9:60fe:a138:6752%4]) with mapi id 15.20.3066.023; Thu, 11 Jun 2020
 11:47:36 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: [cip-dev] CIP IRC weekly meeting today
Thread-Index: AdY/gpn435E1FFPtRxC0bLACZq1qzwAYDKEAAADKufA=
Date: Thu, 11 Jun 2020 11:47:36 +0000
Message-ID: 
 <TY2PR01MB4972DB8AF1C9D6553AA10358A0800@TY2PR01MB4972.jpnprd01.prod.outlook.com>
References: 
 <TY2PR01MB49724F8BC9AB8EF4DBB23A7DA0830@TY2PR01MB4972.jpnprd01.prod.outlook.com>
 <20200611112358.GA1148998@pollux.denx.de>
In-Reply-To: <20200611112358.GA1148998@pollux.denx.de>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 35d4097c-1c27-4f03-2504-08d80dfd3cb6
x-ms-traffictypediagnostic: TY2PR01MB3916:
x-microsoft-antispam-prvs: 
 <TY2PR01MB391608B88D1BDFD055F7668CA0800@TY2PR01MB3916.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 vY3nYu2rBFIoOp4Vv6XPi3IUTC08geJSUgzGPp1ft3TaAok3kY8hrIGJCdILXzDJ23zZqTtLupOaqSyYdYrjkCQmDSPw+vHowragoEeViJJEPwZMlI6h6cDsCxRbLQY/UU4rqsYOviaSU0cVYQ7Fjo0NrAYlcXC2C1/N62P1/ZL6QnbrRuWAVRi5avHmAyTpLJRxfLf0Rgq+19r8mXXaNhpSjXUUmbzwXoNKTC99fNqh4FN2me7PxuAcBe6zcOLR+LE53ywLMSpFKB8mrBdqgkHMc9MauVB0nSjSzMl6jvLwrM+C/MpoCHB+abh/hcZ7IBYUFlT7hNeSpUj3Fve6rE0Wmf7Jw/UpHplj5Ev/7uGvWSF9Z0ZRAIeBDNWNoRNC/+eW8QVaZq63Wj2tBb/g7A==
x-ms-exchange-antispam-messagedata: 
 T2RfKot49TsgDJBFgeJ04s+Hs/05ZhkzkeG6vQYyHDUaPdyshO8jlOGioHMf6N+sjcr31kLGyzndEBQPWTbhcpa8PMQawitnZcNblnTiY5B17JGNjhYYep8pwNneuPdzMpfWEaHO6nClP0lW8ZywXLW8UmBGJr3rCccc7tZtoGyn1yjxPiDZZXrMC9xkbRifZeblCdPAp+WTINy6r6PsIkbksqDPwCVdE24c6jz9Jp92iprc4/Heae640gJpYfvgkZL5Z2TZUV0rxDMIXelhe1keajUO/jMsFIf4T7S/Lgkafbd58AfIAvJFsU3fV7WFxxTuqDAuYRrmTYPB45oPqUk/dRCA16rypIQ1AfQAOdKdhtaVkXQKcz78X/Kz0C6Ne3Zow8kYEM2r/CCzFFtSC2UFh25UdXRTMoUmpJRPaKgUTAo33uRudomtbo8MyuEx0GVprtFi+lT98UmarumZDI+B+BCbAeBpMtHvwOpTkP338nQohSZquooo3/+Ns25f
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 35d4097c-1c27-4f03-2504-08d80dfd3cb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2020 11:47:36.8272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jdPwSZq/Dhsl0cyU1V7LufwZf9tJicUnopA7d1R2XoMHyWXaJ66i0IR7ez0R/yC5ASmDh09epaHxdLjkpgZUY4JctSdtu8HfcM7D8n03pZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3916
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: CA3oNfzs5b6NZhmUxRAylMWHx4520388AA=
Content-Type: multipart/mixed; boundary="bGcM3wqkWUMFRCF0ytk5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591876075;
 bh=QqIiVq7yUi7TzR041G56Lel05AN6BUMYQ6iTLMVgrsE=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=aLQ8n/OMzhaJWPgM825d140c6xPP+6z2VrddHr+6iH1t88Eet9kfR0i0OqOeEqT9mLc
 T8PmNkDhfL0cmQYdAID9GMDRW066D9PrU+vs7IbiLnLrUtlhGU4oN3XDMIlK73ZYw6VH7
 kmC95PcJEybVPaLq0edxpGWGYfhgeb4ECXg=

--bGcM3wqkWUMFRCF0ytk5
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi, Pavel-san,

> I'll go	through	the IRC	logs.

The log is the following.
https://irclogs.baserock.org/meetings/cip/2020/06/cip.2020-06-11-09.00.log.=
html

Best regards,
--
M. Kudo

-----Original Message-----
From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Beha=
lf Of Pavel Machek
Sent: Thursday, June 11, 2020 8:24 PM
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] CIP IRC weekly meeting today

Hi!


> Kindly be reminded to attend the weekly meeting through IRC to discuss te=
chnical topics with CIP kernel today.
>=20

I'm sorry I missed the meeting. I'll go	through	the IRC	logs.

My activity last week: reviews on 4.19.127 and patches queued for 4.19.128.

Best regards,
     								Pavel


--bGcM3wqkWUMFRCF0ytk5
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4795): https://lists.cip-project.org/g/cip-dev/message=
/4795
Mute This Topic: https://lists.cip-project.org/mt/74808947/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--bGcM3wqkWUMFRCF0ytk5--
