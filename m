Return-Path: <SRS0=4SwZ=CL=lists.cip-project.org=bounce+64572+5383+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CB3C433E7
	for <cip-dev@archiver.kernel.org>; Wed,  2 Sep 2020 16:25:57 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 181AE2067C
	for <cip-dev@archiver.kernel.org>; Wed,  2 Sep 2020 16:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="uJXaL3YI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 181AE2067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5383+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id KbQCYY4521723x3dIHlRQOkG; Wed, 02 Sep 2020 09:25:56 -0700
X-Received: from APC01-SG2-obe.outbound.protection.outlook.com (APC01-SG2-obe.outbound.protection.outlook.com [40.107.131.138])
 by mx.groups.io with SMTP id smtpd.web11.11715.1599063852403964261
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Sep 2020 09:24:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DoSdr/mVsVEN/xrhBKfZj5ro/mpyrxPA7ntLdVrNN6+Mw7WnRVZoR/lsTYdAfIW2B+RLjK4d6zQJFbGpyhBg5ChfWjIsiwLaXMXIrQSCpgtw21xraaPZ7iHOrJb9MZhjIiZsDY5uIbGhjGVXsXj1k1nqDMyk7u7SiWtIQv1yx4wBjQaZ3+0Iy29zfj3CLoDX9wmKg6tQZLif1FViuqP+ytiFv1Eb8OGkh5+6WnGnPxFrjfy1maYnZ6S9OL7QAlYuGzb8MYb4HNycjEl/b+lUx5jVxH3NAJGtl8uHpF8EB4xdQUdAc0IbKxf/BSwptOka8jy2r73enjpQN0yejeLwqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORTcFhDxCrU1HmcQvawn6G4GccJXXh4qH4zLmqi6+MM=;
 b=dEMX/ogr9N1WRdjzgzG0cr++apX1gp+HOT34pYp34OfTGKVVjqt/9FEUryGZA9KVuljoskp9aGqKaZf6gFsQu4kp/HN2s+cZorhWe7kANxPhR3Yjt5t0TSXRmWO+1cDdIBMMQU/SPv5Ci4ACTvl6APj//HGc5zafip2WYR48XHFNLCPdW7vLr4zB7ei8QnZBrHpuvNKfg1lZ119bQX6k0guy6W09zNDNyppNqGTyz5qGKJ7UXHuC+mjPfODLhTt4gefQmGKOBQVM2uZtyztbgKBNpxraN8t7ZnVn4vGxwePFw3UVkEqQjMd4KZXiGF71vhIzs5XFJRKYrCNHBygTcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from TYBPR01MB5309.jpnprd01.prod.outlook.com
 (2603:1096:404:8025::15) by TY2PR01MB4330.jpnprd01.prod.outlook.com
 (2603:1096:404:10b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 2 Sep
 2020 16:24:08 +0000
X-Received: from TYBPR01MB5309.jpnprd01.prod.outlook.com
 ([fe80::c141:37ba:af8c:b2ee]) by TYBPR01MB5309.jpnprd01.prod.outlook.com
 ([fe80::c141:37ba:af8c:b2ee%9]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 16:24:08 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>, Nobuhiro Iwamatsu
	<nobuhiro1.iwamatsu@toshiba.co.jp>, Pavel Machek <pavel@denx.de>
CC: Chris Paterson <Chris.Paterson2@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip 0/9] Add RZ/G1H WDT/Thermal/CMT/MSIOF support
Thread-Topic: [PATCH 4.4.y-cip 0/9] Add RZ/G1H WDT/Thermal/CMT/MSIOF support
Thread-Index: AQHWgULc8wAo+dXPo0W6XlynmsJPPalVhiYw
Date: Wed, 2 Sep 2020 16:24:08 +0000
Message-ID: 
 <TYBPR01MB53094D74BB55C87E664CBA45862F0@TYBPR01MB5309.jpnprd01.prod.outlook.com>
References: <20200902160517.5181-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200902160517.5181-1-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [86.169.0.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4a3b243b-beab-41ca-1eae-08d84f5c9e2b
x-ms-traffictypediagnostic: TY2PR01MB4330:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <TY2PR01MB43302F5CA3863FC581AAE95A862F0@TY2PR01MB4330.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 jVDxKIn6mJQZ6dLgXQBP396u5OgYYfwCWjPO3rdCoLk7WkrDCgJLzySjn/93S8AVFVzHuKSlzwMsERiwZ+6RZzku0c0NLaB/x1XxLNPFxDqAWHVtOEz1Ygnn4cvVQ4dSw/CR0kU/KAbcuLMIXTrnKiHX1mIIIgEDO3uynWIHn/mQupzfZAlh7MuRERY3eVfCXO3Ox84V5v2gjldJIFtEXSEUqddqoNsP+bDbPwl0HIXME0Oya82XC3xpDoPndd1/NLzrai4o/WyBoOQjqmJE+Wxi6p6AnYLzf8zYESQqq3cpFOjQOEdXscnb0/AiT3xN9bJa+YnnlXV+PWTnalGX41fOH/8GQ3/7i3+o4Volu6kfzGWHY8hbtKXNob+S+PSp9FzBlpq+vd8LSEgS6pOpSQ==
x-ms-exchange-antispam-messagedata: 
 ARaPWex7VA0vzNAcQ867IRiZNGamh2rZJvzk8DTpmfWr8h5QLeXLpopJD6JZ67d7ulVkyMq4wnzntqR6kkE+f9RYfVt9b19wFkrbPS6C8RReErfhDRkCcdtLwW49bzgghoNq4QaN/LZGiPDgWd4QlKZRjwlptk1OpZGv17+EChUlzbUjCFM2VQWPdPpwdn3m9Nu+MiFe6csdVNmLKzaT9pfsLWfH/6p/j9KoGX58QlkI8P20QANv6H/9F/DzjFKJ0Oej8Y23FIi1i9IVLN4pYsfQSfUl61ExQRyZYIg4iWsEPzQwK7Ve9ZqjwL+KHIgzIBTkc1B0rSYSbhfSbWiIYjDC3wIYukmTbMz2lbOD64yOSfHFTSG2F16YrxkqnwYhLtqQqHetg69FI0XrQUTpHNamLZT3yuqOM3KrlhOGFls+r7TfMAwbFWLF8G0G2GAAIEmy1G3x9ViTVgL/NFfnxok04JunLbyR9KwUA/78/vev6l/qp6Lu+Xk6p2vzkQOXryL1xTjX5fNlqwDcRnwVQ/cEEaPpVTFxcSwmpl+2tP5ISL/Icc2uKS0tDjV0kH2oW1SUUWW8aS3NOD9iYVLQidKF2PGwGRhVLJ1ZD+R+ea2ABDVGUYBTXDGp5rdC6tTBDA3vX/Lo6lvvhEm3OFu7UA==
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5309.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a3b243b-beab-41ca-1eae-08d84f5c9e2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 16:24:08.0971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z9mnHwnHUZ2BjEuHVBOD+ga7v8URx7gps7pvA22PGefyG3nbI8kyrX+jOsUrQ1RB8ykDeJqGn9IXiJ9tEKOgI8KcZncFBXQB5kgEVWJwh1k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4330
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: RWEmj23iT9RJ9zpZOPCVIC0Gx4520388AA=
Content-Type: multipart/mixed; boundary="CUIdgAhRsv6xdwwFx5Sp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599063956;
 bh=UsqiWNSKs22UxbQZJ3fwK+g/jFlTW52SUJSy9wSIwuo=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=uJXaL3YI7nZh5Du3C2qyaDRLsUSNPVwf3lWyIxZCQDW7LFMbDwbfuPyF0qeeijHCBE2
 ZqyAxIVs09WtuQ2v0+9Q+EA+LM/lXd5ahn5tMM+3dsiJAL7amg5PllscDYmFCx0U9qhbI
 JW5mZVUsri+J7bKn3nDSxdoam2dj9vI7kv0=

--CUIdgAhRsv6xdwwFx5Sp
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi All,

By mistake, I have sent the following duplicate patches with this series.

1) https://patchwork.kernel.org/patch/11751131/  (ARM: dts: r8a7742: Add MM=
C0 node)
2) https://patchwork.kernel.org/patch/11751133/ (ARM: dts: r8a7742-iwg21d-q=
7: Enable SDHI2 controller)
3) https://patchwork.kernel.org/patch/11751121/ (ARM: dts: renesas: Fix SD =
Card/eMMC interface device node)

The above patches were sent as part of previous series[1]
[1] https://patchwork.kernel.org/project/cip-dev/list/?series=3D342183

Cheers,
Biju

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: 02 September 2020 17:05
> To: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu
> <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek <pavel@denx.de>
> Cc: Chris Paterson <Chris.Paterson2@renesas.com>; Biju Das
> <biju.das.jz@bp.renesas.com>; Prabhakar Mahadev Lad
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: [PATCH 4.4.y-cip 0/9] Add RZ/G1H WDT/Thermal/CMT/MSIOF
> support
>
> This patch series add WDT/Thermal/CMT/MSIOF support for iWave RZ/G1H
> board based on
> r8a7742 SoC to 4.4.y-cip kernel. All patches in this series except last o=
ne are
> cherry-picked from mainline. The patch "ARM: dts: r8a7742-iwg21d-q7:
> Enable cmt0"
> is ported from linux next.
>
> This patch is depend on [1]
> [1] https://patchwork.kernel.org/project/cip-dev/list/?series=3D342183
>
> Lad Prabhakar (9):
>   dt-bindings: watchdog: renesas,wdt: Document r8a7742 support
>   ARM: dts: r8a7742: Add RWDT node
>   ARM: dts: r8a7742-iwg21d-q7: Add RWDT support
>   dt-bindings: thermal: rcar-thermal: Add device tree support for
>     r8a7742
>   ARM: dts: r8a7742: Add thermal device to DT
>   ARM: dts: r8a7742: Add CMT SoC specific support
>   spi: renesas,sh-msiof: Add r8a7742 support
>   ARM: dts: r8a7742: Add MSIOF[0123] support
>   ARM: dts: r8a7742-iwg21d-q7: Enable cmt0
>
>  .../devicetree/bindings/spi/sh-msiof.txt      |   3 +-
>  .../bindings/thermal/rcar-thermal.txt         |   1 +
>  .../bindings/watchdog/renesas-wdt.txt         |   1 +
>  arch/arm/boot/dts/r8a7742-iwg21d-q7.dts       |   9 ++
>  arch/arm/boot/dts/r8a7742.dtsi                | 135 ++++++++++++++++++
>  5 files changed, 148 insertions(+), 1 deletion(-)
>
> --
> 2.17.1



Renesas Electronics Europe GmbH, Geschaeftsfuehrer/President: Carsten Jauch=
, Sitz der Gesellschaft/Registered office: Duesseldorf, Arcadiastrasse 10, =
40472 Duesseldorf, Germany, Handelsregister/Commercial Register: Duesseldor=
f, HRB 3708 USt-IDNr./Tax identification no.: DE 119353406 WEEE-Reg.-Nr./WE=
EE reg. no.: DE 14978647

--CUIdgAhRsv6xdwwFx5Sp
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5383): https://lists.cip-project.org/g/cip-dev/message=
/5383
Mute This Topic: https://lists.cip-project.org/mt/76585838/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--CUIdgAhRsv6xdwwFx5Sp--
