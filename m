Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92448109E559
	for <webhook@archiver.kernel.org>; Thu, 26 Mar 2026 06:45:49 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.42344.1774507535371150100
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Mar 2026 23:45:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=sOqh4Saa;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.47, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M4qPYQYmaac5qchJiYXAUkofIL8cgqN4WkkXtylLv9AhEboaU8fl5PlV+AEw+SgxXvkCKI3hyKb3W+EPKD2SGhZZfbay7/LdjH7OngqIH+HMx5U96HojseB6Df0g/SybySkh5ICWbMfpEx1k4rtMy8M2N9CYUZbKn/v5gtVtdtYhcEQlPQV2Y9f1dztKhSprX8pxizQ0hC3bW7L8SNdvhE85NH21lQgVngMgYLaCmCwiPbUvhNpZlSh1zh0ozlceQQ1DrCvjdeBy4Vc55VNzinDFIrz45qbmc3+GVXCH/IDRz5/dx63oxOXgAHpdW9zTqvNJRBe16dESxtiB6gLr2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NLNsYUdiurrA6ZBoRY1jUkq8HfyLQ1Ls/ATyVKg4a0Y=;
 b=vlbtVW4tSbuwfMUVOwThXmiIKS2qFVouPb09SoK4hXrmIqeDEkNrlfE29YHO9vsizt8rp28Zl99OFztuHta/aGkFghyee8XOU2Bj7YZ9ZF9NFOA7amikPYHhvkV0eWFq6a3NXORMCdCpqj+W4G+dWQc3NOko3RIwA0xmowcd+wihcMf5LzfHsM70GZKgTfOh3SW7LU5iz7LiWDDu3pi/ZE9g09ObjEcQ48CmjAratYJaFZmkT42q1kL2n3TRO1tgp6BJ0gtDbKa2uUvSRA7/BAFh05BCXHiZvvbrkxx5ZGv2U4cn9HUGl5opCokl+gTaI0k5SGAeSm6GA7UgT1eifQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NLNsYUdiurrA6ZBoRY1jUkq8HfyLQ1Ls/ATyVKg4a0Y=;
 b=sOqh4SaaJITZ/Z4rv8k5iF1Q7g0k1IYtpbDV6xgcBwvYSe2jNyPRq1l5SOaIAU96XFWDw+gAFK71LcvPl7syk4hImrv5jwXlwlwAT6szj7kalDdVjAq3btDCun1R/MAWOREwe2vbHzym7+F87904lR2FQt/gcxBkS0ZQB7/Xw18=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY4PR01MB15806.jpnprd01.prod.outlook.com (2603:1096:405:2bb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 06:45:30 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.20.9745.022; Thu, 26 Mar 2026
 06:45:30 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: biju.das.au <biju.das.au@gmail.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>, Nobuhiro Iwamatsu
	<nobuhiro.iwamatsu.x90@mail.toshiba>, Pavel Machek <pavel@nabladev.com>
CC: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 00/11] Add Renesas RZ/G3E USB3.2 Gen1 Host
 Controller support
Thread-Topic: [PATCH 6.1.y-cip 00/11] Add Renesas RZ/G3E USB3.2 Gen1 Host
 Controller support
Thread-Index: AQHctgJYUlQNzfO/IUqZ9vUAlLwRdLXAbDEA
Date: Thu, 26 Mar 2026 06:45:30 +0000
Message-ID: 
 <TY3PR01MB1134630E7C54053FF237A937F8656A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260317113643.311192-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20260317113643.311192-1-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY4PR01MB15806:EE_
x-ms-office365-filtering-correlation-id: c27a7ce1-e04f-4c4a-7620-08de8b0345f1
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: 
 D7P+gIqCLfq8pBl6c5vftRPrRrXjOEqPoT98KI/twK+BP5NCLrktqTlL8Z+lKp+uSGrY5WcuhBGXFOx/+rJeMwoCS687bujPcGco/S+E69zVr4Dd890AeMq+mOsdQC0k3xTuRuozO6Aed3uLJCn/idDRjYlj0r8LCV4AxH3mPCOefjcvAB7G4J9GwN7+fFv6lnclu1t3kwLgeiD0zV3rG3+X4+YBctX21bF2EQC2r8eyST0ORFhsVpPx9ZHbXeGp0rOYp+VSbObdLByJ8ETG9Plfnp+loTGOKSIIeOGitCP4l6hQqmDlwL8qxarl8A6CY5sYHski+TLivTw6YS6eMlkff2drikl791crPzNela65OBW48urjW7p8P2ZH5I8hJcKo7qIFi7ov12xyDe1RyP41rL6I2U8aKoXaWrQf2VVnvbQKcijZACGfWpdeZTGOnOD/m2gCl29ha9hXyXXnG3wSoU0hpZBgyQ0N7eSCn/YIRhaqBKxp65V3uGdnAEBktLlRAbFTo/qGMWwPHtoPVMGPqwCmxxYqqRgbDVocevQCZTEO1FgQUmAX6ZjINpDB79MEeQgRiaqp+w36QLRGOYTRoytaCj0e8ylQ0DZIMxJo9kyW+IAmzHGIgbQBnh4EvZtMdLTgQ9o28aTJrDmx4tVb0dYNzHM7jlxVNyswl+Y+KMmGTlfVkuEBrF5QHv+91vPPe1tidNTmF1aARi3fz1EScWMlK5kilWEwc8tLh38HuoYV1d8iedaaNrRUOL/4OvKJqFvHMOVoFo4O/lEMeBFs3w8AK2ledhUHeeUh0jE=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?MNDSQ29eZogRWbaqpGQHT2uIZOVIm1xOQuvf6XKQvMitaLP6c/P3ZH0985wv?=
 =?us-ascii?Q?tEZIiiARqtUnNGF0jroualFjMFad8P6ZViBWKrluigtyPDLGiz0sHEeJCTiD?=
 =?us-ascii?Q?umTqEiibYT6Gh+f5Cc7srta3ybzzjrnQJL+ulSGRAuXh08loChv2dWAl0jQ7?=
 =?us-ascii?Q?Rh1x0OdTB9wYOQVZ0RWHUfEgV1FQlbDV4Y9AVrXHNfJFfRIDQnWbcS8/hiUX?=
 =?us-ascii?Q?OAh2XrEQhWMX1KJPUDTiqCvwDzN4JN1cKpC5lHG4d/QdYG+8I8ez0/M7kvNz?=
 =?us-ascii?Q?lp0/l/7pWZ4XKVWc7i77Wk19WiE9YBzvJbvpRq9vmDS4vlzL8f23JQuOg1RG?=
 =?us-ascii?Q?+SwnUb6fNMBh0rX5nsTOKehUS8Jt8gGx1qWnmSY+AP/CQdtTZaAQck9jL4Su?=
 =?us-ascii?Q?y8sUF9aV4K4dEpE4C26UefTAxF8Nn+RkWFz6FCsUVCWtKLgCMhBYIgVcB3E9?=
 =?us-ascii?Q?cvlkYfk1z0BkQJZquZn4yGYnVpfYyae1Q0F6L2injkcHc+0ReVMHxvDZhv8C?=
 =?us-ascii?Q?I7OM3rdldGvvOeT8JDXHqFudGCvbF1xjlrI5hw2WcKkmwfcFnvZwvOlxJokE?=
 =?us-ascii?Q?T0BZtP7phOlSahkkhkW5xi4H4kBwkVgrivnI+biPKHdrlk4u6j9ae/398SJE?=
 =?us-ascii?Q?9uvaCl/k6C+wN3jfCnsDZZKBx9Q9a8mGOM0DVgQrA0doqoZCbez8ygAr5acN?=
 =?us-ascii?Q?8bNrGcwMoFy7zBadbjb1U53IN5fINYIcJsm0EJlnWkoFps8pyWFCuPo13SgZ?=
 =?us-ascii?Q?5O9zKFjW2FMXXvNxh3s8j8ZA9CaxdMbg5Yz/jUMTycKEORa7OUMZmPMUuXAi?=
 =?us-ascii?Q?GBEENCiCCfdWou/jY81cExFY2gObOrkfAZanTZjNlwcEbbkPaoIXuUeipYna?=
 =?us-ascii?Q?9GiBgCdLgtqaQJXXT54SNkwF79nSYWtYx6SxSS4hWsXtQvShtorlmsXu+jeT?=
 =?us-ascii?Q?+4afunNI9StS0dD8sh5HFOqdsmvIZklIbdlSJ6IYiAfpAbgkn0VjMD4E+G1O?=
 =?us-ascii?Q?8D6ZbVBW7hI6X3HkQEJL/Y3Bs1NJ1jbVmxgeEaFOcsOPkfawZkqH2tJYRUOO?=
 =?us-ascii?Q?+o7qUC4GokWqd99H3BfAoRxahXqFTuFdZE7++w+j5S5MPZS9NQQBkPWNmc18?=
 =?us-ascii?Q?F+vb82Mdjgc42RX/T0OhorioZTIowAb2FTRuTakU+946VwFHuw62Im05UZJR?=
 =?us-ascii?Q?u+/Pa/GoQ7uPsJt9b4LboREfrjPom4bSG/gxF3at6tcgUeDqQs4asL5AZDXr?=
 =?us-ascii?Q?FTuPjzJ+GKCttZaYjdfxgpKhddnLyIk9HqP2Ijy6ePvvRfKO/UWEbOjfaYuE?=
 =?us-ascii?Q?tTfx324oSAj6KqUKH/xEeIDVuDu49NN/R0zYmENvFrpxFnVyXquWxmS0dYix?=
 =?us-ascii?Q?TynQJqs2bzmXTxQvwE2vb+CAYKOhSRSSZ2oyYL6krcF906lCiXIXwYGAJhWp?=
 =?us-ascii?Q?czTIbrg/7Y2NjyqVxyCf1aAsHmUq84XtNq1mKdEQ3tD4LKfZayZcMAHiUcRl?=
 =?us-ascii?Q?7I5mY7RqJ+CJJzsdvknWqvw+nZmcPdRHvDjNa9sHsTwejyoy+NtQByQypPDw?=
 =?us-ascii?Q?J0C5//tSqK/Lb3vXEZMX9vkGE+f+iVtDhCjgi13K/QdvZxzTIjOtpKZzzSZy?=
 =?us-ascii?Q?W340c5cEB7Vsh/YaGZJY3j4PB37ukQzNHWcYFKLH38TZER17pIgMpCDtzd3r?=
 =?us-ascii?Q?IoNI1TBM0TLI6kjxZBmjKFVypI8uKsGQzwaWmI7g8OlsLBD4OvxAoRXIMNEt?=
 =?us-ascii?Q?TJqbS+os7Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c27a7ce1-e04f-4c4a-7620-08de8b0345f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2026 06:45:30.7722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZWebo8hDlkd6tI4RxnipsxVdYI37vvraoGw6FfIVn5aPIQWvFROZ29s1crP88Ou/HhcW4oQRhQ4LM0/y6BMY22dgO7X8dFaFKn5Jiz+BHAo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB15806
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Mar 2026 06:45:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22577

Hi All,

Gentle ping.

Cheers,
Biju

> -----Original Message-----
> From: Biju <biju.das.au@gmail.com>
> Sent: 17 March 2026 11:36
> To: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x=
90@mail.toshiba>; Pavel
> Machek <pavel@nabladev.com>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Prabhakar Mahadev Lad <prabhak=
ar.mahadev-
> lad.rj@bp.renesas.com>
> Subject: [PATCH 6.1.y-cip 00/11] Add Renesas RZ/G3E USB3.2 Gen1 Host Cont=
roller support
>=20
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> Hi All,
>=20
> Add Renesas RZ/G3E USB3.2 Gen1 Host Controller and PHY support. The
> USB3 HOST is compliant with the Universal Serial Bus 3.2 Specification Re=
vision 1.0.
>  - Supports 1 downstream USB receptacles
>      - Number of SSP Gen2 or SS ports: 1
>      - Number of HS or FS or LS ports: 1
>  - Supports Super Speed Plus Gen2x1 (10 Gbps), Super Speed (5 Gbps),
>    High Speed (480 Mbps), Full Speed (12Mbps), and Low Speed (1.5 Mbps).
>  - Supports all transfer-types: Control, Bulk, Interrupt, Isochronous, an=
d
>    these split-transactions.
>  - Supports Power Control and Over Current Detection.
>=20
> Replaced devm_reset_control_get_shared_deasserted() with
> devm_reset_control_get_shared() + reset_control_deassert() +
> devm_add_action_or_reset()
>=20
> Biju Das (11):
>   dt-bindings: clock: renesas,r9a09g047-cpg: Add USB3.0 core clocks
>   clk: renesas: r9a09g047: Add USB3.0 clocks/resets
>   dt-bindings: usb: Document Renesas RZ/G3E USB3HOST
>   usb: host: xhci-rcar: Move R-Car reg definitions
>   usb: host: xhci-plat: Add .post_resume_quirk for struct xhci_plat_priv
>   usb: host: xhci-rcar: Add Renesas RZ/G3E USB3 Host driver support
>   dt-bindings: phy: renesas: Document Renesas RZ/G3E USB3.0 PHY
>   phy: renesas: Add Renesas RZ/G3E USB3.0 PHY driver
>   arm64: dts: renesas: r9a09g047: Add USB3 PHY/Host nodes
>   arm64: dts: renesas: r9a09g047e57-smarc: Enable USB3HOST
>   arm64: defconfig: Enable RZ/G3E USB3 PHY driver
>=20
>  .../bindings/phy/renesas,rzg3e-usb3-phy.yaml  |  63 ++++
>  .../bindings/usb/renesas,rzg3e-xhci.yaml      |  87 ++++++
>  arch/arm64/boot/dts/renesas/r9a09g047.dtsi    |  30 ++
>  .../boot/dts/renesas/r9a09g047e57-smarc.dts   |  10 +
>  .../boot/dts/renesas/renesas-smarc2.dtsi      |   8 +
>  arch/arm64/configs/defconfig                  |   1 +
>  drivers/clk/renesas/r9a09g047-cpg.c           |   9 +-
>  drivers/phy/renesas/Kconfig                   |   7 +
>  drivers/phy/renesas/Makefile                  |   1 +
>  drivers/phy/renesas/phy-rzg3e-usb3.c          | 273 ++++++++++++++++++
>  drivers/usb/host/Kconfig                      |   2 +-
>  drivers/usb/host/xhci-plat.c                  |  14 +
>  drivers/usb/host/xhci-plat.h                  |   1 +
>  drivers/usb/host/xhci-rcar-regs.h             |  49 ++++
>  drivers/usb/host/xhci-rcar.c                  | 100 ++++---
>  drivers/usb/host/xhci-rzg3e-regs.h            |  12 +
>  .../dt-bindings/clock/renesas,r9a09g047-cpg.h |   2 +
>  17 files changed, 623 insertions(+), 46 deletions(-)  create mode 100644
> Documentation/devicetree/bindings/phy/renesas,rzg3e-usb3-phy.yaml
>  create mode 100644 Documentation/devicetree/bindings/usb/renesas,rzg3e-x=
hci.yaml
>  create mode 100644 drivers/phy/renesas/phy-rzg3e-usb3.c
>  create mode 100644 drivers/usb/host/xhci-rcar-regs.h  create mode 100644=
 drivers/usb/host/xhci-rzg3e-
> regs.h
>=20
> --
> 2.43.0


