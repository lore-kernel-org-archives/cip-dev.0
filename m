Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC906C9830E
	for <webhook@archiver.kernel.org>; Thu, 24 Sep 2026 11:39:03 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.38])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5867.1790249937042799224
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Sep 2026 04:39:03 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=S47+riHp;
 spf=pass (domain: siemens.com, ip: 52.101.84.38, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jyq2fCRjtOBATZ83YpRFxa4IBKclnURhW7rjCyRCosrl/jstzZFqGgzsdeGDh/1GOfHJC4vFqjH0YvWv9QX9v4xzMp7DEKv9tGFTlRzsrqxF8YUwg4CstiBwRXCWqoRgTBYuA9iWKfd2G34BVAMUA+yKRh2fNqj4ao603qH0JBRO+iNlddNuZoLa/P80k0xRQkAf8vg2wy54aNTZWhIvFaumrBBthqK0+SfkefFnvV+T1O+lYwsxrPKUiUe9p86O7F7omBqCsr2e/T1XLqJlAB17az45QtvmpNXLitFUI4ZU0iJpxGlWIvc4H5I7ttcshNw9XgU9QS7UJAxVqkp2Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9eW4CcIY1/8GKaX8iTnDvta7BvZC4DKeFF+XWBHL30=;
 b=VrM/jng2xL9h4QYsiRePr+/Z1nfChiKeZLimEciA1icVUxcKrTP3P/pnJYAy5mJmUPpYcM7+st3hudCOUfDOaxKh0M0T09PcDrOmdBrtWp0FU85U0qM+dp1xDCM86sAHwfOLZgNQZ1tR+ournZwvvmlwmAKCirOSfZ6kEYiB9y9K+BNqPRG2+gnbDYFkOU552IITAG2nlyp8lBCmCco9Xkx3WNtiTSry1PprB9dYAfxCmv956cNp3gXq/PnkgTo3KVi6z9z+KucpRJ1Gv1J7UUBXcagREpQT1/6cGWkgt/5xJI5STLanj/Z6aRp8ytM6gidVb3MnWKtXPTj7lRRUzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9eW4CcIY1/8GKaX8iTnDvta7BvZC4DKeFF+XWBHL30=;
 b=S47+riHpiwz2u7KKWvqrxF8ZdqzRVfi6O5S6KHa5OgaFVlKse+luRhESXlum8PiMYpt1FUe4RlYLdEwo59k3v3vDcVLkoMjD7xl/RPWADGlfHVFMlcwg5NM9t7hnZDJ1eRhZg3PHv7yLLDU7Hil3ey415lEftIgh9zWl68mz3/XgqVY4pkktZr0CL9BhGHwanI3WfjeNyXrxSABxl1wUuWzQPJ0tIp8Ea3nAwgIiU2zXQ2adnypqHpcvL5Ad0aFahcSn8xPthdhPiTFZdy9YyPs1GO3RZOMbkauWm1sfRz0k2VeX+uEb+cjpAOlMarq7HaKxvj7uSLMBmMz+2MalVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17f::18)
 by PAWPR10MB7769.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:34f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 11:38:57 +0000
Received: from AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5511:7126:a2d7:f914]) by AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5511:7126:a2d7:f914%4]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 11:38:56 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	alexander.heinisch@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v4 4/4] initramfs-factory-reset: Wipe partition before creating a new fs
Date: Thu, 24 Sep 2026 13:38:36 +0200
Message-ID: <20260924113844.3192747-5-quirin.gylstorff@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: 76565a9b-e8c0-4df7-7174-08df1a30686f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|10067099003|56012099006|3023799007|6133799003|11063799006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	DBekDooYD/6z9tM//bjwJg0MfqenC084ae+SUzXj2OC4oNsLyppIrNPxtkhk5uzNVTYDEtN3L7mw6ay6KfYyU4gnpwTbcWqH7uqJlIFzWq+mu3VER44E1EOqS/533N1imwg386pIDp8z0YeUI+sLcfozLYiiP4HPbRC6WUp2cwVfky2pLC99+v7pPqcwQpF9B1xx7Zx6Q2bdjpB+5rObmd9hY0sRJ/DY1wryl+j9XgBXrGVbmaGI1OKroc5B54ZLqiI4gpdQb2FwpSHn81bp2Q/SCPJywrxkIX6yRQXI2CMervhuJ7dDEicCy2YgiOJeOjJerAVF9gTdPeB96jjbOSG/NBDQLOUaMsVHyjXJfe7KYxX6e5vys5Y0UxHZduGlxtDYjsJ4rhyiLpK8bYC5xBTW1VU3THizcNt1ywgoEVY71IIjuYHNV4g/q0Nf8xYP9iZZIyICaa4Izst31/pPxrDpws2sRoHaQtqicoMXg9GAE4nJNv4WwqRySYReRDytHivagM3QbD3R2awMm8MeV32aXdbYTk/vYRihIFtaoIORurX4FccZ+j2aflQQe5I3rHAKUAfftkcTVeN0tzVo+i6Wp8eUVsTvUq6KoQYBUyLmfFkCoPkx4SpyhlSok+uA4DTPxIFCK3T7aqNuG1TxLtkzipnL7gGL56qFvmSe/7s=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(56012099006)(3023799007)(6133799003)(11063799006)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?gEC2T+Jlhn4PC+b0NwVkhnmqMaTvS5du/krsHnJ4L37nMiVzMF2IVGO75okb?=
 =?us-ascii?Q?x0jAs4C+DAJ0ExciWGOLGep5vMHI3UyzfQb7NyDqnVr5mmh7JPHCSFtTf6BI?=
 =?us-ascii?Q?h8JLMFhSAAOOdLz4cvVIlPxlPWr3lTiKUB3nJv9KZefGBFCAfj5wAZ7kAwf8?=
 =?us-ascii?Q?GgR4AEoSHysL9OZl4PGbXWDo4/W6ElJd4MjkEhrgldFZEzV5tONYEjdB6gxL?=
 =?us-ascii?Q?+p4d225ReoYCzk5ZJrULF434WEjr3f1K+lirPlXOINrIPQfKTD1tJmPAlQk+?=
 =?us-ascii?Q?ExPq85CzmAtg2aUG7+fQUVlSttRnM2d+TgiEoucx8o/ZJjVnXRV1HDNUokIQ?=
 =?us-ascii?Q?TQq6PRjjgy7E9FAInYiMk0cNFz+ysDB0/hCPZ4y3DfEZ1c0s8oP8aLJPz9wz?=
 =?us-ascii?Q?0yX4XrWLMvVD2oEEaUDXK37sbwKOZaPFL1/CHP6AVYxuqdz8btsnPmLD+BZz?=
 =?us-ascii?Q?brDpQwuV3Zj9BNBCQof1Ael3sYhzKoS1SLhF0JbuJeUDHHX+8wdQ33SLDK23?=
 =?us-ascii?Q?VfzwtHVIFbNozWaLrAClVE1DtcdH6w1CiIkHJw1kBoit1lnBwstRQL/Hhq3m?=
 =?us-ascii?Q?PAC5LRo/zaCLAO3lv8MIZMs5cdfmGdQY4QiMh/KLxFRRwS8Xl5N2IJ9Fm/X7?=
 =?us-ascii?Q?ha6amTRmjPJoWrrFRFaUwjd+TusAhdEYSq8jlYq1DzrY5EntbgS18Bl9VdFw?=
 =?us-ascii?Q?yelq1Wudp1BQBEacVxOn0VUS8YJhf+ehKyzrtk6ZvPdv08b/hIA9MUSUK252?=
 =?us-ascii?Q?3UKa2GAX5F5t20V1vCKnZofWIf6TS8Mg3por1P4D9Hfe06lNew3zd9YmudZL?=
 =?us-ascii?Q?fXaqQ0C3T+gsfSW00TewOjEAwM1tCQZeM1hEkwFPa2to7BaCeqN4vROlYaH8?=
 =?us-ascii?Q?0qtXXbSGVJJUhV3GRf2tR16gVtdeBmltb93cJ5N+RCYzRp3KAZbngiyoHkk0?=
 =?us-ascii?Q?KubrZ1vjievIegCtCpM6UHPfX81D7XQn+vlEYXu2TlcJ5B/2zqsEr9EpaOln?=
 =?us-ascii?Q?iveFkDOetEhieSpene//IwZ9kCIIkfB2GSBdMx66WbICrs++bN78wQrYwUO0?=
 =?us-ascii?Q?9UhoE+qpsDs8wIDBBiUzlxBPhX08lsrqWX909wDO95fpHG3pjzaZEaJYwBXs?=
 =?us-ascii?Q?b1qGfH/CxIzhQFZRz1gnsRDXNBz/lZhItUDc7iwzl1T4rUBy3jHfMl6li3P4?=
 =?us-ascii?Q?cMDTJxvbGlHFa8OBxit6KrHTiZqV+SBfZ//Qz4HStcnUVI+M7J/HqyiT4DPY?=
 =?us-ascii?Q?zxKJKBPjReiNQgvVTvvZ5UrpjCyCWUAn+qebm7nbr0LbP2EYIHx9ah8EXbv9?=
 =?us-ascii?Q?cYyr8vcbTq3XH2fxe97RZRQai+rW7+Zr2bm6DYJ6ijcCAcfpAcW9ibwVBIKW?=
 =?us-ascii?Q?nYRC6OBDVO7j5mTvXPNgZxQhMd5mY04cT090Hp2eTFITAhyxcSNrYrQCaps2?=
 =?us-ascii?Q?2P1ZofMoV5ZKBJI5HetkwW7WhvSYA3RH9/lBDqY0wCa3n75U5L5NSbkhXKUp?=
 =?us-ascii?Q?E6hP23TzacE9tB8nJwConsg567sN6SRgmLlNXSZ5/iHqhL16ePhgdY9SupeF?=
 =?us-ascii?Q?SIaSLLrlsjr3fTo/KPdFrUN6CByvl6Rqe6WDNBaSLL4fp7dGbNswEYYyPO8O?=
 =?us-ascii?Q?ZZ6R5j6rbS/U9ZDyUFp1PqVZG6MqUgUeU+rgh4uW8nDqEbt8D0MFD2j/hWKP?=
 =?us-ascii?Q?0VU6qhazY/cyqjboTTzwjDaIB/KXKFFEW0zV9VHDJHNL9a2vJz56usDkTEGI?=
 =?us-ascii?Q?yb6nUHvhDbKZv5Rbo1ewkfjDdH5sW2I=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76565a9b-e8c0-4df7-7174-08df1a30686f
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 11:38:52.4057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wpCh26sKuW+O/ANBzo/JsBMiJBK86Uz+DWmu8OkCwUobXrdtU756OJ2gYRW97sc/HVO7qbJgo2E3FW+Du2kzlbzoj1KPM3OpXv1rYmPT8zg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7769
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Sep 2026 11:39:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24332

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


