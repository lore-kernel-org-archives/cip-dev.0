Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72093C98317
	for <webhook@archiver.kernel.org>; Thu, 24 Sep 2026 11:39:03 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.38])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5867.1790249937042799224
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Sep 2026 04:39:02 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=XYBlcuGD;
 spf=pass (domain: siemens.com, ip: 52.101.84.38, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DBNSNNlOxf7+2zNOwGcN62nolQs7Xa9WPwXAF/CB1yXxNHrcVx59sLQYXwo4NvdRaJFI/LzEAcBb7mkwla+p76mwsLyZaCacD3YM5gsiHflmweT27MIafmGcVEx5nMQB5VzquyI9FNy4aW+op9i/ZvEZAf1qHJevSh7ZgmuVosxheJzEaf2ufnHf6PsKljAcFS+nMPBVJewQDm4XkWaQ8B0sIAlNiILlTuRcK8niwk3xc6kLqHZOiplHMXASr0r/y3gN3nueNeWaWzL3vv6edy9n598WehqUSfTRh3uiCZTpCmO9uh1b34SuRbFd1TM3I0gGNQbZVVAzAdCiL8mJBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AjwdJAwwUdwNHT9g5N+RBE/Tz5gi2B+wmdKgqnfQCpQ=;
 b=k6iyrVvvj22xnGAO+Fv5uSQC2vQIQr1JqHPCZVY+pUbBRQ8OjboE3prRFP/EX6KNIlQ3R28+Cbni453VQRfNiyTeNfsCNFwv1KvboGkaDrRWqvlPRNdGlpb0j0jDSG9lL/fHxXoy66Pzule34ZSW0+uxSBMaxq0EwmuzhTaL+bUwMUzZi/pop63k9o8U/dAZ8vZqzFqFJeOGOwgU3gsEDCsfE4YyeS+11+GkI28OtTojybuH8Il2+5GZ+QmN3DuFxzRt3TlaRfjLzDR38RtUCroshzu3nhGUSTMpr3sdMkmzfclAZUuqLNYHX5Tz/VywYaq0RwE2sKN/VSC5TUV8Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjwdJAwwUdwNHT9g5N+RBE/Tz5gi2B+wmdKgqnfQCpQ=;
 b=XYBlcuGDdutPm9eOQzlz4U6xFLQN9F856iiIqLxS46vCvgok0hKsSKySKLGqdcykhmxtZCIGKbmvfA4RLZGjI7pFnKrjSJCKnaCZq7xL9BEx1zCzXDIigoEtTfNBZ77LND5z6xv1Ja3paTTETpu16wZZ/f/e+ND+m0w2Lhaw8wN+CKIYu/wORgI8dDUo0T5whvlPWq2Ga39DsspoViW6U2OmBBNEeehFOi1JVbneufKfEjDk8vZQFvE5gJAL8LdcFxlBo4CJL0nCVcNsgm2FTtmUw1Eoiuf1Elj6QcabPdPhCIHnICopifxCvjSfU1yVLx5S1A5S5qqXbNmxpraZIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17f::18)
 by PAWPR10MB7769.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:34f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 11:38:56 +0000
Received: from AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5511:7126:a2d7:f914]) by AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5511:7126:a2d7:f914%4]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 11:38:56 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	alexander.heinisch@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v4 3/4] initramfs-factory-reset: Rename target to target_device
Date: Thu, 24 Sep 2026 13:38:35 +0200
Message-ID: <20260924113844.3192747-4-quirin.gylstorff@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9f137ff3-154a-4beb-8fdb-08df1a30683e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|10067099003|56012099006|3023799007|11063799006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	rGhBirNXJk+Q+0j2Oon1nZ8C6jDc4gJCGX+9cWoXGOma+fODbl4bXPed7x0HrmjWWSSXTb2dqhV9ykR63cFRul0XFebw9WBRQrklmHLTe8+tFUFQj9+cH69UwL5kiVKF/329rUb6C5EISB3OVltkoa/MsmtGNTirRHP8663JuFGg4PG1df5CPzuCMAftUjmUf9lPhDsCPP8Tw3Jv5A7piTK7djLt9NxDQt8cOc8M8T0YOGviO8pk9qQ+46qIligk3wyUAzkdQ7hVZB7X06QcMnZ5h9HoWBAA2ZK+zUCQDLTs35r2+o3TL0nWBGl8/oOCFpi7JYtX+qy0ej09Px/uqDOGX/m2wB9edkrRv43x9BFnuS4USe092YsbkK/eBQcDrvvxL1yIexYVQWATgHgAe8YEtZW55botpk7lUuEqToaYREWp/cdbiECzyRtrnuBP7k64ypCIMufeOY2g+oLvCXbkC18A5XVl1N4RXVWEdByDO9tFsIeagq3WER1QX/NBfd/6ifiGTfBOU4PXRLxUmets88p5gIzD6l4r4Rz3Rs4TIT6ht0iY5rDoMROoY+4Oa/oisjen1VbbZAbftcyBZv5tUxNZHfVbp2U54FGC0Cbgn6cQUoe2UdmyYocsTUY7Qy6YNe2gm9uLTTsNYepTlDOuZ2Z/hP4Vfz/pjT4odBs=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(56012099006)(3023799007)(11063799006)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?d9TL3opelaXMJkStKsWl99cLA8vJRYAZOxDe+4ysn0F4JjtlBliNkgBkGSVm?=
 =?us-ascii?Q?P4CGK6aeZT3ky/5MmgB/57MKngvuxV4HD5wGayLS0e2fYeLZrJgndYcldrPu?=
 =?us-ascii?Q?CrFPevlVTbI+YPrnH4f5sspaaFbMutgUhqzsIbVYIUbfLMKk3A4xevFboMKf?=
 =?us-ascii?Q?oZeQEZEf2AsxmeMfKD6u1XjlRQkgpYnRGRdq6GRCmDVbSHGSv6qwP6OZ3UEk?=
 =?us-ascii?Q?fToRGz11jzoMlKD5YNzRUUyQh0WNMNwvUcKqNQLDU5Zh7MS0yZcOzNnz0IW0?=
 =?us-ascii?Q?COqj2qnnfdfGMsH+LfWPmCbAEXH8lP4PUrug45ftQxscQSmr5184hlilMbB8?=
 =?us-ascii?Q?RrlXygvYSYtnmjeOnG3glrWwqLAwaevgmEj3UAVin3udDq0oe6dbaPGNB82y?=
 =?us-ascii?Q?0fDCInBhBzg22NAEatbta+QGLE767V0V56YnBVWAFm+j2OclNQXYwjddVi03?=
 =?us-ascii?Q?SGRPNUrN/GRN1Dyb63hmLBQB8rG86Axl5YmPfn1tI4sh8IBF4mP5sPw+s6S+?=
 =?us-ascii?Q?FL/cd6Xr34sjyHTELX//qyiLVbcT8UhMUL5Cl4EwLDsgk4CJRJAtk2CzYk2M?=
 =?us-ascii?Q?hXj/b67EC0KZg3AHi4cIitPkBiqE1HmTuPUj8nYTNUsrt2plZH2CGAGcTvPB?=
 =?us-ascii?Q?M5d5kaML0Ae/JrrWTX/Afrl7jQ2zdJu1Brf1QEOKpjwnu3ZJGkoPy2xz41bL?=
 =?us-ascii?Q?2owMa0WT9OcZcLNTuoaj38nHObi5SSqtnUOX8cwF4e9PP3PCzdfU8gDnbd11?=
 =?us-ascii?Q?4f29O2X4H0ld77CJ6+UU+L53QVvMtUNvZdlpkBQ2taFz/+ip+tU/6Ly9OUgB?=
 =?us-ascii?Q?lH3+UAeCtzHhX3+7/Mysi3jRHyQ8IPo9DVRgFgpx8l73F9j0hD5AfM68bE1v?=
 =?us-ascii?Q?NZlD/VzPSaiBHUjv6D1v+4vDdxO81KbOYgY0GX8Q//FZ3NqcmsUFptE++9Gg?=
 =?us-ascii?Q?OfGuLVEDwnTd/bzue8MnLFELtVhNE0JUnfRiIXCX+6sitM+M46+fTcRwT2oT?=
 =?us-ascii?Q?gjxMFwAt9mLfQ6l6lMefEGWD41zP1tg62DlJxIHBMxisPqewA8vN35AvQXN/?=
 =?us-ascii?Q?FY/uf/sFoapDuygYvQ50E3M0qEZKu+F2zvbrNA2Ti4DIqBsSdY2XkkGd4GqE?=
 =?us-ascii?Q?1sRnoiN6tR2phd2j6trdmbFiC/bJnG9psYiA9qRlik3ZaaFewpUSiUX9rcpU?=
 =?us-ascii?Q?KP2yXIpdCtwSIhUM/0v1aaU/d9Ej3eMOzXtFE6VLIFks0EIAsdMRFbm/rXVA?=
 =?us-ascii?Q?BmUa16Q/0AuTt9lc9tpuOWtBUvIv6q2fhSWzj0qvQXlc4kosDKc8Ae/X8SRG?=
 =?us-ascii?Q?BE3VG1rvmSyw89Ax7OKAUG5OR9EMc4Hk2U7dYKjlzyJ6+KmIDK3ULfsVEb0w?=
 =?us-ascii?Q?HEerbU9JFB4fXqqqf5uNMdLUgHIaQ/iNp+XN5eSGW/AAwy5CMJQkh+huONfO?=
 =?us-ascii?Q?YC048UAuErb+1xxVCYrT4ZAcNDnoaAM8urWQjRwz3Hit8Hsh6xLNbIlJdm9J?=
 =?us-ascii?Q?b9+O3fQ2CFs24j4jU6aRzA3i0k4+xIyRU0oCv1EqT/yGATN1Nbo/OOX0Ax81?=
 =?us-ascii?Q?RgwQt/zygoGW16O/BSCqBdcsxPbTU7rZaTh1agRxuRPAZm/xRx4lXYYwAD2i?=
 =?us-ascii?Q?cROBGy2oHM5MVfLKSAs2HxRkrXUJZFi4EpupGXFyzaD+mlnpK3o1WjbWUaoa?=
 =?us-ascii?Q?XD4QTNjA850rMElJIX3tUbiJGLEAy/JXchCd7IUjpPa8TDZwnhIQje1RrE+F?=
 =?us-ascii?Q?ktSckFdCxOFyv9SEbzec4iHxbbuy2nA=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f137ff3-154a-4beb-8fdb-08df1a30683e
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 11:38:52.0586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4w0p4Yy6XLuNARzFWnIIvHb/behj/Cz5mdDnkZWcan2QzLBMAw0ll30ZaLx7O/7FYOpWpGRp/dTpHv+ia+1JowbHJbP/21ra+qWcNVMW17A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7769
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Sep 2026 11:39:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24331

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


