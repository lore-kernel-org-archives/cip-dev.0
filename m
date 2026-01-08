Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E66CCF6AA1
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 09:29:50 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.29])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3008.1767864584694369998
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Jan 2026 01:29:45 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=DPqgTNbZ;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.29, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oRZoqRocWbHFpsqMs6vNic/yCsZeI2i2WUd65UmMPvlKuUXQBHf+0c4S29rxfWsQeJwMvRrH8w1PzEk+qAn/SdUas4ceMX69h2Fh6mBw8oDfwQc+0s0lTnsjVGm2B5L35eD2qxxnMTJxEMR2si5GtYMIbmPo8MpFX529i19rdXQc4UZR5zaRA29tvUEdq+y2iNmHhA7BBfWSrhrI7YC2lM3CARGrGFrm72y0u1BWsMLglM0TqfjNWR88jCw0NFoUPYhakS+pP0PUHLTP8q4CIJjZdYiI0kTS1V0LgUHPyYymV+aDKEFLXhTBhH0uPXhd+ZUW89itVKWGJrMFmZuiTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rJCp7uF4+ObP6AJcfVLjMyxNE6QJY+Lqb7hM2Q+FPhk=;
 b=RNB2ZE76Rg8kpM7J2DP+qcoIGqg3vFs8p33K0HJIHgn1LHalkdgxYR56D+JQ86AUebuavD1L7Zv79DqRuMyjBn/3tUacJKc+lOt2yR6wCEHTtKPkNvcq3lSsPqhq3T7WTSRlH0tpmRW3/OtAtdQCJDNbSINycW/InapZBnZEMIRG0tISfzDBbBHMufsscSKB9+LcIa4Q9xTgq4PxMIImMxpWdb0yPHbqbHa4T/NguNb0zWtdTMTS0mRR9tUlmqXl2t+D/UwNOPluNE2jJ7Fxeup2ALQWjvLMSmxdEPhp3giBwPQUlACFbZZDcUSYcY2j2ITtGbjg7ZgKtmv3zxe3Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJCp7uF4+ObP6AJcfVLjMyxNE6QJY+Lqb7hM2Q+FPhk=;
 b=DPqgTNbZ7HXxg2IOKPgQitV51H8HO3kBxSITboxFfOI7Hgs7xzx+bcQ13qvCd3sEbMBBc5M7Hs5Ws0Sxd+jpBl/M6eKKH6Cs47y1qDnBfH+IAXo0eLfAqO4SRvufW24ixnnrPOk0gMWCJfAaZqshsnIcFc6bGQIsDuEsHhkDSbA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY7PR01MB14750.jpnprd01.prod.outlook.com (2603:1096:405:257::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 09:29:42 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 09:29:42 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 19/22] hwmon: (tmp108) Add helper function tmp108_common_probe() to prepare I3C support
Date: Thu,  8 Jan 2026 10:28:20 +0100
Message-ID: <20260108092823.489287-20-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TY7PR01MB14750:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c5d783c-7fbb-4232-f4f5-08de4e98740f
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?RE/2BrzsXjn5O1dOmY3pIhhNgcM6ooJdGyAbp5MhteFHwsE3y4DNgiV9YKJi?=
 =?us-ascii?Q?eFysyi0Xi2tr4DDGIxgyDD4SeVhd8moZHsEkeSZU1QefZ3Uj+e6z5v7+p4mB?=
 =?us-ascii?Q?gAn0pyxJl9YEhlr0oOwt+YkXggjfpDQ+dq/stxr6Jh66XuRLg06KhFuyTXkb?=
 =?us-ascii?Q?BSQhdNzgIC/coTCjJBgj1db7Ta8UIvb6JD43Mf/nvGRYfMjRejB84QJbIzWz?=
 =?us-ascii?Q?ncT+y2TdJZw0c90T4gTKiH8qFDPCT53nvSZ0s5ExtYKmX9y3QH9OTKBy1Qza?=
 =?us-ascii?Q?zp6PUbLdcjEo4VyoaMcdVHsmUAlNVyjl4wOjf5UDoJz5WCW9IHRTZ+mgQodn?=
 =?us-ascii?Q?6swZboLB0jUEFXakWQvc6vQWdSLSFeMJZwnyOo4GjVHdurUg+bpnqz4hM2v0?=
 =?us-ascii?Q?YaNpNe6Yl5qJRHoYvi0Omke0vXIKBdPdqTCKmbLJXThuk1r/pcBpgYn932hX?=
 =?us-ascii?Q?G68r08yZ4wnCwb7tB0v//Av1KtUM6Vgt2PvGE5pN9vRT9KXgaJ/B/Qk45aW7?=
 =?us-ascii?Q?KM/d9fQF56MVlQhuH/fSm06DXgEnl5Gbf3AK1+46Q+uxWjyY44592kYP/1J8?=
 =?us-ascii?Q?ODsEJNNSDjplrJAd+WbqUbwNW63s6k46Q97eMNoxGNErMrhODngawJQlg/qc?=
 =?us-ascii?Q?vvZh7VjU132SZHq7vFEN16K/vF6SRz4rMRLRQLmZEU3uV+WRwZsR/hK4U6LU?=
 =?us-ascii?Q?6mgMRqaOTdXtZw0QF//xjGlErhvs3JtrxxMBTbglv9nMM2cqlxApPzo3+G+B?=
 =?us-ascii?Q?8wvJPbK0uHyd+tLJ3NYKXoFnN2fX1AKi5J3mvy1xFXLKD31WKvZU2RO84v2J?=
 =?us-ascii?Q?crE/2jJ8oStpAr76ykpFBq4BrBnOXU2r7g7NvGUbkNrYo0kBDxwO4Y72acr1?=
 =?us-ascii?Q?7tdcSuXKrO0Jg9koWE7+t1SShLpWKrLMqZYhVTCqxOzmC/8ZWqG3SHZLVl5b?=
 =?us-ascii?Q?/NH25bu1b0PmSRKAYSFznmNEbP8ae/H6w/ZGshI1QgDGg6M0HUVAND2bXRN9?=
 =?us-ascii?Q?8FTG97Ip2t/r57OqAUY/3CLEMqKToL9rSGNKieJZ38Bb8teENdrksUbXRDKK?=
 =?us-ascii?Q?IWHiN5DhxM+RG3VBDLRvhk5piJATZQoipiEfMhY1Qgu0MdAa3OTsQZmfn3f/?=
 =?us-ascii?Q?zCRxa1EKOzP+pIfeSNbDPwjktoaTdSfMF7q4CfVhvKHYrf+62i2dF2yGyyZh?=
 =?us-ascii?Q?ZOb2Nj+YFi9g3NedS+zzBQfH03cRA8tmcYoq1iEOj2d+YIwU8AtWBoYG3WQ1?=
 =?us-ascii?Q?Ou3Nit58ln38cC4d8Szj0QqQdJRSX6+wNRXoxp1xuE0QKqlnvt36r4e2CMqW?=
 =?us-ascii?Q?XP9l19xAriu0SDOn6EMHWe2FR2J6GFu2Pt7eICIor3wqYVig5uKYpPQVIiy1?=
 =?us-ascii?Q?WGEsWcGB6wzg3r6Z4+Ap3oazzFUh/Pm/Epxhkdju19BALgr6tbPU/3y3VL0j?=
 =?us-ascii?Q?EccfruV/z8MNvnlSr8HeiZinA9r4OiDjbKNwF/UqbA20d7z1mit05t3Gw2jd?=
 =?us-ascii?Q?urLuC6cql2tt5Km2g9MoAhx2PCGUw6nT/G/x?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?yBQISiuv4yk/FpF+/AlJD7MRGn94/CvCIYNTp426xmVx9urjIqek2f03sfJU?=
 =?us-ascii?Q?Y/3nMk5aI4gGi13h4g5/R17UNv/FYqROs5PtKVWYp++3A7Wx0q3kYsf0suVs?=
 =?us-ascii?Q?qMDUx07SkULfE0jf6tDt3LQrKPm7DjwEmVNeljZiqUQ8igbMtp3/locnoHiP?=
 =?us-ascii?Q?HxugCvjwHBBfhm9csUuyy5moarWt+rrdoq1RIQGcCvUWgBIFGDnXEMGtoyey?=
 =?us-ascii?Q?GYevAjKTsT9OoUvqqSlAbbKuExZReDB4/1/XHHl3Kmyhchjwc+18u69Ky5D3?=
 =?us-ascii?Q?h336StF9lW55DEcBvqPKLKwc9uazgoqSll+DfdJyp6efMDapu8Gk/1IBxHpU?=
 =?us-ascii?Q?jXg1Vw6otZQGTDrE8U+WGzumDppbh9QBra+cWBNGlgTAzffHGreYVnMpQgie?=
 =?us-ascii?Q?8A0NxBJHcfxwSzZtZ0gn1V42rTWx3bmf6JVdgHemmLQqPkwEl2bGIQuD70rr?=
 =?us-ascii?Q?E7PlwR6kvsqqMr/f2Flab0vtfJgY6ysNs1NXCmU/6jW6SYbXT5Y0DqO31WOM?=
 =?us-ascii?Q?e8e+q9W8ZTHHI/7abB4x2bZfwb+rhXhfVos5M9oG2eD8JdU6C1k9iN3cdSx7?=
 =?us-ascii?Q?G0R9xwoqlf4U5RWCORnEraM8ygtTpC54wRsmxAN9ZFIrY6rmE8PPKfk80Zcl?=
 =?us-ascii?Q?wB7lcZG16ThSoQUVCGX4rn/uM/6J5X/MdJ40vaf7/723Szs9mRyIwz+kVpde?=
 =?us-ascii?Q?JyHwOnAJqnxWX+Og1aGN/ItqvGrFDxsNmXp5hiDWKzjfx5qllVi0myqNVxF9?=
 =?us-ascii?Q?ddYwzfcfXimL6VCgOxUqMhVCpqxKa5OGc2gAzFCTX2a3Zwexe3WRsB6oygQ1?=
 =?us-ascii?Q?3QMklGjdZ7ko2XzPwdZQdv2/0k8GG+rNWXciOzy4ns7vseY9XmD+zRj1CgKd?=
 =?us-ascii?Q?j7Ui4trK8aMAr+58TFwO9//Os+ZMrv7BG54WSM3mBrZJHyYqSWmJfjaxxzp8?=
 =?us-ascii?Q?HWev4/k9sJjy4P2JFpYgkjCUFDslGKGkkeG5owV5sISXQ9j1UHf1YE8IyApA?=
 =?us-ascii?Q?UUD65avGCDgg32FETPp3z0oNeH4pwosCkW13tW5L1B4JhKUAevBQKRco8hJ1?=
 =?us-ascii?Q?QOdlOoTkHc2YUQWAkurUz3IsYpFbrm+z+kEqhdb/ik+Aj2I3fAoM2UD/GzE9?=
 =?us-ascii?Q?CDIIZjZDX80Sx2CzQjpZI1QgxwYr8EXPvLJoUCHT7VPwBWuOn1ZE3LC78SbW?=
 =?us-ascii?Q?fGIgNL6Vb/TOSvAoONSxgmIAzc3Q67aCZpiQBf7w69ANIwQTpztIZtzsVZgz?=
 =?us-ascii?Q?KeLQsesoX4/Vt/stkUbn71hkFf61eMBt+sUGMI215K0tn79U70AUAMBROKhI?=
 =?us-ascii?Q?4E2oqJF/8mwmSiuvS/DPz39nBI8StnG+XSuz693Sz2iNEhKZkH/PwZzY+9GF?=
 =?us-ascii?Q?x1h6IgeeiAWHYVUi6LxaH+5VeX1PElDCDsU3XD84M6l7SUu7m0i+D++PWExd?=
 =?us-ascii?Q?RsW9y5Rg0PDUDsFPf+29REWMEQMzFAuWXRyPYkJ/H3uIBqe9Byc9lRxRMKle?=
 =?us-ascii?Q?m1wGC+e22xFEwe+EOmhkWxXtZAlMnp2xYid17pHccV58jWlunumHX1AfMtLV?=
 =?us-ascii?Q?NUtIlryJ1JRcYZosLLCi3y79c6islqqV9w7k6G/lZ7K5ikp0GYcmPrB9nEg7?=
 =?us-ascii?Q?yA+WSs75fUPWkvJJFYkEeWyQdtMx4FFxH6MedL8bROK4PT8nMEh0/0fb2gBe?=
 =?us-ascii?Q?qYHtJHCJb5VmJSw9RKrqraD4NhItj8PjhrtHN4JKdxMvmlqNqIN2Upc4c4Wo?=
 =?us-ascii?Q?twM1MM4Q4pqoZVMZap7SM6nfETUEuDYvxsaeudT/cNT70vOzd/Ef?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c5d783c-7fbb-4232-f4f5-08de4e98740f
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 09:29:42.5591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fdiOPCxaPpzFPE4xZsP4GDPmHTL2Y7mgr3l+j2b3sZGXW95q8SjUtd5pJfC6FzF//EMrPSiJcJdy29007R6RJW4xeDpqIc86/q8uwAJW7A2axUbAUFNYVcAPuYMgkH1P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB14750
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Jan 2026 09:29:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21455

From: Frank Li <Frank.Li@nxp.com>

commit 700f3250198d51093884254220a96777a922dd47 upstream.

Add help function tmp108_common_probe() to pave road to support i3c for
P3T1085(NXP) chip.

Use dev_err_probe() to simplify the code.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Message-ID: <20241112-p3t1085-v4-1-a1334314b1e6@nxp.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/hwmon/tmp108.c | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/hwmon/tmp108.c b/drivers/hwmon/tmp108.c
index a8d9a4e00eb0..63c2eaa59d21 100644
--- a/drivers/hwmon/tmp108.c
+++ b/drivers/hwmon/tmp108.c
@@ -323,33 +323,19 @@ static const struct regmap_config tmp108_regmap_confi=
g =3D {
 	.use_single_write =3D true,
 };
=20
-static int tmp108_probe(struct i2c_client *client)
+static int tmp108_common_probe(struct device *dev, struct regmap *regmap, =
char *name)
 {
-	struct device *dev =3D &client->dev;
 	struct device *hwmon_dev;
 	struct tmp108 *tmp108;
-	int err;
 	u32 config;
-
-	if (!i2c_check_functionality(client->adapter,
-				     I2C_FUNC_SMBUS_WORD_DATA)) {
-		dev_err(dev,
-			"adapter doesn't support SMBus word transactions\n");
-		return -ENODEV;
-	}
+	int err;
=20
 	tmp108 =3D devm_kzalloc(dev, sizeof(*tmp108), GFP_KERNEL);
 	if (!tmp108)
 		return -ENOMEM;
=20
 	dev_set_drvdata(dev, tmp108);
-
-	tmp108->regmap =3D devm_regmap_init_i2c(client, &tmp108_regmap_config);
-	if (IS_ERR(tmp108->regmap)) {
-		err =3D PTR_ERR(tmp108->regmap);
-		dev_err(dev, "regmap init failed: %d", err);
-		return err;
-	}
+	tmp108->regmap =3D regmap;
=20
 	err =3D regmap_read(tmp108->regmap, TMP108_REG_CONF, &config);
 	if (err < 0) {
@@ -383,13 +369,30 @@ static int tmp108_probe(struct i2c_client *client)
 		return err;
 	}
=20
-	hwmon_dev =3D devm_hwmon_device_register_with_info(dev, client->name,
+	hwmon_dev =3D devm_hwmon_device_register_with_info(dev, name,
 							 tmp108,
 							 &tmp108_chip_info,
 							 NULL);
 	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
=20
+static int tmp108_probe(struct i2c_client *client)
+{
+	struct device *dev =3D &client->dev;
+	struct regmap *regmap;
+
+	if (!i2c_check_functionality(client->adapter,
+				     I2C_FUNC_SMBUS_WORD_DATA))
+		return dev_err_probe(dev, -ENODEV,
+				     "adapter doesn't support SMBus word transactions\n");
+
+	regmap =3D devm_regmap_init_i2c(client, &tmp108_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap), "regmap init failed");
+
+	return tmp108_common_probe(dev, regmap, client->name);
+}
+
 static int tmp108_suspend(struct device *dev)
 {
 	struct tmp108 *tmp108 =3D dev_get_drvdata(dev);
--=20
2.43.0


