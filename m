Return-Path: <john.madieu.xa@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C628CD4851
	for <webhook@archiver.kernel.org>; Thu, 14 May 2026 09:40:23 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.7])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6961.1778751613397410108
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 May 2026 02:40:14 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=gIEa7m9T;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.7, mailfrom: john.madieu.xa@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D//0v9/lVgQdb/G5mENjqSe0QYm8Ye3l7tYOo03a3MOZYRh68AY5MZs0DRdlxjMpShHhndpnaK6xBT8E35KRPWvex5e/yrH90QOZf/gKXWuoefvsYvQg86cbDIWS/BKhQBZNXTUKQe9I96pIsBjL87Uuf4jMAxa3J2VEKdbOuKT+7jYw57fMqiA0Uzv5enbr5i9tGf3zsGqJ/C/NvrthqUannSED1kFUXYY6n//nvaY+OxUo0JGe0RY7D/Ie1kuYq0ug/KlVvDUehT6JVgSsGLV38i69AZlB627ZQzanIKvun+Oo2MsfKiuflcbrlu3q1pvPyHC+ErgVbU5yifDqgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7mWrgRMl+PolUW5Xi0zAOK458JiNZg5yLb5E4yKXcnA=;
 b=XOJ8BDiCL9YABhJRKSMrY0uIuq4xqRaSFudY97fj5Xqby1vtT15859QR5K5JajJA3U71MaAC6MwlD4/bJ2yvcyYs4u93b7QkSEpReF2+cGK1P2RuUX2r1YW0qAjtRM3QYtm/xteHTS5ZB3/VyrzEnKt9sI08+HDk8UY8kJ/qxmJ5DzPM5plNuXkJugQdZ1QD5NnEH/L/WH1+ZSPeWALd6wdJ8HqjM3OC9WAvugJF5RdZzPH7YA/DIXm9DBBK4xLwZHdsOgZ3bwScf25KGtTG75TssIABoOGoZGLBtnsnQFTOzUoVy/3GhicdTwPzwv3iDCbmjCCV4riWnrfO+Bdniw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7mWrgRMl+PolUW5Xi0zAOK458JiNZg5yLb5E4yKXcnA=;
 b=gIEa7m9T82qSS2POCO4AROuzU5iFJbqHJxCrISacAcCi8E/Y8VIfo1khuXkaSZ2MbLMd7gmD4ZENJttR3v+AAEZk0N7ilvu63vbpAlm3gQwJd83isgGRc1yXb08NxwwOVcxu5OlNv7wKIaDO/6dfFYlxo4MOI7Umow9lkfRrEqU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by TYWPR01MB8821.jpnprd01.prod.outlook.com (2603:1096:400:16c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 09:40:12 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3%6]) with mapi id 15.20.9891.021; Thu, 14 May 2026
 09:40:12 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	john.madieu@gmail.com
Subject: [PATCH 6.12.y-cip 03/17] bitfield: Add non-constant field_{prep,get}() helpers
Date: Thu, 14 May 2026 09:39:21 +0000
Message-ID: <20260514093935.2212718-4-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260514093935.2212718-1-john.madieu.xa@bp.renesas.com>
References: <20260514093935.2212718-1-john.madieu.xa@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: PA7P264CA0033.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34b::11) To TY6PR01MB17377.jpnprd01.prod.outlook.com
 (2603:1096:405:35b::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY6PR01MB17377:EE_|TYWPR01MB8821:EE_
X-MS-Office365-Filtering-Correlation-Id: 3535ecea-20e6-4581-2f23-08deb19ccbb6
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014|56012099003|18002099003|3023799003|22082099003|11063799003|9063799003;
X-Microsoft-Antispam-Message-Info: 
	t9rPfN2+4c29CknBO1QwGBcrUGNaNcHe2ABobWCkP+7A1oNKtkJzo5O3wj8wf6xK+cv39dfbPxm13QVWjcreYQzRzahbNrDczi0gyicPsUIIssYS5lHDQt+dgpiWxVf/WvaZRHMSnuKbX2jw/KpMeqXYNNDzth0L68KolOLsWu45tA/3M/YvjtberBw9oRw+MYbeHi2uqvTuXe6fYCzDUtUApyirCbXn0z6+XN4GyPGJMpkIC7RpY5dgnhRPb72A1fsO11wRJUBAJrRUXTiGFPnE+9i4PYsyO6xAt5tvi8DPqQcVmlbvC4o+u9hM3fmmnJ0j1923TwN+dQdkX6uL7tSElfr9I1VG8kzjCrRwss6adB0whP7VSDm7oV1eELUxrn2W4z2FOTAnxEXJMDerpX2kjdAmw5gjSG5sK3/NonGeRBXbrkcz3gKgaLghqmMM0pVCvxT/uIp+DDfGgeOtzpaKP7KnQuCsrDnHIgCfeC2zoNbz82eUWEcmTuI/iY2Y8GJ5f0ZjCWrIQtS+3ts4xHokVvo7I+brP58sd1Vx06wX+JuUZtVStyBT9s8PGfrX0FUGdShTI3UWCKT81M4wkzey2kJDgUzn3FyZmLEUhTFK5GIHTYxuIYwC17iD1Jtnd1ALY6u19fbyZgNhdTKLsijzVQ2xJVX/xyGOj1oKE7aILo70ujGGLUVzhrwsEoXWoLu0tGWEI2gFiXdnDSlkYKFNUtwIcj2kelO2CerE8JiXJZoxl3AmSEK7WJZJgCRO
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014)(56012099003)(18002099003)(3023799003)(22082099003)(11063799003)(9063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ERVWsoJoa1VbsyY9vCxJbmyZzrK04l5MovPmWrKgRlChL4BQZsapcC1pVvq+?=
 =?us-ascii?Q?pio5KEvemihRrYsYrpmF/jaf19t7mQsqgs26JQrU7Qwv3opZpvlGU+sUT7rs?=
 =?us-ascii?Q?vFmMJGj5k2O0Hf97KXo7vw52PQRi4mw23rVbwwyE1qnW3KmwcX2yldZb49EL?=
 =?us-ascii?Q?xNm878TtM4bhtDrPXV0SpbjQ1OncKEPAkvxDhbX7qIYibfTKsGE1B2tfXrzg?=
 =?us-ascii?Q?QHXRKqk6RFE+guq8ulN9rccOLrhcVO14SSD+kbo9Ty4DbPlTyKGO2MazxTU5?=
 =?us-ascii?Q?E1OfgRTymvLguuM4v/ztO8YAJNNZ0IetO9LbF16d6eM2JwPNKKH5RLsq6QLa?=
 =?us-ascii?Q?vuyrI+W8TSi7gTG7S9/PDiEhi822kaXYWs3Rt2HUNf5dV2iRy2+ebjfUfqaO?=
 =?us-ascii?Q?wcRoOObkxcjOdwfUnwt9Ga8Sl8myBnFCbNNeq41yvtzAjsPRxZM5eSdVExQM?=
 =?us-ascii?Q?GxNDth0+0DMHMy6BNYrBeay8tJjP56+wPp1NKIHmt9hPdSRDMgktEoU5vLL5?=
 =?us-ascii?Q?A5LRTPA68OYBLRC6ATfr8Tv/3m+MA3KWof4CgpVmo+jz7th4RAm+zIJ/zBte?=
 =?us-ascii?Q?xSOn+gO6Rq+hT512vkmZr1EoWmTYNJntKUI5S7PT5D/qNSMhR0R/4r+rk/wJ?=
 =?us-ascii?Q?xWVL1TOdYgG5EEk3ON/v/HgBYW2fWF68J2Df5iiPvINduODQh19JdTs73k6R?=
 =?us-ascii?Q?IxKG+PCxRhTdzfivCBGflqdYErWEUWLT2KnMWTO20ejdWmYYWhRA2q4aLiZC?=
 =?us-ascii?Q?/Nfi0id2ZNjJGlyUKAVxjPXjdY3JMJp+NB6dkDSQw12VWUUEaPuyThy1zbG6?=
 =?us-ascii?Q?eVQ2TjdaDi3XIykAKzjX5AgHCZ1jH+sRit06V55TF0k4ELFFkRItYdJnWGy9?=
 =?us-ascii?Q?WXkm/xLYDEPwau8OkVryiYaEMYna89E81/DSk3vJIa8zw29UItR4POVDuu5j?=
 =?us-ascii?Q?K+75m1zxfcxwBktp8HqXib1OrAQHwEnyEPRkbcfwJGzDdu3gW6c7xI64CP4Y?=
 =?us-ascii?Q?EZjZouItICFUqO8HB5d2qFcRuLKY5G9gy8B6lMKIzEVGZbPvvkhjH7G+2H8U?=
 =?us-ascii?Q?YEh/SwbMBOZVzooAl0JrrITKwUZ300Kee8djdNLDHM0y3BRSg/eyU3iq4CGT?=
 =?us-ascii?Q?dT1gLJVHpaw4LUu24uQ/gIn5rS72x00jMkPbNnz38uN8LjhTg62tuajhCzPP?=
 =?us-ascii?Q?eTP3Zj610HZ327gP7LCDdWG1dI9BQl5z+oXO8N18RkxSFY6VUrR+cw3tSFW7?=
 =?us-ascii?Q?r5qgzbeaIgWQxlBCyDqZOk7q9naK5mCmmlCfUFNTbzTp8K5B3IZDGZi/X4Vr?=
 =?us-ascii?Q?k2sWRGFyL+T6IHcHn7vFXDnijwKFQHTB344CM4CH1Wfx5cO98pW6UfUO3ZrR?=
 =?us-ascii?Q?MBYTMXWXjyC88SIVVqbWCDPPI6Fj3pCA7DuYqsXBPKZssuK1jsSMoCZ+JxLx?=
 =?us-ascii?Q?/yxQagcKFqiWlYCmhVVrkz7mwhHLE4jLY3/vywln8+0OUdYqmFgns3JO0I9j?=
 =?us-ascii?Q?sR+3rrEOOV/3onNwx3xis1R2KOIbh/bNNA1Nh8t48rAyTFz2oV2k8lQ6eGWH?=
 =?us-ascii?Q?PJi5lySnUmdtwM5x1+heZLtV4C9rzN6RXldZxCrWxosrIzvnCTniN90jxusP?=
 =?us-ascii?Q?TW5swWHHXoPq0NCP/9Elt3gKiUkg8u/Bz26Pv1/B3fn3/2QvoNy3l36LH9ec?=
 =?us-ascii?Q?AzfnYcMn23Eg5xf1r4wutcTJFjnsv4avQd1wnX5ZOMTB33AdwihcuIPN3ocT?=
 =?us-ascii?Q?cFdgwQReLihMwIZ7q0+NRfghvzr42zk=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3535ecea-20e6-4581-2f23-08deb19ccbb6
X-MS-Exchange-CrossTenant-AuthSource: TY6PR01MB17377.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 09:40:12.6835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8advSf3SpNTXUczLq9Exa4iFwJ17ZK2Qv+gHtsDu0VPsrqlyDgRb2ho8/rVtcJXt0K6curAeS32+Nlv4Zxc4v2onxGKfUos8Tp5gJpAz/tY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8821
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 May 2026 09:40:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22937

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit c1c6ab80b25c8db1e2ef5ae3ac8075d2c242ae13 ]

The existing FIELD_{GET,PREP}() macros are limited to compile-time
constants.  However, it is very common to prepare or extract bitfield
elements where the bitfield mask is not a compile-time constant.

To avoid this limitation, the AT91 clock driver and several other
drivers already have their own non-const field_{prep,get}() macros.
Make them available for general use by adding them to
<linux/bitfield.h>, and improve them slightly:
  1. Avoid evaluating macro parameters more than once,
  2. Replace "ffs() - 1" by "__ffs()",
  3. Support 64-bit use on 32-bit architectures,
  4. Wire field_{get,prep}() to FIELD_{GET,PREP}() when mask is
     actually constant.

This is deliberately not merged into the existing FIELD_{GET,PREP}()
macros, as people expressed the desire to keep stricter variants for
increased safety, or for performance critical paths.

Yury: use __mask withing new macros.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Crt Mori <cmo@melexis.com>
Acked-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Acked-by: Richard Genoud <richard.genoud@bootlin.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 include/linux/bitfield.h | 59 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index d7523f592c63..4f4d9926e478 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -17,6 +17,7 @@
  * FIELD_{GET,PREP} macros take as first parameter shifted mask
  * from which they extract the base mask and shift amount.
  * Mask must be a compilation time constant.
+ * field_{get,prep} are variants that take a non-const mask.
  *
  * Example:
  *
@@ -250,4 +251,62 @@ __MAKE_OP(64)
 #undef __MAKE_OP
 #undef ____MAKE_OP
=20
+#define __field_prep(mask, val)						\
+	({								\
+		__auto_type __mask =3D (mask);				\
+		typeof(__mask) __val =3D (val);				\
+		unsigned int __shift =3D BITS_PER_TYPE(__mask) <=3D 32 ?	\
+				       __ffs(__mask) : __ffs64(__mask);	\
+		(__val << __shift) & __mask;				\
+	})
+
+#define __field_get(mask, reg)						\
+	({								\
+		__auto_type __mask =3D (mask);				\
+		typeof(__mask) __reg =3D  (reg);				\
+		unsigned int __shift =3D BITS_PER_TYPE(__mask) <=3D 32 ?	\
+				       __ffs(__mask) : __ffs64(__mask);	\
+		(__reg & __mask) >> __shift;				\
+	})
+
+/**
+ * field_prep() - prepare a bitfield element
+ * @mask: shifted mask defining the field's length and position, must be
+ *        non-zero
+ * @val:  value to put in the field
+ *
+ * Return: field value masked and shifted to its final destination
+ *
+ * field_prep() masks and shifts up the value.  The result should be
+ * combined with other fields of the bitfield using logical OR.
+ * Unlike FIELD_PREP(), @mask is not limited to a compile-time constant.
+ * Typical usage patterns are a value stored in a table, or calculated by
+ * shifting a constant by a variable number of bits.
+ * If you want to ensure that @mask is a compile-time constant, please use
+ * FIELD_PREP() directly instead.
+ */
+#define field_prep(mask, val)						\
+	(__builtin_constant_p(mask) ? __FIELD_PREP(mask, val, "field_prep: ") \
+				    : __field_prep(mask, val))
+
+/**
+ * field_get() - extract a bitfield element
+ * @mask: shifted mask defining the field's length and position, must be
+ *        non-zero
+ * @reg:  value of entire bitfield
+ *
+ * Return: extracted field value
+ *
+ * field_get() extracts the field specified by @mask from the
+ * bitfield passed in as @reg by masking and shifting it down.
+ * Unlike FIELD_GET(), @mask is not limited to a compile-time constant.
+ * Typical usage patterns are a value stored in a table, or calculated by
+ * shifting a constant by a variable number of bits.
+ * If you want to ensure that @mask is a compile-time constant, please use
+ * FIELD_GET() directly instead.
+ */
+#define field_get(mask, reg)						\
+	(__builtin_constant_p(mask) ? __FIELD_GET(mask, reg, "field_get: ") \
+				    : __field_get(mask, reg))
+
 #endif
--=20
2.25.1


