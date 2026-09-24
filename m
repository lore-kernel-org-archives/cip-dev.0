Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD0FC98317
	for <webhook@archiver.kernel.org>; Thu, 24 Sep 2026 11:30:50 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5721.1790249447356994503
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Sep 2026 04:30:47 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=w2sC4Alz;
 spf=pass (domain: siemens.com, ip: 52.101.83.43, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gd7DD9hHXkSf79srAYjkZysJFVpjdyCt/No/kPNAKDy/2Om5RjyStmHlT6epqSTrZAECN8VWLYMWrj6pfQcyoqdAR7jFreSmukNwfXHEA6yTG4EX2i4L0zETXCeThDDsHusSZyxLNdU8JgBIrhPrn+xlEUmgF+bT6mF/IIVGd2wiwf900vvA7oufOqUD7G+UFy75p9yWxJ4ETfedEHoi5jZRqoygVJfOsSnYfeuFit3yVzaAIV7dLpMS0qG+UEKzn4RDbsm4N6d0sYrDjYc2807/TJMwPBHk+8CgEf9a66caLkySW7eC4keBbRHkg3qh1YKJble8UfStju/AL3He3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9eW4CcIY1/8GKaX8iTnDvta7BvZC4DKeFF+XWBHL30=;
 b=inpxlA4BtTGIxzQdBsi52zBIiOzyA4VVCdFE63V1jtxLSR32JtxWY57eC0Rpczq4wHYKHUl94i+X4ZaEc5yDqJbAoildLnibbg20WWK4cGWN+xNe7mLVk/f6wrKhjNNHqPoEHnIY4Ny3UCmzd4+s3T5h1DvzOuEt9x3isIQ0XYhNaQEC4c66UZ0TjREE/g2vSoYVyW8q63YDoWU21avFzEPnJBkx0HBHMvr3j+LNX2DwF4CzLIVAhX2oj9JzCVdPVTtXHRqlCqSh3DvAOX/kQz1/nmnAggKX+dag9dCoxi3+osGBUch15xETI66pn1xWGMwehSv2zhNoHYUj/8itBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9eW4CcIY1/8GKaX8iTnDvta7BvZC4DKeFF+XWBHL30=;
 b=w2sC4AlzRwLZ0Df9yQVQ4p87uOIkZGEfOqv1jQQcyxha+UopMllHFv5ygpCI3dzYEkFNywQSyhcp1j3BoLodTJf8XS8ooMuX3RSo5LrxBu2Ldf1SJdsEpqMPmu6MPycg/x6Mmruzhaty6ki5SBXeTCRbrjkxx/Gejg+NNLItDRhe+eYHhsaINjSnVDep6xOf7r+JcYZasQjITxxY7+P5Lg0tZvjnavaXZLdIebBeQMJMxwlng2HUnJygAI03LTcGimcBMyX1DPFqba+Ey9oNpmGXXnrbvfefTdSiinDqEAC/bFIfFYYJ3OEqljJqBwPpzJJXt8JZk769gPF1NXSfGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17f::18)
 by DB8PR10MB3308.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.22; Thu, 24 Sep
 2026 11:30:40 +0000
Received: from AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5511:7126:a2d7:f914]) by AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5511:7126:a2d7:f914%4]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 11:30:40 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	alexander.heinisch@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v3 5/5] initramfs-factory-reset: Wipe partition before creating a new fs
Date: Thu, 24 Sep 2026 13:30:21 +0200
Message-ID: <20260924113028.3191076-6-quirin.gylstorff@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: d133a0cb-745c-4183-a017-08df1a2f4349
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|6133799003|11063799006|56012099006|3023799007|55112099003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: 
	RpPGlRKB7aTsv7OYfbjTIBvRaDvlzp8wqZzNeFOfgdxRvgnajvNd9rM1l15xpwfBAOgAEHT0F+QNC0uAmgNPbf0RorXbou8UNiBJ9tTE5UAF+3SczA5oj6RBR+8/a1Y7zdgf8+osMpONpHwd6griFl6YibzG6haHG9ff9CtAniAjZeS4sQmlXqLX3WLl7Azg3Jah0fpYYZw04dRnS44EBeWP9SAEYBj64AVhK1dSHiIqJKafpxT1yITyhJ2lrKE+sTKU1dMiLM5oNDFD8Y9PK9XORVN2sbePx3L5tQzWXrQTZGPr0LSSWztSjcJspUIJTBPq/Qoxo3MdpRMnZ21FWirBXVYqlUgnVQ04xkMNZwHWs176K3qOMKkbodcVxK9SKA4nIdeIomdpibnC3l6BrhHIAff5jYJOuWcAtE374566H2L4ZdAULLy04HKPkUC/qGgMGwp+DthLSSNGbqxOWLNkFfruc9P41woMfdhF7ouY1BQAK8u7TkuwQtEI9Pi8MyNS1IjqCE+k91WgBPf5gza80wEGmGXs6HZ0c3NZHw3YY19dQ6kWHmLmYIT9lLO1m1mPTYf8l8XIvbBPPf3B2Yx2C3v2JwLCHWY5f7gxV2peI5laA1w82Xe5E/eM7UijENp/nicT0sHpKs52myLX1J6FBoRq68re0twat7eLIwE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(6133799003)(11063799006)(56012099006)(3023799007)(55112099003)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Wx/3W/dR3dskHxaQjxunNVMht0u9obRdDiqt630GZ+ZpD6LbP0adZNNydzoE?=
 =?us-ascii?Q?zgbdb17lp4TQ+ZgzxxH3pBiDwnFHv2YqvhwPlhALwqjuP4pQ4T+HFVqTlNgO?=
 =?us-ascii?Q?cipwJjO6bB49Duovtib9rG8XvRd2WcofHEqmu32siRIWD0HZJjo1OEKe8H9e?=
 =?us-ascii?Q?WqmtEZLODCqN5k6FpXzr4Tn45pYQ5HMb3g0O2PWVIVgJwp4g1dxmkhmr3tzk?=
 =?us-ascii?Q?xkgD0Pr/llPmGzYRo0yYlyQn2Fb2d0iEoP8bourFE9xs2vlHPRTq28sBmpD0?=
 =?us-ascii?Q?YQ5Xncn+YKAhYNleujMIarMIoMjli5HLFvAYFngLZ3DhS1BOzpiWEPPwaERi?=
 =?us-ascii?Q?0gBMOx0gZe8K2+h5J1FLZmBEF9hrW47lx+De4gGQCnZsKa+U7f2DGynlk+Bq?=
 =?us-ascii?Q?RIsAw5H7cvsQ1xvumfYf40LQUUFaKEMplqz1KMIYjphfejaUlxnSRNnIq+HV?=
 =?us-ascii?Q?r6v8vLFBILsZ1VQvhIs26T5Kj+mQ8vtelpHncpf6fxHvkRF+Cihb3BkdlbSr?=
 =?us-ascii?Q?AeLtTd3onhcsLM4wF4VXQbuSHDsDnRXfSTA7oqvMiRuW7u95EiaZabr/CER6?=
 =?us-ascii?Q?cI2rliCapRawFtlac8xwgn/hFSBDS8aa5IXpCr7fZ599LLxybidy5R1qPOQQ?=
 =?us-ascii?Q?+2dMnWpzEI3nyN/eS91RwM0tKlWcFGXSSwSb/XhF+W2LvtCwEk0JXUHbalmq?=
 =?us-ascii?Q?WVlNJ/5OdgJGVlUHsgLhZcvCrW+4RTdaWrnyfoY62jfV66gIElXUHY+4SPza?=
 =?us-ascii?Q?3fGh+wHwEuRRBP7dt0bUO050uGi17tox7QikgAFxxakLAYc7xWlMt6H85fS7?=
 =?us-ascii?Q?fGJUBD30ryI7B29WSBaVxFD71eUr2A6h2dKPfWU38tfXkEeHWhS1842+ACDa?=
 =?us-ascii?Q?hHCmlM+5b88c3gZBufJgnuo/maT91CiewkSra9PTibShrhuNwjE9e41t/w1m?=
 =?us-ascii?Q?1RxfxO5qG1/bLrAQg0O6W7PwEoDBbb2j68e112TSgTBidg4qhAhSNOwG+GTP?=
 =?us-ascii?Q?Q30qfMznJ4raPD9ZKHHm7rd68eaWWGDdOyCuOROU+V7rbC4pV2o4hB2PyKRa?=
 =?us-ascii?Q?CJfBWzMrEoNzbvSiiwqE2rVl6NV7PXwcAIbgDex1vyGJ8NKy6KKrNDLjRoXz?=
 =?us-ascii?Q?W/09Td++ouhWoJJAKWMKmyQy8USxLmacQY6b6qFCcJvJXgpEjVdao5Tm8Cjd?=
 =?us-ascii?Q?xC8onOjTimZ7R1FqqTt9GJ5phxLYlOys3Cn4ZDWU5b//1MuwgXN+5N1TXz2O?=
 =?us-ascii?Q?zDexgXaljattbc7BH+EVmfDkmsZ/7qwkTVw2dMTwFBGFEI2iK7/ljDgF58Yd?=
 =?us-ascii?Q?cTrBvqI5UAnf3/6Hne0fv3QKAU8yzWMzL8Ir9/RjAuooFUshnsPidE5nEDOB?=
 =?us-ascii?Q?4Z7PHud2Yi9gv8ipDc5OWNqbDXsP6vEA94l8Jx//DSFYFYdeEqdt7bwvEfju?=
 =?us-ascii?Q?Nw4QtNfaWHvM34uF3AIpS6onIJQ4PvxSBg/yelJ+bcK2mBv1GlMp51xdYG+M?=
 =?us-ascii?Q?jePdSDgAZP74ohQ5mFkzLe5oZwoNBWZkVqCJP9u9n7CACNiZu5LgKy/kYnGe?=
 =?us-ascii?Q?Fb9WFefvbLi+mSzlE4qY8ojRMGgpGlQpjMchVbMrc5D2Cy892yTA8UmzMGNU?=
 =?us-ascii?Q?BwFi0K01mbiHKiJhXYLU/BB4Ao2zKTYy/fvILQy3YdVY5+Z+PKWLNFY2L+9u?=
 =?us-ascii?Q?VA72LZ6r/O3P3xW8q0IdO6mmk8Y7SreEDMKQWBZaf/iipBn/SvH2ZgaJV0Gq?=
 =?us-ascii?Q?mnYpElqiBQTOA/w+/3ccOP0Zqhxuib4=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d133a0cb-745c-4183-a017-08df1a2f4349
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 11:30:40.5955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y385dQtO/CFJeqfbAnSK2UX9W3G2mkSiZR38YsRTflwcpljyHXL+jQhiBKaHC2Bg8zsShI98zfLAgMH8Q7QAxpo/AlLBaQ32vhawIvrbfn4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3308
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Sep 2026 11:30:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24313

This ensures that the data cannot be accessed after a factory reset.

A partition is wiped if disk encryption is disabled or if
INITRAMFS_FACTORY_RESET_CLEAR_TPM is set to '0'. If the TPM is cleared,
the LUKS key is gone and the old data is inaccessible anyway, so the
partition is only reformatted.

The watchdog is serviced during the wipe. The timeout can be set via
INITRAMFS_FACTORY_RESET_TIMEOUT, which defaults to
INITRAMFS_SETUP_TIMEOUT or 600 seconds.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../files/factory-reset-script.tmpl           | 21 ++++++++++++++++++-
 .../files/reset-env.tmpl                      |  2 ++
 .../initramfs-factory-reset-hook_0.4.bb       | 14 ++++++++++---
 3 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/recipes-initramfs/initramfs-factory-reset-hook/files/factory-r=
eset-script.tmpl b/recipes-initramfs/initramfs-factory-reset-hook/files/fac=
tory-reset-script.tmpl
index 851aa823..3216dc9b 100644
--- a/recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-sc=
ript.tmpl
+++ b/recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-sc=
ript.tmpl
@@ -33,7 +33,10 @@ wait_30sec_for_condition check_partitions
=20
 if /usr/sbin/get-factory-reset.sh --delete | grep -q "factory-reset"; then
     log_begin_msg "Factory Reset"
+    # service watchdog in the background during lengthy disk wiping
+    start_watchdog "${WATCHDOG_DEV}" "${SETUP_TIMEOUT}"
     for target in ${target_devices}; do
+        wipedisk=3D"false"
         target_device=3D"$target"
         log_begin_msg "Reset device: $target_device"
         fs_type=3D$(get_fstype "${target_device}")
@@ -48,6 +51,7 @@ if /usr/sbin/get-factory-reset.sh --delete | grep -q "fac=
tory-reset"; then
                 fi
                 ;;
         esac
+
         if [ "$fs_type" =3D "luks" ]; then
             if [ "${INITRAMFS_FACTORY_RESET_CLEAR_TPM_BOOL}" =3D "1" ]; th=
en
                 # after this the data on the encrypted partition
@@ -59,9 +63,23 @@ if /usr/sbin/get-factory-reset.sh --delete | grep -q "fa=
ctory-reset"; then
             else
                 target_device=3D$(find /dev/mapper -iname "*$label")
                 fs_type=3D$(get_fstype "${target_device}")
-                echo "luks device detected use $target_device"
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
                 /sbin/mke2fs -L "${label}" -F -t ext4 "${target_device}"
@@ -77,3 +95,4 @@ if /usr/sbin/get-factory-reset.sh --delete | grep -q "fac=
tory-reset"; then
     done
     log_end_msg "Factory Reset"
 fi
+stop_watchdog
diff --git a/recipes-initramfs/initramfs-factory-reset-hook/files/reset-env=
.tmpl b/recipes-initramfs/initramfs-factory-reset-hook/files/reset-env.tmpl
index 07e2376a..8b0bdb20 100644
--- a/recipes-initramfs/initramfs-factory-reset-hook/files/reset-env.tmpl
+++ b/recipes-initramfs/initramfs-factory-reset-hook/files/reset-env.tmpl
@@ -2,5 +2,7 @@
 #
 # SPDX-License-Identifier: MIT
 #
+WATCHDOG_DEV=3D"${INITRAMFS_WATCHDOG_DEVICE}"
+SETUP_TIMEOUT=3D"${INITRAMFS_FACTORY_RESET_TIMEOUT}"
 INITRAMFS_FACTORY_RESET_DEVICES=3D"${INITRAMFS_FACTORY_RESET_DEVICES}"
 INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE=3D"${INITRAMFS_FACTORY_RESET_LUKS=
_FORMAT_TYPE}"
diff --git a/recipes-initramfs/initramfs-factory-reset-hook/initramfs-facto=
ry-reset-hook_0.4.bb b/recipes-initramfs/initramfs-factory-reset-hook/initr=
amfs-factory-reset-hook_0.4.bb
index aaa194b0..d3a4261a 100644
--- a/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-rese=
t-hook_0.4.bb
+++ b/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-rese=
t-hook_0.4.bb
@@ -20,6 +20,12 @@ INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE ??=3D "ext4"
 INITRAMFS_FACTORY_RESET_CLEAR_TPM ??=3D '0'
 INITRAMFS_FACTORY_RESET_CLEAR_TPM:encrypt-partitions ?=3D '1'
 INITRAMFS_FACTORY_RESET_CLEAR_TPM_BOOL =3D "${@ '1' if bb.utils.to_boolean=
(d.getVar('INITRAMFS_FACTORY_RESET_CLEAR_TPM')) else '0'}"
+# Timeout in seconds for wiping the partitions during factory reset,
+# defaults to INITRAMFS_SETUP_TIMEOUT or 600 if that is unset
+INITRAMFS_FACTORY_RESET_TIMEOUT ?=3D "${@ d.getVar('INITRAMFS_SETUP_TIMEOU=
T') or 600}"
+# Watchdog to service during the factory reset,
+# the default is set in the distro configuration
+INITRAMFS_WATCHDOG_DEVICE ??=3D ""
=20
 # to support factory reset on btrfs, add 'btrfs'
 INITRAMFS_FACTORY_RESET_FSTYPES =3D "${INITRAMFS_FACTORY_RESET_LUKS_FORMAT=
_TYPE}"
@@ -34,7 +40,9 @@ FACTORY_RESET_HOOK_TARGET =3D "${@ 'local-top' if bb.util=
s.to_boolean(d.getVar('IN
 TEMPLATE_FILES +=3D "reset-env.tmpl factory-reset-script.tmpl"
 TEMPLATE_VARS +=3D " INITRAMFS_FACTORY_RESET_DEVICES \
                    INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE \
-                   INITRAMFS_FACTORY_RESET_CLEAR_TPM_BOOL"
+                   INITRAMFS_FACTORY_RESET_CLEAR_TPM_BOOL \
+                   INITRAMFS_WATCHDOG_DEVICE \
+                   INITRAMFS_FACTORY_RESET_TIMEOUT"
=20
 RDEPENDS =3D "factory-reset-helper \
             initramfs-cip-functions"
@@ -42,9 +50,9 @@ RDEPENDS =3D "factory-reset-helper \
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


