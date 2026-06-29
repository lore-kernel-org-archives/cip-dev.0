Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAE4C43458
	for <webhook@archiver.kernel.org>; Mon, 29 Jun 2026 22:53:43 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9254.1782773622053622635
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Jun 2026 15:53:42 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=LBnVKaGn;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.49, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CdQ2v3xcoXRc8pXBwlzPKqIxQmvflAbR+oRMU3SzuI7ZWnf+DBuIY+96pv+g/iP4qRHByvv/YzKFkVsssoBOBV05tbfG7h0gnFaji6rvSYTaxy8CIkvSrpfiAgy5zP/Ak4H8XV39KnzQ7ydSp8s2hIRKz5oLsZ2lK6diF6Ma112Rh0vj/pq00VWFVD0ggTI+q4wmqrcmxrjtuDE0aPDk8Zu/mBceqgzonMonLaBFGWclZ33PDu+FodteaP4VFQj9K+wYF1gGyTAtP7XcQVmWAxtZltOnEjI0q4prr7zfANi1ZmOoPxnnguA9m+DP/4ulloIuqS891rKJ8SrJJsCDNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3zdKxgGZMxAGUKKbVd8jHjSPp10BO1qxQ6kv0S02DU=;
 b=IvgmQAJhbxldGOKa+0IzlisHDyrE+saMG4YDZZ9gB1hT3DvjPKi6gj3+qcA3atB1NCPZvQ0sv+9eUwpG4+jcPbdmrFIavvVPG7WmmGrda2O1YtgkXd2VSXpw/zWGUWmI1cZW87ZJsc0tg4jhqstlTTdU/sGu4mg75scpfZZ6kB0bgZGSXsuQ8XdQYRT3RQUuM3HWUvI/elXf5LTRGozD0OihIPEtPztig7DkIaFV1a+Z5B1zvqdthr7kBBBWi37eORREfmrQa2J32TnJeBb5LlIcx6GR4c4J6zNruU1NJGyl4FHdV8pbI/4T743GTeas6L0aX/2rfYRtZfX1Vya/wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3zdKxgGZMxAGUKKbVd8jHjSPp10BO1qxQ6kv0S02DU=;
 b=LBnVKaGndKcnddsR3Z8984ZVqIF0/6MhKsfBaPrWQGrMgePno3LwuWSG7uWauKK8biWn7KIRp+NAjgBiQ/rlLL+DYxlYe+lcJTzyrMzsv1GrSOeVurJ7SOkNlXonyTeFIiOq2Ehe4WD8r8sZbHrsytRuIJmS2fFo63o+6d2WLNY=
Received: from OS3P286CA0060.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:200::20)
 by OS7PR01MB15384.jpnprd01.prod.outlook.com (2603:1096:604:389::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 22:53:36 +0000
Received: from OS1PEPF0000D214.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:200:cafe::36) by OS3P286CA0060.outlook.office365.com
 (2603:1096:604:200::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 22:53:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D214.mail.protection.outlook.com (10.167.240.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Mon, 29 Jun 2026 22:53:36 +0000
Received: from Ubuntu-22.. (ree-0065929.diasemi.com [10.24.0.99])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id A528A3000256;
	Tue, 30 Jun 2026 07:53:34 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 01/11] bitfield: Add less-checking __FIELD_{GET,PREP}()
Date: Mon, 29 Jun 2026 23:53:21 +0100
Message-ID: <20260629225331.10023-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629225331.10023-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260629225331.10023-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D214:EE_|OS7PR01MB15384:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8b37e7db-6260-43a0-2f65-08ded63140b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|13003099007|22082099003|11063799006|18002099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: 
	1FJjrA7R+RzMwohvfA0flsRYLuzLNdo3PY+afYetEIxh/iqKJ/sfN9N4jVmP3E1Ixlq9hjTp8TWGE0gBRzu4xmLknKXNNu57lWAzX542h5Mp/Xu17Qg6nB9azOTK57/MTInA2E6UoPVwEiRrtX2JLziFd8OzXlIHjA9scjw5G6UoDuMSBQOWLKpy7NG4zYjP5WC28P+EkwSNmtfDbIGLnQ3X2tXLD9lvyy7S9jTNMggXUDvrhVeG//1d9Hg66UUp5V0FGWkrVYtDlrUQwdtq6hxG3vq+gvoTcVWpQikd6GWHQ6RMJd7x2373z+KOGvLN6yThjrkW0NP1xXxzbMVelVi0vQBh/5p2Md+moceqPCUwvOiazs2vApFPvb0cFxFokpmQW8jWOD3TxpGt14C04cdEOYyKe639eGtbmYLODSKtUw16aPEOyQTSEZ1ylpDpC7xmvB51nwWrGbsQmIWQOdk4kKKxUEYNSHXYT1+ZBGgVv/PLrejJ+1s5aaDK4a8VVibOnt9czKne8sj8/Z+A4gw/T6GKloHinU9m7MnsXBQxuaFzO/MkKBg0qQv6HHtHdKiIfPkGFFJLkbsZ+xplbQ/MMDVvsis/FQjaUcOEoIilN3eGxgJvVxg2Og7fJenFS4AZRJwcZRViVHL5O8PE1nMDvVshbWWkSDPdAzQnQsQx8G2ds95V5RNVtuOcf/iayPL04ox+o0hRu8cwt6PeFQ==
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(13003099007)(22082099003)(11063799006)(18002099003)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	e3GR45LUghjniCIvmsr+32ESGk32UgG3k3T2Q9P9QDaG2/tFdz9S+Y6+RaPMXV0keaITCdqmd5zpaxC/ti6IaMiIVb5AVXGQLEdvIjEGoIVr8VvDv3vde2g+r02lGzkjnjLcAlqsqyb1/fP6RLuMw+0Npw0u50An8Lw86JiT9029QR3JBVXpS+ZoIDpl5TmhMFy7XOJNqVNJpR0Ji6p5G9hlbHzyYOPs7hFqjQQJWwwmk7GK3Mbz+F2prD/r6u9BBGlHoi0n/JK5jhrhiNlj5ngukP2Iha951gsQLy+Ykl2QsC+utDk8g0Cy8ADZQqDX4LB78QrNNfixnDBnvYGX5+ELdkCF7OJWJCdfKkV05wjkr9TVPcVzQcaYw48j9apc3rIu4U92iKnjytEOL2Ww5omqro3pgheZXyDtqCuFijrD+s61buy3YIt+N5SMvval
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 22:53:36.0162
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b37e7db-6260-43a0-2f65-08ded63140b9
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D214.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB15384
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Jun 2026 22:53:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23309

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 2a6c045640c38a407a39cd40c3c4d8dd2fd89aa8 upstream.

The BUILD_BUG_ON_MSG() check against "~0ull" works only with "unsigned
(long) long" _mask types.  For constant masks, that condition is usually
met, as GENMASK() yields an UL value.  The few places where the
constant mask is stored in an intermediate variable were fixed by
changing the variable type to u64 (see e.g. [1] and [2]).

However, for non-constant masks, smaller unsigned types should be valid,
too, but currently lead to "result of comparison of constant
18446744073709551615 with expression of type ... is always
false"-warnings with clang and W=3D1.

Hence refactor the __BF_FIELD_CHECK() helper, and factor out
__FIELD_{GET,PREP}().  The later lack the single problematic check, but
are otherwise identical to FIELD_{GET,PREP}(), and are intended to be
used in the fully non-const variants later.

[1] commit 5c667d5a5a3ec166 ("clk: sp7021: Adjust width of _m in
    HWM_FIELD_PREP()")
[2] commit cfd6fb45cfaf46fa ("crypto: ccree - avoid out-of-range
    warnings from clang")

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://git.kernel.org/torvalds/c/5c667d5a5a3ec166 [1]
Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 include/linux/bitfield.h | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index 6d9a53db54b66..3346c6009c2ce 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -60,7 +60,7 @@
=20
 #define __bf_cast_unsigned(type, x)	((__unsigned_scalar_typeof(type))(x))
=20
-#define __BF_FIELD_CHECK(_mask, _reg, _val, _pfx)			\
+#define __BF_FIELD_CHECK_MASK(_mask, _val, _pfx)			\
 	({								\
 		BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),		\
 				 _pfx "mask is not constant");		\
@@ -69,13 +69,33 @@
 				 ~((_mask) >> __bf_shf(_mask)) &	\
 					(0 + (_val)) : 0,		\
 				 _pfx "value too large for the field"); \
-		BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >	\
-				 __bf_cast_unsigned(_reg, ~0ull),	\
-				 _pfx "type of reg too small for mask"); \
 		__BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +			\
 					      (1ULL << __bf_shf(_mask))); \
 	})
=20
+#define __BF_FIELD_CHECK_REG(mask, reg, pfx)				\
+	BUILD_BUG_ON_MSG(__bf_cast_unsigned(mask, mask) >		\
+			 __bf_cast_unsigned(reg, ~0ull),		\
+			 pfx "type of reg too small for mask")
+
+#define __BF_FIELD_CHECK(mask, reg, val, pfx)				\
+	({								\
+		__BF_FIELD_CHECK_MASK(mask, val, pfx);			\
+		__BF_FIELD_CHECK_REG(mask, reg, pfx);			\
+	})
+
+#define __FIELD_PREP(mask, val, pfx)					\
+	({								\
+		__BF_FIELD_CHECK_MASK(mask, val, pfx);			\
+		((typeof(mask))(val) << __bf_shf(mask)) & (mask);	\
+	})
+
+#define __FIELD_GET(mask, reg, pfx)					\
+	({								\
+		__BF_FIELD_CHECK_MASK(mask, 0U, pfx);			\
+		(typeof(mask))(((reg) & (mask)) >> __bf_shf(mask));	\
+	})
+
 /**
  * FIELD_MAX() - produce the maximum value representable by a field
  * @_mask: shifted mask defining the field's length and position
@@ -112,8 +132,8 @@
  */
 #define FIELD_PREP(_mask, _val)						\
 	({								\
-		__BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");	\
-		((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask);	\
+		__BF_FIELD_CHECK_REG(_mask, 0ULL, "FIELD_PREP: ");	\
+		__FIELD_PREP(_mask, _val, "FIELD_PREP: ");		\
 	})
=20
 #define __BF_CHECK_POW2(n)	BUILD_BUG_ON_ZERO(((n) & ((n) - 1)) !=3D 0)
@@ -152,8 +172,8 @@
  */
 #define FIELD_GET(_mask, _reg)						\
 	({								\
-		__BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");	\
-		(typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask));	\
+		__BF_FIELD_CHECK_REG(_mask, _reg, "FIELD_GET: ");	\
+		__FIELD_GET(_mask, _reg, "FIELD_GET: ");		\
 	})
=20
 /**
--=20
2.43.0


