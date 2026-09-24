Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B631C9831D
	for <webhook@archiver.kernel.org>; Thu, 24 Sep 2026 11:39:04 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.38])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5867.1790249937042799224
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Sep 2026 04:39:01 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=MtmCUJE6;
 spf=pass (domain: siemens.com, ip: 52.101.84.38, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WYH5F7Ww6Kuqn53KmH9+/6qtbAjQBJnX3HjVMZ/+WMX1gIeQylXaKFsMa7hb6j66pba5OKYi/LDn5jk3nklIA5wAarNOwVIfcHoPyBPMd+AWPaHQRBELvVqKS0vSi0Ol9wYKgwBH6BifzVmxqwN/F0gPA/1iUivN0KDyH0jQv9LEqAe3L46YW8lIYn05AUNe2wd6Sk881JiH0kGzBbjJwNp+qnWD/W3x/cdFNdu2BwzYkkSoRuYjotu8HCYZWmwc6ftI1DrOXdIcPUdWIdXQu9ueU+Q5/B53eplL9cY4EsBV/Yy5Dgq3J/R5FHEwURW5K0WMr/1N4RvQmj9QHz3gRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XpE8y42LuywxoakwEM7Pv4Z/1rNyQdywbvZGu8arJ+0=;
 b=Azj9Fm44dzATaL8E+ZVd+FdtZLvyiDQUj0GGAbftj6EOh0oCw5tlRp2EPGHORafdt2KT59M6KEI8OF3x74zdhf9ttOhE1zM/mphG28/dwI8AAj8dRsQo6ixfrdqevdacnj3Kv+z8DlKREM3QwbzxjpAVxxNKK132fbp9kbDNSdpcBiuJkHJV+rn7td7MgI3/bNq/oYVl0P+4W4404PpV1V+sWs68c7dx5Pd1oebO2/IgYjYZPjRMSXaPuPy6hzoKwI/GBaYqh58kMplYaEIyD+JBqn/qGbae0gKNuWUOJqNLYJkjHJZfEQafXMu17k14iUiDfpLBAXIbEoLlbxjFqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XpE8y42LuywxoakwEM7Pv4Z/1rNyQdywbvZGu8arJ+0=;
 b=MtmCUJE64Efhr2Xo4bjg+lQf+37K++GRW1689jQ7mp+6kHtlkGXMTzrfd1XL4Ketw9F8/2u9DRxDZhWzbsAFt8eQo/jtXgqSUbG/wkgve6ewiuTrmd2TAfXtm5fi7153VMgk1liHx7NOTamueKlBPGwGSEjbQlZATPoZhyQJ3GIxvnGBhzcXfFQli6DHoXvD0b0CcO72oLd9s+2npzdvNpMptdfkaKaEVVKWdmDdYvFNauKqtHjVgNu0yorh5n2lul19JaF+JAglbZqUp+MKE+Ovddjdo9Yf6jvw2lybXOav8F6mU0G+KWk+NLYDDX6m0wSrgKV20DOynByw3JJFzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17f::18)
 by PAWPR10MB7769.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:34f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 11:38:53 +0000
Received: from AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5511:7126:a2d7:f914]) by AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5511:7126:a2d7:f914%4]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 11:38:51 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	alexander.heinisch@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v4 1/4] initramfs-factory-reset: Ensure that '0' disables the TPM clear instead of enabling it
Date: Thu, 24 Sep 2026 13:38:33 +0200
Message-ID: <20260924113844.3192747-2-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924113844.3192747-1-quirin.gylstorff@siemens.com>
References: <20260924113844.3192747-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0087.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::12) To AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17f::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR10MB3172:EE_|PAWPR10MB7769:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cad8610-45f7-429f-e66c-08df1a30677c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|10067099003|56012099006|6133799003|11063799006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	7lq0HVkCM2wDy6pSgtK93Sv7+RNi7L6Ebh+07gAlmJMUHCgKc2O0UwFQJclod7sjsw+S4SJGRExTn1PKoNCGI7gKYZJ/Y4naz4KQTytZUYy0g3Rk/ittQzCWxSI0Fj8Inwd4jd+IJBl0eazJPd8gO6Nbm+b2+9kciYVz+JLlrYTAsYaHL+SQssLlz3+jNT6U9T6kHxVtPTkoFhsQDOiRdncF8PpAoGCB7AeVBhsytj74PvNNtQU4lD8ozYKvljFk/cQ9t0/RYERa0ZVYMj7TUzz7l9RZ49wbU8sJBkuHGzxoCGPDt65slToZ6oCA8ZAsO/l+8Wgkte9g8VbTZCKb7BWmYeeXdw/yFJPBEKLhcWVvHDvVZjuLqhA0ameD6vgAIgcgPmWfqjizT+HxGhUzLlImwJGd+3Ng4nWwUi7Gms53wvU9xLPYNoD39v7fM59kuQV2djMyWyMDNPV3sI+MawrAUlPwBzeKI2b+/4AT5XOc8O8cwPdGfTXFIyFRb8gjOlD/wgZPetaaQ3nTkMmzL68cnGuK0oPN88S8QfoN8eqeHsjty0MglNnrqZFxZBWU/RuNmyCQqhVbRVuzw7C6l4gYsr3TaDprLp2CXlV767R3LjmfLJ5cR14BVxIRqpgXal17suIFxoexbaUvnhBBlatUDgl0li5yCh166vCdUiA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(56012099006)(6133799003)(11063799006)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?DAXKPkWYoVfx5ltndN6M4LNaBSOVUWs1d5sElyeQmDCdFS1XCB62kcTB3sOB?=
 =?us-ascii?Q?bhhi6XCl65bHupLXbLKsO+xeXKHpnw1Fr6ZzEmEmyaD2KoDcg3lAyYTNsjUR?=
 =?us-ascii?Q?GQGGC06REYvhAxKlRQGzY8IbD1GZ1wFNH9cQqQaR8bJCQATu2ETCS3L0Th7q?=
 =?us-ascii?Q?+3J4Bk4Bdunq87sOwTJP9h/69WonOx/16mGuegBm/JC43MefGPvwfABvBRug?=
 =?us-ascii?Q?dnHf6PQVolxAJuQ9t5Oi8HC5MWJaWPlbqmzBMyWYsSjrM4uoeH3UrwwqXka1?=
 =?us-ascii?Q?8ITZmIOpv9mFYZcE67BTgqIACOySqDxv7j1A0x+aU3HwUV8jPGpCIESFF+kc?=
 =?us-ascii?Q?ocG4yTdHftbj/6GdowpDg05Lyl3UW/O6yEfEosPuAEj4njJwzGKqiZN9e2Fm?=
 =?us-ascii?Q?wASllwmkr8O9FlUyhTJj4tIHKqa0Jf4Uk84prsT64JA/7jJcsI1YhraVWYc1?=
 =?us-ascii?Q?XEOzMJSZykm7I+OctzECu00XBcD32pEBLYmA2XEUgQVDy5ILBQT29JNxMCEg?=
 =?us-ascii?Q?veZ1S7VqMjHm9zl8y7izGx3oo97pCv+R/xJikHqH1iKryWB6ijtd98reoyvL?=
 =?us-ascii?Q?CAEsrmitaIR432x5NF7+pBAal8OEy7XtPtW2UdcCZi/GXHuOuJ7fAoOH26AN?=
 =?us-ascii?Q?QQXEZoKw9D6YPkXn+WiEBWXG7W75o5kiq0yvCdWtsNl/q621g05D7WKXTUMo?=
 =?us-ascii?Q?xIl6Epq+p2kajBxpjLmScopdlUr+aacvm3BaZRbPJKNwwPEFn28KB1m/6VDw?=
 =?us-ascii?Q?YPL57f9Y7E56UvRD9Ir8ods31iWrhWUIkDe5gvwviqHrPOP5yK285UvPOYoi?=
 =?us-ascii?Q?vjAAof8lb/4z5EQ44EM9fm3ZtppMyf7VpKouoeDBAdydUY81FD/B9GY4qouk?=
 =?us-ascii?Q?AmMBltc/+/vXbK95wW8wLJQSIu7g+rqZRIF3CTfZVjnkqBhT85lqVU01ccOL?=
 =?us-ascii?Q?T2586vPhSeuNe0tlnBjci/Oa9qyHpaqQJcDGtcbp/6qgX4BUOYX6KiHf7R2C?=
 =?us-ascii?Q?Aep7DEWBuPtWv9m8pQHZjUS3Bgx/EDKfCOnxGyHiE/pj7aQqopkM9MICeTL1?=
 =?us-ascii?Q?BIFKJyoKOBbbKJS5lRpALa4zqluPUbrperrdu3OLnn5f5uzUZ/l8mzSB4nTL?=
 =?us-ascii?Q?Qmz0P5b0oSHXjdL17uDOaBS+xC+AMzKA3iD/+CrhV9jJ1yPeYEUdETfL43ny?=
 =?us-ascii?Q?h5SQdIBxeWSMobvscOWEADP0cxYkimkfSo+9lbMPHTgV7Lj+Ur7W4TQG7Exv?=
 =?us-ascii?Q?6wDH0ZRFYXlkzYXR3iK7VolWP/DTQPgcuaz+haYfOONLP0aDUl0frdi3OyTj?=
 =?us-ascii?Q?PotQOENGYQOreHsHu7Xnii6mIBZcS9FMiBQNlLhy7hPunfZcN0xKNLGevlpC?=
 =?us-ascii?Q?zBjCkA0uYBEFjVucmouPcm8kYibQBB2Y0t18trHdf6LLexIrumum6JgGqapt?=
 =?us-ascii?Q?ZrsOuODRuTQf46773NCXJQI578dh38mpp9MawSy7gm7QF1b9NIAaUu50WbRE?=
 =?us-ascii?Q?LIu9UEXWygG6GPUlS+fs/pBAdmKHe4I9WJneYu9otL1MIvFeqazk3nC+gvyK?=
 =?us-ascii?Q?bFVyCCLXnUlAGI382IRgF+uK8iHTCw13wE74NLnLfQA7bhmcIOpF3xasYkhP?=
 =?us-ascii?Q?V8HdmZrH6uVfGCv3p+LIaCNk+RZce1eE3h/M18q5MDe4049TxNH9FiHIFl4R?=
 =?us-ascii?Q?SldeomO7NmydRnZ6uj2a7J6JKMtF3cL19wHaJ3X5F30wp4SLjybk7FxHdm8s?=
 =?us-ascii?Q?a/gtUbt7KH7rDh1XWwbnyXnvGioMU10=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cad8610-45f7-429f-e66c-08df1a30677c
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 11:38:51.0207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DtlDlD2nMmCtd2AxAI7ebGyPU87qeh3n7IaOq98bab8eG2xqaSaIrdlZ0ToCAF/O6T575gNN7vmE1LAH3JbR5INRaF3/IzkPHxbgafb7NtA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7769
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Sep 2026 11:39:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24329

Setting INITRAMFS_FACTORY_RESET_CLEAR_TPM to '0' did not disable
clearing the TPM: the generated script tested the variable with '-n',
which is true for both '0' and '1'.

Normalise the value via bb.utils.to_boolean into the new variable
INITRAMFS_FACTORY_RESET_CLEAR_TPM_BOOL and compare it against '1'
instead.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../files/factory-reset-script.tmpl                          | 4 ++--
 ...reset-hook_0.3.bb =3D> initramfs-factory-reset-hook_0.4.bb} | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)
 rename recipes-initramfs/initramfs-factory-reset-hook/{initramfs-factory-r=
eset-hook_0.3.bb =3D> initramfs-factory-reset-hook_0.4.bb} (90%)

diff --git a/recipes-initramfs/initramfs-factory-reset-hook/files/factory-r=
eset-script.tmpl b/recipes-initramfs/initramfs-factory-reset-hook/files/fac=
tory-reset-script.tmpl
index 94b5f8b0..d17cf322 100644
--- a/recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-sc=
ript.tmpl
+++ b/recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-sc=
ript.tmpl
@@ -2,7 +2,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2025
+# Copyright (c) Siemens AG, 2025 - 2026
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -48,7 +48,7 @@ if /usr/sbin/get-factory-reset.sh --delete | grep -q "fac=
tory-reset"; then
                 ;;
         esac
         if [ "$fs_type" =3D "luks" ]; then
-            if [ -n "${INITRAMFS_FACTORY_RESET_CLEAR_TPM}" ]; then
+            if [ "${INITRAMFS_FACTORY_RESET_CLEAR_TPM_BOOL}" =3D "1" ]; th=
en
                 # after this the data on the encrypted partition
                 # is inaccessible
                 tpm2_clear
diff --git a/recipes-initramfs/initramfs-factory-reset-hook/initramfs-facto=
ry-reset-hook_0.3.bb b/recipes-initramfs/initramfs-factory-reset-hook/initr=
amfs-factory-reset-hook_0.4.bb
similarity index 90%
rename from recipes-initramfs/initramfs-factory-reset-hook/initramfs-factor=
y-reset-hook_0.3.bb
rename to recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-=
reset-hook_0.4.bb
index 670725b7..aaa194b0 100644
--- a/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-rese=
t-hook_0.3.bb
+++ b/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-rese=
t-hook_0.4.bb
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2025
+# Copyright (c) Siemens AG, 2025 - 2026
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -19,6 +19,7 @@ INITRAMFS_FACTORY_RESET_DEVICES ??=3D "/dev/disk/by-partl=
abel/var"
 INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE ??=3D "ext4"
 INITRAMFS_FACTORY_RESET_CLEAR_TPM ??=3D '0'
 INITRAMFS_FACTORY_RESET_CLEAR_TPM:encrypt-partitions ?=3D '1'
+INITRAMFS_FACTORY_RESET_CLEAR_TPM_BOOL =3D "${@ '1' if bb.utils.to_boolean=
(d.getVar('INITRAMFS_FACTORY_RESET_CLEAR_TPM')) else '0'}"
=20
 # to support factory reset on btrfs, add 'btrfs'
 INITRAMFS_FACTORY_RESET_FSTYPES =3D "${INITRAMFS_FACTORY_RESET_LUKS_FORMAT=
_TYPE}"
@@ -33,7 +34,7 @@ FACTORY_RESET_HOOK_TARGET =3D "${@ 'local-top' if bb.util=
s.to_boolean(d.getVar('IN
 TEMPLATE_FILES +=3D "reset-env.tmpl factory-reset-script.tmpl"
 TEMPLATE_VARS +=3D " INITRAMFS_FACTORY_RESET_DEVICES \
                    INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE \
-                   INITRAMFS_FACTORY_RESET_CLEAR_TPM"
+                   INITRAMFS_FACTORY_RESET_CLEAR_TPM_BOOL"
=20
 RDEPENDS =3D "factory-reset-helper \
             initramfs-cip-functions"
--=20
2.55.0


