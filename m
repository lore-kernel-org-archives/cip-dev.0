Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85740C3600B
	for <webhook@archiver.kernel.org>; Mon, 31 Mar 2025 10:46:51 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.39])
 by mx.groups.io with SMTP id smtpd.web11.48820.1743418002043064491
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Mar 2025 03:46:42 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=B5fdLuF3;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.39, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BlWurSobnMQwhtBzBbaFjjZg1TH4fyT3k+tSYevBWVlxU6s191L3KRDodJp7jdcs8m2pCxRzxrkvi4ZKO1SmcSZcYg/IwKVRljR0HQtWmySGBa8sltbsOzBMBfz5AlRLnfV4XDXSwb9JDQDECHtFR0t5Qvhq4O7pACCszNaWjmiUNBm5WdlqUSWksfxy/SEbmTOIDlmg5vTIxWmIcfy80Z29iWdwM4bSR/1E/xBsLtthzsHhfDAkJu3GK941lVAV+Ms4YB3wbRWf8g/4rbU4blq3PjDWcizzADBQ8JZka4q1d2k+Ac0fDvz2mNHS8em6TEhLcZU31gw2EgO72kN7bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1wFeuz0Reot2yb77dO3DLbcdDRRsjn09sjHtNQ7HJRI=;
 b=XbmL5o1S4yv/E1h+sd7rrsm/mBsDeADDaNaNoYmlIG4UYhGKzniObSocCfTSNDKrmc4zSm8ndODlRyb9YDv3zVVnH2DHT8pOdQOaNuVj52C7rudyDSdDFjaeJcIvRI5IxGZafrjeO+/JX1a86n6KkYTOGmL0SscZzqNvd7Vk2ggXScl+Ptwbd06rcxxFeJDpDf2eYrv1MJ1+eV+MpUn5qGVDGp6nDzA09XEjqyBr2cZUA6C96YUqEbzgqMlEz6m9x8+GA9cg1KXP0CI0GyzpcP+B8YvCm3yImmWkwTZmT8FmqoQBejH4diLu75h9Jfz+GXfe+CRSQeyw3UvfKngw2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1wFeuz0Reot2yb77dO3DLbcdDRRsjn09sjHtNQ7HJRI=;
 b=B5fdLuF3QLLtSnP4cEfKN/vFb0ucY0Pdt+Kj20cO2vHTslGImdthPopBcm+66LsoofyVxJkMceoSfES3+zRFm6CZywH8woLeJhpZ79WjdpGX+tDAYbXKzm1gfDYnO6YgzC3eq5gAU0q2GN133pTEAXIfuMSekHQmqFtkiuJ96kE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TY7PR01MB13744.jpnprd01.prod.outlook.com (2603:1096:405:1ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.33; Mon, 31 Mar
 2025 10:46:40 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.036; Mon, 31 Mar 2025
 10:46:40 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 23/43] pinctrl: renesas: rzg2l: Reorganize variable configuration macro
Date: Mon, 31 Mar 2025 12:44:54 +0200
Message-ID: <20250331104514.79090-24-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250331104514.79090-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250331104514.79090-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::13) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TY7PR01MB13744:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fec6275-e59b-4951-1eba-08dd7041517e
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Kv78ga8N44L+JVJpBhKUUts0gJn7pOnsGkTa3zesvZk8PMyHiD5Nh4PYO1RT?=
 =?us-ascii?Q?DyN6fFDaSKA2m5dIUekC50dDeu5y+LqGexQbC5BZRg3ViKFGer52VjfX6iP7?=
 =?us-ascii?Q?zg1iZ9EIXKcSw/NJa/O2a92Z9T9ycz+1IJg91EY/MVUefZ2MDWbaXWuoWKnP?=
 =?us-ascii?Q?fIOj2OXi6KciFYPWxREITkFl9Q228ZG8NB7y4orXphufJspaG6w65BeBP0Rj?=
 =?us-ascii?Q?uCjSg7KU+3nH4CtWOiqNWmciLJ6zjuditTk65oFvIiwCLP/uwzX3G6zHtBNz?=
 =?us-ascii?Q?OPloO5iY/iEn+OorjBA2SV/6XoNmfpQeduew8A+2pEoSnRanzugJmmUwcMLV?=
 =?us-ascii?Q?yirx1r1S4uxDCN1mBP9qMkhF6lz6P+uYmEnM9TpC5rgT/B3q9Smwh7POTS2V?=
 =?us-ascii?Q?w3X7J4lKYikVajRjnb/eiAD2ESoXy/UUfslQr9LVBx0ttgBltV2Nd9Jf1q9D?=
 =?us-ascii?Q?bQEj/AZAT/s1x2fmNx0SmMMhqpLH5+3P+cT/LrkjfLir5ZsqeJR2QkoZNml7?=
 =?us-ascii?Q?Gb12SRiOwtJS/pmME6gcFtp0X9g4vnEXDT+XzZL9j5ovqXt0VQT9d4qHBYnN?=
 =?us-ascii?Q?DxvFCnvVIcZMEm8zQwyGlXniaQtVnu/ISCtCcruvsRe3RAJN1Hl7n1sD2hKT?=
 =?us-ascii?Q?OeBP0lP0+rxa0QKpc4/V08MI6HPVeE+PEow9sExnaLjRo8GdoAw4lN2hpKvA?=
 =?us-ascii?Q?KzbhVui/9RuCiKJjFoxLbwcC0e5Jje+JlnbL1FCAX+MVhteNjpZVpbIQ36Ga?=
 =?us-ascii?Q?yqXxiBLtzHj8KoRs2h+wOAg/OcGQRiWsmKwCFMi/8QPh3hL6EzinR5WmZFOS?=
 =?us-ascii?Q?vb/HNcvE6kh1dkVpSae/arJcrNCRYzxgs+yquP2RSoPTbd1plGMPsouu5dfu?=
 =?us-ascii?Q?JDVCy6UdmN9kpSwibBGSqJfMKGK1zipYnfsbw5qNJopbdExclqm7xAmpzDCI?=
 =?us-ascii?Q?fdndICsaXT1X7Ql4O3KdFMu2/gzQV9dNELYuMP8GrXkVWnNVfjEytEPcLGRx?=
 =?us-ascii?Q?FTX52yP93oh/WmeQBkNGF2wcbj910vXOouHKz+JXmXKVp0HdI0SN0nwPUfvO?=
 =?us-ascii?Q?1kyEl8dhy+Rw+T662Ec3U4Wxoz8kY+zcKAyIHAopQaKeL1lui5FhEfEpinZf?=
 =?us-ascii?Q?TEsQu6g8mKpcTN5Ja4B2qdQJTvVeg/CxBEL6HCVoy28xEdei5MOydl+aXKlO?=
 =?us-ascii?Q?UODI3AV4i9hdFiRnj1ZZlowDJsHhY8qfXRYQuIfUcAp7P/UM+rwaH0/nnK8b?=
 =?us-ascii?Q?wUr1i9TnUD56Zpdg8gB4lhYUsU896RjdjNFGQ7mwlWcsi2WEXkM9hwBsIjFy?=
 =?us-ascii?Q?GYXHrSePuSOhj5qecIi4WJtpnteifd4TixQT6DTN5Eg/+GwptkrbuWsC3LE4?=
 =?us-ascii?Q?ZM8YFpV4eS6dW2V4grXhafC+/89/OrJJj2/ZcsGk2ufPV84fyiaWozJkZMWR?=
 =?us-ascii?Q?2PZK3odUX7nmXjBRrtBOX/Kujhj9S6aX?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?co+6gseKoFgjRCFMGjuhdNi1eH5ZRbdIGgn7C5s7VJk5p/O0j0j0xCjYIie+?=
 =?us-ascii?Q?PTVoKqN/blhBpSOsIlj6x4R9uJvq9U1fFyj16Du3CvOvSVeER70zwCiAATS5?=
 =?us-ascii?Q?vv8sebB/xHU1hnr5YSu36AdLzNICPQAunr7/UMrhnpxTrwHnscNYBDbz23AQ?=
 =?us-ascii?Q?Fbz9nnVHXOSYf6OYfit+wXGa3xCGX5ZPX/mpM693kG59wTZqy7hZLm5+fI1h?=
 =?us-ascii?Q?q2LetuqdudgrNUTw1l6imqQksNTe6KfMWqVhybS7GQJ8CnFPU048m+I6FftU?=
 =?us-ascii?Q?nMMpckCBHOSWbEFdrm+OFjQuBNdRRtAGN6zVW3eTUe6c2QnjpUZeNG4uYi33?=
 =?us-ascii?Q?wn8CtIZEZTyJimDX4njRLUmEFHoBYPbCWD8ckTM049hAOmwN+u7j/8Ewhxme?=
 =?us-ascii?Q?uQsMUeS0SEsynxav8o/ogzKEajcLx/sa2drL0tHdioEchGvRBi/kNbgHDoCY?=
 =?us-ascii?Q?YKKdwvttT6LUx9nv2n//K3JzxFeBUNnBw1eJwU6BfXi6ptJp9/QmSn8UMRbg?=
 =?us-ascii?Q?cFAWm8ODbwluYMRgHJJ2yKOx1C4uqzkdncptuGM9pmpXHLAai/cK1VzVNx3v?=
 =?us-ascii?Q?edlUejW9LSNRdsUi72tTCE8vf2R679h8DM4zSD2/7CbFTTMyiZEDjqINXd3C?=
 =?us-ascii?Q?VTMePMbeUA/VEaKToadL8W5sDiKDM/mb1n7dykekKxzU/Sk8dzehl8RlYzZ4?=
 =?us-ascii?Q?qICzTXmZifcpakPgMBRndkpgprpvEvfVTQvBNJzpMGLo6vD5dUoLqm/KYczo?=
 =?us-ascii?Q?k8Xui4SfAkgdwKh99G+za8g95hWyXUltj9szaTv0ZtPGWOV0n2LBN3/9g1oN?=
 =?us-ascii?Q?TGqKAeirq5gsQSvG+nJkLsco1bdGQ14B79MDyX2o2JUQvEl2CNFlNu86ilbi?=
 =?us-ascii?Q?MD/4z8aOie49g1WFukcqh+KspVYkWHDayOYc8LSw6B+hnOGoaeoJKh84p4xt?=
 =?us-ascii?Q?USJ1oPV76B+D4VdfuawYAntK43pRpvBzimncoBtpQi1DzqOhQmclC7FyaXLX?=
 =?us-ascii?Q?JB12KfoMi2Av6D18GQNvf5Ttx04UFI04diyfEwKal/beaF2y+iLdQZ5/e6m9?=
 =?us-ascii?Q?JATnN+1LpG0FJPFwXlST6VSyMROcJ05AqWe0Yz67B/kopAahmXe4C0+K7+qt?=
 =?us-ascii?Q?34Xnt+I8oj8vH5mmBgGBnU7BMEsLngF/mxMih3czWPZx+sRX/iRZlWPaRBIK?=
 =?us-ascii?Q?oCeAIZgwCnG8YcH6BevIZRQrRU4IGfyscY+kZ4jjmYME3ClR5N+moaL7koUH?=
 =?us-ascii?Q?pZnET+CapvARIws9Dt+HWzASKQSA17eK6epuHuYBK+z8Uphf4i7PQs44JEVM?=
 =?us-ascii?Q?ecJ1fgJrTLSggYYpY5rnWVnAsxcQLml5rHSyWOAaFnX0eIW2MAmnnVZA0SEU?=
 =?us-ascii?Q?eyTW+GLMcYeUtfddWFC9PnV2rsMYYgrByOGlopk4DvKn67jZEjxEAOrk20O+?=
 =?us-ascii?Q?iw59GnvGqq2aQDsaJxjE66ol8WDJNrGqDmmR/YTG2ts8FbTiCy1IqQ/+Dz8Z?=
 =?us-ascii?Q?2ns/wXESicLk4yLIgoXpy/g+KRdmSBLblgCE+FBErSfZI4PWjl7+vyfK9Qa4?=
 =?us-ascii?Q?w1oIklxXlMMJXvrn+X9RpG+o8n/TBf+GDiIjNfwYdHUnVyV4S8xL5tGD/npA?=
 =?us-ascii?Q?kALUy/qeThkmhXO0pITY/AQ=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fec6275-e59b-4951-1eba-08dd7041517e
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 10:46:40.2156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TYHvRDHwl1r0To4aQKGm3X2RdSoYl+3wyzDxDGutvvqUE3z7Z6zQ3yFWxNfUN5nWj9bU6Nk8CGdloNIVEjMBe5vMGrQUEVMBvXQZmEOhcbPoPHohaZyuuugnK3fiTXK/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13744
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Mar 2025 10:46:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18411

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 87d084bcbf1e8dbe97753e20d30fe9d56a97e6be upstream.

The `PIN_CFG_VARIABLE` macro did not indicate the capabilities of a pin
but served as a flag indicating that the pins of a port have different
capabilities.

To better reflect its purpose, move the `PIN_CFG_VARIABLE` macro beside
`RZG2L_SINGLE_PIN` and rename it to `RZG2L_VARIABLE_CFG`. Additionally,
introduce new macros for packing variable port configurations:
  - `RZG2L_GPIO_PORT_PACK_VARIABLE(n, a)`: Combines `RZG2L_VARIABLE_CFG`
    with `RZG2L_GPIO_PORT_PACK` to handle variable pin configurations
    for a packed port.
  - `RZG2L_GPIO_PORT_SPARSE_PACK_VARIABLE(m, a)`: Combines
    `RZG2L_VARIABLE_CFG` with `RZG2L_GPIO_PORT_SPARSE_PACK` to handle
    variable pin configurations for a sparse port.

Due to the above change the configuration macros have been reorganized
as follows:
- Shift the bit positions of `PIN_CFG_NOGPIO_INT`, `PIN_CFG_NOD`,
  `PIN_CFG_SMT`, `PIN_CFG_ELC`, and `PIN_CFG_IOLH_RZV2H` down by one
  to accommodate the removal of `PIN_CFG_VARIABLE`.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/r/20240618174831.415583-5-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 29 +++++++++++++++----------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index d38df51c7118b..7d76e0962e5c7 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -56,14 +56,14 @@
 #define PIN_CFG_IOLH_C			BIT(13)
 #define PIN_CFG_SOFT_PS			BIT(14)
 #define PIN_CFG_OEN			BIT(15)
-#define PIN_CFG_VARIABLE		BIT(16)
-#define PIN_CFG_NOGPIO_INT		BIT(17)
-#define PIN_CFG_NOD			BIT(18)	/* N-ch Open Drain */
-#define PIN_CFG_SMT			BIT(19)	/* Schmitt-trigger input control */
-#define PIN_CFG_ELC			BIT(20)
-#define PIN_CFG_IOLH_RZV2H		BIT(21)
+#define PIN_CFG_NOGPIO_INT		BIT(16)
+#define PIN_CFG_NOD			BIT(17)	/* N-ch Open Drain */
+#define PIN_CFG_SMT			BIT(18)	/* Schmitt-trigger input control */
+#define PIN_CFG_ELC			BIT(19)
+#define PIN_CFG_IOLH_RZV2H		BIT(20)
=20
 #define RZG2L_SINGLE_PIN		BIT_ULL(63)	/* Dedicated pin */
+#define RZG2L_VARIABLE_CFG		BIT_ULL(62)	/* Variable cfg for port pins */
=20
 #define RZG2L_MPXED_COMMON_PIN_FUNCS(group) \
 					(PIN_CFG_IOLH_##group | \
@@ -99,12 +99,17 @@
 #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)	(FIELD_PREP_CONST(PIN_CFG_PIN=
_MAP_MASK, (m)) | \
 						 FIELD_PREP_CONST(PIN_CFG_PIN_REG_MASK, (a)) | \
 						 FIELD_PREP_CONST(PIN_CFG_MASK, (f)))
+#define RZG2L_GPIO_PORT_SPARSE_PACK_VARIABLE(m, a)	\
+						(RZG2L_VARIABLE_CFG | \
+						 RZG2L_GPIO_PORT_SPARSE_PACK(m, a, 0))
=20
 /*
  * n indicates number of pins in the port, a is the register index
  * and f is pin configuration capabilities supported.
  */
 #define RZG2L_GPIO_PORT_PACK(n, a, f)	RZG2L_GPIO_PORT_SPARSE_PACK((1ULL <<=
 (n)) - 1, (a), (f))
+#define RZG2L_GPIO_PORT_PACK_VARIABLE(n, a)	(RZG2L_VARIABLE_CFG | \
+						 RZG2L_GPIO_PORT_PACK(n, a, 0))
=20
 #define RZG2L_SINGLE_PIN_INDEX_MASK	GENMASK_ULL(62, 56)
 #define RZG2L_SINGLE_PIN_BITS_MASK	GENMASK_ULL(55, 53)
@@ -370,7 +375,7 @@ static u64 rzg2l_pinctrl_get_variable_pin_cfg(struct rz=
g2l_pinctrl *pctrl,
=20
 		if (FIELD_GET(VARIABLE_PIN_CFG_PORT_MASK, cfg) =3D=3D port &&
 		    FIELD_GET(VARIABLE_PIN_CFG_PIN_MASK, cfg) =3D=3D pin)
-			return (pincfg & ~PIN_CFG_VARIABLE) | FIELD_GET(PIN_CFG_MASK, cfg);
+			return (pincfg & ~RZG2L_VARIABLE_CFG) | FIELD_GET(PIN_CFG_MASK, cfg);
 	}
=20
 	return 0;
@@ -1835,13 +1840,13 @@ static const u64 r9a07g043_gpio_configs[] =3D {
 	RZG2L_GPIO_PORT_SPARSE_PACK(0x2, 0x06, PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_=
CFG_PUPD |
 				    PIN_CFG_FILONOFF | PIN_CFG_FILNUM | PIN_CFG_FILCLKSEL |
 				    PIN_CFG_IEN | PIN_CFG_NOGPIO_INT),			/* P19 */
-	RZG2L_GPIO_PORT_PACK(8, 0x07, PIN_CFG_VARIABLE),				/* P20 */
+	RZG2L_GPIO_PORT_PACK_VARIABLE(8, 0x07),						/* P20 */
 	RZG2L_GPIO_PORT_SPARSE_PACK(0x2, 0x08, PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_=
CFG_PUPD |
 				    PIN_CFG_IEN | PIN_CFG_NOGPIO_INT),			/* P21 */
 	RZG2L_GPIO_PORT_PACK(4, 0x09, PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_PUPD =
|
 			     PIN_CFG_IEN | PIN_CFG_NOGPIO_INT),				/* P22 */
-	RZG2L_GPIO_PORT_SPARSE_PACK(0x3e, 0x0a, PIN_CFG_VARIABLE),			/* P23 */
-	RZG2L_GPIO_PORT_PACK(6, 0x0b, PIN_CFG_VARIABLE),				/* P24 */
+	RZG2L_GPIO_PORT_SPARSE_PACK_VARIABLE(0x3e, 0x0a),				/* P23 */
+	RZG2L_GPIO_PORT_PACK_VARIABLE(6, 0x0b),						/* P24 */
 	RZG2L_GPIO_PORT_SPARSE_PACK(0x2, 0x0c, PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_=
CFG_FILONOFF |
 				    PIN_CFG_FILNUM | PIN_CFG_FILCLKSEL |
 				    PIN_CFG_NOGPIO_INT),				/* P25 */
@@ -1913,7 +1918,7 @@ static const u64 r9a09g057_gpio_configs[] =3D {
 				      PIN_CFG_ELC),		/* P8 */
 	RZG2L_GPIO_PORT_PACK(8, 0x29, RZV2H_MPXED_PIN_FUNCS),	/* P9 */
 	RZG2L_GPIO_PORT_PACK(8, 0x2a, RZV2H_MPXED_PIN_FUNCS),	/* PA */
-	RZG2L_GPIO_PORT_PACK(6, 0x2b, PIN_CFG_VARIABLE),	/* PB */
+	RZG2L_GPIO_PORT_PACK_VARIABLE(6, 0x2b),			/* PB */
 };
=20
 static const struct {
@@ -2637,7 +2642,7 @@ static int rzg2l_pinctrl_register(struct rzg2l_pinctr=
l *pctrl)
 		if (i && !(i % RZG2L_PINS_PER_PORT))
 			j++;
 		pin_data[i] =3D pctrl->data->port_pin_configs[j];
-		if (pin_data[i] & PIN_CFG_VARIABLE)
+		if (pin_data[i] & RZG2L_VARIABLE_CFG)
 			pin_data[i] =3D rzg2l_pinctrl_get_variable_pin_cfg(pctrl,
 									 pin_data[i],
 									 j,
--=20
2.43.0


