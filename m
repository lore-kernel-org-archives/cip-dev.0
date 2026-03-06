Return-Path: <cosmin-gabriel.tanislav.xa@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9E0FCB637
	for <webhook@archiver.kernel.org>; Fri,  6 Mar 2026 17:07:12 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.2])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.74261.1772816825374377257
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Mar 2026 09:07:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=gSnJwAHM;
 spf=pass (domain: renesas.com, ip: 52.101.125.2, mailfrom: cosmin-gabriel.tanislav.xa@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EaSbvUY1uvFtmBGrT/OyOh0FVcXud6VEELBpawX8t9VoCzLEoqijeTDBkE8XiJGl715Qrmkg7YMpdADfeO27eo7u3srwiFIopNKm8i1kyud3CSRJN+ftQT6s7oGrl83xAtLpG5zljsXkTNwzR49hnVCSyfPsgbyGPkfyAS9rkgvUJbHv8RwYj7Dc+rydEm0VN2ZUM2F54orR6tWL8rBK+j96hUnP9nTrCXlk2djdVSUwSWCJmeQ+sywu62RrXkkOi4mjsvA2HI8vwOlt5HGPis6NQ5S4zoMbSSXHjxLMPHOPtTKiLE/+qhyqGCd//vrN+ebHsqF4iL+nkxk2KB9wdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OODJZjutF506ZIDBIt5vOY8QkQREv7ARuXqS4XEy+0Y=;
 b=eAIVuaYXtEdy3YqEYxuuhCb/w1wirckXKKNtToPZMznYmx+HHrxxUNgeKKm9y3mQ5O/aI/VqWwp+2k6mmv+THcb2ERVzeqv2jwy8cZ8p9Turmq1p3u+D8PYrYDcVGpWocSw+TT21zQfU2yjszVYTBfhX8ePSJR3xGn13J8g9IZ7bKAD1FeM9eFiq2Ss2WGaM3wKLqxBs5gjTvuGFpujYEWQZk7bOK4H94wCeOrOhD/DaR5JQjcZ695Z5zOoIGC9pQNIpgDezw/lP+FQcGBCt3eRHH2xJCEc5yUk0Zc3N6NXHofM2ebtQeZNemgVB0eDp+QPWy14nmQLY958tu5vEfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OODJZjutF506ZIDBIt5vOY8QkQREv7ARuXqS4XEy+0Y=;
 b=gSnJwAHMFYnvRo/b0nG2HTWEoe3ZLD+TMzPa9eBfKPbVDF4ti9/7bZmsuuVeMphppFA3kpBLaHOZl5tIewPSdwqY5/yaifLvpYT+AAQs7+rGDwcEtjLLMzos3gTvhHLlb7eFJOVXb/d4swPghGS0NW8ffbUmejs1xJ72r9SrghE=
Received: from TYRPR01MB15619.jpnprd01.prod.outlook.com
 (2603:1096:405:29b::10) by TYYPR01MB12304.jpnprd01.prod.outlook.com
 (2603:1096:405:fb::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 17:07:01 +0000
Received: from TYRPR01MB15619.jpnprd01.prod.outlook.com
 ([fe80::a68f:5c9:9de8:4fa4]) by TYRPR01MB15619.jpnprd01.prod.outlook.com
 ([fe80::a68f:5c9:9de8:4fa4%5]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 17:07:01 +0000
From: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: RE: [cip-dev] [PATCH 6.12.y-cip 00/17] Add RSPI support for RZ/T2H
 and RZ/N2H
Thread-Topic: [cip-dev] [PATCH 6.12.y-cip 00/17] Add RSPI support for RZ/T2H
 and RZ/N2H
Thread-Index: AQHcrYq0SPyPaqomcEmiM2IminkmbbWhu8Gw
Date: Fri, 6 Mar 2026 17:07:01 +0000
Message-ID: 
 <TYRPR01MB15619BCE50B3E347A1DC7A5DF857AA@TYRPR01MB15619.jpnprd01.prod.outlook.com>
References: <189A4F21D47A489D.1967085@lists.cip-project.org>
In-Reply-To: <189A4F21D47A489D.1967085@lists.cip-project.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYRPR01MB15619:EE_|TYYPR01MB12304:EE_
x-ms-office365-filtering-correlation-id: 23819f1a-6f4d-4160-d957-08de7ba2c897
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|7053199007;
x-microsoft-antispam-message-info: 
 pmWnA4IUCdF/xOpTiXYZ//oIfBMyhCCFIT5tY1H8qMZLIiQNLW/a5bwzm1xLcDErXq/tY4UynQIiWgeksR52w2bYpfFMpglPKhfDl4lWIYR/PAtnAuth5rUTVThmqOWmokUe/3NQ/Sra79h5y0u77coiZhzMEMFEvGapkbTAiLJgNuMkXqS9bAW6HWIuqiRhQcQWlZeeFhsNr1PXbuDMTKZmOkQejM/afI7JmAHK1ZJpc+c+O67RAhUiEb8KXmwXvWqNrKq3k/uSNg6ObiBsssSY/cFWq5n8fWXJs+6f5BLdlSGEcdOnlts2/uW083SfB1It2tWaNSTnR//+B/bjn4FYV6saIHzYbvr6kkYEL2MamHC/bR9bH0ZaB+k9S7EserfgTAUQpfhxu+j8yXklAkrdKRbyuIzWEaW7yvxLECZBJCRzZKJR1Bm5NiGxFwJ0Q3NGUULLyEBIuwMIPgIwDblz1NM+uPHms9exV7HcLVDlHvweO2AbWwR3H7b0/GhTGaLkMsdp54f2nxgIg6JZOwo8oGSe0M0UWn0sxxSc9zh5uGWOtQOo52rlMs12WIyYby8MBHxgIjStG+kFmdmSuzIo0r220PaB/4NJij8zwvtMbcQAIEB9zEfzWeKGHRrU4Ird4o4fzmNxG/JLu570Os8BSll5BoAg0HmhrdEa8GRAwsun+YQdOpsHwm2Le9A7+tYffFxOUqz1Ud4kXtCsmm2KELfk6jcJ35N0g3N1DIgamvCY5I1mwY83VDJ589ICCp2vj6bUg3XPhaWvIWoUKVi1nmF5Sg+BNl6+Y47/skM=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB15619.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?0ob3qZLFh1AvH532r8HTNO7pFORCQ6SPP6dlHfzDdut+ud8vSUYJo2Ej7bQQ?=
 =?us-ascii?Q?+6k8mU/NsOcq5hkCTwoE/pvkkstfS56AxVpiwo8YirEEMSTLZEZpEphc/OQT?=
 =?us-ascii?Q?57CBtICHFFGK2IXptVvixmY9QZkGGZas0MekxNfiDu4kgwjCMMXBA1gylmnz?=
 =?us-ascii?Q?3mWwR99n4pFOAPdKuEbQ9asbrMdV8cuA5MMdkMIn+skMqbwBZi6x5NnEUBJa?=
 =?us-ascii?Q?9g4CspFwZ2ivcjzaX8eKHXLUJBLvMJfHhC6TEFeXdoaLtckGro4Gg63VpXT+?=
 =?us-ascii?Q?xKMNvgFPhbeGS+D0gTjptaHpbJ4z2cGV2+SvzqppyetJVx/WIth8hAbvnIsY?=
 =?us-ascii?Q?ss6nz4UPBMF9k777WxeyZLxAJ/1tcaaX7VwKMtkopZVh0lLy2qfwEaGLhen7?=
 =?us-ascii?Q?+axlvvMztoidcF0UHCl6IS/WzmlDH17fj67FWjAqaDarETlcAYTOfx+Fn1Bi?=
 =?us-ascii?Q?UQucyhdtHllG2rFGN3w01U5PflJjpawdhj/oUeX8colfRPupTfZq0jZziqa0?=
 =?us-ascii?Q?vc1WqKnr289Cj3I+qv9SQQA5dhQxF2V8+K64X2Kz3GVlnQTUxTGvMFOyxjLz?=
 =?us-ascii?Q?9CCwknffTOdmu1bTPpJZsm+amK6y7xSXay+VWUxOSd7mvSiPem9DlhdxSGSw?=
 =?us-ascii?Q?RIiNOAXL6KVnUvb/eV8Ab54dAA33pijwPk0V69xSufxMNIl8Pja/XT0StOEH?=
 =?us-ascii?Q?RChsoaQchC2hd2ojzBoC83qlS0AYFCq+at5Gw6GFEeC4orCdbArhMXLr1Y+6?=
 =?us-ascii?Q?cuzIesC5XwcCnq3kamp1rY0ZuZJBI094gWyb+7RRDqhadCfu9kNAeceA3Xqa?=
 =?us-ascii?Q?NYSSNXDaAvfa4JD6RUo1G3q8HnK8X5lWXH4Q1YLhYIT5bPFAZMf6NAI+PzzL?=
 =?us-ascii?Q?JrOyCnSjqyypfYFdeKhXH6qyPISavUcM8Ne3NR3oDGO6ZXnivd+SGZPii/Mt?=
 =?us-ascii?Q?j8KAkrJ0ukppeW31S1ad34JU5kx1ua3lt76upjW+HPXloHEl/aCyhqtO09zh?=
 =?us-ascii?Q?0UG9Wep+mL+9hfhb9Kucx2cfgnFWHKa2O+/cWw6HV8FXzPQv6YfJvd4Axfzj?=
 =?us-ascii?Q?iz3g/nk9BoHq5gDl5pln97x7Z+CM06VFsN1BcLnc8Q1YRylX2m5E9p5wDolZ?=
 =?us-ascii?Q?p+iuWaXZa1C/ZxTY2df0m5+I43lgk69AbOVHl06q4xgIaIEainK09DAHVLIv?=
 =?us-ascii?Q?nGjiFHUcHLTQs9tHUsGgnM2wLPhf0VGDZN0H/QqHziuipPB5RG0jwqcn5B+W?=
 =?us-ascii?Q?KyOUCRN8GmEcLpnFF9zTqswSsmWh3GbiGwkYdQ4qdhmIvLac/ZwVd341Tccy?=
 =?us-ascii?Q?owfVnQBlJQ88o/t8+6sr75wFBSrPkcBCa04OwI1DvrErY5Uh+1ti+XzaZXD9?=
 =?us-ascii?Q?2Ec4zSBmpOnD7Ibmviaxn/luN0lw2XNioteTO7ZU1jbGvguj07iPyKUYOjS4?=
 =?us-ascii?Q?TV7579wmTRP4L6No6//yR0U/vwjBz+bO2MwowTN9IsR/UgiHeHo0RpuHqvMe?=
 =?us-ascii?Q?kAb5d9OYy2hjoFtcLv45WpwsxXUKFLQEFvlulNn3/Q5FIJc1P04XsEps1WHE?=
 =?us-ascii?Q?eG9O0LPHLE4ya5lhoi2rh9cSFwMIqJy7DCGYAMuB/CQpeSXy9VHs5QIMNzf2?=
 =?us-ascii?Q?xUBquDsb2uJYZlO2zFh0fe1au23dOaOwSBc4lDhRDCRVVLwhXeB+qmL2yxe7?=
 =?us-ascii?Q?t4NIGhyHeloj+x7lc/SgMe7TeWXru9XHH+9HkavTzYSJgHPQZh7RZ8yRi9X1?=
 =?us-ascii?Q?Qjv4c0tJwtAo5FyF86fFdNnQsCnnVP6XeZ9Tamyh2yt7p7SUeDCY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB15619.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23819f1a-6f4d-4160-d957-08de7ba2c897
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2026 17:07:01.3456
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8z/LQcg8M1cuiPxx+nLDJxHbqLzr/XJ6t6izmHP+tGjXDL4j5nQ8XSGi1G9gg+tdKcQMx2r1JQ0QqjnhcibrdZUg+NyN9OkKlY1889LgVXgIsh5H3gRgWS9wd7ryX5zk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB12304
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 06 Mar 2026 17:07:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22124

Please disregard this series.

I forgot internal Reviewed-by tags on the patches.

I will send V2 without them.

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Cosmin Tanislav via
> lists.cip-project.org
> Sent: Friday, March 6, 2026 6:59 PM
>
> This series adds RSPI support for the Renesas RZ/T2H (R9A09G077) and
> RZ/N2H (R9A09G087) SoCs.
>
> RZ/T2H and RZ/N2H support is implemented as part of the RZ/V2H RSPI
> driver, and, as such, the RZ/V2H RSPI driver had to be backported.
>
> Patches were cherry-picked from upstream kernel.
>
> This series applies on top of my previously submitted series [1] (to
> avoid a conflict in drivers/clk/renesas/r9a09g077-cpg.c mainly).
>
> [1]:
> https://patchwork.kernel.org/project/cip
> -dev%2Fcover%2F20260303165351.914437-1-cosmin-
> gabriel.tanislav.xa%40renesas.com%2F&data=3D05%7C02%7Ccosmin-
> gabriel.tanislav.xa%40renesas.com%7C6f945845bba64a25ade008de7ba1d46e%7C53=
d82571da1947e49cb4625a166a4a2
> a%7C0%7C0%7C639084132155199464%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOn=
RydWUsIlYiOiIwLjAuMDAwMCIsIlA
> iOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DrtUD1q=
73VhE%2FdD%2B1XBvLJaYzI2MoNIG%2
> FQLdoJK4JUZU%3D&reserved=3D0
>
> Cosmin Tanislav (14):
>   clk: renesas: r9a09g077: Add SPI module clocks
>   spi: rzv2h-rspi: make resets optional
>   spi: rzv2h-rspi: make FIFO size chip-specific
>   spi: rzv2h-rspi: make clocks chip-specific
>   spi: rzv2h-rspi: move register writes out of rzv2h_rspi_setup_clock()
>   spi: rzv2h-rspi: avoid recomputing transfer frequency
>   spi: rzv2h-rspi: make transfer clock rate finding chip-specific
>   spi: rzv2h-rspi: add support for using PCLK for transfer clock
>   spi: rzv2h-rspi: add support for variable transfer clock
>   spi: rzv2h-rspi: add support for loopback mode
>   spi: rzv2h-rspi: add support for RZ/T2H and RZ/N2H
>   spi: dt-bindings: renesas,rzv2h-rspi: document RZ/T2H and RZ/N2H
>   arm64: dts: renesas: r9a09g077: Add SPI nodes
>   arm64: dts: renesas: r9a09g087: Add SPI nodes
>
> Fabrizio Castro (3):
>   spi: dt-bindings: Document the RZ/V2H(P) RSPI
>   spi: Add driver for the RZ/V2H(P) RSPI IP
>   arm64: defconfig: Enable the RZ/V2H(P) RSPI driver
>
>  .../bindings/spi/renesas,rzv2h-rspi.yaml      | 138 ++++
>  arch/arm64/boot/dts/renesas/r9a09g077.dtsi    |  72 ++
>  arch/arm64/boot/dts/renesas/r9a09g087.dtsi    |  72 ++
>  arch/arm64/configs/defconfig                  |   1 +
>  drivers/clk/renesas/r9a09g077-cpg.c           |  22 +-
>  drivers/spi/Kconfig                           |   8 +
>  drivers/spi/Makefile                          |   1 +
>  drivers/spi/spi-rzv2h-rspi.c                  | 687 ++++++++++++++++++
>  8 files changed, 1000 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/renesas,rzv2h-r=
spi.yaml
>  create mode 100644 drivers/spi/spi-rzv2h-rspi.c
>
> --
> 2.53.0


