Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C835EC83F17
	for <webhook@archiver.kernel.org>; Mon, 28 Jul 2025 13:48:07 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.62])
 by mx.groups.io with SMTP id smtpd.web11.81875.1753710481295114634
 for <cip-dev@lists.cip-project.org>;
 Mon, 28 Jul 2025 06:48:02 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=TcSH0Ayq;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.62, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rluP5MNGPDSapX44kDtJAJL6OxvYJUJFYOWJJRCBmrq+OrWs6KvMU8J0zfgONzpmJS7XkuHuxWWB6ftdxfvQgzY8cr6kd0jcBGHNvtNmRV2/jUCfNb7UEyi7k9CKlk8BFQu0Qraiq5Bf5MSfOGqKgmwYz5JYl4Oz6n0pmbD9RSwknIvQhqgJioypY6lqiJ/J/vtLAiujuwJ3LDGew5g/eD+BTF1Bjot/E955spLJk32Xhk500XA1gp46ZSmDPrK4psPEQKZzzVTRqREGpoDs+18KuXk65x4Qy228GR8GU2A2IKrVyslRpa++OZUOWpe6TzUyRuVYhV8Fc+mckAzazQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6TavbvZ9j8J+6Tn7KgiIG7XTePUPq/LMzV7L7kDOBIk=;
 b=LW7xyCPNnchQTkIgO+A0XEAeV6Jy7JuSdC5hhxd5fnRNH5COTceGznE83I8GcQSbs8h26Pw7G+z6uNokFtQzgIHpJl+bJtIF0VTMlGrOy1aRJEdIcTzX5lCOFyoeOY+oYG6BtiEtKlj5eccLmuRMCCH5JBukNNfWEiJ2Jk2g2cJthmR1Rceo+BLYYFfknCVkDAz++MWbsGM5GDAs982aJ6q22vduD8Yt8Qn40By+iOYwa1msAyqv/bV5j0VpU+iZEqZvJTs0Ylld8oNZgUEEG6wlAeapiq5q4vAB7hRmmBXEh9K7w131Bw05nPpVcdWKLTEwAVofMRwEERKqpyUNAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6TavbvZ9j8J+6Tn7KgiIG7XTePUPq/LMzV7L7kDOBIk=;
 b=TcSH0AyqCKHTq3GC0fKlgk1pn9zrw0/D05X812VXmMRoNwF0jCC2lmEwLq81bi78soXnZyWCU9rR+f7+3f8e9q3SagzxURHk4rMatWpbynaEYw3kaAdvhJ8FrkLsU49Iv13l/uosZgi3ehM2Gtk/EOq5avJHs5QF1Bbj5YFaIX8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS3PR01MB6657.jpnprd01.prod.outlook.com (2603:1096:604:10b::10)
 by TY4PR01MB14280.jpnprd01.prod.outlook.com (2603:1096:405:209::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 13:47:56 +0000
Received: from OS3PR01MB6657.jpnprd01.prod.outlook.com
 ([fe80::8575:e22a:3c44:76f0]) by OS3PR01MB6657.jpnprd01.prod.outlook.com
 ([fe80::8575:e22a:3c44:76f0%5]) with mapi id 15.20.8964.026; Mon, 28 Jul 2025
 13:47:56 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 1/2] arm64: dts: renesas: rzg3e-smarc-som: Add I2C2 device pincontrol
Date: Mon, 28 Jul 2025 15:47:30 +0200
Message-ID: <20250728134731.1287791-2-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250728134731.1287791-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250728134731.1287791-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MR1P264CA0017.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2e::22) To OS3PR01MB6657.jpnprd01.prod.outlook.com
 (2603:1096:604:10b::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PR01MB6657:EE_|TY4PR01MB14280:EE_
X-MS-Office365-Filtering-Correlation-Id: 85fd88ed-fc1b-4566-bb38-08ddcddd5bbe
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?IL4aFcGX/DZsD2NKvT5vgSIfqzP+W6G6SaADZhGhMvBrizKFHw2bcQ7yxUC3?=
 =?us-ascii?Q?tyhDMCf6qgVdgb9YPaBTSAIj0vdqJSloq8dkk+JAQhyJ28Ir1MoSCwXOsv+U?=
 =?us-ascii?Q?jdFchU7UalvSW9k1nsXhFLKaO0Xdm3MnJXPOLVpfva/8r5rwzA7+TkeuvU09?=
 =?us-ascii?Q?YgOodFFdNERdWf1mft98i5pA3LkfBl53UUkWyg+k9H59b/YYROLmFqL4kaZH?=
 =?us-ascii?Q?NtYrqf9OrJy5iKsKQRl1QNDJMhxiK7Dz5WRSIyHtsBOzKRFtlYtcDcDzHOsS?=
 =?us-ascii?Q?Gt58zYWcNQ3tcSTtsAsXj2DnZtkx819dIBBIyhfyxraU4SKsVMpl1XmKS6G6?=
 =?us-ascii?Q?QWqMeGjhGCv27LhMxuEJLj8pOTZtsma77eTiYOFMpTCmnA/Eblpt7G116OG5?=
 =?us-ascii?Q?1n5rOrKW3phiw4wkpf+6cpMX1Cdip5z21qok35Ln4TIZXjCMi+/t/GFBvry6?=
 =?us-ascii?Q?zsaGgnJWMVFyw0OhMZBTQ1C5An97R0rXbeHNH/xo1JEZuXURzCLN6/OhAi8v?=
 =?us-ascii?Q?TLYKQChBRfay7p4Grybu+owbzWf+jQY7gm7sBhDEqondXsUCzDmuHoZeB6z5?=
 =?us-ascii?Q?RHlVPci6s4nW8I94BfYgHi4p6+i2j1eerMx1yBT7qjPzZvyQu52PUCJb56u/?=
 =?us-ascii?Q?3rqYzEJeadxjqZ6V++a8sUXthrY1Ij3kBlnuWtULWj+OqHXYKqmQIjgoM8tF?=
 =?us-ascii?Q?jrijlpupvrDIDwiADXWtIdbgeQZQo8S+dQgocsI82OKDolBcIWURD9R5RiXG?=
 =?us-ascii?Q?T8OU24KcX1T3T6sHq/XXL+awNUeP7A0IF+GyPo4e8epiivLLKnjy/2vwIZqK?=
 =?us-ascii?Q?edgqMk0xfXjgcwYSEdLc8GxearCViiMuTjgWZ96x9iUqSI0Zxz9VNqbvmSpC?=
 =?us-ascii?Q?F+m70CJwgit9tTJRa8yWLlXperHl6hyQWaV21PfnZ7JS8TuUBT/Bm4BkdGWO?=
 =?us-ascii?Q?KALHDDCVirL7G3TyYJ8qzZ7RkBUj9JVNXCNtPuTb7TnRx7916JfMOhaPn0xq?=
 =?us-ascii?Q?RJjHbq4IcnRJSkriqIr2aNNIISVCwbLK4HPOey8Xy8vtw+z6OmTPqjld3bkA?=
 =?us-ascii?Q?wGb6HcYM/1JTgKZ+AbMXnxdBRGQPa190zd1+ZeTOLEyHuBRCjYf9AU6KH7Go?=
 =?us-ascii?Q?H94e8PFeeyC86eJDN7VDWLTBzeWW6cMuGNln9oB7xkHFr0LwD3hcH5QehWRJ?=
 =?us-ascii?Q?nRQtLQwMBSemELPGV3YrS/Hraf38x9wFkquzYa6alzWUKQ8EyAlKTblE0Fjy?=
 =?us-ascii?Q?kMsXrLRDIzV1bsoYQopTeOzZd/nDKwfNpdrhTj6JBnUudGBnvl+B0TXT1UwI?=
 =?us-ascii?Q?Q7r1pB7KZaWcQnCmiujs/3Iu5E7u6T/bgsQzST84MixeoTU2/ql+31fhESWx?=
 =?us-ascii?Q?vfHxPTGcX46gvNvO8sq0ShcbauvdinCju4j44GowtrmtqvpgVMFYdziwJLlX?=
 =?us-ascii?Q?nyHXUZpn/VUGxKmiRyICCvxGVZxE2HrhKyIcy1vmEbUzJebbZbyH4wlavJJ3?=
 =?us-ascii?Q?BLKDJEAUCdaj4gc=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6657.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?VbQu+C4/WRwkUR/MfFsRG3U7Ugn4z9C1FobbphY47m1WpRoBXuzbeERHSfRJ?=
 =?us-ascii?Q?mjgfcECZAMHSpYgLm5G49lF+V/ytqYHgKCe/ctLqetmkEqP0uIfo/AEDSVlR?=
 =?us-ascii?Q?H33e6RuUJk2yJk8xzD2xH/hNdBNPhNcMSnLE7YbDYFDpryHXVYl45Wo86Efe?=
 =?us-ascii?Q?3LwUDGcDvgGqDYFBevVZsgQ90KBAAErL3fkOwVYoO74fDaLObv4lZFLeZ6S6?=
 =?us-ascii?Q?lrYnI+DjUS3kH3M4jG3KayJGCC0E7N9WdnmyS9fnOn+XFUL7nw4/UG+XM1RA?=
 =?us-ascii?Q?eo8oXhLRADDZkqlR/5BAKbGbAF9z0WWHWLgIZUXwTrx15DxsBL54PbEdgXJT?=
 =?us-ascii?Q?IsXuqgwsrTNzJoR+Wutg+JA1hEeCQ4snJeaW/oE0+YyAGbkhSIc/0Vra09qr?=
 =?us-ascii?Q?KvSJ1kuSE26yvItvPjWOoX4Cf0FdOBrgDl/DdxNTrPGrv0bTCXdIAnrVH61T?=
 =?us-ascii?Q?VQ13mI3WGki6go5IEwy5feJ5mvzaXwvnOuw6xYdoZYTl9+NxRuIdTRPCQ+ys?=
 =?us-ascii?Q?HTW9wqwR2E/3V0+tgzp3FL/Q9msF5jKG7PFNqLqeHvdyEkJGVYkIPUtee1xi?=
 =?us-ascii?Q?BjqFev1D2/nrafqzrUFjI/6bdBO8zgSEd37AuBseIcjMtxXM2SbmKH6NQ/2O?=
 =?us-ascii?Q?U551xa4y/jYPFAWuSf3LMPNd8GXLe7Tdr/8Nk08zAx7fCf+8/Mpu9xnBbFXM?=
 =?us-ascii?Q?LwYUkpHLJzcAnJguUFX6t3Zpxw17OLwnJjCqW03sWbqo3HsDDIPukbEa9Ak9?=
 =?us-ascii?Q?t2ECzVgyi6Qw5zPhSIRE94c3LItnFDHO+RcqDBQJUEOctPTuBWjw4CBN/hNA?=
 =?us-ascii?Q?WTc9qELiUUnCuL1ANX7v2ubzMNPmhHc1pSlGTdsux59K5XPdfTh15k46c0V4?=
 =?us-ascii?Q?JOlMIs/etjZkik83KlLQ8nO5PKF/jlQLyBFM7rblLNvK8/xEv8h+F80f927T?=
 =?us-ascii?Q?oZ0uvKLbEfofJOoIpcUBvCBxDm0hLbsWk/ErTnpR2vcLJXyrkGSER4BmcU/4?=
 =?us-ascii?Q?mYYqi7hH8yq3Wo5tb2k6a8y66Fver09tDbXqxbyQtjsLf3WMvOtIayU0lFC2?=
 =?us-ascii?Q?4phZ93AWB+6CxzPhH84ta/ujP1GLIUL41zrNAPktLBRdpzrtsX3r3QyrzLaG?=
 =?us-ascii?Q?hlBwz/QGFWtDpB+rfSogFab2zhnVVORbrEdvcM4q4kO4Ybk/JdeRxlRPjOip?=
 =?us-ascii?Q?k6m+DqmrtHkp0oPgK+m9uuuOndOMVWu/Vr173NYJzJH2S+cc7/TRSTThbjvl?=
 =?us-ascii?Q?Xo8njARJc9zRPlzbSvohuE9xQ74GBVIvkIitnfrJXmmeqlVaM1ujMnySu29d?=
 =?us-ascii?Q?RsZSv5SVuvSGF+5S/dcdpw1rAhm+/bKCDBovZ5cY5pw1oMC4OAgzcBY9+M1p?=
 =?us-ascii?Q?s5+wP0NTqwGop2C5XrVIxWEdX8Ira4i0EPPmYmzzOTplqY5I2BcyF3CtfmL5?=
 =?us-ascii?Q?gwvf0F/I22EhQRBcartg/+Fhn6oZj8nAjvIPJeJk+OHUal60CUzhOI/jR/OP?=
 =?us-ascii?Q?FVajfyJ2SlF8Myeagve41D6eXULSTX/PRMND93J35OWU84g2ogZJ1IQrY3nh?=
 =?us-ascii?Q?GX7ArmBHnafs0d5SfMIzTfXcS8rt83ZIWXFlTETZ/kWJuTqbs0ZTYmvf/B7G?=
 =?us-ascii?Q?mmViH0tZOg7kc3ZOERG1iNo=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85fd88ed-fc1b-4566-bb38-08ddcddd5bbe
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6657.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 13:47:56.7932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8/dZz4kViEaQ/nBDjA//e3n0u6+mEyl2zrfxH+ltYVpxKmq02iG/0kHsbkYFxNTJpXF8d5JXML5nTmvboIjTI9j/A41KV4ptsrKSmatwS39PubWUd0BHD2EXeosKb/RZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14280
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Jul 2025 13:48:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19604

From: John Madieu <john.madieu.xa@bp.renesas.com>

commit f7a98e256ee30f50de1e7b43cc383828834e8c9e upstream.

Add a device node for I2C2 pincontrol.  Also enable the I2C2 device node
with 1MHz clock frequency as it is connected to the RAA215300 PMIC on
the RZ/G3E SoM.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250329121258.172099-2-john.madieu.xa@bp.ren=
esas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi b/arch/arm64/=
boot/dts/renesas/rzg3e-smarc-som.dtsi
index e9327cf9077f..d93c846ad391 100644
--- a/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
@@ -26,6 +26,7 @@ / {
 	compatible =3D "renesas,rzg3e-smarcm", "renesas,r9a09g047e57", "renesas,r=
9a09g047";
=20
 	aliases {
+		i2c2 =3D &i2c2;
 		mmc0 =3D &sdhi0;
 		mmc2 =3D &sdhi2;
 	};
@@ -74,7 +75,19 @@ &gpu {
 	mali-supply =3D <&reg_vdd0p8v_others>;
 };
=20
+&i2c2 {
+	pinctrl-0 =3D <&i2c2_pins>;
+	pinctrl-names =3D "default";
+	clock-frequency =3D <1000000>;
+	status =3D "okay";
+};
+
 &pinctrl {
+	i2c2_pins: i2c {
+		pinmux =3D <RZG3E_PORT_PINMUX(3, 4, 1)>, /* SCL2 */
+			 <RZG3E_PORT_PINMUX(3, 5, 1)>; /* SDA2 */
+	};
+
 	sdhi0_emmc_pins: sd0-emmc {
 		sd0-ctrl {
 			pins =3D "SD0CLK", "SD0CMD";
--=20
2.43.0


