Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99042C44520
	for <webhook@archiver.kernel.org>; Fri, 17 Jul 2026 13:16:00 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.11])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13216.1784294155421129952
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Jul 2026 06:15:55 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=pKmPWIZu;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.11, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wmv/s2rC8aMHMtyJEqbpc2E6F8AtmuHy6fyigLeWRRnINhk+Wp3sD1jug2Y5OxqWiFv9Lxu+jxKebzscS7LD7ahieVIgj9E3+O8StIow1CI/evN9YqSR5SxCqYTuNBFst5qkr3Gqd/EGwF7ceGHTz60SMS46y2HFRWfzBgZ3tZ3O0R+HW6cPMe9qEBOxjqXmW07wKyQy0L7EOwuqglBrhk9/JY9FrYN+tYRMh/wg/7eRvtiGbpt2XW7jnBmGdeZjjEvHXV78IFzeiTiblBJjQ0Q6r8J2Ljl58Cdn3BSRfSHvAbUK+21YSp5bqsbePkstvO+Nv/FqK2jZBtBECGS6hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N3Dz+LGBFCQxB27y5wNUMPzb2vgJicthgqgty//XYRI=;
 b=oCnnHd5FZB8bAe2NPCtOj/F/cAlGDmymbCWd6lL2utVNmYG+Y25jTvufxoZB3SRtbqIjXK6ELUqm7jdw5+TiGlulgdwXDz9N1Pkq/ikg/cLB852nXoQIr8OeXUv6GXyWsclAfYfUN2XiAbJKpjBXWFg7xrCkR53c32IgZceQZQQTHZJyFn5jchBH3g5cB0xni4GzLKEuHG2BweuqX+iPtefGGBQPjji/JvkW/jvpAV7sxYbkJifaJj3aJoXXemwJASFz/uCeL9rtwd62brV+KJvuQ1gTy+QoYoia5C6qOVm3QUh2ipIr5t8rehU/TAVl51fcNrChBBeqEbzx7BDSlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3Dz+LGBFCQxB27y5wNUMPzb2vgJicthgqgty//XYRI=;
 b=pKmPWIZuZZsQjd7/cGeHV+sOvTWKY5sCTKCaYKazn/dIBSj7oz49eIP+EnnIGG8fXqwIpNahFpjOCzF0vyENz3kme+L3YtRExSwE2uOCPgkJpUwt+yjRqWf2wocG/JKbztPgyElVwz7PXaiE94H6DSzCAspmP1MZfY4/0r0y1C8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by TYWPR01MB8447.jpnprd01.prod.outlook.com (2603:1096:400:174::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 13:15:53 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 13:15:53 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 10/15] hwmon: (lm75) simplify lm75_write_config()
Date: Fri, 17 Jul 2026 15:14:57 +0200
Message-ID: <20260717131502.2234020-11-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260717131502.2234020-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260717131502.2234020-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0041.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::6) To TYRPR01MB13588.jpnprd01.prod.outlook.com
 (2603:1096:405:18d::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB13588:EE_|TYWPR01MB8447:EE_
X-MS-Office365-Filtering-Correlation-Id: 238ca57e-d501-4fcb-3ec4-08dee4058763
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|52116014|38350700014|10067099003|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	m3vV1P9THb8oSlF744SBvEPHc7f2sSFv+aBwmen8JRZ4zD/fCZcnEBa7tscQyFJCXiqHs8TvIYRaqJ8nPiBAUXdyAXueSTujb3VugYWaMVWSYRQJe4suDR+/DQLwNOh0fp9v0XCM3GqsgOGjN1wgQlek1nBSEqJ9GaDzCjDayZ105O7UwkJBLF5Xi2tlWdA29zvBfHaHAxk4WdA7T35Gs+9sXkn/cAiQDa+4pEgkqI3d9N5YbMc/GnS6Byvjp1czfnZdW59hsNm5rKXitXRjHN/71hO6XQtsPT3cCiinC3pb9SaCqsKWAGLknFZK35GuLzKigxwBz1i1ktNhm5ih2a1vLvN6RoEGE+yyR1PmKxgqm4qTQMDkSVZ8lbFfRkg1Qtyb7wYod+njTkMcJN/MYwKND/1vL2Ep/s7svFqfAfwEyaH+XSIYcs7EeqxPjwTeznugzlXC9znMCmPJd7FJCUeusEO+KebIYJPFkWDxF3MTx+haaO/T0GtF2WXFD/IMzq+0A1gGmn4eKMt0w7vOmJkBPQkFYKLgeA4WE10G/dINgU5lb9PVPKTYkjkY1mbvmPYXbFv8Uznhigov6O1xl+PCsEOHcwla5dxrQ9R0c7QaZlDvlkqlcIwXtJmlFgEjNygT4mRBVtWFn66h19aud3G4fMJEKycIa8cWXxgCspeFHbYw1ZCsnDS/b5hN0rNw6Zf2iYSoZO+YIqiACxSiULIQ4BL/V3QyeGnM3JTD5C4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB13588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(52116014)(38350700014)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?8+F84DbPlYxYdo+fk71iCqwcjCjgR5yUZjKFzqvwxrBAsfvZhXsa5Y7sYKUg?=
 =?us-ascii?Q?9LbcIsveDNcUw8EMtlKTixbdaqx3Kw/xvyOx0I5m4JRnXjLw/iyeNi5VzTg7?=
 =?us-ascii?Q?ncHLEFia11d+CaZd7s70fOmRedDKwgCgiKw1ya3fb4kKaU79yXflIUfVQjd8?=
 =?us-ascii?Q?4ez+eOxCs+oxrBKXmtKMox2Vn1HooLcnQsGtLP384Ih8VYYglGnPt4CpnhUu?=
 =?us-ascii?Q?uSYkFJ/uN0IHGmkngrKnG+mXVn6fxjLpwO6e8YjwUmT9CbhE5p5jR0XRYZS9?=
 =?us-ascii?Q?SVGN8b/vB6NQx1LiqzdZPqSc/KejIxPudfwTGZ3V1btf7NCpxkNkd4ChaHii?=
 =?us-ascii?Q?H+YFqPXwOEkDgXIQj/t+9i75QbTSAjPQFHVszS8px7cOJ2j7FEFPMXd3JZGL?=
 =?us-ascii?Q?EtEOA1dC0NoZG0Nz9Mo+RY9bT4mInAzRwqHZm9HLd7F48fby/EZmfGMhSbeb?=
 =?us-ascii?Q?K1fOFfWDJZgFBXLiQ6EI4E7UPfPNJSj8dJbJTfjOcuRiQPFP+8SyTgxUE9q4?=
 =?us-ascii?Q?2IWWuO591DsEyP8uGYhMyrwS6KhqezUeHnIAxqIx/fATn/aOF2Rl3tCZGltu?=
 =?us-ascii?Q?Id2MfmACUnThalO51awq61cfKIb+MMjdgdAnHq1W18QtAUmioPcdq7AQ6w/t?=
 =?us-ascii?Q?n3riPO/u9ejW3mlED2NUOTkSUh/U4qNC6zuhpYgUB9ktMONz3Xoya1bn5BGS?=
 =?us-ascii?Q?WZp8NVwQprNruLSrUoKe62nwoc9RHZAKsLnBt/Qt1AaqmmtumWLbOB3Pe0Er?=
 =?us-ascii?Q?uw0oOMb1dauCmQoddoR19LgMQ6/rT/cTgwTPvWn8b1PvHQP8bez8Qgx3VAyP?=
 =?us-ascii?Q?9bF27xSED4dJmNa7bFBH9qSZBF+Auk+4B9yY0psY6tGqa/pcm/3nXUBA8vFt?=
 =?us-ascii?Q?Zdai2+8hRybJPg4flQNoIsfNMYg11W82GAUaIqhqWbZTR89s3PjlAcdevneh?=
 =?us-ascii?Q?b4ke+7rAgqX+j/s5jWKF4+feMYu3j4K7qeKWSUiOlQxh2ooWMZwwJd1ydCu2?=
 =?us-ascii?Q?hARto/omo3TctwtGYIPuaciP4nYchYvsDIxYQZYhnlmW76vjUFqBzn9+XKWS?=
 =?us-ascii?Q?f3ZTwFMkH/uLq3KHs9GPaZ8LUa9btdXMzlMyIDFuaEeBDGrTqQAMzegTCABF?=
 =?us-ascii?Q?Er1cR31tswyEYBaw2Jm9GJGw3r/661pRw9o3Ip0u3UgAAD1wDmgl2aoIjA56?=
 =?us-ascii?Q?w50eW84BtbYP/Hr+2/mM+i6+XOMbnYrpqKeU36WhmEl++aROFw7H2+Amvnlf?=
 =?us-ascii?Q?1Y/PQp6JYLjAhBPHJ6efStshBd+Stf7Ww0aBYg75HIXqL0xCq3sPuP5mZOHj?=
 =?us-ascii?Q?tjA5PSDBQOHhHg5cZEVpKOtiTnQ5FwBWE1//jDGemCuddDDonhoO3NxpiepE?=
 =?us-ascii?Q?esuz2Iiq0/Vm/n9QtgVL1BQD3YS02E6xJfhgiA/CEkMSgg9Qfnb6bMuHPqRb?=
 =?us-ascii?Q?TJ7a5krmyVIFChDyclqLAAausxHvizvbLsw0VZaxPziI6LNQU90JNmEW5UJA?=
 =?us-ascii?Q?kfyyHn3wijCQqvtUBXNMuwubQPePZfovy7mYxwU7iJjcTQBd1CqJnkp35JhZ?=
 =?us-ascii?Q?ZvcBljxuUzx4jkHU2a6aPSSQBgX4rcMLnXHHgefGgQhrp5kAmqf/xy3nCeVF?=
 =?us-ascii?Q?8TgQy6bh2c5w4Cn7XyFPWkz0auMjDsTkNWkWCf01BrwRG0vNqD4yIy6LXpid?=
 =?us-ascii?Q?eOASpuIBOs/ZTH2mYn+rJ3ZrjLalnyC+T2jwdiVgPnPZChVdN7DdGzMhtRZJ?=
 =?us-ascii?Q?PyVaji7un1B9ieOgEmFtydmBvuFO2KbUonAgxA6phvUUN6+yBkp3?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 238ca57e-d501-4fcb-3ec4-08dee4058763
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:15:53.1208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QlaLhewKlfVtxfZ1l96FzM7eDfi1OSiqZaoori0bps74Fhw4RF8gjYuDRCH+ZcKlLxcCmT1BTgWfidnnvemQjHx7L6ysFVTis8icP85G7ZP78zkB1OnJNz9Z/kQoYkrU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8447
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Jul 2026 13:16:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23662

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit c4d08cf8a03eb9b14858a9b8cf8f4d71a639da57 upstream.

After previous refactoring, it is now possible to make
lm75_write_config() a simple inline function.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20241219225522.3490-8-wsa+renesas@sang-engi=
neering.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/hwmon/lm75.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index b8889392d5da..b03e760cf3a1 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -340,17 +340,11 @@ static inline long lm75_reg_to_mc(s16 temp, u8 resolu=
tion)
 	return ((temp >> (16 - resolution)) * 1000) >> (resolution - 8);
 }
=20
-static int lm75_write_config(struct lm75_data *data, u16 set_mask,
-			     u16 clr_mask)
+static inline int lm75_write_config(struct lm75_data *data, u16 set_mask,
+				    u16 clr_mask)
 {
-	int err;
-
-	err =3D regmap_update_bits(data->regmap, LM75_REG_CONF,
-				 clr_mask | LM75_SHUTDOWN, set_mask);
-	if (err)
-		return err;
-
-	return 0;
+	return regmap_update_bits(data->regmap, LM75_REG_CONF,
+				  clr_mask | LM75_SHUTDOWN, set_mask);
 }
=20
 static irqreturn_t lm75_alarm_handler(int irq, void *private)
--=20
2.54.0


