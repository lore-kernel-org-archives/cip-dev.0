Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC637C9831E
	for <webhook@archiver.kernel.org>; Thu, 24 Sep 2026 11:36:22 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.2])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5788.1790249778074354651
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Sep 2026 04:36:20 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=S9vsPFev;
 spf=pass (domain: siemens.com, ip: 40.107.162.2, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ET54yCcYM4dmehFyaHJmE0yGGiL0DSajYxCSwkwFuJaCwZXHwGz5iqg9p+WXbvwktSkU5tF3US+0qZfa/CPM28tZ3EAZbmeOe+61T9jMFsSZZcI9TwSSfRjviviCJsi6P3G6GuPSEoczmzH47n+XZtXRJMWPFmwp5yuI45qo3hxi7LoBwuZYeu80yfeucnuzy8VgURB1JLLrLezxC/xnhYyrIw/9l4vuoPeI6FnQ524WIPevAEJjifwysE4KSUu1/s9M42ynYRx/UxsG9xrVHbyoAEUQXpPg73muXWekhygPsuZ/H9xn6x5czjv8gd9nkiUjbdcYMCTGQGlkE3rOdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xeMZWOZR6QhMXh2wStE3MXAoTAZQy3C6mGHRMdII5Sg=;
 b=BfFfwaacfSYwi0KB45W26iK/WOj65NT+MCOlFf9dusFDlnAwp+4bNkrPbUsGSns/KA0ltGcS8actNY9ybZTs3MZiaEPs8lbDGieRNIchRW69dV13t9b46X36b+828Ug8GTZ7SUrxMboo/Z/ZlyRGOUu+97WAC/Q93eet6RTzcXm4xgbRtQBtMEGiuMLy0sHg046BmlcNdiGqPE2UzpFOaAtORax1hFE11cegpHVqNyPr2Z3xBiqoawh+zGajHDsdQuMh+vetQUi1zX8Ax5Lo/S0axlCAdOF7/liFWRRK9LZsTV6QW43BxlKjJ8OvHU1aWv0Q2CMmlReHMlRPhkDsVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xeMZWOZR6QhMXh2wStE3MXAoTAZQy3C6mGHRMdII5Sg=;
 b=S9vsPFevpO0XCQ1eGhyAIS7/KQOlY6Ev2zh9ArQFW4kh/d5RAbgKpkP+Q/22iQ0L5X8nRcKRciEZmCmK9RPw6jKqjDOw+bZdFe37NKMr/y15lsOhM0m68uS9H8k9hvlzH8/DjNGEOOBtPXhNo5dLT2siOz0W5ZjTbZMzU1Apxwr5tHZfDPhQBruuMMRJAZ0Ji6tnweTYJxkCoaxKHjCE+2bEsl4BfE8QZMoHGfOThfCeDu6oYTclIgcr/FSe2ytH0k84VNbkwtGNvyo28R9UksA5gF+BYOuCP7zfTLjnaVm86DxfRPcBd6wyuSP+5j3HXVo+k3J3VSiwERGZ6B8kFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17f::18)
 by AS2PR10MB6374.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:555::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 11:36:11 +0000
Received: from AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5511:7126:a2d7:f914]) by AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5511:7126:a2d7:f914%4]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 11:36:11 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com,
	clara.kowalsky@siemens.com,
	christoph.steiger@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v5 10/13] Integrate cis-hardening into cip-core-image
Date: Thu, 24 Sep 2026 13:35:10 +0200
Message-ID: <20260924113557.3191996-11-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924113557.3191996-1-quirin.gylstorff@siemens.com>
References: <20260924113557.3191996-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::10) To AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17f::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR10MB3172:EE_|AS2PR10MB6374:EE_
X-MS-Office365-Filtering-Correlation-Id: ba420baf-3295-4beb-f8ef-08df1a30077b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	ToJ2OfDlkbPZQRK4Sju7yZeqqrN3jEvHBcZ924zLvdWhsDF+CVvdRNotegGd6kezUCpA4noc59cQFoKtXPH3lVt5kuXLuA09OFK5rx3EIy3xPhVz4hJ5WPXwrySGDXpwIpl4lhI+1iK1AEOU2Hp6mHKNdu+fn4vIyJaoEH9D5Up+sfTV2aFlRiJA4GOFtaIMlLpm+uMZTM2KfU4MiBRaU/Nt3KieSKr93aEno3iPUi9etVB9PXGD4RtUUidWR4z3FQgTHtE7CadB+9AP4JcIZ0i3wL6gnOo0HuEMAX5F4vGGuXVPRav/t/enp0yqlQg1NJuviBqYM1AKT+Fa4a8Xbz11tH+GvTASY14/6+IYxoBNZ+hTvY/1FRHI+f6UqF9n1hE5icGTxRZMuV1WXtuD6v1YnpTyJKzTU7Zy3FYMpjNxcku/MwTICoyh+/CWbeYT1f+Fk/7v21QxqS52Cw17INYP35l2KHISD3lWMl4qsz5SMCaVccWe8e1nElBZ3+dbfDGBPsIkReDBpqBHEklmKdr/I8acHsNwOlfVUl4jfcVDMN07oNXnrLHlb4+Cs7z88+6CAe5KeQxJSi8uo5kMQ4G13gQEoR35k1quTTYzFK7S4uCc26zra57il3eU4VT18LJzIVsqP33icbS5DQKRvX6BNRE/cl/IFaUaK0jFUrs=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?U8c/+j7EJIcuV18YWydLWdmBOjPqDQNaW2HutqsCmdR7346h9ZpvWHQhIUSi?=
 =?us-ascii?Q?CQc+jlqcV2QuwP+NJtb8isbMioTxkDz+NcwDCQcqrMGNpPZEAnW7P0mWR8Ic?=
 =?us-ascii?Q?0UKkeFBJdmlEqgIxbRd4y5vgNPHe4klh+LC1ME4Y2saoAWQvmulzBuWfugvf?=
 =?us-ascii?Q?BJ0MdsyOBuer+YAG2zU5SgoMZ/mMWe4/iSCV0J6XsAn0okjEJwtOrV8HqIxb?=
 =?us-ascii?Q?Tnvul1ZXjUKuIXsEJlVU+DjGeRXGkmLZAOsQ8Yij4FfFlMLjGsJnM1Dwn9ve?=
 =?us-ascii?Q?BwSPJSNeFBofafCSxSIR4c/wJhLtBtEVQUE7WIaZIzm9yIgP8N9SOjkBHGKw?=
 =?us-ascii?Q?VARw5MZvQp3b17ckdWJroPqZjVQkLOtSy2gVpumhxGXiO+Mi7UQ2EAb6SsPg?=
 =?us-ascii?Q?TN0VByHFJF+mon7cYkmSqvUf8Z9uptKH4YpPjQdOPfjsH6gxKFNhhtOrzi/g?=
 =?us-ascii?Q?NRHv7h80EQjFRj1a2thkn4rQ1DwDTEx0ZXyXHEpHnXbsO5udS9vLyJJLdNIR?=
 =?us-ascii?Q?EMfJrcviCAMgbaGlgIlG8gePdKj4tsvl3359N33iyVA12c0yTxDEL2D3S6gl?=
 =?us-ascii?Q?jQgocXk2BZtN5uIoAVT3GTC5TXKkPtK2pQYs05RcFpBCqi2v1/5ORC4O+aLx?=
 =?us-ascii?Q?JJ3MUDWmFhQUgE+OER0+qYItC1PqjoXJCu76oiILq6iVCO8IXhtiuKueIN1/?=
 =?us-ascii?Q?6AyuM6J0YjqWKknaor3NhH8H74tZSQjRrVUk7y0xEDOdtoosE1lLWcsaKepx?=
 =?us-ascii?Q?NQGCahJnWB+d0ZsPH5Vjsj9NLgGZPrvAHuBf0LiAlSbgHhWLz3rcl8W3ndS/?=
 =?us-ascii?Q?NQP9limBjHt3sPDSlcBzdCDmoeCqgFnS+jr8dVPZnnK6SrG2WhuxvQi/y7fR?=
 =?us-ascii?Q?Hyul1ug4sVbXd+qZg0NcQeJiO0/M5yvFfDRTvWKEDLyS58MpwZA3ddw0oD04?=
 =?us-ascii?Q?pBWvUG1BVcn8yo3kK2jIGOrz1yCwlzQAcjeCBpfyvsKdcNi3x6WfDfLI++T6?=
 =?us-ascii?Q?uE8UvPKuXodx5pEIxxHu3Gx/4Z4YgriJpE5nGv3r1Z24rdYUT3J+ftPtnpmZ?=
 =?us-ascii?Q?wmvAuFFcjYG/8voJGxlyTbusxQRGLbkUPR2ZxbwkpeUGjY8FooM2LKcNvCOS?=
 =?us-ascii?Q?3cvvFSlnegkD5DP126MoCeOjiwXt4XsptmpX4kfPhZbjVlvykS4e+0d6ZPkX?=
 =?us-ascii?Q?gZGwxMXTkxq/iyXTE1WRzfkXrM7NPUGHJY/6GnU5A/Lf0yKC4gWXYfNyYPji?=
 =?us-ascii?Q?iVBOIktKOrbK7eOVnQvgP6E0IcwFc9lAlHuBHQi8wS8mi1EMRUHIX+FMPwgO?=
 =?us-ascii?Q?g2g2DKqKQywJH0lcKBl7aIW58v7A3DoYxb58pVe1Ctpn/wy1IPNSQhJ2dUBL?=
 =?us-ascii?Q?zxOem79GkAorgiFRqHqwNm4VsWe7j8aHlBZJvWs7NlfYkMyxb4mdx00h15h/?=
 =?us-ascii?Q?z0hL4kc2YDvY/XwfCVtLIAzuUfxDhy33WYpQ6jOyi75yJDiFHjqDDBG5XtWi?=
 =?us-ascii?Q?M6vK0H4+j/rrwBZ3CxAqh2vlSMSu6C0bfuv84Z6BbCuZk5t9anFAiMWdDCBr?=
 =?us-ascii?Q?PZR54Fz1V2FzfNTeUeoxAwqcY+/hxlJ8LUIhv4x07YxPUmtZUFrmWuTtzu13?=
 =?us-ascii?Q?0hHKlNFly5nJaOdd/Tx+7cB0LuizzULF32uSM59tpHq1jIQl9opQErLw7XrV?=
 =?us-ascii?Q?PXkyT8QaFcKtlpvH9e2FVbNazV9RRzshLWTFcuIekDP/HkXtbCUTf+buXy9d?=
 =?us-ascii?Q?+yW/qO0+T8avJ7Vn3za5I1RXxl9CjJ4=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba420baf-3295-4beb-f8ef-08df1a30077b
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 11:36:09.7263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OaP2EHFGk6wTT+BNx+msowf7r6Q54GebvgFputlIWykKC2aHqs2ChnvZslLs4QdwMDfgpdGKc1ORAjya8Zl63WQwcxwJUAEf51RsfeLtCKk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6374
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Sep 2026 11:36:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24324

If CIP_CIS_HARDENING is set, inherit the cis-hardening class, install
the hardening configuration and apply the kernel hardening to linux-cip.
If CIP_CIS_HARDENING_VALIDATION is set, additionally install the
runtime validation.

Co-Authored-by: Clara Kowalsky <clara.kowalsky@siemens.com>
Co-Authored-by: Felix Moessbauer <felix.moessbauer@siemens.com>
Co-Authored-by: Christoph Steiger <christoph.steiger@siemens.com>
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-core/images/cip-core-image.inc    | 3 +++
 recipes-kernel/linux/linux-cip-common.inc | 1 +
 2 files changed, 4 insertions(+)

diff --git a/recipes-core/images/cip-core-image.inc b/recipes-core/images/c=
ip-core-image.inc
index f6162cd7..de4c5ac6 100644
--- a/recipes-core/images/cip-core-image.inc
+++ b/recipes-core/images/cip-core-image.inc
@@ -10,7 +10,10 @@
 #
=20
 inherit image
+inherit_defer ${@'cis-hardening' if bb.utils.to_boolean(d.getVar('CIP_CIS_=
HARDENING')) else ''}
=20
 IMAGE_INSTALL:append:factory-reset =3D "factory-reset-helper"
+IMAGE_INSTALL:append =3D "${@' cip-cis-rules-config-${MACHINE}' if bb.util=
s.to_boolean(d.getVar('CIP_CIS_HARDENING')) else ''}"
+IMAGE_INSTALL:append =3D "${@' cis-validation' if bb.utils.to_boolean(d.ge=
tVar('CIP_CIS_HARDENING_VALIDATION')) else ''}"
=20
 ISAR_RELEASE_CMD =3D "git -C ${LAYERDIR_cip-core} describe --tags --dirty =
--always --match 'v[0-9].[0-9]*'"
diff --git a/recipes-kernel/linux/linux-cip-common.inc b/recipes-kernel/lin=
ux/linux-cip-common.inc
index 65335238..25197910 100644
--- a/recipes-kernel/linux/linux-cip-common.inc
+++ b/recipes-kernel/linux/linux-cip-common.inc
@@ -16,6 +16,7 @@ inherit linux-kernel
 MAINTAINER =3D "cip-dev <cip-dev@lists.cip-project.org>"
=20
 require recipes-kernel/linux/cip-kernel-config.inc
+require recipes-kernel/linux/kernel-hardening.inc
=20
 KERNEL_CONFIG_FRAGMENTS:append =3D "${@(' ' + d.getVar('RT_FRAGMENT')) if =
d.getVar('KERNEL_NAME') =3D=3D 'cip-rt' else ''}"
=20
--=20
2.55.0


