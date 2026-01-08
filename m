Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E956CF6A90
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 09:29:00 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.40])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2985.1767864532451868369
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Jan 2026 01:28:53 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=I5zNQGuQ;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.40, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NS5z78JUdWK4ESfjHt5nYjNOslr0+iVOu1PkGaFuEif3f0rRMAk0wdg+EFS3TkeZK2XBr1/mb8jpLI+Z9QQYVwJPHKhRDaZifdZYTGXW3RNNDYreE6EiWv7Jt0UaySkp9l1etmY9qoM2DZvMyBcGdmNIQ5ELO3e141zX9vvkzSsoo3SfyEnc8Lk+O41A1JR17nTIo2/+lhtsudBfeC3fI7wnxcJXGUvcZLw6DfzNzLNoTGBv9He+WahRPA1rpfteaahxrkrjY5vatFrcI4zYn1T82AIo5SpH7zlhZgzmVIh5ihfYEw/jdN4g0Y0BQOIyZ4JGAPahLhC+sSM5kRG4Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i3uYVuS6lLoV/uXKzBzKtCR+ysiybM2tSuzeTyW1HZk=;
 b=Jeu/i1LMxKA1eZXYYyLsDY+fCnVWJURWUVEt3hllLUHxLs8m8y+HMvy7nbth4GDINBgKus3LUny8Q2TkQez5gDr1s+FYJd525B9yTTtMDYp2IautDLiv3uNVOZvCe55DkA0oyY2JTyzvHUc3Gm0CarirkEjiKH3fnVENg2mRPFwOGOeVOzNq2AInzUV5U+bx00eWQ/y2dVDGBKjxr3I36z0UTV2U7pktekjuB0hmnX+EL9txFtYZ7qjM7dzhfmqbDT/vjfO8kdpFSj5HYnOkRCc/mHWhzOzwZCm6lFIyIAXYoBDNpVBlBLD97Z+/vdNzE3N1miche9wDThmvrqdC1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i3uYVuS6lLoV/uXKzBzKtCR+ysiybM2tSuzeTyW1HZk=;
 b=I5zNQGuQASCU4PfKlFzkScVj4v5/z3VbZNLQ2vVQsqV3DWQleMidAAOPdMbSyPAfCKQA/frc0LUYG/YIOjR7b4YBhfPULFYUc2iRvIlWEKYdQ9jiBm31KyEi+I3sfnyi3uYf0rExBUx4mM1M2/3Ie2ogzHNmPKQUfs/R2rbwhvQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYRPR01MB12872.jpnprd01.prod.outlook.com (2603:1096:405:1b1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.0; Thu, 8 Jan
 2026 09:28:45 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 09:28:45 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 00/22] Add I3C support for RZ/G3E
Date: Thu,  8 Jan 2026 10:28:01 +0100
Message-ID: <20260108092823.489287-1-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0364.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::12) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TYRPR01MB12872:EE_
X-MS-Office365-Filtering-Correlation-Id: 499d1806-8d24-4e51-e578-08de4e985228
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?3VqYz7YOx2uVtTHA/KY7gvd2qDbiWKOI87baXY2uxKVRhekmIPtZGRmXSneE?=
 =?us-ascii?Q?Zbw+BMXC/ixZgiKU/OC2Rbm/c6HgRLdSOgvQv/tToR2udXdX08DQp01ppqxd?=
 =?us-ascii?Q?d2pqJZWJuG823Vby/g/qHQ3jP1MW/89AxE1zH6P5wuU5QrxZmMKGMwQPQaF/?=
 =?us-ascii?Q?pw8qdjmpeuKrNJckdM1Vlgxhmj8TNsJxcICz5NKaOteGX2uGksgW8qkR9j5o?=
 =?us-ascii?Q?Ie/BOANgJmR7aXLrwVNlyYyuViakYRheasX8cx0LBbM2DEdvJCjsUAinDVnI?=
 =?us-ascii?Q?NU39llgmSWjbec8qlYv59VMJxbioV3muqqJB9QEGkvj8i/XaCtiMZejfjNMm?=
 =?us-ascii?Q?cpBX2zjNdJu0NAYSywBr5SsSKmGrFdcrd1pprGVVxLxe7bsgOC2Mr9m+yWsy?=
 =?us-ascii?Q?XyeggzjHHoMQz3kr5Xzh+zBjjCUgIElQAvtqPu5dNJlQ8QchNHXSRDBo5uwG?=
 =?us-ascii?Q?4wSuSGXXGT5ANi03gkrXNU2jrkkQuw8nzvkaAqeTRm356HJWYjaBOEVFuDXf?=
 =?us-ascii?Q?YZLGcy14MnphxSEC2mgWbeSiBEtHU2VgIXheI+nTsU481RU6NAjHqi4TDGDe?=
 =?us-ascii?Q?hVsRBec0Bm2Zj0z6vaJwc46tqgOQfDjTbS6jbnunGF/opp+B9osIrOuCPyBv?=
 =?us-ascii?Q?vUK2B75uSlaVCXJWZ7VPuKhpW11fm3/wiu2UHK+9UHZyyVu8CyzkdYU7ddDF?=
 =?us-ascii?Q?XhJIzjcjzTLPg6qXjIAvo3yv8NYjjBroxL7ZOyf09dUTdINqsac+nDu/7Ipn?=
 =?us-ascii?Q?8bJcvgqBsy8pkJUg2bTq786u2Yy80vtE5FhTMquoKAkR8bu+ju9FU5NalQKP?=
 =?us-ascii?Q?WUXor/rtowHmEIv9p+4xRQonFm54/p5nei5KsLDq4GSsmaQk0FB9FFgSn87v?=
 =?us-ascii?Q?94LPKUb+3N8Z+3rPFd/u484PLCvt9dY2Rpz4KSObr8nzssousuIx5hIJgPPg?=
 =?us-ascii?Q?S09+y0r0TukuVxxVjG36HZbMqO2RD2p12+IaDcZ8sRmWo4IMrmcHKu22VJGf?=
 =?us-ascii?Q?8w1RZ6KvGwbA5OF7Aj2YLb8iNaDqndvd/ouxEUbjCni9e1afJPkuXOoBB0NP?=
 =?us-ascii?Q?TTEBfNm+CcdnPWUc+Zy7ll/pS3KOpdt6H+oPKsgvbJ7VZXgSHQgSljxc5imS?=
 =?us-ascii?Q?kuMEzwR0jBvYCVqz0DNNg/c7xEwZL3oXb6RGEnpyhTtFf8tfyBmZHTGxE/Sl?=
 =?us-ascii?Q?xDbN8Iexlu6JqelyO41mFGi6j7qhVKIt0b6jQUZ/uOBGUIsZ2BGVIXWVF5rI?=
 =?us-ascii?Q?Brr6mhoPQssQSXsFETsxxyoFW+AfVfezi0HMXECRfiLeO4oJmFmTSRL7w6nA?=
 =?us-ascii?Q?WFvhY0j6ce17Orn0yfPuO2QGHQ3TfyI9uiKOZZq2BAzQJ4Q54cCfgmHYobc4?=
 =?us-ascii?Q?Mbj8ViTpqeNikFC8k8oO9hOPwbh9ESrN4/4DiQ1Eg8vtVg//n16DTCaEQRu9?=
 =?us-ascii?Q?IgZRLtVE4rkT+DCUgTz4vuSi4FqQRh1Tloa7mPSgW51GZX5euZTqgc62xyzL?=
 =?us-ascii?Q?cqXhjzSzbKh86eCK/Y78bdDKZMQ3QjkeNjCt?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?vL383olUvhxR25pilQU4hG9FYCK/MYVFHFEuYWTvKTw2uV5WGJ7EVUXH2xHS?=
 =?us-ascii?Q?Zr25+4+1xwK28zlQshxVmxaT2PWX9nRLSyLk1wo9UH1mp+ggD8P3ItAgk211?=
 =?us-ascii?Q?Fp+pV3LE/7kHdj1dWtczv9ODVmu/ypb5fcOXoHwfxiJ4ocmNPsKmZ8vRaZ4F?=
 =?us-ascii?Q?Rgu5QMk5iwrOgD7y3h1f3hzizXiiGVcEkX3BLce/ZAPUBssRtHj+6nIgSNPZ?=
 =?us-ascii?Q?T+qekR0LrDqVikZY3QV4pSXbUAz61wSSvfejVs0SiTIz4BnHrveiW7UMuieP?=
 =?us-ascii?Q?rMYFjmGaemTLUEWf4oTKi/t0GVO7FyU9SNU2e4etJxhEVHQCpcvR792p3dt0?=
 =?us-ascii?Q?eH8AyZNJIOipJ7cdRF4XeDlrl9RoMUDRZu5UGOjWvHXVGzlNYH5+gAOiNBou?=
 =?us-ascii?Q?q87on52BWHq1zwHrMAuDXlfgZMbMVrgYO91Ra4DJXqICcmu1PALyajnN2/iH?=
 =?us-ascii?Q?vQFOMjPIRX0blfzqoikFao/IEsVismi4HHN84P760s7afdI3vi2rslWSKokP?=
 =?us-ascii?Q?xI06JiQq7ruV92LME9/r4ztTvdhf5RtsIfp3oOk7cBUeQ7OBpDds5JtltHhF?=
 =?us-ascii?Q?gAl2szGpKzKCUmCCPorq4hzC5ZoS5URVosLtvJF9I1ZtHusC2c7b6AcSRdVJ?=
 =?us-ascii?Q?M8T2pBNhhBg4dFkM8F7dV/3yK2l00WcZb36l4axelGWmi6Mq7UVPUVFa2qCE?=
 =?us-ascii?Q?iP5aG6TtIsCjU7ELAxcsJlR0H8lOE1Ai4Abi0C4a5ciUPvYoyLHlC+yU1B9Q?=
 =?us-ascii?Q?6jdn49+BWqRXROvGAZDww9a/IkT6owY1vGpa2GQcvoHoyrPDLJMNad0GYnu7?=
 =?us-ascii?Q?dP2/SWv1T7uIE7FSMTeWboiSnQsQ5tmTh1TWwhaB/nMYn8vVJzRtGV1UJRzh?=
 =?us-ascii?Q?UTbvRjjZMZNW3Hs+7mwuj5iqm+JkDL/MMGfzm9YUpqqhj6UilGlzEwhUeF4K?=
 =?us-ascii?Q?FecghBTTQ5079Y+jdlaTH0C3ps7bSXBYAl+nRpbzPxWCQF9v/VKAmQ9LXJq0?=
 =?us-ascii?Q?FzV/ryc3rDQCyIpkPUAKREjrrkpkczdJBF/ZoC+oObDshjfQ2arlRfEIAiFv?=
 =?us-ascii?Q?CTeXuaewx+T8DiLeDgNyrD05K+ShxuKhHv+JA/1jnqj9ki/tAVgPPEzsqm/b?=
 =?us-ascii?Q?Pre44KnxCYSGSuGAoDFbxrh+CA99Cp7NDWpfIqMJFsAg6IlawEN+qZZwTodX?=
 =?us-ascii?Q?++iAC6+EK8e7E2RT6MRLc+y6tqEpJMW6cIYRYa2cE9ZxbaM8XM0RripEotXZ?=
 =?us-ascii?Q?6BRhBvakktq4jhuARXVW2hctA9cRiWxCjwcgFi7dpph6BNPuD7t9Ah9X1+QD?=
 =?us-ascii?Q?TWdvAKXa3loUskx4nYmfmpG/+bcNvLFZ7uH+Vk1QX2bnxYTXB5R0guy8WJQf?=
 =?us-ascii?Q?WF96FkuXawfFI9fvCReCyvkfULFiBDLG9l5g/dIyeA8IVyoW4ZwgSweC0udS?=
 =?us-ascii?Q?QsHVRJimE2evEXpKfL3iY0yx0BQdpAugtsF4n/57bxOUCC29V62tOCNsrK+j?=
 =?us-ascii?Q?wIHLMGKj+WLtb/CrJyaFaDj+jmo82D/PUFE9ewbNoHfYMvbCu5xsJmMK2k+h?=
 =?us-ascii?Q?cu0ySU8x/vdNizIJIUoq3/xYduNTbnenM3/ulu734VQRy3ay1MGcdYJyUYZ5?=
 =?us-ascii?Q?OWla8yXSePvK77Be2vMASM/BuSSDicxbMftjxKBw4dgmaK7eqPeHNxs8xuvv?=
 =?us-ascii?Q?VU47G7K2OPQ9NwDetSTrQ3zA1VTD8ppep3GD9wDjDeeyna/U4igGiFCFhG6E?=
 =?us-ascii?Q?01tTfwIbQsBncfQ09JkNHx6NdUj0Y7TEdr1V+oBlW1Bie0hEnuZ0?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 499d1806-8d24-4e51-e578-08de4e985228
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 09:28:45.5505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qv5oEkJRHAp4BteU6P3kGt+ltp06y7G3Fiui9/tmc1Fs/BTOSzO9rk3vrHZH9RXxrfImb3fU/TPqI4oKK8NPxhs0gGNKIT3Z8pIp2SSj0QZNf/G16W3KkqkHjfZ4315o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12872
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Jan 2026 09:29:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21436

This series adds I3C support for the Renesas RZ/G3E SoC into
linux-6.1.y-cip kernel. This includes also nxp,p3t1085 I3C backporting
for testing purposes.

Tested using the NXP P3T1085UK-ARD connected to the RZ/G3E SMARC SoM
via the RZ/G3E SMARC BREAKOUT board.

Thanks & Regards,
Tommaso

Alexandre Belloni (2):
  i3c: Document I3C_ADDR_SLOT_EXT_STATUS_MASK
  i3c: document i3c_xfers

Billy Tsai (1):
  i3c: Remove the const qualifier from i2c_msg pointer in i2c_xfers API

Frank Li (4):
  dt-bindings: hwmon: ti,tmp108: Add nxp,p3t1085 compatible string
  hwmon: (tmp108) Add NXP p3t1085 support
  hwmon: (tmp108) Add helper function tmp108_common_probe() to prepare
    I3C support
  hwmon: (tmp108) Add support for I3C device

Jack Chen (1):
  i3c: export SETDASA method

Jarkko Nikula (2):
  i3c: master: Add helpers for DMA mapping and bounce buffer handling
  hwmon: (tmp108) Do not fail in I3C probe when I3C regmap is a module

Jorge Marques (1):
  i3c: master: Add inline i3c_readl_fifo() and i3c_writel_fifo()

Naveen Krishna Chatradhi (1):
  i3c: Correct the macro module_i3c_i2c_driver

Stanislav Jakubek (2):
  dt-bindings: hwmon: ti,tmp108: document V+ supply, add short
    description
  hwmon: (tmp108) Add basic regulator support

Tommaso Merciai (3):
  dt-bindings: i3c: Add Renesas I3C controller
  clk: renesas: r9a09g047: Add I3C0 clocks and resets
  arm64: dts: renesas: r9a09g047: Add I3C node

Wolfram Sang (5):
  bitops: add generic parity calculation for u8
  i3c: controllers do not need to depend on I3C
  i3c: master: Add basic driver for the Renesas I3C controller
  i3c: Standardize defines for specification parameters
  i3c: Add more parameters for controllers to the header

 .../devicetree/bindings/hwmon/ti,tmp108.yaml  |   18 +-
 .../devicetree/bindings/i3c/renesas,i3c.yaml  |  179 +++
 Documentation/hwmon/tmp108.rst                |    8 +
 MAINTAINERS                                   |    7 +
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi    |   35 +
 drivers/clk/renesas/r9a09g047-cpg.c           |    8 +
 drivers/hwmon/Kconfig                         |    3 +-
 drivers/hwmon/tmp108.c                        |   73 +-
 drivers/i3c/device.c                          |   20 +
 drivers/i3c/internals.h                       |   38 +
 drivers/i3c/master.c                          |  105 +-
 drivers/i3c/master/Kconfig                    |   14 +-
 drivers/i3c/master/Makefile                   |    1 +
 drivers/i3c/master/dw-i3c-master.c            |    6 +-
 drivers/i3c/master/i3c-master-cdns.c          |    2 +-
 drivers/i3c/master/mipi-i3c-hci/core.c        |    2 +-
 drivers/i3c/master/renesas-i3c.c              | 1431 +++++++++++++++++
 drivers/i3c/master/svc-i3c-master.c           |    2 +-
 include/linux/bitops.h                        |   31 +
 include/linux/i3c/device.h                    |    5 +-
 include/linux/i3c/master.h                    |   48 +-
 21 files changed, 1993 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i3c/renesas,i3c.yaml
 create mode 100644 drivers/i3c/master/renesas-i3c.c

--=20
2.43.0


