Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE6CCF6A93
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 09:29:10 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.20])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2990.1767864541085865851
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Jan 2026 01:29:01 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=o9z+nX35;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.20, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oci1EhuHcTGZrifsK4qqlhJqh+YGDRN9+4Dxj3Ff4Bw1YNUJMjpHufY1l6lUZEiZx/O5XLBvtMl8X2Dp8Tic9WZZegPKXJ654ouKnFDo2XmmAw0eMd0+VlgcSmrXXSBVOnQOyGAqqTbXY+qLfVGO76Eur2+LsO6s7lTIV0MgWPxg5puu4uUuZ3R2T7Ig6835AoyEKh5ZZsUco06Di/Ejl+bX+OmCWPJUeklIRM3e2xcT3dQtoh9VDqQXA20xio44xqYZmgij7GgKtWXGypeWdzkU0A/WJ3GWSQFI1VmRzWu9copxSWcc+DYY2mtrl4qnXvbtE79GcIedu8+iAzcB4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wKqZK0V02tj8GyfAKq/NIwPzCeLH7VHX9uflkR4je38=;
 b=P8UtZOhCNLqInEYchW8yBToZhmzFwLpi8eQmM65M2vWDsqDZFkNj78ZZyESeifBzFip9EoDYck7Kp69t7Gqvm/CJzr0H+0mzqBZYNEQciIPdzqB8HiIVbh+rcR1QBRsxdgFetygG31k5/zNPHVDtLCcd/9k0IHy8co8JLGFt0tdg2XTbT1tOt5mKLegwnEIc7mL8heV++pMZpcqTykJCOmI6OR6mngSYwY4oPHRRD3f+W5xwT3UpPxCWQEaw2HLwg7VNU2nr4udrIa+6CV6KY/mci7nHvc9deDPO6F0dQO5qo5kbkgZpcM7ncVG0vD+1BHDaj7VMBEYegtpIFnDbPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKqZK0V02tj8GyfAKq/NIwPzCeLH7VHX9uflkR4je38=;
 b=o9z+nX35ubWN/u3YbZBcGy02QT5tGO6SO/pLVwQ/1nWfsbI6UCOjwnvydOkHLeBaf+qboYFZ/+maVnnXLdw40UGKQO6ZX48bHmiV6LiAZEVlZGqZJKInt6z7rY1j6Z30UkSCxUUGpV9vKXOY1T+S1muZjdaxVcOQI0UXuSe7xdg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYRPR01MB12872.jpnprd01.prod.outlook.com (2603:1096:405:1b1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.0; Thu, 8 Jan
 2026 09:28:57 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 09:28:57 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 04/22] i3c: master: Add basic driver for the Renesas I3C controller
Date: Thu,  8 Jan 2026 10:28:05 +0100
Message-ID: <20260108092823.489287-5-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108092823.489287-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260108092823.489287-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0364.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::12) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TYRPR01MB12872:EE_
X-MS-Office365-Filtering-Correlation-Id: 85fa35a5-20ee-41a3-fc76-08de4e98593a
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?JLql8IhSEr1xDVuHsKoNgeAlfer+fqajkIWVZu5bTsQXnu1/sxPuh4gJR/2U?=
 =?us-ascii?Q?sF8M2Olj1+ejIKye7O/2Fi0p0fi/FHLTa/dKb2EFUXJiWdJxe6i3hpdeN4hJ?=
 =?us-ascii?Q?z1q/bAsIvEjzUhn3Lh/gu48CLuuHyjZvfHgitbgflCcGhVzagSzolulsyfYx?=
 =?us-ascii?Q?9fMp6Ja1sApJwiOYuKLJlK4npWHuGh17X0rqnnjGesES/qtbwvoTOOv7bY+X?=
 =?us-ascii?Q?tKsHW2pqRCEblKQnQ/u92f9pA+gP+NUElORC39oQSWZFTk3+aVvgMv2rdkMz?=
 =?us-ascii?Q?yo9opKzu/bkPOm/CyRY4dtlVq9AmCUFoJhUDgdGBIygaJLEvpve/zVQTjYY6?=
 =?us-ascii?Q?NenF2uO/Qy+U90tmdMy7aock2WVpFawqfwFQNhls0EHx9UnePFgZ8l8pKx3Q?=
 =?us-ascii?Q?OBBOYD2yVw4ASJnP6zXIIVGqFsO6yXZ4nwuo7Jez1yxgnntNiYMGBFYP2r3I?=
 =?us-ascii?Q?10jg4bXgM1UwcfpMtifDcjmpw3Fa6vTwk3U48suois1Dp1Q405VtX44JHIo/?=
 =?us-ascii?Q?lw1Kn1X61tL8R0z2l8e5iqJYWiBnrsJvTRT9az7Lcm8qWEGjBA/SHFS8MY0t?=
 =?us-ascii?Q?7FVULO5M7x3vlJNrjKMUmUb6kuhUBuO8G40T2CqdZVCvCxS0qGhvQUerKQTY?=
 =?us-ascii?Q?HwRwkukSQLMf0x+nzBxvsWF7xV911mIwLj2KLZ7kYoGbtQCJB+lG6dhxMtbW?=
 =?us-ascii?Q?XYchrQgUWjklEVetePwgTI2D289j6UOD/vl+AWLquDJHBGBXMQoqbP9F7A06?=
 =?us-ascii?Q?QxBlxIlFZKF6A0kwsjMPKOlAT6vHQQHQjd46IivpAHEFccXcaUGiPPzz8HhJ?=
 =?us-ascii?Q?tPHaw0xcC/SJPGQ8utgJzH4+9VfpXOn3hmv1GXaW/B33ZBCy5VuypGCCXzSu?=
 =?us-ascii?Q?NF4atRHEQoEO8zqtErYe/31XepJDz5I/5eiG44QktMfyMAYlRTwmQvPFq/pC?=
 =?us-ascii?Q?o8Ow57MnUZSKK8HWJuwEQTRogvvHJWvDpsuLyIMe7ixG6dC19Fy2oFoB14w2?=
 =?us-ascii?Q?lTVpAtrpyA1E6OBtUN+YlHDD2K5FkFy/tguDDSuqP74nBU2zQgFbz90EzJBz?=
 =?us-ascii?Q?PR1xp7Pd5ilN/jgjFJcR9s9LhqwyaRs+i2oPJeP4wd02LQ6Yb4JrjJhfH+5w?=
 =?us-ascii?Q?zSkNQJrQ/2FqEmgd1caUrZiIyyeSRc0Eadcm7PMNeZUWpLk+p2NL0YwiiqYP?=
 =?us-ascii?Q?GJ6JHI+rzQFmYxp/F3tDi/xAGNNT5h5cGcVqG+6ood711tpdc1FhFzCuO3mX?=
 =?us-ascii?Q?uoRUI62aX4UxsXy7S6vA+TfjxMaSCOWQqnbCiiBD+B5D3yKh4iaB/l22Vd69?=
 =?us-ascii?Q?53GJ0OLjOi7NCuMvP8OL5V3ZjLCCDoN7a0bE5NM6NZDLRkVdf7B4Y2ZYhx98?=
 =?us-ascii?Q?yYg5JVZdw0iESxwpjp74Gl1JSBR9rcw93bcc/TvBlDMBT/0wmqszBLBnxMbh?=
 =?us-ascii?Q?wgZV9XCL6Grxy5I47KRCka0wdD0ImkbIUteBS+g1U4g3szCtWjYY1DVyUNpB?=
 =?us-ascii?Q?Slk3a4w2Pssn+VS11kKXnkUMDRYfsLvsNNkn?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?91614Bfr6U0sCxg1qmjFnHrOOEphOAZJGIJotpMLT6LI1aeVmnNAZSbuLcU1?=
 =?us-ascii?Q?pmtUGPh2MzqpaSyZR21P6V9NSXoZA036ra7U5LcwXCS0mLXvzZKgwJZ9DLdr?=
 =?us-ascii?Q?1VJBkdxnAXe+4fk5SEVqsL47Kplod6RNikhzDGZ3hH8bz5k6XKjNXuQ2V6EL?=
 =?us-ascii?Q?NdshP0eRhhlNuQe1g+a8yJDngCnxZhxj9hbwyvkOpNlb/zckKilIZ6iNOB4l?=
 =?us-ascii?Q?fRsrC4uGUcxE6axkBlm0VaHsDSAxOORohX51YB9ANoYFeMq/Ak1tbycFUwLT?=
 =?us-ascii?Q?Ac+W/UHccxOYUahH+05pwyP3KeJZgq1l30J8G3fCYYsfoaRyeeu3qG2YBkrV?=
 =?us-ascii?Q?plLAueQUoT/VeRKm00/R0zaoXcmqI1f9Q81n/QfDm72Lj349LJd+X1BDLC1F?=
 =?us-ascii?Q?KmkbosyTYjriNJ4g3/eiCHPrlesoziXUbPci6u5iCbdhw3KzazPWq3gYpKV1?=
 =?us-ascii?Q?0j0HJdcJxfIbaHTr8RB17iCkUF3HavFTN7FTAkX6/CGQ6MswA7LuUYrHm/jr?=
 =?us-ascii?Q?ChlPa84w2e0nZYAqFWZcXzmd083aaP2Yta6hM7EX/zTnWjXBmJc5h8I5Uzn1?=
 =?us-ascii?Q?EjdilGLLKnCn2eOayWRijRlCsWyCNfN1Cp05Zqm0cfGWrG9xlVYg4yiGVvUN?=
 =?us-ascii?Q?H7oXsM4gv22hGF8BAOdAUnWnH2aW9JG2uRe4GdF9x9NrEDSlUE+Pa6fWPjdv?=
 =?us-ascii?Q?4KnLxz0uD4zZVY/zGsPi+HmHATX+YHLtJXhv9OqB08Za4L1ylML0D3T7Lj2P?=
 =?us-ascii?Q?fcXTkKVnkx5jb4OVYgiZB00WHHAMAVQ7N2sXr+OT4aoTGC7PtVJoCebfjAu+?=
 =?us-ascii?Q?aaYa6qgfDYzg7b29Gd9Bfxonncb9QeyFqxXmvbf7nPl05VpOX0ItozFmFJ7n?=
 =?us-ascii?Q?x4lMvW/wYzaAjSGfAll0uv25obWygozOhlI+AzlJ70+5eQFVGBLfB9jJGX3t?=
 =?us-ascii?Q?iEcTCm+fPgkCkIoeW/M9ULWHCg+HiW2b23KhlyS6BYLG3IzGotBUcVDaPGd0?=
 =?us-ascii?Q?Zf7LGHK2WdbZWEoxhQpxzfWeUM51T+6pS5NVT8Fa7B8df/9RZJWfZtxpCIlg?=
 =?us-ascii?Q?5wEkqAnQAE7dG6I3QPeaiqIb6rb+FHciYXxIm60T7wtQT/4j/EeRlG7oy+8c?=
 =?us-ascii?Q?cYuBPitziVB6lIJxBNGXeb7GTT0nlAsuNJ0AC+dE1gp0U/0NIyr3uLMG+1IF?=
 =?us-ascii?Q?apO/ctu2dltpDuscN8C5AshnI03BU8nyRX1vO84E5M2LqjJakz1Hbj1f3UDr?=
 =?us-ascii?Q?xCwHXlkUy3bs51f0LJ0wW9ApUewRXOHX/zeI2QtEWgl/mudpvJqiioykoFCN?=
 =?us-ascii?Q?/X2UU99MYQjLcMtkFuY4+XBAwLFi61d3B1kAkTlWNFLihvbyDnz80OpmS0Xf?=
 =?us-ascii?Q?HU9drWeJMU8TrPKz8yz6RG0mLm1YpOm2L7TeBGPnqLJZ9ZcKAJnip8yj8KdN?=
 =?us-ascii?Q?Y37Qb/ByzSqUvxsTktDReMAs4YMUZCPYSHMyMwiEhLKPMGvMSMr3T9uQ/9CN?=
 =?us-ascii?Q?3X5wyRCHiNAkCNje6DSfa4X93u4AV3jzPo3Gm8wKqLpEa/tcHMN/XHMmKMcd?=
 =?us-ascii?Q?2a0/5hJsRr+sk82iEnWN3ee1Na5pUTIirFyjZjeGZtxcenDV9ug7DUyW8gih?=
 =?us-ascii?Q?l508e7C2pso67j0SaEgr40yuPJYnhG2P3HbvFl6b/RXt7jwfCvvHfjTYE4/m?=
 =?us-ascii?Q?a8QUAElpOiMgQ3aJrSKfsXuRFZdLB24s9awJRCZzVYoCwVVnGkviHoh4xTzG?=
 =?us-ascii?Q?tdH6fnF+HrtnfgkXY8OdTo7KO7V+KTKjUQe36r3pd+CFHp0ABZQu?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85fa35a5-20ee-41a3-fc76-08de4e98593a
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 09:28:57.5734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uzopX3FHf+3T37ZnrFj7jYXUv8B2slh3iEN8z255mGcdMwOUG61E+jc+OvA9P8vSx4l5yHVr3O89biVFR4P0qTOxown3jBMhewkq34HAsCz2CZTewuQNBp5N8igYtdXm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12872
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Jan 2026 09:29:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21440

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit d028219a9f1485914492bf373406f6a0e665ace2 upstream.

Add a basic driver for the I3C controller found in Renesas RZ/G3S and
G3E SoCs. Support I3C pure busses (tested with two targets) and mixed
busses (two I3C devices plus various I2C targets). DAA and communication
with temperature sensors worked reliably at various speeds.

Missing features such as IBI, HotJoin, and target mode will be added
incrementally.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://lore.kernel.org/r/20250724094146.6443-5-wsa+renesas@sang-engi=
neering.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
[tommaso.merciai:
 - Removed  __counted_by(ncmds) from struct renesas_i3c_cmd cmds[]
 - Added struct reset_control *tresetn, *presetn into struct
   renesas_i3c
 - Use devm_reset_control_get_optional_exclusive() into probe function +
   reset_control_deassert() and devm_add_action_or_reset() for tresetn,
   presetn error path.
 - Fixed renesas_i3c_remove() from static void to static int]
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 MAINTAINERS                      |    7 +
 drivers/i3c/master/Kconfig       |   10 +
 drivers/i3c/master/Makefile      |    1 +
 drivers/i3c/master/renesas-i3c.c | 1431 ++++++++++++++++++++++++++++++
 4 files changed, 1449 insertions(+)
 create mode 100644 drivers/i3c/master/renesas-i3c.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f87e337db1e1..061d208b5a9f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9700,6 +9700,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/i3c/cdns,i3c-master.yaml
 F:	drivers/i3c/master/i3c-master-cdns.c
=20
+I3C DRIVER FOR RENESAS
+M:	Wolfram Sang <wsa+renesas@sang-engineering.com>
+M:	Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/i3c/renesas,i3c.yaml
+F:	drivers/i3c/master/renesas-i3c.c
+
 I3C DRIVER FOR SYNOPSYS DESIGNWARE
 M:	Vitor Soares <vitor.soares@synopsys.com>
 S:	Maintained
diff --git a/drivers/i3c/master/Kconfig b/drivers/i3c/master/Kconfig
index b5e20b28f107..eb096e22683b 100644
--- a/drivers/i3c/master/Kconfig
+++ b/drivers/i3c/master/Kconfig
@@ -39,3 +39,13 @@ config MIPI_I3C_HCI
=20
 	  This driver can also be built as a module.  If so, the module will be
 	  called mipi-i3c-hci.
+
+config RENESAS_I3C
+	tristate "Renesas I3C controller driver"
+	depends on HAS_IOMEM
+	depends on ARCH_RENESAS || COMPILE_TEST
+	help
+	  Support the Renesas I3C controller as found in some RZ variants.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called renesas-i3c.
diff --git a/drivers/i3c/master/Makefile b/drivers/i3c/master/Makefile
index b3fee0f690b2..e7dd13daea72 100644
--- a/drivers/i3c/master/Makefile
+++ b/drivers/i3c/master/Makefile
@@ -3,3 +3,4 @@ obj-$(CONFIG_CDNS_I3C_MASTER)		+=3D i3c-master-cdns.o
 obj-$(CONFIG_DW_I3C_MASTER)		+=3D dw-i3c-master.o
 obj-$(CONFIG_SVC_I3C_MASTER)		+=3D svc-i3c-master.o
 obj-$(CONFIG_MIPI_I3C_HCI)		+=3D mipi-i3c-hci/
+obj-$(CONFIG_RENESAS_I3C)		+=3D renesas-i3c.o
diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesas-=
i3c.c
new file mode 100644
index 000000000000..432be328a4e4
--- /dev/null
+++ b/drivers/i3c/master/renesas-i3c.c
@@ -0,0 +1,1431 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Renesas I3C Controller driver
+ * Copyright (C) 2023-25 Renesas Electronics Corp.
+ *
+ * TODO: IBI support, HotJoin support, Target support
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/completion.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/i2c.h>
+#include <linux/i3c/master.h>
+#include <linux/interrupt.h>
+#include <linux/ioport.h>
+#include <linux/iopoll.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+#include <linux/slab.h>
+#include "../internals.h"
+
+#define PRTS			0x00
+#define  PRTS_PRTMD		BIT(0)
+
+#define BCTL			0x14
+#define  BCTL_INCBA		BIT(0)
+#define  BCTL_HJACKCTL		BIT(8)
+#define  BCTL_ABT		BIT(29)
+#define  BCTL_BUSE		BIT(31)
+
+#define MSDVAD			0x18
+#define  MSDVAD_MDYAD(x)	FIELD_PREP(GENMASK(21, 16), x)
+#define  MSDVAD_MDYADV		BIT(31)
+
+#define RSTCTL			0x20
+#define  RSTCTL_RI3CRST		BIT(0)
+#define  RSTCTL_INTLRST		BIT(16)
+
+#define INST			0x30
+
+#define IBINCTL			0x58
+#define  IBINCTL_NRHJCTL	BIT(0)
+#define  IBINCTL_NRMRCTL	BIT(1)
+#define  IBINCTL_NRSIRCTL	BIT(3)
+
+#define SVCTL			0x64
+
+#define REFCKCTL		0x70
+#define  REFCKCTL_IREFCKS(x)	FIELD_PREP(GENMASK(2, 0), x)
+
+#define STDBR			0x74
+#define  STDBR_SBRLO(cond, x)	FIELD_PREP(GENMASK(7, 0), (x) >> (cond))
+#define  STDBR_SBRHO(cond, x)	FIELD_PREP(GENMASK(15, 8), (x) >> (cond))
+#define  STDBR_SBRLP(x)		FIELD_PREP(GENMASK(21, 16), x)
+#define  STDBR_SBRHP(x)		FIELD_PREP(GENMASK(29, 24), x)
+#define  STDBR_DSBRPO		BIT(31)
+
+#define EXTBR			0x78
+#define  EXTBR_EBRLO(x)		FIELD_PREP(GENMASK(7, 0), x)
+#define  EXTBR_EBRHO(x)		FIELD_PREP(GENMASK(15, 8), x)
+#define  EXTBR_EBRLP(x)		FIELD_PREP(GENMASK(21, 16), x)
+#define  EXTBR_EBRHP(x)		FIELD_PREP(GENMASK(29, 24), x)
+
+#define BFRECDT			0x7c
+#define  BFRECDT_FRECYC(x)	FIELD_PREP(GENMASK(8, 0), x)
+
+#define BAVLCDT			0x80
+#define  BAVLCDT_AVLCYC(x)	FIELD_PREP(GENMASK(8, 0), x)
+
+#define BIDLCDT			0x84
+#define  BIDLCDT_IDLCYC(x)	FIELD_PREP(GENMASK(17, 0), x)
+
+#define ACKCTL			0xa0
+#define  ACKCTL_ACKT		BIT(1)
+#define  ACKCTL_ACKTWP		BIT(2)
+
+#define SCSTRCTL		0xa4
+#define  SCSTRCTL_ACKTWE	BIT(0)
+#define  SCSTRCTL_RWE		BIT(1)
+
+#define SCSTLCTL		0xb0
+
+#define CNDCTL			0x140
+#define  CNDCTL_STCND		BIT(0)
+#define  CNDCTL_SRCND		BIT(1)
+#define  CNDCTL_SPCND		BIT(2)
+
+#define NCMDQP			0x150 /* Normal Command Queue */
+#define  NCMDQP_CMD_ATTR(x)	FIELD_PREP(GENMASK(2, 0), x)
+#define  NCMDQP_IMMED_XFER	0x01
+#define  NCMDQP_ADDR_ASSGN	0x02
+#define  NCMDQP_TID(x)		FIELD_PREP(GENMASK(6, 3), x)
+#define  NCMDQP_CMD(x)		FIELD_PREP(GENMASK(14, 7), x)
+#define  NCMDQP_CP		BIT(15)
+#define  NCMDQP_DEV_INDEX(x)	FIELD_PREP(GENMASK(20, 16), x)
+#define  NCMDQP_BYTE_CNT(x)	FIELD_PREP(GENMASK(25, 23), x)
+#define  NCMDQP_DEV_COUNT(x)	FIELD_PREP(GENMASK(29, 26), x)
+#define  NCMDQP_MODE(x)		FIELD_PREP(GENMASK(28, 26), x)
+#define  NCMDQP_RNW(x)		FIELD_PREP(GENMASK(29, 29), x)
+#define  NCMDQP_ROC		BIT(30)
+#define  NCMDQP_TOC		BIT(31)
+#define  NCMDQP_DATA_LENGTH(x)	FIELD_PREP(GENMASK(31, 16), x)
+
+#define NRSPQP			0x154 /* Normal Respone Queue */
+#define  NRSPQP_NO_ERROR			0
+#define  NRSPQP_ERROR_CRC		1
+#define  NRSPQP_ERROR_PARITY		2
+#define  NRSPQP_ERROR_FRAME		3
+#define  NRSPQP_ERROR_IBA_NACK		4
+#define  NRSPQP_ERROR_ADDRESS_NACK	5
+#define  NRSPQP_ERROR_OVER_UNDER_FLOW	6
+#define  NRSPQP_ERROR_TRANSF_ABORT	8
+#define  NRSPQP_ERROR_I2C_W_NACK_ERR	9
+#define  NRSPQP_ERROR_UNSUPPORTED	10
+#define  NRSPQP_DATA_LEN(x)	FIELD_GET(GENMASK(15, 0), x)
+#define  NRSPQP_ERR_STATUS(x)	FIELD_GET(GENMASK(31, 28), x)
+
+#define NTDTBP0			0x158 /* Normal Transfer Data Buffer */
+#define  NTDTBP0_DEPTH		16
+
+#define NQTHCTL			0x190
+#define  NQTHCTL_CMDQTH(x)	FIELD_PREP(GENMASK(1, 0), x)
+#define  NQTHCTL_IBIDSSZ(x)	FIELD_PREP(GENMASK(23, 16), x)
+
+#define NTBTHCTL0		0x194
+
+#define NRQTHCTL		0x1c0
+
+#define BST			0x1d0
+#define  BST_STCNDDF		BIT(0)
+#define  BST_SPCNDDF		BIT(1)
+#define  BST_NACKDF		BIT(4)
+#define  BST_TENDF		BIT(8)
+
+#define BSTE			0x1d4
+#define  BSTE_STCNDDE		BIT(0)
+#define  BSTE_SPCNDDE		BIT(1)
+#define  BSTE_NACKDE		BIT(4)
+#define  BSTE_TENDE		BIT(8)
+#define  BSTE_ALE		BIT(16)
+#define  BSTE_TODE		BIT(20)
+#define  BSTE_WUCNDDE		BIT(24)
+#define  BSTE_ALL_FLAG		(BSTE_STCNDDE | BSTE_SPCNDDE |\
+				BSTE_NACKDE | BSTE_TENDE |\
+				BSTE_ALE | BSTE_TODE | BSTE_WUCNDDE)
+
+#define BIE			0x1d8
+#define  BIE_STCNDDIE		BIT(0)
+#define  BIE_SPCNDDIE		BIT(1)
+#define  BIE_NACKDIE		BIT(4)
+#define  BIE_TENDIE		BIT(8)
+
+#define NTST			0x1e0
+#define  NTST_TDBEF0		BIT(0)
+#define  NTST_RDBFF0		BIT(1)
+#define  NTST_CMDQEF		BIT(3)
+#define  NTST_RSPQFF		BIT(4)
+#define  NTST_TABTF		BIT(5)
+#define  NTST_TEF		BIT(9)
+
+#define NTSTE			0x1e4
+#define  NTSTE_TDBEE0		BIT(0)
+#define  NTSTE_RDBFE0		BIT(1)
+#define  NTSTE_IBIQEFE		BIT(2)
+#define  NTSTE_CMDQEE		BIT(3)
+#define  NTSTE_RSPQFE		BIT(4)
+#define  NTSTE_TABTE		BIT(5)
+#define  NTSTE_TEE		BIT(9)
+#define  NTSTE_RSQFE		BIT(20)
+#define  NTSTE_ALL_FLAG		(NTSTE_TDBEE0 | NTSTE_RDBFE0 |\
+				NTSTE_IBIQEFE | NTSTE_CMDQEE |\
+				NTSTE_RSPQFE | NTSTE_TABTE |\
+				NTSTE_TEE | NTSTE_RSQFE)
+
+#define NTIE			0x1e8
+#define  NTIE_TDBEIE0		BIT(0)
+#define  NTIE_RDBFIE0		BIT(1)
+#define  NTIE_IBIQEFIE		BIT(2)
+#define  NTIE_RSPQFIE		BIT(4)
+#define  NTIE_RSQFIE		BIT(20)
+
+#define BCST			0x210
+#define  BCST_BFREF		BIT(0)
+
+#define DATBAS(x)		(0x224 + 0x8 * (x))
+#define  DATBAS_DVSTAD(x)	FIELD_PREP(GENMASK(6, 0), x)
+#define  DATBAS_DVDYAD(x)	FIELD_PREP(GENMASK(23, 16), x)
+
+#define NDBSTLV0		0x398
+#define  NDBSTLV0_RDBLV(x)	FIELD_GET(GENMASK(15, 8), x)
+
+#define RENESAS_I3C_MAX_DEVS	8
+#define I2C_INIT_MSG		-1
+
+enum i3c_internal_state {
+	I3C_INTERNAL_STATE_DISABLED,
+	I3C_INTERNAL_STATE_CONTROLLER_IDLE,
+	I3C_INTERNAL_STATE_CONTROLLER_ENTDAA,
+	I3C_INTERNAL_STATE_CONTROLLER_SETDASA,
+	I3C_INTERNAL_STATE_CONTROLLER_WRITE,
+	I3C_INTERNAL_STATE_CONTROLLER_READ,
+	I3C_INTERNAL_STATE_CONTROLLER_COMMAND_WRITE,
+	I3C_INTERNAL_STATE_CONTROLLER_COMMAND_READ,
+};
+
+enum renesas_i3c_event {
+	I3C_COMMAND_ADDRESS_ASSIGNMENT,
+	I3C_WRITE,
+	I3C_READ,
+	I3C_COMMAND_WRITE,
+	I3C_COMMAND_READ,
+};
+
+struct renesas_i3c_cmd {
+	u32 cmd0;
+	u32 len;
+	const void *tx_buf;
+	u32 tx_count;
+	void *rx_buf;
+	u32 rx_count;
+	u32 err;
+	u8 rnw;
+	/* i2c xfer */
+	int i2c_bytes_left;
+	int i2c_is_last;
+	u8 *i2c_buf;
+	const struct i2c_msg *msg;
+};
+
+struct renesas_i3c_xfer {
+	struct list_head node;
+	struct completion comp;
+	int ret;
+	bool is_i2c_xfer;
+	unsigned int ncmds;
+	struct renesas_i3c_cmd cmds[];
+};
+
+struct renesas_i3c_xferqueue {
+	struct list_head list;
+	struct renesas_i3c_xfer *cur;
+	/* Lock for accessing the xfer queue */
+	spinlock_t lock;
+};
+
+struct renesas_i3c {
+	struct i3c_master_controller base;
+	enum i3c_internal_state internal_state;
+	u16 maxdevs;
+	u32 free_pos;
+	u32 i2c_STDBR;
+	u32 i3c_STDBR;
+	u8 addrs[RENESAS_I3C_MAX_DEVS];
+	struct renesas_i3c_xferqueue xferqueue;
+	void __iomem *regs;
+	struct clk *tclk;
+	struct reset_control *tresetn;
+	struct reset_control *presetn;
+};
+
+struct renesas_i3c_i2c_dev_data {
+	u8 index;
+};
+
+struct renesas_i3c_irq_desc {
+	const char *name;
+	irq_handler_t isr;
+	const char *desc;
+};
+
+struct renesas_i3c_config {
+	unsigned int has_pclkrw:1;
+};
+
+static inline void renesas_i3c_reg_update(void __iomem *reg, u32 mask, u32=
 val)
+{
+	u32 data =3D readl(reg);
+
+	data &=3D ~mask;
+	data |=3D (val & mask);
+	writel(data, reg);
+}
+
+static inline u32 renesas_readl(void __iomem *base, u32 reg)
+{
+	return readl(base + reg);
+}
+
+static inline void renesas_writel(void __iomem *base, u32 reg, u32 val)
+{
+	writel(val, base + reg);
+}
+
+static void renesas_set_bit(void __iomem *base, u32 reg, u32 val)
+{
+	renesas_i3c_reg_update(base + reg, val, val);
+}
+
+static void renesas_clear_bit(void __iomem *base, u32 reg, u32 val)
+{
+	renesas_i3c_reg_update(base + reg, val, 0);
+}
+
+static inline struct renesas_i3c *to_renesas_i3c(struct i3c_master_control=
ler *m)
+{
+	return container_of(m, struct renesas_i3c, base);
+}
+
+static inline u32 datbas_dvdyad_with_parity(u8 addr)
+{
+	return DATBAS_DVDYAD(addr | (parity8(addr) ? 0 : BIT(7)));
+}
+
+static int renesas_i3c_get_free_pos(struct renesas_i3c *i3c)
+{
+	if (!(i3c->free_pos & GENMASK(i3c->maxdevs - 1, 0)))
+		return -ENOSPC;
+
+	return ffs(i3c->free_pos) - 1;
+}
+
+static int renesas_i3c_get_addr_pos(struct renesas_i3c *i3c, u8 addr)
+{
+	int pos;
+
+	for (pos =3D 0; pos < i3c->maxdevs; pos++) {
+		if (addr =3D=3D i3c->addrs[pos])
+			return pos;
+	}
+
+	return -EINVAL;
+}
+
+static struct renesas_i3c_xfer *renesas_i3c_alloc_xfer(struct renesas_i3c =
*i3c,
+						       unsigned int ncmds)
+{
+	struct renesas_i3c_xfer *xfer;
+
+	xfer =3D kzalloc(struct_size(xfer, cmds, ncmds), GFP_KERNEL);
+	if (!xfer)
+		return NULL;
+
+	INIT_LIST_HEAD(&xfer->node);
+	xfer->ncmds =3D ncmds;
+	xfer->ret =3D -ETIMEDOUT;
+
+	return xfer;
+}
+
+static void renesas_i3c_start_xfer_locked(struct renesas_i3c *i3c)
+{
+	struct renesas_i3c_xfer *xfer =3D i3c->xferqueue.cur;
+	struct renesas_i3c_cmd *cmd;
+	u32 cmd1;
+
+	if (!xfer)
+		return;
+
+	cmd =3D xfer->cmds;
+
+	switch (i3c->internal_state) {
+	case I3C_INTERNAL_STATE_CONTROLLER_ENTDAA:
+	case I3C_INTERNAL_STATE_CONTROLLER_SETDASA:
+		renesas_set_bit(i3c->regs, NTIE, NTIE_RSPQFIE);
+		renesas_writel(i3c->regs, NCMDQP, cmd->cmd0);
+		renesas_writel(i3c->regs, NCMDQP, 0);
+		break;
+	case I3C_INTERNAL_STATE_CONTROLLER_WRITE:
+	case I3C_INTERNAL_STATE_CONTROLLER_COMMAND_WRITE:
+		renesas_set_bit(i3c->regs, NTIE, NTIE_RSPQFIE);
+		if (cmd->len <=3D 4) {
+			cmd->cmd0 |=3D NCMDQP_CMD_ATTR(NCMDQP_IMMED_XFER);
+			cmd->cmd0 |=3D NCMDQP_BYTE_CNT(cmd->len);
+			cmd->tx_count =3D cmd->len;
+			cmd1 =3D cmd->len =3D=3D 0 ? 0 : *(u32 *)cmd->tx_buf;
+		} else {
+			cmd1 =3D NCMDQP_DATA_LENGTH(cmd->len);
+		}
+		renesas_writel(i3c->regs, NCMDQP, cmd->cmd0);
+		renesas_writel(i3c->regs, NCMDQP, cmd1);
+		break;
+	case I3C_INTERNAL_STATE_CONTROLLER_READ:
+	case I3C_INTERNAL_STATE_CONTROLLER_COMMAND_READ:
+		renesas_set_bit(i3c->regs, NTIE, NTIE_RDBFIE0);
+		cmd1 =3D NCMDQP_DATA_LENGTH(cmd->len);
+		renesas_writel(i3c->regs, NCMDQP, cmd->cmd0);
+		renesas_writel(i3c->regs, NCMDQP, cmd1);
+		break;
+	default:
+		break;
+	}
+
+	/* Clear the command queue empty flag */
+	renesas_clear_bit(i3c->regs, NTST, NTST_CMDQEF);
+}
+
+static void renesas_i3c_dequeue_xfer_locked(struct renesas_i3c *i3c,
+					    struct renesas_i3c_xfer *xfer)
+{
+	if (i3c->xferqueue.cur =3D=3D xfer)
+		i3c->xferqueue.cur =3D NULL;
+	else
+		list_del_init(&xfer->node);
+}
+
+static void renesas_i3c_dequeue_xfer(struct renesas_i3c *i3c, struct renes=
as_i3c_xfer *xfer)
+{
+	scoped_guard(spinlock_irqsave, &i3c->xferqueue.lock)
+		renesas_i3c_dequeue_xfer_locked(i3c, xfer);
+}
+
+static void renesas_i3c_enqueue_xfer(struct renesas_i3c *i3c, struct renes=
as_i3c_xfer *xfer)
+{
+	reinit_completion(&xfer->comp);
+	scoped_guard(spinlock_irqsave, &i3c->xferqueue.lock) {
+		if (i3c->xferqueue.cur) {
+			list_add_tail(&xfer->node, &i3c->xferqueue.list);
+		} else {
+			i3c->xferqueue.cur =3D xfer;
+			if (!xfer->is_i2c_xfer)
+				renesas_i3c_start_xfer_locked(i3c);
+		}
+	}
+}
+
+static void renesas_i3c_wait_xfer(struct renesas_i3c *i3c, struct renesas_=
i3c_xfer *xfer)
+{
+	unsigned long time_left;
+
+	renesas_i3c_enqueue_xfer(i3c, xfer);
+
+	time_left =3D wait_for_completion_timeout(&xfer->comp, msecs_to_jiffies(1=
000));
+	if (!time_left)
+		renesas_i3c_dequeue_xfer(i3c, xfer);
+}
+
+static void renesas_i3c_set_prts(struct renesas_i3c *i3c, u32 val)
+{
+	/* Required sequence according to tnrza0140ae */
+	renesas_set_bit(i3c->regs, RSTCTL, RSTCTL_INTLRST);
+	renesas_writel(i3c->regs, PRTS, val);
+	renesas_clear_bit(i3c->regs, RSTCTL, RSTCTL_INTLRST);
+}
+
+static void renesas_i3c_bus_enable(struct i3c_master_controller *m, bool i=
3c_mode)
+{
+	struct renesas_i3c *i3c =3D to_renesas_i3c(m);
+
+	/* Setup either I3C or I2C protocol */
+	if (i3c_mode) {
+		renesas_i3c_set_prts(i3c, 0);
+		/* Revisit: INCBA handling, especially after I2C transfers */
+		renesas_set_bit(i3c->regs, BCTL, BCTL_HJACKCTL | BCTL_INCBA);
+		renesas_set_bit(i3c->regs, MSDVAD, MSDVAD_MDYADV);
+		renesas_writel(i3c->regs, STDBR, i3c->i3c_STDBR);
+	} else {
+		renesas_i3c_set_prts(i3c, PRTS_PRTMD);
+		renesas_writel(i3c->regs, STDBR, i3c->i2c_STDBR);
+	}
+
+	/* Enable I3C bus */
+	renesas_set_bit(i3c->regs, BCTL, BCTL_BUSE);
+}
+
+static int renesas_i3c_reset(struct renesas_i3c *i3c)
+{
+	u32 val;
+
+	renesas_writel(i3c->regs, BCTL, 0);
+	renesas_set_bit(i3c->regs, RSTCTL, RSTCTL_RI3CRST);
+
+	return read_poll_timeout(renesas_readl, val, !(val & RSTCTL_RI3CRST),
+				 0, 1000, false, i3c->regs, RSTCTL);
+}
+
+static int renesas_i3c_bus_init(struct i3c_master_controller *m)
+{
+	struct renesas_i3c *i3c =3D to_renesas_i3c(m);
+	struct i3c_bus *bus =3D i3c_master_get_bus(m);
+	struct i3c_device_info info =3D {};
+	struct i2c_timings t;
+	unsigned long rate;
+	u32 double_SBR, val;
+	int cks, pp_high_ticks, pp_low_ticks, i3c_total_ticks;
+	int od_high_ticks, od_low_ticks, i2c_total_ticks;
+	int ret;
+
+	rate =3D clk_get_rate(i3c->tclk);
+	if (!rate)
+		return -EINVAL;
+
+	ret =3D renesas_i3c_reset(i3c);
+	if (ret)
+		return ret;
+
+	i2c_total_ticks =3D DIV_ROUND_UP(rate, bus->scl_rate.i2c);
+	i3c_total_ticks =3D DIV_ROUND_UP(rate, bus->scl_rate.i3c);
+
+	i2c_parse_fw_timings(&m->dev, &t, true);
+
+	for (cks =3D 0; cks < 7; cks++) {
+		/* SCL low-period calculation in Open-drain mode */
+		od_low_ticks =3D ((i2c_total_ticks * 6) / 10);
+
+		/* SCL clock calculation in Push-Pull mode */
+		if (bus->mode =3D=3D I3C_BUS_MODE_PURE)
+			pp_high_ticks =3D ((i3c_total_ticks * 5) / 10);
+		else
+			pp_high_ticks =3D DIV_ROUND_UP(I3C_BUS_THIGH_MIXED_MAX_NS,
+						     NSEC_PER_SEC / rate);
+		pp_low_ticks =3D i3c_total_ticks - pp_high_ticks;
+
+		if ((od_low_ticks / 2) <=3D 0xFF && pp_low_ticks < 0x3F)
+			break;
+
+		i2c_total_ticks /=3D 2;
+		i3c_total_ticks /=3D 2;
+		rate /=3D 2;
+	}
+
+	/* SCL clock period calculation in Open-drain mode */
+	if ((od_low_ticks / 2) > 0xFF || pp_low_ticks > 0x3F) {
+		dev_err(&m->dev, "invalid speed (i2c-scl =3D %lu Hz, i3c-scl =3D %lu Hz)=
. Too slow.\n",
+			(unsigned long)bus->scl_rate.i2c, (unsigned long)bus->scl_rate.i3c);
+		return -EINVAL;
+	}
+
+	/* SCL high-period calculation in Open-drain mode */
+	od_high_ticks =3D i2c_total_ticks - od_low_ticks;
+
+	/* Standard Bit Rate setting */
+	double_SBR =3D od_low_ticks > 0xFF ? 1 : 0;
+	i3c->i3c_STDBR =3D (double_SBR ? STDBR_DSBRPO : 0) |
+			STDBR_SBRLO(double_SBR, od_low_ticks) |
+			STDBR_SBRHO(double_SBR, od_high_ticks) |
+			STDBR_SBRLP(pp_low_ticks) |
+			STDBR_SBRHP(pp_high_ticks);
+
+	od_low_ticks -=3D t.scl_fall_ns / (NSEC_PER_SEC / rate) + 1;
+	od_high_ticks -=3D t.scl_rise_ns / (NSEC_PER_SEC / rate) + 1;
+	i3c->i2c_STDBR =3D (double_SBR ? STDBR_DSBRPO : 0) |
+			STDBR_SBRLO(double_SBR, od_low_ticks) |
+			STDBR_SBRHO(double_SBR, od_high_ticks) |
+			STDBR_SBRLP(pp_low_ticks) |
+			STDBR_SBRHP(pp_high_ticks);
+	renesas_writel(i3c->regs, STDBR, i3c->i3c_STDBR);
+
+	/* Extended Bit Rate setting */
+	renesas_writel(i3c->regs, EXTBR, EXTBR_EBRLO(od_low_ticks) |
+					   EXTBR_EBRHO(od_high_ticks) |
+					   EXTBR_EBRLP(pp_low_ticks) |
+					   EXTBR_EBRHP(pp_high_ticks));
+
+	renesas_writel(i3c->regs, REFCKCTL, REFCKCTL_IREFCKS(cks));
+
+	/* Disable Slave Mode */
+	renesas_writel(i3c->regs, SVCTL, 0);
+
+	/* Initialize Queue/Buffer threshold */
+	renesas_writel(i3c->regs, NQTHCTL, NQTHCTL_IBIDSSZ(6) |
+					     NQTHCTL_CMDQTH(1));
+
+	/* The only supported configuration is two entries*/
+	renesas_writel(i3c->regs, NTBTHCTL0, 0);
+	/* Interrupt when there is one entry in the queue */
+	renesas_writel(i3c->regs, NRQTHCTL, 0);
+
+	/* Enable all Bus/Transfer Status Flags */
+	renesas_writel(i3c->regs, BSTE, BSTE_ALL_FLAG);
+	renesas_writel(i3c->regs, NTSTE, NTSTE_ALL_FLAG);
+
+	/* Interrupt enable settings */
+	renesas_writel(i3c->regs, BIE, BIE_NACKDIE | BIE_TENDIE);
+	renesas_writel(i3c->regs, NTIE, 0);
+
+	/* Clear Status register */
+	renesas_writel(i3c->regs, NTST, 0);
+	renesas_writel(i3c->regs, INST, 0);
+	renesas_writel(i3c->regs, BST, 0);
+
+	/* Hot-Join Acknowlege setting. */
+	renesas_set_bit(i3c->regs, BCTL, BCTL_HJACKCTL);
+
+	renesas_writel(i3c->regs, IBINCTL, IBINCTL_NRHJCTL | IBINCTL_NRMRCTL |
+					     IBINCTL_NRSIRCTL);
+
+	renesas_writel(i3c->regs, SCSTLCTL, 0);
+	renesas_set_bit(i3c->regs, SCSTRCTL, SCSTRCTL_ACKTWE);
+
+	/* Bus condition timing */
+	val =3D DIV_ROUND_UP(I3C_BUS_TBUF_MIXED_FM_MIN_NS, NSEC_PER_SEC / rate);
+	renesas_writel(i3c->regs, BFRECDT, BFRECDT_FRECYC(val));
+
+	val =3D DIV_ROUND_UP(I3C_BUS_TAVAL_MIN_NS, NSEC_PER_SEC / rate);
+	renesas_writel(i3c->regs, BAVLCDT, BAVLCDT_AVLCYC(val));
+
+	val =3D DIV_ROUND_UP(I3C_BUS_TIDLE_MIN_NS, NSEC_PER_SEC / rate);
+	renesas_writel(i3c->regs, BIDLCDT, BIDLCDT_IDLCYC(val));
+
+	ret =3D i3c_master_get_free_addr(m, 0);
+	if (ret < 0)
+		return ret;
+
+	renesas_writel(i3c->regs, MSDVAD, MSDVAD_MDYAD(ret) | MSDVAD_MDYADV);
+
+	memset(&info, 0, sizeof(info));
+	info.dyn_addr =3D ret;
+	return i3c_master_set_info(&i3c->base, &info);
+}
+
+static void renesas_i3c_bus_cleanup(struct i3c_master_controller *m)
+{
+	struct renesas_i3c *i3c =3D to_renesas_i3c(m);
+
+	renesas_i3c_reset(i3c);
+}
+
+static int renesas_i3c_daa(struct i3c_master_controller *m)
+{
+	struct renesas_i3c *i3c =3D to_renesas_i3c(m);
+	struct renesas_i3c_cmd *cmd;
+	u32 olddevs, newdevs;
+	u8 last_addr =3D 0, pos;
+	int ret;
+
+	struct renesas_i3c_xfer *xfer __free(kfree) =3D renesas_i3c_alloc_xfer(i3=
c, 1);
+	if (!xfer)
+		return -ENOMEM;
+
+	/* Enable I3C bus. */
+	renesas_i3c_bus_enable(m, true);
+
+	olddevs =3D ~(i3c->free_pos);
+	i3c->internal_state =3D I3C_INTERNAL_STATE_CONTROLLER_ENTDAA;
+
+	/* Setting DATBASn registers for target devices. */
+	for (pos =3D 0; pos < i3c->maxdevs; pos++) {
+		if (olddevs & BIT(pos))
+			continue;
+
+		ret =3D i3c_master_get_free_addr(m, last_addr + 1);
+		if (ret < 0)
+			return -ENOSPC;
+
+		i3c->addrs[pos] =3D ret;
+		last_addr =3D ret;
+
+		renesas_writel(i3c->regs, DATBAS(pos), datbas_dvdyad_with_parity(ret));
+	}
+
+	init_completion(&xfer->comp);
+	cmd =3D xfer->cmds;
+	cmd->rx_count =3D 0;
+
+	ret =3D renesas_i3c_get_free_pos(i3c);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * Setup the command descriptor to start the ENTDAA command
+	 * and starting at the selected device index.
+	 */
+	cmd->cmd0 =3D NCMDQP_CMD_ATTR(NCMDQP_ADDR_ASSGN) | NCMDQP_ROC |
+		    NCMDQP_TID(I3C_COMMAND_ADDRESS_ASSIGNMENT) |
+		    NCMDQP_CMD(I3C_CCC_ENTDAA) | NCMDQP_DEV_INDEX(ret) |
+		    NCMDQP_DEV_COUNT(i3c->maxdevs - ret) | NCMDQP_TOC;
+
+	renesas_i3c_wait_xfer(i3c, xfer);
+
+	newdevs =3D GENMASK(i3c->maxdevs - cmd->rx_count - 1, 0);
+	newdevs &=3D ~olddevs;
+
+	for (pos =3D 0; pos < i3c->maxdevs; pos++) {
+		if (newdevs & BIT(pos))
+			i3c_master_add_i3c_dev_locked(m, i3c->addrs[pos]);
+	}
+
+	return ret < 0 ? ret : 0;
+}
+
+static bool renesas_i3c_supports_ccc_cmd(struct i3c_master_controller *m,
+						const struct i3c_ccc_cmd *cmd)
+{
+	if (cmd->ndests > 1)
+		return false;
+
+	switch (cmd->id) {
+	case I3C_CCC_ENEC(true):
+	case I3C_CCC_ENEC(false):
+	case I3C_CCC_DISEC(true):
+	case I3C_CCC_DISEC(false):
+	case I3C_CCC_ENTAS(0, true):
+	case I3C_CCC_ENTAS(1, true):
+	case I3C_CCC_ENTAS(2, true):
+	case I3C_CCC_ENTAS(3, true):
+	case I3C_CCC_ENTAS(0, false):
+	case I3C_CCC_ENTAS(1, false):
+	case I3C_CCC_ENTAS(2, false):
+	case I3C_CCC_ENTAS(3, false):
+	case I3C_CCC_RSTDAA(true):
+	case I3C_CCC_RSTDAA(false):
+	case I3C_CCC_ENTDAA:
+	case I3C_CCC_DEFSLVS:
+	case I3C_CCC_SETMWL(true):
+	case I3C_CCC_SETMWL(false):
+	case I3C_CCC_SETMRL(true):
+	case I3C_CCC_SETMRL(false):
+	case I3C_CCC_ENTTM:
+	case I3C_CCC_SETDASA:
+	case I3C_CCC_SETNEWDA:
+	case I3C_CCC_GETMWL:
+	case I3C_CCC_GETMRL:
+	case I3C_CCC_GETPID:
+	case I3C_CCC_GETBCR:
+	case I3C_CCC_GETDCR:
+	case I3C_CCC_GETSTATUS:
+	case I3C_CCC_GETACCMST:
+	case I3C_CCC_GETMXDS:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static int renesas_i3c_send_ccc_cmd(struct i3c_master_controller *m,
+					   struct i3c_ccc_cmd *ccc)
+{
+	struct renesas_i3c *i3c =3D to_renesas_i3c(m);
+	struct renesas_i3c_xfer *xfer;
+	struct renesas_i3c_cmd *cmd;
+	int ret, pos =3D 0;
+
+	if (ccc->id & I3C_CCC_DIRECT) {
+		pos =3D renesas_i3c_get_addr_pos(i3c, ccc->dests[0].addr);
+		if (pos < 0)
+			return pos;
+	}
+
+	xfer =3D renesas_i3c_alloc_xfer(i3c, 1);
+	if (!xfer)
+		return -ENOMEM;
+
+	renesas_i3c_bus_enable(m, true);
+
+	init_completion(&xfer->comp);
+	cmd =3D xfer->cmds;
+	cmd->rnw =3D ccc->rnw;
+	cmd->cmd0 =3D 0;
+
+	/* Calculate the command descriptor. */
+	switch (ccc->id) {
+	case I3C_CCC_SETDASA:
+		renesas_writel(i3c->regs, DATBAS(pos),
+			DATBAS_DVSTAD(ccc->dests[0].addr) |
+			DATBAS_DVDYAD(*(u8 *)ccc->dests[0].payload.data >> 1));
+		cmd->cmd0 =3D NCMDQP_CMD_ATTR(NCMDQP_ADDR_ASSGN) | NCMDQP_ROC |
+			NCMDQP_TID(I3C_COMMAND_ADDRESS_ASSIGNMENT) |
+			NCMDQP_CMD(I3C_CCC_SETDASA) | NCMDQP_DEV_INDEX(pos) |
+			NCMDQP_DEV_COUNT(0) | NCMDQP_TOC;
+		i3c->internal_state =3D I3C_INTERNAL_STATE_CONTROLLER_SETDASA;
+		break;
+	default:
+		/* Calculate the command descriptor. */
+		cmd->cmd0 =3D NCMDQP_TID(I3C_COMMAND_WRITE) | NCMDQP_MODE(0) |
+				NCMDQP_RNW(ccc->rnw) | NCMDQP_CMD(ccc->id) |
+				NCMDQP_ROC | NCMDQP_TOC | NCMDQP_CP |
+				NCMDQP_DEV_INDEX(pos);
+
+		if (ccc->rnw) {
+			cmd->rx_buf =3D ccc->dests[0].payload.data;
+			cmd->len =3D ccc->dests[0].payload.len;
+			cmd->rx_count =3D 0;
+			i3c->internal_state =3D I3C_INTERNAL_STATE_CONTROLLER_COMMAND_READ;
+		} else {
+			cmd->tx_buf =3D ccc->dests[0].payload.data;
+			cmd->len =3D ccc->dests[0].payload.len;
+			cmd->tx_count =3D 0;
+			i3c->internal_state =3D I3C_INTERNAL_STATE_CONTROLLER_COMMAND_WRITE;
+		}
+	}
+
+	renesas_i3c_wait_xfer(i3c, xfer);
+
+	ret =3D xfer->ret;
+	if (ret)
+		ccc->err =3D I3C_ERROR_M2;
+
+	kfree(xfer);
+
+	return ret;
+}
+
+static int renesas_i3c_priv_xfers(struct i3c_dev_desc *dev, struct i3c_pri=
v_xfer *i3c_xfers,
+					 int i3c_nxfers)
+{
+	struct i3c_master_controller *m =3D i3c_dev_get_master(dev);
+	struct renesas_i3c *i3c =3D to_renesas_i3c(m);
+	struct renesas_i3c_i2c_dev_data *data =3D i3c_dev_get_master_data(dev);
+	struct renesas_i3c_xfer *xfer;
+	int i;
+
+	/* Enable I3C bus. */
+	renesas_i3c_bus_enable(m, true);
+
+	xfer =3D renesas_i3c_alloc_xfer(i3c, 1);
+	if (!xfer)
+		return -ENOMEM;
+
+	init_completion(&xfer->comp);
+
+	for (i =3D 0; i < i3c_nxfers; i++) {
+		struct renesas_i3c_cmd *cmd =3D xfer->cmds;
+
+		/* Calculate the Transfer Command Descriptor */
+		cmd->rnw =3D i3c_xfers[i].rnw;
+		cmd->cmd0 =3D NCMDQP_DEV_INDEX(data->index) | NCMDQP_MODE(0) |
+			    NCMDQP_RNW(cmd->rnw) | NCMDQP_ROC | NCMDQP_TOC;
+
+		if (i3c_xfers[i].rnw) {
+			cmd->rx_count =3D 0;
+			cmd->cmd0 |=3D NCMDQP_TID(I3C_READ);
+			cmd->rx_buf =3D i3c_xfers[i].data.in;
+			cmd->len =3D i3c_xfers[i].len;
+			i3c->internal_state =3D I3C_INTERNAL_STATE_CONTROLLER_READ;
+		} else {
+			cmd->tx_count =3D 0;
+			cmd->cmd0 |=3D NCMDQP_TID(I3C_WRITE);
+			cmd->tx_buf =3D i3c_xfers[i].data.out;
+			cmd->len =3D i3c_xfers[i].len;
+			i3c->internal_state =3D I3C_INTERNAL_STATE_CONTROLLER_WRITE;
+		}
+
+		if (!i3c_xfers[i].rnw && i3c_xfers[i].len > 4) {
+			i3c_writel_fifo(i3c->regs + NTDTBP0, cmd->tx_buf, cmd->len);
+			if (cmd->len > NTDTBP0_DEPTH * sizeof(u32))
+				renesas_set_bit(i3c->regs, NTIE, NTIE_TDBEIE0);
+		}
+
+		renesas_i3c_wait_xfer(i3c, xfer);
+	}
+
+	return 0;
+}
+
+static int renesas_i3c_attach_i3c_dev(struct i3c_dev_desc *dev)
+{
+	struct i3c_master_controller *m =3D i3c_dev_get_master(dev);
+	struct renesas_i3c *i3c =3D to_renesas_i3c(m);
+	struct renesas_i3c_i2c_dev_data *data;
+	int pos;
+
+	pos =3D renesas_i3c_get_free_pos(i3c);
+	if (pos < 0)
+		return pos;
+
+	data =3D kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->index =3D pos;
+	i3c->addrs[pos] =3D dev->info.dyn_addr ? : dev->info.static_addr;
+	i3c->free_pos &=3D ~BIT(pos);
+
+	renesas_writel(i3c->regs, DATBAS(pos), DATBAS_DVSTAD(dev->info.static_add=
r) |
+				    datbas_dvdyad_with_parity(i3c->addrs[pos]));
+	i3c_dev_set_master_data(dev, data);
+
+	return 0;
+}
+
+static int renesas_i3c_reattach_i3c_dev(struct i3c_dev_desc *dev,
+					       u8 old_dyn_addr)
+{
+	struct i3c_master_controller *m =3D i3c_dev_get_master(dev);
+	struct renesas_i3c *i3c =3D to_renesas_i3c(m);
+	struct renesas_i3c_i2c_dev_data *data =3D i3c_dev_get_master_data(dev);
+
+	i3c->addrs[data->index] =3D dev->info.dyn_addr ? dev->info.dyn_addr :
+							dev->info.static_addr;
+
+	return 0;
+}
+
+static void renesas_i3c_detach_i3c_dev(struct i3c_dev_desc *dev)
+{
+	struct renesas_i3c_i2c_dev_data *data =3D i3c_dev_get_master_data(dev);
+	struct i3c_master_controller *m =3D i3c_dev_get_master(dev);
+	struct renesas_i3c *i3c =3D to_renesas_i3c(m);
+
+	i3c_dev_set_master_data(dev, NULL);
+	i3c->addrs[data->index] =3D 0;
+	i3c->free_pos |=3D BIT(data->index);
+	kfree(data);
+}
+
+static int renesas_i3c_i2c_xfers(struct i2c_dev_desc *dev,
+					struct i2c_msg *i2c_xfers,
+					int i2c_nxfers)
+{
+	struct i3c_master_controller *m =3D i2c_dev_get_master(dev);
+	struct renesas_i3c *i3c =3D to_renesas_i3c(m);
+	struct renesas_i3c_cmd *cmd;
+	u8 start_bit =3D CNDCTL_STCND;
+	int i;
+
+	struct renesas_i3c_xfer *xfer __free(kfree) =3D renesas_i3c_alloc_xfer(i3=
c, 1);
+	if (!xfer)
+		return -ENOMEM;
+
+	if (!i2c_nxfers)
+		return 0;
+
+	renesas_i3c_bus_enable(m, false);
+
+	init_completion(&xfer->comp);
+	xfer->is_i2c_xfer =3D true;
+	cmd =3D xfer->cmds;
+
+	if (!(renesas_readl(i3c->regs, BCST) & BCST_BFREF)) {
+		cmd->err =3D -EBUSY;
+		return cmd->err;
+	}
+
+	renesas_writel(i3c->regs, BST, 0);
+
+	renesas_i3c_enqueue_xfer(i3c, xfer);
+
+	for (i =3D 0; i < i2c_nxfers; i++) {
+		cmd->i2c_bytes_left =3D I2C_INIT_MSG;
+		cmd->i2c_buf =3D i2c_xfers[i].buf;
+		cmd->msg =3D &i2c_xfers[i];
+		cmd->i2c_is_last =3D (i =3D=3D i2c_nxfers - 1);
+
+		renesas_set_bit(i3c->regs, BIE, BIE_NACKDIE);
+		renesas_set_bit(i3c->regs, NTIE, NTIE_TDBEIE0);
+		renesas_set_bit(i3c->regs, BIE, BIE_STCNDDIE);
+
+		/* Issue Start condition */
+		renesas_set_bit(i3c->regs, CNDCTL, start_bit);
+
+		renesas_set_bit(i3c->regs, NTSTE, NTSTE_TDBEE0);
+
+		wait_for_completion_timeout(&xfer->comp, m->i2c.timeout);
+
+		if (cmd->err)
+			break;
+
+		start_bit =3D CNDCTL_SRCND;
+	}
+
+	renesas_i3c_dequeue_xfer(i3c, xfer);
+	return cmd->err;
+}
+
+static int renesas_i3c_attach_i2c_dev(struct i2c_dev_desc *dev)
+{
+	struct i3c_master_controller *m =3D i2c_dev_get_master(dev);
+	struct renesas_i3c *i3c =3D to_renesas_i3c(m);
+	struct renesas_i3c_i2c_dev_data *data;
+	int pos;
+
+	pos =3D renesas_i3c_get_free_pos(i3c);
+	if (pos < 0)
+		return pos;
+
+	data =3D kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->index =3D pos;
+	i3c->addrs[pos] =3D dev->addr;
+	i3c->free_pos &=3D ~BIT(pos);
+	i2c_dev_set_master_data(dev, data);
+
+	return 0;
+}
+
+static void renesas_i3c_detach_i2c_dev(struct i2c_dev_desc *dev)
+{
+	struct renesas_i3c_i2c_dev_data *data =3D i2c_dev_get_master_data(dev);
+	struct i3c_master_controller *m =3D i2c_dev_get_master(dev);
+	struct renesas_i3c *i3c =3D to_renesas_i3c(m);
+
+	i2c_dev_set_master_data(dev, NULL);
+	i3c->addrs[data->index] =3D 0;
+	i3c->free_pos |=3D BIT(data->index);
+	kfree(data);
+}
+
+static irqreturn_t renesas_i3c_tx_isr(int irq, void *data)
+{
+	struct renesas_i3c *i3c =3D data;
+	struct renesas_i3c_xfer *xfer;
+	struct renesas_i3c_cmd *cmd;
+	u8 val;
+
+	scoped_guard(spinlock, &i3c->xferqueue.lock) {
+		xfer =3D i3c->xferqueue.cur;
+		cmd =3D xfer->cmds;
+
+		if (xfer->is_i2c_xfer) {
+			if (!cmd->i2c_bytes_left)
+				return IRQ_NONE;
+
+			if (cmd->i2c_bytes_left !=3D I2C_INIT_MSG) {
+				val =3D *cmd->i2c_buf;
+				cmd->i2c_buf++;
+				cmd->i2c_bytes_left--;
+				renesas_writel(i3c->regs, NTDTBP0, val);
+			}
+
+			if (cmd->i2c_bytes_left =3D=3D 0) {
+				renesas_clear_bit(i3c->regs, NTIE, NTIE_TDBEIE0);
+				renesas_set_bit(i3c->regs, BIE, BIE_TENDIE);
+			}
+
+			/* Clear the Transmit Buffer Empty status flag. */
+			renesas_clear_bit(i3c->regs, NTST, NTST_TDBEF0);
+		} else {
+			i3c_writel_fifo(i3c->regs + NTDTBP0, cmd->tx_buf, cmd->len);
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t renesas_i3c_resp_isr(int irq, void *data)
+{
+	struct renesas_i3c *i3c =3D data;
+	struct renesas_i3c_xfer *xfer;
+	struct renesas_i3c_cmd *cmd;
+	u32 resp_descriptor =3D renesas_readl(i3c->regs, NRSPQP);
+	u32 bytes_remaining =3D 0;
+	u32 ntst, data_len;
+	int ret =3D 0;
+
+	scoped_guard(spinlock, &i3c->xferqueue.lock) {
+		xfer =3D i3c->xferqueue.cur;
+		cmd =3D xfer->cmds;
+
+		/* Clear the Respone Queue Full status flag*/
+		renesas_clear_bit(i3c->regs, NTST, NTST_RSPQFF);
+
+		data_len =3D NRSPQP_DATA_LEN(resp_descriptor);
+
+		switch (i3c->internal_state) {
+		case I3C_INTERNAL_STATE_CONTROLLER_ENTDAA:
+			cmd->rx_count =3D data_len;
+			break;
+		case I3C_INTERNAL_STATE_CONTROLLER_WRITE:
+		case I3C_INTERNAL_STATE_CONTROLLER_COMMAND_WRITE:
+			/* Disable the transmit IRQ if it hasn't been disabled already. */
+			renesas_clear_bit(i3c->regs, NTIE, NTIE_TDBEIE0);
+			break;
+		case I3C_INTERNAL_STATE_CONTROLLER_READ:
+		case I3C_INTERNAL_STATE_CONTROLLER_COMMAND_READ:
+			if (NDBSTLV0_RDBLV(renesas_readl(i3c->regs, NDBSTLV0)) && !cmd->err)
+				bytes_remaining =3D data_len - cmd->rx_count;
+
+			i3c_readl_fifo(i3c->regs + NTDTBP0, cmd->rx_buf, bytes_remaining);
+			renesas_clear_bit(i3c->regs, NTIE, NTIE_RDBFIE0);
+			break;
+		default:
+			break;
+		}
+
+		switch (NRSPQP_ERR_STATUS(resp_descriptor)) {
+		case NRSPQP_NO_ERROR:
+			break;
+		case NRSPQP_ERROR_PARITY:
+		case NRSPQP_ERROR_IBA_NACK:
+		case NRSPQP_ERROR_TRANSF_ABORT:
+		case NRSPQP_ERROR_CRC:
+		case NRSPQP_ERROR_FRAME:
+			ret =3D -EIO;
+			break;
+		case NRSPQP_ERROR_OVER_UNDER_FLOW:
+			ret =3D -ENOSPC;
+			break;
+		case NRSPQP_ERROR_UNSUPPORTED:
+			ret =3D -EOPNOTSUPP;
+			break;
+		case NRSPQP_ERROR_I2C_W_NACK_ERR:
+		case NRSPQP_ERROR_ADDRESS_NACK:
+		default:
+			ret =3D -EINVAL;
+			break;
+		}
+
+		/*
+		 * If the transfer was aborted, then the abort flag must be cleared
+		 * before notifying the application that a transfer has completed.
+		 */
+		ntst =3D renesas_readl(i3c->regs, NTST);
+		if (ntst & NTST_TABTF)
+			renesas_clear_bit(i3c->regs, BCTL, BCTL_ABT);
+
+		/* Clear error status flags. */
+		renesas_clear_bit(i3c->regs, NTST, NTST_TEF | NTST_TABTF);
+
+		xfer->ret =3D ret;
+		complete(&xfer->comp);
+
+		xfer =3D list_first_entry_or_null(&i3c->xferqueue.list,
+						struct renesas_i3c_xfer, node);
+		if (xfer)
+			list_del_init(&xfer->node);
+
+		i3c->xferqueue.cur =3D xfer;
+	}
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t renesas_i3c_tend_isr(int irq, void *data)
+{
+	struct renesas_i3c *i3c =3D data;
+	struct renesas_i3c_xfer *xfer;
+	struct renesas_i3c_cmd *cmd;
+
+	scoped_guard(spinlock, &i3c->xferqueue.lock) {
+		xfer =3D i3c->xferqueue.cur;
+		cmd =3D xfer->cmds;
+
+		if (xfer->is_i2c_xfer) {
+			if (renesas_readl(i3c->regs, BST) & BST_NACKDF) {
+				/* We got a NACKIE */
+				renesas_readl(i3c->regs, NTDTBP0); /* dummy read */
+				renesas_clear_bit(i3c->regs, BST, BST_NACKDF);
+				cmd->err =3D -ENXIO;
+			} else if (cmd->i2c_bytes_left) {
+				renesas_set_bit(i3c->regs, NTIE, NTIE_TDBEIE0);
+				return IRQ_NONE;
+			}
+
+			if (cmd->i2c_is_last || cmd->err) {
+				renesas_clear_bit(i3c->regs, BIE, BIE_TENDIE);
+				renesas_set_bit(i3c->regs, BIE, BIE_SPCNDDIE);
+				renesas_set_bit(i3c->regs, CNDCTL, CNDCTL_SPCND);
+			} else {
+				/* Transfer is complete, but do not send STOP */
+				renesas_clear_bit(i3c->regs, NTSTE, NTSTE_TDBEE0);
+				renesas_clear_bit(i3c->regs, BIE, BIE_TENDIE);
+				xfer->ret =3D 0;
+				complete(&xfer->comp);
+			}
+		}
+
+		/* Clear the Transmit Buffer Empty status flag. */
+		renesas_clear_bit(i3c->regs, BST, BST_TENDF);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t renesas_i3c_rx_isr(int irq, void *data)
+{
+	struct renesas_i3c *i3c =3D data;
+	struct renesas_i3c_xfer *xfer;
+	struct renesas_i3c_cmd *cmd;
+	int read_bytes;
+
+	/* If resp_isr already read the data and updated 'xfer', we can just leav=
e */
+	if (!(renesas_readl(i3c->regs, NTIE) & NTIE_RDBFIE0))
+		return IRQ_NONE;
+
+	scoped_guard(spinlock, &i3c->xferqueue.lock) {
+		xfer =3D i3c->xferqueue.cur;
+		cmd =3D xfer->cmds;
+
+		if (xfer->is_i2c_xfer) {
+			if (!cmd->i2c_bytes_left)
+				return IRQ_NONE;
+
+			if (cmd->i2c_bytes_left =3D=3D I2C_INIT_MSG) {
+				cmd->i2c_bytes_left =3D cmd->msg->len;
+				renesas_set_bit(i3c->regs, SCSTRCTL, SCSTRCTL_RWE);
+				renesas_readl(i3c->regs, NTDTBP0); /* dummy read */
+				if (cmd->i2c_bytes_left =3D=3D 1)
+					renesas_writel(i3c->regs, ACKCTL, ACKCTL_ACKT | ACKCTL_ACKTWP);
+				return IRQ_HANDLED;
+			}
+
+			if (cmd->i2c_bytes_left =3D=3D 1) {
+				/* STOP must come before we set ACKCTL! */
+				if (cmd->i2c_is_last) {
+					renesas_set_bit(i3c->regs, BIE, BIE_SPCNDDIE);
+					renesas_clear_bit(i3c->regs, BST, BST_SPCNDDF);
+					renesas_set_bit(i3c->regs, CNDCTL, CNDCTL_SPCND);
+				}
+				renesas_writel(i3c->regs, ACKCTL, ACKCTL_ACKT | ACKCTL_ACKTWP);
+			} else {
+				renesas_writel(i3c->regs, ACKCTL, ACKCTL_ACKTWP);
+			}
+
+			/* Reading acks the RIE interrupt */
+			*cmd->i2c_buf =3D renesas_readl(i3c->regs, NTDTBP0);
+			cmd->i2c_buf++;
+			cmd->i2c_bytes_left--;
+		} else {
+			read_bytes =3D NDBSTLV0_RDBLV(renesas_readl(i3c->regs, NDBSTLV0)) * siz=
eof(u32);
+			i3c_readl_fifo(i3c->regs + NTDTBP0, cmd->rx_buf, read_bytes);
+			cmd->rx_count =3D read_bytes;
+		}
+
+		/* Clear the Read Buffer Full status flag. */
+		renesas_clear_bit(i3c->regs, NTST, NTST_RDBFF0);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t renesas_i3c_stop_isr(int irq, void *data)
+{
+	struct renesas_i3c *i3c =3D data;
+	struct renesas_i3c_xfer *xfer;
+
+	scoped_guard(spinlock, &i3c->xferqueue.lock) {
+		xfer =3D i3c->xferqueue.cur;
+
+		/* read back registers to confirm writes have fully propagated */
+		renesas_writel(i3c->regs, BST, 0);
+		renesas_readl(i3c->regs, BST);
+		renesas_writel(i3c->regs, BIE, 0);
+		renesas_clear_bit(i3c->regs, NTST, NTST_TDBEF0 | NTST_RDBFF0);
+		renesas_clear_bit(i3c->regs, SCSTRCTL, SCSTRCTL_RWE);
+
+		xfer->ret =3D 0;
+		complete(&xfer->comp);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t renesas_i3c_start_isr(int irq, void *data)
+{
+	struct renesas_i3c *i3c =3D data;
+	struct renesas_i3c_xfer *xfer;
+	struct renesas_i3c_cmd *cmd;
+	u8 val;
+
+	scoped_guard(spinlock, &i3c->xferqueue.lock) {
+		xfer =3D i3c->xferqueue.cur;
+		cmd =3D xfer->cmds;
+
+		if (xfer->is_i2c_xfer) {
+			if (!cmd->i2c_bytes_left)
+				return IRQ_NONE;
+
+			if (cmd->i2c_bytes_left =3D=3D I2C_INIT_MSG) {
+				if (cmd->msg->flags & I2C_M_RD) {
+					/* On read, switch over to receive interrupt */
+					renesas_clear_bit(i3c->regs, NTIE, NTIE_TDBEIE0);
+					renesas_set_bit(i3c->regs, NTIE, NTIE_RDBFIE0);
+				} else {
+					/* On write, initialize length */
+					cmd->i2c_bytes_left =3D cmd->msg->len;
+				}
+
+				val =3D i2c_8bit_addr_from_msg(cmd->msg);
+				renesas_writel(i3c->regs, NTDTBP0, val);
+			}
+		}
+
+		renesas_clear_bit(i3c->regs, BIE, BIE_STCNDDIE);
+		renesas_clear_bit(i3c->regs, BST, BST_STCNDDF);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static const struct i3c_master_controller_ops renesas_i3c_ops =3D {
+	.bus_init =3D renesas_i3c_bus_init,
+	.bus_cleanup =3D renesas_i3c_bus_cleanup,
+	.attach_i3c_dev =3D renesas_i3c_attach_i3c_dev,
+	.reattach_i3c_dev =3D renesas_i3c_reattach_i3c_dev,
+	.detach_i3c_dev =3D renesas_i3c_detach_i3c_dev,
+	.do_daa =3D renesas_i3c_daa,
+	.supports_ccc_cmd =3D renesas_i3c_supports_ccc_cmd,
+	.send_ccc_cmd =3D renesas_i3c_send_ccc_cmd,
+	.priv_xfers =3D renesas_i3c_priv_xfers,
+	.attach_i2c_dev =3D renesas_i3c_attach_i2c_dev,
+	.detach_i2c_dev =3D renesas_i3c_detach_i2c_dev,
+	.i2c_xfers =3D renesas_i3c_i2c_xfers,
+};
+
+static const struct renesas_i3c_irq_desc renesas_i3c_irqs[] =3D {
+	{ .name =3D "resp", .isr =3D renesas_i3c_resp_isr, .desc =3D "i3c-resp" }=
,
+	{ .name =3D "rx", .isr =3D renesas_i3c_rx_isr, .desc =3D "i3c-rx" },
+	{ .name =3D "tx", .isr =3D renesas_i3c_tx_isr, .desc =3D "i3c-tx" },
+	{ .name =3D "st", .isr =3D renesas_i3c_start_isr, .desc =3D "i3c-start" }=
,
+	{ .name =3D "sp", .isr =3D renesas_i3c_stop_isr, .desc =3D "i3c-stop" },
+	{ .name =3D "tend", .isr =3D renesas_i3c_tend_isr, .desc =3D "i3c-tend" }=
,
+	{ .name =3D "nack", .isr =3D renesas_i3c_tend_isr, .desc =3D "i3c-nack" }=
,
+};
+
+static void renesas_i3c_reset_control_assert(void *data)
+{
+	reset_control_assert(data);
+}
+
+static int renesas_i3c_probe(struct platform_device *pdev)
+{
+	struct renesas_i3c *i3c;
+	struct clk *clk;
+	const struct renesas_i3c_config *config =3D of_device_get_match_data(&pde=
v->dev);
+	int ret, i;
+
+	if (!config)
+		return -ENODATA;
+
+	i3c =3D devm_kzalloc(&pdev->dev, sizeof(*i3c), GFP_KERNEL);
+	if (!i3c)
+		return -ENOMEM;
+
+	i3c->regs =3D devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(i3c->regs))
+		return PTR_ERR(i3c->regs);
+
+	clk =3D devm_clk_get_enabled(&pdev->dev, "pclk");
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	if (config->has_pclkrw) {
+		clk =3D devm_clk_get_enabled(&pdev->dev, "pclkrw");
+		if (IS_ERR(clk))
+			return PTR_ERR(clk);
+	}
+
+	i3c->tclk =3D devm_clk_get_enabled(&pdev->dev, "tclk");
+	if (IS_ERR(i3c->tclk))
+		return PTR_ERR(i3c->tclk);
+
+	i3c->tresetn =3D devm_reset_control_get_optional_exclusive(&pdev->dev, "t=
resetn");
+	if (IS_ERR(i3c->tresetn))
+		return dev_err_probe(&pdev->dev, PTR_ERR(i3c->tresetn),
+				     "Error: missing tresetn ctrl\n");
+
+	i3c->presetn =3D devm_reset_control_get_optional_exclusive(&pdev->dev, "p=
resetn");
+	if (IS_ERR(i3c->presetn))
+		return dev_err_probe(&pdev->dev, PTR_ERR(i3c->presetn),
+				     "Error: missing presetn ctrl\n");
+
+	ret =3D reset_control_deassert(i3c->tresetn);
+	if (ret)
+		return ret;
+
+	ret =3D reset_control_deassert(i3c->presetn);
+	if (ret)
+		return ret;
+
+	ret =3D devm_add_action_or_reset(&pdev->dev, renesas_i3c_reset_control_as=
sert,
+				       i3c->tresetn);
+	if (ret)
+		return ret;
+
+	ret =3D devm_add_action_or_reset(&pdev->dev, renesas_i3c_reset_control_as=
sert,
+				       i3c->presetn);
+	if (ret)
+		return ret;
+
+	spin_lock_init(&i3c->xferqueue.lock);
+	INIT_LIST_HEAD(&i3c->xferqueue.list);
+
+	ret =3D renesas_i3c_reset(i3c);
+	if (ret)
+		return ret;
+
+	for (i =3D 0; i < ARRAY_SIZE(renesas_i3c_irqs); i++) {
+		ret =3D platform_get_irq_byname(pdev, renesas_i3c_irqs[i].name);
+		if (ret < 0)
+			return ret;
+
+		ret =3D devm_request_irq(&pdev->dev, ret, renesas_i3c_irqs[i].isr,
+				       0, renesas_i3c_irqs[i].desc, i3c);
+		if (ret)
+			return ret;
+	}
+
+	platform_set_drvdata(pdev, i3c);
+
+	i3c->maxdevs =3D RENESAS_I3C_MAX_DEVS;
+	i3c->free_pos =3D GENMASK(i3c->maxdevs - 1, 0);
+
+	return i3c_master_register(&i3c->base, &pdev->dev, &renesas_i3c_ops, fals=
e);
+}
+
+static int renesas_i3c_remove(struct platform_device *pdev)
+{
+	struct renesas_i3c *i3c =3D platform_get_drvdata(pdev);
+
+	i3c_master_unregister(&i3c->base);
+
+	return 0;
+}
+
+static const struct renesas_i3c_config empty_i3c_config =3D {
+};
+
+static const struct renesas_i3c_config r9a09g047_i3c_config =3D {
+	.has_pclkrw =3D 1,
+};
+
+static const struct of_device_id renesas_i3c_of_ids[] =3D {
+	{ .compatible =3D "renesas,r9a08g045-i3c", .data =3D &empty_i3c_config },
+	{ .compatible =3D "renesas,r9a09g047-i3c", .data =3D &r9a09g047_i3c_confi=
g },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, renesas_i3c_of_ids);
+
+static struct platform_driver renesas_i3c =3D {
+	.probe =3D renesas_i3c_probe,
+	.remove =3D renesas_i3c_remove,
+	.driver =3D {
+		.name =3D "renesas-i3c",
+		.of_match_table =3D renesas_i3c_of_ids,
+	},
+};
+module_platform_driver(renesas_i3c);
+
+MODULE_AUTHOR("Wolfram Sang <wsa+renesas@sang-engineering.com>");
+MODULE_AUTHOR("Renesas BSP teams");
+MODULE_DESCRIPTION("Renesas I3C controller driver");
+MODULE_LICENSE("GPL");
--=20
2.43.0


