Return-Path: <john.madieu.xa@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83911CD5BBF
	for <webhook@archiver.kernel.org>; Mon, 25 May 2026 08:00:28 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.26])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11494.1779696022261648269
 for <cip-dev@lists.cip-project.org>;
 Mon, 25 May 2026 01:00:23 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=B5rvtdYg;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.26, mailfrom: john.madieu.xa@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J0uPTsEPdWsKWmOZrkR6ZUmWvUvZFpO7GTyPOsK6refHnBgUC7Yq5Cix1kBey1AlMzR7DTeji1KEmLsv+BniTNDcuBFGLNwNdfaWAE6WaFCxgsvOsD6b8A1T9DLx9cH7yS4j8umZhVkouJYp7f5YXMcYaR6GposY9SmCQRFE7wv/kUziJRXcNHGGawiu6sR3f2XSujljpPIuS4CatI9LWNnNbxhagyTzVEDMv8hvjCLw3EfTUkjzq5jqgKXLzHY4n8QrpAQjRcCMt+b+TCBPmcc++Rw+A9c/vg3UvgeX8e696Vqp8yFR1VkAuCenVP3CVhQMrbC7MCWpdcMai3cypg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bs9p7zjZXxQ+dDJCET84QU4QmURX3SnyBM1SBzkqLdw=;
 b=GUCWrr+EXUBJGzj/vhsYPiU18hTFVavUbTMb3pbJ1YV9LFzdkJ1oQI5aRswLuWsJmR68dl8M/TEb81IZMOlVJUPkLB0FKXFA2Vx9Ie5s1hpKTf+LkRho1mxTL3wZdOplohmsLkGD9RLsExRZaCPrtYZMt2M0DBWSegagzIPqTisbqOeE3mzr2JsLUilRqa+3I6uH785KuGLk4JqoVewdc36kX8whBIUrGqMvyYdwSCdm9TX9Lji2SD2QpibUg1X+msWKk16420d0zaGESZodrKcTgOM7u2GbEZ4w+NGgJKf6yKYTLKPXWfiNaPXLmHnTP/yLepXSAiQrq24e0WNZoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bs9p7zjZXxQ+dDJCET84QU4QmURX3SnyBM1SBzkqLdw=;
 b=B5rvtdYgztw412pbusjYJ6Y83np1VDTCwsCpFrE3cSeVxjkB005LaxBM5Tcr/du0hzc9Av42fcWiKmEfz2VcBEHKEwdHCUo6iv+26Yjqb7/5utfs8CPDkIlBH9kdxJrCHhwJDMdNDpEYasPw8J21pCiBFK0j4iu2UgrbDgLSEnI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by TY7PR01MB16103.jpnprd01.prod.outlook.com (2603:1096:405:2a4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 08:00:17 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3%6]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 08:00:17 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	john.madieu@gmail.com
Subject: [PATCH 6.1.y-cip] PCI: rzg3s-host: Revert generic field helpers, use a local field_prep()
Date: Mon, 25 May 2026 07:59:16 +0000
Message-ID: <20260525075916.3817626-1-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0183.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::11) To TY6PR01MB17377.jpnprd01.prod.outlook.com
 (2603:1096:405:35b::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY6PR01MB17377:EE_|TY7PR01MB16103:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fea2d2a-d931-4539-4ec9-08deba33a8b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014|9063799003|56012099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	UWsOAhYZJBm1lrcovtcB49A6+F1s54UMOHHAo6fEDlsX5Qe7EYSE6Q8CZlqS85tUwCuGzwRBlAREoBzMYCTczTAY85Xziu+y2fR042jvqfGAHek9wrOkmhMd0HcDAGkUemU4QCfz6LPoPQOPeE/DfAQt9/Z8HDYJvScZjYS3mpbkpwVroBrYpXIcau4C0MdfTwypnZ30x84FHce5tt5Zk+NTgPXPDH2rxPgZuG5bVxzI/1BxIIwXoqFB1acETy/aeqFeL24k+8OssCIXqNnGHqkWdl4hAZnnSYBbpIJsxzl7sXIhgX5D7hbwI4qnJcufsP3HIvbT7ZwU4IvW8EBXfyT7mOPW6cOgTrYrQiiW3R4EeSe69P3WBjc7Q27zLzmV7+NdK1VGkba8uAzHQw+NGob2lHbFC7DGsNg8/xGEMFHCpy1ozK+ImQYGc17C810ycrrrlraOs9J85qytp4CAM7wyRBcJmglcLFJWpm2ui+NfnYcdQtxVmcHerXa7dUxMZiryriAyZggMQ+u3oaTtujDgjaZng/S18veocSI0JtpOg7+wv/fmD9fsFI2ldUpC5wdPE3JPhhiy0RFsoqmaTd3xgin2XPEcPCz2bCbDQoMpH0A5CTaPFzctmG9oGN742hddx1NWToLybkPc8Ejkcw38MnS7MrDTpcuYZDll2veIxFEfCFqNcA16Ob1Mzs9UR63evPV4oV43ipX7DYaey+5LFb4+nkOaYd3NzL0J4/UaE8I5wNUBwMk6VRBW3aWq
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014)(9063799003)(56012099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?aVbeRU2J+JZZwom5lwq4Oy6MwGJL7Ezm/GdpisoIDVmc/vp6PadW7SJzjn2r?=
 =?us-ascii?Q?+ofzEyNzjS+BEFS04xmAPkMsTOd1kDRC0hnxCrImY2ErZPlWo3GJzkBhpz1m?=
 =?us-ascii?Q?EpQeydI/Wr0qoyWfd89TAKa0Nw69eByNeWiVvZvk1waex7tjQDZHdnkSN9WE?=
 =?us-ascii?Q?IVU5/UhoXJY7ygTJbVHRuM7GGw1+fcZxtMGc/DNIGbMDmQCkYSIyWvNoqjEt?=
 =?us-ascii?Q?lzHxZ3vW+JRFpC+yaVJ0yzOakO59trMm8Z9++7fQdrcvkMhtQpQzo3TwP8Vt?=
 =?us-ascii?Q?QZQvTTGGWc+8CGa0gLQ21exq/V6mhbCXB1qKwL+CB1SciiY+3YgNQIPrNnss?=
 =?us-ascii?Q?L9heEznccA5uDPY17tT4GOGujVM2MBTjeJsxeNN6OJCJmWM91awm04aP8YK/?=
 =?us-ascii?Q?PlqrHUS5oUS2elhywB8agMOPR6bVG2kr5QeobsSZePiEc5meAMFRbxvJiZSP?=
 =?us-ascii?Q?zgpc2CTF0Ui3oLmfsvN1/SjYDPKrG96tYmG3Wum8+29Hvt9UZlhkmSfCGlfi?=
 =?us-ascii?Q?0yKpm4OM6iDRLIR4ohOws11xgWWK3Q+oaTsxG1/Kjx85RkMcp0r+VWJTKyDf?=
 =?us-ascii?Q?sMNP8HI7PC4dkWrT/PgLAaimG7VRFiKZ/+3lctp/KRoYJ5R46NIk26kpTVRj?=
 =?us-ascii?Q?pVQrTnFHPcRczqiPLXqtJMMm2VC/fk5QJY8W6bznbiQXSisf+fJTU+FWI63m?=
 =?us-ascii?Q?+RDqrIBdlOlYF+RmB4Yn16+wUeUuBQwGRhFS894/Dm2p0PZnXWB8J52PFZL/?=
 =?us-ascii?Q?yB4mBKPYh9ygN1pmm1cY3/X0OdllvL1UHJ/xcPcZ2orHGHqQ/rVsnFZ2cbRD?=
 =?us-ascii?Q?w708mCWdura971qqOWwmDkNc6N3YW+5CZCTEoXJx0ath2fxLcJGP5YqA5sp7?=
 =?us-ascii?Q?lqi2Piy47uvNeY6VO/oJ3Z/tjNfpG0BZLcXO92JABjxMFypRDnsCOkQ8eimy?=
 =?us-ascii?Q?8UehgIKPMFe6ciAEG4gIy0S3vQKGnM49+uGBVX7hO5BJdjBZucWf7FO5+mG7?=
 =?us-ascii?Q?pBW5De9SjbHpFwdIBWWLBdE8bXcCeuqa93nyJCB6n283PaYV3Zl95YZcuzwC?=
 =?us-ascii?Q?2eMh3Z/bh4X+knX4d4o4mo4kTC0XI1F0VXNd1Cj4WNOgS6bnF7pBFdyaJ+6N?=
 =?us-ascii?Q?XtROvmpUbh77c74gEzXgV2cGtkdjEEAsztA+JEIC5fde5QFwHkE2CL8KmLBJ?=
 =?us-ascii?Q?/UFHrJ42FnkC5dxOCKSRgSDFaCOMAvgSHZgwXbsklmXOG4f12CGz2x2kmc74?=
 =?us-ascii?Q?T5GqJDG+f7qKTG618qFdr5D3G3zLNiqXXJ2X0MXXEWW/owLguqkg2V10QrZq?=
 =?us-ascii?Q?BzDZnrRLwVn7RIM/UjkStV924QL6kjYL161lmQat0c51Dedz/4T5FbMznrvs?=
 =?us-ascii?Q?KZuD3cpPitYSTX27v1y3aa4Vs/URt6OOrM9qK5xznPRZ6wJbRktjmg+RzefD?=
 =?us-ascii?Q?0ZwTgCHjf5Jezw6rF3Zi0EkBRlmbJ5qkXw6V3QyEod7P8smUjHdC5zH+fcsK?=
 =?us-ascii?Q?qqleXezu9GAoPOqysVGnVZxdmzjyXSMJZ0NhN2AKEp2EouoajNf87uKG9E7e?=
 =?us-ascii?Q?hC+oLf12mkk1FSi4Vig5uLBfFLzToRVnMdg3xOUpAVEVdA8F2iL6cGv3746d?=
 =?us-ascii?Q?+0Xf1cJh+Oke0Wwn6tPoR9zVDUk0eFk+j4SnusW6xWNP1LFivQ+Q6rpJe6b7?=
 =?us-ascii?Q?1XJCJcjfuIoexXZO+7OYCv310oy8xB3XsCQeCIBGrCqj1foJ6m3fBUMdXnAC?=
 =?us-ascii?Q?N7/KG1biKIlb56Qn0y+3RfBSq9uwf6I=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fea2d2a-d931-4539-4ec9-08deba33a8b9
X-MS-Exchange-CrossTenant-AuthSource: TY6PR01MB17377.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 08:00:17.1661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6m7dnuwEtoTNPEQ1JDMhJN5IYAHa/oHjb/m4hyTlSA0/TeS7LO9B/2zEZsItWsCrZwXMS1NXJj6HAUhPRt7jE041rX1DRJrnXkvaYBMtLhY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB16103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 25 May 2026 08:00:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23003

Commits bd9b74372900 ("bitfield: Add non-constant field_{prep,get}()
helpers") and 8f685ab55408 ("bitfield: Add less-checking
__FIELD_{GET,PREP}()") introduced warnings, as other drivers already
carry their own local implementations.

Revert both and add a local helper instead:

  #define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 drivers/pci/controller/pcie-rzg3s-host.c |  2 +
 include/linux/bitfield.h                 | 89 ------------------------
 2 files changed, 2 insertions(+), 89 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/control=
ler/pcie-rzg3s-host.c
index 1b92371292dd..45cc2f3782ab 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -178,6 +178,8 @@
 /* Timeouts experimentally determined */
 #define RZG3S_REQ_ISSUE_TIMEOUT_US		2500
=20
+#define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
+
 /**
  * struct rzg3s_sysc_function - System Controller function descriptor
  * @offset: Register offset from the System Controller base address
diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index 3dca52ee7625..d0dfb2d86ec1 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -17,7 +17,6 @@
  * FIELD_{GET,PREP} macros take as first parameter shifted mask
  * from which they extract the base mask and shift amount.
  * Mask must be a compilation time constant.
- * field_{get,prep} are variants that take a non-const mask.
  *
  * Example:
  *
@@ -76,36 +75,6 @@
 					      (1ULL << __bf_shf(_mask))); \
 	})
=20
-#define __BF_FIELD_CHECK_MASK(_mask, _val, _pfx)			\
-	({								\
-		BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),		\
-				 _pfx "mask is not constant");		\
-		BUILD_BUG_ON_MSG((_mask) =3D=3D 0, _pfx "mask is zero");	\
-		BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?		\
-				 ~((_mask) >> __bf_shf(_mask)) &	\
-					(0 + (_val)) : 0,		\
-				 _pfx "value too large for the field"); \
-		__BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +			\
-					      (1ULL << __bf_shf(_mask))); \
-	})
-
-#define __BF_FIELD_CHECK_REG(mask, reg, pfx)				\
-	BUILD_BUG_ON_MSG(__bf_cast_unsigned(mask, mask) >		\
-			 __bf_cast_unsigned(reg, ~0ull),		\
-			 pfx "type of reg too small for mask")
-
-#define __FIELD_PREP(mask, val, pfx)					\
-	({								\
-		__BF_FIELD_CHECK_MASK(mask, val, pfx);			\
-		((typeof(mask))(val) << __bf_shf(mask)) & (mask);	\
-	})
-
-#define __FIELD_GET(mask, reg, pfx)					\
-	({								\
-		__BF_FIELD_CHECK_MASK(mask, 0U, pfx);			\
-		(typeof(mask))(((reg) & (mask)) >> __bf_shf(mask));	\
-	})
-
 /**
  * FIELD_MAX() - produce the maximum value representable by a field
  * @_mask: shifted mask defining the field's length and position
@@ -250,62 +219,4 @@ __MAKE_OP(64)
 #undef __MAKE_OP
 #undef ____MAKE_OP
=20
-#define __field_prep(mask, val)						\
-	({								\
-		__auto_type __mask =3D (mask);				\
-		typeof(__mask) __val =3D (val);				\
-		unsigned int __shift =3D BITS_PER_TYPE(__mask) <=3D 32 ?	\
-				       __ffs(__mask) : __ffs64(__mask);	\
-		(__val << __shift) & __mask;				\
-	})
-
-#define __field_get(mask, reg)						\
-	({								\
-		__auto_type __mask =3D (mask);				\
-		typeof(__mask) __reg =3D  (reg);				\
-		unsigned int __shift =3D BITS_PER_TYPE(__mask) <=3D 32 ?	\
-				       __ffs(__mask) : __ffs64(__mask);	\
-		(__reg & __mask) >> __shift;				\
-	})
-
-/**
- * field_prep() - prepare a bitfield element
- * @mask: shifted mask defining the field's length and position, must be
- *        non-zero
- * @val:  value to put in the field
- *
- * Return: field value masked and shifted to its final destination
- *
- * field_prep() masks and shifts up the value.  The result should be
- * combined with other fields of the bitfield using logical OR.
- * Unlike FIELD_PREP(), @mask is not limited to a compile-time constant.
- * Typical usage patterns are a value stored in a table, or calculated by
- * shifting a constant by a variable number of bits.
- * If you want to ensure that @mask is a compile-time constant, please use
- * FIELD_PREP() directly instead.
- */
-#define field_prep(mask, val)						\
-	(__builtin_constant_p(mask) ? __FIELD_PREP(mask, val, "field_prep: ") \
-				    : __field_prep(mask, val))
-
-/**
- * field_get() - extract a bitfield element
- * @mask: shifted mask defining the field's length and position, must be
- *        non-zero
- * @reg:  value of entire bitfield
- *
- * Return: extracted field value
- *
- * field_get() extracts the field specified by @mask from the
- * bitfield passed in as @reg by masking and shifting it down.
- * Unlike FIELD_GET(), @mask is not limited to a compile-time constant.
- * Typical usage patterns are a value stored in a table, or calculated by
- * shifting a constant by a variable number of bits.
- * If you want to ensure that @mask is a compile-time constant, please use
- * FIELD_GET() directly instead.
- */
-#define field_get(mask, reg)						\
-	(__builtin_constant_p(mask) ? __FIELD_GET(mask, reg, "field_get: ") \
-				    : __field_get(mask, reg))
-
 #endif
--=20
2.25.1


