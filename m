Return-Path: <john.madieu.xa@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B3ACD4F3E
	for <webhook@archiver.kernel.org>; Thu, 14 May 2026 09:42:34 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.34])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7014.1778751750249935556
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 May 2026 02:42:30 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=oUNVl/nm;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.34, mailfrom: john.madieu.xa@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jWNPewf6qP6M0Hq6DOd9CwE0fwgRGmofst+UXBT4VQTelMwggMNGsiJst7vp7I1wxjvRZgeappcg1TCLKxlb1Cw/hSAPn0lxeuLkjHzIc6zQAc1ZYdsikN96+t5IfqIHPb5jkpI7OsonJmNnAhqx1nELTt7CcD3Ibvjaj/qhEYD5dJLw6U6Z68YlfnftC7LM0Z+9kqUrTI7OR/RTPjVKKdS218gos60ni/4VkPFn2VEpXiFvoq5Vh5NPtdy5RwYF2ZqavwKNxQF2NWlBMFrmNLWA2ArOrSG2AnvMoTcul9knHunnUwhxi3+WtYV6qB3O6RHO2NOnDsAzNl/dRIJbTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nOlcBhNB9UoYMdwwVSkCaAW5h2CdRTHQHQp77bOzmLc=;
 b=xTczN45lPuRw85q9BKLaJl7buHPVpQYesDlhCVvPCpr5pagtfeL3mPHeGRa1ypn48G6CQeAapOHx8RT83XdOb/3hQ8qEkYhEYZS/nwMRviL+EwkuIIjlJjUDeNkKr9Vj0hQg2bZvBfhsKu5NcvvHe23Zs5KZbSwDwzAMnAsrR5kTTQmZ6QM/u5EAMgdGMYBR32+FQAsV/cOYtYM64yJeb6TNuDPan7hQvweE/LOH3OHp7y5f2s7ievYPHOxEj2Nd271wrETbXfwj/qhVi/5YceR6ErVdMTQA1aTk4e2LMuk6p2xyb7RkfKC/ehLg4r7EdyUIMOnPIyGbrJn0qyuxpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOlcBhNB9UoYMdwwVSkCaAW5h2CdRTHQHQp77bOzmLc=;
 b=oUNVl/nmgI7DcyprK1w0ziSPyjUqNO4Xvg1sJF/jpuBabtfopq/E4T8+2cHpsuPS9BFu0pidBjq/wGhZTuUE1/6AL8tVi7jou5tNOLq+g61rwTbFsW17lyDhmImEMVEexotukE2omleESC2fRC6qBTXo4QRoz21yaV0ZF1682Ck=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by TY4PR01MB13906.jpnprd01.prod.outlook.com (2603:1096:405:1fc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 09:42:27 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3%6]) with mapi id 15.20.9891.021; Thu, 14 May 2026
 09:42:27 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	john.madieu@gmail.com
Subject: [PATCH 6.1.y-cip 02/17] bitfield: Add less-checking __FIELD_{GET,PREP}()
Date: Thu, 14 May 2026 09:41:37 +0000
Message-ID: <20260514094152.2215176-3-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260514094152.2215176-1-john.madieu.xa@bp.renesas.com>
References: <20260514094152.2215176-1-john.madieu.xa@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: PR1P264CA0025.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19f::12) To TY6PR01MB17377.jpnprd01.prod.outlook.com
 (2603:1096:405:35b::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY6PR01MB17377:EE_|TY4PR01MB13906:EE_
X-MS-Office365-Filtering-Correlation-Id: 18fc2e56-97b5-4062-5be9-08deb19d1c02
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|11063799003|18002099003|56012099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: 
	UNn8lApdyQg45IWGtw/TYT8lkgs9Jqf/7sxN3ms5xCYeB0pG7HnFirfk052w/siXjZ97k6EaO8cwWRHulWN5dRhYxduQrQADK0qQqYJPyaiJwW1RySW+3gR+9Ap4IfnkRdXHM39QUJ9b8tO998MwV+Bnqizxck0+xN6DTiSnJg6hXltvb3KyO7TipHZ/eplTXfpPGbQ6kEp52UgQYZWP4+NFWUs7poZ70d8BNnorvq5kSJtUWZuw7ZgZfK/3hCHKqlF/WvF0betPR254VheKorKD6XwYTZgAr/XibkwdwU0V8sXiGeZlPIhZDU+6eUpUFLfbCUh1WlGmF3CY1A3VgBxogUi/MEwG3aPBEjdlG8R7oV3h4yKO2ooidePPMaMtZY1tVtFL9R5zKTOk1CKG0aGSpX/uT/rf5SrWHvEDKcu26CE9HpJMniIYCmOEptt8TXHoXccx1m7DWS7JoI5p3pbBo6r0xVwROwzCT6xmQl93c1h+DZqtSR8qKXTNEL4Bk2oxRM7ztgiQb1lJLuWHH5DsFPdy2dJPVvy8xlNKyAuaib3ZmACrGRILDe9CRQvN9LOiIV6uNQ4gBRQj/rwtEkHoIc/s22arr6ZngBHl7bdkfEMKStZQ/YiQPVdvCHrbFFkrwyG5MtOZDoGdHLBBYB5QsVJZZsmRtfIyPbWDcGN9TXTZvqKm5eIEVvDNjuyXHJ8CUia3+wxzsA8ZQ4yYQ6bSP/+s1ccPMiN9QeKAHcyHOMGCQDPJILBdsoZLwzYn
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(11063799003)(18002099003)(56012099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?sil2YyTkg8vab2hU66NU8IX24nPX+Vpx1IMcQ4eNi+UgzYFlDArqPKEmtw3r?=
 =?us-ascii?Q?OVZ1//zCA5xIXljlwktyjotb7PU1mKu+fd/K0Mp39b2yowg268nQuZUmHf4a?=
 =?us-ascii?Q?4R8mzOPA47++ppWxB+eG9RDkgipNcUX1GtK1lEuHLT6NgMXfwFqiJZPFF5PA?=
 =?us-ascii?Q?aRpagAEkHoOuaHFUON5UsRdtRcL4ZjvQ2dF9ja1f6w57trltT9X9L/bi2wZe?=
 =?us-ascii?Q?sGSCfK9UAT+cA5ZisaCFDmHWgzwwT8I16Tm5CieeejTh2lWjFtwsdS7aO8uC?=
 =?us-ascii?Q?/ruZgViakJc4ym0F63dRdyOtIZLgU3qFnSWLQJ+OegG46UpYhkaLSsVjInsi?=
 =?us-ascii?Q?RdmEE43cuAk2B6rhEobMRaZn8IQ1oW2y0DLO/aqT+eN3lX3bobjgeTLIyvUJ?=
 =?us-ascii?Q?qN9X39/j9VlCp7VtZw600TKm/sZi1306NjXAroxYIawSXQWmlBtr2Ty9LuPy?=
 =?us-ascii?Q?M9TiwQ8YwSIQL2EMHtjabG9Z4WPCaNIsO9crH7uxLkdaOcOUA380JV288XG5?=
 =?us-ascii?Q?+5ytttlzkpE98fPSBkmbg0A+AMpk4n5tgyqkPIC+7/x1ynQjPIISmipF3aWO?=
 =?us-ascii?Q?7eKrjdkwhn1mZp0QOEYa9T/Si2AFez+1GMiHYCeNASC2IaBTjwQfS8Y3PeEF?=
 =?us-ascii?Q?D3hYxVcEgeHr0uH0JHVitihfm9ERIbViwZFy4TTv38opQxZM5oHry9r3EZu+?=
 =?us-ascii?Q?2RJfHlNTx0Qo5Nyb+eay4AXMkzwR3GttPsg2jq8Ml4/t05sKU/qBrFwZLrbc?=
 =?us-ascii?Q?+9qRhoQoppaU4SNa5KUAaRO793hj07j+5PJYkWikdWrt1pm2taoM3xuyfOVp?=
 =?us-ascii?Q?+2zHRwLHQrxcBTeJ/CtTwAxwXpK0IunGV6qRe6r8zjosQNNx+tdHOeGO5UXA?=
 =?us-ascii?Q?PfLbfd/kQahI8whYDNiOeRS2wxlryBPcWb5K81/9gA0GmsJ7rdqviKDGYuhs?=
 =?us-ascii?Q?XXlaGl1Y8IC4jmEZYiNxUrHhRA/YnbtM1f7OUYmKaU/lOm1Jf86SJjGKacz0?=
 =?us-ascii?Q?AiYW5LPXsspQq8YWfyBrDVRq55pEDW/B9WKH+9xym3hzC6pFN3PJ9wEX6fND?=
 =?us-ascii?Q?wYXnKgiEduF7HyPQY7whakxNwHgDG7oV+DIMO3gOvN+94Q7oaSCkgJ2RIj/u?=
 =?us-ascii?Q?5ttD49MuBxns85eXxuQemO7Y8sX3LTS7ejKtXf3lc0SZCJhPPpehBkTbrlu+?=
 =?us-ascii?Q?U2aV2xfSM1R9Ua4remM0tvynyPr7Jm5uj9eBQ19ATr4Sl64BybiCAJM8RtlF?=
 =?us-ascii?Q?gTMCFKCPagyz0GeYBCZSYlEUmf8yc6iNcye+sSKY5aMJnxhBirEwXt/ULi8A?=
 =?us-ascii?Q?7hKHJoR9ByK2AAILPRmDX4lpoye1OZ9HmTUlo75f+QFdVthkFuJ3uhy1CAUs?=
 =?us-ascii?Q?gn63A2hm8FV2jRr6SmDHBBUJ1mPFsKR/NxaKEFRndQLdPPny3FysYT3nLW7I?=
 =?us-ascii?Q?v6BzrRXQ1QpAephnQvLjaK6MJUz4XnxcSqS64tw9D6VMGkZHj+ucinb5YmBo?=
 =?us-ascii?Q?Nac3wcdMzXoNLSj5c4WGzpZaA1mnG5C70ftOaJ4OCKkCRpow7y+lrsgEh2sO?=
 =?us-ascii?Q?g1Wqa4k5EFk16KEaqLSNl6LBl87a3ZQ06HlVBs9ZLOQlbHm0a6OdfeMuA5UM?=
 =?us-ascii?Q?F6sc0+eqPv3oOXnLhzqZ/Xq9bRePbDCnM/sKIBS2Wp/iG+fL+LIya5T4a0QA?=
 =?us-ascii?Q?A5xfi0GKqgRb7hcV545se3heSUPNHX8hRWs7MpuoAPzke/Nm5zByP2jVOtzB?=
 =?us-ascii?Q?MtHFQLWtLT4dFmu3rJgiq3m5KHooBnQ=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18fc2e56-97b5-4062-5be9-08deb19d1c02
X-MS-Exchange-CrossTenant-AuthSource: TY6PR01MB17377.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 09:42:27.2083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PXUNiy7ZsdbnXXATnIVhmJDcb3hZG3kEvo8+JgjH9X2gWQLz0hDr5h4/tAvik7GMo9bcx5S1S9GChXV7ZmacxFVGj/C7+R7/UZRw9IlICio=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13906
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 May 2026 09:42:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22954

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 2a6c045640c38a407a39cd40c3c4d8dd2fd89aa8 ]

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
[john.madieu: Keep __BF_FIELD_CHECK(), FIELD_PREP() and FIELD_GET() unchang=
ed
 to avoid touching unrelated in-tree callers; only add
 __BF_FIELD_CHECK_MASK(), __BF_FIELD_CHECK_REG(), __FIELD_PREP() and
 __FIELD_GET() byte-for-byte from the upstream commit. The wrapper
 redefinition of __BF_FIELD_CHECK() in the same commit is omitted for
 the same reason: existing FIELD_MAX/FIELD_FIT/FIELD_PREP/FIELD_GET/
 FIELD_MODIFY callers continue to use the original __BF_FIELD_CHECK().
 Matches the additive pattern used by the FIELD_PREP_CONST() backport
 already in this branch.]
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 include/linux/bitfield.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index d0dfb2d86ec1..387cb0ac6ae1 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -75,6 +75,36 @@
 					      (1ULL << __bf_shf(_mask))); \
 	})
=20
+#define __BF_FIELD_CHECK_MASK(_mask, _val, _pfx)			\
+	({								\
+		BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),		\
+				 _pfx "mask is not constant");		\
+		BUILD_BUG_ON_MSG((_mask) =3D=3D 0, _pfx "mask is zero");	\
+		BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?		\
+				 ~((_mask) >> __bf_shf(_mask)) &	\
+					(0 + (_val)) : 0,		\
+				 _pfx "value too large for the field"); \
+		__BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +			\
+					      (1ULL << __bf_shf(_mask))); \
+	})
+
+#define __BF_FIELD_CHECK_REG(mask, reg, pfx)				\
+	BUILD_BUG_ON_MSG(__bf_cast_unsigned(mask, mask) >		\
+			 __bf_cast_unsigned(reg, ~0ull),		\
+			 pfx "type of reg too small for mask")
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
--=20
2.25.1


