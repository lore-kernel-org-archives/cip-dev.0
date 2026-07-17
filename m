Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D19C4451C
	for <webhook@archiver.kernel.org>; Fri, 17 Jul 2026 13:15:30 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13194.1784294128494967485
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Jul 2026 06:15:28 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Ri4vAbET;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.56, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xELHnKQLZpKDFwI1JRZHlXX/FZTgmy8XVniZpKA4lomuLLpI61X4yuUiR8WNAoP8sG2qlTMKiYZk+XOqRJNysnkYFE50XE7NRParmNzRm77yeIYsy8zX0JxqEIz87VPbpYs5x33lnr5dNbyfPekaIkQWeNtyfNTYm1Q++Lp4myz6mNO+O6/zmAx5lKMYgkWp2/cIjvHt78MvscDWiEoyOG+5jTBvprPUuQ+hceAvtbgO8FE4CU4cp7MpM6TPQmk56zs3O30x7Y3a0PoktRQlj3qjMslorXHamrIHPeAS1SK2/5QpF88u15R0M2Q58snjPyscqcMMvjK6++K/uU76ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qWCaYv/shxw4Uo5H5v1cRra7KEqU9Z7K9vNKqLfimHQ=;
 b=YrzbH4zqvMDrSWBo0lN28ADsuWWO3j0n/p9yjEI13TN0JRPzOW4yZmYLN/Ata6n5w2zt+xsMTVOZbVcHGba/0y38m5KpYV+/OFT28R1XWmPcLld3us4PeLhYkE0mGHLXS8/rztRLGSoUPh2ZMgeJwglXP+HSeONJ1A5VASYu8YF7+JQ0MTtXYd0DEO5wPuRHq+/SAo7z1a4M/GgGcxPb3WJOzRxBkjHL5yeokzGAyVNff74uc78gLs8yAPnhfFXLt+pAoKpJyWzcJS7ByEzWpDC1W397zOu+YR55DEE0C4lWVOW+7pI9NIe5n3chCseX6PQEnZ+RCIOLYqjmdhGjgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qWCaYv/shxw4Uo5H5v1cRra7KEqU9Z7K9vNKqLfimHQ=;
 b=Ri4vAbETL3XhAZvRn+rFkdTqTejSX30A6b0WAAJLnPNcZHsPRokmDrfCiPL2VQlxWnP8Fssy0Kd9h33qLdHDqWtStUG/MWOXAC7dCO7en73FvDVzd/VueW1u5QB2QjcCzpoZVTyuvVeV22n3qgCERuhEhNK8SjTsts4TZbCEY+w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by TYWPR01MB8447.jpnprd01.prod.outlook.com (2603:1096:400:174::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 13:15:24 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 13:15:23 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 00/15] Add p3t1085 and p3t1755 support
Date: Fri, 17 Jul 2026 15:14:47 +0200
Message-ID: <20260717131502.2234020-1-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0041.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::6) To TYRPR01MB13588.jpnprd01.prod.outlook.com
 (2603:1096:405:18d::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB13588:EE_|TYWPR01MB8447:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dd126a1-af4c-48be-601d-08dee40575f5
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|52116014|38350700014|6133799003|10067099003|56012099006|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	yAhWiTvCIwqXrRf9DFwb6Wu6xYS69yDEUx2lbccFKswF42iPjmj43Euyyn5hk3Rk9lpo/HaWL0FZ7lXPZp0DcBGpaz4SLv3mP0yI5DcAUQXv3aEaQmdU+mDjSCS7BmViWcckj4qdJ9Rse7Ru69t0atKkjeqqwIFfC8HDTpZfVMGxYr3oXel1Vf81+fh6xy8RjzLCv3wUaw/WCN3MstIOgYXkl0TIPIK/ncSvKHiSevj2GnnjOPsIQGJIhh5QVB2Fi6wV3n4QFZOwvR+hXM5DEHqB+N/2EdVkgCKzs1n1x2PsRsOhCPcEXJpWYs1NlIv1SnVnyZQ0TdC4ypMMnhc/dF1lAlNR8S/5eqeaQ4ld8qYgxhkBTUnEsLsNPAEWgqhwwxOUHYvW9gVN5srkmopJwNaRL6z9hz+5z6YgxyVI5vuuqmmoLeoWpGEpRo8WIiV1pMwBbt+lN3awRRyK9UXgYeDlE8knlRhAxbHaiNhTqKVGfD0sCEVCyqav5eAh0cL6XLRML1KJ49hF/XOnr9Dswm+Xz4wJ4ZHLKft1tsaeg3ZvKsKTUEM1rR2+Wja3kLgMx6tgT4A/uthAhTI+SpVOsiQDp/Zg5s2X9DEvoWhE0nP0dn38zr2gPB/tZlxyd4GTxojgXI8rrYdA6YJxdvNml14M/RgOHv+NHjTLVcG/7Get/+srMjPdfWr4lnLdxdxNQbjLEnZ1YA5feKIgKerM7JZDXpTLLcIgsVVKM2irAX8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB13588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(52116014)(38350700014)(6133799003)(10067099003)(56012099006)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?rnbUIR5z0fCKkqMSBc8L//68r8JpBuiVni9j8hVD7cYLsQBPxXM8VE1JwO/w?=
 =?us-ascii?Q?hPosJ9kdIHLD9BpIOmf6TLqepRV0RMN3g+tq+dqWxtOJMcSPQGhYuUsprXoJ?=
 =?us-ascii?Q?SHyrczprmuIgLvraNQbNq0btea5vbyWAPeF3TODiyZ933uYQ5Xla0cfTHGih?=
 =?us-ascii?Q?lCD5TpATFOYHzRBg/iZH0CSxg42fwvXUfl2WNKvP3FoYBAIPc4SttSdwLWgA?=
 =?us-ascii?Q?pmuVCGOA4GU6DORE7CjiT1MSHRUYq0enJegHLtkT3FZOQvGDN3RClFmaSfPp?=
 =?us-ascii?Q?871pCyssGhC1rhIrPmHZ8i4mpumGHtSEHdvnOkxkkGQCzUjxFaSH5aG2uScU?=
 =?us-ascii?Q?DumpOM3MPOajYvQZlz4TYkQfnlnzt3mgh+H8mTWexPZuBNWC5C03HIdtQRpz?=
 =?us-ascii?Q?h3XikIa5mejt3wBDE4NnFqixM/PAeAczeRtpD/YNINT4alPTHn035lvkcTNq?=
 =?us-ascii?Q?2Qy+EOAHA7gJmZO73rpuNvYZrkWT8FQEWt5SoYddBL8HwdvzrsuBhM/hvhnp?=
 =?us-ascii?Q?/PHuLlOz7qWuYOUqod1sijfjQGD1eHGD5bGlvSbOaBsjQVkaiHrDLOSnzmjq?=
 =?us-ascii?Q?9Wr1z6sZ5MCPMwejLz0YkVBboR0v/jmd2UoKMLt64GNf0WLh17+GwsqbSfIJ?=
 =?us-ascii?Q?Ai3OgbCfCSbsDBl1IoTVrtwJSX4UrRcXUYak/xLqcp67ugB2GwWXnuTqiA6g?=
 =?us-ascii?Q?+SQjMkXZE1cx0XCvKrhxbmKOrtqCkWroNAA5drWTTVKdUJFg1uUnRF941QRV?=
 =?us-ascii?Q?eD1+998d/Th/fQPfx5mfs/mnkQtpiClp3JEpKeQ7NbDge+YxcEfU2eHuHPrz?=
 =?us-ascii?Q?8M1gNjwbAGjNuV8lLq6O6kS8n+UKsx/D9xgRet6YHGWzxSy5Ta29VPSETBBK?=
 =?us-ascii?Q?W5OLCfvKtQ7qLH6WrRws4omTNo46kYUvLH3My4k48f5IDSFRgfMlG+Hwg8CH?=
 =?us-ascii?Q?Y+OglJ2wyOqwDV6DeYPNbEyAqXs9AwPeZ6Heew/6UnslHCvDxvoWO51GOdwB?=
 =?us-ascii?Q?gDHMQxBnq4NDj2122bjZKkc3oNGsA9iQa6+64fu9fyBtaW+galvP3hvO5Y2D?=
 =?us-ascii?Q?BiotYCp9lie6sz5Nb3EEf3rfkZOR1ZRDMIVbXMW/MnMj5Z2TJHfhC69IGlCy?=
 =?us-ascii?Q?HHp/d6Ik0kThX8L9zzxzvQuvJeC6JgFXNn1YniYTBRsxctbbKY4BXjKZqYRp?=
 =?us-ascii?Q?pInnJe5r3AWhZuY1f313HxIrLjX1r+wBRDdIE6wvGiQscfGc2rqFWHSIrtA3?=
 =?us-ascii?Q?Jy1hzMQqJ71ChpmcvJj3us0eU0naQ7GzlD8VQZdkZVWqZaJrzIQhsgyC2NcA?=
 =?us-ascii?Q?6ubFJiHQn62W1sqRPKwiWWakdmCofYXZozkOQoc3Xu/ruDrRhgn2e3z0IPNS?=
 =?us-ascii?Q?PS6sH0MbhnGodVRngjqRJ4TnXL2gX5l16AO6moN9H474nMgP9JYzTP5LrJs+?=
 =?us-ascii?Q?OO7wtD5Obk8vcftrtlp5aTYzQSZnHKq6DbIpQka3/q787bFMThqJI3cCTzey?=
 =?us-ascii?Q?+xRGAQ3+b5SddwcfQ6cXLSFyt0V/WtlTarIFFHi7yG4smdWWR+noWzc5nlW0?=
 =?us-ascii?Q?lEgnuRMFJVEQe5pNHV4N5GMXdYAbxtLUHx7lltGI4nADyHUyEnvLjlZIvzyF?=
 =?us-ascii?Q?3Z0/p177vx0euflKPraTt8esYhYZnjumoNf56gCnq1f/LSQ4fY65pT+H4ift?=
 =?us-ascii?Q?yw4o9xWyhSmFm7X0eRtVvdP+pahL+a+m+c7h+V1ykaAjiB5P8jhqb6suaQtl?=
 =?us-ascii?Q?MPEhvpBG6BQ/ESoY4T1oHYip8L4RxBGqpS+Yhvqb6ipbp6K/xU3W?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dd126a1-af4c-48be-601d-08dee40575f5
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:15:23.8894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nz6vqD+/LOMqUOQen0x8qSWdTy9j5L8+fHYGnrP3dw/yVM/yrkfVIYUvE+emt0yuHJael0OMDfrRdkE18h/FlGgdSMsuIjeoRy6hi80jgNT/11oh9mJMOcnbdAmivhPs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8447
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Jul 2026 13:15:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23652

Dear All,

This series adds p3t1085 and p3t1755 i3c sensors support into linux-6.12.y-=
cip
kernel.

Kind Regards,
Tommaso

Frank Li (4):
  dt-bindings: hwmon: ti,tmp108: Add nxp,p3t1085 compatible string
  hwmon: (tmp108) Add NXP p3t1085 support
  hwmon: (tmp108) Add helper function tmp108_common_probe() to prepare
    I3C support
  hwmon: (tmp108) Add support for I3C device

Guenter Roeck (1):
  hwmon: (lm75) Hide register size differences in regmap access
    functions

Jarkko Nikula (2):
  hwmon: (tmp108) Do not fail in I3C probe when I3C regmap is a module
  hwmon: (lm75) Fix I3C transfer buffer pointer for incoming data

Stanislav Jakubek (1):
  hwmon: (tmp108) Add basic regulator support

Wolfram Sang (7):
  dt-bindings: hwmon: lm75: Add NXP P3T1755
  hwmon: (lm75) Add NXP P3T1755 support
  hwmon: (lm75) simplify lm75_write_config()
  hwmon: (lm75) simplify regulator handling
  hwmon: (lm75) Remove superfluous 'client' member from private struct
  hwmon: (lm75) separate probe into common and I2C parts
  hwmon: (lm75) add I3C support for P3T1755

 .../devicetree/bindings/hwmon/lm75.yaml       |   1 +
 .../devicetree/bindings/hwmon/ti,tmp108.yaml  |   8 +-
 Documentation/hwmon/lm75.rst                  |   6 +-
 Documentation/hwmon/tmp108.rst                |   8 +
 drivers/hwmon/Kconfig                         |   5 +-
 drivers/hwmon/lm75.c                          | 339 +++++++++++-------
 drivers/hwmon/tmp108.c                        |  73 +++-
 7 files changed, 297 insertions(+), 143 deletions(-)

--=20
2.54.0


