Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3CDC36010
	for <webhook@archiver.kernel.org>; Fri,  4 Apr 2025 07:39:01 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.60])
 by mx.groups.io with SMTP id smtpd.web10.6098.1743752336007445269
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Apr 2025 00:38:57 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=IRqC8a43;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.60, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FLRZd7/gf0Q3/aaPm9JOo1mzc5nbeejTJVDXL19ImJbcExz06MgNTlkV0cGG5glA4uh/HV7PDng3Ucu+fKbpxA2tPtYVWLP6/DqPVp73w3d2TVKFS/K67tXRyZZ/FwDQnvAeIOF5bzOR0osuSU9c8yalitPoaV4BMQSYwNRn3+rwFgRMvg8XaSHh5sN2jtRlkR2VRNrYd2HiJtC+4Hrfeip4B0h+gNcBWoTrwJyNDOl83z725eszhUJJ8TumxNfa116xnzihs+9BVWB3bKSEs48xeD+xCIfiLE74upDZWH80tM+pQz6hLoN5AXIjz+0HLhnkBdn9b/rVDih2kLvlow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KxwmkwaO+6uEhmdqhMZnloQg146RU+j+KGY7TkEr0is=;
 b=G0J9vqw0R+ePTy2gXOHkv70/PctSV3H/SQ/en0Tkc7qSsF8/G+3Zx4r90aq2KI0U1296RuP1p3jOVcUkMnrOjgzyhcumXQEo0Y4jH7Qvzj3rn75C+qAcMM5ZTpegnF15Y1K3Qkyyc2tVY1S3Dhd5yUiW4uZ3OouiHhpDo7oNwkfDpDqZ5mw3ph4rsTXfp27/ii4oiGpQLPuLH2yrddX3OpA1sVU1PWRzP31SOiXqPEQn4OMe/lJBFhWdjE1lCpLzGNl2AAvZhwX9ponoZaie/TgIYCIairY2dwSQkRK5SGL/vTi3XsvOPQAzYKjgFkwJHmWvA4blkBFVLNaDUjTk2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KxwmkwaO+6uEhmdqhMZnloQg146RU+j+KGY7TkEr0is=;
 b=IRqC8a43wb1uhkntqskIn1mRjDcgb4fOma8/VHiknV9bkq+tVA9XCe8fD5e1KMb/jk9BxmuvYyS1deN3hzn/RlJI9Kk5f35a2uDzjCUhDsPhCA570QA3LfwXqLBeKQz5LIK+tqeU1KonRxnp9f67NuwLz0Ym9fF2aKtUxm1zQbQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS9PR01MB13254.jpnprd01.prod.outlook.com (2603:1096:604:313::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.39; Fri, 4 Apr
 2025 07:38:43 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.038; Fri, 4 Apr 2025
 07:38:43 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 0/9] Add RZ/G3E RIIC support
Date: Fri,  4 Apr 2025 09:38:10 +0200
Message-ID: <20250404073819.173272-1-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0438.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::16) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS9PR01MB13254:EE_
X-MS-Office365-Filtering-Correlation-Id: f2d963a4-e1c4-48c6-20d1-08dd734bb9de
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?lqxu871enpduL+eyboKhZ01vPNsarS+v4ofB1+286K0iGJ5ZNFVbr3x95fuv?=
 =?us-ascii?Q?XtZALWLW4mee7j8rHM/AlxEqtRaRwS3xiikfTCoBdASZy36aRzFuz7pfDnvi?=
 =?us-ascii?Q?E6tXG1gLp16tZatz0JB/q2M9m5HvVYkHwNkY4bw8n5WBeSK2JCGjlJ5X7Sxi?=
 =?us-ascii?Q?ylaDu3hupJwyfCyjIsJq/vTbmoiJ7lGBuVvWmPEWz1CC1gUR/OQFQvWQFphH?=
 =?us-ascii?Q?YES6fJT1/bjvrPScgCMG1R6mi8EsJseVkzUzOuTr/fvyUStOiIQYHZSi0iE9?=
 =?us-ascii?Q?SX/SPvly/iI/gI1P9PF7xkBTSn8uBfVjVzZhIv7tMKwZ3knnPR0gWG3xi0Im?=
 =?us-ascii?Q?OzLhJpwzzHJmBV+h3ajMktqVDYgItbvZx12zXvvx/HU+Wuc587j+B6D9SyUy?=
 =?us-ascii?Q?1uVz7QGqnmpllohxIOqNlRp5ysN/KI3YyLc8dAo4HcD+P45cPN4BbVHK164Z?=
 =?us-ascii?Q?/MZeg/cCHrkCdaOaMKMyrX/c54qJG3gbeHpMhwLUEWcGrjDCcRx3X1C4eGUD?=
 =?us-ascii?Q?SreIS61QscQYcwQqY14fclflLSB9l8WVbfWgpeK7pm5RTHN9k/LoOuIOpi0b?=
 =?us-ascii?Q?jp3+nt9/BpU6saKpdFz+1eZqDkdFZ6SKoSKoRqGd3RfFMyOKMvw0cFYBzj4f?=
 =?us-ascii?Q?vIwLuL+aaBYk+vk6aFbSKeXMpZeI/PpqXVWLnafOcyoAhrHGFgFiFxQ2lxjT?=
 =?us-ascii?Q?ukZpBrLt7rqRVqKH8Lqpgnu2Sprvzh1MLlwE1OUdRQfklbRCyws+syZScsO9?=
 =?us-ascii?Q?HlCWT40yZLUGCu3puzTW5ENlsLmUXXBNs7ki+DB0rL6BSdznCAvliPHZ+Egf?=
 =?us-ascii?Q?AJy7Zwj3Ozf9IrpffMHTo2ikWW6tpa0/hkG3ZBPoeqGSpfX4mdLiE7U3+Ggo?=
 =?us-ascii?Q?xRdxnj0HYq3axihSLSHq4EoTl0NdCCiPx9nKXcF7Mf5nfso9hQ2mygeiXd2b?=
 =?us-ascii?Q?GBD5aaBR9GUCnvWo8YuzHCNY5f0vn+abuHEWrEZwKMlZQGY0d1doiimm0wLV?=
 =?us-ascii?Q?PI8Ws/nnL0JHSrOHoItxCzheKGSbPxUuPTZjosJDnPvEZd55DZUTFPxe9zG4?=
 =?us-ascii?Q?/PlMuKB0YfK/OO8V+Y0vl0nhGuegMsWGK0Ut8nLaqKgI5c9KDaIjhwInt10R?=
 =?us-ascii?Q?oj7eoI5te782rqd/SNuIBhV8UROTLO92FKS1/dLeOXsAiUcfCI8VUH21pWh2?=
 =?us-ascii?Q?vmyHT/5A5oVoNnOZGuwPoDfFL0Pi7oC+6UTZqA7wUYQsEzWwCGWrDu4j3ISK?=
 =?us-ascii?Q?ULnSmSHzBQEC3XbfRsvWHu9DXMc+iweA56VqtDBSVF7VNHU7uZr38MT97MsK?=
 =?us-ascii?Q?mTqr7382NfCjDCECM45nzyUVuJnyya9DJHWKZuNm7PTxtUVUBjQySaOjHO3I?=
 =?us-ascii?Q?TeHKnuZ/ZKrDo60Ujc4xuF7K8AQPVc8wK4kFMgHgC2I/JSTem9xUxlvR7LBQ?=
 =?us-ascii?Q?oIED584TU+qYiP/cAc/vDLFGGQ6eh63j?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?HzFPmh00RFEO81/2XO6YZUEj7Y6V/yKWXY3s9MNsIw1WHrgxWZEtiy7knsVj?=
 =?us-ascii?Q?iPfsX4Zqow0mOs8A5PFYKw36UeObkElDCT8xi++KFipzV+MBsQO3rU8iYc7e?=
 =?us-ascii?Q?pj8WYsy6dHUZh7FSm/lNRcqUDft0J5QBOiZgPdXRenhOV7RuUwRn6D8YBHDv?=
 =?us-ascii?Q?DAlDEVfI21VSh/s30pzFvb6zreej3cjQU705vV/1vn3QKc6wWFL37Rpf/d0/?=
 =?us-ascii?Q?kLplmZlq4crjHic3/PphMG2mb71MFrbaLRO/0u9oOvdYvMF75mOFVy8B8bje?=
 =?us-ascii?Q?4mNmeOiH+3I8DS89VhoWsg75H41FJRXO+dyzwfswU3B8wTLLIVpNJ7kThpbw?=
 =?us-ascii?Q?l0GR8iXglXE8cZAadnJuSUm4OUUaXxxpv2cbV2SdtibFkvMmoPQ8dLDFO91v?=
 =?us-ascii?Q?6JEhLFAdEcO83gVO5H3/N46NCuV6Wmb8VqYRvloYiP965FyMA0Udzu99mgQM?=
 =?us-ascii?Q?yADmffTeVhwYVj6MdD3u/tOWOAakynUV53/7b3HecRSE93E6AxhKP0zFDcAc?=
 =?us-ascii?Q?div8c4xJAHDTMnt/khi7Mxz4/2i7GXzUfyOXklOffM52gf/MGs1xQMiea6l5?=
 =?us-ascii?Q?pokLl0/GjN7sonBg7RWZOGzKlbnxl8Dw3enFAEx88v211gSTwJlPfUTUwLKE?=
 =?us-ascii?Q?pK416rdmscSsbsneFYMXOCvaU+KaZ6jC8HJrFhO4unGRnOJ1kPFGCx4YxCAg?=
 =?us-ascii?Q?UKIDF/Lm3qpb05EN16IIiKvCtaESI/pK89+/hVk2SUzS5joD2CkI2y73u681?=
 =?us-ascii?Q?zmP+QQYwPUW9r2croAAvYA9oUf0P1tquejCHNw6FF3NHxOZJsK7m/qqqhcTW?=
 =?us-ascii?Q?YX4OGc0gKud7EYoZ0RiYQGPZGUxNbPQepk/q4qJXfGVKTGCZ6YB4D/twnPYo?=
 =?us-ascii?Q?bsJtabzj0zKbHLMUFIbypXO8pLGAyXkQpI9tq9kyjkxLIuMtjNWHTYeIQxqu?=
 =?us-ascii?Q?7XPKxiqvCu8OWnDj+BrvJNW1Qp+Fzi/1dUg86/9CXT78kOosA60bhdoCUEwk?=
 =?us-ascii?Q?487DTBkvxyoFwoofulEPUb73I1vuAzkSEhjmnzXIncL4y8gd64/Kcwqbuz6s?=
 =?us-ascii?Q?/qZsQjp1M+l8tFDmF9ldk2M0Su8VDCGFsnW4fE6O1+yRgzud3/ZAwFRKdaA+?=
 =?us-ascii?Q?GeU71A13zigyEZs5sQY9efiCgMAXra3+Zjj2UqwLyzMNlTMc1sV5A+vHyXsQ?=
 =?us-ascii?Q?ewaCuGBgufAN+VLxr8ifcDfLpPKRDRLJ1narrm1awTIYS7eRSE2EZ5rlwQcA?=
 =?us-ascii?Q?3Fajy7BSm+wmidDNEldi6dDmG3VpAq8AW6TNJ+6puwAQUhVt4fDFp1HBxyny?=
 =?us-ascii?Q?KoO6LkbvDF+kbTh3jyp1mDscq5YFXr0SsGfJw2JhTil8TD7VA2FlHszJC5a+?=
 =?us-ascii?Q?+1dH+coPqNAKEAL6RcqSViz8zWmcQjipSVWKUSdmpFZE3Twy1olhiHc+e7hU?=
 =?us-ascii?Q?UHlQo2L3hloEZJ187gJQqIoXR7wYjKTFXozeAKUEAhOIhxEQt5I1rjTeEkSE?=
 =?us-ascii?Q?EUJVpGyCdaFz6/bWdQOmaLqfQsGYO7A1nNuN/pGtKe0+OXb6BC794fSp6PUP?=
 =?us-ascii?Q?JBu7Y8Ppq3+hZ0uq3qj3bJhqMlMw3A2E6cpC3djxj+rBCUIceQPrdKZt1CrR?=
 =?us-ascii?Q?2z5j/cTSufwUfNVxAsessgM=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2d963a4-e1c4-48c6-20d1-08dd734bb9de
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 07:38:43.8764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wq4PVsF5yKVVD6vWJsGAD+K9+r2Kc2Hz1K52hWm31mx8eigM6wB3HzZ0YLMdP+IBkeowql9TkyhYCmetEKeH0Ps8bRsH2S2rh8RkwWNpMYHLxcd2bDF961FhHDm9I18y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB13254
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Apr 2025 07:39:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18465

Dear All,

This patch series adds support for the I2C Bus Interface (RIIC) found in th=
e
Renesas RZ/G3E (R9A09G047) SoC to linux-6.1.y-cip kernel.

All patches are cherry-picked from mainline kernel.

base commit: e423d82c34b97 Mark this as 6.1.132-cip40 release.

Thanks & Regards,
Tommaso

Biju Das (3):
  clk: renesas: r9a09g047: Add I2C clocks/resets
  dt-bindings: i2c: renesas,riic: Document the R9A09G047 support
  arm64: dts: renesas: r9a09g047: Add I2C nodes

Claudiu Beznea (1):
  dt-bindings: i2c: renesas,riic: Document the R9A08G045 support

Lad Prabhakar (5):
  dt-bindings: i2c: renesas,riic: Document RZ/Five SoC
  dt-bindings: i2c: renesas,riic: Document R9A09G057 support
  i2c: riic: Introduce helper functions for I2C read/write operations
  i2c: riic: Pass register offsets and chip details as OF data
  i2c: riic: Add support for R9A09G057 SoC

 .../devicetree/bindings/i2c/renesas,riic.yaml |  26 ++-
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi    | 189 ++++++++++++++++++
 drivers/clk/renesas/r9a09g047-cpg.c           |  32 +++
 drivers/i2c/busses/i2c-riic.c                 | 125 ++++++++----
 4 files changed, 328 insertions(+), 44 deletions(-)

--=20
2.43.0


