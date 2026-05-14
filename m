Return-Path: <john.madieu.xa@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E1CCD4F25
	for <webhook@archiver.kernel.org>; Thu, 14 May 2026 09:42:34 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.0])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7011.1778751752536792466
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 May 2026 02:42:32 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=VGwSKq05;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.0, mailfrom: john.madieu.xa@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PMQ2bbU3PFeA9c+6DG3gEUKwW+X0id3lyodmqTzFSiT+gYEvN9wXE51tbaiN4kQmcUQ/FObne7iahLemTbs7P6ecqZh9MF48+kyBCFLyf8ChyZc9Q3Y/aIV7LFKAEK7wkojv5A0tn5/TtE/zF1ixmWOxmwDPpcZeoTXm2kADPG6I/hZ1zs6Og4QdoF9DwXEvFAwALjBG4QkcWGxfSeDdbf71n6dcWn2QcOtSeXkQ1YfwEMqJn7WOthS5FlKUxHGGS2zQau5Kap4q9MC5Z6vzz15i9qzz5E/bTzi87kEMn5wm9mt5KlevUI329uLuW4vLdNCMJO5hpD2XANhUS2dDdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ldDg5aLoA/HVt69HPoLL8D23rLr8kbh07SwMp4eQMIQ=;
 b=hpSzm17KmsiAcszxRjN+7YSMwxaxcs030wHpfLIIGE7WCDWdHluv6Ax6U61eHzaJblVRDZ8Ok9koUkqdnX3xHSkyZ1rG71qTgutEykVVdSBKSegnoThqCOqrChK9ZCUsL6ra/oZ/Cny3hnS5g2NhPX85ReLS08GaiVdTP5ikHB2plNZosJ9t93zm4tka/mMaXZSnSFv1fF/KsCszS7bwuSX6lC2iwCI2VheaEZg+3yZnEP3d7cWC6Gf52CPh1ZJj/7IQxL+jHfp9UBgtgC5YOHhBsj4hgXeHzjRIPlyNnsAufhl8njuGTpMw5Xn0VeA2UrSmq95/7NnNiWGo4F5JEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ldDg5aLoA/HVt69HPoLL8D23rLr8kbh07SwMp4eQMIQ=;
 b=VGwSKq05e7+Gs92spvQZfUVZEeYPIeEZWOAOtHyGLJvSiRQFeL6tNL01X34GJZSOFKF7/N7zxJSCIPG5529428V/gmEaW8CCDAXqaCOlcbA3yHaVbzUFRFoNpmusA4Vto8X1kLSjXP3eZfuFkdjASW7fVtPBEXd1iGMV+PF9pVQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by TY4PR01MB13906.jpnprd01.prod.outlook.com (2603:1096:405:1fc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 09:42:30 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3%6]) with mapi id 15.20.9891.021; Thu, 14 May 2026
 09:42:30 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	john.madieu@gmail.com
Subject: [PATCH 6.1.y-cip 03/17] bitfield: Add non-constant field_{prep,get}() helpers
Date: Thu, 14 May 2026 09:41:38 +0000
Message-ID: <20260514094152.2215176-4-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260514094152.2215176-1-john.madieu.xa@bp.renesas.com>
References: <20260514094152.2215176-1-john.madieu.xa@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: PR1P264CA0025.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19f::12) To TY6PR01MB17377.jpnprd01.prod.outlook.com
 (2603:1096:405:35b::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY6PR01MB17377:EE_|TY4PR01MB13906:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ebc1869-1619-4f1a-f80b-08deb19d1d93
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|11063799003|3023799003|18002099003|56012099003|22082099003|9063799003|38350700014;
X-Microsoft-Antispam-Message-Info: 
	CDhtSHJ9C3zL7n1cYqlKeGo6pofq/aRaGcq9GIWVsCGBXC6gyaYu/jNq8jpKYCbXhOpmZHpcDMs64FoEKHnwoWDdM0RaQ/poqgKRdVIPshbP2eLV9vU4dzyBEMQsBJ/skxYcn1Sk38gR2tTA10laT7Ej5ckDQUUNSnGsYH4sWj1dGCrg74faIOH3lcOz6ySc9yBk51KexiGAeWzr44XbIX+dXZNmFoTcWo5NNyuaW+zcFWg7jv7D+kUz5WEn6f6OJVn776g0YvHGhLlrG06Ma2qMm7/5r2kIBx/bBBVvXNwzfCrSgrP75AU+KEJdUfpwihxQ4kzgRt1/AGz8P1aq71z5reC+i+9EXo1/OT3nXm/xQujISX671qskasJM8lreiWibuxzaKwy5z7e+GWR7ierBzivbT2FZ+YojGHHSE8g4G0ZXojlK/R3yK5oNZW53ORvV7MHbdMsyzptiVkJNhMb2edlKSB0EnwCirm4FRBjqAs+Lkdh03irfZdHhN4tLroblY4fioo1uVinA15uqEHzXGwwBIWkMIPcxwyIFkh3E8nfWtIotNkWAFA/U9s9RxF/2oBOLZValn20B2Q/UG0u6Pax+wW/UvXtH1XUCKJA0HP1eJ93EpHqydi64Ia1fXQW89UkaMAtPsch3E8mgJdYatkFoVW5aiPvBfBKfGWlF3k3eAMi8OlKGAE8Ssf5RsaUZ+268YdLtEmVLMfIJfzDSsEHNQU5vG/S9rYQR1Gj2fpUE8Ab+ftT62mql1gqm
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(11063799003)(3023799003)(18002099003)(56012099003)(22082099003)(9063799003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?QgXRWm81hbN9pkXUaHV7UeTESHZN0FZbeRyHMw1snTXlYz90SRJerfxQrIWu?=
 =?us-ascii?Q?whYWgfonfXul259Z0tD1SiyShdWXnl5PJr2NSW+GIoKjBW0dEkBu2qsFBBl3?=
 =?us-ascii?Q?O+I964sMPY/LNMRFkNSEdPGrtLAnSr0eg4Ckfjwetra5khZn1wTiyuPwq9XE?=
 =?us-ascii?Q?IYoaT1+8Xdr1njcZVgGMYGsgngnmfvdXGBHFoczGyrqdOIlfDXHS8vh2gFnL?=
 =?us-ascii?Q?G0LwMM32JitiAT4f+I4VD1pxvQBvw+68N9Cto2jmmhhtiW3g/z5RBMU36dv6?=
 =?us-ascii?Q?s45iRXBCuOvR6da5IxKLD13BzISzBEEF0xJltSvI3+rQ1mCxQgxDwRMvw4qs?=
 =?us-ascii?Q?lYQwzhqBQofnvFmGyM8AAWgMKc3X24TnJN3OkH/hNbGYRTtfq5Zytckjigqh?=
 =?us-ascii?Q?3Rkck9I2rhH0jccE+kwoNRsMQcqwKMJF+75rKAMe9hMkytQCzNtBwFREM8Wq?=
 =?us-ascii?Q?xAGosy7vRiOLo4O87B0h0HoRLY2dPin9ceKEMLczPR1cjTonFyC2KypgkyzU?=
 =?us-ascii?Q?FeeqT2TVjbgkJE7qgNxk2ns2cwWt+fxm7XWe3RccxC5/EYy3MitrMXT5gjIL?=
 =?us-ascii?Q?jTe550WokxkCw5ca17YrG6lkGvwSpYUXtoKlf67bAeO3xZUyypRYbzr4vEUD?=
 =?us-ascii?Q?9B3aeT7rA2iLGACST8zJhzuY2L+sucdY0iMOxxWTjBpOYRB9+wTfYME+Mt9A?=
 =?us-ascii?Q?3Q7iu0wrnl04pKEuje2ImgnHE0kcSIlD0x/aadbvaen1o+wvXVlVAxBvNxVU?=
 =?us-ascii?Q?Rsbt6ZGH+Ef8oy9h72aYmw+PUebuSFh/d10yonsVNKf8FdeI0U8CIZkSP8bu?=
 =?us-ascii?Q?0VSwTZv5JGhPUy+CxX5wfw5FiVtylsBO2/MySaLBR0wgnEVoAFvcRfKNgdN0?=
 =?us-ascii?Q?pjEj2Ocl3MZRwd1RyV3WsefsWHVmZOe1+7XGeUv6MjQsghsKdrgKaYMUlAOP?=
 =?us-ascii?Q?lWUFukXdiswOHAeDPPdCGnqAgGtZgq8DYT8UPGVnvkaIi27emVXwsYPUp3f5?=
 =?us-ascii?Q?QMlLgjvKGeavzZODLaMoe9H/ElRwCP5uCgj7U2gjit0xEVvScelKW4xTGY/6?=
 =?us-ascii?Q?3ddskRYlHmix/4skKIb2nTOm9Jk1TdB4eCSA0zuIHUQXr2y72bNgj6HLUtVS?=
 =?us-ascii?Q?wtNmoUgkyd4DN0otwXD+xBnGZyKwf4ERSoVuzeHeTJlRcGRYOHVNfJnVCAUf?=
 =?us-ascii?Q?IlMb4xTCmkIInjhz7feGrNr3NMedRRz/FKLABtr/Y1yPm1pWHBUBojGyUMFo?=
 =?us-ascii?Q?k6+VmisPxne6Bsal709wBxDAKAT8F1ppj8zuoJTsJin56FLI+pfEbXrgFyzy?=
 =?us-ascii?Q?74qfZ9XawAx3Ow8mqI6IkWeXKXIUS1gGPSw+LOZHUaGgKMfYkxQKRDGiVbMj?=
 =?us-ascii?Q?z4vcSawmPN3bX0wMEeA/kfSibXLlCQQKOQ8c5nz4/6SG7AYb6pIHAaXiBmnD?=
 =?us-ascii?Q?qTkvfVTjs3aIWSQejF4fCz+lYMr0lNLkCiK8Varb27Az41LpCktj/0H+bc8x?=
 =?us-ascii?Q?zNB5/POkpu6KugEANMhGzRIgI4FxDOK6/hOMq3rVw6m7411oMG9Ic25D5UE0?=
 =?us-ascii?Q?JB4jo6V3XUuYlL3NVE25twwwr6HTjis7isjjJBdLDgaq6tUyMyIRzAXFfK0u?=
 =?us-ascii?Q?mw7T0/E8k7Im2XsnPl2NUg9KmESc5mh6y6U3G291kQg1YzDxuslgq8+WK7nC?=
 =?us-ascii?Q?OtNY12PMfMhP0qQhIg4IvmVcVrcTqbdHnEtNKtnDAe2rXviXN13MUI4IpXFB?=
 =?us-ascii?Q?uNOa0a+dJUV4/BnyBMsgY0WUtldPVVQ=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ebc1869-1619-4f1a-f80b-08deb19d1d93
X-MS-Exchange-CrossTenant-AuthSource: TY6PR01MB17377.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 09:42:30.0681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dnvTkQvtbdeZV73QYV3I3XnBbAuDCGtIZdyAGAiP7DIzjFsoAidw3G2XztuI+bqBj3xviagyCzb4xTJYDketwrt2sj9l0HklTcW9LLJfaTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13906
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 May 2026 09:42:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22955

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
index 387cb0ac6ae1..3dca52ee7625 100644
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
@@ -249,4 +250,62 @@ __MAKE_OP(64)
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


