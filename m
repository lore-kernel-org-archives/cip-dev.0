Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11B9C61DB9
	for <webhook@archiver.kernel.org>; Tue, 25 Aug 2026 14:38:17 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.59])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23566.1787668694022419751
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Aug 2026 07:38:16 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=SK4IIiBA;
 spf=pass (domain: siemens.com, ip: 52.101.83.59, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KfxlYEmOiVDMIMNt06MlQ9aEbP7K1lHQ3oJh8KjcNEST5a8jp1PNlo1C+6UiV9PTF0ojAQO3qB+xrd3yzq/qFhsI2TRJbMbcJrkvBguc2WmGuowSv9rtpvS8eh1ALmpZGkwCQNBtnvjNzRWvY2o5suqbh+5Nx75EyZQoc7kdaD6/d5fkammBEKSyCaQYHOKBB87/rqNO469ZnWLUFeoHpbAi1SBNDfD/AWVgjPpmB4h9KCAATNwsbYrSR7TCEyvmFx5N8svih10d/O+ztLzERRME97iDGn/FSKU1xKyRfjrwZTGc32wwKFr4Q1YpJCEdNnIpDB1iHe0MXzf29L526A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nf4csfrBe8RexTSmy1wfSgNlpnJa9S0EmC6h82klznM=;
 b=RYo7b+HD8/H7DXgZEuWtQhIF1ltgn1n91xp/mr+opB1K6RPCryTOO97qV54tVQszmOt39iwXDlwwF0r7Ski4/A44UHh7gVOijO7Wgkc9QFF6zh6TkWj0fvo9jNOYu5gonnWM0+JE/KrsgQH1SF4RkcnKtogRSJdsjlH4zdw54qMsg3LJxHGRODDhQBx3Z961x9EJoSKfIViBBVkYHo1V5V/+ecsVIbmElq/CSmYmg3GAd/n1vXC0UN4vn0zJsEimhCGNmxD5GxPxKplYsEwQAvChx43FvSfKe9Krfy9IKuSyTvFKXcaek1Yqor2gQmuVw7Hz87Aoy+jPcYm7cyAN/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nf4csfrBe8RexTSmy1wfSgNlpnJa9S0EmC6h82klznM=;
 b=SK4IIiBAG9GwlnKwtYKkN+ITcp00AYGCdSy/Mv+7rlOgccPub35PUrdsbMiKstQXkgHNYzt5DLNuxs7JbUg9FfUuWh6ACCu1KVGt41PywiLm3ejvWMVLdTXXZJe7v/VrrnCMUwJr7JeIPEu2r7UTh9pjx34cF/7C3fD+QV05ItoQjSEQJS5prAH8yoxHKbKZF+EOhV5AiqQ7WJUzdGsvyober+glBtbZqubUbndkgHliS+FE5S7JGAIXekPVk1t6B01h9qgpEzquht4WFgeWsaFW5Xe4fHHmQE25dHz0tgE4U9IkkYNBBul1Hgw9RVHNQJBwasG+Wl6fZwyw36sVcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by PAWPR10MB7126.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 14:38:09 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%5]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 14:38:09 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	alexander.heinisch@siemens.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][RFC 2/2] initramfs-factory-reset: Add option to clear partition before new fs
Date: Tue, 25 Aug 2026 16:37:48 +0200
Message-ID: <20260825143802.3764929-3-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825143802.3764929-1-quirin.gylstorff@siemens.com>
References: <20260825143802.3764929-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0081.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::14) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|PAWPR10MB7126:EE_
X-MS-Office365-Filtering-Correlation-Id: 749320e7-4755-47b7-d38f-08df02b67bf0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|6133799003|10067099003|56012099006|11063799006|18002099003|55112099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: 
	DSIEPbD7Jd1/aVjBDH1MckpB7caCyH6tndrZNorFtiRg6IEygF+2X1vw7qDpSiZg3YWethvflS0dw1l+68C2gTrclE5X8ZHMIsp26/Fl7MYDars14uHAjX99UuozTSWDGK5KT9jSKcG6/vfSetEN3CFVtGYeljSXUnGE8I5ObymNUJNNS82Sr1++XjUpPopYnxE88W9sgfIdR4ehOjbTDXnJVxB07Nyuakz4o/lqglREGcDhs4bZCxdP91BAeXYk5lnP5rtkJd9VT8cRElVCT+6H/WxFo0LSf0oR2LwMmnriClT6V8y3DITqQ2MmIM+ase268KoSsj5yfteCHELr0RBdIDPZCPDUjMDeUKmPGxa76pQphzeKvCR97i85u7YD52IK4ZsWsVGlo6lr6bJ3EkmqyODVrQ2BtvD20gV2+hYNQjfHIyyKSQ7NFIFb/s01cgxhW9JPUJP3Y/daE4a+kVl2uoQbrvLJF/sk4mN/duNJvB/yyPJjPHjhN0iBKViMajZthWkt5cOKFOEQtFQD+r/HdvE+2evzTQ9K55kCMCjAxsbPWbTT0nVE/8dxSIP+IbNa0r15Ug8JJuuOfnyLnwMxEby0JsuU1x403ruJAZAwARneT8oquGDxp/swXbHDa6bknLnL0/FVJqjq8W0lQN24g9A303X2/hRxth/15Y8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(55112099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?xlYHOEer4xY83FOgyl5g5KlDNOnctpvEncl8kdXaQjPOhPqhMlDb43IcBU+C?=
 =?us-ascii?Q?iS3hk4Q4JZclVCYpl6KD/4hL4vSnfk5uv0XJbopV2FEavANMULPed2BUA+qS?=
 =?us-ascii?Q?x6OlH30o41o8BSSfToVPRJql2inPn7UfgXGWFwX5Q/xyim81oWNArY7Yi7Tn?=
 =?us-ascii?Q?NMEDw4NnNLdJ1+EgAHTyq9bfr5MQ93EXj3Cj7cBdpbQr+xy9OZmQh6yWuwuJ?=
 =?us-ascii?Q?0N9xK+0HL57fvnM5vd0PBFkOHh7R7xR3rJz5v8f6QbLD+29ukjMotW9eRBCF?=
 =?us-ascii?Q?yo1DZRtLFqAddA0z8ZHkFPa9VhFXeq+P7CVf5RnbpJ5xCPxBU8+s167t7XYR?=
 =?us-ascii?Q?jiB7DYsYHvh/JiBwMrzh5WNS8WVUwcLy5P05oBgmc2VYfJ4xAhyESeT2W+3n?=
 =?us-ascii?Q?FHJQUrgnZjzwqkouVT5hgvpHsz9ExbTswk1ZPfPzT7AylHhIAfW/pgVwPJvS?=
 =?us-ascii?Q?Ww7ZuiMpoLWqmMW7wB2sCbrVUa218AxcV9YP2A1o7eNRgjZvXd6EXnE91nL7?=
 =?us-ascii?Q?nga6THAPgAO34dxQPA6eQ1O4GzblajRIWzRnDZ4IPr+PgOjox8wRNID4u79D?=
 =?us-ascii?Q?xyS5KVI+dvnqwhvPmxiBtNJA7qyiI/3i+a78IG5rjfoHupzeMRtaNNxymmqv?=
 =?us-ascii?Q?hY1RwloIUivPXH3uc8d0YhY1B3QLRHloFA3N+fYjD6woEUnV4pal/3tM+Xln?=
 =?us-ascii?Q?O9Y3Dw59ddg9KGd3XT0HnN3ZIRocnVBxqejiUd5D/COvbrwHtbcTDb0ZXIKS?=
 =?us-ascii?Q?IucIvrk2r1KosVpW/g8++ZnPY0z5YqA0Ufxzi+uF3oy63nTjU/+oQCcrVMzt?=
 =?us-ascii?Q?8Jl4DAd1K6DJL60B4d7AkESvCKZy2sNU0m7zj8nlzn2WYoTJfsMmMceFaGfp?=
 =?us-ascii?Q?8WgkxDj5ryFS+AfWmCVxmoWoNRxgKvYXzVRRsGtmeQZNyHKwFbgUVWdBhLvD?=
 =?us-ascii?Q?+fx+AJPflLiPNe6otVrmulO0XUN/aTECQgcvRWqr2JaJeYm5nuu1yrWq0a/V?=
 =?us-ascii?Q?KfFXOiWt72IOMmT/tQDHvz+aeETB5f8kvl3tXeVfhst/KRayqGKinQbNYEQs?=
 =?us-ascii?Q?iMjCGHHBHvDkAFEGvael3B0/xz7/iGClcqIKTEWlIw4ymm4EsFFOAKSyMG08?=
 =?us-ascii?Q?7VfjMLp/E2n25/rQQIC9Yr68EE4sLcFbkV3NpF7OdfoRnA/Ecrjs/tGim6fo?=
 =?us-ascii?Q?Gh8JuB5zyTAZ7oIRPI0gK8aXLKqXuf9aKra09/IMY/h7Gt27PjLfgExqfayi?=
 =?us-ascii?Q?z4t5xFckmcl6XEWZZvs3ihc2opfc7He8WLP1vrmzBON5ugEgZKnOLkgtUNf1?=
 =?us-ascii?Q?qvGKLvMR48icg/mIJ0hAbPCyTZdyijnxLArhqJWeAO9v/+6/dNQ5Z1qn4lpv?=
 =?us-ascii?Q?9W6DQE+8HsELhIgZ7/DmEVTd/60S6ek6LU77/Y8DtO8TqJa1wweKOkseyA2y?=
 =?us-ascii?Q?wIDfQjCN0vuL2TieRV2jcwor4nfQO2PXeNkAIaR3+DQB3BhUTEd5nDkSgQvV?=
 =?us-ascii?Q?WXsZkQ6QANS6IcST5r1Uy56uoa7g4cHOH6ez0RFkSMHChwv5gb+uSORlKYJ9?=
 =?us-ascii?Q?d/4Z1VDHqb82blEkJUdis3oZ0elm1VpxM1oCIe0LeIHqSWGE9XeziHZ2Jtdf?=
 =?us-ascii?Q?xu02alHN/ui4uycLU3h4mK2ICW6ZZSvBMmKdTgskYhWaoUnrCyLu0Du0DhAi?=
 =?us-ascii?Q?0Qsh/UJ2oPqseJgtvaXZKVzQLk9FyxtR9yUjin5l6NF5sxnhsJD8ljb1Jogs?=
 =?us-ascii?Q?SNnaBYnnIbR7n+0Ufi06Ae+g8gOx8Hs=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 749320e7-4755-47b7-d38f-08df02b67bf0
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 14:38:09.8018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S0oPOpRVTspG+jQfQPfEHuIcG9ZiEb4uC6x7+oUYKV9OcyX5R02UycUQOe2WF0jaMGcsDXIMZSMqf6mGZ02JMayy9ffrWy7LPZyAycLVLdE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7126
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Aug 2026 14:38:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24000

This ensures that the data cannot be accessed after a factory reset.
To clear a device, attach `:clear` to the device string in the variable
`INITRAMFS_FACTORY_RESET_DEVICES`, for example:

```
INITRAMFS_FACTORY_RESET_DEVICES ??=3D "/dev/disk/by-partlabel/var:clear"
```

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../files/factory-reset-script.tmpl           | 69 +++++++++++++++----
 .../files/reset-env.tmpl                      |  2 +
 ...bb =3D> initramfs-factory-reset-hook_0.4.bb} | 21 +++---
 3 files changed, 69 insertions(+), 23 deletions(-)
 rename recipes-initramfs/initramfs-factory-reset-hook/{initramfs-factory-r=
eset-hook_0.3.bb =3D> initramfs-factory-reset-hook_0.4.bb} (73%)

diff --git a/recipes-initramfs/initramfs-factory-reset-hook/files/factory-r=
eset-script.tmpl b/recipes-initramfs/initramfs-factory-reset-hook/files/fac=
tory-reset-script.tmpl
index 94b5f8b0..8f95d780 100644
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
@@ -13,11 +13,27 @@
=20
 . /scripts/cip-initramfs-functions
=20
+# entries of INITRAMFS_FACTORY_RESET_DEVICES have the form
+# <device>[:clear] - return the device part
+target_device_of()
+{
+    echo "${1%%:*}"
+}
+
+# return the option part of an INITRAMFS_FACTORY_RESET_DEVICES entry
+target_option_of()
+{
+    case "$1" in
+        *:*) echo "${1#*:}" ;;
+        *) echo "" ;;
+    esac
+}
+
 check_partitions()
 {
     found=3D0
     for partition in ${INITRAMFS_FACTORY_RESET_DEVICES}; do
-        if blkid | grep -q "$(basename $partition)"; then
+        if blkid | grep -q "$(basename "$(target_device_of "$partition")")=
"; then
             found=3D$((found + 1))
         fi
     done
@@ -30,23 +46,34 @@ check_partitions()
 target_devices=3D"${INITRAMFS_FACTORY_RESET_DEVICES}"
=20
 wait_30sec_for_condition check_partitions
-
 if /usr/sbin/get-factory-reset.sh --delete | grep -q "factory-reset"; then
     log_begin_msg "Factory Reset"
+    # service watchdog in the background during lengthy re-encryption
+    start_watchdog "${WATCHDOG_DEV}" "${SETUP_TIMEOUT}"
     for target in ${target_devices}; do
-        log_begin_msg "Reset device: $target"
-        fs_type=3D$(get_fstype "${target}")
-        case "$target" in
+        target_device=3D$(target_device_of "$target")
+        target_option=3D$(target_option_of "$target")
+        case "${target_option}" in
+            ""|clear) ;;
+            *)
+                log_warning_msg "Unknown option '${target_option}' for tar=
get '$target_device' - ignored"
+                target_option=3D""
+                ;;
+        esac
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
@@ -56,23 +83,35 @@ if /usr/sbin/get-factory-reset.sh --delete | grep -q "f=
actory-reset"; then
                 # use a variable from the reset-env to set it
                 fs_type=3D"$INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE"
             else
-                target=3D$(find /dev/mapper -iname "*$label")
-                fs_type=3D$(get_fstype "${target}")
-                echo "luks device detected use $target"
+                target_device=3D$(find /dev/mapper -iname "*$label")
+                fs_type=3D$(get_fstype "${target_device}")
+                echo "luks device detected use $target_device"
             fi
         fi
+
+        if [ "${target_option}" =3D "clear" ]; then
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
similarity index 73%
rename from recipes-initramfs/initramfs-factory-reset-hook/initramfs-factor=
y-reset-hook_0.3.bb
rename to recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-=
reset-hook_0.4.bb
index 670725b7..c192c38c 100644
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
@@ -15,13 +15,15 @@ MAINTAINER =3D "cip-dev <cip-dev@lists.cip-project.org>=
"
 DESCRIPTION =3D "Delete the content of the given Devices"
=20
 # list of partitions by label
-INITRAMFS_FACTORY_RESET_DEVICES ??=3D "/dev/disk/by-partlabel/var"
+INITRAMFS_FACTORY_RESET_DEVICES ??=3D "/dev/disk/by-partlabel/var:clear"
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
@@ -33,17 +35,20 @@ FACTORY_RESET_HOOK_TARGET =3D "${@ 'local-top' if bb.ut=
ils.to_boolean(d.getVar('IN
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
=20
 DEBIAN_DEPENDS .=3D ", coreutils, util-linux, e2fsprogs, awk, \
-                    factory-reset-helper, findutils, initramfs-cip-functio=
ns"
+                    factory-reset-helper, findutils, initramfs-cip-functio=
ns, \
+                    psmisc"
 DEBIAN_DEPENDS:append:encrypt-partitions =3D ", tpm2-tools"
-HOOK_COPY_EXECS =3D "mountpoint findmnt mktemp basename \
+HOOK_COPY_EXECS =3D "mountpoint findmnt mktemp basename dd \
                    mke2fs awk blkid rm get-factory-reset.sh \
-                   chattr grep find"
+                   chattr grep find blockdev seq fuser"
 HOOK_COPY_EXECS:append:encrypt-partitions =3D " tpm2_clear"
=20
 OVERRIDES .=3D "${@':btrfs-support' if 'btrfs' in d.getVar('INITRAMFS_FACT=
ORY_RESET_FSTYPES') else ''}"
--=20
2.55.0


