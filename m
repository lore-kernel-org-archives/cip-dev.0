Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE50C9830E
	for <webhook@archiver.kernel.org>; Thu, 24 Sep 2026 11:30:50 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.65])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5690.1790249442850179999
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Sep 2026 04:30:43 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=fNOouV5c;
 spf=pass (domain: siemens.com, ip: 52.101.65.65, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f1eLDm231E6QUnS/VpJcCwEXCZDsaDhA1TxtNIcZWKRu7Rc5pfqWe7fsrj6yTr37WsapcgEzYB8Jlui69UZzD7eR9Av4qFK2xevy4GU/JsDc85LTpBg49P7+pbI9XFK2HCCMWaqiLLSgfCdvjNs5LB81hR9TLgX22UqxlqhnFyDYl7DXvhTj4runKL1TKAsTxNI5d9mR7ja2NQqxi6iAgCcqXVHgY6/Bz8fC/uTNRmPT2NdKlg/HOGXM+DwD24JFftkScnzHHJLhFoe2KWNXuVLMeTGj/fxWQgyP7YgGZRmy+w/wiGrE6piQgMpoyi/cK8UBfKorSjOzvrQvEaYUEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6q0SlifLkU6HbTdSvhNhhpnTnvZy5GX9hoskZ6BdWC0=;
 b=JcWlOdhS1LPdIImPxp9cDY9zC1wT5BGgVrMJwqSyb9+a/iUZD4KyjWoTTJ4OGnebr4Vzuu3QNoT5+jJBiiv+bVGjLXRP8FFzOEH7MCwLVOE1aZgv+dXkItm2f07Y5d0lYH5PggXjqvLGF3KePXFHLxrVMgZK7QHPOxY7pWfNwW0fElGwUyWPcx9AE4cS+SyiMDmZC2D++d9OVHUJkuCUcaYOWFYqM6RKZExUQTK9OFGAGnecrC3Tfte/jaJSwmsEQ7C1MAv6PccW0qgpLWf5XFEieuG82ZVrTe26dKKOhCFqldWlnn6VgMtp7k8r1L5KNatN/GId+83VEnCoAI71Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6q0SlifLkU6HbTdSvhNhhpnTnvZy5GX9hoskZ6BdWC0=;
 b=fNOouV5cwKXoQLPr0iHtcjpT+I2MCqoAKxKG86jh11WSJ+nhPgGPFaLf03iQBoh/73thmwLFFg40kxWJ3BB/85JndHnsT9hQhdDjkMLBMsUWnAwGf7meEDMiSFyKpM/+UVY1a7gZOEoWbV35hU19r9AVsvNlkrWX2xj3ywD1FkpgO2C/6g0//+zLzFJ1u9kuX6EvY3eQzSJOzo5hX5959urJHVMWNwuhj6bfLZVD98jHeYyhwJbAubhpIC0ZOVVNJbfEu9Ya8QztlTWWodWLznYIjTZNE80sSKrVHDBlydv2jKaH3gvRRNsWctmR17aj98ZeQo3owLX1S76do79oPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17f::18)
 by DB8PR10MB3308.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.22; Thu, 24 Sep
 2026 11:30:39 +0000
Received: from AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5511:7126:a2d7:f914]) by AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5511:7126:a2d7:f914%4]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 11:30:39 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	alexander.heinisch@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v3 3/5] initramfs-crypt-hook: Move service watchdog to cip functions
Date: Thu, 24 Sep 2026 13:30:19 +0200
Message-ID: <20260924113028.3191076-4-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924113028.3191076-1-quirin.gylstorff@siemens.com>
References: <20260924113028.3191076-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0091.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::6) To AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17f::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR10MB3172:EE_|DB8PR10MB3308:EE_
X-MS-Office365-Filtering-Correlation-Id: c2ef977d-1767-4790-489a-08df1a2f424a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|6133799003|11063799006|56012099006|3023799007|55112099003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: 
	9P4jtnHX3+ZJDIvyhob7cxCCvBhspv1b5JYi7lIiyxitrVwbr/yVfSLHAq5FSKkuJKY1V/Q+eNxoW6ThZrsu52J8SGAk8jNDMuwP7WPRLfM24J8l/qeMu3MURYh7dVLnrtM9u1tY5eaT4E3lKwq840rUdsFpj9k4Yw6o35fI+sTXANB1VKF0cS19YmR2BdquvQQ0xFnRs51/+/RBwxIvEqAauI02ke40D0uqo1Br9kDuHkiN6RQ/cgszHTClNZfoM6OsOlg5mrc6s1JzSXnrCKthR/97eQ94z8AlhRq+22KiEy03HTtf2czggkp11eeAumxWDHubCza6N4+VGHKxtEjiuiEQO6ANRBcvbYDNb0WAAxqTNdGVhToiC0KhmF/jQTrLXeUD7kpmqd08qdHIaCB7c/gVl/afxK0pxgeHXcZwi2Eesk5JPzlIiKlEyNoNST9scCx6BuJVufIt4cxMbBTqK6pt2JzcBzz/4dVlJx2cQBytsrZ0bYf3N3xwYoI24KwFqGFp88PqZj+nKOb5HkZyGlKFHncuHiCvl8IsAVY6l5McVBevqVAtVGGPNdyEWr6dnq07hj1Fuo4jNUJq1anyO4iwzOm+PnAZkTq3XjWMXg2jCYtGDNE6Y6Gm7JaeKF+Itcbs3LxkPV18bL8tNgwlkK0JFWzPnIKdeN21vnU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(6133799003)(11063799006)(56012099006)(3023799007)(55112099003)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Cetln9IGHgibD8IMwikCkoKFadKwNonfP5XccqWTfpElOIaZmgSfcevWPd8Y?=
 =?us-ascii?Q?Z07Eums38HNcB92OkgZ5eWgJ2Qg0zKTB6qtaCVgc4lPLgsM4RQo+s2NOTCI/?=
 =?us-ascii?Q?XPoxptZB6DAzZxewUMa9BYcyywxQJ6mGUkajJUVEpqiD9H9w4Zy3TLd/LrDD?=
 =?us-ascii?Q?ng75mITK4CzqB7gG66rH8tPjDBwUMRqmaGKEm/YsfU+nspBbYxn8lcj4o5Rm?=
 =?us-ascii?Q?Hxklkwyg8UQBhmMuZpGfo8xGR+WtO5x0j3Dbc2467fq50Yp2fi0ukgKMm//i?=
 =?us-ascii?Q?X2J2Y4qiR/L4A03pZuxYYLCbzekX3Wdsin01QjVpckENyLjGguUrSZz/5qby?=
 =?us-ascii?Q?zPcAQ3cqwNIekx44HtKQSFT8gUch9WgveSSQxccEO5Lp0IKz38yHdaG4G6S0?=
 =?us-ascii?Q?XgirOL0DvotrOyr3+WUtehbQLj8Xa0KYYFiAXIdPis1bJkXI0c4p+vyGZVLW?=
 =?us-ascii?Q?QA5UAYcx7vNRs0tyHE1BtKbdq9o26hGfuojmQKt/rBXPa1w5s6fxvW9z111y?=
 =?us-ascii?Q?YssAVD9DxWcxRskfjGD5JlbKJBv5s45pj0/MGsXENsv/aawwwpbVT07/Y5DA?=
 =?us-ascii?Q?0xrXUISgcZ5iZMuCyEkA/A05MRLKmNaPnzixwViabCzXVa7mElu6SxVjBsI/?=
 =?us-ascii?Q?glERu7gwPvxZtXENLfQ/anXmMmKnrP8t2sqbKyTkwiyXeY6GXLwQHQV98XXG?=
 =?us-ascii?Q?LGYZXOFFfI6pUyGuqw6h4G6xYibZ6EmcFdFPJApo5d9Yqe2VdT41ejZRFCFO?=
 =?us-ascii?Q?je4nGJf39hswieGIAv6zDT8N2C653OfdvtN6oTnMcZoNciSVK/mWEwHbUonr?=
 =?us-ascii?Q?osdwAZBUkAS6FnGY7+QaTTXTA+foibdfFkIXiLsIXsQakBAjLoYpbaupyL2Y?=
 =?us-ascii?Q?SeESicnMtmLOpaekdS7vllVWuX1lBAkzDJ4jRxscNQgCWnQZTUoc3aR/mFZ/?=
 =?us-ascii?Q?/9+9HOYMkxQyApVCr+XtNDouDxP9kuBgT7jlxc7/XHGF5/a1QwYhS7tCpntR?=
 =?us-ascii?Q?v0Cimwni9/mlSXqvMBW+OG0ZwKB4APiRkAJElZiX0V/fo15A6xzH2aIMP563?=
 =?us-ascii?Q?g6O3DQWJ6Ez6il/4ZTF4PAUpzNbhUZRHXbH69EkeoOiaE0I9f9gB22p09Wbn?=
 =?us-ascii?Q?xVn0rs9CXQyfA3wO010EsXiTNhqm2LoFwIdZrWRaudWFh5ZG5ywjBeMD77dF?=
 =?us-ascii?Q?8/h4nX2Wxp4i3v7m/koYR/+81Td50i0GUJ3a5BXhznYPOce/woBzdbmX5+zO?=
 =?us-ascii?Q?PBEV7e7YtP1+9vtDJwNg+hVOae+QrLYJ+qC0xSRVCF8nzeq4cHS8FWI1lycA?=
 =?us-ascii?Q?w8pIZfArMoe2Uer123mV75lVDSCC7sfqcdoyoqVD1rWxfkssmEwyN53zuzlM?=
 =?us-ascii?Q?N3Nc3aEboWLKM0+cQCM+BAUbUE6tzku5POC76M1LgJ3FTekmDvEWxNO9VAxo?=
 =?us-ascii?Q?jrmhdSrF+y4YOHe86CI3d7vU+TQbzARNgAaxE0bOgPB4Ls2c6fP3BdQCFO+m?=
 =?us-ascii?Q?+gf996aP8Ou5feazgUloCcQ4TR7zcqikFmkL0lW3dSnUYgaB+ViJbpuq48Z5?=
 =?us-ascii?Q?xsdoyUf58udZzmKzDoW3bltBUvY7xSQZyTxoYo5gFDCiHXOFuF3PlQi5QI3W?=
 =?us-ascii?Q?bZb7h6VhzA5jN18Sw83MiTIVIHiDJGRHByuVCkkhQIiTOdWmXCIB/zW1OXuL?=
 =?us-ascii?Q?Zt2c/0zyJFmFnzMDpZxnYvIcNQxQVUUYQMQ7tHo7Z1glZp8YRrR1jTKTqST/?=
 =?us-ascii?Q?bX05+E3aY6MA+/KMqNl5jlr6fktkFcY=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2ef977d-1767-4790-489a-08df1a2f424a
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 11:30:39.1284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zPMq2ReJ4k7OaK1hyuUza/CU+x1SEWTb2C5iI+4MCqreMq94qfddOEtVDV0ErDwKampnPbyom1gp35TEkB/j7hQ1Lf1B2Z3GaGz8Tcj+c7U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3308
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Sep 2026 11:30:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24310

This is in preparation for servicing the watchdog also during the
factory reset.

As the watchdog device is now shared between multiple initramfs hooks,
move the default of INITRAMFS_WATCHDOG_DEVICE from the recipe to the
distro configuration. The recipe only keeps an empty fallback.

CRYPT_SETUP_TIMEOUT now defaults to the new global variable
INITRAMFS_SETUP_TIMEOUT, falling back to 600 seconds. This allows to
set a common timeout for all initramfs hooks servicing the watchdog
while keeping CRYPT_SETUP_TIMEOUT for a task specific value.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 conf/distro/cip-core-common.inc               |  9 ++++-
 .../files/cip-initramfs-functions             | 36 ++++++++++++++++++-
 ..._0.1.bb =3D> initramfs-cip-functions_0.2.bb} |  0
 .../files/local-top-complete                  | 23 ++----------
 ...k_0.11.bb =3D> initramfs-crypt-hook_0.12.bb} | 14 ++++----
 5 files changed, 53 insertions(+), 29 deletions(-)
 rename recipes-initramfs/initramfs-cip-functions/{initramfs-cip-functions_=
0.1.bb =3D> initramfs-cip-functions_0.2.bb} (100%)
 rename recipes-initramfs/initramfs-crypt-hook/{initramfs-crypt-hook_0.11.b=
b =3D> initramfs-crypt-hook_0.12.bb} (92%)

diff --git a/conf/distro/cip-core-common.inc b/conf/distro/cip-core-common.=
inc
index 99218c3d..c945378a 100644
--- a/conf/distro/cip-core-common.inc
+++ b/conf/distro/cip-core-common.inc
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2019-2025
+# Copyright (c) Siemens AG, 2019-2026
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -31,3 +31,10 @@ TEE_SUPPLICANT_IN_USERLAND ?=3D "0"
=20
 PREFERRED_PROVIDER_factory-reset-helper ?=3D "factory-reset-helper-file"
 PREFERRED_PROVIDER_factory-reset-helper:ftpm-stmm =3D "factory-reset-helpe=
r-efi"
+
+# Watchdog to service by initramfs hooks during lengthy operations like
+# partition encryption or factory reset. In our integration, enabling
+# fTPM/StMM implies a U-Boot-based firmware which may enable a watchdog ea=
rly.
+INITRAMFS_WATCHDOG_DEVICE ?=3D "${@'/dev/watchdog' \
+    if int(d.getVar('WDOG_TIMEOUT') or 0) > 0 \
+        or 'ftpm-stmm' in d.getVar('OVERRIDES').split(':') else ''}"
diff --git a/recipes-initramfs/initramfs-cip-functions/files/cip-initramfs-=
functions b/recipes-initramfs/initramfs-cip-functions/files/cip-initramfs-f=
unctions
index f14956d5..aeeca06c 100644
--- a/recipes-initramfs/initramfs-cip-functions/files/cip-initramfs-functio=
ns
+++ b/recipes-initramfs/initramfs-cip-functions/files/cip-initramfs-functio=
ns
@@ -2,7 +2,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2025
+# Copyright (c) Siemens AG, 2025 - 2026
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -84,3 +84,37 @@ secure_boot_enabled() {
     fi
     return 1
 }
+
+service_watchdog() {
+    watchdog_dev=3D"$1"
+    setup_timeout=3D"$2"
+    if [ ! -e "$watchdog_dev" ]; then
+        panic "Could not find '$watchdog_dev' - Please check your kernel c=
onfiguration."
+    fi
+    for _ in $(seq $((setup_timeout / 10)) ); do
+        printf '\0'
+        sleep 10
+    done > "$watchdog_dev"
+}
+
+# start_watchdog and stop_watchdog share $watchdog_pid via the shell
+# environment, so both have to be called from the same script.
+start_watchdog() {
+    if [ -z "$1" ] || [ -z "$2" ]; then
+        log_warning_msg "Watchdog is disabled."
+        return 0
+    fi
+    if [ -z "$watchdog_pid" ]; then
+        service_watchdog "$1" "$2" &
+        watchdog_pid=3D$!
+    fi
+}
+
+stop_watchdog() {
+    if [ -n "$watchdog_pid" ]; then
+        while kill -9 "$watchdog_pid" 2>/dev/null; do
+            sleep 1
+        done
+        watchdog_pid=3D""
+    fi
+}
diff --git a/recipes-initramfs/initramfs-cip-functions/initramfs-cip-functi=
ons_0.1.bb b/recipes-initramfs/initramfs-cip-functions/initramfs-cip-functi=
ons_0.2.bb
similarity index 100%
rename from recipes-initramfs/initramfs-cip-functions/initramfs-cip-functio=
ns_0.1.bb
rename to recipes-initramfs/initramfs-cip-functions/initramfs-cip-functions=
_0.2.bb
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complet=
e b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
index 3312e632..f5b1c8f1 100755
--- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
+++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
@@ -63,20 +63,6 @@ if [ -z "${create_file_system_cmd}" ]; then
 	create_file_system_cmd=3D"mke2fs -t ext4"
 fi
=20
-service_watchdog() {
-	if [ -n "$WATCHDOG_DEV" ]; then
-		if [ ! -e "$WATCHDOG_DEV" ]; then
-			panic "Could not find '$WATCHDOG_DEV' - Please check your kernel config=
uration."
-		fi
-		for n in $(seq $(($SETUP_TIMEOUT / 10)) ); do
-			printf '\0'
-			sleep 10
-		done > "$WATCHDOG_DEV"
-	else
-		echo "Watchdog is disabled."
-	fi
-}
-
 check_partitions()
 {
 	found=3D0
@@ -307,10 +293,7 @@ for partition_set in $partition_sets; do
 	fi
=20
 	# service watchdog in the background during lengthy re-encryption
-	if [ -z "$watchdog_pid" ]; then
-		service_watchdog &
-		watchdog_pid=3D$!
-	fi
+	start_watchdog "${WATCHDOG_DEV}" "${SETUP_TIMEOUT}"
=20
 	# Create random password, store it in the tpm2, sealed via PCR:7,
 	# to allow continuing reencryption in case of power-failure.
@@ -374,6 +357,4 @@ if [ -x /usr/bin/tpm2_shutdown ]; then
 	tpm2_shutdown -c
 fi
=20
-if [ -n "$watchdog_pid" ]; then
-	kill "$watchdog_pid"  > /dev/null 2>&1
-fi
+stop_watchdog
diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.=
11.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.12.bb
similarity index 92%
rename from recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1=
1.bb
rename to recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.12.=
bb
index 7d198582..b9f829ce 100644
--- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb
+++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.12.bb
@@ -88,12 +88,14 @@ CRYPT_PARTITIONS ??=3D "var:/var:reencrypt"
 # CRYPT_CREATE_FILE_SYSTEM_CMD contains the shell command to create the fi=
lesystem
 # in a newly formatted LUKS Partition
 CRYPT_CREATE_FILE_SYSTEM_CMD ??=3D "/usr/sbin/mke2fs -t ext4"
-# Timeout for creating / re-encrypting partitions on first boot
-CRYPT_SETUP_TIMEOUT ??=3D "600"
-# Watchdog to service during the initial setup of the crypto partitions
-INITRAMFS_WATCHDOG_DEVICE ??=3D "${@'/dev/watchdog' \
-    if int(d.getVar('WDOG_TIMEOUT') or 0) > 0 \
-        or 'ftpm-stmm' in d.getVar('OVERRIDES').split(':') else ''}"
+# Timeout in seconds for creating / re-encrypting partitions on first boot=
.
+# Defaults to INITRAMFS_SETUP_TIMEOUT, which applies to all initramfs
+# hooks servicing the watchdog, or 600 if that is unset. Set
+# CRYPT_SETUP_TIMEOUT to use a task specific timeout.
+CRYPT_SETUP_TIMEOUT ?=3D "${@ d.getVar('INITRAMFS_SETUP_TIMEOUT') or 600}"
+# Watchdog to service during the initial setup of the crypto partitions,
+# the default is set in the distro configuration
+INITRAMFS_WATCHDOG_DEVICE ??=3D ""
 # clevis needs tpm hash algorithm type
 CRYPT_HASH_TYPE ??=3D "sha256"
 CRYPT_KEY_ALGORITHM ??=3D "ecc"
--=20
2.55.0


