Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DAEC982D7
	for <webhook@archiver.kernel.org>; Thu, 17 Sep 2026 16:14:50 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.1])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.43616.1789661685153000358
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Sep 2026 09:14:46 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=FxCRXLk0;
 spf=pass (domain: siemens.com, ip: 52.101.84.1, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NlGGgihyTmw5Z+jJgifMyPmoZFtq1+OrYMFGtVdPAyyQ+frEzuTzrn4SGnHlg/XJG/DW18fUlo95JQKUy5ytx6D4BFXKoG3rMKY+M3Lalrh+WaWimGsUI7rj10Daj8dr63d6bXpDQUeKbTpJMHCHsWT/Yp5NqA/PTkLMx9L8wnBUzOpfijtR+4Rykd4r0Qp27VkOiOV9C3bGSaCE44NA2/lMbx7+hy9Xj1Jy2YeY8V0S7ZxFKl2+N2dSkbbHlFBx9SC8t66vBZ/YWWQhIRIcQstHDsDAMy/5d4KFe/obRWSSkf4S2XG3wL+i0pfEUUTbPVMC58s5bYblMEMVqvophg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7hZMENyvBJBwDm0Q6xfJ3JK1bDy47oYLq1IfidnvG/Y=;
 b=oT48tJJXh6J2gkv+K3wFByLydZkBdNjFaXmc0pVd48R5xXDd6zxOXV1tjif8ruC1lCSg6t8XzqN+ASFnt31WOtmqb/dtARC8ld96kRAhMG24rN2vE0LaS/0SQANI8U/ciik/w55ahAH41LAiQzgazAKtOTz6+g/PCoveOTi+bfj1UVjTLc8pSBCYR9IMNDBvTj9EqfOlMXnNHALLE6nNOJf0r1sUCY7QJHvEntqhgmazvyxPgAoSDL6ceG8+aElTGSVUDlTy38etcAttS0lghVc/MiAKIjnfXiPlBpJhfLH0mH/+gcGS1+pRm3OFrT0qyTVxE+7ZhNHOLzD0FoyyMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7hZMENyvBJBwDm0Q6xfJ3JK1bDy47oYLq1IfidnvG/Y=;
 b=FxCRXLk0HRxah35nMu22Qh2BZW1iv+rdT3kLCHDrPK+92IC49HeHfRYJ7Nlk9dIhJ6el6UIyuucCJUfknhdk/PJ9EdASc6HaOLXdglPyUHYWoF/RGSfnoXd8xxuKk66qnlvSlpSPwz85Bj0EoojjBNxuBzWGQ7W9YC5I3yGQ/fDg1Hgl1VnAdmivcAn8zc7soY9G81p/d+KJmYpJs5bIA5Apii4H63HUfKZ8NDmdSDgDtRNdvF/kZ/VvfTiBnc7pXPbKh1r8ozlymNpBbAlTUf57+3awCf4BR1zgmULcfj094GC2k9c83oOHo95ewr9cXQp6heZ4Dr5VcdEzNHz8ZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by GV1PR10MB7598.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:89::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 16:14:41 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 16:14:41 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	alexander.heinisch@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2 1/3] initramfs-crypt-hook: Move service watchdog to cip functions
Date: Thu, 17 Sep 2026 18:14:05 +0200
Message-ID: <20260917161425.666709-2-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260917161425.666709-1-quirin.gylstorff@siemens.com>
References: <20260917161425.666709-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0012.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::22) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|GV1PR10MB7598:EE_
X-MS-Office365-Filtering-Correlation-Id: b087eedc-3741-4f40-32f9-08df14d6c77d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|3023799007|6133799003|11063799006|56012099006|22082099003|18002099003|55112099003|10067099003;
X-Microsoft-Antispam-Message-Info: 
	FVhxxG1wPZDIwQB9R3nUQgn/L0D26qUV5IbNe6/1UL/Hu2OpmGWLe+CYAJA4R9+vcBzRkt0LAbYavVAA8O6dDDb219AJ+MDs4pFVhQNkQ9//FkZqeZYcpuLznePiwDHtoJTiKMonByWA4C7bLEf8UzeHxmvtIsoNQfCZCbQCI65NUFRZ4kG/8wuEyaxuL5AFdIYTEBFRpvYqN686XDYGSdV/G4q+RqH4iO2egZ5n5kHoTD4YaVB1kpWcQjTnEHV/OaShG18EzeVO8OzGaQmrdh2M1w4HtkDhRa91kSmNKn2tSJalD+uqbeoK3Ni/2M/TqA0Au4Lp5mHPsteHf6+xj01B0bc9m+JCDVvoMlYVFERxDl1PgoXBWPT7rSPW9W6cIHN5OtnsZpb+fJZNJRe1AMasc7oVkOd+xBL4GAlH6RIWGSa19gfGMNbGkszYwPCmD3aWKJ8Jm14uzOVgRSM5KfXmKi5AooqCHxSHhcVVbeTE6SJT/Kb5AxXO8Ueen2BPhWf4zP+yXa3qJisDEWXQHwUjCtFdCsWlTeHybCeRE90I3Cud/izXUcsNmRsubc6f5oOohspFM73jQO6mBBHO1qFmeHHVbdpSVReEqTSfJHFNAmNOGbBoIqN91RdOb5EfZKn/7xrdmwZ83nVOWNVlzxF3JnfLx6zqXOzqBgyDc6w=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(3023799007)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003)(55112099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?PblbrdRBSx4huNyc+hHdRCtsCDwcHWprYIqC6yrK6X4np7UJBrGQu1etz6fI?=
 =?us-ascii?Q?IFHIzRq1Cs02vvh3Yka8F6tQGaEefEhE5BZUBKi0PU+rdVfWlS2FsKvu337D?=
 =?us-ascii?Q?3imTjpucEF45QAQlXOvSjVyEKAK1p+T8XRfeIRDDJ3bN56Jx5lC1ZoldRDdl?=
 =?us-ascii?Q?gWxfZR+jNSiD+7V75rubGlhXBWHyV2uhbyrBE/6Bpag+Lzucjo1nUf6vdka1?=
 =?us-ascii?Q?kP+5gV9zwI/llDJ+CNtl5rSuqV3npqdmJDslGUdkl+0upnC9aNIqftY2yIIm?=
 =?us-ascii?Q?OEKk5y7JVxchbULRUDAiZ+NmWZDjbXrZNhcJQ7RavPCB7ZkY19IOoIM6QLm3?=
 =?us-ascii?Q?fp5wUsL7NYUwqVHhzq9jqatdMfgi8kjlFHZbLZk1+uiu8HXceGXHWcVa3+W5?=
 =?us-ascii?Q?RDpzc+M/pXskjb2Kp37f967dFj4xDt20JlJfaEJZC61COHZL0dxQIMcZ8kby?=
 =?us-ascii?Q?RLpkyjsW/div/HCtSsPXwxwwyn9ZNEv3kqzB8Kid8qkG2P0ydVDAKWrqkryX?=
 =?us-ascii?Q?zST61DwurE05ZrsJQ0LSuhRfhj6jmiky/W4Dc2gmSuRdEukVNncOLiVSk99g?=
 =?us-ascii?Q?2NaD7wqbDwfSUDFEcYx8Nui/B2E6ElPzCzWrFQ4J9LA7CGhnKIHsbYX8SMiy?=
 =?us-ascii?Q?gVkuE3Nf1ArmNDMe6xRerwb9yNyFhWAjzNtwPOng+UqR3OLLMxfOBDCQGB8g?=
 =?us-ascii?Q?FHf33v2KViRdlEOjegjYqPJLD0VgIzxSUAuacmbMM7ng11ulIyy2vIKs3Ray?=
 =?us-ascii?Q?0Nnsb8LotUzaTdoAHb4YkQEwKt9FBAn3KhkiH7z7DZ8Si2O8viVoVDmBnLWV?=
 =?us-ascii?Q?IoYsZWov8mdX7CSJi1r4WxBv+Y1zZYrKOFB3/Am1ZHXhnjr9KZo1Rp+VkUXZ?=
 =?us-ascii?Q?hgUOMZLIuRnIm+QepJR1/VoFsGlFZUbdaOVS6042C6iE3GTi3bXWqGqhhsQs?=
 =?us-ascii?Q?ulXbGx2HN+j3UlvNCM1pUFXq3OetMq0WPtzyUUvhPrEJcCDYTaw4D63r4U7t?=
 =?us-ascii?Q?62vZnpIPa5TiKcpzPyddvukt6T7efSF4pC37BCVQAnj+Qh3mcCdzqUON7S2V?=
 =?us-ascii?Q?KvX48/nPHRrXUORVFjBeL5RKeUtZKEiSV2cUEsJlC97rdRu2cqYtOZLHhnoI?=
 =?us-ascii?Q?h2ueeu2f8Q2BeBjXSvUaIZmIVcoKgPDoEuj8oNIYL0d80Bh0SJAZcys5Q3rc?=
 =?us-ascii?Q?YUVtxnAyunFslSne6DqgHIKYGvjgB0HAs/IfKfOtED7sWxnm8OIO9Lxn2Ue2?=
 =?us-ascii?Q?o1C5dM1Qwbb+pM5VGAzIIM2KgsAs5x86SFwonJB5Ce3JRAsOaw3xAYf9JC6p?=
 =?us-ascii?Q?Sf5pSHhvCVM2Hw2lWD+o5gZySLR1p9TyHyFyyRluSpCX+DpeodStqCSND4bh?=
 =?us-ascii?Q?yttipq9WZ7fV3EM/pPOXp869/Tr0qh7aOzx9huOm72N0ksWBTM6WsyyTNLCk?=
 =?us-ascii?Q?9Z8sGtsTJ7EsJuYFc9au8cqYPolPkL+BPKGyOQm4vMt+U4YBYjq6SaRCwG7A?=
 =?us-ascii?Q?0h7zaSz/Cj8u6yH0DY/xoRDHW/r6TtgM2wUHG789Qfb4oQaJs/ifQWFsPQzh?=
 =?us-ascii?Q?kWNTmWQHjKItPrgjtKzz8/+KaZwHNvKitRDcuhTgbefVtD7GupSY9ubL6NcM?=
 =?us-ascii?Q?93ZmZI4AyUhR/zR9yNlVxYRK+vgCLzTPEf2us3I7fe+enhHFLhJkYyL/eGf2?=
 =?us-ascii?Q?t5mBhniWM9zOsC31Y8LgRiJ6caEJpMXGeZJcBVYh3Z9xLzkcAFxtOo6D4ViA?=
 =?us-ascii?Q?3FQDv1P/cph4dBlhLTU5E9kGm1vjvGI=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b087eedc-3741-4f40-32f9-08df14d6c77d
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 16:14:41.4800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jd7x4gZaNylfj0E3Ay4qELpSfHDvrf2WnFZCazNU3vtKf1Eht99sdsqba7bs+l+w7JxTqo7ST+FlMdYl7Coijpzs1ForPIPx1hmoshQXjQ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB7598
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Sep 2026 16:14:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24225

This is in preparation for deleting all data during factory reset.

Also rename CRYPT_SETUP_TIMEOUT to INITRAMFS_SETUP_TIMEOUT

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../files/cip-initramfs-functions             | 36 ++++++++++++++++++-
 ..._0.1.bb =3D> initramfs-cip-functions_0.2.bb} |  0
 .../files/encrypt_partition.env.tmpl          |  2 +-
 .../files/local-top-complete                  | 23 ++----------
 ...k_0.11.bb =3D> initramfs-crypt-hook_0.12.bb} |  4 +--
 5 files changed, 40 insertions(+), 25 deletions(-)
 rename recipes-initramfs/initramfs-cip-functions/{initramfs-cip-functions_=
0.1.bb =3D> initramfs-cip-functions_0.2.bb} (100%)
 rename recipes-initramfs/initramfs-crypt-hook/{initramfs-crypt-hook_0.11.b=
b =3D> initramfs-crypt-hook_0.12.bb} (97%)

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
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition=
.env.tmpl b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.=
env.tmpl
index 787172f6..c9ae70a6 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tm=
pl
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tm=
pl
@@ -3,7 +3,7 @@
 #
 PARTITIONS=3D"${CRYPT_PARTITIONS}"
 CREATE_FILE_SYSTEM_CMD=3D"${CRYPT_CREATE_FILE_SYSTEM_CMD}"
-SETUP_TIMEOUT=3D"${CRYPT_SETUP_TIMEOUT}"
+SETUP_TIMEOUT=3D"${INITRAMFS_SETUP_TIMEOUT}"
 WATCHDOG_DEV=3D"${INITRAMFS_WATCHDOG_DEVICE}"
 HASH_TYPE=3D"${CRYPT_HASH_TYPE}"
 KEY_ALGORITHM=3D"${CRYPT_KEY_ALGORITHM}"
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
similarity index 97%
rename from recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1=
1.bb
rename to recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.12.=
bb
index 7d198582..514bda80 100644
--- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb
+++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.12.bb
@@ -89,7 +89,7 @@ CRYPT_PARTITIONS ??=3D "var:/var:reencrypt"
 # in a newly formatted LUKS Partition
 CRYPT_CREATE_FILE_SYSTEM_CMD ??=3D "/usr/sbin/mke2fs -t ext4"
 # Timeout for creating / re-encrypting partitions on first boot
-CRYPT_SETUP_TIMEOUT ??=3D "600"
+INITRAMFS_SETUP_TIMEOUT ?=3D "${@ d.getVar('CRYPT_SETUP_TIMEOUT') or 600}"
 # Watchdog to service during the initial setup of the crypto partitions
 INITRAMFS_WATCHDOG_DEVICE ??=3D "${@'/dev/watchdog' \
     if int(d.getVar('WDOG_TIMEOUT') or 0) > 0 \
@@ -104,7 +104,7 @@ CRYPT_BTRFS_SUPPORT ??=3D "0"
 INITRAMFS_CRYPT_MOUNT_OPTIONS ??=3D "defaults,nodev,nosuid,noexec"
=20
 TEMPLATE_VARS +=3D "CRYPT_PARTITIONS CRYPT_CREATE_FILE_SYSTEM_CMD \
-    CRYPT_SETUP_TIMEOUT INITRAMFS_WATCHDOG_DEVICE CRYPT_HASH_TYPE \
+    INITRAMFS_SETUP_TIMEOUT INITRAMFS_WATCHDOG_DEVICE CRYPT_HASH_TYPE \
     CRYPT_KEY_ALGORITHM CRYPT_ENCRYPTION_OPTIONAL INITRAMFS_CRYPT_MOUNT_OP=
TIONS"
 TEMPLATE_FILES +=3D "encrypt_partition.env.tmpl"
=20
--=20
2.55.0


