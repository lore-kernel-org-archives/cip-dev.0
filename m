Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D62C83F03
	for <webhook@archiver.kernel.org>; Fri,  4 Jul 2025 09:07:56 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.39])
 by mx.groups.io with SMTP id smtpd.web11.8480.1751620072993928161
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Jul 2025 02:07:53 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=sHKxN+Hy;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.39, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TBxcLxQ3GPvVnuVgfJpmXGve8k/Mn03cdvjh5H6RmwYblGw3qDtRoPBLV2mbudXn1scdde1G3+Y+ieezGTxIRuoMz6QzCnB8P0KiMgNsSj6/a7Ni3Sgn2wsCHr7HXchACi142dEJ3iuqPBp8O/pX3wCJ2e7cH8jDd+3BB9NBKkdGQQXpl+8HxcEHpFdqCaw/h97/Pz7W7GoDrs1ip8O+xyB9IqL3ec1r/K4G2bGDSI4KLzdjVGL8nU1HSrR1mvm3smBO27DfbbX/p8LKYmTAbjWjjdM8m/5lTaCJ1Us/uUDQ0DV1TxUSove3BciNTeyiCh005DG7q8mlNkZDnS+B4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jKoY+/ks4Zm2JSXwOzhrb9Uiet0YNadr0yGqu6Et3AY=;
 b=JrpKmF9XMekobwXVjM3U5U4FmfBUfCEPS41gvuMZXmR1KbPWZNF3LHHTxh8KbZ/CPyaAr+TfWfIEdyajkln6SNp3c0Wu9g2i1qijZBNUSB2ePdhGLEBivg7RWgwnHX53PFglk9PJPyj2YGU/SYSdhYAsLJ7UuQY9PiTfCrqrZYFBrE4ilnhmXK8IY8yYjHcyv3dqIb7x03bDovLWEHjRGDaUQJzfyDFlm6JusX/IX5OEbzGJPZ1DaeDWzhONXJiV7Dku4YHjDgtFM2Lo3yVDNt/njBqMnt21OyI7r8g6HKOfaUePn/dBPpx2Qm8ymUIxiJfEh2U1uu6w5j20h5xIoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKoY+/ks4Zm2JSXwOzhrb9Uiet0YNadr0yGqu6Et3AY=;
 b=sHKxN+Hy0UhByi60tm7hRwyQS031Kcg5DtP17+CqZ4UyTxS2HFmhPwUQyincYrJeFv5skECTOKdmcMZ17JsIa50PfbiA3ATQKdcMXwnHsXtMlc9RqD8x57wuHDC8jgL73SEpSxd8iEum8qXjv6Ojdy+k5Zeuu3Omxn2oR3DX8tQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TY4PR01MB14451.jpnprd01.prod.outlook.com (2603:1096:405:23b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Fri, 4 Jul
 2025 09:07:49 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%7]) with mapi id 15.20.8880.027; Fri, 4 Jul 2025
 09:07:49 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 01/18] reset: replace boolean parameters with flags parameter
Date: Fri,  4 Jul 2025 11:07:07 +0200
Message-ID: <20250704090724.669848-2-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704090724.669848-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250704090724.669848-1-tommaso.merciai.xr@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MI2P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::13) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TY4PR01MB14451:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c759170-4cde-42bc-4642-08ddbada3fbb
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?IR+FSYz5XphWTVRMsz777zmkS/IMxVggE/sH3c/QX9qSt67eQkNgKXhRX7Kt?=
 =?us-ascii?Q?sXJtOOuPDn17DuBpm3TYmLWwA0aEIL8aHzJMuiQB/HglriTlTc1eaU+PTogr?=
 =?us-ascii?Q?e/0nqJ+VvpqbeQDl0YrAlir5yMR611vVqAT/53BQ0bLYXKyiTKqjUkonB6Zo?=
 =?us-ascii?Q?Qmdihu6ZrFGHlfQhA1XiWH5CAVe0XkwJbLDAvxaIraW+pQ0BEVMwriosbvBz?=
 =?us-ascii?Q?HQGvYCzP9ah3WI+1DEF32H7B2AScwSl7uvWAS+SizD5Ea4tK/PkWJPDLwR9H?=
 =?us-ascii?Q?hI+UjfTgv73Pnvw319zcrfBu+2sd6nEgOAXQBWWcpzVor0JDSrVcomzcSR55?=
 =?us-ascii?Q?LiMKkqWOPBEJMDkL+oi2QCPRJFGrHz6qUEI9NSpxwF9vpnK+0eKTq1Fwdx6j?=
 =?us-ascii?Q?TE+ggOlZWDWoSwWl+vywO4bjJs7NmWYA/KtY8zkzTrsfoT8ybBEBkORbfRn6?=
 =?us-ascii?Q?MZ8UyhJ5wEUiuvAH8GstxBjLSdyH/Rb18pbuNUCRVn0szq3yvyIWRgrs2g8m?=
 =?us-ascii?Q?VIkqIMUx6BT3rmj6HtRNu8xsh5eT/8X7JaqXEQGEwsWRarZ+a9WDryTUD1TB?=
 =?us-ascii?Q?+mVXnlCMt04dulcyKVp81nnPkLq6ecZt4AG/we7gmBcm8NYl874gJa/sbZPr?=
 =?us-ascii?Q?6roAB5iROet8lOFrDEXW8xssQgageszE5/2rDOjUnLJA6uCMq4tGYdJNM8fT?=
 =?us-ascii?Q?x8yLo7PV1X48BOJDiiKiLW87OKo0IQI7J/0lKobyLXfn22+HMU92M8swvT2d?=
 =?us-ascii?Q?hU8jd63dBlLSWoJo+iGBCM5vKoibaP2B3GSaEP38siLmmDSF8rrqr+eZQBtp?=
 =?us-ascii?Q?c1IpjSzTCd95YKImgSJTLkW0svMUMUtDs58xKJfFmAmGH9DjfvF4jD3zSqnQ?=
 =?us-ascii?Q?S9WIu63coAisnLQTYIlJN/wdJMR8948kia+snIOH0iAFYRX2Sl4x5WiXNXqc?=
 =?us-ascii?Q?j9bfQ+6gDOidBEHmZ8bPD4lrYa5j3QMIzASUTWjMvOpV2Rcu6rYnb5KQySth?=
 =?us-ascii?Q?LfBzYfv+kSGdcB6yNb6tWDh8vK+Ga8yrsA2tDj22xpUUH2FYdlCZpOxzrqYI?=
 =?us-ascii?Q?f+awFv5RiB3qLMenUzzCEmiQylxZdz2lji1u0gEqTmy3tpYiXJ5lKmW0Oc3L?=
 =?us-ascii?Q?jL5NoN+C9J4TGyPrQvLsbtruBfsRp6arKcezDZ7RjLK+KktxqFY1VvQO56vp?=
 =?us-ascii?Q?6PgOrq8b4sSOS5XWMZtrIMRVaMKZb7rPsjQ11EMJpRI8BTko+oHHQAmIWgK5?=
 =?us-ascii?Q?vG196b0/MX4if9alijcxMeM9vPtQ+CvRY9JL3u2EOxSKRcFVztHSidZ9FzJQ?=
 =?us-ascii?Q?TZxF1ue0LbCDX72GWtwWUwoXFBuSFLqVkr1FLguiX4quotfWyEEHGpAEKU5G?=
 =?us-ascii?Q?1TdadlCWOOrtUrWWrCVJjNZbqCeMaU4m2tvqbfrkuMPBAA5bhTW3/eRM5JbJ?=
 =?us-ascii?Q?Ox/EPQmXX4wGUngcYmb8MbLjKCtPQoTiXGNLy3ZG9F/DBhUermj8qeaNNl0u?=
 =?us-ascii?Q?K3C1A9WAC1lES+A=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?1haZTuwq0X/da+EwZrgWdyD8hMl6nnnMrA8O+YRTi7Vq8geg66pcNCwjEbKD?=
 =?us-ascii?Q?3rNzcIUmUCpKHlbbkiLe7Tj5vOVOPS8SbX3hpM00ZONqkO5T3dNJyOHDvp1n?=
 =?us-ascii?Q?mghR+nYQAt/5tTpXb2qlZgd1/88AJLZp3R1PSoWC+is/M7V5YaHSLj3PYd6i?=
 =?us-ascii?Q?fYEap1i7tOlREHCjPXJHpUiCqjkSnNRAN2P15W9LZqXR5t8xh6JEp5ZD88rH?=
 =?us-ascii?Q?OZndcQdX0BLgSaeQuUK8WplWW6wOd7AitA9e0wByNHjEsYJeafueYkOqIuwi?=
 =?us-ascii?Q?HmfL/ev+7Pwc8H49eR9GA3F93Itx9zxGA6URXiMGZYQrnloaMki+iRNj8Rtg?=
 =?us-ascii?Q?T1wJhW6eJoj/orHBYnuy8XeYFvh25sG84FLUHdZh3FxSLty6/vIPBdCSLHYj?=
 =?us-ascii?Q?BdmE6D4ni0y8z2P83xYmt1f0/+NseTgbtZ2LF8r0VeqJup8wHlZl7qHTsTgo?=
 =?us-ascii?Q?2oRf6GYciFM/BEgle2GVD/t5fil7clNAN/gRTKRlFo4n2fFWB3eYy8NWlOnJ?=
 =?us-ascii?Q?3TNT4Mf4J60fEKJuLvPsCFVfCLLZB6vLG4RWu+ucty5usiUPuuiM2YPHlo3c?=
 =?us-ascii?Q?T6eZLRItSkTTmHiyUeqGtR/Na25Z6S2R/cTVivykNoJx6RjeQ5L9fIIbaED1?=
 =?us-ascii?Q?QmVzE4rsEkaG3maA13FJBhHrJzjwKgkKjzJ+FBlnXGDI1/Qei+mtp3/IpYri?=
 =?us-ascii?Q?wqtRTWOvvDgnajwWW4g3eN7NggcjFRKegg0oFwWxBpI7ENYsuqEXPkS+NhIz?=
 =?us-ascii?Q?Y4fYv1w1xuQJP3jvW24naqfrGIjAUAozgmEgG3Yavd2YC4E7JnpNRda+zBPq?=
 =?us-ascii?Q?u2SYPtk7ttZ4uphrNR5ck3lngm6Shjf8OWDXY61ksQujFKgrhxc0Kha0W9cF?=
 =?us-ascii?Q?uaHVXdUBzom6i87UOYTOTBYM3UGQ3m75jdLpiCRuhztCPg7e2CijxFypVTFK?=
 =?us-ascii?Q?91KKLqVxUTWQgHQL7/MLOiWATLwjy2QViaLc/k6MTpTUKA9yTz+x8f3Yrto7?=
 =?us-ascii?Q?0L+b0OWLehQmRU0nyrHecr/llwpAptRnhiMY17g3mtstd0hPur77Bn7UVSdK?=
 =?us-ascii?Q?+T1FBgdAOll3a3dt9MHDJjv07wEthrynVyGsx+UAzB5S2m5Nc2lSjjm6ifpF?=
 =?us-ascii?Q?tdkzSyqXIjo9yrPcgdxBCHHfQe4LqslB2MWoXRWfNruR3Hqngbmzt0CNv+bt?=
 =?us-ascii?Q?tnXmRE2ZPrL1UEKeczJJqgy3vTFwBZ+UGhaslLkuvjQHRpGOOa3S8RqC/8tf?=
 =?us-ascii?Q?jh6KNnFguw42MhEWoauTl2YC2E1Fn81ZOv4oZnZpG9yqOnGyWUV9D6C0l9kQ?=
 =?us-ascii?Q?FjVrfAgk5TzxZFcmwoescO14E3buXJJbm6areYyYLeVMrRrcJGpvW/upYsVd?=
 =?us-ascii?Q?9l23FPQuXkmTlQbRYf6HEA+/XyKVRWlR4fVpFp/gsoUK1bTpZLyy1Ryal0/H?=
 =?us-ascii?Q?bZFbFr6BG1DtPlx3n6Apad/dO1C4kQUdr+nsiGejI8M7rS+6r9xbgmt8fsKV?=
 =?us-ascii?Q?MxS2YERE2/NWeJNAMzYsvUaciBiPK2LNkbg97Md1o68W1wcV1GACHa/ZVEQ7?=
 =?us-ascii?Q?D2fxE6GT5OMTJUlTnr4qXP1ENnc27vDlZOfhMGP6CH1ec19wV7EEmgcGmtnf?=
 =?us-ascii?Q?g4ikQV4ZY6A8xgo6SBhMsps=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c759170-4cde-42bc-4642-08ddbada3fbb
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 09:07:49.4693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WJ8T06HmjEBhLXOHnl5dApiUh8OfF/D2qEHdKj9/8Li1P+cBqn5VOCcyzVp57FrJMvIdjLST8KnyEtktUdlKs1lHWZ8EvOKghlhZVgOkElVNTpQSSSujySRkPzUEQHix
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14451
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Jul 2025 09:07:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19345

From: Philipp Zabel <p.zabel@pengutronix.de>

commit dad35f7d2fc14e446669d4cab100597a6798eae5 upstream.

Introduce enum reset_control_flags and replace the list of boolean
parameters to the internal reset_control_get functions with a single
flags parameter, before adding more boolean options.

The separate boolean parameters have been shown to be error prone in
the past. See for example commit a57f68ddc886 ("reset: Fix devm bulk
optional exclusive control getter").

Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
Link: https://lore.kernel.org/r/20240925-reset-get-deasserted-v2-1-b3601bbd=
0458@pengutronix.de
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/reset/core.c  |  71 +++++++++++--------
 include/linux/reset.h | 161 ++++++++++++++++++++++++++----------------
 2 files changed, 139 insertions(+), 93 deletions(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 4d509d41456a..682d61812852 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -773,12 +773,19 @@ EXPORT_SYMBOL_GPL(reset_control_bulk_release);
=20
 static struct reset_control *
 __reset_control_get_internal(struct reset_controller_dev *rcdev,
-			     unsigned int index, bool shared, bool acquired)
+			     unsigned int index, enum reset_control_flags flags)
 {
+	bool shared =3D flags & RESET_CONTROL_FLAGS_BIT_SHARED;
+	bool acquired =3D flags & RESET_CONTROL_FLAGS_BIT_ACQUIRED;
 	struct reset_control *rstc;
=20
 	lockdep_assert_held(&reset_list_mutex);
=20
+	/* Expect callers to filter out OPTIONAL and DEASSERTED bits */
+	if (WARN_ON(flags & ~(RESET_CONTROL_FLAGS_BIT_SHARED |
+			      RESET_CONTROL_FLAGS_BIT_ACQUIRED)))
+		return ERR_PTR(-EINVAL);
+
 	list_for_each_entry(rstc, &rcdev->reset_control_head, list) {
 		if (rstc->id =3D=3D index) {
 			/*
@@ -994,8 +1001,9 @@ static struct reset_controller_dev *__reset_find_rcdev=
(const struct of_phandle_a
=20
 struct reset_control *
 __of_reset_control_get(struct device_node *node, const char *id, int index=
,
-		       bool shared, bool optional, bool acquired)
+		       enum reset_control_flags flags)
 {
+	bool optional =3D flags & RESET_CONTROL_FLAGS_BIT_OPTIONAL;
 	bool gpio_fallback =3D false;
 	struct reset_control *rstc;
 	struct reset_controller_dev *rcdev;
@@ -1059,8 +1067,10 @@ __of_reset_control_get(struct device_node *node, con=
st char *id, int index,
 		goto out_unlock;
 	}
=20
+	flags &=3D ~RESET_CONTROL_FLAGS_BIT_OPTIONAL;
+
 	/* reset_list_mutex also protects the rcdev's reset_control list */
-	rstc =3D __reset_control_get_internal(rcdev, rstc_id, shared, acquired);
+	rstc =3D __reset_control_get_internal(rcdev, rstc_id, flags);
=20
 out_unlock:
 	mutex_unlock(&reset_list_mutex);
@@ -1091,8 +1101,9 @@ __reset_controller_by_name(const char *name)
=20
 static struct reset_control *
 __reset_control_get_from_lookup(struct device *dev, const char *con_id,
-				bool shared, bool optional, bool acquired)
+				enum reset_control_flags flags)
 {
+	bool optional =3D flags & RESET_CONTROL_FLAGS_BIT_OPTIONAL;
 	const struct reset_control_lookup *lookup;
 	struct reset_controller_dev *rcdev;
 	const char *dev_id =3D dev_name(dev);
@@ -1116,9 +1127,11 @@ __reset_control_get_from_lookup(struct device *dev, =
const char *con_id,
 				return ERR_PTR(-EPROBE_DEFER);
 			}
=20
+			flags &=3D ~RESET_CONTROL_FLAGS_BIT_OPTIONAL;
+
 			rstc =3D __reset_control_get_internal(rcdev,
 							    lookup->index,
-							    shared, acquired);
+							    flags);
 			mutex_unlock(&reset_list_mutex);
 			break;
 		}
@@ -1133,30 +1146,29 @@ __reset_control_get_from_lookup(struct device *dev,=
 const char *con_id,
 }
=20
 struct reset_control *__reset_control_get(struct device *dev, const char *=
id,
-					  int index, bool shared, bool optional,
-					  bool acquired)
+					  int index, enum reset_control_flags flags)
 {
+	bool shared =3D flags & RESET_CONTROL_FLAGS_BIT_SHARED;
+	bool acquired =3D flags & RESET_CONTROL_FLAGS_BIT_ACQUIRED;
+
 	if (WARN_ON(shared && acquired))
 		return ERR_PTR(-EINVAL);
=20
 	if (dev->of_node)
-		return __of_reset_control_get(dev->of_node, id, index, shared,
-					      optional, acquired);
+		return __of_reset_control_get(dev->of_node, id, index, flags);
=20
-	return __reset_control_get_from_lookup(dev, id, shared, optional,
-					       acquired);
+	return __reset_control_get_from_lookup(dev, id, flags);
 }
 EXPORT_SYMBOL_GPL(__reset_control_get);
=20
 int __reset_control_bulk_get(struct device *dev, int num_rstcs,
 			     struct reset_control_bulk_data *rstcs,
-			     bool shared, bool optional, bool acquired)
+			     enum reset_control_flags flags)
 {
 	int ret, i;
=20
 	for (i =3D 0; i < num_rstcs; i++) {
-		rstcs[i].rstc =3D __reset_control_get(dev, rstcs[i].id, 0,
-						    shared, optional, acquired);
+		rstcs[i].rstc =3D __reset_control_get(dev, rstcs[i].id, 0, flags);
 		if (IS_ERR(rstcs[i].rstc)) {
 			ret =3D PTR_ERR(rstcs[i].rstc);
 			goto err;
@@ -1226,7 +1238,7 @@ static void devm_reset_control_release(struct device =
*dev, void *res)
=20
 struct reset_control *
 __devm_reset_control_get(struct device *dev, const char *id, int index,
-			 bool shared, bool optional, bool acquired)
+			 enum reset_control_flags flags)
 {
 	struct reset_control **ptr, *rstc;
=20
@@ -1235,7 +1247,7 @@ __devm_reset_control_get(struct device *dev, const ch=
ar *id, int index,
 	if (!ptr)
 		return ERR_PTR(-ENOMEM);
=20
-	rstc =3D __reset_control_get(dev, id, index, shared, optional, acquired);
+	rstc =3D __reset_control_get(dev, id, index, flags);
 	if (IS_ERR_OR_NULL(rstc)) {
 		devres_free(ptr);
 		return rstc;
@@ -1262,7 +1274,7 @@ static void devm_reset_control_bulk_release(struct de=
vice *dev, void *res)
=20
 int __devm_reset_control_bulk_get(struct device *dev, int num_rstcs,
 				  struct reset_control_bulk_data *rstcs,
-				  bool shared, bool optional, bool acquired)
+				  enum reset_control_flags flags)
 {
 	struct reset_control_bulk_devres *ptr;
 	int ret;
@@ -1272,7 +1284,7 @@ int __devm_reset_control_bulk_get(struct device *dev,=
 int num_rstcs,
 	if (!ptr)
 		return -ENOMEM;
=20
-	ret =3D __reset_control_bulk_get(dev, num_rstcs, rstcs, shared, optional,=
 acquired);
+	ret =3D __reset_control_bulk_get(dev, num_rstcs, rstcs, flags);
 	if (ret < 0) {
 		devres_free(ptr);
 		return ret;
@@ -1298,6 +1310,7 @@ EXPORT_SYMBOL_GPL(__devm_reset_control_bulk_get);
  */
 int __device_reset(struct device *dev, bool optional)
 {
+	enum reset_control_flags flags;
 	struct reset_control *rstc;
 	int ret;
=20
@@ -1313,7 +1326,8 @@ int __device_reset(struct device *dev, bool optional)
 	}
 #endif
=20
-	rstc =3D __reset_control_get(dev, NULL, 0, 0, optional, true);
+	flags =3D optional ? RESET_CONTROL_OPTIONAL_EXCLUSIVE : RESET_CONTROL_EXC=
LUSIVE;
+	rstc =3D __reset_control_get(dev, NULL, 0, flags);
 	if (IS_ERR(rstc))
 		return PTR_ERR(rstc);
=20
@@ -1356,17 +1370,14 @@ static int of_reset_control_get_count(struct device=
_node *node)
  *				device node.
  *
  * @np: device node for the device that requests the reset controls array
- * @shared: whether reset controls are shared or not
- * @optional: whether it is optional to get the reset controls
- * @acquired: only one reset control may be acquired for a given controlle=
r
- *            and ID
+ * @flags: whether reset controls are shared, optional, acquired
  *
  * Returns pointer to allocated reset_control on success or error on failu=
re
  */
 struct reset_control *
-of_reset_control_array_get(struct device_node *np, bool shared, bool optio=
nal,
-			   bool acquired)
+of_reset_control_array_get(struct device_node *np, enum reset_control_flag=
s flags)
 {
+	bool optional =3D flags & RESET_CONTROL_FLAGS_BIT_OPTIONAL;
 	struct reset_control_array *resets;
 	struct reset_control *rstc;
 	int num, i;
@@ -1381,8 +1392,7 @@ of_reset_control_array_get(struct device_node *np, bo=
ol shared, bool optional,
 	resets->num_rstcs =3D num;
=20
 	for (i =3D 0; i < num; i++) {
-		rstc =3D __of_reset_control_get(np, NULL, i, shared, optional,
-					      acquired);
+		rstc =3D __of_reset_control_get(np, NULL, i, flags);
 		if (IS_ERR(rstc))
 			goto err_rst;
 		resets->rstc[i] =3D rstc;
@@ -1407,8 +1417,7 @@ EXPORT_SYMBOL_GPL(of_reset_control_array_get);
  * devm_reset_control_array_get - Resource managed reset control array get
  *
  * @dev: device that requests the list of reset controls
- * @shared: whether reset controls are shared or not
- * @optional: whether it is optional to get the reset controls
+ * @flags: whether reset controls are shared, optional, acquired
  *
  * The reset control array APIs are intended for a list of resets
  * that just have to be asserted or deasserted, without any
@@ -1417,7 +1426,7 @@ EXPORT_SYMBOL_GPL(of_reset_control_array_get);
  * Returns pointer to allocated reset_control on success or error on failu=
re
  */
 struct reset_control *
-devm_reset_control_array_get(struct device *dev, bool shared, bool optiona=
l)
+devm_reset_control_array_get(struct device *dev, enum reset_control_flags =
flags)
 {
 	struct reset_control **ptr, *rstc;
=20
@@ -1426,7 +1435,7 @@ devm_reset_control_array_get(struct device *dev, bool=
 shared, bool optional)
 	if (!ptr)
 		return ERR_PTR(-ENOMEM);
=20
-	rstc =3D of_reset_control_array_get(dev->of_node, shared, optional, true)=
;
+	rstc =3D of_reset_control_array_get(dev->of_node, flags);
 	if (IS_ERR_OR_NULL(rstc)) {
 		devres_free(ptr);
 		return rstc;
diff --git a/include/linux/reset.h b/include/linux/reset.h
index 514ddf003efc..99296af98f81 100644
--- a/include/linux/reset.h
+++ b/include/linux/reset.h
@@ -25,6 +25,33 @@ struct reset_control_bulk_data {
 	struct reset_control		*rstc;
 };
=20
+#define RESET_CONTROL_FLAGS_BIT_SHARED		BIT(0)	/* not exclusive */
+#define RESET_CONTROL_FLAGS_BIT_OPTIONAL	BIT(1)
+#define RESET_CONTROL_FLAGS_BIT_ACQUIRED	BIT(2)	/* iff exclusive, not rele=
ased */
+
+/**
+ * enum reset_control_flags - Flags that can be passed to the reset_contro=
l_get functions
+ *                    to determine the type of reset control.
+ *                    These values cannot be OR'd.
+ *
+ * @RESET_CONTROL_EXCLUSIVE:				exclusive, acquired,
+ * @RESET_CONTROL_EXCLUSIVE_RELEASED:			exclusive, released,
+ * @RESET_CONTROL_SHARED:				shared
+ * @RESET_CONTROL_OPTIONAL_EXCLUSIVE:			optional, exclusive, acquired
+ * @RESET_CONTROL_OPTIONAL_EXCLUSIVE_RELEASED:		optional, exclusive, relea=
sed
+ * @RESET_CONTROL_OPTIONAL_SHARED:			optional, shared
+ */
+enum reset_control_flags {
+	RESET_CONTROL_EXCLUSIVE				=3D RESET_CONTROL_FLAGS_BIT_ACQUIRED,
+	RESET_CONTROL_EXCLUSIVE_RELEASED		=3D 0,
+	RESET_CONTROL_SHARED				=3D RESET_CONTROL_FLAGS_BIT_SHARED,
+	RESET_CONTROL_OPTIONAL_EXCLUSIVE		=3D RESET_CONTROL_FLAGS_BIT_OPTIONAL |
+							  RESET_CONTROL_FLAGS_BIT_ACQUIRED,
+	RESET_CONTROL_OPTIONAL_EXCLUSIVE_RELEASED	=3D RESET_CONTROL_FLAGS_BIT_OPT=
IONAL,
+	RESET_CONTROL_OPTIONAL_SHARED			=3D RESET_CONTROL_FLAGS_BIT_OPTIONAL |
+							  RESET_CONTROL_FLAGS_BIT_SHARED,
+};
+
 #ifdef CONFIG_RESET_CONTROLLER
=20
 int reset_control_reset(struct reset_control *rstc);
@@ -42,30 +69,25 @@ int reset_control_bulk_acquire(int num_rstcs, struct re=
set_control_bulk_data *rs
 void reset_control_bulk_release(int num_rstcs, struct reset_control_bulk_d=
ata *rstcs);
=20
 struct reset_control *__of_reset_control_get(struct device_node *node,
-				     const char *id, int index, bool shared,
-				     bool optional, bool acquired);
+				     const char *id, int index, enum reset_control_flags flags);
 struct reset_control *__reset_control_get(struct device *dev, const char *=
id,
-					  int index, bool shared,
-					  bool optional, bool acquired);
+					  int index, enum reset_control_flags flags);
 void reset_control_put(struct reset_control *rstc);
 int __reset_control_bulk_get(struct device *dev, int num_rstcs,
 			     struct reset_control_bulk_data *rstcs,
-			     bool shared, bool optional, bool acquired);
+			     enum reset_control_flags flags);
 void reset_control_bulk_put(int num_rstcs, struct reset_control_bulk_data =
*rstcs);
=20
 int __device_reset(struct device *dev, bool optional);
 struct reset_control *__devm_reset_control_get(struct device *dev,
-				     const char *id, int index, bool shared,
-				     bool optional, bool acquired);
+				     const char *id, int index, enum reset_control_flags flags);
 int __devm_reset_control_bulk_get(struct device *dev, int num_rstcs,
 				  struct reset_control_bulk_data *rstcs,
-				  bool shared, bool optional, bool acquired);
+				  enum reset_control_flags flags);
=20
 struct reset_control *devm_reset_control_array_get(struct device *dev,
-						   bool shared, bool optional);
-struct reset_control *of_reset_control_array_get(struct device_node *np,
-						 bool shared, bool optional,
-						 bool acquired);
+						   enum reset_control_flags flags);
+struct reset_control *of_reset_control_array_get(struct device_node *np, e=
num reset_control_flags);
=20
 int reset_control_get_count(struct device *dev);
=20
@@ -116,17 +138,19 @@ static inline int __device_reset(struct device *dev, =
bool optional)
=20
 static inline struct reset_control *__of_reset_control_get(
 					struct device_node *node,
-					const char *id, int index, bool shared,
-					bool optional, bool acquired)
+					const char *id, int index, enum reset_control_flags flags)
 {
+	bool optional =3D flags & RESET_CONTROL_FLAGS_BIT_OPTIONAL;
+
 	return optional ? NULL : ERR_PTR(-ENOTSUPP);
 }
=20
 static inline struct reset_control *__reset_control_get(
 					struct device *dev, const char *id,
-					int index, bool shared, bool optional,
-					bool acquired)
+					int index, enum reset_control_flags flags)
 {
+	bool optional =3D flags & RESET_CONTROL_FLAGS_BIT_OPTIONAL;
+
 	return optional ? NULL : ERR_PTR(-ENOTSUPP);
 }
=20
@@ -162,8 +186,10 @@ reset_control_bulk_release(int num_rstcs, struct reset=
_control_bulk_data *rstcs)
 static inline int
 __reset_control_bulk_get(struct device *dev, int num_rstcs,
 			 struct reset_control_bulk_data *rstcs,
-			 bool shared, bool optional, bool acquired)
+			 enum reset_control_flags flags)
 {
+	bool optional =3D flags & RESET_CONTROL_FLAGS_BIT_OPTIONAL;
+
 	return optional ? 0 : -EOPNOTSUPP;
 }
=20
@@ -174,30 +200,36 @@ reset_control_bulk_put(int num_rstcs, struct reset_co=
ntrol_bulk_data *rstcs)
=20
 static inline struct reset_control *__devm_reset_control_get(
 					struct device *dev, const char *id,
-					int index, bool shared, bool optional,
-					bool acquired)
+					int index, enum reset_control_flags flags)
 {
+	bool optional =3D flags & RESET_CONTROL_FLAGS_BIT_OPTIONAL;
+
 	return optional ? NULL : ERR_PTR(-ENOTSUPP);
 }
=20
 static inline int
 __devm_reset_control_bulk_get(struct device *dev, int num_rstcs,
 			      struct reset_control_bulk_data *rstcs,
-			      bool shared, bool optional, bool acquired)
+			      enum reset_control_flags flags)
 {
+	bool optional =3D flags & RESET_CONTROL_FLAGS_BIT_OPTIONAL;
+
 	return optional ? 0 : -EOPNOTSUPP;
 }
=20
 static inline struct reset_control *
-devm_reset_control_array_get(struct device *dev, bool shared, bool optiona=
l)
+devm_reset_control_array_get(struct device *dev, enum reset_control_flags =
flags)
 {
+	bool optional =3D flags & RESET_CONTROL_FLAGS_BIT_OPTIONAL;
+
 	return optional ? NULL : ERR_PTR(-ENOTSUPP);
 }
=20
 static inline struct reset_control *
-of_reset_control_array_get(struct device_node *np, bool shared, bool optio=
nal,
-			   bool acquired)
+of_reset_control_array_get(struct device_node *np, enum reset_control_flag=
s flags)
 {
+	bool optional =3D flags & RESET_CONTROL_FLAGS_BIT_OPTIONAL;
+
 	return optional ? NULL : ERR_PTR(-ENOTSUPP);
 }
=20
@@ -236,7 +268,7 @@ static inline int device_reset_optional(struct device *=
dev)
 static inline struct reset_control *
 __must_check reset_control_get_exclusive(struct device *dev, const char *i=
d)
 {
-	return __reset_control_get(dev, id, 0, false, false, true);
+	return __reset_control_get(dev, id, 0, RESET_CONTROL_EXCLUSIVE);
 }
=20
 /**
@@ -253,7 +285,7 @@ static inline int __must_check
 reset_control_bulk_get_exclusive(struct device *dev, int num_rstcs,
 				 struct reset_control_bulk_data *rstcs)
 {
-	return __reset_control_bulk_get(dev, num_rstcs, rstcs, false, false, true=
);
+	return __reset_control_bulk_get(dev, num_rstcs, rstcs, RESET_CONTROL_EXCL=
USIVE);
 }
=20
 /**
@@ -274,7 +306,7 @@ static inline struct reset_control *
 __must_check reset_control_get_exclusive_released(struct device *dev,
 						  const char *id)
 {
-	return __reset_control_get(dev, id, 0, false, false, false);
+	return __reset_control_get(dev, id, 0, RESET_CONTROL_EXCLUSIVE_RELEASED);
 }
=20
 /**
@@ -295,7 +327,7 @@ static inline int __must_check
 reset_control_bulk_get_exclusive_released(struct device *dev, int num_rstc=
s,
 					  struct reset_control_bulk_data *rstcs)
 {
-	return __reset_control_bulk_get(dev, num_rstcs, rstcs, false, false, fals=
e);
+	return __reset_control_bulk_get(dev, num_rstcs, rstcs, RESET_CONTROL_EXCL=
USIVE_RELEASED);
 }
=20
 /**
@@ -316,7 +348,8 @@ static inline int __must_check
 reset_control_bulk_get_optional_exclusive_released(struct device *dev, int=
 num_rstcs,
 						   struct reset_control_bulk_data *rstcs)
 {
-	return __reset_control_bulk_get(dev, num_rstcs, rstcs, false, true, false=
);
+	return __reset_control_bulk_get(dev, num_rstcs, rstcs,
+					RESET_CONTROL_OPTIONAL_EXCLUSIVE_RELEASED);
 }
=20
 /**
@@ -344,7 +377,7 @@ reset_control_bulk_get_optional_exclusive_released(stru=
ct device *dev, int num_r
 static inline struct reset_control *reset_control_get_shared(
 					struct device *dev, const char *id)
 {
-	return __reset_control_get(dev, id, 0, true, false, false);
+	return __reset_control_get(dev, id, 0, RESET_CONTROL_SHARED);
 }
=20
 /**
@@ -361,7 +394,7 @@ static inline int __must_check
 reset_control_bulk_get_shared(struct device *dev, int num_rstcs,
 			      struct reset_control_bulk_data *rstcs)
 {
-	return __reset_control_bulk_get(dev, num_rstcs, rstcs, true, false, false=
);
+	return __reset_control_bulk_get(dev, num_rstcs, rstcs, RESET_CONTROL_SHAR=
ED);
 }
=20
 /**
@@ -378,7 +411,7 @@ reset_control_bulk_get_shared(struct device *dev, int n=
um_rstcs,
 static inline struct reset_control *reset_control_get_optional_exclusive(
 					struct device *dev, const char *id)
 {
-	return __reset_control_get(dev, id, 0, false, true, true);
+	return __reset_control_get(dev, id, 0, RESET_CONTROL_OPTIONAL_EXCLUSIVE);
 }
=20
 /**
@@ -398,7 +431,7 @@ static inline int __must_check
 reset_control_bulk_get_optional_exclusive(struct device *dev, int num_rstc=
s,
 					  struct reset_control_bulk_data *rstcs)
 {
-	return __reset_control_bulk_get(dev, num_rstcs, rstcs, false, true, true)=
;
+	return __reset_control_bulk_get(dev, num_rstcs, rstcs, RESET_CONTROL_OPTI=
ONAL_EXCLUSIVE);
 }
=20
 /**
@@ -415,7 +448,7 @@ reset_control_bulk_get_optional_exclusive(struct device=
 *dev, int num_rstcs,
 static inline struct reset_control *reset_control_get_optional_shared(
 					struct device *dev, const char *id)
 {
-	return __reset_control_get(dev, id, 0, true, true, false);
+	return __reset_control_get(dev, id, 0, RESET_CONTROL_OPTIONAL_SHARED);
 }
=20
 /**
@@ -435,7 +468,7 @@ static inline int __must_check
 reset_control_bulk_get_optional_shared(struct device *dev, int num_rstcs,
 				       struct reset_control_bulk_data *rstcs)
 {
-	return __reset_control_bulk_get(dev, num_rstcs, rstcs, true, true, false)=
;
+	return __reset_control_bulk_get(dev, num_rstcs, rstcs, RESET_CONTROL_OPTI=
ONAL_SHARED);
 }
=20
 /**
@@ -451,7 +484,7 @@ reset_control_bulk_get_optional_shared(struct device *d=
ev, int num_rstcs,
 static inline struct reset_control *of_reset_control_get_exclusive(
 				struct device_node *node, const char *id)
 {
-	return __of_reset_control_get(node, id, 0, false, false, true);
+	return __of_reset_control_get(node, id, 0, RESET_CONTROL_EXCLUSIVE);
 }
=20
 /**
@@ -471,7 +504,7 @@ static inline struct reset_control *of_reset_control_ge=
t_exclusive(
 static inline struct reset_control *of_reset_control_get_optional_exclusiv=
e(
 				struct device_node *node, const char *id)
 {
-	return __of_reset_control_get(node, id, 0, false, true, true);
+	return __of_reset_control_get(node, id, 0, RESET_CONTROL_OPTIONAL_EXCLUSI=
VE);
 }
=20
 /**
@@ -496,7 +529,7 @@ static inline struct reset_control *of_reset_control_ge=
t_optional_exclusive(
 static inline struct reset_control *of_reset_control_get_shared(
 				struct device_node *node, const char *id)
 {
-	return __of_reset_control_get(node, id, 0, true, false, false);
+	return __of_reset_control_get(node, id, 0, RESET_CONTROL_SHARED);
 }
=20
 /**
@@ -513,7 +546,7 @@ static inline struct reset_control *of_reset_control_ge=
t_shared(
 static inline struct reset_control *of_reset_control_get_exclusive_by_inde=
x(
 					struct device_node *node, int index)
 {
-	return __of_reset_control_get(node, NULL, index, false, false, true);
+	return __of_reset_control_get(node, NULL, index, RESET_CONTROL_EXCLUSIVE)=
;
 }
=20
 /**
@@ -541,7 +574,7 @@ static inline struct reset_control *of_reset_control_ge=
t_exclusive_by_index(
 static inline struct reset_control *of_reset_control_get_shared_by_index(
 					struct device_node *node, int index)
 {
-	return __of_reset_control_get(node, NULL, index, true, false, false);
+	return __of_reset_control_get(node, NULL, index, RESET_CONTROL_SHARED);
 }
=20
 /**
@@ -560,7 +593,7 @@ static inline struct reset_control *
 __must_check devm_reset_control_get_exclusive(struct device *dev,
 					      const char *id)
 {
-	return __devm_reset_control_get(dev, id, 0, false, false, true);
+	return __devm_reset_control_get(dev, id, 0, RESET_CONTROL_EXCLUSIVE);
 }
=20
 /**
@@ -580,7 +613,8 @@ static inline int __must_check
 devm_reset_control_bulk_get_exclusive(struct device *dev, int num_rstcs,
 				      struct reset_control_bulk_data *rstcs)
 {
-	return __devm_reset_control_bulk_get(dev, num_rstcs, rstcs, false, false,=
 true);
+	return __devm_reset_control_bulk_get(dev, num_rstcs, rstcs,
+					     RESET_CONTROL_EXCLUSIVE);
 }
=20
 /**
@@ -599,7 +633,7 @@ static inline struct reset_control *
 __must_check devm_reset_control_get_exclusive_released(struct device *dev,
 						       const char *id)
 {
-	return __devm_reset_control_get(dev, id, 0, false, false, false);
+	return __devm_reset_control_get(dev, id, 0, RESET_CONTROL_EXCLUSIVE_RELEA=
SED);
 }
=20
 /**
@@ -619,7 +653,8 @@ static inline int __must_check
 devm_reset_control_bulk_get_exclusive_released(struct device *dev, int num=
_rstcs,
 					       struct reset_control_bulk_data *rstcs)
 {
-	return __devm_reset_control_bulk_get(dev, num_rstcs, rstcs, false, false,=
 false);
+	return __devm_reset_control_bulk_get(dev, num_rstcs, rstcs,
+					     RESET_CONTROL_EXCLUSIVE_RELEASED);
 }
=20
 /**
@@ -638,7 +673,7 @@ static inline struct reset_control *
 __must_check devm_reset_control_get_optional_exclusive_released(struct dev=
ice *dev,
 								const char *id)
 {
-	return __devm_reset_control_get(dev, id, 0, false, true, false);
+	return __devm_reset_control_get(dev, id, 0, RESET_CONTROL_OPTIONAL_EXCLUS=
IVE_RELEASED);
 }
=20
 /**
@@ -658,7 +693,8 @@ static inline int __must_check
 devm_reset_control_bulk_get_optional_exclusive_released(struct device *dev=
, int num_rstcs,
 							struct reset_control_bulk_data *rstcs)
 {
-	return __devm_reset_control_bulk_get(dev, num_rstcs, rstcs, false, true, =
false);
+	return __devm_reset_control_bulk_get(dev, num_rstcs, rstcs,
+					     RESET_CONTROL_OPTIONAL_EXCLUSIVE_RELEASED);
 }
=20
 /**
@@ -673,7 +709,7 @@ devm_reset_control_bulk_get_optional_exclusive_released=
(struct device *dev, int
 static inline struct reset_control *devm_reset_control_get_shared(
 					struct device *dev, const char *id)
 {
-	return __devm_reset_control_get(dev, id, 0, true, false, false);
+	return __devm_reset_control_get(dev, id, 0, RESET_CONTROL_SHARED);
 }
=20
 /**
@@ -693,7 +729,7 @@ static inline int __must_check
 devm_reset_control_bulk_get_shared(struct device *dev, int num_rstcs,
 				   struct reset_control_bulk_data *rstcs)
 {
-	return __devm_reset_control_bulk_get(dev, num_rstcs, rstcs, true, false, =
false);
+	return __devm_reset_control_bulk_get(dev, num_rstcs, rstcs, RESET_CONTROL=
_SHARED);
 }
=20
 /**
@@ -711,7 +747,7 @@ devm_reset_control_bulk_get_shared(struct device *dev, =
int num_rstcs,
 static inline struct reset_control *devm_reset_control_get_optional_exclus=
ive(
 					struct device *dev, const char *id)
 {
-	return __devm_reset_control_get(dev, id, 0, false, true, true);
+	return __devm_reset_control_get(dev, id, 0, RESET_CONTROL_OPTIONAL_EXCLUS=
IVE);
 }
=20
 /**
@@ -731,7 +767,8 @@ static inline int __must_check
 devm_reset_control_bulk_get_optional_exclusive(struct device *dev, int num=
_rstcs,
 					       struct reset_control_bulk_data *rstcs)
 {
-	return __devm_reset_control_bulk_get(dev, num_rstcs, rstcs, false, true, =
true);
+	return __devm_reset_control_bulk_get(dev, num_rstcs, rstcs,
+					     RESET_CONTROL_OPTIONAL_EXCLUSIVE);
 }
=20
 /**
@@ -749,7 +786,7 @@ devm_reset_control_bulk_get_optional_exclusive(struct d=
evice *dev, int num_rstcs
 static inline struct reset_control *devm_reset_control_get_optional_shared=
(
 					struct device *dev, const char *id)
 {
-	return __devm_reset_control_get(dev, id, 0, true, true, false);
+	return __devm_reset_control_get(dev, id, 0, RESET_CONTROL_OPTIONAL_SHARED=
);
 }
=20
 /**
@@ -769,7 +806,7 @@ static inline int __must_check
 devm_reset_control_bulk_get_optional_shared(struct device *dev, int num_rs=
tcs,
 					    struct reset_control_bulk_data *rstcs)
 {
-	return __devm_reset_control_bulk_get(dev, num_rstcs, rstcs, true, true, f=
alse);
+	return __devm_reset_control_bulk_get(dev, num_rstcs, rstcs, RESET_CONTROL=
_OPTIONAL_SHARED);
 }
=20
 /**
@@ -787,7 +824,7 @@ devm_reset_control_bulk_get_optional_shared(struct devi=
ce *dev, int num_rstcs,
 static inline struct reset_control *
 devm_reset_control_get_exclusive_by_index(struct device *dev, int index)
 {
-	return __devm_reset_control_get(dev, NULL, index, false, false, true);
+	return __devm_reset_control_get(dev, NULL, index, RESET_CONTROL_EXCLUSIVE=
);
 }
=20
 /**
@@ -803,7 +840,7 @@ devm_reset_control_get_exclusive_by_index(struct device=
 *dev, int index)
 static inline struct reset_control *
 devm_reset_control_get_shared_by_index(struct device *dev, int index)
 {
-	return __devm_reset_control_get(dev, NULL, index, true, false, false);
+	return __devm_reset_control_get(dev, NULL, index, RESET_CONTROL_SHARED);
 }
=20
 /*
@@ -851,54 +888,54 @@ static inline struct reset_control *devm_reset_contro=
l_get_by_index(
 static inline struct reset_control *
 devm_reset_control_array_get_exclusive(struct device *dev)
 {
-	return devm_reset_control_array_get(dev, false, false);
+	return devm_reset_control_array_get(dev, RESET_CONTROL_EXCLUSIVE);
 }
=20
 static inline struct reset_control *
 devm_reset_control_array_get_shared(struct device *dev)
 {
-	return devm_reset_control_array_get(dev, true, false);
+	return devm_reset_control_array_get(dev, RESET_CONTROL_SHARED);
 }
=20
 static inline struct reset_control *
 devm_reset_control_array_get_optional_exclusive(struct device *dev)
 {
-	return devm_reset_control_array_get(dev, false, true);
+	return devm_reset_control_array_get(dev, RESET_CONTROL_OPTIONAL_EXCLUSIVE=
);
 }
=20
 static inline struct reset_control *
 devm_reset_control_array_get_optional_shared(struct device *dev)
 {
-	return devm_reset_control_array_get(dev, true, true);
+	return devm_reset_control_array_get(dev, RESET_CONTROL_OPTIONAL_SHARED);
 }
=20
 static inline struct reset_control *
 of_reset_control_array_get_exclusive(struct device_node *node)
 {
-	return of_reset_control_array_get(node, false, false, true);
+	return of_reset_control_array_get(node, RESET_CONTROL_EXCLUSIVE);
 }
=20
 static inline struct reset_control *
 of_reset_control_array_get_exclusive_released(struct device_node *node)
 {
-	return of_reset_control_array_get(node, false, false, false);
+	return of_reset_control_array_get(node, RESET_CONTROL_EXCLUSIVE_RELEASED)=
;
 }
=20
 static inline struct reset_control *
 of_reset_control_array_get_shared(struct device_node *node)
 {
-	return of_reset_control_array_get(node, true, false, true);
+	return of_reset_control_array_get(node, RESET_CONTROL_SHARED);
 }
=20
 static inline struct reset_control *
 of_reset_control_array_get_optional_exclusive(struct device_node *node)
 {
-	return of_reset_control_array_get(node, false, true, true);
+	return of_reset_control_array_get(node, RESET_CONTROL_OPTIONAL_EXCLUSIVE)=
;
 }
=20
 static inline struct reset_control *
 of_reset_control_array_get_optional_shared(struct device_node *node)
 {
-	return of_reset_control_array_get(node, true, true, true);
+	return of_reset_control_array_get(node, RESET_CONTROL_OPTIONAL_SHARED);
 }
 #endif
--=20
2.43.0


