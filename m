Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699A6C982DA
	for <webhook@archiver.kernel.org>; Thu, 17 Sep 2026 16:14:50 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.1])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.43616.1789661685153000358
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Sep 2026 09:14:47 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=y8vur99g;
 spf=pass (domain: siemens.com, ip: 52.101.84.1, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KioCAcAClhRh05xm7dnZuCYE5ox2dSkJmZVLl/HhNElSDbVIwN3yLXbUOhOJG68oogSYPFVfox8AD4+08+DQeaRK8O9B+MsYyEMk4nWlLfBOzYIFQkMypxQeFwlrEX/3lQjTQbZj4rterLCcjhjIjiX9KXWcwU7auBOlXgEe9y9yQ+YHnf5Jfm5B/OVOZPwqKBnlZo7WVWZad14tGE05hQuF/NKyi5RGtoWVUcJj3LxvwpiMO7EzRKV7ojJFHHmTJaMEW5hoz6qywr1wn921JroOFvJFzCqtb28Ug8KZCtgXv+gmDOFrj72qF30sBCb1sTsK0vknov/QwuLPt97VWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5pMLCK5yGJpv0i4MG7cbm5/E0izTxNSIBcZGv298jo=;
 b=nCTAi+aTJ7i1GyawtIYYuvbA4rvpaKurJKz4uTrPvsyIa2SVaAH+JYn/e+3rqQi1WlH43qWNY5WP6ZCKj8jeATIetstJ+NvsZFtlUlr+4DjCN+uXHZ5rcHeg5k6IikGHF6LpTA7HNI1wgipJE+6Nk4sas4VUt0haA1DzfpJN9YIEmmrMCCAa13fr8yfav373FOqHfa7ppapMZdi6Mj28EQtk2XZ0KXvUWYRvu08TR8GXaRrvpqYDIOY8CDtCTwasfqXs/j1AJXm744llJz3asOVPz8JLLkQCmmgIbkSsH2ecFwuWms++zJkhNyIRWOnf/5JZdNmWUSbwhD8VEUOPvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5pMLCK5yGJpv0i4MG7cbm5/E0izTxNSIBcZGv298jo=;
 b=y8vur99gYYWoaNWMp8p5njQfvHQmw0poc+3ohg/HZFkRwZu9fikfbjkSMISVzLhJqLkB/9NdHXmt03S9uR42Gr7Bjsrfuzcn4CUtQQ0T7kV541STYiAk7McWEu/a+mKTdwUvE3KV448f7BrsLXiJ2CjBotGBQIjELG+92NlLlPuAE1K2b7ICfhor+Cz6KIUN5tJlkdt7wEOUYtCmAUD/1UA+58AalmQgqKFaWLY7+HwTzUIBFsblTYSTuOC2jaBD4JngPDJBzUn+01UTVkuACQMvImad5W2pYPU7C+CVT1Za70c0DziuA8V/OBu6Db2a5FyLXYGTuydbWf60aex7AQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by GV1PR10MB7598.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:89::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 16:14:42 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 16:14:42 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	alexander.heinisch@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2 2/3] initramfs-factory-reset: Add option to clear partition before new fs
Date: Thu, 17 Sep 2026 18:14:06 +0200
Message-ID: <20260917161425.666709-3-quirin.gylstorff@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: cd61ca0b-935e-429f-f4fe-08df14d6c81b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|3023799007|6133799003|11063799006|56012099006|22082099003|18002099003|55112099003|10067099003;
X-Microsoft-Antispam-Message-Info: 
	LWPPmDoDSJnBBEbCCPhrMIn2Rsc5nFBtarkOFuvs46C4LKtHlZljrZF6Qj42eXg99QhEF22Nj2w991Xj60trwYBcsZPzrJipT2P9+oQFmw1fmTuwYpGG5MjarVpna7gthiwWjUX3FjgDYQhfgoxzfxJ1jRPityTWr3/WKqeln6WJ4uXD+Y9oF8AM44v+nBpNAljOVAY15iD1YUAvlR1fb3QiUmUCiEmX+XSQh+2v00Vk+5X04DUgLLjnqvG3066GQ1MHal2+IvQlioysYphr3GJruB0+AlHX+lXu5Pmf60rIhSM3O4Vnya6kZAuhmJjdQ4Z2j++kM7sqrf2KUKQ9uckyt3kziHXpk0AMDKRwRUYkwr8Ty1riJdDrQCRMKP6lDHyLh/Mh2lT9Y40yd72HOs1+pxqo83cdAxP0am32GSYks61cprZsB+vLeoAsmQeXnSWKe1P97Og1hmhbFsMa8Ujlqx5ZoixAWRQGSxq/HvScEf9syoWwD5tfFkoF1BKFX+k8Gh4zkpQ1uFES4Xm5jwHKUOEr/HnhFLeM6ElLeaPv/NV53lyb6kntTMe+6tybMO1L1hlvtqQzt3sxcJZ3X0jDuIBsN6uf4YCDxzzmIE7BFVoLFy9Bpm8mMFaXEsY/rIFqJUqFvexmIvqFf58c/7oChgPVHgaX+z/YSykc5hs=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(3023799007)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003)(55112099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?kQwKxjsvP91Af3WaeMsBc96rxDO9ergmGSntUz+tfXJFp1Hw6fASRTKpIKqZ?=
 =?us-ascii?Q?7uKf8YmUnJhz9JejVQ4HnIvgalSgTRW5z+lUA1dNXwrAZXk937Fb6gSaQDUM?=
 =?us-ascii?Q?inivBlUDBre80zQtFEwrL7mJjFdXfDN+YHQNRfBtavZl3LodLs0Y1brn04v2?=
 =?us-ascii?Q?Iszzgu/WB1/prDnhf4jmgED0FOLxWY2c1U9sdpPdE8QlLf068eHkBBJqKSIW?=
 =?us-ascii?Q?iKK2vr7L7qiJejl+ySwYK/CpLDn/Ck6RnUBSKXZGLzgDhwGq7ZIBVizSihGB?=
 =?us-ascii?Q?sANzNv9XQs5H9O1tK0ST3DPrSWn+eV2HE7fpzWhQ5QkUwMYR3IAIWsc2Zc9A?=
 =?us-ascii?Q?QEyVnLj64s2v+dtqvbd4z1HZjfOyQbXSJT/K0bpjFfFsZK5rvfSVcM22Ixe+?=
 =?us-ascii?Q?KqYhgYql/icNXw8WqQmZQT+VBq5/TbFb5ioxiiZ7xzU3tVdueQtnlJYKryB4?=
 =?us-ascii?Q?I2Pwls73XEJg++jrte3PcDQOFol5JfCIUdOlj8ZuJ86bccFzTAuA9YxAUJYm?=
 =?us-ascii?Q?Hd64iwVpYYG48Sv/lsN2dISJBeGjaJpuxn5IDTcpV0jn49dbS2DzudC9OQMl?=
 =?us-ascii?Q?IyzzJRETQr/PnvLKGDuj1tJnjoq4NHtECDwae76xLhSMb/psgqhYWH3/iuo0?=
 =?us-ascii?Q?NX6UtCGAD7vW54fwEUJpwkAlNm6ZFOzS2tomBs0DXKiUZan9OqPYDhfQtp4i?=
 =?us-ascii?Q?Fbtdn9AsaYuH2C9UrCiNCNp9FHVFr5zGMuHz44XBb/SU49oO2DCNChEe8wAG?=
 =?us-ascii?Q?57eQQ4jO5rAAUk6J7K9zIVonIHuvchYm49tYdVkjfGiNb+7tgbMYRnCYTIXf?=
 =?us-ascii?Q?JKfN1IbeJsKpkeSUdvt2h0uza/AHHwX9pQhJPyEUF8EijZRbEJfD2PLnk+nT?=
 =?us-ascii?Q?9MGoczztif4oiHhHNKeGqG/e28LUzfk+UvbexWeWJdEKekIeCWjPhfFm3E9x?=
 =?us-ascii?Q?nQMeL6lKuBlOR6I6mEH1YxY68CW07Gr02UBxxCxULLk8SnbUun14YwCNP6Z1?=
 =?us-ascii?Q?76hsDBf7q59Fclm+Nhu0TOGkoMC1tnz5U5vX0HnXtYTOnjC3IioiAHMYZ8e8?=
 =?us-ascii?Q?fmoiD/Ju/cxk/g+42+0+SEevTr51GNChQB67MGPbwQ4/B3YzLLciR975qz1H?=
 =?us-ascii?Q?NKT1LlMe+ukCCz97Blt8HHENxP+GlZdFbjQ6jCFPs74Zv/wAvKScXUfpYYCB?=
 =?us-ascii?Q?owaguvzA/CIPjFlyERz6KZrxU3ZsaLg0+lrGiAieVF69kiAYDVXms/hKheKO?=
 =?us-ascii?Q?2tM60Yr7Fs8TSYcU9zDQyPqMDItwZlbtvBYW8Yoctp/w21ySxEXzCes5vPgo?=
 =?us-ascii?Q?UxJBbSedIhl6SjGvZQgkSPIsSjzJt6pYhnTOQdcgR7vZQdMEi0XmLgBoXIrm?=
 =?us-ascii?Q?IUMhsN85WwnXKRnnWUxq542BtbwgtqKfpEI1298fdC3Hm9mjWYriL8h+AYHZ?=
 =?us-ascii?Q?wknWvSHzWgYBYgcnBq1HlK9cLe5V8tGHNopNxp0wklhLsuYxPeUpsLvGMXHt?=
 =?us-ascii?Q?ViG8b5nfNo9wwMXQbWcdPpXTDbMovB6gEQlhu1/0y8EHb7sqZNI2p36cg/Av?=
 =?us-ascii?Q?n+2wPEzsvQUDs4CU2PXo/Zn6zWLTvfARt26/os+83DvaUAHWH9GgOi3+jzrB?=
 =?us-ascii?Q?xd1ZahLFJLS9S2dq6V8MdgEF5Hij/5TXbePgFMvHxw3MiCwR8x637rrdLYes?=
 =?us-ascii?Q?uYLZvr85xOrodKOIdjlNMEUsv9wCD00qjCtvGcVpfdFxskzwAsgtO4yt51aW?=
 =?us-ascii?Q?+D5Wqr8ddpar42fhkqKFN/SJRsjFeQk=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd61ca0b-935e-429f-f4fe-08df14d6c81b
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 16:14:42.3826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZPCJMhmWdOfh2qI33+A/nv/DkxfnqHle6XfFhsy8pjJB6lid3xX9EeVUVNISYj/yXMC6dhMbx+4sv1j1RoNLkdjc5BdWaj9EIYIUtQJKVV0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB7598
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Sep 2026 16:14:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24226

This ensures that the data cannot be accessed after a factory reset.
To clear a device, attach `:clear` to the device string in the variable
`INITRAMFS_FACTORY_RESET_DEVICES`, for example:

```
INITRAMFS_FACTORY_RESET_DEVICES ??=3D "/dev/disk/by-partlabel/var:clear"
```

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../files/factory-reset-script.tmpl           | 48 +++++++++++++------
 .../files/reset-env.tmpl                      |  2 +
 ...bb =3D> initramfs-factory-reset-hook_0.4.bb} | 16 ++++---
 3 files changed, 46 insertions(+), 20 deletions(-)
 rename recipes-initramfs/initramfs-factory-reset-hook/{initramfs-factory-r=
eset-hook_0.3.bb =3D> initramfs-factory-reset-hook_0.4.bb} (78%)

diff --git a/recipes-initramfs/initramfs-factory-reset-hook/files/factory-r=
eset-script.tmpl b/recipes-initramfs/initramfs-factory-reset-hook/files/fac=
tory-reset-script.tmpl
index 94b5f8b0..e58b5460 100644
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
@@ -17,7 +17,7 @@ check_partitions()
 {
     found=3D0
     for partition in ${INITRAMFS_FACTORY_RESET_DEVICES}; do
-        if blkid | grep -q "$(basename $partition)"; then
+        if blkid | grep -q "$(basename "$partition")"; then
             found=3D$((found + 1))
         fi
     done
@@ -33,20 +33,25 @@ wait_30sec_for_condition check_partitions
=20
 if /usr/sbin/get-factory-reset.sh --delete | grep -q "factory-reset"; then
     log_begin_msg "Factory Reset"
+    # service watchdog in the background during lengthy disk wiping
+    start_watchdog "${WATCHDOG_DEV}" "${SETUP_TIMEOUT}"
     for target in ${target_devices}; do
-        log_begin_msg "Reset device: $target"
-        fs_type=3D$(get_fstype "${target}")
-        case "$target" in
+        wipedisk=3D"false"
+        target_device=3D"$target"
+        log_begin_msg "Reset device: $target_device"
+        fs_type=3D$(get_fstype "${target_device}")
+        case "$target_device" in
             *by-partlabel*)
-                label=3D"$(basename "${target}" )"
+                label=3D"$(basename "${target_device}" )"
                 ;;
             *)
-                label=3D$(blkid --match-tag LABEL "$target" | awk -F=3D '{=
gsub(/"/,"");print $2}' )
+                label=3D$(blkid --match-tag LABEL "$target_device" | awk -=
F=3D '{gsub(/"/,"");print $2}' )
                 if [ -z "${label}" ]; then
-                    log_warning_msg "Could not find any label  for target =
'$target'"
+                    log_warning_msg "Could not find any label for target '=
$target_device'"
                 fi
                 ;;
         esac
+
         if [ "$fs_type" =3D "luks" ]; then
             if [ -n "${INITRAMFS_FACTORY_RESET_CLEAR_TPM}" ]; then
                 # after this the data on the encrypted partition
@@ -56,23 +61,38 @@ if /usr/sbin/get-factory-reset.sh --delete | grep -q "f=
actory-reset"; then
                 # use a variable from the reset-env to set it
                 fs_type=3D"$INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE"
             else
-                target=3D$(find /dev/mapper -iname "*$label")
-                fs_type=3D$(get_fstype "${target}")
-                echo "luks device detected use $target"
+                target_device=3D$(find /dev/mapper -iname "*$label")
+                fs_type=3D$(get_fstype "${target_device}")
+                log_success_msg "luks device detected use $target_device"
+                wipedisk=3D"true"
             fi
+        else
+            wipedisk=3D"true"
         fi
+
+        if [ "${wipedisk}" =3D "true" ]; then
+            log_begin_msg "Clear device $target_device"
+            device_size=3D$(blockdev --getsz "${target_device}")
+            if ! dd if=3D/dev/zero of=3D"${target_device}" bs=3D512 \
+                    count=3D"${device_size}" conv=3Dfsync; then
+                log_warning_msg "Could not clear partition $target_device"
+            fi
+            log_end_msg "Finished clearing device $target_device"
+        fi
+
         case ${fs_type} in
             ext*)
-                /sbin/mke2fs -L "${label}" -F -t ext4 "${target}"
+                /sbin/mke2fs -L "${label}" -F -t ext4 "${target_device}"
                 ;;
             btrfs)
-                /sbin/mkfs.btrfs -L "${label}" --force "${target}"
+                /sbin/mkfs.btrfs -L "${label}" --force "${target_device}"
                 ;;
             *)
                 log_warning_msg "Unrecognized filesystem type ${fs_type} -=
 could not format"
                 ;;
         esac
-        log_end_msg "Reset device: $target"
+        log_end_msg "Reset device: $target_device"
     done
     log_end_msg "Factory Reset"
 fi
+stop_watchdog
diff --git a/recipes-initramfs/initramfs-factory-reset-hook/files/reset-env=
.tmpl b/recipes-initramfs/initramfs-factory-reset-hook/files/reset-env.tmpl
index 07e2376a..663b0af0 100644
--- a/recipes-initramfs/initramfs-factory-reset-hook/files/reset-env.tmpl
+++ b/recipes-initramfs/initramfs-factory-reset-hook/files/reset-env.tmpl
@@ -2,5 +2,7 @@
 #
 # SPDX-License-Identifier: MIT
 #
+WATCHDOG_DEV=3D"${INITRAMFS_WATCHDOG_DEVICE}"
+SETUP_TIMEOUT=3D"${INITRAMFS_SETUP_TIMEOUT}"
 INITRAMFS_FACTORY_RESET_DEVICES=3D"${INITRAMFS_FACTORY_RESET_DEVICES}"
 INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE=3D"${INITRAMFS_FACTORY_RESET_LUKS=
_FORMAT_TYPE}"
diff --git a/recipes-initramfs/initramfs-factory-reset-hook/initramfs-facto=
ry-reset-hook_0.3.bb b/recipes-initramfs/initramfs-factory-reset-hook/initr=
amfs-factory-reset-hook_0.4.bb
similarity index 78%
rename from recipes-initramfs/initramfs-factory-reset-hook/initramfs-factor=
y-reset-hook_0.3.bb
rename to recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-=
reset-hook_0.4.bb
index 670725b7..ccb8a72b 100644
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
@@ -17,11 +17,13 @@ DESCRIPTION =3D "Delete the content of the given Device=
s"
 # list of partitions by label
 INITRAMFS_FACTORY_RESET_DEVICES ??=3D "/dev/disk/by-partlabel/var"
 INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE ??=3D "ext4"
-INITRAMFS_FACTORY_RESET_CLEAR_TPM ??=3D '0'
-INITRAMFS_FACTORY_RESET_CLEAR_TPM:encrypt-partitions ?=3D '1'
+INITRAMFS_FACTORY_RESET_CLEAR_TPM ??=3D "0"
+INITRAMFS_FACTORY_RESET_CLEAR_TPM:encrypt-partitions ?=3D "1"
+INITRAMFS_SETUP_TIMEOUT ?=3D "600"
=20
 # to support factory reset on btrfs, add 'btrfs'
 INITRAMFS_FACTORY_RESET_FSTYPES =3D "${INITRAMFS_FACTORY_RESET_LUKS_FORMAT=
_TYPE}"
+INITRAMFS_WATCHDOG_DEVICE ??=3D "${@'/dev/watchdog' if int(d.getVar('WDOG_=
TIMEOUT') or 0) > 0 else ''}"
=20
 SRC_URI +=3D " \
     file://factory-reset-script.tmpl \
@@ -33,7 +35,9 @@ FACTORY_RESET_HOOK_TARGET =3D "${@ 'local-top' if bb.util=
s.to_boolean(d.getVar('IN
 TEMPLATE_FILES +=3D "reset-env.tmpl factory-reset-script.tmpl"
 TEMPLATE_VARS +=3D " INITRAMFS_FACTORY_RESET_DEVICES \
                    INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE \
-                   INITRAMFS_FACTORY_RESET_CLEAR_TPM"
+                   INITRAMFS_FACTORY_RESET_CLEAR_TPM \
+                   INITRAMFS_WATCHDOG_DEVICE \
+                   INITRAMFS_SETUP_TIMEOUT "
=20
 RDEPENDS =3D "factory-reset-helper \
             initramfs-cip-functions"
@@ -41,9 +45,9 @@ RDEPENDS =3D "factory-reset-helper \
 DEBIAN_DEPENDS .=3D ", coreutils, util-linux, e2fsprogs, awk, \
                     factory-reset-helper, findutils, initramfs-cip-functio=
ns"
 DEBIAN_DEPENDS:append:encrypt-partitions =3D ", tpm2-tools"
-HOOK_COPY_EXECS =3D "mountpoint findmnt mktemp basename \
+HOOK_COPY_EXECS =3D "mountpoint findmnt mktemp basename dd \
                    mke2fs awk blkid rm get-factory-reset.sh \
-                   chattr grep find"
+                   chattr grep find blockdev seq"
 HOOK_COPY_EXECS:append:encrypt-partitions =3D " tpm2_clear"
=20
 OVERRIDES .=3D "${@':btrfs-support' if 'btrfs' in d.getVar('INITRAMFS_FACT=
ORY_RESET_FSTYPES') else ''}"
--=20
2.55.0


