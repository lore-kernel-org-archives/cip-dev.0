Return-Path: <john.madieu.xa@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4D0CD5BC0
	for <webhook@archiver.kernel.org>; Mon, 25 May 2026 08:02:28 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.55])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11522.1779696140449951278
 for <cip-dev@lists.cip-project.org>;
 Mon, 25 May 2026 01:02:20 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=vTlUSTQB;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.55, mailfrom: john.madieu.xa@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SNs9G7dJPOsuYu9VPIa6ZF/jWEaMnTi5S6isr+M50d1U88KdcRxNIf1hgHjqZxNhKI4SkM6mBEJl5p58b/lOwIUVGb7OsIw6kFkfblj9hG7wUylidko4VkIZYaIyfB2/jcM+0hbH/+sUqdReamT12bYIjb4BYkJkCeXwnSHqdHtGnmUwNlNBTYT8o1J5PGH3xPG3gAHYRaVuf3yBX3QutVa9cdYT2nOczIpZjzqnnkgbd05tat5iSXUNBYJEEcqTU6WCjyAOq7KHw30QLy8RPrJwom29XTROUL2Gn9E0dcosPP9wPGSritoCy/Hx5IZsyphHxFtFhLCIxd5eLZWXZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/zcbvHG0U+14nwSLGhjTpXQwrfbFitryQ/0yvKrQnUY=;
 b=X4QSONAd3pGcpFdWfBGOHiXl3yOiMIdSe2zgeqS7pOk8bZyURwRlScSA4NBh20OoKgxyyhMBhphXuG5S9foGPaR0oqr4UdJHKMBV3IYkqhJjDHcC2Fl5WHLMt4RgveiYqkN3swn69g2y3+UHtg0/8ER/2+4mnm7Qj+5u+twTXmt8dDT+15YblnFzooV6y1QuebCXti+u5jHznw9bpnTIqRCOnb7wjk7dr2AGyKbyk1iprrU+7fC2lkbKyVWWS7hjqs7vgVt7pFceZnGzgO/cukTTpdEJrilWttpt24Pyv0090OQdvBZCEn6xmM73zJ9WQlQ0oFXHcnxFKqBMeJ4MDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zcbvHG0U+14nwSLGhjTpXQwrfbFitryQ/0yvKrQnUY=;
 b=vTlUSTQBkm8mAPyX/pL5ogwmNBiKK00TeUOHJjte3c7pO6nd3FZDiLJE63lpRy5UwSqgMlJmNkQUipC1mS3cu0wcboRUBOL3i5Cb+pe51Xroy5jU/vWdsq3VvKlOKWRTlbFFrV+6+q9GMWX43dqFYrEebX3Q9AcK7UTAIkIFp+w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by OS7PR01MB16927.jpnprd01.prod.outlook.com (2603:1096:604:41e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 08:02:15 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3%6]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 08:02:15 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	john.madieu@gmail.com
Subject: [PATCH 6.12.y-cip] PCI: rzg3s-host: Revert generic field helpers, use a local field_prep()
Date: Mon, 25 May 2026 08:00:34 +0000
Message-ID: <20260525080034.3818992-1-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0147.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:377::7) To TY6PR01MB17377.jpnprd01.prod.outlook.com
 (2603:1096:405:35b::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY6PR01MB17377:EE_|OS7PR01MB16927:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c669498-531b-47e6-b2db-08deba33ef4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|18002099003|56012099003|9063799003|38350700014|11063799006;
X-Microsoft-Antispam-Message-Info: 
	mm4p3R2+6xlyyvTSrFALU6aqGYC4tKdx/Hjpyx2KIfOdvDfJpfW/jVrJoADQ5GVg2Z1sVJLU4xK2u8S8tAbdE20bblg+DWUtsX5+TK+3E+/mRRflCpOyZIs38Or23SwpwMUHiqNu2G5aymyPlBscyqmxwgSphlOFeahzj71Fs5WpiKTn1RxTSEu0SUXrcxdBFP5di1PZhv1kRCF3t/OW6MknNCipnl85hx36+430axT2kONOXokmMr4wjl4jLsxgh7289xGdWyEGsOCXzsRwhe5eXZF8fYqbVr4j4yjciP78e00vMNBDoVoTfzkvX9M+gujGDeSyHP9Y19i5V6ll2blzuKb5Ayfwl5Vuy2c3+6y/+JSPs2jQdEvaCvvV3eH5nHYPtYTFOJcPXv+9BubqLhGc7ssOvsupcjC9kesAl1QnjckykGhSv/CfvaKjHqULTtc14b2aK7SeGVyRdhQc0u11vESUsi5AzeHWbxU+zh7UsNUe3+wpd2X75rnOWnP6ObeHPIz4XIahAN8zGn6HtaoyKCny4rTiFcQ0StS/QSTOFFLBn6x6bIgPihQUNqBqCrs4BlkHbRIgqrtxawTUOf3525N7W2i2UR9E0vP7BCJIy4fUMAgIvwfkuGZVtsm7+RxDE8R9JdPctMQR5G9sn5MpT1XDLHT8U3eL8qfoAe7zBcPXd6CGON0sPpyx/XMhSuAc8zX5M6qAdNODLg491a/1jaXmyefBBzO8+cr/ffkrdor3byltE27ya9H/rN4Y
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(18002099003)(56012099003)(9063799003)(38350700014)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?b/a6JFgwOjUJlnv3Yl2l/13wd4vByn6fvDMhAmw3vUzSu0tEc8S1VMRr4eSn?=
 =?us-ascii?Q?61VxwUmaWNFHlGUBzkOfLWrzGoBtDHkdNtz+xn8fXdJL+JpCblBerivdF7Dl?=
 =?us-ascii?Q?cVZg+qJe9oB21fEhon4zQgSnX/9UeyFHiwHI0hzrjukP812f0kCvXR+j9aYG?=
 =?us-ascii?Q?PlyCSJxVNQVcusn8J6XJ636R3moN+aW8P59qrTu0buP9dKgBWsvV+amLmtaL?=
 =?us-ascii?Q?nzyCpRZENzebn+KxPVCfJ+qtI241MZRbP/9yQNoDh+2iNVrzg7dENBwHCr6F?=
 =?us-ascii?Q?M5w78NIWEuJV4HjuuzNhpiHwOK3AUP3h3KnwWU1R+4HJ2u+B5UxoW+AsQ9d0?=
 =?us-ascii?Q?66WLjyWveqW6Q+lNxz7MRoZvN4AtoniAMLFN1Y+6mJIMhIGDD8so7ZjSGp+L?=
 =?us-ascii?Q?GblkUhBR4LNTDVZNCJedhJMPuWA8rYUfEpigzp00Wwkcr/itN8/SLxraxAoI?=
 =?us-ascii?Q?7X0PhMVik+/LhU5e1BvbRqzaqw5DC4/7hpIuW7ek+lI/taew3cLeIpKLNwd3?=
 =?us-ascii?Q?btBtAFXmwPEEYqQ3sMmRsuaV61iqDkFUres3maEORIqqdNKbm4pI4RbpAGdr?=
 =?us-ascii?Q?PcUfskF0ZQlDbq5YUAfxh+xFqd76kTEoywvu7FUJXZi8buGcZe+81mDGcT0f?=
 =?us-ascii?Q?SUQY1UTztgelCu6nQT5QwHis++36YqzXNjCydsDz4orwKrcE0lqbImGagiZ5?=
 =?us-ascii?Q?m+ripbgznsDdPuPB5ssCxLJCHETe6Erz4BTGQiRMN213B3YPm2Fa8ZKbHZij?=
 =?us-ascii?Q?72nEg5aV32VZ/TCQKGx1I7ZtbY9bUb8cjTGaIZx7h/Bvf2x7ht3S+aB4uSzx?=
 =?us-ascii?Q?XQ6LYMIszMbt158eNNnPVcJW4U/W1O7ki0Og+7O9WOm/LjIQK4JCsGuRpQSg?=
 =?us-ascii?Q?qoCxnxxEO4N+DU3Cm3LKFQY3zQoTdb+kYauyBB2zleHcj71Mrp+HOzaYJ9ju?=
 =?us-ascii?Q?8oU1kFBhrvWQhwg7I6FaBU0eCvH2speurRSTBI4AduYT7MHNl0V1pwuLRWH5?=
 =?us-ascii?Q?ebP0f8NpLgVAHe0HNL61M++SIYxZC9FyGX6Hy/WNTCUlaJVxBt8lhHnRCclB?=
 =?us-ascii?Q?5NPZVtVnXhOB7lDZFfgKR+zM551R5rA4PljXAJH3Btsf31rP+irtxEKmlNaX?=
 =?us-ascii?Q?7QmzLTtf1RHeLfCHp6Y05mVM0+2iYcizTK4mlEwIoPOD+y6K8mMogjJ1RHPj?=
 =?us-ascii?Q?9oUdPWuOjF1+MN8mwCGF3x9Ybi7nO64LQBQnzaJv17Oqc+NA2b+9i6kxr7xd?=
 =?us-ascii?Q?3fGybLvAmKL+g/Ksam/Zu6dA8kgF/i79PnjQRk3gEAaNQA7D4XjKXl6/epWV?=
 =?us-ascii?Q?H6zOpr6UA033fk2/Uu9iB7ZKuOpSWAm7PYYZeDzXhDlze9er+M+vaMDG9E9h?=
 =?us-ascii?Q?ZcUDREtXO7sGWClxGEPwJ9RIBOfcRRbKeaUeg4KvNPNsUuoOb6DuKZtZrjrx?=
 =?us-ascii?Q?PaAVMUQkPASG+GpGmA2jAQ6kuEi/sh+jwIC+85bnCDOQDncb+euVfz5Ki4XF?=
 =?us-ascii?Q?t90v4hu2TBXzh1ivczMpSXHysHPZroTJXJmueTq+d1Kw1ABYZCA8G6DvkgWe?=
 =?us-ascii?Q?kg1hqsS2QlLvzBbyJMXxxEnZIeid0h2jicAmZkOjoQVVnDyLIRihjRdIuTEn?=
 =?us-ascii?Q?bQeKvF5KRwnKGLs+hBoaZ2JOeSnsf4GbWSuC+kTtsUtTWIEAZBz2k06otpIH?=
 =?us-ascii?Q?H2JncPTr9jJpjJ4kWiW2+iRfiqy0069PyLpB/pGHE21rGgH4MpcbFX8jOVCM?=
 =?us-ascii?Q?vu4exYJY/3qLhCzTrQE9Fm+HURUSV7E=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c669498-531b-47e6-b2db-08deba33ef4d
X-MS-Exchange-CrossTenant-AuthSource: TY6PR01MB17377.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 08:02:15.7301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BPJg8jdHzCZQcHuZfzJtYDGtD3AYvNJ4S8pyp6LtbX1lJtm9b3HoZUc+S1CiKJrDAh578HvGTR15FUNfFYUV14HMdfvzI6EE7hJroBbsUmk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB16927
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 25 May 2026 08:02:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23004

Commits 10566a8001e0 ("bitfield: Add non-constant field_{prep,get}()
helpers") and 32b1a8f287d5 ("bitfield: Add less-checking
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
index 4f4d9926e478..6d9a53db54b6 100644
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
@@ -77,36 +76,6 @@
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
@@ -251,62 +220,4 @@ __MAKE_OP(64)
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


