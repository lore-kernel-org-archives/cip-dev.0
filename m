Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82BFDCF6AA7
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 09:31:10 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.39])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3029.1767864649193704525
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Jan 2026 01:30:49 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=nCMDp4hp;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.39, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FyxU3fzEncaLFgrLBro037zWh0p6UyB+mO0KDaHqo1ZmGCsljqB1lQgsWyEO00lOB+UQPeQ1oILEgNpci/5MuHOXzBUvP58/MU2OFFA7050mt9TyeAigZQj7SKdeiQNtVDSChXB51riJ+BqKKbzkhW6TTCJXgk1NWhqTUmE1C8EKTG520ZJVwfATE1Pnqse6Gaenn+o5T7jQ8A47dbnbBkQkmg9c2fkYxwMu/ik5RHmTXuGvd38DVVU+T5hb7x2GgABxrr/Tpi73+OMTiCTuVZK/Yvxf8uMDEEYvFFSJAT5l/cPyPrvCuxpdAWd13uO2TQhjxh7AcILpiCQY0vRtdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hrocSt9Ngrj/HJk89I42sfWIbVKaSLOoXxElgYsJnFM=;
 b=nTomWilqQPmAjjF4UHRbHN7CTmrJmjNOR51tfgMJuTrdmFXPfUQTLteKF7PMlVg/+HOXO+aUwOT6S2vjXThLcPfgrjJ8g9NzeIBnkdZqio3TNZoJmgnuuemLAaueDzbel2h6P6qEZf3DnYIEutuzg8W2Xg/rfcjERFkuO4/rStZd+xjlQLPL4emt5RU8esU7ot0RPnqUlnlyjlaVAE2ZkHF6Jzw/5DvU7NHfe14jIN6VL5qmkcQFTTsUhPDvD7waQjR0CCaAoj8sWHFZqClqjt/rvC5ELuV+6fvsykcC9MibIZ1TTQAuFYrhL32msDLSm5gMUY8LtPFTdB/M8ta76Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hrocSt9Ngrj/HJk89I42sfWIbVKaSLOoXxElgYsJnFM=;
 b=nCMDp4hpuLobxQjUuWG0Zv2ACH+epCjE+VVdVHAFMZi5K+joLTI5aaON3uH6cVsNT5CGconypmHk7lLpbDXsqzMUTgr5dORhPU7hpHTRKCAEY78tGoLermquuxvUWEWTkRUI9DMKAg/nunWFN5PsCECYh5nZ6xs94MaVTtvxQqQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY7PR01MB14326.jpnprd01.prod.outlook.com (2603:1096:405:240::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.1; Thu, 8 Jan
 2026 09:30:46 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 09:30:44 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 00/19] Add I3C support for RZ/G3E
Date: Thu,  8 Jan 2026 10:30:04 +0100
Message-ID: <20260108093023.489513-1-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0244.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::13) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TY7PR01MB14326:EE_
X-MS-Office365-Filtering-Correlation-Id: 705f7713-91c8-4f56-affc-08de4e989921
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?X4ZOkzubj/0rsvDiH+z4AgxuIZme7CfTUn85WGUfAu0TpkxwhhWrV9NTKvdP?=
 =?us-ascii?Q?ZRuKVNA6hHt/pRnaZxIAj4PJOuiLAfSrW/+cZ3d/KuhHxY+HekPrOKWzE9f4?=
 =?us-ascii?Q?GtwyWolTvtom5JjZ+dBxfwgdlcswp/Lcq1ZiSqAqxp8uPE7BTkf99gxuWcTp?=
 =?us-ascii?Q?ucTBEjd0Hf8GudSTKvqggbLjXmkpu5Eoc1EzhoV0+lUkWZ4kTgg8ik1oAJJb?=
 =?us-ascii?Q?Ouzb2FgGU2vE0g0rrtiSHL3GXeAMyC1kri1qEYnyY8lEuJH0v7HAg+/unTgM?=
 =?us-ascii?Q?Qd+VPPyddJku+3phKzHgp8qyzo75AiK2YDEo3S6X0Ojh+e9yDoPZbNl/QlHh?=
 =?us-ascii?Q?4+bAwiY8Wy8e0VwvkCwBmAquHL5hZaK2vLw843eLCJ6h50jLY0xDAXk9ksnB?=
 =?us-ascii?Q?ikfuA6UtXz2W+hdp9cWP2XXZ1XhuDseC09/iprnTc9/HaR4+girNVcaFD6iM?=
 =?us-ascii?Q?pq00uxWPSwz8M0ATgjpHzhMZGECg34YtZFP8DeORJHJf5zj1UfQv2Q1Ip4Zf?=
 =?us-ascii?Q?W/waZipwnDjQdpIxWOSN7fwCcs6ZPiaHKmZPKP+RGlqArdRshDWQJr22j5r8?=
 =?us-ascii?Q?0FrrXrh49i4MyaXjFpDzvZVZHCpyfIDZitJpndKUySu0MYkS92Mvf7Q1QozE?=
 =?us-ascii?Q?TjlSvxvNGAtsQMWMI/iRD1fA1Bmg7rTi/A70fNvtN5fgSR2P6k/W3r4iXF2X?=
 =?us-ascii?Q?v3zpJAFKbFFPZbwsC92uU6+EFsbBXMQ4z3er+q4sTKhFsPW/fyF3FsRMc1e0?=
 =?us-ascii?Q?d64z+j1mysgdxWRXPPLSaHFd2i4e5ej6SP+Jgqtv2P8xe6QfzFLXZZ0Rbmza?=
 =?us-ascii?Q?jFrELtKNOIcVNATTEP9oYqHS8rdrrreKL/4lqPAoWZyZxHrmo1cMuUm+83bH?=
 =?us-ascii?Q?fjubBymXkYQKoxebv9/MfkRivCXRty1gV3VuWZB/aectc8Qr8qZJtUSShyk3?=
 =?us-ascii?Q?1h6Yq/2iW1tO5vQymI2UV8qEUzUVSk3g3ZqxteKvUZVr/b2DQR1oDH3+3nZ/?=
 =?us-ascii?Q?BZByxunp60USFmf4uumpQFbMOFDJYgLfSy2ESWeN0tzjhbeN1i4SvXImV7hZ?=
 =?us-ascii?Q?3Qv3v2mJ0z9w2XeUjrFqlU33p5GEEdAx1G7ZXHTnTR0No1c6DsdR7UoObJdd?=
 =?us-ascii?Q?V+tqVbcgwlVKkNNdzba+rl2Ukgc7+l2UjGFLP7xoLyYieS9dhVTSKBEg+0h2?=
 =?us-ascii?Q?1hCKVeTR4PiGwxjn+0thNyjg6Cfidp5DIyLvFUUBLZRsRvPwdAxbHBVg03ey?=
 =?us-ascii?Q?NJq+WfmoGKlywQAs2xDLaZ/Npl4enjmS+nzguSK5PTUNR073XK/VEyA4DhAk?=
 =?us-ascii?Q?JNLdjLzw+HSxjYCcfgmvnSC7LUlK0eJDyuJeR8N9MWVu0IzWp9ZN+e0UQphs?=
 =?us-ascii?Q?Ushlby2OuPMHcmbiOO88bPROh1Bd4YMNvPQ/bZ2rwpi18P2tAnflzPoG6Fpg?=
 =?us-ascii?Q?iEgI8+0P5X085NajEvmo4TUiRbOdp3aqZOMXnicW1Y+RaJybVaGWEpk6T9vw?=
 =?us-ascii?Q?uNCZzLZW1Sn/T5noiFWDtjlsMitNaeyPvN4v?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?6QqNcmAux3zxmh/b0hnw8K4DKp6r4Qnk8CGtMyQznsjDcwukvl8xJePBPYjH?=
 =?us-ascii?Q?MxtU6TPnfcg99z96iEYXvOl1s1+RbyTmbGs5wSpDmPiMQiwypYUNFw0ve057?=
 =?us-ascii?Q?+GHrbQA2XqIuEVFSJhY+attkTECNFR6fm6kPKhs6eDxu8UyHJjuAv8DwWBJZ?=
 =?us-ascii?Q?YH9SCL3eyW3NKhIZcPyUIAC1Ms6N9LjUSgFAOsaEA4cVeDtVG1MV2NgVLo7/?=
 =?us-ascii?Q?t4+enztJKys2iyJgMBbsNoWXmV1/L0tk2PkCe6c6r6iTAp6gzcs5DF8U0UjP?=
 =?us-ascii?Q?WNQeO5RPLB34vu1LZoj22LNshSf8ECsjLWGerEKOn4lsqiRTkZ1T1/LxCkTW?=
 =?us-ascii?Q?SYYmNsW0rmIMySgNPZhWXU5+lgJ9rgImNq/yeJMcvcchQwV65E8Dmb5YWobX?=
 =?us-ascii?Q?EakETfIgSYk4HhcMzA3l6ItO1KyI35Zm+jIl92e3J70ZOaw/TZ6ejHq8JUbX?=
 =?us-ascii?Q?i0OHV2aWBQucnzgNrRUS8cix6BcZaoOoH63VhfOanTlNLG+vP+EroMurC3nS?=
 =?us-ascii?Q?jsEexVm5DlA1dGozNu241/dXph5zk1AQIEkKPYgATwgcOghVNSf4Iqd/1P2p?=
 =?us-ascii?Q?2boPjJGOPoFt//+YWgvBQivRosCxuQsJWnsKrwbGbV1Jfn7qghmmFCz7nqBl?=
 =?us-ascii?Q?WK7QPLD+JGXt3lWp834UfTqH7EdxWSZarvn9AgBqkwnuZNHvvsnbw17VIjBL?=
 =?us-ascii?Q?bNDMzjZveV2eWWI3a/hJ6UUjzq7bL1EzyB8TzouykjDAfzHTvYAW52PCnqDH?=
 =?us-ascii?Q?6RJY9nZl9KcpTW0AtuQSRBS3HJfi4HDkLdbWQSe/PUank8u2msH8lO5Vvf6E?=
 =?us-ascii?Q?tZV9goj3GaqCcxIcZvQOroIY9s90tOm4FE6NaWBScL6zZdqHOp0CDdu5UTWD?=
 =?us-ascii?Q?ILAUqwmhd+XMgEwfeHDwW50BoWNzvPO/BXgWMtJ6yh+PTvhLIwpbIWRtj83N?=
 =?us-ascii?Q?8W/Ewz84dxmWEaASoW90z70cdJ40WuRjVCm0qKrXU2enjujDW1BjYo9wFHK2?=
 =?us-ascii?Q?QPvd2xyu05oDlg//bvhZXvZIzSA2fibKtAQdXpENWajtktKFyUGSOeKiNDWO?=
 =?us-ascii?Q?sbBiuJqBGK+B9LkEpJdDBKd3CLzinrRtidfc7Q82xizp9iTyhZRESqxcnZpt?=
 =?us-ascii?Q?4HvJf5jeumZeEeucgxAYB1lNaU3OcNVULaxAkBp6UFuhPxf04yzK0ILNyq2a?=
 =?us-ascii?Q?y6TS2PdA8ZNUx9ZoQpKOiAASqB7ogwP2r4fhCZ95KsdstYAGnCIhOnaU1xfr?=
 =?us-ascii?Q?Cx3t9H6Rl/IwIlX9C8RtHIJmevUiGerTc3u3RTUS2J7JBhZGAo9NQCJ265NZ?=
 =?us-ascii?Q?1hI6NKx/isGuNhrqd3Xm1GQmRd8PNAyL8rl+BgQMVJFez+69EY4Ra3VFUisr?=
 =?us-ascii?Q?6+lC79IjBMv47GigCWGRECNXXoBVsmUGSlp+VSbLL70fg9iA8SyQ7Y5Jcw0I?=
 =?us-ascii?Q?dulvCq5Otxq19ACrgzfe6qn2WJDAl3yE9DgNQSAIOTWrCVkUfii8BTjuTnIz?=
 =?us-ascii?Q?3yXdb+LwCiblrAQL+PFFsblcdyX11HUhvIup1Spw45oyaauCBZGXp5pNRiOB?=
 =?us-ascii?Q?vEpvCBYIaqA2z23nHKtCo6QvWsqQxuhS2hZ7H7sNsIU506HHbFQDxi+uCySR?=
 =?us-ascii?Q?njiXKPwFWuj56nJZpXElzCvwkdOFsjkCR3J3eQ9wl21i8ea5zelXBBLcW/8r?=
 =?us-ascii?Q?Mt7D+zE+oZvoy+803gz3851tMLxNcvXawaFvmuCOb2yay90sAvZZmU/qhdf9?=
 =?us-ascii?Q?GSQJ0Lz1X9NTnOh1Yt2vhijAfm6wKUdp8kis6rSglBZLs+QsNcwF?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 705f7713-91c8-4f56-affc-08de4e989921
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 09:30:44.8132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4NElN+76g71ygwAhw8R0wtS9nCXqSt+BlMyToDc+tkt4+wjUV3SHDNOUTby1kIv47hS8zJITmBHROOPwXoRRUxauV2kvLaDTC8EJBmtdrSQJqo8TzdUtBxqTBFcBdZVf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB14326
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Jan 2026 09:31:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21459

This series adds I3C support for the Renesas RZ/G3E SoC into
linux-6.12.y-cip kernel. This includes also nxp,p3t1085 I3C backporting
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

Jarkko Nikula (2):
  i3c: master: Add helpers for DMA mapping and bounce buffer handling
  hwmon: (tmp108) Do not fail in I3C probe when I3C regmap is a module

Jorge Marques (1):
  i3c: master: Add inline i3c_readl_fifo() and i3c_writel_fifo()

Stanislav Jakubek (1):
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

 .../devicetree/bindings/hwmon/ti,tmp108.yaml  |    8 +-
 .../devicetree/bindings/i3c/renesas,i3c.yaml  |  179 +++
 Documentation/hwmon/tmp108.rst                |    8 +
 MAINTAINERS                                   |    7 +
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi    |   35 +
 drivers/clk/renesas/r9a09g047-cpg.c           |    8 +
 drivers/hwmon/Kconfig                         |    3 +-
 drivers/hwmon/tmp108.c                        |   73 +-
 drivers/i3c/internals.h                       |   37 +
 drivers/i3c/master.c                          |   86 +-
 drivers/i3c/master/Kconfig                    |   14 +-
 drivers/i3c/master/Makefile                   |    1 +
 drivers/i3c/master/dw-i3c-master.c            |    6 +-
 drivers/i3c/master/i3c-master-cdns.c          |    2 +-
 drivers/i3c/master/mipi-i3c-hci/core.c        |    2 +-
 drivers/i3c/master/renesas-i3c.c              | 1404 +++++++++++++++++
 drivers/i3c/master/svc-i3c-master.c           |    2 +-
 include/linux/bitops.h                        |   31 +
 include/linux/i3c/master.h                    |   48 +-
 19 files changed, 1911 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i3c/renesas,i3c.yaml
 create mode 100644 drivers/i3c/master/renesas-i3c.c

--=20
2.43.0


