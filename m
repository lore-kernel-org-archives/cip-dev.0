Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFECEB64DA
	for <webhook@archiver.kernel.org>; Fri, 16 Jun 2023 08:53:11 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.91])
 by mx.groups.io with SMTP id smtpd.web10.4159.1686905587913087236
 for <cip-dev@lists.cip-project.org>;
 Fri, 16 Jun 2023 01:53:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=O/ayZkDA;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.91, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IoHR0LLlf3LG48EYrMDwqO/niuzsTraQx3RR32Ed7AKD+sIpVKi1cx1AlGovtBKhhfbtgI73skoS7+1gjkRBpp2rYPMCQJdEi5to6w3EWXrNoCN7EWxtV5fIkx9mJilCZZTLJerIkPcTbmAuBrQsDF5fmRish4/DNQPPe2hoj3AZKDK7//le4t8rGKUYaFThvv9cipYZy1scqxAl0BLe2dDsvSwlVCntWZ84JDU5HCsTxxMMJoaC3/G9Cx1gsaNPrFKh6RJr6/v73c6kPgyGtq/KxHLERQya8rOIRc5VOcb2BbdKMQO8ecSyzRZnMIZsw1q4oLJBFe5ijl1LSAN7yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lwlvSvs4onGn4oBPd2p/yY7kS16aOmxHSie305RdKUY=;
 b=Fssi41lXEowGpuu9gK6yTVvNtQa+2WFwGdEavgXATAr00ns0n+22WiTRH8IFSA4KFD4RsKr+zIcvmHfabZKfDmh5liljfkivzdWLFbZLVQ2Pa4fHQy0iPc2fnGaXSgn8FZsRnshT37NB3P9RYvZy1Ie879RbzT8zSYNTZeZXjuj7W9X1cgIypDVMdCdFvZa7UIkFq+cjrcdzgbWMMXST0eE27ML4921T2sR18ungK68680jYa0f8DXeF58g1h86Rhkxc6MOgxKLrtqM2n2H3UyTTzxu2uSvfR9ILiEnFGE9M2zmLCoTSKxjzVARYGmc2aEXfyNOLLeGkmpF7Xv8UdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lwlvSvs4onGn4oBPd2p/yY7kS16aOmxHSie305RdKUY=;
 b=O/ayZkDAOy8vg+h0RL62oV5luhxVd1kFDRh4oK5porD9eblkNvQDn4VsjAHIMGf1F7HtSG4+I8/nz6/X/2hQEDgcn3lf/DywHTPqKXHftWq1rRI6A82GK0P4jlbrcbBCsdoR69CsshPTVvuFbmZZb8Z9yunOJNRpc1SoXYaCHcw=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB7993.jpnprd01.prod.outlook.com (2603:1096:604:162::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Fri, 16 Jun
 2023 08:53:02 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fc77:6148:d6a:c72b]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fc77:6148:d6a:c72b%4]) with mapi id 15.20.6500.026; Fri, 16 Jun 2023
 08:52:59 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Pavel Machek <pavel@denx.de>
CC: Chris Paterson <Chris.Paterson2@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH 6.1.y-cip 0/8] Add MTU3 core/counter driver
 support for RZ/G2L alike SoCs
Thread-Topic: [cip-dev] [PATCH 6.1.y-cip 0/8] Add MTU3 core/counter driver
 support for RZ/G2L alike SoCs
Thread-Index: AQHZmEvhmsXocB8bykyoeyB0DUt3lq+NLyqg
Date: Fri, 16 Jun 2023 08:52:58 +0000
Message-ID: 
 <OS0PR01MB5922722AFE1A3D5D270F45DD8658A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <176602980452741A.14840@lists.cip-project.org>
In-Reply-To: <176602980452741A.14840@lists.cip-project.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS3PR01MB7993:EE_
x-ms-office365-filtering-correlation-id: ff1425cf-ada8-4bcc-dee6-08db6e4715cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 2rg0bScEmYyu8q98qxSQaR701Ot40CckIG7HyJpoP+sX0O6beT//Ro+WVV+3AMjRmbrC5Pd9uUO8mIhg0HggOtGIjw/k8B57buM9TfpHNaPyZeGx0gkT9aTu7QtWcI6hzM/5Y6HsEapyCOh8+g7L9bZT4EU5wGyelg0ErVrC9y3wPeE3Er5pQaY258bNDsx6rw47ef/DlOVAXEQJ/i1qh6sOaTK2ELHyJ4k5sXwnHNQ04fk/UCOZEw21BrfVFdinHgBFliy4e4ySSpnauQ1ve5Zn9gx1Nl3syabAXwo7trhG1GvVGNL5hopYP5HPzGhKfswBBMeaqFT25Y3ATtGWj6fBXUOmdAMI8cX5JU9Ce6AJ3qrYMR5FIbk1yXNgdziICiK0vw6k9Nk++sh0Cy9N85hYbk6xX9LguHqjsmZi5UyeqeV25e0l3WsB26rsGkzPH7X2Is5k8BWI4MtiAr5DixKucAtp6iWDA5tbSqCF202d+9SOHVm+4alTxwPSayRVs2gbplhUq3jMW0Z9nKU1+il3QVvgfsWFI0qm4M6WzwtqiZrmNPu4TOkaZw2iYUcv4SMtNtHqFgIrmUyd/Cx7z6v3leijA7PuCh46Y+uNK1I=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(6029001)(4636009)(39860400002)(366004)(376002)(396003)(136003)(346002)(451199021)(55016003)(76116006)(110136005)(478600001)(54906003)(41300700001)(45080400002)(8936002)(38100700002)(122000001)(8676002)(66556008)(66446008)(66476007)(66946007)(64756008)(4326008)(316002)(7696005)(26005)(186003)(9686003)(966005)(83380400001)(71200400001)(53546011)(107886003)(6506007)(86362001)(33656002)(52536014)(38070700005)(5660300002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?MfYfxdK4uXL1bQmP3Hi4BujsF4lKWw/YayyTTlhVm/msqRdlQ+QWvLPqcOfa?=
 =?us-ascii?Q?6DsMLeqqH/ctExCn7I+3rVaK+elUzNpwJunQStD8opXmUI1d7eiRxEnW3oLN?=
 =?us-ascii?Q?ilL/xAcmTFPNhiq/2K+cEZ8ai92EbsoGe9Pr7TT6L4GxCEiOL+1xCm8egg6n?=
 =?us-ascii?Q?qYsQ4dh3yrsXK3eZytL5Cy6EAeMPC2h05yFxLViotK0svqJATfbEEtbLsk/J?=
 =?us-ascii?Q?6+in1/WbdD7EMPyeWeiqHXtYDuZSHSQjrHc/zb3/+mXeXdR5zk0ZAY9lp4yd?=
 =?us-ascii?Q?/3yd271BAerHyJt4CZXmSIDazfsPsyxn8IaiE6cmtpby6U6Zx+A7l/0SXiGn?=
 =?us-ascii?Q?Jfjztpm6uYYBNqOOAXCflkeqnSX7yvP2PvNgftdcnMw6VKeA4IKRAsVp8egd?=
 =?us-ascii?Q?cPsS8Ri/jrxg06JdBbqE3DxdToHKv/JMopRaUYulqdzBB6BNbSxteLH4vKT6?=
 =?us-ascii?Q?ukvV1lpqJAHgisYYIWQr9IlR6NJvCO+zD+8Y/xiF7B8kTZUCJ9W1qGvOXlKC?=
 =?us-ascii?Q?FFz0ODSxYeujHRd3NTs25ldypweAoO9m6e0eQQ647a66e8IYKn/UhzqbLCpy?=
 =?us-ascii?Q?pgCNiwYX+ThCGxs1SnNEJxlthBGuNAdJC2NF0CoFp5SmEu2Yp857s5Tpt/3s?=
 =?us-ascii?Q?ETszvSL0+JMOwm5y6KFlgS4VTO9nujNbWsilQ9WoXlgvuBgyjGXh3ZJeufeV?=
 =?us-ascii?Q?8l8U1DXMIBi//LnUy8bbWSdRdhbkf5abl7wNv4CR3UCL+kzPUu/w6KWYDokb?=
 =?us-ascii?Q?QXPYgMtlnyBL2Vtroh1Mk3Q5FL5whXAS84kSX9gTQjhxYtqo94OYVEacUt75?=
 =?us-ascii?Q?JjAtE1+CVit6wOu1kX7pn4HGG6Lw+9Jd8puu59Qzsv/peB03Vnkqaj0UgHdq?=
 =?us-ascii?Q?Wz5dNBHidCzqERQWtVh9ljQ84e4yrQjkJaAFZy/UY48HKZ50NKekT9+hMEKa?=
 =?us-ascii?Q?l8TtPwBp/PH4/Lf0FDQJKZs0aE0oGnTW68D1tlBhmeNK5P6lXqkwVw459Fkh?=
 =?us-ascii?Q?K1ijkBfvKdI//IDN5cpUsvyyzNg8YfnXM/w1q5dWVesiSKdsy7WVgredMekM?=
 =?us-ascii?Q?hCmPxO86ftj8qWuZH3QzEYANbfnTDWBWsM9sdok03gMLxv9hkrnTqKyOtK7z?=
 =?us-ascii?Q?sl0Ybe61HweQuyKJYQNyz3LZ253RBCJ7zx48xmsDq/qOkM4GaD179S1a8JRB?=
 =?us-ascii?Q?lTDvu+Zy9+N0AqcpK8C73CfqfqBDNor/42ILTazX+TjnIGr11K6zrHTZ+NS4?=
 =?us-ascii?Q?sqN4FyQLiZ0yHkeVChLuRjWs1hRnVqhh/dB889YJw4zPeVT13OOvX2ob5BhL?=
 =?us-ascii?Q?4zSS2UJdp22qlC0Dq02OQo5pS61k6FoWim9IgkwuALmJM7YzD9k34YXuOkS7?=
 =?us-ascii?Q?/Qmb+UvixaeD20KkMcZl0devPGGzODJ4C2QKFo6XX6LcLFHRB1HQJEtNsOhE?=
 =?us-ascii?Q?Hw8uqrMMhZBxv8ZIFQqVjo+ONkoEn3naTyfvJtnzcKWU109bRVZtEBAfouqL?=
 =?us-ascii?Q?YZo9ovjletHozPBMU1YssRw39odLFYqEgiZwL6OcovYVBJ5oE1mo+ls37pHI?=
 =?us-ascii?Q?J+HktaLQgq68ffpUtuuQvyzfWnNBcciavdJODpXRNbWENPyWsXKWsOxc+YOK?=
 =?us-ascii?Q?7w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff1425cf-ada8-4bcc-dee6-08db6e4715cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2023 08:52:59.0394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N8yBxUCp906o10mlfSG8too7Tx7PgS1fogwOHk7yAoVPXJXOAwJLuxLFVpaZH9uZiszd8VzPSiRQRIjSxZFYAKBRIl/ZxyXb1UsBrzs+DJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7993
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 16 Jun 2023 08:53:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12066

Hi Pavel,

Gentle ping. What is happening with this series?

Cheers,
Biju

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Biju Das via lists.cip-project.org
> Sent: Tuesday, June 6, 2023 8:52 AM
> To: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu
> <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek <pavel@denx.de>
> Cc: Chris Paterson <Chris.Paterson2@renesas.com>; Biju Das
> <biju.das.jz@bp.renesas.com>; Prabhakar Mahadev Lad <prabhakar.mahadev-
> lad.rj@bp.renesas.com>
> Subject: [cip-dev] [PATCH 6.1.y-cip 0/8] Add MTU3 core/counter driver
> support for RZ/G2L alike SoCs
>
> This patch series aims to add MTU3 core/counter driver support for RZ/G2L
> alike SoCs.
>
> All these patches are cherry-picked from the mainline.
>
> It is tested with Rotary encoder[1]
> [1]
> https://www.mous/
> er.co.uk%2FProductDetail%2FAlps-
> Alpine%2FEC11E15244B2%3Fqs%3Dm0BA540hBPfDpUEkDmFV5A%253D%253D&data=3D05%7=
C01
> %7Cbiju.das.jz%40bp.renesas.com%7C3f20076914c54730e85108db66630357%7C53d8=
2
> 571da1947e49cb4625a166a4a2a%7C0%7C0%7C638216347664195285%7CUnknown%7CTWFp=
b
> GZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D=
%
> 7C3000%7C%7C%7C&sdata=3DpRx27j4b4tT4IRdGTaMDBLynFPCujwxAQnRnMNbYicU%3D&re=
ser
> ved=3D0
>
>
> Biju Das (8):
>   clk: renesas: r9a07g044: Add MTU3a clock and reset entry
>   dt-bindings: timer: Document RZ/G2L MTU3a bindings
>   mfd: Add Renesas RZ/G2L MTU3a core driver
>   Documentation: ABI: sysfs-bus-counter: add cascade_counts_enable and
>     external_input_phase_clock_select
>   counter: Add Renesas RZ/G2L MTU3a counter driver
>   MAINTAINERS: Add entries for Renesas RZ/G2L MTU3a counter driver
>   arm64: dts: renesas: r9a07g044: Add MTU3a node
>   arm64: dts: renesas: r9a07g054: Add MTU3a node
>
>  Documentation/ABI/testing/sysfs-bus-counter   |  32 +
>  .../bindings/timer/renesas,rz-mtu3.yaml       | 302 ++++++
>  MAINTAINERS                                   |   8 +
>  arch/arm64/boot/dts/renesas/r9a07g044.dtsi    |  70 ++
>  arch/arm64/boot/dts/renesas/r9a07g054.dtsi    |  70 ++
>  drivers/clk/renesas/r9a07g044-cpg.c           |   5 +-
>  drivers/counter/Kconfig                       |  11 +
>  drivers/counter/Makefile                      |   1 +
>  drivers/counter/rz-mtu3-cnt.c                 | 902 ++++++++++++++++++
>  drivers/mfd/Kconfig                           |  10 +
>  drivers/mfd/Makefile                          |   1 +
>  drivers/mfd/rz-mtu3.c                         | 391 ++++++++
>  drivers/mfd/rz-mtu3.h                         | 147 +++
>  include/linux/mfd/rz-mtu3.h                   | 257 +++++
>  14 files changed, 2206 insertions(+), 1 deletion(-)  create mode 100644
> Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml
>  create mode 100644 drivers/counter/rz-mtu3-cnt.c  create mode 100644
> drivers/mfd/rz-mtu3.c  create mode 100644 drivers/mfd/rz-mtu3.h  create
> mode 100644 include/linux/mfd/rz-mtu3.h
>
> --
> 2.25.1


