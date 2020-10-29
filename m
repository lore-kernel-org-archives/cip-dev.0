Return-Path: <SRS0=jxdo=EE=lists.cip-project.org=bounce+64572+5694+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214E3C2D0A3
	for <cip-dev@archiver.kernel.org>; Thu, 29 Oct 2020 12:00:20 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3040D207BC
	for <cip-dev@archiver.kernel.org>; Thu, 29 Oct 2020 12:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="GXJZc6Iz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3040D207BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5694+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id xP4uYY4521723xWKWOIwhNos; Thu, 29 Oct 2020 05:00:16 -0700
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.99])
 by mx.groups.io with SMTP id smtpd.web09.7587.1603972815753300555
 for <cip-dev@lists.cip-project.org>;
 Thu, 29 Oct 2020 05:00:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jjRdJMBwMUtwMeFG5NfJdccI/jCxzE4S+YZ4bkYelhCr7s3b24aoFqzuB6TGxrvMpCGY3e83e5oeiHSPYXJll/zL7i+H1xBIYVfnXC85/iBXao9IsuJZ+KkcPAz2DENgYPfYeEyxoDiSRGQe1BCPUnVnMrHZqIQr43vs7D/t10dmcvUY2V+f989kBg8IgOoSTpsvjTBI1Y1v6PPLSDPMHGIELKUpyTbEWX22PXSlt9zkAlrFqQau/jbFDS0jhoaiMCHURchII3dpX3oYmBbGq/tiGfjUOBsyjSdli3CzTCeAUvOWBtC1ujk41zVcInWZC8X7gYftyFcoddn/vKgFVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B19YxYEvRcyIY8r9vbcsOjMcROLv0KMaXPXUGNWJ97g=;
 b=Gohm9cwg1CPkgLwDKE0zjaWApX7DFyw+XbYZBq83X/wjUNiMj0Ng5P4dPOifOuiCdwYNG5gtCgkwX/DzTTf81AE7TYVwpmq29zj6eZf3VcAiM6rRZJrkbHCHhO/ZtUAx/24lm45F9KMsB5dtkE+SJNhu7L7fvkSd/qaZ+IkrlVmGM7LsoJ0mrN+Lw1cZ/j7GTD8zgmTN9gC8l+eyS/HGupSueOblS6+iPoySUrrJiSJ17JOMm48Ixo1awvdJTxFanS2rZdAMcsNPDxOqWZXFfwlH4SZD5EWemOYdVGoHrAmDHU5w+AKowbTx4Aba7FncvWRthQ0ApTzBjzzovwHd+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com (2603:1096:604:38::10)
 by OSYPR01MB5432.jpnprd01.prod.outlook.com (2603:1096:604:86::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25; Thu, 29 Oct
 2020 12:00:13 +0000
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::18f:c7ea:e9e4:db70]) by OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::18f:c7ea:e9e4:db70%3]) with mapi id 15.20.3477.028; Thu, 29 Oct 2020
 12:00:13 +0000
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 0/4] Add SATA support to RZ/G2N
Thread-Topic: [cip-dev] [PATCH 4.19.y-cip 0/4] Add SATA support to RZ/G2N
Thread-Index: AQHWrekZ1QvTw5zho0GgCSWqKXX8k6muefuA
Date: Thu, 29 Oct 2020 12:00:12 +0000
Message-ID: 
 <OSBPR01MB504881CC1F63DB299BC816E8AA140@OSBPR01MB5048.jpnprd01.prod.outlook.com>
References: <16427401AEA80AB0.17887@lists.cip-project.org>
In-Reply-To: <16427401AEA80AB0.17887@lists.cip-project.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b09ba58e-c59a-4b49-751b-08d87c023146
x-ms-traffictypediagnostic: OSYPR01MB5432:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <OSYPR01MB5432C600E66DDF40BA9C2E74AA140@OSYPR01MB5432.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 eLc/zG3j49+j283Fyyb/uLvYHLw/rbQY7uUIlGrNqS7vM3cTZYYWIg1tSnMNWX7+Y0LEbDsFTttSeugxS8RQWGcSWagyFtG+2Z6TQueN0wWQXWymHYhlMEsUbfwIw5/oIO0qgFdYof9L+TflG4jMx11E3cEbY4g18HW538hiSpJu+rlKHvy5WhdXY5eyP0tyqUjOWVOc6bpOhdKg2pwz0vkDYhyGvODcdYRQgwD7NWCOymGo1EHVA7Mz5AsBkby0mrkib86iGKyi1U5cvWAdNyypStRueHN+zlTL41+Xn/zuwpihkvZNHleVxjfkuSwckdYzLcLtWChGZf8SmVLDdA==
x-ms-exchange-antispam-messagedata: 
 wkIIyKhzHi8XigqWwMpfiaR6NR706bF67CIQ5I9QeEAnn7DFXuWBAu/3HAgqmrzhIdSIVfdtaB43aqP1iWl486RmpBuogYmxlKA/Y5VinDMp9helKt/MnfNYB7OCQ6w7JCs/TG0ZnZXvfohSOmhqhg2iDKZGnHgHZMtUrMlhFYUXQ+d6Sale9+Bvk90E8xXXcYAtJxJQ1F7hYQ0XwRpZmcOCkYKKW5zeQzkOXU84O4J3izTfUD9jODB8TWfsBLKiI4iI1VwGROX7qXb0KgGdP50gKN2kwE2GvMLOeoNHhxvfBw07jLByWMLRdmLAnI3iBLalsxleUmO9d6TyB/MSiIP6trnOlT+//6DuTJMGJcaHTOv+ivbz3iSNihSAdtyBHecnZSEyVGnu1TblUudBdJHsHc5rLtzoC94F9uHXg3//B93ciN0cMOyuY845CAjlLBQ+TyqbdPZsQNWKneA+XUZcu1S0Sqpi83xyYjC5UyBOudV21SYtrp4e06mVmyHkM0V89uGN7T67fCKlhif/NJXnfK5suLVkSamQFAfG4ygpSKCB3p47PCx0foqM/X+tNNwbAo8pMyRAu9ZvCrsRHDBHCYsPFlk00n85t7SWMDGrz+VjBYdS+WTaMQqHpwuSN0DKwDB1DNcopb1Baai0QQ==
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB5048.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b09ba58e-c59a-4b49-751b-08d87c023146
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2020 12:00:13.0335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pPXm4cE+SARb+otusiJKk59OzmvqrX3SPtgJiTvDNxu/WrTgFbbP5wzQ7pBmacZvxnAmqo+tmUAoJO1YyWBfVwwg6+ZdYofhBPJVAE+fUz915W5CAliLmi0AsXtsIyGw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5432
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 6S0W8GNGMAjjMQUvx7EImslWx4520388AA=
Content-Type: multipart/mixed; boundary="V1XkqF4aJrXIAZ9WDLNL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603972816;
 bh=TBsL6TZkGCrnHCpoDVk5jeWXuPI0/8dupcGJQF+YjpM=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=GXJZc6Izj8B9j8vqCHuLaMRY10jQpSgz9sZrgvwhg+IeXmPsU2bQLLSoI2loEsUDTDY
 cymTgKIoGh/lLGglK+jItAZcTWUpuzlaqiDLfK74gvxKfk3o0QOI+f0pug0mp8t3n+7OA
 ayvNWLprVw+mtp+C7PvqyS4wql5mp7IEd0g=

--V1XkqF4aJrXIAZ9WDLNL
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Lad Prabhakar via lists.cip-project.org
> Sent: 29 October 2020 11:46
> To: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Pavel Machek <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>
> Subject: [cip-dev] [PATCH 4.19.y-cip 0/4] Add SATA support to RZ/G2N
>=20
> Hi All,
>=20
> This patch series adds SATA support to RZ/G2N SoC and enables
> sata node in Hihope RZ/G2N board, alongside a fix to sata driver.
>=20
Missed to mention all the patches have been cherry picked from v5.10-rc1.

Cheers,
Prabhakar

>=20
> Fabrizio Castro (2):
>   dt-bindings: ata: sata_rcar: Add r8a774b1 support
>   arm64: dts: renesas: r8a774b1: Add SATA controller node
>=20
> Geert Uytterhoeven (1):
>   ata: sata_rcar: Fix DMA boundary mask
>=20
> Lad Prabhakar (1):
>   arm64: dts: renesas: r8a774b1-hihope-rzg2n-ex: Enable sata
>=20
>  Documentation/devicetree/bindings/ata/sata_rcar.txt   |  7 +++++--
>  .../boot/dts/renesas/r8a774b1-hihope-rzg2n-ex.dts     |  5 +++++
>  arch/arm64/boot/dts/renesas/r8a774b1.dtsi             | 11 +++++++++++
>  drivers/ata/sata_rcar.c                               |  2 +-
>  4 files changed, 22 insertions(+), 3 deletions(-)
>=20
> --
> 2.17.1


--V1XkqF4aJrXIAZ9WDLNL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5694): https://lists.cip-project.org/g/cip-dev/message=
/5694
Mute This Topic: https://lists.cip-project.org/mt/77885348/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--V1XkqF4aJrXIAZ9WDLNL--
