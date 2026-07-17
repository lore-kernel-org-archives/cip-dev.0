Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2359DC44516
	for <webhook@archiver.kernel.org>; Fri, 17 Jul 2026 13:14:20 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.0])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13285.1784294054487969128
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Jul 2026 06:14:14 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=UCjeX1F9;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.0, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JNo42fze06TJMPrwiAIoZ7XtIX18CCjqZeLqnYbePQOOpX2H22S4tU5xr4t+fc/EpO0SB0Bcfnqmr/8CDpnHmrmjDsSMtph4dJ1niNID3SsGgjhp9y5q5IOOz0cE6GGG9EtVXpfqQsq0GXsXW4W2NHnaJFuXP3K4HsfF4TBfTqVDKG2xnQXeKePvN8sdDtMERS1vVlyQmeVDMWeqcPBXAUUp9xM8scOlgmMZnZ6+qY15U4jteVqvFrHtUhWCD5TB/phqu68Dx2p7BCnPfaN2Ll2yy5WmjARJvrqdeWYZ9bywLSI3GSu4RWy0AGs8ZFLkPkcy82gmmW+GEAWXU7QAZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sv/sxOKTY4vGwtx/ksRdo71EBkKJsnfuwtn9EFZAAhU=;
 b=J14dBpaiXjXvkcfXgptdEWwUuHNOJuSHRtiaVDQd9DHG9TAjyG2gMiY4EYMVM/Ty9gAgiDe7rDtvDri4RE331vFJXnD8X+TApvYsNZHEgJO5W5/3nQMtVgTAn0uFn71G+//kYtaiCAEjjjSt3szjDw7Vl5wNUUPnsLubIWQUQdVuPrfnAC+ZD0h5Ngb0PmneDQlFiY8T1meDlMT0UFwVlGl7nGsxYk6wZgOFPeBqGi/C4MAvU16pIeYvUgKxI6UKRNXaIPVvxQDSynhMcmkAOqLd+56ioBGB1OVySqh7VFKhvJ5ZlVqTeJ2r5Ib8n+uSC/iMOKu6T4Hd+8l7p4B2PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sv/sxOKTY4vGwtx/ksRdo71EBkKJsnfuwtn9EFZAAhU=;
 b=UCjeX1F9aw1TX8GjHrabosHCZ0V3mRlBohEhRkK5kf6y4VJwfXFvyhxxh2Jr1y9fq6O3S9ey4qw4KVF+ED94A+A7/oW+aEbBubZPNAsU4EbmA8i0sJI25EHGFJETJWXeLBQT3Y1VBUYqsvk+EHnmItKDHN9pzrA+962WvWPoLc0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by TYWPR01MB8447.jpnprd01.prod.outlook.com (2603:1096:400:174::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 13:14:11 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 13:14:11 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 19/23] hwmon: (lm75) simplify regulator handling
Date: Fri, 17 Jul 2026 15:12:37 +0200
Message-ID: <20260717131241.2233788-20-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260717131241.2233788-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260717131241.2233788-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0209.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::6) To TYRPR01MB13588.jpnprd01.prod.outlook.com
 (2603:1096:405:18d::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB13588:EE_|TYWPR01MB8447:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c6ae445-2285-45e2-5f6e-08dee4054ad4
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|52116014|38350700014|6133799003|10067099003|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	0UAe7pYDwKCyCOLHqy7C5UFtJiKPPAZS9hyRm2Lk2CjEFNzuxI7cLN+5wyTE+m/X9LQE8GGNx7dDVT+KqSd2XRkCtbGzm9DQ+i8cweIf72IIO0CMyL7gbLxVZc7odhkFIxKcSYiVpou8bUqN72wOF1W0JH6vjxQB51WxM4wO4l9olC9Qc1lvHLO3D6S4HdRNvsCN21YscXPg+8BWk2yw0zIEgGPNq7RzR7LfZKNBCrD9dT0SWyo+yUB6qtIw7D2PYRpSXnaHu1WeNPzZ8IyvjMWMA+uqRcfoN9aTUNxy7FT3MbjXTCw/UWPB1tkuMxLebbzDqTGPQInJpUEWlF0ZAcScMa6tK+RTjbz3mNF4CAchrzDaPG5WzkoqAmvheawdRGp4ckgploKKupBSgYs1KI/P+4k1cMRRi58v6saQtLJjWL8iqYWNEStt6men2YCQfpRH5wkh2V6T95BwF/FR2nph7+9wOcrhHAFIkP4a1Cpxp/XBnUuy5w7ppo8Iuwu9YMXulJNGocFGlkiZQ2vjFn+2iziL0Ds4RH9MKy6kQQ3R5za0Vkc4iPEiBO1HMH/Jgwhx5jY4N6Pt/Sp7bdlbNsM3AA9J7MHHKMe00YPTKz5DDKFyfHGzitXOlBXk4/XMmAsSQsgapS/jlP0b23TheuAA6U+Tq7e2ERTbeulvJ2vvbBmemOlkhfOIPIT6j11XVm3xnJ1ZV+wFVhpdQ3C8Q/PQkfX2eOzSV0twY6jHrnE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB13588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(52116014)(38350700014)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?TG4nznR2iGPZEqj/vcJvy5GLHCfmXel8dC9QjkDv+DB0dkaKN353BbQ+O1E4?=
 =?us-ascii?Q?P0cjkcO1TVPi5o2MlDMN2juT6r7uzIWL3XGpG9n2H3DDUalDXciq0tZGnX4g?=
 =?us-ascii?Q?bI5zj7Y4X//7N9976xgMFxFaruAxA7N/qvjdhN2U0Z57yuIhPSr42JFRDREH?=
 =?us-ascii?Q?jRZIucinIyqGi4lJ6b7Zbv8YC99w3DlCyUPMWwIcTxynGPipgy/9YnM2g83U?=
 =?us-ascii?Q?cEcVaI4x0qUnav7sYMLHMeIcXmHh7Y9dnjdoWBGjxiHvUV32j/cJ+I2X+zMB?=
 =?us-ascii?Q?CQBdBInz67BJCaON3NyTJ30ibJ/lwoHe2bobgn+5BbF6ZmN0MVggSYAjzUs0?=
 =?us-ascii?Q?OCvumEueTshybBiGTsJdbC/+tdD3E6ye8FW8mKx0T/1nKHWcV5Ni5ibrg8fv?=
 =?us-ascii?Q?7ciripFtfQJ4kMWItRikxPhMDSlm7s4DyEaDzN+ddVdy2Yl2Sx/ndyBulk30?=
 =?us-ascii?Q?Zl8sdTWENRwOnAeq3c/7QnzDXege17oKqQsCA3E9Z4Viuenm0CstnplVaQFm?=
 =?us-ascii?Q?xK+zEwLHKRkam8JWwVwt0Vj8jTwAgMsPZsRaMm5//bnVs5h9g8fb+P9c5zuc?=
 =?us-ascii?Q?C06dVtn41+jh14Pwvmm2T3xaiTawsnLwrWhsZGqTsAaek7Iix0xPZd2z7Qhm?=
 =?us-ascii?Q?G/rz6VqO2M55+ZpTMk7apit5c9tMJH1aF7TVUrO3qWCA1vc+UYsagEy2ElcG?=
 =?us-ascii?Q?fVfHBCGp+2XHi+oiFRpfTpTpO6wbvfbYxzVUTy7CdiXOLRzTojHM61U/KKnU?=
 =?us-ascii?Q?bfzIhXkb5cKpVMRstG95tC9Nj2Ui1gl1yPitW7XUd+WlSXkrtITrf9YJzrHG?=
 =?us-ascii?Q?cILoWxyAnZKipndiB06+CvCkk5oUJmorfmCdVvXKMgXfIHISq7h3zjpyDCcf?=
 =?us-ascii?Q?eBYFpwsLOHocOFmmtLgoqGVZYIHwbAGYb1yZv5JJU/7VQ/umuZMGT7PG+JRj?=
 =?us-ascii?Q?YmCj8+nCYg1QJOVDZXish34+jseLoyYAW7iN0OYju9tO8iSBDPf6SmNZHA1m?=
 =?us-ascii?Q?B8mt3B2L/nENnNA4bMyyAyUWpX61w6dHp/Bvs/34QKdAfrfyb6RJOtZEHJuN?=
 =?us-ascii?Q?qvwyBgHZXOPR8Om7NfP/gzNz/1mxLkJlBqMwU8e9TE608Sr/6dKQE/z9lc5f?=
 =?us-ascii?Q?2AwUqMqaj9rC7xrlAo3/060dUOai58ln+va+ausWPmHUXuzkFqpn7nmNka3R?=
 =?us-ascii?Q?xgfBEbZmHKXqDlCSwM8GXJno2fBDLCPdRwnvwKRaN6izv/cBNaPBbm4rOESQ?=
 =?us-ascii?Q?lPRN5AMjBuo1PNaeUUUwo8uPU+CPxHL3Ivc/JElb/ppcS1jGjbumptBs54MX?=
 =?us-ascii?Q?itfVs2HEVb7ufkcU8UPgZFuPy3jy61YYbM8rFrBPJROEYiysZ5RTfkDC1nhZ?=
 =?us-ascii?Q?GQdeY242tsuW5b4AqchwMxflQUNHSQOw2cBOHWO0WwBKe2zURaGWisgaijwB?=
 =?us-ascii?Q?JDGRJqmyIvIPtiAmtJ4wWnD6MBDiPAtSB/Ug/f2AfKmY0MGW7FZ2O75V7IrB?=
 =?us-ascii?Q?AuMSjW9SAjHkPDDfFkSbU9OUHuYouD9EUpn63kj1UgIRV/YtxapjfyYcAVOa?=
 =?us-ascii?Q?Ykvls0GE9cOUytl95mYTAOTrvRrcdFbsbMMwYOuLE/+qvbDc1+0ozTFt+ZyD?=
 =?us-ascii?Q?FzlDC8zBY+29H/h1Qw85fFNiD9JNQmOEHO37qQr+c6DZ+D7mh7jv4xv/plwL?=
 =?us-ascii?Q?pZkSVTw5qzKlpXfhcrZUPRi7qxIVzbZXBTblHXid5pdr9qrObter/GtRjoeH?=
 =?us-ascii?Q?5l7vYL4NkrQglbl4ayT93CfKuWj5L4rWw0E94wSzVfoLbq4kQjiH?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c6ae445-2285-45e2-5f6e-08dee4054ad4
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:14:11.7845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IiAFsc9iY31rW9kFf6u+OR2fNtXVtvbHTf+BfBjzqCRXNLDMRgiXHsLRFgVJPUk2lOhxJDjRk2yioKfBa467861z4IGFQ2mRoZ9A2gb4MOP0NwBbadCgUfmrGOF3xpuj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8447
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Jul 2026 13:14:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23647

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 2b64c6f652b0f5435b293d33f7d231132e987fb2 upstream.

devm_regulator_get_enable() was introduced exactly to avoid open coding
regulator handling like in this driver. Make use of this helper.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20241219225522.3490-9-wsa+renesas@sang-engi=
neering.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/hwmon/lm75.c | 25 +++----------------------
 1 file changed, 3 insertions(+), 22 deletions(-)

diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index 81fce8bdb929..0553e2e4520b 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -110,7 +110,6 @@ static const unsigned short normal_i2c[] =3D { 0x48, 0x=
49, 0x4a, 0x4b, 0x4c,
 struct lm75_data {
 	struct i2c_client		*client;
 	struct regmap			*regmap;
-	struct regulator		*vs;
 	u16				orig_conf;
 	u8				resolution;	/* In bits, 9 to 16 */
 	unsigned int			sample_time;	/* In ms */
@@ -622,13 +621,6 @@ static const struct regmap_bus lm75_i2c_regmap_bus =3D=
 {
 	.reg_write =3D lm75_i2c_reg_write,
 };
=20
-static void lm75_disable_regulator(void *data)
-{
-	struct lm75_data *lm75 =3D data;
-
-	regulator_disable(lm75->vs);
-}
-
 static void lm75_remove(void *data)
 {
 	struct lm75_data *lm75 =3D data;
@@ -657,9 +649,9 @@ static int lm75_probe(struct i2c_client *client)
 	data->client =3D client;
 	data->kind =3D (uintptr_t)i2c_get_match_data(client);
=20
-	data->vs =3D devm_regulator_get(dev, "vs");
-	if (IS_ERR(data->vs))
-		return PTR_ERR(data->vs);
+	err =3D devm_regulator_get_enable(dev, "vs");
+	if (err)
+		return err;
=20
 	data->regmap =3D devm_regmap_init(dev, &lm75_i2c_regmap_bus, data,
 					&lm75_regmap_config);
@@ -676,17 +668,6 @@ static int lm75_probe(struct i2c_client *client)
 	data->sample_time =3D data->params->default_sample_time;
 	data->resolution =3D data->params->default_resolution;
=20
-	/* Enable the power */
-	err =3D regulator_enable(data->vs);
-	if (err) {
-		dev_err(dev, "failed to enable regulator: %d\n", err);
-		return err;
-	}
-
-	err =3D devm_add_action_or_reset(dev, lm75_disable_regulator, data);
-	if (err)
-		return err;
-
 	/* Cache original configuration */
 	err =3D regmap_read(data->regmap, LM75_REG_CONF, &status);
 	if (err)
--=20
2.54.0


