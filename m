Return-Path: <john.madieu.xa@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F607CD4F39
	for <webhook@archiver.kernel.org>; Thu, 14 May 2026 09:40:23 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.7])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6961.1778751613397410108
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 May 2026 02:40:13 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=pndfkMDM;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.7, mailfrom: john.madieu.xa@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WkaC0BHU4FkJ17PyWSxTuFcl+wA6y1DMu2NMIXVSzb6+o4V6ulgG1MpNiPM8KmLSLr2UAjA1lN9QdiUVxfO113/pah24zZy29F+2YOjb0MgjQjRila8OAhrSMArU/Z6IBWc30wYp3kv1tbcbaGYC2ACLAs07rbwFQxN6QfuRwjMqoF7PHVjAKV0TbUwvTx1jq5WTpDwhWs3GqB2jvPeCygnz9OO7CxY2sY+KUKlS7vgSd7fveQt3EjTmyaaWzJwqbXlSr/6bQfcS/tW2Y22BG++T0akRNZ62ccfBMnzZbg2dG8TIrQAU2JUDiOKB4DYjqe9+YQY9uXWG17ZrDNOyhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tInxRSj2esop1kNaCLMdsXuZjShL5P9ma7+DjVqG17o=;
 b=RdBztKbNJMtEblVwJQcgRQW9XsZMAorXWG1k20zQm3wgQs0KUQlDOP9JXdqUABiPLthL0iXHH8oaWhnbxj09GyUFnpdMnWu02GWDUDiTNECfOkFeDdZb8tiRd8w96dQ+km7tAs37LqTTgt791l3G3axJOX8fp5DoB1+FrL6RxKPVQvD0JKV0+DPvvyFAlvIONXO/OEL6kVhcumfYDC0bw+MquQJ82Ge7DKzHxJaEnwQee50t3dhaUakT8Ek2SJSeBZbuj1B0ld2nJUOuP8U8JoIcljbPI1REbP9GL2g8vInmZK65HrgfyK3B1wpgaezgtlZ0GYT73aLfI+WfCpZWDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tInxRSj2esop1kNaCLMdsXuZjShL5P9ma7+DjVqG17o=;
 b=pndfkMDMnDrh17KmKNrFvZmX4CgRimvhDcVkMicAHpIrk6isIRBeazT5IkM8duhc/WJSW2lZynKLqzcbsJCEjdOoQA1TgJDcGMQDzKjJHTMPtfR56xcj9VG3cxceCDWjn7Tr4WvdUu7xx4JvVAqpZ6vTh65v3YTrD/ImJLwJAgE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by TYWPR01MB8821.jpnprd01.prod.outlook.com (2603:1096:400:16c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 09:40:09 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3%6]) with mapi id 15.20.9891.021; Thu, 14 May 2026
 09:40:09 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	john.madieu@gmail.com
Subject: [PATCH 6.12.y-cip 02/17] bitfield: Add less-checking __FIELD_{GET,PREP}()
Date: Thu, 14 May 2026 09:39:20 +0000
Message-ID: <20260514093935.2212718-3-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260514093935.2212718-1-john.madieu.xa@bp.renesas.com>
References: <20260514093935.2212718-1-john.madieu.xa@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0033.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34b::11) To TY6PR01MB17377.jpnprd01.prod.outlook.com
 (2603:1096:405:35b::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY6PR01MB17377:EE_|TYWPR01MB8821:EE_
X-MS-Office365-Filtering-Correlation-Id: 11b980ae-c16e-4ed2-6033-08deb19cc9ff
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014|56012099003|18002099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info: 
	p0SwiPXpo7RNcxCsfX+DZpCUMvGHncyXp21fSyKiI9QKHPHC5BJrly4Wz1R1R4SVzIdcMVyJ3gSzOHqmkGjCD7NlX+cM78sNl1bpUp/ec4mvfucp1XGyG6MTqH1Km6fC438v1hK9vP/xUeEJqakETZ8szKMHcC4UFD8ZiMRNO+mhbifdPd51EItvr8QSEoL6H3XffIhw5+IYcrnDXG9D5lV7sqW7FkAoVcYtew4ESrmVHAge4jIF3G0poNX6WJenSLkvh9dMKXEBKbaBsjG/T0QQWDLXlFz18TSNVjGY8YXVmLvQAU2zLl/R2+CdWy3t1q3UJifiiZR7Xr9dPtbhnxqHT3F39g1KD50Z9TdWdqxilfnGLnuvG2mUC+qAM24FF6P2HITRCgnAv7R5Udq6TPDK6KLIH6sMnt7rueybBEjDOT2oUouHP3ScKJ9Ltqngyr+oqX855nkIhH0CArYFStb6bKeqLjOOPGcPTAZqDbCPeaZD8UywAYYUchiKhi1aiWbN+JD7MvwZeXu7X1j/DXKyNUSdrdARuFdBvDKf/rT+g8MmO/pHcdUwyMOGrye3Vt7BviHFFUxWo/D0jWQZlPlHd7P7+xHzqwFhL5Epa4jpW2i8tbOfCny/AZ8AOlWzzc0cJJQQHdtStwDkjQ0J+jcaAE36slUofcF+IlyVxd4c74CPatp5pbB+7IGKGwh/MI+qxw1VC5qFeDr/tkqFiP6bn3JIv1a4yun5O9icygTf5K23Y20th75Ow6u4UpDF
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014)(56012099003)(18002099003)(22082099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?OUl85Y6MdaSZRCwA3bwwOVytLp8m7IwdR8pGhU6m6zHlH1M7Y1DsmJGEb8Kd?=
 =?us-ascii?Q?QCRGmF2RvWuLk/iT36Z2Cmkp3ThSolbjBEPRX5eKg/3N5KUu2gtWox06Nitt?=
 =?us-ascii?Q?Pn7vuR1+IbFnZtCI4unvaZL5uKXWFV4pYLBjTUI9lQmBZW5eazEKu6Wiafbh?=
 =?us-ascii?Q?tc1PaJ5iOKJehz5AvcEV+SmTm+PDCfx93ZZuMA09pXbWuYhFsPtbRhgM0t1b?=
 =?us-ascii?Q?Ur0yZYmJt9nrrfNo+5yGdRT7qUnK5IEIYG8WaCgrjnHsbgH2BEafch35H4zW?=
 =?us-ascii?Q?Mz0OwjudjJDgTVJsnZ4pDNlbx/HoOjSVRDe0YO/9MlHi1pbj1hPNrRgomLUP?=
 =?us-ascii?Q?+R5BdyQzcXp7A/XEacP1ywChGXOj1eJLp5b5LRvnEIVzfslpP3XOxHUEFLSB?=
 =?us-ascii?Q?j0YNRvPQvs+i9HRt+uLP/m70r+JiDse+DyZtW+4zeLAPO3rV4XTzRstJBoqL?=
 =?us-ascii?Q?jiqmtp6K/FLLLecwjsq/yPcBF27cY8s8GNVDHiAC1igZh5HvrwSheiH+/tFd?=
 =?us-ascii?Q?vabPSkzFFPCEsIMCJBmXcTg6BvoYgbV/dmYS8+ip+LBVap45n6OvsrQu1fu2?=
 =?us-ascii?Q?aa2OSwKTkDt4yahmKtnOgFWcbnT4g3yeqySBpXDcDXBZWxnxYZDANMGMBAsn?=
 =?us-ascii?Q?/mR7O1lOX/cUtnuYQlaH8AbF4pxCEqJqfJygVm2723PO01keRZhW1VmyCB3v?=
 =?us-ascii?Q?W/gXxoKQZO7lXcBMaT7GRYKQIMzorXjYDyM7e7G8fYr+cILGXWZkSngK6p62?=
 =?us-ascii?Q?L5ccd+fbjnokK2+AKvnru+bsbEq8Nr/R5AwDEQvam0f2Rdoal9OQq5toN2rk?=
 =?us-ascii?Q?B/Ff/4J+g7N71sfjGCJKxqedGbSEnSOHa0ss/j67xHGOj8YlLWgZDfKKRxSl?=
 =?us-ascii?Q?EpT5YdA4Cb7P0yWF03QXRzrcUFY64cGN3a3UflglOcClBbqJ5NSLMgCufv8p?=
 =?us-ascii?Q?/qjlMGBAaXnL1ypybWabkovC/vk8k6Uus16S6pZf9q3ZaNgxuOsny+vXoQO4?=
 =?us-ascii?Q?/qv85LU4+n6tvvm58dsJVPbdHvsyUcx32Oa2Fl0YUHyCUZCP6jLf9KCijnab?=
 =?us-ascii?Q?Y2uJemVPcSSqIoxilKgAE0JEiDMb8XCvUWkOKx/6iV/8FiGYSWrlCxGXnPe1?=
 =?us-ascii?Q?k3WCelUXIWUAUPtXUS0O91eaRRt+8AUU/lvKKTybFUrODVnbVT7rsLjwzuOS?=
 =?us-ascii?Q?Kc9n7+uMXY6yFXeyvjlSBYSkqZPwdxWXetE8noxh+CpZ5HHJpQo0SyA3ODBk?=
 =?us-ascii?Q?ilqVAebwwhkThUjnUaV0nigSAIi3ZsjR6OfadNcaenH+uc7+ia3sdHWSYN5f?=
 =?us-ascii?Q?IYuYDe5LRiw4ZnIulOstf+F1SIxT7CEpoWXc2fzm4C0kPRu8C0AaKjlIaiKT?=
 =?us-ascii?Q?Qo8jQwtCpeKqk6MoQSGmdDlZkcXfEHdJk4Hy/U+xl3bdBTDIIyvAKcPJMRxG?=
 =?us-ascii?Q?kneuYmH1ICEwALI+gAWa4ZsoYioc7UCM4VK7YBG/ezLB8GQY24Poo0QfULyi?=
 =?us-ascii?Q?7cWLiQ3BVqPSeWp+vZFQTjzt3NUdeEQryP32FXKPXCnceAz34kdxQrB1E+nH?=
 =?us-ascii?Q?2CmUzSNph4dA6tH4ATsWIOrxb7k2rS3iHKhi8aJk2Y9slHc8bqTrwihhCWex?=
 =?us-ascii?Q?uwJwmQMbZ4TJoGppECxSAqY42bhBAwm+MiPASQs5wjqHPrXp8KEURJ39YAeT?=
 =?us-ascii?Q?a/UqwcaUio95yNPWxE67fnriAwFnO6sfxwvo7ftpi3ud9BD1jW1a+VUSMSvy?=
 =?us-ascii?Q?QvIU4gioufx9BqUzo4Rk/z9uxAoCiIk=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b980ae-c16e-4ed2-6033-08deb19cc9ff
X-MS-Exchange-CrossTenant-AuthSource: TY6PR01MB17377.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 09:40:09.8223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J9Q4BFK3vrinBsv/hQ7Vz987VXjg4Dc9qFHncSbX3Oc2V6YhtbtX5bCVnONXI5NkdafcYelyK0xCBfN/xYDBysy2SitUlykpe51RVRTZdGM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8821
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 May 2026 09:40:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22936

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
index 6d9a53db54b6..d7523f592c63 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -76,6 +76,36 @@
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


