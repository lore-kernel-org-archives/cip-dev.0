Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D4BC53209
	for <webhook@archiver.kernel.org>; Mon, 27 Jul 2026 13:14:32 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.25])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.30845.1785158067014203733
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Jul 2026 06:14:28 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=Q1CPSYEs;
 spf=pass (domain: siemens.com, ip: 40.107.130.25, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j3FISmm6u4GX9avDQWwsyg0kuckeKNJlg+No2lMgiKrQhoSZ0zGlVf8yaM++3g+DA+DZ4yrCNZR/uljr3RgRVAG3Ob1dxj11UySn9l7A/khsFAZuufjsgGfwyVwngJs7LeHeQJRilT3wrVrScLv0tIhC/nS+3Ovj7P+m/x7ANG3frQntWmhvVYszm07x7MmkrigTgNKx7gwVC/VXU0FcE5WBxHRKQg58E/01ejp80i5swc71kG9WVZ+Zb1fXB3mfX2MIl9P7MlOjYPd1DN/ppgbfRAGt7ljSS2fPn8USGnnxrMX2WEJ8F+bSBOs0nM8uU2LrbG8KVuyhtadKztW3kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WW5RkT2bKU/oMkJYQlmjYDFOhqkmM9cUxOTmkqyVaHI=;
 b=dd+hZ/3KthGbpqPNh42+8Blzt/+D6kA5IFOiiuZsRSBipkATAgyFJFTahXpM8YLB1BZpPoLmHo/FA7GktMGa4eX8YLDVjNEt0oWBhsE0UHYbN5MdYeHPVSjM+w6AdmeisFF2on3ry/i5oBlKtk0ywN/tNegjDRktIShBbBrzHzVw47XtB2aKyF/gSZQB0nb9odT094MA8C0xC4n5toQ+iHrVqxN6dpKrSfsWApNrMt6ZrYvrT+NTGuMQoPr8TS8GxXGKFO8wikSe9K2M+rfHd+eXgXPcxaDtouu6j7Ue4QcP6W/APAVFKUjBp8yLyeEm6vJbuJn7plbnLVTuF3oqGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WW5RkT2bKU/oMkJYQlmjYDFOhqkmM9cUxOTmkqyVaHI=;
 b=Q1CPSYEsHNnKym3ELfj9rkGfot3StQ6lscrH6iAMzqf5bG1rs1/CiiEbzhP4hr6TKsJqotH4+HtBLDSGj9HD0A5Qo0zizUHB4EBiOPLGn9KB9p3mhTrduyMXxyTds4qAXkP8ctXJmYPcRR7Zl0i63jy7dcVuaR27/wFbEFHziHkN6mPc7EGmwUiodvilZRshySIlxi7dqbLOUV8z4etADS9tXLhQC0glBp+gwk0bc7z0BJ+eUX17gCr2TYmlRAI3i4pYfSLMeTUitG/1wzUmbK0tLbCMV+tDHwEzm+C5dsH406rgjD25L0iXIo63IYp0k+LMgS8VICxUbqz0CypLZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by AMBPR10MB9305.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:6a9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 13:14:23 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%5]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 13:14:22 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	christoph.steiger@siemens.com,
	clara.kowalsky@siemens.com
Subject: [RFC cip-dev][isar-cip-core][PATCH 13/14] Add Kconfig option to select cis-validation
Date: Mon, 27 Jul 2026 15:13:07 +0200
Message-ID: <20260727131414.76760-4-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727131414.76760-1-quirin.gylstorff@siemens.com>
References: <20260724124038.3633611-1-Quirin.Gylstorff@siemens.com>
 <20260727131414.76760-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: DUZPR01CA0088.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::14) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|AMBPR10MB9305:EE_
X-MS-Office365-Filtering-Correlation-Id: 509f98f9-ccfb-49b1-e73b-08deebe0f9a1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|18002099003|22082099003|55112099003|10067099003|56012099006|11063799006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info: 
	HuPXIkmbfwa1G5BeBSu4GT01/7pwe94YjzUNIwszeyQrwfBwAVYAgdsyrJgGiFdRG1mMfA0Gjhr5cJk5IB0mDx3EZ+KRiznuJlu9ZgoohaRduROX/lqAiYZ8U7vcZ6Z5JYkZUk2twBH/MiGlDSrejfIJsMNfeBDiYocgkvaStVAEqdvcixNTymIl0u/TWmULRbNo9FPq/hRfFjuz2vt8irCitTSp6T3G21EqC9PrNkSX7QzyzKZVXnxhXP72rk5k1eRwqZJ7GLuJqP8gH4V9DGDwhR97Ew+I5aUYKILmuFjy5KppDDCHWG6eTTjiT+wRN88uo9cr1UeykQRM4lvs7VRMhc7OLHOSe+lL4syQuVC9xoRd3ACKfRoeiqsc1nyJXKaHrk5lpthLhqRovcgrc4rNJ1Cndl8L8dbhE6cejnmi0q7O4Osg3SLHMHic5yrSvVR3VUox80FqCavifQQArYaxXcfkkN1AMq6fF+kdnpHjXTTbvJbcBLohnB50DbCqzBLBl37YIxRcFp6Vf9UyeMIpsD0+T49P/sTnLqyPqquG67zoKctLlBdmNHj90tcEDHcJ4v4q6vqIavy7Ap3NMCQ0Ruf3pH2KerEUn+NYuqdPDEqgJlx2rAlQGwlcYJpEDcwTlCLvXdehg0Yr7mLdcI6hVOoi27OVOwJ+VlMn8Oc=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(22082099003)(55112099003)(10067099003)(56012099006)(11063799006)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?a9n3k/ERmTJNTRdv1QEVi17z0hjkEMQQp0YthBdFb+DaqZmhC9oz3KgpvXKx?=
 =?us-ascii?Q?KtE6Jf13MhfakOGkS1tVz5DPoPOBeI1cqofCKYkrRHz50ftBT7Yi9Y1TucuK?=
 =?us-ascii?Q?bTVyEu/NGlZs7Xr2f+Nj8tg9bct0yE45RyPUFfPldfCUNG2JRlYML2fe12a0?=
 =?us-ascii?Q?NSC7ZdgdUPFT0C/xtltHQQqUucNhXL3nRWThdS3kNb7d2x0ZyDy/aXJQLCW1?=
 =?us-ascii?Q?YuQ+GeoWvlW4uX4nXz9XFfcy0t9AI8lPSma8QygVpsXmNkocjs4ZVcIFrWp1?=
 =?us-ascii?Q?xmSPvqwj1C1SeF8KpBFKhN05tM9ZhtK+hqwh0bCnkZFInGclSV79WgECSrUJ?=
 =?us-ascii?Q?qyQqmkYMcSgknP4gKm7z3HOKsTP+uNHKTeenMXcdETBN5UVm0a7ITghAPQjh?=
 =?us-ascii?Q?0hhu/zs8MD3Jkxrpqpb7cHuaGWU9cGSdgXuGNfdkR4BKpMY8ER+rN/Cskj4W?=
 =?us-ascii?Q?l2XWPtorzrUGce/DydwF7aNG7FRrFxqLD5vY06Ly9Opbzp7Hyv1yUf7my9uM?=
 =?us-ascii?Q?pTD2VHM2fjjBp72q2C9H9wrjl6IXfTrf6PS02kMm8C2TxFnay4pwNbt1FNkJ?=
 =?us-ascii?Q?BPfdUztpF1sQ92ROhwiD9UWywEQ8MmlXVHcmHB5QBCERQ6eEaq3jUEkN/j67?=
 =?us-ascii?Q?2sIfweareexqu0k2QX1o/syDpJjwMIK2WJ8QYvUuTpxSVO7HtPQadHafuAN+?=
 =?us-ascii?Q?JYJyc4wK9D2XrwlRvlDw0QziT8MhxjT9an5HHHEdkCKC/2brCwO+R+rzOprT?=
 =?us-ascii?Q?i/T+jBLjz6g1RaR+DpYUcb6b2l/lrpjsrh1I9m8YjCoS9PBf0cycuXUy0BJ3?=
 =?us-ascii?Q?apiM3W2oCibx4hoLTnHDtiit5lJ/wowvS9/XlYBFSzZSuEvM+mrsA5l+afcL?=
 =?us-ascii?Q?fNDLveAfQJ80xjsn93RmgogCJ5VMVpNCzeYBWB0vmKD8RQb4wVaX/DOBYEAI?=
 =?us-ascii?Q?7m4TDO8APJ7sKRepw8sHEJpw1X43F1SNFnVg/M1Li0UUkMZsvuSUaaayh6t7?=
 =?us-ascii?Q?nTRDkScqwTvzbbC4SP/z0mb5ykkVKWbf1CMd/YVdiYAn8H6kpWX8CZCSggCY?=
 =?us-ascii?Q?6O2ol1aSRd4mZl2/7QLkQsezcoW11EL/98IDFIuPKqNc4B4pmV/Uosa2kc8E?=
 =?us-ascii?Q?o0KKANN9eDTGgOE20GEMHq5M+dZI+ZZDFBwL8vbP4OWCcUIB8ZKKqBMyDA4w?=
 =?us-ascii?Q?6nXj8BHKzBWsF4retQNjE5K1cn2uOGxY+0pxJeHlQM1p6IbnBPjB/PYPFw7t?=
 =?us-ascii?Q?WgwSo0s8CzEEDcApaEyf8FUS5s1IL4QHS22roENdkJj0KcwZCsPGO0UeFnWf?=
 =?us-ascii?Q?GtVpZ/AKpH1B2tgdccyiIArsjsBrvLhYdxNcnn6EX1bk35AY761/s6w24UAJ?=
 =?us-ascii?Q?Y37WBaQScJjQwo7sxkdn3N7PWVW99YfSpUJaeMmriR5NeERvjJ0A3cq4E/C4?=
 =?us-ascii?Q?+S9y0nNqOa/v2GyS4nepNOD7pR8eYxbgUXFTROtUXUdniBjOGTjMaFcXFTZl?=
 =?us-ascii?Q?YSO+b/2m6AwOQirDbZDRVuHR6UDC4/uy8XSZTVsOeHxIzhZcP9a61gkHYjxc?=
 =?us-ascii?Q?vf3Sq8d8UO+UPmJQisP17yBZfIKM/uQbJPV7qzW+Fbj72Hfk7BxZNp6ZJqmQ?=
 =?us-ascii?Q?qYnuXUG4bZZfIxwjTDEQFUVGS826uuZYkcd1nMD07z6o2+C9rg/YfAkcy9OW?=
 =?us-ascii?Q?DgUmOPuBUgoqY65rv/xZlVzgbKQjmWyraN2FcAVS1nLV3P6/ahtkR1IOSXvs?=
 =?us-ascii?Q?8ppZSqyr8UGc8H5946fyzpgCNAVNdp8=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 509f98f9-ccfb-49b1-e73b-08deebe0f9a1
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 13:14:22.7841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VFFIs7SelYhpr98SbtqUDEskG6tWpitglj/o8Tkf+jSzhlfbwJU5NStWYuZSJRWnKg0kSZFEN1pI0pqNnf+4Z3LMBdFlH/OQpXC4wYpA8es=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR10MB9305
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Jul 2026 13:14:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23765

This is for testing the cis-validation.
The following rules are failing as the prerequisites are intentionally
not installed:
1.3.1 install sudo
3.5.1.1 enable firewall
3.5.4.1.1 net_fw_default_policy_drop
5.3.1 enable pwquality

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 Kconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Kconfig b/Kconfig
index 438234c..6790dab 100644
--- a/Kconfig
+++ b/Kconfig
@@ -364,6 +364,12 @@ config FACTORY_RESET
 	  This adds the necessary packages to request and execute a factory
 	  reset of the persistent partition. See also ./doc/README.factory-reset.=
md.
=20
+config CIS_HARDENING
+	bool "Harden image according CIS rules"
+	depends on DEBIAN_TRIXIE
+	help
+		This hardens the image according the CIS Debian Linux Benchmarks
+
 config KAS_INCLUDE_DATA_ENCRYPTION
 	string
 	default "kas/opt/encrypt-data.yml" if IMAGE_DATA_ENCRYPTION
@@ -380,6 +386,10 @@ config KAS_INCLUDE_FACTORY_RESET
 	string
 	default "kas/opt/factory-reset.yml" if FACTORY_RESET
=20
+config KAS_INCLUDE_CIS_HARDENING
+	string
+	default "kas/opt/cis-validation.yml" if CIS_HARDENING
+
 config WDOG_TIMEOUT
 	int "EFI Boot Guard watchdog timeout in seconds"
 	default 60
--=20
2.53.0


