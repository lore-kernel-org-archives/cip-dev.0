Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BBE109E558
	for <webhook@archiver.kernel.org>; Thu, 26 Mar 2026 06:45:29 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.58])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.41799.1774507524683595988
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Mar 2026 23:45:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=IPNQGr0U;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.58, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n3iqtzU6if0tRx0vrwILMGLfFcoe7X+GFYzJT2UGJtskGRPtlmwDFLQvgKru1Gtx8WoDUo2FIgHX5ayffif0J6pfoGjVZAaqjXLr6k6SnSd1VGwfkf9WGs9GK3iRxR8CYT/BD5x21mIP9IYSlM8WDxmR7RTV4WFrdhmMVYsg7y4x9FB6DYuy99Onnw0EfqSwNfS1SXzoxFk4WKAfByJ/3g+YXVwUr1TuLFYEGvhHuIMF6xRLU017idrlZBmjpK+jG6qise2Z4MwRIjK7EADg+aHdavn2QfApML2JLZCmmvnjtRYqRkj+1QyqaUXMRz5/nXUMNK3pm6M01NxZb4Qb0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R+aYDpAKDN+zFSieg7lQl3bDMLwnp7+OYnDgFrGvJ80=;
 b=tlzpBFUks+fPDrdOi7yPjVowLNcteSAeOwGGxAKyCzdvK3f+VgU+uEuKUGi2E06iRpxJjot5uyBv9VtS22JJvkOOxUDW6FNW7T8OEcfMIzMhcgMcJ63D7C7KzipGV24iTnPYO59RdNk+G6Sn0c1Ph/DVIm2zaBQyYXdhzte5Njn5wVLLoADsaJcis855+5B7bDH/g64/nToPtEdwCGYiZGW7CSEbbxpGkWc34neMZ4FG1KKLkGKhCAtE/MSXIM7knGobOf3GfGp0AOeO5zB77sZ2p1xu/0cf4Dm9UVcgsBiyOOmCSGNSaL/JY6o3ViwPIX4T2PU3Ro+NULQhfFaXIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+aYDpAKDN+zFSieg7lQl3bDMLwnp7+OYnDgFrGvJ80=;
 b=IPNQGr0U1phOZIBBXlIodZCgEN1dOTx3BXMZGa/ZHoTXBjRFgbhnpBRyBrv4cwRhJXywo51JvAf6R3sHwkMxDRVXzAUEYFl8jWfK9Ko5MR2UFunI48XKd1eq1LFy1PzsC562fabXp8ujOH0dpvfR08b0ejbk019dmBs0omCUtRM=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY4PR01MB15806.jpnprd01.prod.outlook.com (2603:1096:405:2bb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 06:45:17 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.20.9745.022; Thu, 26 Mar 2026
 06:45:09 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: biju.das.au <biju.das.au@gmail.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>, Nobuhiro Iwamatsu
	<nobuhiro.iwamatsu.x90@mail.toshiba>, Pavel Machek <pavel@nabladev.com>
CC: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 00/39] Add Renesas RZ/G3E RSCI support
Thread-Topic: [PATCH 6.1.y-cip 00/39] Add Renesas RZ/G3E RSCI support
Thread-Index: AQHctf+ifxTR/rtbeE+gnoU/LP4ZhbXAbBuA
Date: Thu, 26 Mar 2026 06:45:09 +0000
Message-ID: 
 <TY3PR01MB1134618D8A4896B5FB8A8D3AE8656A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY4PR01MB15806:EE_
x-ms-office365-filtering-correlation-id: ae74fdee-91d6-486f-25c4-08de8b033912
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: 
 oPFHmdNVk4vlmbUk363eycBXAeXeXcm8hw+OD2QHxwizOa5ZkOFO703AoKHRW/rhj1ndQSvfRAgRdcvndNo4kIxfGAlKBci7hWO7nC0sf9Boq3qV+boq0W4QZMZqlyu3TYLEosG5LtLVOSWgxwrSczUuagsaGSuiWs0pyk/NnTuRhzaU6zywX2dWvSti97nR8QKR5mvu9iu/nAqn8zmtJccaRFc0LmzeLBTKgtfRsuQEpW8BzUMnjLZfwpHmd1xnPf2S4d1VUAUl5vh/tjXE+o+tuASAvViiOAQqMkybiS/G5S09STxQXijujq3mbMaRMF4SIiB2WQmkVQx8GahOTZKAKdakGo3bgmS4g/cERlwZFXHBFBfsym4TkeaRtJOuaLUWPON9dA7UlcjLRTnK5LsJ0/wCuZocq17f3eXramGiu+7zPaY1L0oGqDc6CkaD06vKXcCtOE2o7CwJtt8Yuwff70dQlb0oGHya28yvfhSlgdL2GUW11HqTPGquqYA7MQC36DgWBYjKSGVY0C8S/4JF06hLG0+d307i/4ZIVYCHSL3tzTnTvIbeFspEvhwRviqtyMQ4IoUIC/LDmMBb5Xhoxr84JY+2CXBj0D4sVYjomhTazFRyq5+RtC1cNmWrIbX++QdvASNdbpVgb/xIDNDZMzIr52qX0BfafqoQ7qx/6Ys8Q+hRk1wj5JQ3OQH4N+lILDvdS9wXWFwhHpNTmbTIyeGmw62KcYEKjgGpf5IxfL/zC4RcIs4SjH3HVH8wNcZZXtQCxmLFkFO9Mv/wDD1skb5TBqlQLxFw/YTRfQg=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?KxPEBsqTGvvzC5kAp1+lFJqq2qN39eczHezrPedFs4xyOoL42MTAp7/ubRFH?=
 =?us-ascii?Q?K6sylmqhiAbyDiTOM+3l5cH2KJFEM/JPsNQJKyJQ4snp6dXY7cTVJixt22+k?=
 =?us-ascii?Q?8ecEO6SvOhCknoIRVtYMsnw52GwmZlEEE1yXJGR7NHacKGljMy3zTPhtA1Vj?=
 =?us-ascii?Q?qmpziB+d+LUswu89JjLfh85tC8pOd7T9ZiO4EAmrHyECeUVciWs/m0AOxgrT?=
 =?us-ascii?Q?4wyt5YMU42m+U63oKPgMmwhUlVYxYXvVpyPZH5F9qCQon6+Ky4ZR7D7qcVVQ?=
 =?us-ascii?Q?r9JLDTwk1w8u7KDfgHANa9qqSl6gpaK/DgwmTC6b0JKm0l+YVptC97Y8QheB?=
 =?us-ascii?Q?kmJ5jrx57gH/AKoy+50pj7zMvUHzLyiOGSHoCxWITVHfmq88e9mY57+4SEMO?=
 =?us-ascii?Q?m6B2gThcxJmou4leIZ8wUQBUaoY2j8YkYDYSqsWJVEHqCb6mwCFCoIXd+CHp?=
 =?us-ascii?Q?+P3YfqnaYsYKxjqYx5PZ4CQU4DZy7HcHdySUCBJHJaSl4KbrXja3pP+wSpyA?=
 =?us-ascii?Q?FXHrNYTBTuR7gIP+KPKmcdLpGAHv0zu5xxHdYmpsv6dN5jfysgAYZMxlY8Va?=
 =?us-ascii?Q?+N8ByCWuAlPnIyBofbeDWo4ixQ6VGXRvCysq/pqnXjFVF34zEc7JqPyG/UeE?=
 =?us-ascii?Q?fIGdI6dSZuq/gTZDY5CUclu6tvZEIc3+4d5zNN/afVdXdHgCOXTTyEXPY9o/?=
 =?us-ascii?Q?PVKc5irnz16ZPRjuS1V9W18kD5mBLLEXD1nBTXbgCX8Bn1Wnm+69d/ARM69P?=
 =?us-ascii?Q?JhUtL1qiCZOZzuJPpj8jovS5zvrsAHiZvt6Ij8T5Rsjmtm31mGDK6469Y1M0?=
 =?us-ascii?Q?QtNs06BtPSO54AaGExb8R4UjXg+1bEof5+i3bdcbVitTyp0J4hiVleMaUAhZ?=
 =?us-ascii?Q?TFP3bV4WPKRuSzU/45DEx/Ra2TGJvTsRxtaOMMii5mS2sqxe1JdFp0Gxs6ZN?=
 =?us-ascii?Q?zGjQkNYEucPUQyCU8XIP+ENLHyJqngww840XldzCw7m3oWXGXzBn7WP5de0p?=
 =?us-ascii?Q?1S4ijWCjLiNfeZagqdb8ApeYK3/Vw0Fdi1DinwCAX9qBckAT/HyjxkkBRBem?=
 =?us-ascii?Q?h7lzXcYp0li2o/hqu0kMwHHzzPqv2F5OR3/7rwkPeUhO00f2vr0KoPcqaWd6?=
 =?us-ascii?Q?AktS8++F6vyX77xGO9vtqMVQoP8XfXkPBgo2qvehdHsJyeT6UIU8Y5UHQv4h?=
 =?us-ascii?Q?Q1ZKA392bR/En3RECBnJwa2Mp/cdFt1i4WjRd9ZKHcz6mt0Bq+najRGkctdH?=
 =?us-ascii?Q?q/70WhvaPJLzYQWwgXPqUGP7XwlOUwRWHbQ++ICgvSCV3121BYL7zuuXZdnT?=
 =?us-ascii?Q?16Qs4ON3Ew78AGbqUfs6Tww3uBONfE3zR3dEEC3yRcYENg66VHwlQDWw0UVv?=
 =?us-ascii?Q?y589v4Fwv+g+vxM11EvwklL1tN+dS+2P3PzUcHpNzYXQ48svl7Qz8vdJeQvk?=
 =?us-ascii?Q?QG58qqosTmsbPsUeldGPOt6IDP9/CHPptdTdL5eNVjlNZIBGWJCJ84LIkwtP?=
 =?us-ascii?Q?hYP4yG4KbLLafseuURPCvX7YsctdWyHmzMhZSxz41WPlKWNoyapcdko8AQQU?=
 =?us-ascii?Q?N2fkk58QWjdaJBNPIYDZnpWh/eT4nEyOKM46P60w217zoSgvGDZvvz7xSMnp?=
 =?us-ascii?Q?0tS7Olh9z7eylPqBs9fRbYZBMG/xuEt5mmNFnZblL0elwC9xFN7o4mewsnqQ?=
 =?us-ascii?Q?gHLqXsedhVdnBGuaN6d0hqVrGC/eh1iNWGk5y7VPwNn+tNZq86I6P1g12N20?=
 =?us-ascii?Q?CAFcb+vmgQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae74fdee-91d6-486f-25c4-08de8b033912
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2026 06:45:09.1333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u1AKQ9FdS3sM3nKEwKlhwezMHuKacYT/XEZ2q5ZeGbs8KMG5LrrxRePsDHNq6G+abrks+t0i4DK/ZRJHx3lmdjFI5mx5+unHPxsuxgnk8bQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB15806
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Mar 2026 06:45:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22576

Hi all,

Gentle ping.

Cheers,
Biju

> -----Original Message-----
> From: Biju <biju.das.au@gmail.com>
> Sent: 17 March 2026 11:16
> To: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x=
90@mail.toshiba>; Pavel
> Machek <pavel@nabladev.com>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Prabhakar Mahadev Lad <prabhak=
ar.mahadev-
> lad.rj@bp.renesas.com>
> Subject: [PATCH 6.1.y-cip 00/39] Add Renesas RZ/G3E RSCI support
>=20
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> Hi All,
>=20
> Add RZ/G3E RSCI support for FIFO and non-FIFO mode. RSCI IP found on RZ/G=
3E SoC is similar to one on
> RZ/T2H, but has 32-stage fifo. RZ/G3E has
> 6 clocks (5 module clocks + 1 external clock) compared to 3 clocks
> (2 module clocks + 1 external clock) on RZ/T2H, and it has multiple reset=
s. It has 6 irqs compared to
> 4 on RZ/T2H. Add support for the hardware flow control.
>=20
> The device RZ/T2H is not present in 6.1, so squashed all the binding patc=
hes into single commit that
> document RZ/G3E RSCI.
>=20
> The set_rtrg() uses field_prep() and later replaced by PREP_MODIFY But fi=
eld_prep() not present in
> 6.1. So squashed the commit.
>=20
> Replaced kfifo_*()->uart_circ_*() in rsci_transmit_chars() to make simila=
r implementation with
> sci_transmit_chars() for fixing tx issue with 6.1 kernel.
>=20
>=20
> Biju Das (21):
>   clk: renesas: r9a09g047: Add RSCI clocks/resets
>   serial: sh-sci: Fix deadlock during RSCI FIFO overrun error
>   serial: sh-sci: Update rx_trigger size for RZ/T2H RSCI
>   serial: rsci: Add set_rtrg() callback
>   serial: sh-sci: Drop checking port type for device file{create,
>     remove}
>   serial: rsci: Drop rsci_clear_SCxSR()
>   serial: sh-sci: Drop extra lines
>   serial: rsci: Drop unused macro DCR
>   serial: rsci: Drop unused TDR register
>   serial: sh-sci: Use devm_reset_control_array_get_exclusive()
>   serial: sh-sci: Add sci_is_rsci_type()
>   serial: sh-sci: Rename port SCI_PORT_RSCI->RSCI_PORT_SCIF16
>   serial: sh-sci: Add RSCI_PORT_SCIF32 port ID
>   serial: sh-sci: Add support for RZ/G3E RSCI clks
>   serial: sh-sci: Make sci_scbrr_calc() public
>   serial: sh-sci: Add finish_console_write() callback
>   serial: rsci: Rename early_console data, port_params and callback()
>     names
>   serial: sh-sci: Add support for RZ/G3E RSCI
>   arm64: dts: renesas: r9a09g047: Add RSCI nodes
>   arm64: dts: renesas: renesas-smarc2: Move aliases to board DTS
>   arm64: dts: renesas: r9a09g047e57-smarc: Enable rsci{2,4,9} nodes
>=20
> Cosmin Tanislav (1):
>   tty: serial: sh-sci: fix RSCI FIFO overrun handling
>=20
> Geert Uytterhoeven (2):
>   serial: sh-sci: Call sci_serial_{in,out}() directly
>   serial: sh-sci: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
>=20
> Krzysztof Kozlowski (1):
>   serial: sh-sci: mark OF related data as maybe unused
>=20
> Lad Prabhakar (3):
>   serial: sh-sci: Replace direct stop_rx/stop_tx calls with port ops in
>     sci_shutdown()
>   serial: sh-sci: Sort include files alphabetically
>   serial: sh-sci: Merge sh-sci.h into sh-sci.c
>=20
> Luo Jie (1):
>   bitfield: Add FIELD_MODIFY() helper
>=20
> Max Filippov (1):
>   serial: add PORT_GENERIC definition
>=20
> Thierry Bultel (7):
>   dt-bindings: serial: renesas,rsci: Document RZ/G3E support
>   serial: sh-sci: Fix a comment about SCIFA
>   serial: sh-sci: Introduced function pointers
>   serial: sh-sci: Introduced sci_of_data
>   serial: sh-sci: Use private port ID
>   serial: sh-sci: Add support for RZ/T2H SCI
>   arm64: defconfig: Enable Renesas RZ/T2H serial SCI
>=20
> Wolfram Sang (2):
>   serial: sh-sci: let timeout timer only run when DMA is scheduled
>   serial: sh-sci: simplify locking when re-issuing RXDMA fails
>=20
>  .../bindings/serial/renesas,rsci.yaml         |  160 ++
>  arch/arm64/boot/dts/renesas/r9a09g047.dtsi    |  220 +++
>  .../boot/dts/renesas/r9a09g047e57-smarc.dts   |   64 +
>  .../boot/dts/renesas/renesas-smarc2.dtsi      |   13 +-
>  .../boot/dts/renesas/rzg3e-smarc-som.dtsi     |    4 +
>  arch/arm64/configs/defconfig                  |    1 +
>  drivers/clk/renesas/r9a09g047-cpg.c           |  126 ++
>  drivers/tty/serial/Kconfig                    |    7 +
>  drivers/tty/serial/Makefile                   |    1 +
>  drivers/tty/serial/rsci.c                     |  728 +++++++++
>  drivers/tty/serial/rsci.h                     |   11 +
>  drivers/tty/serial/sh-sci-common.h            |  183 +++
>  drivers/tty/serial/sh-sci.c                   | 1296 +++++++++++------
>  drivers/tty/serial/sh-sci.h                   |  180 ---
>  include/linux/bitfield.h                      |   21 +-
>  include/uapi/linux/serial_core.h              |    3 +
>  16 files changed, 2348 insertions(+), 670 deletions(-)  create mode 1006=
44
> Documentation/devicetree/bindings/serial/renesas,rsci.yaml
>  create mode 100644 drivers/tty/serial/rsci.c  create mode 100644 drivers=
/tty/serial/rsci.h  create
> mode 100644 drivers/tty/serial/sh-sci-common.h
>  delete mode 100644 drivers/tty/serial/sh-sci.h
>=20
> --
> 2.43.0


