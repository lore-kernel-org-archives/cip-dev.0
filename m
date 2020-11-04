Return-Path: <SRS0=VrDW=EK=lists.cip-project.org=bounce+64572+5737+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9617C2D0A3
	for <cip-dev@archiver.kernel.org>; Wed,  4 Nov 2020 23:20:51 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABC7020786
	for <cip-dev@archiver.kernel.org>; Wed,  4 Nov 2020 23:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="d38C5nED"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABC7020786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5737+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id IuUjYY4521723xh3AQrFW2wR; Wed, 04 Nov 2020 15:20:49 -0800
X-Received: from APC01-SG2-obe.outbound.protection.outlook.com (APC01-SG2-obe.outbound.protection.outlook.com [40.107.131.110])
 by mx.groups.io with SMTP id smtpd.web11.141.1604532048139518089
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Nov 2020 15:20:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lm9rSpcvZLs56bB0ZDp5vMI1bQeKyljxENnL+zIguOzNpCOFiH2vkSOxMNLYYfCCO5zehVBF0F8lheDzdaWAE2W9/HkknWA6L66agfOQHymEvzZKsmPxxyiTN0hRaxQXxIVgMmj2qtaWGz9Pv+U4c9+xzdsftw7L65mVCFKaZoQjt1Q+GMg95Xu1uykAe7ODG7jS0N6BIV+N+XyGBnP8Y+g3lPnwG0i67WgNFFk/F5ZJvd1sk2nVl4sEF1k5KNBA9m5723u9uMBUUHAfJ4bPmP5EedfNSsgo65o0AmAWP2VbHdbIag8pN3EPa9CTIwPeNsLGJSpiN/PhP4/7PrOIkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4twpREmrisQCPAwH/w88ETBNtwoMm8juzGLX4eJODHE=;
 b=fRslpNZ8Ytp7R2tJpFu67VFgbzL7EfiBa9Q6sOaqGsvSkxeP+bk/QfK+jADNRi/D+ny1FLKD/aGRGHNl5Xx9tautOygV7LNP6xZir97inhE/chPqZUbimzC3u9n+3Y9rqgDfZAlo08+ffosM7QDYb+U5QMOMrbCJcEtb1z4a7w/ImrETwea5VHV/y91NVptwdWmbx9dxEVetQqvCry1qtgHa7/s6dadQpeGeFgilTlmqciP+nVHEVc9/nuAWrXkw37azfJ4wV3YesCqhW5OCHJvukEXg+VF6A3CeSZrqw4MK/pNw7s1GQojzcti6tkgbeouO1UY1pJqs/FWhnJ2t9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TY2PR01MB2698.jpnprd01.prod.outlook.com (2603:1096:404:6b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.24; Wed, 4 Nov
 2020 23:20:40 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::bc60:b903:db5a:4abe]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::bc60:b903:db5a:4abe%2]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 23:20:40 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdazAPaeIGqRDfO9Q9e6Vg/ZlNyhVQ==
Date: Wed, 4 Nov 2020 23:20:40 +0000
Message-ID: 
 <TY2PR01MB4972AB11B2F26872FFA47FD2A0EF0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 503e8c0d-df3c-4b8b-6b2d-08d881183eb5
x-ms-traffictypediagnostic: TY2PR01MB2698:
x-microsoft-antispam-prvs: 
 <TY2PR01MB2698D6F1841FEE2F6ADC03F8A0EF0@TY2PR01MB2698.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 fothSSgYCq9KCNGimRDTRkh/+Jm9TlG5uJh6XiJ4uX8IEAHaFtOR1Nzx24wgLfXMhwJ+3Zg915ja/T6+nMNXUcN3z7x4tNSzKLPIe+uU71k5hLYc0JK9+7jpOY8IgNrbf+GqVtNFf/xVkUBUKoZtDsu9EJYr6V1pSQuCV45nH7wGWV4MCr+/VdVyLKU1vjVPV2pTkwAbqycwGfi1qQzKH9wkeKoB1RG8MjdE0S8Ircq6QtPwZmb5QgLV8jfOQmoaC99CaJLBggJLQcxE5W7g24Mk3khGmwTOHBkSTcAJ9IHJKfLYjGecXMIg1LdFJdJ+4d7xuGSPLSmwd3q9W6uvSVSlfcDit1JMnNItqdOJ1AdgggUA7Jd2Xx+m7HcNgpR4cTmtQAaTIWU76cx0QosB1w==
x-ms-exchange-antispam-messagedata: 
 x/d+Q124gRfaCwNTqgBU3MXP6FgV5Y6DLj1C/xLn349wWqs7T6wXYnBPaJGEpxNxu/RwnknYqu/zMdP7IyY73zWx+tGxXTOioJFJ9dPomxpxGKU1r8Jiw/pr2TfdXtl1VssfbVxhsNBBQQzDsK4SSok9rJnc5wB+MWAHQ1PLUTsuMQl7iBT3dt36h9xaVerETKhdR5ToyuX/PPsrnr0fKD7De9vhWJHZeuMLGHnHUP4VcvIDijH2c4TwUNZhdU5o1IgChBnh85Th03Tkj9Eoq0UX9Y73NEnSrrqkPov6fZYrnG5XPC/ehku7Z6g/axF6ZeLOKxQak1JensSkqtaKmg7st8fSigFuzzJepDeZvrKXvn680pjB+01w8jPshOE5e2qncRFuyVSKKyCpeHtUDYhAJX1UrnSS4zR4JAGRsDw+E6OMJprNghCSLoVJ/8lBb3ER/GAmLRe9HzY5WY/M6B1i8F0e/MLZ1/mpkcVTiZvwuxRZ6EOuxw/hzgC/TYwxyrqIzz/uvR6KefFefCa8TT8xsQqd9TLlEbhKIZYuZpBwZgJQNhEcFoDkTf5mUK/frfAtCoumhbSTTyaLjKJPQF6PWSuKuD/1H/7L9STH0JTbO9Xy+doArsjvsyFldNe6jutofomoGeanODimfxl5zg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 503e8c0d-df3c-4b8b-6b2d-08d881183eb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2020 23:20:40.3440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S5YvHYSinsynLJ72EtYY4vE0gJ0aEH53bqZA0c4oZNK0NQcZVbwOVa66BhoLkzF0x6lcyHS/y0yDEtWuc+2Ns10TXIhW6ZDHg+sziELOKEA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2698
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: UJsYlHPXtClKCIuHd4S8RM8zx4520388AA=
Content-Type: multipart/mixed; boundary="AMmzHErAHYTirEEfgWpf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604532049;
 bh=g/r2rL/7A7liQ0IZeyDW+/+TaKcOgLTGXavRekAlEBg=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=d38C5nED3+kIltsV31hm8Cu2eurVvS50KXSRA2sapJWOGorIPyosFr2sM46pTwdxu5V
 dgXSPZv1vhJo7Z5qJvVTWujhrbLB9NTuctQa09vf4OOvvrosSrx3/Uk37OSkkZVZY8ZT3
 Ov5B6VIUDMIo5UckFoar7DXXb3SMFcJlHXg=

--AMmzHErAHYTirEEfgWpf
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2020&mont=
h=3D11&day=3D05&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37=
&p5=3D241&p6=3D248

USWest	USEast	UK	DE	TW	JP
02:00	05:00	10:00	11:00	17:00	18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2020/10/cip.2020-10-22-08.59.log.=
html

Agenda:

* Action item
  1. Combine root filesystem with kselftest binary - iwamatsu=20
  2. Check whether CVE-2019-0145, CVE-2019-0147, CVE-2019-0148 needs to be =
backported to 4.4 - Kernel Team

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

--AMmzHErAHYTirEEfgWpf
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5737): https://lists.cip-project.org/g/cip-dev/message=
/5737
Mute This Topic: https://lists.cip-project.org/mt/78041044/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--AMmzHErAHYTirEEfgWpf--
