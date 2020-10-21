Return-Path: <SRS0=u/Lv=D4=lists.cip-project.org=bounce+64572+5638+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EBFAC4363A
	for <cip-dev@archiver.kernel.org>; Wed, 21 Oct 2020 23:50:46 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BE9F2417D
	for <cip-dev@archiver.kernel.org>; Wed, 21 Oct 2020 23:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="o+gs8lpD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BE9F2417D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5638+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id XHEEYY4521723xDqrqFpRV0u; Wed, 21 Oct 2020 16:50:44 -0700
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.125])
 by mx.groups.io with SMTP id smtpd.web12.2628.1603324242494578915
 for <cip-dev@lists.cip-project.org>;
 Wed, 21 Oct 2020 16:50:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fuG+okWke+9bc2osLesooFRKIFVGqsyX+tACtBHRul/+e8bTHOjqddBX2HkcptZBqmUAjI65WjBakRpCslxicjQoIKJSf9ySwEQVwtUo60zwhNi0BQvRgQN0cPE4uS3D8QQu2acTDZuLmJZsyUMI0ni0RjESj2pNL6zFFi1uUUsRI/lmatuda8RmlZ701KO/EsVweiDf4C0SmMTdIdMlODINvpUq7iwDaj9+h/YU+NWtkNzPqxOCLhPm+ZLvXx41Ql3EJcMJ3r6IpKghfTa7hgrwkxzUAxd7q2XkR74vNAo5l06pojfYO0z+hFBsyeINbE7rhn/baIHk6PfdlOn0ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/dWjpLmeCOAz3IBck6SCJ3zALF+IktV2g4IyHWhY+c=;
 b=RS0No7lElYAy79VLjRVBoMxBORyEsU42nEI+hrPjUrR/Pc3UfHYDXUtEUQTJfv99AIeEgT4QH/zKH2y58RqabLkaTWs+wM89ck9cpUn071dCr2EdYbCFoVvmFO1mmYHDdV6/tzyfMYtF4m+bBHePlp55vqR3dkF41gNAYjr20RecSsffOohQ2ycS/EKuR8nQEpIlgeIiJYU/a5hlWTQZC+bfXpcEqbF0PZcs3R1GWv9a564P25cyyDRE+R+dUqDhjTlALRhjiXZ84wVoCQmxnjAfE0zT6Avmw2rP525jcfZjfMtCGUsHAgLtUbnEk5/oVJFEC3zYRAU03h1bLue0/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TYXPR01MB1696.jpnprd01.prod.outlook.com (2603:1096:403:11::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25; Wed, 21 Oct
 2020 23:50:39 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::bc60:b903:db5a:4abe]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::bc60:b903:db5a:4abe%2]) with mapi id 15.20.3499.018; Wed, 21 Oct 2020
 23:50:39 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdaoBOKAYO9Ktx/IQe++SQ32O0/8jA==
Date: Wed, 21 Oct 2020 23:50:38 +0000
Message-ID: 
 <TY2PR01MB4972D9F630C057C729A93084A01C0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: af047f93-5ae0-4b42-a30a-08d8761c1cfc
x-ms-traffictypediagnostic: TYXPR01MB1696:
x-microsoft-antispam-prvs: 
 <TYXPR01MB1696F18F93B2AB802168954AA01C0@TYXPR01MB1696.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 NjCNHcV4QGMQdKI2Cr6P+l+eA/dp3AXxea2qwBdrz19uWq7ug3aVPBeRqMAZTbdqRAeUGreRrPAogK+U8k3vAV5BeCuedz9Bnd6nL+PNAo3Uc4leRdUz5Ol85pINtqQJaA2V8/NKyyt8ucqzp9oeS1bFtGsyy8N6vqWxQSm2PaaS9PrVO8j1YbYquMMFyslVygqC5OXhzGJg8heHmZyoaHmSFY1FQ9RjFovo/NC7vJScvIj9QYEbOR24Dd33Au+VSUUUYSiEaoqeR1x1Ra875HY5WFRgVTlD5aUepSuxhGwU3rCZpmsEnNbG4ytDG8U4gA5A0r9Hnd7sSVOJlaM8RbNY1StohK/lA3/RHHfOHy6BYf6BtZywcgVrpU/V5RcNYz8M4BM74ub6srS3gesOiQ==
x-ms-exchange-antispam-messagedata: 
 eNcwSrpM8CMMhrg+YeNXA0QDHrV8qK6ZetRQRh4klIpggsMDXPGyiFV0aO86+hEzrmBA/Mpw/rbodWuSBlikJRGsiMxDqbKwcyQqaG1rgQJpasEsh1RGRFvuq00PkLHbd0A5Zl1ehmOzImJXR0e26EmYfCf3+T8hQ+nhCjSvdEEoXAz0NjDP79/52UQJVobfFkoI0B5leQBAak0/LtWHYq7XMQsoOryVq1kWsanyID+8JqMzvWuumskEK8pqseJxW3/2tS9RyQRiHePG2Nt1oBqom6/cs5VQP4CbeL4O0VjkaKGcV6FgNFrTkjs0rTLW/lL2+SA/81LyUK6ok1td/Atdh79qks8U1+WaF01f2+1k3UYKwysUiNbo1kxVQG9IxXB4XUYPVqMAN45hrcguvERG5necqwUKmkcCNB+gB11ToCrBgq6b+reqa5woMhNfOjDKTs7t9MRo4SULDuqyNNj7j66ORWIOjO6F5k4CWl4P+p736we5rQmOPAofrI4FhXCtblT28kmdrsdWs1wedXSkPFmekRXXjQ/lmuEFqgbb4MJgJssTT+5CxMWrao9+HAGeQXWwAkLn2grtG+r9xUDesSXIOrgwEXIpD0gylC0qByA3Omy3G3uiRsGKDRXsjUcS1pmJGM1NYQ3cd99tFQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af047f93-5ae0-4b42-a30a-08d8761c1cfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2020 23:50:38.9126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UkM9nAhddSIt+uUH7YUUoEKXAI89WSNH6I25PSun0DH4ak6kGJ6taHxAOUioor2zRAhqUYF3g3XiwQzIl/sOigUytkb39ctnB+DoQEj67kw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYXPR01MB1696
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: g8Ue9SzdooNiNnyy5j4WG2Jbx4520388AA=
Content-Type: multipart/mixed; boundary="TXmAUHDKZPoitNmSBTkx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603324244;
 bh=VtHVLHhHqOnPvwzZ3zKnkili3/BmmGBNik4XU6VcE1Q=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=o+gs8lpDjrGtFu8rqy6MqRBaDNsCtv/uHayff65DCPCFFN/DK5g+uxbfmOpFWRwivLb
 p5a79OUcgMjGlcv/5uD3xsCwQotuTfcG1kLLpj1e/3l+qdw4U8HvZXAlCe0KSK+CZpGNG
 0RtwBXVwob3mOC004k2M2/gjtqYi4Dock8I=

--TXmAUHDKZPoitNmSBTkx
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2020&mont=
h=3D10&day=3D22&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37=
&p5=3D241&p6=3D248

USWest	USEast	UK	DE	TW	JP
02:00	05:00	10:00	11:00	17:00	18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2020/10/cip.2020-10-15-09.00.log.=
html

Agenda:

* Action item
  1. Combine root filesystem with kselftest binary - iwamatsu=20
  2. Check whether CVE-2019-0145, CVE-2019-0147, CVE-2019-0148 needs to be =
backported to 4.4 - masashi910

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


--TXmAUHDKZPoitNmSBTkx
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5638): https://lists.cip-project.org/g/cip-dev/message=
/5638
Mute This Topic: https://lists.cip-project.org/mt/77720437/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--TXmAUHDKZPoitNmSBTkx--
