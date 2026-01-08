Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82BD4CF6AA6
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 09:31:10 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3043.1767864667554035259
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Jan 2026 01:31:07 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Vnes04Ko;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.47, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hhfir7Q44kPVvJkOR29K7n50Ar+tc4K60KaYgAHKx+IlvmJODAVzf5D92rlUUvNhyRtWGm7UUTBOrWNDsKSpigVPnVVVegKsv44Njljio3s+607SBQbNblGNHnTWI64hG1y/0aPGXhP9NZY41xWo/w4m5XAuyTtp/vUwUzVGfPtxwkf2GcCYwlUX7ojd1XHIgnBmB6ZZ+1/quV6DSEePGbJy74D/D1hqSUUnFuBWCXdse9T7N/TebTpd72rSUTY1Q09/jwV4MiPqiblvXLRBCOwPXw7pBUZOMcBaApLeD6fT2ntpXr7Ui9xNoJRBnG6ech8v+NChpXm2gRuFeAM1LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ou5MLFnS1zP5yfU+kgbYxUkXhT9WgdhBzxhoVa/5M8=;
 b=roXUWmdTw7GpQWzg7QrywdyCGGzit0HEK84qAsTSMcGqM9qCTXpLK5HDDeOoTk4at9imeGEfv4j1MMUF0XMcteJLOFrOYKZmWchQZ0yaL/l7S62k7ZCtVDlIKE2kFFq6ir5jsAd+ZV1qXI6K+YNqNyq436d54BBJKoRGYizXp2PWwWMNa9jLD4viInwB6pG7o2UT1PBd7a1TU0BxDoiERFtssC9KNeupkY/fsqO8jCMtY1+A5qJ+ki6yspKOEFelac7yrm4abY51IDF2/riUbrtA3M8Uu6HY5kvSHtUl/IJ1WLpX7qYKyIdu2a1PtPZiyE71pa0mz3BGTS/39wXfvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ou5MLFnS1zP5yfU+kgbYxUkXhT9WgdhBzxhoVa/5M8=;
 b=Vnes04KoVxncSJu1ZpxCQfusnVt3uSL4aJrHHQK9QvKDzWCvd1+vPZNcKxgSAxNst9JqeJvNsyg5eBREg4ixbOQoZQks16obX/xGo3nzRWCmadd1xsNR19W1BkTsU20O06joM3ygD3ztV+DlVBtEJA3JZo2lAqOt+no/I5Yq2Ek=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY7PR01MB14326.jpnprd01.prod.outlook.com (2603:1096:405:240::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.1; Thu, 8 Jan
 2026 09:31:05 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 09:31:05 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 07/19] i3c: Standardize defines for specification parameters
Date: Thu,  8 Jan 2026 10:30:11 +0100
Message-ID: <20260108093023.489513-8-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108093023.489513-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260108093023.489513-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0244.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::13) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TY7PR01MB14326:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c512262-62bf-4e1e-6755-08de4e98a54f
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?1vj/NVZh0Eqa0Ar+01uSbPePPZe8+5bS5b4ToeCEiK5ZoB6zxl6lR4ZzZAC6?=
 =?us-ascii?Q?Kh6F/cjP6/ZuBbFDRrFQBe2rjTajp5H0f7y500I36XWXTFHDaMDgAdNltg2Z?=
 =?us-ascii?Q?zHMOMmDIfALUakLBOj2DagYUsN1YJse7B2FwS9msGeRzXlA10WXYKU666qgV?=
 =?us-ascii?Q?2jMrvF1Zkl2rPhA5wW4u+W6IHcRw3wt2FMFCsAohSGTn7WFUrpL/z7wSVU04?=
 =?us-ascii?Q?fFjzl2l0QM09EgPKQmz8jYqd4MVX45g4XNNeXz3qSf6a4C4ZW4C3O3pT0QlJ?=
 =?us-ascii?Q?kL6Wl9I365LJoarXEqpJ556BpDe6pBruoW342hT9k0asW/5w2YqoEWYGLCQd?=
 =?us-ascii?Q?fCAhYZeSNdyyYBcepLACwVFWWudbTE7EWovAZn3rL5Mko0cIccGCUu4hsGo9?=
 =?us-ascii?Q?wSIy7+yV3IUGjSqgNLxeXIernH+jdZ/7yRTiOxvwM2DFeJabQMoxVTy5q/bb?=
 =?us-ascii?Q?NGPFm6JEIGKiHuUVQ5GwyWl9B9HobYgFxhyT02+NLxxNj5o2w7jjdjx3vyPL?=
 =?us-ascii?Q?REsv9bEfBNhR638UPZJtqm8YV28OWI4LS3SlWZqduNeQEGr8cs5nEeDL65d0?=
 =?us-ascii?Q?1ucTS5xcs7o3QlbqwBrpt+o3aGD5a1Wtf0Hv+WYATLHwya9DrjCkj+eNqhU2?=
 =?us-ascii?Q?QIhtHCWJyfMVbt/7B27xFeuSjCXeTkeRe0UBQioz8SYByGTQ17PqT/pxO2hk?=
 =?us-ascii?Q?tqbxUodnZ68uiGyJ+g4oNiGcD/MlWZd0ceqkYna2RMQikypneJ0t1ubXe25S?=
 =?us-ascii?Q?fAScmWCO8iJ2uRB8KLzlBPmx+2CSi5dz4MvAuG3nKye9zOwObBcSf24Aw6DN?=
 =?us-ascii?Q?bqG9JbkON5VHjd01LgwttIREg1fg4oN/tGfLwTdLrRxtfQH/4RscPnDqnMfx?=
 =?us-ascii?Q?VWH7Le+6SBYxJyN7MoLp6Z2CtwKt1t/tVJ3m9Yk5gAI5Oq8TLVeZHowYx+IJ?=
 =?us-ascii?Q?xWduVPIiC+IKJ1+KTRDN6c3UrZDKOni683S7LBNpzVF47KfnwMrsPgHKCcIm?=
 =?us-ascii?Q?qo+0UTyjumCMzGBhcsugcWUyinhWpbE5qqQ6qHzdOv52nSqc/2M/TNRFeJLn?=
 =?us-ascii?Q?plFEhxf9ihaw2TV0uSnbRkdgv/SnB5/uBZVj56CWCjOyMiDIU5mDpQAnld4f?=
 =?us-ascii?Q?B+QdUjMMk4djfaIeeUq+vXEVOafVFUX4yRRyg00Te5eLAp2o/Ji4ahD7T70f?=
 =?us-ascii?Q?p0EWXFtkgtuYnIxF4E/6MvoRB6TPDt4QJw6XFlhUtXo17GAS+k7HF7dSpLqO?=
 =?us-ascii?Q?mJNDgqKnCBjJag8tsomw00IFy8Iz1kL0S2qpdg/h6H3EyEnsfFB7tCfLeh2c?=
 =?us-ascii?Q?Fc76UnqWaMHbPQLzvEfTWEEkVIYGU1oTD7OqmG/IT8VfWL69+7VoUG8KnAz/?=
 =?us-ascii?Q?7BzjUwrYM7KSIqVJTGqQ+J8/q8kiJ+JcJD8LN+IgwFzImUxSCTmKA1xn95xJ?=
 =?us-ascii?Q?mtGPlsh1Y0RqCC4Fo7G0kWxPXUlf/5Opj0WRKN/QgKFINV69+Ie7UoieRr5M?=
 =?us-ascii?Q?jClhj+2iDbFSn3ZMbBAw/dtHrurkeecfHPbj?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?q/gv7nEXIadkS3Rf6Gb9LQgU74IO9YgkHMr73rInCkf/FVHGuC75OdZvDc2y?=
 =?us-ascii?Q?WnnhlIVLEi1sx70UJyfxU6RpOPNDoF6eOvCDAWKN7fTlDcLH7H6hCS8Hgw2H?=
 =?us-ascii?Q?43znWWDwnEJgJZtQexdw9pHzEJfg/TAEkih1unf/CiiPBG/ace7rhZtJsZPC?=
 =?us-ascii?Q?JyKSIjJB311s5voDs6iY8gLSzcHROcGGpS5BRJV/qXajo5COOr82STLH8mAi?=
 =?us-ascii?Q?wXSkRVKCmSgPKJeaVN4YbmOd90j9+9np+XEDJ1eSiW/g7rWK7qx5GMdUd5PT?=
 =?us-ascii?Q?z3z5z1vOSn/lKgsWwEEp14XYXcw0eCsPwBQFV8zL1h7rTZT/ttwITFiJWVgR?=
 =?us-ascii?Q?fhkDrAgtl5YJhn/UBf6L+rT6IFfvTSgx4wqYEwSGzyYxf7Zen4kRZbhptBZb?=
 =?us-ascii?Q?QRAaj35oEHuwrqK8xpB9bvGqRwpL0hIqCA7Eko7UoQS5ngEn7+1VqKX9ykTQ?=
 =?us-ascii?Q?z6a00ZgDzf9fhPn/3CmWBK7tN3gjUEuIlAssaKE1DuQIIQ5FxqHwcQuaMjsX?=
 =?us-ascii?Q?7PEDjiKWn0Itm9sQTj378YajKzpQZFajm4P0ttaKx/5Y1I99bX93FK8T650r?=
 =?us-ascii?Q?KkT+EkcuYbbjegQapFC8z4kc94OtG9TcBRg75i31YCYW4tYzNXkA4gTOunWN?=
 =?us-ascii?Q?Rej7ecjLeSZ30dqK84A5tunKxsHSdawLWc7Cf0vY5nAdf3bJVL1dLydYMx3Z?=
 =?us-ascii?Q?9dDd/oqjrl5FNQCfax7+/oOxIW9EpDSlfAJmZps0PkEX5H0jrQnsuf8hJizn?=
 =?us-ascii?Q?/ACy27zGx4xmiDI7Edk7tI/90O/8q43imZe2z2nzYOhtMiV3tUt3xGrCId5X?=
 =?us-ascii?Q?X693MeFYNa2NW+6Xdve6+xgkdFRJw6LM91DA1OYpyoptvWpn3kJRssmHjZFx?=
 =?us-ascii?Q?FzML/3IiPOePMrvgWDG6f0MC9i/B/oXA33lsWBeZIyeGsyrlBVDK57rawts4?=
 =?us-ascii?Q?t6vefChR1ACZtjc+0WtvOHKqqAc5jKjdf1cNUA3h9gMXl+MuNVHTSY+1gnZf?=
 =?us-ascii?Q?nS8JzOiv9I9EZOHyQ/k420iQ73sBYnYjw5nzS/WFrTuyy9HTxYU/BsJicAWu?=
 =?us-ascii?Q?Snn9iFbERqCSH09y9SXHM/FQKyC2FYEICFinwboV0vALEMmd7vbgQCoDJ/1r?=
 =?us-ascii?Q?aD2RDsgqauHSGGBnH89tgtwS2bHkisfmyLBOJiAkBjQnLBN5dTzNNdZ/vekf?=
 =?us-ascii?Q?YrbkvnPLTutnRKSQWNbqmf/5Z4sVtJEeUyPyQHYQLSOeiDWTBLsmLgTcEJlg?=
 =?us-ascii?Q?zK61z/za70LxzzykYOqLtrTIonp59Pg9qICiM7Se/2G6SWwZiJ7AXZ29930n?=
 =?us-ascii?Q?pim9S+c8b1Pvxpy8f7rATPELflZRk1DZAjrT6N7I6XFB0MukdYqZk3QasFDP?=
 =?us-ascii?Q?f5v9k6O8qcQZwMf6qNlPYJ7066JGjCWT+PMLYocrFsZSG9PmmCDm3IqaMv1D?=
 =?us-ascii?Q?Rtv/8XBcF5Xqjp9IHb1TWxP6VIhGpeoOt0RW0mSqwkd8Sq64bX7DkkBxMEvI?=
 =?us-ascii?Q?kKuKCsftXuinAMO4Gxtg7k+qjlmyCGtuCbNZJt1L+qV+3ZkAVk02s1hv76oI?=
 =?us-ascii?Q?0VaCyKNnyDEIZds1V69/Y4SYUBWkAX+yiHyeppA1Qy3fmMLaxHMOjNjgZSfb?=
 =?us-ascii?Q?EH9ERZy7DuASADTCYecZ9qBKilbjBPdxErPP3HJ/gVLjdH+LzaVXvsqg6CLZ?=
 =?us-ascii?Q?cRvRxTwohKj3VlzYB88vGQyvy5bMItvsvP37Rf3XlcjRjbOsfakMTtGMK46k?=
 =?us-ascii?Q?PyM7pKtv+6FZ1ubO8rI0a/PcBRtaetlRBHuq5vPl1lQWETYuolu1?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c512262-62bf-4e1e-6755-08de4e98a54f
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 09:31:05.1745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ayz8PAGKk71w7wh8zSHsnK6V2CWNtTjdGq1+vSYAqBq5N7AAwuRHk6ALoUWCc3Fc90F5956X3C6BAfa+NSvzhrr5XOaUBTW+LNei7a3e+pPEvHu84Af2et/UFFJfbsc/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB14326
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Jan 2026 09:31:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21466

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 9c0609d685b27a0bb392390680207baa820ed118 upstream.

Align existing defines to follow the consistent pattern:
I3C_BUS_<PARAM>_<MAX|MIN|TYP>_<UNIT>. Prepare the codebase for adding
new parameters and help avoid duplication.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://lore.kernel.org/r/20250724094146.6443-2-wsa+renesas@sang-engi=
neering.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/i3c/master.c               | 12 ++++++------
 drivers/i3c/master/dw-i3c-master.c |  4 ++--
 include/linux/i3c/master.h         |  9 +++++----
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 6eb779affaba..8e41c15d2c97 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -727,12 +727,12 @@ static int i3c_bus_set_mode(struct i3c_bus *i3cbus, e=
num i3c_bus_mode mode,
 	switch (i3cbus->mode) {
 	case I3C_BUS_MODE_PURE:
 		if (!i3cbus->scl_rate.i3c)
-			i3cbus->scl_rate.i3c =3D I3C_BUS_TYP_I3C_SCL_RATE;
+			i3cbus->scl_rate.i3c =3D I3C_BUS_I3C_SCL_TYP_RATE;
 		break;
 	case I3C_BUS_MODE_MIXED_FAST:
 	case I3C_BUS_MODE_MIXED_LIMITED:
 		if (!i3cbus->scl_rate.i3c)
-			i3cbus->scl_rate.i3c =3D I3C_BUS_TYP_I3C_SCL_RATE;
+			i3cbus->scl_rate.i3c =3D I3C_BUS_I3C_SCL_TYP_RATE;
 		if (!i3cbus->scl_rate.i2c)
 			i3cbus->scl_rate.i2c =3D max_i2c_scl_rate;
 		break;
@@ -754,8 +754,8 @@ static int i3c_bus_set_mode(struct i3c_bus *i3cbus, enu=
m i3c_bus_mode mode,
 	 * I3C/I2C frequency may have been overridden, check that user-provided
 	 * values are not exceeding max possible frequency.
 	 */
-	if (i3cbus->scl_rate.i3c > I3C_BUS_MAX_I3C_SCL_RATE ||
-	    i3cbus->scl_rate.i2c > I3C_BUS_I2C_FM_PLUS_SCL_RATE)
+	if (i3cbus->scl_rate.i3c > I3C_BUS_I3C_SCL_MAX_RATE ||
+	    i3cbus->scl_rate.i2c > I3C_BUS_I2C_FM_PLUS_SCL_MAX_RATE)
 		return -EINVAL;
=20
 	return 0;
@@ -2785,7 +2785,7 @@ int i3c_master_register(struct i3c_master_controller =
*master,
 			const struct i3c_master_controller_ops *ops,
 			bool secondary)
 {
-	unsigned long i2c_scl_rate =3D I3C_BUS_I2C_FM_PLUS_SCL_RATE;
+	unsigned long i2c_scl_rate =3D I3C_BUS_I2C_FM_PLUS_SCL_MAX_RATE;
 	struct i3c_bus *i3cbus =3D i3c_master_get_bus(master);
 	enum i3c_bus_mode mode =3D I3C_BUS_MODE_PURE;
 	struct i2c_dev_boardinfo *i2cbi;
@@ -2844,7 +2844,7 @@ int i3c_master_register(struct i3c_master_controller =
*master,
 		}
=20
 		if (i2cbi->lvr & I3C_LVR_I2C_FM_MODE)
-			i2c_scl_rate =3D I3C_BUS_I2C_FM_SCL_RATE;
+			i2c_scl_rate =3D I3C_BUS_I2C_FM_SCL_MAX_RATE;
 	}
=20
 	ret =3D i3c_bus_set_mode(i3cbus, mode, i2c_scl_rate);
diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c=
-master.c
index 577368467b8b..2c0b2abdb7c1 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -622,14 +622,14 @@ static int dw_i2c_clk_cfg(struct dw_i3c_master *maste=
r)
 	core_period =3D DIV_ROUND_UP(1000000000, core_rate);
=20
 	lcnt =3D DIV_ROUND_UP(I3C_BUS_I2C_FMP_TLOW_MIN_NS, core_period);
-	hcnt =3D DIV_ROUND_UP(core_rate, I3C_BUS_I2C_FM_PLUS_SCL_RATE) - lcnt;
+	hcnt =3D DIV_ROUND_UP(core_rate, I3C_BUS_I2C_FM_PLUS_SCL_MAX_RATE) - lcnt=
;
 	scl_timing =3D SCL_I2C_FMP_TIMING_HCNT(hcnt) |
 		     SCL_I2C_FMP_TIMING_LCNT(lcnt);
 	writel(scl_timing, master->regs + SCL_I2C_FMP_TIMING);
 	master->i2c_fmp_timing =3D scl_timing;
=20
 	lcnt =3D DIV_ROUND_UP(I3C_BUS_I2C_FM_TLOW_MIN_NS, core_period);
-	hcnt =3D DIV_ROUND_UP(core_rate, I3C_BUS_I2C_FM_SCL_RATE) - lcnt;
+	hcnt =3D DIV_ROUND_UP(core_rate, I3C_BUS_I2C_FM_SCL_MAX_RATE) - lcnt;
 	scl_timing =3D SCL_I2C_FM_TIMING_HCNT(hcnt) |
 		     SCL_I2C_FM_TIMING_LCNT(lcnt);
 	writel(scl_timing, master->regs + SCL_I2C_FM_TIMING);
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index c67922ece617..7dfcbe530515 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -249,10 +249,11 @@ struct i3c_device {
  */
 #define I3C_BUS_MAX_DEVS		11
=20
-#define I3C_BUS_MAX_I3C_SCL_RATE	12900000
-#define I3C_BUS_TYP_I3C_SCL_RATE	12500000
-#define I3C_BUS_I2C_FM_PLUS_SCL_RATE	1000000
-#define I3C_BUS_I2C_FM_SCL_RATE		400000
+/* Taken from the I3C Spec V1.1.1, chapter 6.2. "Timing specification" */
+#define I3C_BUS_I2C_FM_PLUS_SCL_MAX_RATE	1000000
+#define I3C_BUS_I2C_FM_SCL_MAX_RATE		400000
+#define I3C_BUS_I3C_SCL_MAX_RATE	12900000
+#define I3C_BUS_I3C_SCL_TYP_RATE	12500000
 #define I3C_BUS_TLOW_OD_MIN_NS		200
=20
 /**
--=20
2.43.0


