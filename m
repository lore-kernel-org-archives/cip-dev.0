Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D46AC9831C
	for <webhook@archiver.kernel.org>; Thu, 24 Sep 2026 11:30:51 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.65])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5690.1790249442850179999
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Sep 2026 04:30:44 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=XCgUjRi1;
 spf=pass (domain: siemens.com, ip: 52.101.65.65, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ukPVR8O7rsDHAbfUb/fU85uGoP4hLv32IsBVD8w+pCjmTuiCdPhjVDRbs6njs5bDtvzvJinTQavUeb3P7DbEtRSupjkCH0wJxLpMvwE2q15/JjjAAn+JsvQaKpFkjC2Ng+x6WDCBxhYE29FgA0EXz1qCwR9H+PpwvFqThmjeLxFsophc/qnxt7Rh4I7+rwyYrV5o/4u1VqgE3PC0U2kcAKbvMxIBhCn/RJU2IihRqzS3W2n1WlQcumL4V7HY4M+pbPsRawC2eV6835EFzEInnAqno5yxuKUjtViqjeVtr32j5JrJv9oyyrC5ayFysRc5BZ7l70lLPj2gX/J3u9Pp8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AjwdJAwwUdwNHT9g5N+RBE/Tz5gi2B+wmdKgqnfQCpQ=;
 b=c1RzETXTfSduxt16jpdaNSjG+/zr3NykPBScxX+fRJZFj5YZfZCTdEF2FCWI+8y/mrV9A0qyYZV9eA0CINxSbUxp8I0I866jr8YwIcJ2ZWC/EGqGm7PObaMcUeKXEIR0xOi++jgZgHlx/YuF/kOUUnhI03ZUms/XOtOo04hCjFh6MSNNCCrzNun6gy36OIVNckCf6BhrnZJykDc/kaiL26fMnDtLe2TeSwWrwXYtg2MsQd+/f8IG+TzUL9m8Kzv56ITjYJQ/8aZ7/OLEm/cbgfWyKYMmSoh0WhEtzJ/grZwFoh0rz17u02ewjMYn2Q6BJEwUPCzGGMyE+fCLFTsItw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjwdJAwwUdwNHT9g5N+RBE/Tz5gi2B+wmdKgqnfQCpQ=;
 b=XCgUjRi18LxNlwOR1zxTbSyWsPymHsc1RPT9/PcnhVahyzAXfnD+iqnF5oIvosJlHs9RgRaBdui12lk9Bds21a8zJYRDMFvjWUpfnedgXGof51FrKLGn1CEKgYmBJ29UXFMTvhfhl8/vqBDflBF25YgghHg9uTZwHLdzzJGZKEsvuzGL8tMJ9hlwmYqYJzBwPMCbu9Frn4fSov4nYw8ZMmABE91u3G1oWPzQGjL1TsvlTDMYhjgGPxl+648y5gXLzB4acVlCm/aeQnycWVy5apGLw1/4Lmcr3C2PI5aDih9tfgrs5dyNFh+PinCjMnJRHBfOMVxGcioX7qUcQD8KXA==
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
Subject: [cip-dev][isar-cip-core][PATCH v3 4/5] initramfs-factory-reset: Rename target to target_device
Date: Thu, 24 Sep 2026 13:30:20 +0200
Message-ID: <20260924113028.3191076-5-quirin.gylstorff@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: d1ecaa47-0df3-4085-9cc3-08df1a2f4301
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|11063799006|56012099006|3023799007|55112099003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: 
	GrNzQb1gPi/vHQM0Mkc9Off5rO8eM321G9i3l7SU5IiRKHSQpsg6nB/016PlvPuSGTb0k3BABQb9fkEXtXRlBLL9tFrVZacine6vNFe3smbkR61klARRQFfD+Q8mHxQdHWupiJiwF5S131yiQnDcfHko3fAeYCFbZf+tGzf6InxIDoXdKBQYsP1Y1qH6niAYetpl6GhzwCalGlKd0VjVRYcdQJYQJX5htcS14LSGEPNhUBvIcPH3Mc9w6INnpa4ya55mMfuD+sSnySHqI2pB2aqAzjcPrBkwS+AvDOYGm4X9snxAA6L/yOslF2LZDeWZ01TmYYKxMmHD50VwjwuwZDueveWTHZGSzMtGyE4j/yULUvyxhiZvVrCewPVxJtdX2Of+PyRj3CQ7fmACx9mV3704wbmgDbQ4OjkO/Y7k59ny+0FDUanLqudM4t/nfXAjJZnjESJdnO3/8glh2Ad+8JUshkRppwHku8mtPa+q03qMGjHCPrw9ofLH8nwvxj1J2a9wWe73vV5+O7R7TxsxT4mbTG7oKOaisJfbkxF5cySXMdpHnip5iQCPpRAoA8HhzAkVZk2SCpimKw6c6J0JO7ODabVAvlcBJ5ipyQR1VKyvSMIgfDbN6++HgnT3crg2+KbxzymwsfmRXDQCDzcpGuvyaTNi6YkUTaLOdDxuKY8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(11063799006)(56012099006)(3023799007)(55112099003)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?lope6Tz1kQ3UN53EqMCtcJQbwijZuLFcEJ1ildPNdHtvKoKv/NUv0XXPuUyN?=
 =?us-ascii?Q?3p83ZrS9uMC5yyA+dzng6/ZFKg9DZuTNrinnv+vrElwVlsaaEDV8cIghhs0T?=
 =?us-ascii?Q?iW0iHgmukHxUJcgNVkHVqTUqU2Cv7c0u/oaXGYYqP7QxFHqEMCj2YU7P5r8Y?=
 =?us-ascii?Q?xSgIPfnMe3wijfIytXd/Xwjre0+GFOqx6zKxrbQj6A0cQFsduQ0wUOvSnGP9?=
 =?us-ascii?Q?r0EkUBn7PoNLGLwtlW/rPbBs3yyzpo1k4vlyB/iqrxnwUl3L+Jzf+5fCIcSx?=
 =?us-ascii?Q?hE6ZmnIlmYmCWZNeo/tNzIrD3itb+A3OIEtgTsI6M9x7ItDkLo41ohp8ytKw?=
 =?us-ascii?Q?F0aEazCrkQ37A2syVMNKzu81s/Q65h2TMcgWzV5+W0qRoHXBksM7TzhAgAWc?=
 =?us-ascii?Q?7uldwgipnFTwT+bd0R9SNJfz37cxc18lj2UZyfTSUdhtnpP6Cf3KS49pU9PR?=
 =?us-ascii?Q?ZclYPAHCp5Tp1B0BhqEKQXGh82BJyFyILkeMo+EY4k30tvs1TFenSwLvJ+2H?=
 =?us-ascii?Q?bJx0HgIanFs/hFZRBMNNZqbxIC7yKEcqrCRZzlU4JaYQnZM752mizlZIHCQZ?=
 =?us-ascii?Q?UyrPQn0EE1utt0y1o61uI1waeAkqW7O70KoRicaknUViyrSymR2rR2GDiDt+?=
 =?us-ascii?Q?1/VD4Hub+A00Er32E7GBoWuhIJxCZIoFA9SvgtWGvY+WsV0hIJdwSnmPNSpW?=
 =?us-ascii?Q?g60QxImNxppU1w8DNNEh+i20Jt2l1pGgJQqTTVT6pAszHtTTYu8MmZnhUxYK?=
 =?us-ascii?Q?VADaeM6tVoIyNtwQ/Hc2ZeY/RFJbR141C+A1Dh3+Q8YeLoCi1sHdwjPPCr64?=
 =?us-ascii?Q?pHNhE3WDY/FveIZl4YraNHeVob72pOVNf7gwagmIgHtU+uozoWzx5Ef+DFMq?=
 =?us-ascii?Q?6wo/ADj7R+48Rt4449dctWHMM0jyA2JTjkJdbSPABtjeIHUVOox/3tf9xMVS?=
 =?us-ascii?Q?4/a0+vxHpFmDD6oBix3eEyFC3FTnrAxS2+1ZuftugurEoIxm32x5Y4ycOc8o?=
 =?us-ascii?Q?w6S1RCH3GYRZLEupXGAyeWTcYi18y0S80w29IKO5hDiCZCZIRGkuQxPMWPcO?=
 =?us-ascii?Q?pBCf7ZH1kDqNnAa7u91mVKHkTEC3y8qshsp8++uy9WLNPtYIzZ1rU0QdIhwj?=
 =?us-ascii?Q?qZxfU+k4KNnxeh4QcEt3CPE6bUfNiCZtXyerm7ZhFcffQF/yxAhfp2Ca1Srl?=
 =?us-ascii?Q?8PNBaUr77phnHFMDEBw/IboejXIsfAQupBrGwr5thMUgCRnfYDIcb0oXz1Av?=
 =?us-ascii?Q?zVm3syQJ3GFLslYNGHdre58KwB4PCFr1EmseqdxyROFPF3B1ryLLzhBUxn6f?=
 =?us-ascii?Q?Hwjz1quSTPEHaLJbQTz7nqbf2qKmShyfAAuGIg0ymW3Oa37TN2XUrT/MY8tf?=
 =?us-ascii?Q?xWfS793dY7Dv+EPRJZEfMpQiKrcsTZawLpVfVAfveOU050dHkiaQl5JQYae6?=
 =?us-ascii?Q?6SpeNIucwco01K1aO6eZ0T4e16TyTwYuRU5GMY/RFQfzNiZRbo+5IcKorUSE?=
 =?us-ascii?Q?EB9q6XvU1b9xcDqp+VJaRRu9lhWB8Yztxp6lOm2DkTrKepHEcPeVN69H+B9t?=
 =?us-ascii?Q?rwonCc0RK2F/6rjQxEqh7JYtegb6io5o4zfLU5yhqGUlYkyYR5oTd/6+bMIE?=
 =?us-ascii?Q?oBO3Y59cMMGGLw7wUGYUgck8t97rT/2r4rYqjzo3meO8dk0mpybhISqzPfc/?=
 =?us-ascii?Q?/etW29be1cqYonwa8ur43l1sZzhBelTyisSNOpWUMPNlFEPIJQwGQbql8avw?=
 =?us-ascii?Q?UGRx9VkHlrvYEXTT+f70Ss/hlC9g18g=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1ecaa47-0df3-4085-9cc3-08df1a2f4301
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 11:30:40.1191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fFvcRZ61qQb3pKN9uO0yzz/J6Qy6mGFXSouXeEIOwnTagDhlUqbqpZk3/7IxrdaLtO4VbfBdis7jotr/HMJbq2qds5pS+SQ0u09ef5998L4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3308
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Sep 2026 11:30:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24312

The loop variable target is overwritten with the LUKS mapper device
if the partition is encrypted. Use a separate variable target_device
for the device that is actually formatted to make this explicit.

Also quote the basename argument in check_partitions and fix a double
space in a warning message. No functional change.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../files/factory-reset-script.tmpl           | 27 ++++++++++---------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/recipes-initramfs/initramfs-factory-reset-hook/files/factory-r=
eset-script.tmpl b/recipes-initramfs/initramfs-factory-reset-hook/files/fac=
tory-reset-script.tmpl
index d17cf322..851aa823 100644
--- a/recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-sc=
ript.tmpl
+++ b/recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-sc=
ript.tmpl
@@ -17,7 +17,7 @@ check_partitions()
 {
     found=3D0
     for partition in ${INITRAMFS_FACTORY_RESET_DEVICES}; do
-        if blkid | grep -q "$(basename $partition)"; then
+        if blkid | grep -q "$(basename "$partition")"; then
             found=3D$((found + 1))
         fi
     done
@@ -34,16 +34,17 @@ wait_30sec_for_condition check_partitions
 if /usr/sbin/get-factory-reset.sh --delete | grep -q "factory-reset"; then
     log_begin_msg "Factory Reset"
     for target in ${target_devices}; do
-        log_begin_msg "Reset device: $target"
-        fs_type=3D$(get_fstype "${target}")
-        case "$target" in
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
@@ -56,23 +57,23 @@ if /usr/sbin/get-factory-reset.sh --delete | grep -q "f=
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
--=20
2.55.0


