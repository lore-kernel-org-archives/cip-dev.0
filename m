Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5ECC433EF
	for <webhook@archiver.kernel.org>; Thu,  6 Jan 2022 10:53:46 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com
 (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.93])
 by mx.groups.io with SMTP id smtpd.web12.7031.1641466423949925959
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Jan 2022 02:53:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=BOGlNKfu;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.93,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jfDCzuxrFMTJGQDlmG1O17ce6qOSppfa7U54tUUTo7DC8a/bk8yezjgcZixWM6Ir/UEd1uB5trrqvgxFvbX+i7F5XAXZBWKb0VeNEjiVnsiaL+wxsRDaQJiW5VG7SBvffAfsIAh1tM+XIw2n0AlyKE1IHPMPKr31bGeBjMCkM/p0hRWUfMylIscYZGxLY1agObn2d65sjBb/M0LDi1D7J2/5OZI/guPYfTpberd61iW7NY6BeEU4qLkFK3eHvheEvaLMAhaq9bzOj1js3xSVus3NCRmdtj4QNXlvqvg2j8Z6NNSNA2sOx7MIsSwqUYlUmTibsfsI94IVZxZe5aBCow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQkhKJ3aZbbh6WTkEVZCIoRSJbW7eQaSTZemMxP0/v0=;
 b=hskGDEXblAUmAaiA5XkBaETdWJYOr1TpYuz5M0ci1UmSGz0XKOvnvZsMA6TKnz3HMucoi91vqg0pNF46ci8Bi/5DEi7hZGOsbHxuye+L7Y/Pu7mXjzbmM3vdJd4BcqVuXG6n/l6Z9mlnJv1M93FzRj09YBROVwg0tVCIZu3aIHfvLByG6vMcTGIzSBSAjyCZ4FZMuU9q8hqTjs1Z/oUMHu6BsV6JBoNDGKi15+4+VgffVbIqDeUm9hjb3SxMgdijBHkQeNy2GEH4ot51tEYCKxRlutLY8RhRVPw7gFzPjqOvXjdo4xom/ML4BWR+xK+259xdJD/9Bh7Z3VGgj6r6JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQkhKJ3aZbbh6WTkEVZCIoRSJbW7eQaSTZemMxP0/v0=;
 b=BOGlNKfu2vJbzLSQx+R5iSV0pVm21Q7zI5nVwAEVsoE6dsXt5teT4DhrlfOJmOwL2uxRrvjvoZAMIOpKswK9XjjASAvd+ujrZtzwKPQNrhWFp2cv+URLiZpXOzAMyH0aamKXXgNDFHxyVBPQ8D/HBcWFXioPk6jfpkL315lSQ4w=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by OSZPR01MB6815.jpnprd01.prod.outlook.com (2603:1096:604:137::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Thu, 6 Jan
 2022 10:53:39 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::2182:43e9:3f29:1b3e]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::2182:43e9:3f29:1b3e%6]) with mapi id 15.20.4844.016; Thu, 6 Jan 2022
 10:53:39 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH 5.10.y-cip 00/31] Add sound/adc support for
 RZ/G2L
Thread-Topic: [cip-dev] [PATCH 5.10.y-cip 00/31] Add sound/adc support for
 RZ/G2L
Thread-Index: AQHX/J0I4oLgBDGj5EGFNMhq9mDXE6xV3TJg
Date: Thu, 6 Jan 2022 10:53:39 +0000
Message-ID: 
 <OSZPR01MB701986387CEBA39F8BC4DAD5AA4C9@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <16C5324B2EFDDB95.12001@lists.cip-project.org>
In-Reply-To: <16C5324B2EFDDB95.12001@lists.cip-project.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: edeefdaf-0605-4c09-556c-08d9d102cc31
x-ms-traffictypediagnostic: OSZPR01MB6815:EE_
x-microsoft-antispam-prvs: 
 <OSZPR01MB68157FAF5174A54595E87178AA4C9@OSZPR01MB6815.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 ouo2wRs07y89wsOn/3WGMf4zw5HI+yap0JbWolnJmnmN4WMo20/ocCgjkyVgXAopICme7dKwrWSNd3He87djIJOqjCOlSClf491jN9bKn7Z4rVbTvwFa4yQDcMOSvTvWgOoqGjcPBYBG0Cq9jlfS4OOJKeElKdca6WTK2yMQv+mqysESMynNyBOnPFKQMZz4O4Fig+2VnkwEA6lF/J+MXc2cGLoFaAxYCCNzBX1CX9Y8E3jdweWlReFDPdFcYA7kmCIOYyyH4qEPIj6VbJPT1Mm1Swu+T6gbFbrIHhgjazAL0cEdm1sSLI+WbN2VA/AA0nI47DArymZWzbNcWaIqTFiVJW+VIwHDkNgYUha66XhhLo6IVQF/2IuvKrXxa65fq4CoztjYg2nTYwk5y/dsiuN9z7YVVxxPFvtGEkv1MAokWYh0TqmB/8AIGGtIQdvo38Caic2h0Wgd7xBAD99xYnsKDKoHWdSO6BqD+CfLrsIdrP42o6h79nN0F03ODreeapkyEUFMAoFI8rjNX0dF88cmV4c2IXe5wXheeixVrH0dM6y5dfeRpTPmNRBgmXUWgE+Ym7MwYD+E4J04F3VrH/gGice5BqkeKCJ+C1DN+soHbJReF3YH+46mYxaTxXOt+KOXpSmIvp9pZ6fgXCGRPYDnpbvhLzKopKE5x9RFGHv3ORr8k/zgSIffUeTcVbmh+aYmLylQehdmfu3eP1n6ElefrYZ9Nk2e+QaWixavV1oQsLLX4cryYbDg3ox3I02iO1xYEacSpXVCJ5z39nDNdigIh2Vn/fInfg7ip/0hMdk=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(107886003)(8936002)(83380400001)(508600001)(4326008)(5660300002)(966005)(38100700002)(71200400001)(53546011)(6506007)(38070700005)(66556008)(64756008)(76116006)(66476007)(66946007)(66446008)(7696005)(9686003)(186003)(45080400002)(8676002)(316002)(26005)(110136005)(52536014)(86362001)(122000001)(33656002)(2906002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?EtRSPP26LPk+uvCZ8vZKj3w0F0ImMDNvr0bw1N9U58cwq8Y/hGnhjyP3RqLd?=
 =?us-ascii?Q?BojIYl9S7rLz8yy50kxquJbcoVZeMvLIzBpEVVOawHCjrynaGmSxwLXjQbkg?=
 =?us-ascii?Q?MztI3tO4L3lFyOl+ekiLjZwh439DzR29cnDUBQKlGLcm9zsEgb37MdKQ3z1U?=
 =?us-ascii?Q?B+6ROQnB1nQFx5xt04kNeaa2G380tL7eNaP1dWqjVzzJLFxhG6ECjEPeapIq?=
 =?us-ascii?Q?UGdyFzMQJBDKZ2YHb16UPvmn+fGvuErsosOR7THqR0YpkoVPISdaP3i/n1yb?=
 =?us-ascii?Q?5IFMVR8ERFltp6si5aPcsD94zvZVQutnTl4TeI5DPhO7BQMTQKAgU2ElFCMk?=
 =?us-ascii?Q?5Vlv8vHr3ZKNyiBq7oJfOMCAoABNe4ifawrdx4itlVyaxcqWtftpMcTmScL6?=
 =?us-ascii?Q?64Yy34oAM/uqJKPFAXnvzev+IaqaoZjDgirSUXZWqMR8ldZlu7oR+bUXAV75?=
 =?us-ascii?Q?wL8ufJLFr8jQOe+yRVIaCCjgiUk1ySLrHskeh2xWjoljZT2Hs+FS0XQ/3+ay?=
 =?us-ascii?Q?QEgYsAyZcxIfkPO1L5FTyUCKP1GzXF4qaYLNyq/diKFI6+zGjDgCFuJHHLs0?=
 =?us-ascii?Q?JxxiAFo03UMjYjiwmHtL1rdwxiitpPkJj9fGgvYC78eSxZsgqCe7Vsdvjso/?=
 =?us-ascii?Q?lrJQ3P55ChFSfQ/MrdSGA0tEVNbS57SaTouQQ/g3UM8NW9Ua4QZFdbTCm3fx?=
 =?us-ascii?Q?0+uoDWeY48pSwShm7jSD8s7ljCL1S/KSLVx8eSGdLifB8tsb1mYVBpOzmsPO?=
 =?us-ascii?Q?SQ9wY9JNB7ze2cYzsxmMqTpy26Iy6fPsr1aKbNvnuJCMGfmYt/Sk8eKzjsHr?=
 =?us-ascii?Q?qASp9UVZM5wFL5O70ZErQ/ljIeItCDG11+wgyMZtNec8N6yn3PN9eN0xKDD+?=
 =?us-ascii?Q?Eyf8WJml/H3CufCk/4SOtr/W//gjFmQYNaob18hJLbfgz9yNqACFxQ83f0zI?=
 =?us-ascii?Q?zE/8rHILFyXKkMPO2SfFQvO2ngtitkYMAzHyomUFFsHebYZMtPIxlrE+2PoB?=
 =?us-ascii?Q?rikoYfo6xgoIf6hLINBxPDfQ0tvo3KOXTYOC9uoIhaaxKp5PlZ+LDtlQbz7z?=
 =?us-ascii?Q?5od32j4WV2IVe5zi4aphpwJRNukFyQEGVVMcD9Olkt5I5fcSnWkkck6F0D+C?=
 =?us-ascii?Q?ZGYMHQUlqc1n93pKjyaJkvowzi4M/d/h1x8Jxh8w5TQXlIG6GC6YbXqySHsB?=
 =?us-ascii?Q?jTeBc0QYifcOHt6/Kk6BJLJzyaC9lx6ddqsQOORBCr+xcwLoQA7e7HFyNvZq?=
 =?us-ascii?Q?cR3M9qaYbTWWr2ri0UpPodgz6gJyao1U8qNOLxW3XpQtrLlPlPi/z13OHBDf?=
 =?us-ascii?Q?D2pzaiqmA+MOd/DDoAv518qIMjw2Xe2+6hcNCbo5DPf2dqPi5cqPjZSoz/W9?=
 =?us-ascii?Q?WXrf7CnNF7BQ7bkSJAs9bxHiX1VuUJUjMEEBBbGzxaYhMaB6Op/ex9YCB7oZ?=
 =?us-ascii?Q?kpIn0r3A4/fEjFB9ORCDz8Xzj+od2kJ7fUkiu+Yvj1jQyXnbmSZw/Dl1IXWJ?=
 =?us-ascii?Q?3ZWTj4tWzcttrW6oncZsNMZViC/gk0y9RMp63ydSxF16XO/1llV7PIJ5qzAc?=
 =?us-ascii?Q?TRdFP0E73GlNZhwof2br5BZlZ0OPLqVA7Qtsf2NKaexqaQHfAoJsuQc2Rk/m?=
 =?us-ascii?Q?eEFR2JXrIQptuOJ6NTl85xx0M8Vhj4wRQTHIc9f2gEwu346T/UfZl4bZ1j0j?=
 =?us-ascii?Q?jezOzs5wJfZKSLVt8wICNygRu7f2KtnkZA3kIMNWLaFIxM9fNhHHOXmqoVYm?=
 =?us-ascii?Q?HahdGirNpw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 edeefdaf-0605-4c09-556c-08d9d102cc31
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2022 10:53:39.4623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 zLakUFCA8vySphpNF8L8Aejv8mnLGr+CI7oZY6PV1jh9fOt++M7uV0fkDg7YUa5tID1N1Uh7Uc/6z90MVeGLZoKDR8fZfnaU5/uE36T03SoNh/11kfdK6kt7blA85atE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6815
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Jan 2022 10:53:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7325

Hi Pavel,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Lad Prabhakar via
> lists.cip-project.org
> Sent: 29 December 2021 10:15
> To: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>
> Subject: [cip-dev] [PATCH 5.10.y-cip 00/31] Add sound/adc support for RZ/=
G2L
>=20
> Hi All,
>=20
> This patch series adds Sound and ADC support for Renesas RZ/G2L SoC and e=
nables RIIC/SOUND/CANFD/ADC
> on Renesas SMARC EVK.
>=20
> I have also included the missing driver patch for riic and kernel configs=
.
>=20
> All the patches have been cherry picked from v5.16-rc7.
>
Do you want me to separate out audio related patches and just send the ADC =
for now until the audio patch comments are resolved/fixed?

Cheers,
Prabhakar
=20
> I have created a MR [0] for cip-kernel-config to support build testing an=
d can be merged once this
> patch series is accepted.
>=20
> [0] https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fg=
itlab.com%2Fcip-project%2Fcip-
> kernel%2Fcip-kernel-config%2F-%2Fmerge_requests%2F55&amp;data=3D04%7C01%7=
Cprabhakar.mahadev-
> lad.rj%40bp.renesas.com%7C448a426ec06a400fd7ee08d9cab42a09%7C53d82571da19=
47e49cb4625a166a4a2a%7C0%7C0%
> 7C637763697420828810%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi=
V2luMzIiLCJBTiI6Ik1haWwiLCJXV
> CI6Mn0%3D%7C3000&amp;sdata=3DT6OVaoV3tgK9UsAYD7ZeT%2FwjVctGGJM3Hja2V%2BBd=
5mU%3D&amp;reserved=3D0
>=20
> Cheers,
> Prabhakar
>=20
> Biju Das (21):
>   ASoC: dt-bindings: Document RZ/G2L bindings
>   ASoC: dt-bindings: sound: renesas,rz-ssi: Document DMA support
>   ASoC: sh: Add RZ/G2L SSIF-2 driver
>   ASoC: dt-bindings: renesas,rz-ssi: Update slave dma channel
>     configuration parameter
>   ASoC: sh: rz-ssi: Add SSI DMAC support
>   ASoC: sh: rz-ssi: Fix dereference of noderef expression warning
>   ASoC: sh: rz-ssi: Fix wrong operator used issue
>   ASoC: sh: rz-ssi: Improve error handling in rz_ssi_dma_request
>     function
>   clk: renesas: r9a07g044: Add SSIF-2 clock and reset entries
>   arm64: dts: renesas: r9a07g044: Add external audio clock nodes
>   arm64: dts: renesas: r9a07g044: Add SSI support
>   arm64: dts: renesas: r9a07g044: Add DMA support to SSI
>   arm64: dts: renesas: rzg2l-smarc: Enable I2C{0,1,3} support
>   arm64: dts: renesas: rzg2l-smarc: Add WM8978 sound codec
>   arm64: dts: renesas: rzg2l-smarc: Enable audio
>   arm64: dts: renesas: rzg2l-smarc: Add Mic routing
>   arm64: defconfig: Enable SOUND_SOC_RZ
>   arm64: defconfig: Enable SND_SOC_WM8978
>   clk: renesas: r9a07g044: Mark IA55_CLK and DMAC_ACLK critical
>   i2c: riic: Add RZ/G2L support
>   arm64: defconfig: Enable RIIC
>=20
> Colin Ian King (1):
>   iio: adc: rzg2l_adc: Fix -EBUSY timeout error return
>=20
> Lad Prabhakar (8):
>   dt-bindings: iio: adc: Add binding documentation for Renesas RZ/G2L
>     A/D converter
>   iio: adc: Add driver for Renesas RZ/G2L A/D converter
>   clk: renesas: r9a07g044: Add clock and reset entries for ADC
>   arm64: dts: renesas: r9a07g044: Add ADC node
>   arm64: dts: renesas: rzg2l-smarc-som: Move extal and memory nodes to
>     SOM DTSI
>   arm64: dts: renesas: rzg2l-smarc-som: Enable ADC on SMARC platform
>   arm64: dts: renesas: rzg2l-smarc: Enable CANFD
>   arm64: defconfig: Enable RZG2L_ADC
>=20
> Yang Yingliang (1):
>   iio: adc: rzg2l_adc: add missing clk_disable_unprepare() in
>     rzg2l_adc_pm_runtime_resume()
>=20
>  .../bindings/iio/adc/renesas,rzg2l-adc.yaml   |  134 ++
>  .../bindings/sound/renesas,rz-ssi.yaml        |  118 ++
>  MAINTAINERS                                   |    8 +
>  arch/arm64/boot/dts/renesas/r9a07g044.dtsi    |  140 +++
>  .../boot/dts/renesas/r9a07g044l2-smarc.dts    |    7 +-
>  .../boot/dts/renesas/rzg2l-smarc-som.dtsi     |   35 +
>  arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi  |  162 ++-
>  arch/arm64/configs/defconfig                  |    4 +
>  drivers/clk/renesas/r9a07g044-cpg.c           |   28 +
>  drivers/i2c/busses/i2c-riic.c                 |   23 +-
>  drivers/iio/adc/Kconfig                       |   10 +
>  drivers/iio/adc/Makefile                      |    1 +
>  drivers/iio/adc/rzg2l_adc.c                   |  591 +++++++++
>  sound/soc/sh/Kconfig                          |    6 +
>  sound/soc/sh/Makefile                         |    4 +
>  sound/soc/sh/rz-ssi.c                         | 1074 +++++++++++++++++
>  16 files changed, 2334 insertions(+), 11 deletions(-)  create mode 10064=
4
> Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
>  create mode 100644 Documentation/devicetree/bindings/sound/renesas,rz-ss=
i.yaml
>  create mode 100644 arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi
>  create mode 100644 drivers/iio/adc/rzg2l_adc.c  create mode 100644 sound=
/soc/sh/rz-ssi.c
>=20
> --
> 2.17.1


