X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.118])
 by mx.groups.io with SMTP id smtpd.web11.7201.1641466868753324431
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Jan 2022 03:01:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=AfMHaaxs;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.118, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iCZFM6tAiXFlYh0SXNuS5zli4S3k3v71E78TBMAlRAt4RlbGoqdzLMbYGg4NX/G/9OC9SrVlXpspU32aWoePLc4uBzskNobvkAmNUUK4o3FkRAUZq/GyAzdqyzQhLMVl0xy1tB2On8SJegQFgykSMd9tmGWveY61O9+YbRgDX3Db/HvPc8MhS3QoMI/UQn+Sy5MzBRPb1uPFQg+JqVhPyONQPK4e5At0K/eqGqf23kRaVssZxnva8ba62TxdO32K9nG++0XBSx5ofq/oh4bYzxBchHkTE9DLuxeiGluJzhRLZ45SduwfVpqiYDrg1C9iGDTOFh+BK/QX5wddPZ/L1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mVghxpK2Br3XgS2QWyxg/uD4yOCvbxDo0zJNQEKzJYI=;
 b=VHxdn8egVNvnd01k7hsp3QkxqXnVrD/pWJ2WuZf0l3qPUtV4sh3g2hMnrFKHCzwLjyHFeCfpISxi7yb4yro92pHo/6/iV+qBsOzD2nXG6w6gH46dvli9+PcJJDLwXzRpJQZRR2RUBteagcKEq6eEPkbn755tLxx+BexpEz7FKQgdsKwSMHtG/ImcwVghxWVo8gHntiSMZUDfGy7fTa2yv/hWieoGy6fNX3I2pMmhoBVHG6HR6kT8W54cxvnBxITBymj8uG+oD9tCwQHfswvurjPWbGix1A47ISfCkrRHEXIvp8nGXitCNzrvFkzukJwhVyW/YKh/9BErCb7uTc4ONw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVghxpK2Br3XgS2QWyxg/uD4yOCvbxDo0zJNQEKzJYI=;
 b=AfMHaaxsxE7aHI2PCicJeiHztUJDsuCj9uJOj/7Z7VKTv/ID1yKzgIFbDewW1gTUu+5j/1IcybYhEsGNkFhbHxkojMHy5u4SdkEzSUgfU2nyPC/wmxAQVAwlgMjR8KN6+QW6Ne9OTXPRlOwDgoFIcF9HPH3wfb5ypMmO96iCFWQ=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSAPR01MB1700.jpnprd01.prod.outlook.com (2603:1096:603:31::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Thu, 6 Jan
 2022 11:01:04 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3847:4115:3fbe:619]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3847:4115:3fbe:619%7]) with mapi id 15.20.4867.009; Thu, 6 Jan 2022
 11:01:04 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Pavel Machek <pavel@denx.de>
Subject: Re: [cip-dev] [PATCH 5.10.y-cip 00/31] Add sound/adc support for RZ/G2L
Thread-Topic: [cip-dev] [PATCH 5.10.y-cip 00/31] Add sound/adc support for
 RZ/G2L
Thread-Index: AQHX/J0I4oLgBDGj5EGFNMhq9mDXE6xV3TJggAACSIA=
Date: Thu, 6 Jan 2022 11:01:03 +0000
Message-ID: 
 <OS0PR01MB5922F2A6BF497F345832359F864C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <16C5324B2EFDDB95.12001@lists.cip-project.org>
 <OSZPR01MB701986387CEBA39F8BC4DAD5AA4C9@OSZPR01MB7019.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OSZPR01MB701986387CEBA39F8BC4DAD5AA4C9@OSZPR01MB7019.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7495485b-bb79-48b0-1c0a-08d9d103d527
x-ms-traffictypediagnostic: OSAPR01MB1700:EE_
x-microsoft-antispam-prvs: 
 <OSAPR01MB17006B9C29ECF12A6E7D62BE864C9@OSAPR01MB1700.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 tHu7FgKgOvAfYRAnVKGJtAfxC4hvqpXNJ8G63xTWGV35KSn3yPSFMWChJrhXsIdesrnd2XQVcF5iMwamy/4EMZXqf/i1zs2vLU00k604/0cbQ6Q7uC567oN0fEKl6MIUNhRNSOF9cxH/GQ/AfBpu10sgh0m5yDbyU1o4MrTtOxeqKpbcKuWz5F8aXD+U6r1YTCADdppg6oH0NFydtitcdmHsO28BaGamGWQI6+tSXpYsZ8CKyCQLjcLDwqjy7TxJpSXomYwRf3V2AnLjkf9gO46lqRzt6XTsYvgDRJDE3AWx7jv1w5O1TmQyCUM+GugbvL+wi+LOJ0CA5r3GWac2UJXZk7lCtCrn+me9zDVRg0b9fQhq5uEXywtT0TBS7VyAf5lcrPZAozd6IM6ND+NsdpVOhwFMUS4OzXFjqmdppWeELyEPwSqBpR3Y8NrS/bLtnzCbypPMOFLC2Tw2JVJfuBm7VCu09lreY/f7roO3hxLxnK0/vjrDGP0ezoIN3bLTlmNtE5SMY33OAf2Qec6abPlvysggpQcgNhDA8FpRithBnL87PFgt0Z6xIxQNQw30y7dFALsjyOj4B50f+1yi1IcxvuGQ58FBlzp6q4+DQHuducRCo88q9zxJRJwXLRMZ/sPCXv1hLOGca93Y9cF3w+9i0CYzCqfYtJffI7Fflda5O3xjMxREb+pNL1/KTaJ/D0KtW1INQPufbKgRbd+l1YDgMqpkN7tIsHFYbQddDkeDbdIETDbQaiY6QmGs+fV3NR+1gV5rVeo8o2U26VRzcBbFqxaXnFWWcksQ7YqjlNM=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(53546011)(38100700002)(122000001)(55016003)(8676002)(52536014)(64756008)(66556008)(45080400002)(76116006)(38070700005)(110136005)(8936002)(508600001)(86362001)(71200400001)(66476007)(966005)(26005)(19627235002)(66446008)(9686003)(2906002)(83380400001)(66946007)(33656002)(5660300002)(316002)(7696005)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?b3/5hzuQZSqrGe4JrZ71LWl9LH0tReemZTTagDP+hddxKDPCqkPSHuN532S7?=
 =?us-ascii?Q?IPsXb7Bc3xWt3aHf6b7L1MTMDlf0wXkY6N/X0vZzudEwY/hmfJn+iLhKob2E?=
 =?us-ascii?Q?NST5bLyhcHDNTtp/fWq4Fd1uck0aPwGR7J3y4qFpKS6lrz6MvP+kSJoj3Wk/?=
 =?us-ascii?Q?y1DR3CvkbV3TXSmyxuKdwfgxtqzJzVfxYaAoQwO+lQl4YE7zyLXR+x99yAx6?=
 =?us-ascii?Q?eDc697ROhY5jmsC4mr7w1VOCWN7lsglCODtnJDMica4Q79QWVTAZMmfQu+1A?=
 =?us-ascii?Q?Mp5Us3J+OyJGJ4fIaDLEkjZ0/5IzJVXgMND84InzcgXEwxe/seLvp7r91c0i?=
 =?us-ascii?Q?7gD+MWsqsOQLWhPS8U3ZiK2StnNSDvjYrtM7uEFpCIQWOHI2gqPspcM/tiuo?=
 =?us-ascii?Q?xpdQSh4gKCIgVN34kIkw0oESqQnvqePlYeI0XZrVtfrsf7ylY+X/JGpANDFO?=
 =?us-ascii?Q?SKv/Ah5UhJmU0PEErIuwiVlcsz9iEWeMSrqGvpKz1sBnf+PbY3uJAElvyWkv?=
 =?us-ascii?Q?jMduJMoLQR24TAsiyGNWLux9QXVDilYNdo2WyfAafazsvQMRbCglOU6UmCLD?=
 =?us-ascii?Q?PuPLKT44KZL1Y7wHW9dYBGNfWGkHRaFFQ6x4Dr9vcKHDul7N+apXYLJonAr7?=
 =?us-ascii?Q?WMCflXXRhY41o2k7i7vKBJEuXBla+940kp+gWBcE7nOyK1rBfZpD8GaXntZS?=
 =?us-ascii?Q?4yFvmxcAFgOjwz0QLYAJOnKyv512h5kO5RDnFRual5MLjBBgCFmWkuBA+sHe?=
 =?us-ascii?Q?9+yQr3IAW1PDg1V0D/0lccNSHecJ2maDUlYzayGWwaA4eSJeTYILOLMMFH8k?=
 =?us-ascii?Q?kfvqAdyFkgtKT9/K+6FGoDx9kUxBksE2tpe6+d3sPl0lZhXESv5tWKiKQfAH?=
 =?us-ascii?Q?tcpngFX3GzJBfo6oMQEiWgNMGzGcwLxLYQnMEEiDrmv0BSaC6A2LWzc9IHoT?=
 =?us-ascii?Q?QtrgXOTdXRYo5OB2A4A/njuVyV8LGI21Fifp6E/ISsp9u79U3aNSXIOkP0Mt?=
 =?us-ascii?Q?lyrKuoKHIjSJ2LAuVLvy6eELuzhPypeBc5gl7T+IvZNSn8yKCn66tbfxsnHj?=
 =?us-ascii?Q?PfrLECm65pBaLFOW3yq3vWW0RDwrSAHUGuMYpsx8zY0M0npf4ln9szf4Fl7z?=
 =?us-ascii?Q?fi0E0WtOMpNa/26cUt7NJUbwJnnSCnzqOmrZortWsY5SrGPLdy5VKs6VBARd?=
 =?us-ascii?Q?JbVndwy9dy1LA2Pisbbt+/cMFkYF5OWD52J5N6y/bVqP4/hHwpc7s0bEc4u4?=
 =?us-ascii?Q?2V9gpalRXDWBb1Weh8zxk2i7r1xPM8kF/wPrli+mlJcORujIF4V94gjnBUlu?=
 =?us-ascii?Q?oFij3Byo4Z5JntoAWK7sDjmHbVxMtIkK2AbMKVVnoJyKfLSKxO5TpcGXFAIu?=
 =?us-ascii?Q?cpbEG4mZ1S4Z1Pqa8WpGHzmt2HmKh2iJjt5sLghHFV5AWYpcbQ17p2TBlIdu?=
 =?us-ascii?Q?zrH2Bi3IpKlpW1c1OGx7H6C5AjWLzEedp+/oyzJcIhsJjTqTuKljd+1F14Wk?=
 =?us-ascii?Q?VIklaxi69XO5pxYwJE+FdsFf8PSIXevSOCoq3Dw6yx+8L2xCqDHPH+0nHdeM?=
 =?us-ascii?Q?f/piAvep+HpJlt58chAAfiRt+IuIBH7zJKkxV5jfvVzaQ7++XqHR0jL6HtCv?=
 =?us-ascii?Q?iNtU5nA6zcyuZjeyANXwgALV2+i3Nbw11Lzyx6NAz1MVItd2vCNqV9y9M+MB?=
 =?us-ascii?Q?lZRGZw=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7495485b-bb79-48b0-1c0a-08d9d103d527
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2022 11:01:04.0071
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jK4mDxSAhHoe7JphwqwMIcsfNLnL34O0hA44yHJ90p6sYLy3l89w4sjFdRExlGN+baibKkgnRdr78EPrjyxi1SCwkHUdUf5+dw3vjYeq+Lo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB1700
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>

Hi Pavel,

> Subject: RE: [cip-dev] [PATCH 5.10.y-cip 00/31] Add sound/adc support for
> RZ/G2L
>=20
> Hi Pavel,
>=20
> > -----Original Message-----
> > From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> > Behalf Of Lad Prabhakar via lists.cip-project.org
> > Sent: 29 December 2021 10:15
> > To: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu
> > <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek <pavel@denx.de>
> > Cc: Biju Das <biju.das.jz@bp.renesas.com>
> > Subject: [cip-dev] [PATCH 5.10.y-cip 00/31] Add sound/adc support for
> > RZ/G2L
> >
> > Hi All,
> >
> > This patch series adds Sound and ADC support for Renesas RZ/G2L SoC
> > and enables RIIC/SOUND/CANFD/ADC on Renesas SMARC EVK.
> >
> > I have also included the missing driver patch for riic and kernel
> configs.
> >
> > All the patches have been cherry picked from v5.16-rc7.
> >
> Do you want me to separate out audio related patches and just send the AD=
C
> for now until the audio patch comments are resolved/fixed?

Just to add, I have tested audio playback/capture continuously for 3 days w=
ithout anu issues.
The race is between atomic context and quit function. Currently it is not t=
riggering any issues.
If you can point out a valid case where it can trigger issue, I am happy to=
 check that.

Regards,
Biju

>=20
> Cheers,
> Prabhakar
>=20
> > I have created a MR [0] for cip-kernel-config to support build testing
> > and can be merged once this patch series is accepted.
> >
> > [0]
> > https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
l
> > ab.com%2Fcip-project%2Fcip-
> > kernel%2Fcip-kernel-config%2F-%2Fmerge_requests%2F55&amp;data=3D04%7C01=
%
> > 7Cprabhakar.mahadev-
> > lad.rj%40bp.renesas.com%7C448a426ec06a400fd7ee08d9cab42a09%7C53d82571d
> > a1947e49cb4625a166a4a2a%7C0%7C0%
> > 7C637763697420828810%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQI
> > joiV2luMzIiLCJBTiI6Ik1haWwiLCJXV
> > CI6Mn0%3D%7C3000&amp;sdata=3DT6OVaoV3tgK9UsAYD7ZeT%2FwjVctGGJM3Hja2V%2B=
B
> > d5mU%3D&amp;reserved=3D0
> >
> > Cheers,
> > Prabhakar
> >
> > Biju Das (21):
> >   ASoC: dt-bindings: Document RZ/G2L bindings
> >   ASoC: dt-bindings: sound: renesas,rz-ssi: Document DMA support
> >   ASoC: sh: Add RZ/G2L SSIF-2 driver
> >   ASoC: dt-bindings: renesas,rz-ssi: Update slave dma channel
> >     configuration parameter
> >   ASoC: sh: rz-ssi: Add SSI DMAC support
> >   ASoC: sh: rz-ssi: Fix dereference of noderef expression warning
> >   ASoC: sh: rz-ssi: Fix wrong operator used issue
> >   ASoC: sh: rz-ssi: Improve error handling in rz_ssi_dma_request
> >     function
> >   clk: renesas: r9a07g044: Add SSIF-2 clock and reset entries
> >   arm64: dts: renesas: r9a07g044: Add external audio clock nodes
> >   arm64: dts: renesas: r9a07g044: Add SSI support
> >   arm64: dts: renesas: r9a07g044: Add DMA support to SSI
> >   arm64: dts: renesas: rzg2l-smarc: Enable I2C{0,1,3} support
> >   arm64: dts: renesas: rzg2l-smarc: Add WM8978 sound codec
> >   arm64: dts: renesas: rzg2l-smarc: Enable audio
> >   arm64: dts: renesas: rzg2l-smarc: Add Mic routing
> >   arm64: defconfig: Enable SOUND_SOC_RZ
> >   arm64: defconfig: Enable SND_SOC_WM8978
> >   clk: renesas: r9a07g044: Mark IA55_CLK and DMAC_ACLK critical
> >   i2c: riic: Add RZ/G2L support
> >   arm64: defconfig: Enable RIIC
> >
> > Colin Ian King (1):
> >   iio: adc: rzg2l_adc: Fix -EBUSY timeout error return
> >
> > Lad Prabhakar (8):
> >   dt-bindings: iio: adc: Add binding documentation for Renesas RZ/G2L
> >     A/D converter
> >   iio: adc: Add driver for Renesas RZ/G2L A/D converter
> >   clk: renesas: r9a07g044: Add clock and reset entries for ADC
> >   arm64: dts: renesas: r9a07g044: Add ADC node
> >   arm64: dts: renesas: rzg2l-smarc-som: Move extal and memory nodes to
> >     SOM DTSI
> >   arm64: dts: renesas: rzg2l-smarc-som: Enable ADC on SMARC platform
> >   arm64: dts: renesas: rzg2l-smarc: Enable CANFD
> >   arm64: defconfig: Enable RZG2L_ADC
> >
> > Yang Yingliang (1):
> >   iio: adc: rzg2l_adc: add missing clk_disable_unprepare() in
> >     rzg2l_adc_pm_runtime_resume()
> >
> >  .../bindings/iio/adc/renesas,rzg2l-adc.yaml   |  134 ++
> >  .../bindings/sound/renesas,rz-ssi.yaml        |  118 ++
> >  MAINTAINERS                                   |    8 +
> >  arch/arm64/boot/dts/renesas/r9a07g044.dtsi    |  140 +++
> >  .../boot/dts/renesas/r9a07g044l2-smarc.dts    |    7 +-
> >  .../boot/dts/renesas/rzg2l-smarc-som.dtsi     |   35 +
> >  arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi  |  162 ++-
> >  arch/arm64/configs/defconfig                  |    4 +
> >  drivers/clk/renesas/r9a07g044-cpg.c           |   28 +
> >  drivers/i2c/busses/i2c-riic.c                 |   23 +-
> >  drivers/iio/adc/Kconfig                       |   10 +
> >  drivers/iio/adc/Makefile                      |    1 +
> >  drivers/iio/adc/rzg2l_adc.c                   |  591 +++++++++
> >  sound/soc/sh/Kconfig                          |    6 +
> >  sound/soc/sh/Makefile                         |    4 +
> >  sound/soc/sh/rz-ssi.c                         | 1074 +++++++++++++++++
> >  16 files changed, 2334 insertions(+), 11 deletions(-)  create mode
> > 100644
> > Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
> >  create mode 100644
> > Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
> >  create mode 100644 arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi
> >  create mode 100644 drivers/iio/adc/rzg2l_adc.c  create mode 100644
> > sound/soc/sh/rz-ssi.c
> >
> > --
> > 2.17.1


