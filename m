Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39714C9831C
	for <webhook@archiver.kernel.org>; Thu, 24 Sep 2026 11:39:04 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.38])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5867.1790249937042799224
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Sep 2026 04:39:01 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=ZMTAP5gA;
 spf=pass (domain: siemens.com, ip: 52.101.84.38, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tb+2PbUuFa+gVlS3PyK2ZHjadRkkLyyj54mGLbZcuTXs0BLha4P+etbw2n/vlxHh7Z3KPaRaGSF5Zm8hgotgQ2E9xThTd4SmlPXyUZIgyqAbWNcuERkhxxU96quF6XdlzGQXjOv1+5afYFNNdHmHd8eQzdEYE2c1iVBBbO8KCjgEeja1ZsNHghjNvkVIbciJb8t4WkhLLHhvSsaaxZ9b7+tmRRmvBEOATEp/ay6iJL8APuXlY9ntDbbp7KlaTyQMQ15i9nwtiWybHiOpmel9LZg8iOiXgOYC62EL8AOBodAGC1VjahiSlerWIlpShrO/+tRcOTlZ8+JVTFyTjWJIUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6q0SlifLkU6HbTdSvhNhhpnTnvZy5GX9hoskZ6BdWC0=;
 b=wfGFaniuojUrbAmxg9p60C6jUu6tUi/0fru9yoHXuipHT5lMU2mqTzHNrQizcj8Yw6c8ykvECbdILOuhulYsZf6mjKK924Z9yvdFSt+ZQo+wxWbCNmYDAE1FhOD2VKqGTp9+Fb/iON3mqAIV+iSOC6DHqU9tGZqfYiRtqRjA8hspWO3oEWi5wvSDGHJkX+covGscXWiOHNVwLNU08N/IavYy6YeQf6NeWxUoLLRau8Zdjfnoz0rcC1CxVZCZJj1SPQ66qRRSs1eyLn02WbZz8HRgK5ILYonR9C1lNRnYkImIPdvmSWezvEwCC69c3E7IQ033aZHUrEOKgXw8yQLl0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6q0SlifLkU6HbTdSvhNhhpnTnvZy5GX9hoskZ6BdWC0=;
 b=ZMTAP5gAL/9HEzG5kZdRNvZX3VlqhA5nn88g6fwXwjEINk9OYXgliGI7PjtS+uR0EBdAilBQG3cuxrLtll+asq7BBZoAmzxMS18ZmIoci2PcmThNTwPFWW0k49wcUNppZuhLrOr5xeaYXdjk1EFdS7wI7wu3Fts9A9Ym6bHo2qjuoXzmA65fGbSE4VpsrLmbnpNDjjmy+k8hb+lnwlpJrJsdo/IdHBqeSIZ9faLyn6/9B1SsL52+vx9R9LMejVXPJGYp3DIBG2RA2HZdmAw3JZvAMuDbIHgDmtrb/TTk8qQNvOk/gKFXt4R1CJbkohwQoXg25/l33HSCUyHejj+sAA==
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
 11:38:53 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	alexander.heinisch@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v4 2/4] initramfs-crypt-hook: Move service watchdog to cip functions
Date: Thu, 24 Sep 2026 13:38:34 +0200
Message-ID: <20260924113844.3192747-3-quirin.gylstorff@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: e9b49f1d-04ec-44ff-75bf-08df1a3067f8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|10067099003|56012099006|3023799007|6133799003|11063799006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	D0+uNqMXz7FqQqZQil+Yf4vW5y/V7HzinwfJiaqhtYR7FparT/8ZTqND2KfO2jbFGPo4gxY2rQ+rpX71DYlgugxNpJbf85iS86pVjM2G8v/ERcj+urQ5Id8gvVVMEMHZn/qRfUmTMMe8jrJ1ROmj5cc9iHYLX7tcGpL79m/S5oorVfKqRgHA3GUgnvYkAC6m+WCLxbfWGr+mCJ03zKxMOcDR4luxVEKqAbnohMSvzH8aN9/n+e56Pg0+oV1Pig9fG+uq6C/zhg9OfQQV4RltkEfT3Z6TUDrXc5GPP+yvhBp7YQDwBOGXH2SpzHwJhMUwPHALj+s+N2NwOeSoV2NNYMq80U/sntTjyprZLnmIKq3Vvsssq5X/KHK/gKdO8WXZk/0fv18CPaHRDtOV3upXdfAxHpNNJyuwDd8E099Key1ky+wRYvVEWXsmeVIq4nNZvfx113b0U6DhKWB90vx0m3bF0fLCaqqFF3c+PTxfYZgrApr6iZ5yngoqoYgYTiqWzfEmeog19rxgLooDoEM4d5L+GaTdMdmWQjCBq6TVvOHS4A31zm0p/x8iTdWXPl7e9fWQootddGhNZ6PjmM3EHcbUjqWgBM4lq7bwRMPDDoBovyqAuBGZifndKGvTx00AYm4UItXfXG/fyNdsM8dxAzYCJ9F87akYb0NNV9dFefA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(56012099006)(3023799007)(6133799003)(11063799006)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?lGkYiHtFN0m7Pr2gbUD1N7zciim4Gqcpohmam2mDmd6KUneZqIaWioDbBCta?=
 =?us-ascii?Q?WOYvdTn0b2geTH8B6GBpaLGRhhajrAJvLM0IuYXRHnR9qwXkPYdLSxFjpuIo?=
 =?us-ascii?Q?37jwwHR7T1S4mNoR4wOfs7FvBv2/b98EoC/ULDdneonTSxOTTsmftvBfitDU?=
 =?us-ascii?Q?YRs07h8P6wp7reAPvCztXiGFvlhxB14JzNfB/iBQKsoKps3SouuAQYWkG3lN?=
 =?us-ascii?Q?aJgAUgIa7v35YqWCfN0PsKvriFDzcQwpqfeUTZc/aTgLeLpd+6WxJK+AZ3FL?=
 =?us-ascii?Q?f1lS/cASHRcz62mzvVFnLjgrbSNj7SThaN+3w/7CgOjv7oSLkodHWPmCH460?=
 =?us-ascii?Q?FO09r2Sa1rkYTsf7kKF7gPFA3zEpOaKB2Y/Roh5rJLAjRsP6EUAoI441cAWq?=
 =?us-ascii?Q?dk3JiQiFV0CQdsJEoHj8W3sJ2+Q85rOy7pQsp7FAru9bR08QEMiX3VX8CH99?=
 =?us-ascii?Q?nJ6ktq/XN3rDRiV9v2h+U/jsXX7spvvV9M8I1jODCcTzldrQnWFCW4VpTd3Y?=
 =?us-ascii?Q?1ZixIMK5khnIHLlJnRm8UBLfP5jYNol0rJukRQPUImvPJGDbPJxAIoLBGBKr?=
 =?us-ascii?Q?qYGUK7I9Euh6nq6XZCJS1VqYpJK4rvQkVeXdgQn+e3OgvxSL8B3ZFxsVH4Qs?=
 =?us-ascii?Q?t0D2zm98tkfwr6jafx330m+3EzSy6r0eu6mMkiz42Ob6pCYIACJCG1rnXyRm?=
 =?us-ascii?Q?uPe3UaX7eYpEt4X6z6r68Mdad5s7knEw/fGsLZSb0YIvGBXUVrqcng6tedlV?=
 =?us-ascii?Q?liHPUMMrUm91HIV7y7O5V/dBvKIt+6qnchq6AMren0RT3OfxNkyRzduGu1s1?=
 =?us-ascii?Q?Qx598P7Os1dc7eA5OPrqNcg01i1zEmblKQ5bsoDyAnODU3asCo6mylSkxYdZ?=
 =?us-ascii?Q?5hVQGSOHkGnfu/RURT53GV0OXSmunPonccICWcFEZlFS1PMYS8yKUQogh26m?=
 =?us-ascii?Q?euHZTx/HuQBUqJDKxH4lfwS1tsi75GrN6i3VdmnK8M6gKrbaHmq+7dsUgy6F?=
 =?us-ascii?Q?6aJWwzzhndO+F3wca+GbwBUDQIQ3tYm3omKCPBiaAfURuae55xYZm1UrSGpB?=
 =?us-ascii?Q?OJKZ2bua4F20X7u/7kYeq4RNhrTBrPXwOUTkleSjn9Kx7yrGcGh4mPUCaRiX?=
 =?us-ascii?Q?aWYX1iDtfWqMzVQKZ2BnVgw0HuXt2xz8FwLinvIEEimmnbQhIUip5bA0zvKB?=
 =?us-ascii?Q?rYmIa0Z5HgzJ/6IhzwYJxhb3M3Em9FSX35Ob4cLAuf0ljOhyK1DOPP+yrgfP?=
 =?us-ascii?Q?JXV0s/bM70PBmf2lVBSSYU2T4nRdVUbIzV7izsxQGph5Qsri83I2KXTcDcIi?=
 =?us-ascii?Q?LBCLYuzmnscXV55zrphX35Y8MBpYmvtM2mtyQk9BLL9ov3tboRqB4BOrLvC+?=
 =?us-ascii?Q?f/CFCwegSg5yigzVEc/BcAw8GJxZkriMokQj/aYKgaopQV9AqbdOVMvYeosJ?=
 =?us-ascii?Q?oUUlFWt5Ia8bVxDuhphhPghC6lm/pUT4iKNwrw4xfisXbB3qDHqAh9dCS6dI?=
 =?us-ascii?Q?VrA5lHcu6hjriQt0ueOkti9CiaIfzlHpmmIy/9pk3059ewkZuxH6YCIUIkAO?=
 =?us-ascii?Q?kgQw3fnrUsnjodSB2BKrbXsOMi1IYRGFJql+Wy7OLquEyax2u9FKnUBD1dmq?=
 =?us-ascii?Q?4SvnakjjUC9kAQV9fxmslzG4JTidfmLzepH6ShxrHZt+bqnmhVZH3ICh5pq0?=
 =?us-ascii?Q?syOsU7CoumP+YFnGibpiYAHy8UKesipXoY7aTVVq5wgkU/KwoUpTABe1qJns?=
 =?us-ascii?Q?YiMXjCpMFZS9vnVN2/Lm3Apj9YKQxRM=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9b49f1d-04ec-44ff-75bf-08df1a3067f8
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 11:38:51.7533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5lQAoCxanK4JDW2F9hZPclosXnBrO+lHJHE5FEdmRRf2d5Nuk/GJMX7eVTlIn/ptN6fk6lG4CGKtm5BVOAhWdio0reA4rKnvEP/kL8/LNaE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7769
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Sep 2026 11:39:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24330

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


