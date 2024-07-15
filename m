Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379AFC3DA59
	for <webhook@archiver.kernel.org>; Mon, 15 Jul 2024 13:46:48 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.42])
 by mx.groups.io with SMTP id smtpd.web10.38516.1721051199476428444
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Jul 2024 06:46:39 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=oqJFo9qr;
 spf=pass (domain: siemens.com, ip: 40.107.20.42, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PUF721e6HAWXiyXQmqwFDpTplaknSN7f59l1GarK93fHyjEg3W4O4G/+vqcxCtJL1OdaBvatwz+kFHkGCW5bP6mE9Wrd0paQ93RuVt54A89FhC+g8zSZ/zhSfIk4xvsLQU9UvdM3RPsm7eYm8ZFj2Ql8HxMew24Uji7b56JDK5qOQTuuDqzvqn+xBlcqAKXq2UXFz5nVwQQpVR8Lmnnz0zqJ3AiWbDrNi1FR7j3edtApliMRcdgs5I9OuSTz1IOAiB30yMyPhKdOPpr+iV6ZyYHYB2/LMRXcW8Z0NRGgRcDyx841jCsJkT19jdtCPvDi8qBw8SyhYOVM45E4mMzIyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JxiOH+/+tevQ8rkudKOhPgdFWSOJYSBpipb7b6TP9WY=;
 b=WoMud4qjDyvCV424r05UoGKIbeJdJWGCsPGoIcc/Jx/Pr6R4p/2cBRKsUA4K+6BcCkqjTrFhu0bz4kvpu7Su9qzzz6+ABNX6Cp9Pez0k/JDCBDbRCXrFQGL3KHvpUON+DQ+sAzx6NAujs1SvJkaIe5HSeI+COSetng1kAfKAXaaJbdrw1x/XYyO7tuegKkfv19+54nDlJv6YCyZ7xxTEFO6tt9uF9xN3dMFd+oLtn8nWmLBqtQ0D0/iYtl77tccwW8WQglSxN/lle7rr1Sh5AoT4RJdVaUF0Qljq6b6RFUGRJ1lbyRkmTPMbG1TsHaWeUo8S6BBSM6dxtxy0mtr52A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JxiOH+/+tevQ8rkudKOhPgdFWSOJYSBpipb7b6TP9WY=;
 b=oqJFo9qrai2mx2D3uYJjclN2J8JSsoQZ4D+dpabmmsw42pZ++D1Gp4CHobGyGqtzWfxH2XOgt4OrFd+o/XQtYjJEpyvnldySK6gJKu2w3UvQMCNJK46qaDMIe/xWTJ/GZW/+GSLAGqLrWHE13DgHdF28sKONxnKRG73aICIP+8KWpunj9/yx9u9R42Xi3ZfEXNeOqb15v0r2ijFbjznXP72m3vABm2vZRlnsI+pukPkA7loxJLV2nRKZ/GN4AQyybDeW05/09QN+4ZIZxgav9M7kmAHDKwkzUnOGidMZOJDxNeHeHwSlAf7bE40STuylSugPMrf0gL5jytdH8BR5mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2c2::14)
 by DB5PR10MB7871.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:48a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 13:46:36 +0000
Received: from DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f75d:ad6e:d321:cc46]) by DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f75d:ad6e:d321:cc46%4]) with mapi id 15.20.7762.020; Mon, 15 Jul 2024
 13:46:36 +0000
From: Stefan Koch <stefan-koch@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	christian.storm@siemens.com,
	michael.adler@siemens.com,
	simon.sudler@siemens.com,
	stefan-koch@siemens.com
Subject: [PATCH v3 3/4] initramfs-crypt-hook: Allow speed-up of disk-reencryption
Date: Mon, 15 Jul 2024 15:46:29 +0200
Message-ID: <20240715134630.1640160-3-stefan-koch@siemens.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240715134630.1640160-1-stefan-koch@siemens.com>
References: <20240715134630.1640160-1-stefan-koch@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::14) To DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:2c2::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB4953:EE_|DB5PR10MB7871:EE_
X-MS-Office365-Filtering-Correlation-Id: 090adfc1-7f00-4473-ff5b-08dca4d48b8c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?aUX9+DrlMbojikoqPAFCW9yzqtm68CIdRwyRBPB3acZssEY+q7loSAGl4pW1?=
 =?us-ascii?Q?edIdgc52jNrLX9sDf/Rl2ll8J5WmmmV6A+zp6R+GVVuDFHv609gAjznwfK/z?=
 =?us-ascii?Q?zSF95AYnqFAzZEtWflcpYendFcyoSZnhOlmS2hs4EnUmHtTHLPRH1ofcphfh?=
 =?us-ascii?Q?J2yW3jJK0OmGhqyd4OGeDOZVzlNg3XnfWt3t366TRcFBc/sYzoIiVND7yu0/?=
 =?us-ascii?Q?020FkjOO3hmVyllKY0073Ui+KIDMJcJMSFbj43gRfekccFLh7jQs5kxMpcGd?=
 =?us-ascii?Q?CrjUKL4VGkohO4IhdCDr+5TH0iFPAcneOZhLNZg7/SJjOktMmMIVhHsyVvqi?=
 =?us-ascii?Q?bA6Tk150WmnkZBIBfw3NRNHS4G2+p0ikEGwp5G6YtHy/8lR07dGyXxNBqCEA?=
 =?us-ascii?Q?NgObK0AHHukX+VkyGLQ7Q6V4mybxBeCm6jeH5QvRSinVEmrFZC408N5PECF1?=
 =?us-ascii?Q?0u9xEui/k0/Mb+kKSa9+ANO+VtkD4QKvMp2nH5ZE4gnGflp10DGAV+Ogw2i9?=
 =?us-ascii?Q?kOqG7tH72MiLfefXcfOd6hdfZiIUr4agB19EEqOk6XYMcTJvIB95FXIfT1Ht?=
 =?us-ascii?Q?quf0IYQ8ByZve9ND9MQ3cmjTrrvEjewtDk7doBhGb15OObVe5EzSurUEIwFp?=
 =?us-ascii?Q?em+ivGmA+v4l7V0vUWktPYg57e2mJ4CrUP++SridID6B2rsqYsZ7sqhj4j1p?=
 =?us-ascii?Q?0wovCe6OHCbyQdsoCzCUCytwClF1LDQyEXfnavdJKDqgmsh5i5UaQw/DsRWk?=
 =?us-ascii?Q?/YViR7tx9RKkLShDUGYRsQtbaRkUFxwiaWoX3tOOh/kvQ0B8mFrnXJtr3Zcz?=
 =?us-ascii?Q?gZ57gT3jqJpMGblv27MQFxE8iqVF3/gQHo+nJdOVNdabB0yxRXydKitW3u9q?=
 =?us-ascii?Q?2ncvcHO/iSP4vDRfKmLQEBCkFqbAEONcOOJGOiHiPfESGLVjhtlkrUo5q6d7?=
 =?us-ascii?Q?IvGKOCmQk1HTnowe2tid9DnYEEoodeD5ZhRA9mWYv7tWdnNR2EfER7ZtMoVE?=
 =?us-ascii?Q?9YdSZnlRdYEGe/8EP8V5/tHTrUjUU+W82zALf5aCEQElHeiKvElEGCQX5gUQ?=
 =?us-ascii?Q?77IIP2+RyczAD0Hkadvy/rTU3D0VeL+wLa9bdjSLX6GdoDNxKEAq3HGA+dc1?=
 =?us-ascii?Q?YqQR4+E/0B/FekH3XkbqZ4UoEEbgxcrZMT7lMdjVJHNkvr1J1VPZZcmCLU5v?=
 =?us-ascii?Q?DlSGD/L2ZIQpS4CDIZDYypqdfkscUwudazS+PqIoQsZJhKvPGBpYecwwGUNm?=
 =?us-ascii?Q?s/66OYKNxnbopcw5KzxO/w7+Hv8HEhaSfopnGuS/3WB6iFvSJ7A54uOGdOfa?=
 =?us-ascii?Q?nOjnQU9UQrsI/CI3yTU2TM5VfoqfV/d0g9m3vvHkCCS3xw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?VQdOIAik1VcWIyThUzuX4tNOQUzK15V64JH9mLIeb6oyfopuzJNJMC+fRMVG?=
 =?us-ascii?Q?9dZehkwBIiwScrhgl5ELnzff9+zZDbwzDzvqa3dqifGBmCmnCVrAk+iWKcFs?=
 =?us-ascii?Q?eN8Y91k+zK+f/qZiSLzqP1Wbn00e3M8bZoF18Fi/SNIrQsRWb98Hkh+yrNms?=
 =?us-ascii?Q?S8Pt152uafttyv1rWv+ARx/riEGEU8TmzP64TDkbEr5Dcv7EWx9b+l/ZIZ3K?=
 =?us-ascii?Q?f3gd5wBRlkoz3VfKc5VsYAiQ84HIrKP70ur8Jvbb2foIDzAFoksLLoAsjfEa?=
 =?us-ascii?Q?QnonpTyJY7ReUlzFofyNMa6wf9XGltu2rSO4Y2NozpkCzJ5m1SfODmyKPUi6?=
 =?us-ascii?Q?KH+wkkYBja+dnk73okTFhfBgVxi/qp2MFfBaeYmFPgNtDJN8smRem18gR9hA?=
 =?us-ascii?Q?LpgqTi+ya/yYfpAAKtDXihZiHV1jkXj1GlMjhb3btvSeeAKrAKhJSjSyc3Ic?=
 =?us-ascii?Q?8MPWKXPYjPIz1uNQ5utcVkzxs/acnrTNBeYAbgzhL4pwPKZZIRQKrn1MshHw?=
 =?us-ascii?Q?CyYJPkRhtOSRdNFHJOiTGeUF0ibhOoNP/ZfnqdFOtakhBb26vLssOYDcyheU?=
 =?us-ascii?Q?1XXZn0wt2eOmC5R4Vpw3ikwC6IeJ4pzJiR18Q5ictbOf98xdKKOa7EJKLM5B?=
 =?us-ascii?Q?d9dDULdj7Y0xgbfLi6VMTtvOJufxIKjuk0+pOy/QiSKu7hBMlLOMj7HePFpX?=
 =?us-ascii?Q?y9P+MgemBJCWFM3SEX8XuJiBIYzOmxjgz2bNBJbHmLdaH28/ZKd75SYBRPAM?=
 =?us-ascii?Q?XMTqb26Tiae2lK49WgEHqFKM5/MuokrD4pPWV2X61tjebAQY/l7yIxGT2C+H?=
 =?us-ascii?Q?w8DqyAbQRP1msQY/+/+UHECgl3wYkAa/Dyy3gtuNM/owPF+mYc9Lm0rTMI2/?=
 =?us-ascii?Q?IfKFaiHDk+3u6AvJIDPlaVrHD8qt0Eqarh7TJHjzwyfzV4S8NxwPlYyuVhe0?=
 =?us-ascii?Q?vrBll+aKpHSaqu0AYvZWMFW2oZPM7JAQO+XKQSEmnsCvjOmLy6wqvSIGVAHj?=
 =?us-ascii?Q?KIy4kk2wsAf8sZikg5ACfbBnNwOt7gXXptA0KsWjZHciTonXUmVr8rtQInPa?=
 =?us-ascii?Q?YcSdENoE9R/A6U5xHKQeMygCi0Uq2Ry4HK1baKZqTVTRGfRrpXQs9TI0QzuU?=
 =?us-ascii?Q?xfQpM6owtXWH6KLxXiRASiL8mtwS6PbwEWOONtLYXYOPIWb/u1cE9x50AgQK?=
 =?us-ascii?Q?bQacR0dMrVEaK/Zq9wjJ6nTwD/9ShMTDtvTjbc5kVZ/BXtYSt7C7PTvezNL3?=
 =?us-ascii?Q?2QLvnYVVsknzatecN9IRtnokM22YhsrhqEF+gmD7NSFFkn/DPkNEKpOS/5Vz?=
 =?us-ascii?Q?9o5vzHl4naguQrjJ5IzN+wXMzm/uC0h4p/6mdYKQa6uohkA6K54/Ae7AoMjw?=
 =?us-ascii?Q?1q6RJr4dThy0yD2bUHU1iCW8SKv4Ip2FbxYd50py+vln8VYV1M2IRn85d8WA?=
 =?us-ascii?Q?p1qA0amMqueApTmOdUapuJ1pbelFuX/opFgazk6+d1RXMb3KNriggTfn2aWP?=
 =?us-ascii?Q?11KZb8Q7fWSIPdHnE5BbnUwPG06UHx/baZZrF75cyty9VH3dw0r6rIZdRzTi?=
 =?us-ascii?Q?lPZFgFQBvlIdmw+t9wuCFuL6NL/UF/4n8u9zO8Bu9wGBgiMNNYnxGYNbLjas?=
 =?us-ascii?Q?XNzUf+ER7znadAZVfoXQLh3xxh+6Sir1xsY1uGKFGC764pZ1BXzOGGHRhPG2?=
 =?us-ascii?Q?AFMYNQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 090adfc1-7f00-4473-ff5b-08dca4d48b8c
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 13:46:36.2048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 48W+4Gbv+BU97EekkhzeKHFGHTA4YJB1dJ5wBijGf/zJxGklIMW+Fbz72PZSIo1rpVAD6pXml1c8QbkQdyjqgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB7871
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Jul 2024 13:46:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16496

As the reencrypt mechanism doesn't work at file system level
so it wouldn't detect used and free blocks.
This means that the block-wise reencryption process could
take a very long time depending on the partition size.

Using the format mechanism instead of the reencrypt one
would delete all existing data (without wiping). This would be very fast,
because it doesn't matter whether a block is used or free.

Set CRYPT_FAST_REENCRYPTION to "1" to speed-up the reencrypt process.
So, this would be done:
- Obtain used space of the unencrypted userdata partition
- Shrink the partition and resize it to the size of used space (minimum siz=
e)
- reencrypt the userdata partition now with smaller size
- Expand the encrypted userdata partition back to the maximum possible size

Some disk encryption implementations like within the Debian installer
will overwrite the entire partition with random data for security reasons
(e.g. wiping old already deleted data, hiding metadata, etc.).

However, this speed-up lacks the described security benefit of implicit dat=
a overwrite.
So for security reasons, it behaves identical to the format option
(there is no support for explicit random overwrite within initramfs-crypt-h=
ook).

Keep in mind that a power loss while reencryption will cause data loss
(with or without fast reencryption).
The key is only enrolled after fully succeeded reencryption, yet.
So, no recovery from already encrypted data would be possible.

Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
---
 .../files/encrypt_partition.env.tmpl          |  1 +
 .../files/encrypt_partition.script            | 53 ++++++++++++++++---
 .../initramfs-crypt-hook_0.2.bb               |  8 +++
 3 files changed, 55 insertions(+), 7 deletions(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition=
.env.tmpl b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.=
env.tmpl
index bb93361..2b02f55 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tm=
pl
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tm=
pl
@@ -5,3 +5,4 @@ WATCHDOG_DEV=3D"${INITRAMFS_WATCHDOG_DEVICE}"
 HASH_TYPE=3D"${CRYPT_HASH_TYPE}"
 KEY_ALGORITHM=3D"${CRYPT_KEY_ALGORITHM}"
 ENCRYPTION_IS_OPTIONAL=3D"${CRYPT_ENCRYPTION_OPTIONAL}"
+FAST_REENCRYPTION=3D"${CRYPT_FAST_REENCRYPTION}"
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition=
.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.sc=
ript
index f943aea..7bb40c9 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
@@ -54,6 +54,9 @@ if [ -z "${create_file_system_cmd}" ]; then
 	create_file_system_cmd=3D"mke2fs -t ext4"
 fi
=20
+# Path to full (non-busybox) losetup binary
+losetup_path=3D"/usr/local/sbin/losetup"
+
 service_watchdog() {
 	for n in $(seq $(($SETUP_TIMEOUT / 10)) ); do
 		printf '\0'
@@ -62,13 +65,16 @@ service_watchdog() {
 }
=20
 reencrypt_existing_partition() {
+	reencrypt_device=3D"$1"
 	part_size_blocks=3D"$(cat /sys/class/block/"$(awk -v dev=3D"$1" 'BEGIN{sp=
lit(dev,a,"/"); print a[3]}' )"/size)"
-	# reduce the filesystem and partition by 32M to fit the LUKS header
+	part_size_in_kb=3D"$(expr "$part_size_blocks" / 2)" # blocksize 512 byte
+
 	partition_fstype=3D$(get_fstype "${1}")
+	# reduce the filesystem and partition by 32M to fit the LUKS header
 	reduce_device_size=3D32768
-	reduced_size=3D"$(expr "$part_size_blocks" - 65536 )"
-	reduced_size_in_byte=3D"$(expr "$reduced_size" \* 512)"
-	reduced_size_in_kb=3D"$(expr "$reduced_size_in_byte" / 1024)K"
+	reduce_device_size_blocks=3D"$(expr "$reduce_device_size" \* 2)" # 512 by=
te blocks
+	reduced_size=3D"$(expr "$part_size_blocks" - "$reduce_device_size_blocks"=
 )"
+	reduced_size_in_kb=3D"$(expr "$reduced_size" / 2)" # blocksize 512 byte
 	case $partition_fstype in
 	ext*)
 		# reduce the filesystem and partition by 32M to fit the LUKS header
@@ -84,9 +90,31 @@ EOF
 		if ! cryptsetup luksUUID "$1" &> /dev/null; then
 			e2fsck -p -f "$1"
 		fi
-		if ! resize2fs "$1" "${reduced_size_in_kb}"; then
+		# shrink partition temporarily to minimum
+		min_size_fsblocks=3D"$(resize2fs "$1" -P | awk -F ": " '{ print $2 }')"
+		if [ "$FAST_REENCRYPTION" =3D "1" ] && loop_device=3D"$("$losetup_path" =
-f)" && [ -n "$min_size_fsblocks" ]; then
+			# set encrypted size for expanding step
+			encrypted_size_in_kb=3D"$reduced_size_in_kb"
+			# minimum partition size
+			min_size_in_kb=3D"$(expr "$min_size_fsblocks" \* 4)" # blocksize 4096 b=
yte
+			# shrinked partition size (reduce_size + minimum partition size)
+			reduced_size_in_kb=3D"$(expr "$reduce_device_size" + "$min_size_in_kb")=
"
+			# set loop device as reencrypt device
+			reencrypt_device=3D"$loop_device"
+		else
+			# continue with default reencryption in failure case
+			FAST_REENCRYPTION=3D"0"
+		fi
+
+		if ! resize2fs "$1" "${reduced_size_in_kb}K"; then
 			panic "reencryption of filesystem $1 cannot continue!"
 		fi
+
+		if [ "$FAST_REENCRYPTION" =3D "1" ]; then
+			# use temporarily loop device to simulate shrinked device
+			# because cryptsetup uses device size at reducing
+			"$losetup_path" --sizelimit "${reduced_size_in_kb}K" "$loop_device" "$1=
"
+		fi
 		;;
 	squashfs|swap|"")
 		[ "$debug" =3D "y" ] && echo "skip disk resize as it is not supported or=
 unnecessary for fstype: '$partition_fstype'"
@@ -96,9 +124,14 @@ EOF
 		;;
 	esac
 	if [ -x /usr/sbin/cryptsetup-reencrypt ]; then
-		/usr/sbin/cryptsetup-reencrypt --new --reduce-device-size "$reduce_devic=
e_size"k "$1" < "$2"
+		/usr/sbin/cryptsetup-reencrypt --new --reduce-device-size "$reduce_devic=
e_size"k "$reencrypt_device" < "$2"
 	else
-		/usr/sbin/cryptsetup reencrypt --encrypt --reduce-device-size "$reduce_d=
evice_size"k "$1" < "$2"
+		/usr/sbin/cryptsetup reencrypt --encrypt --reduce-device-size "$reduce_d=
evice_size"k "$reencrypt_device" < "$2"
+	fi
+
+	if [ "$FAST_REENCRYPTION" =3D "1" ]; then
+		# remove temporarily loop device
+		"$losetup_path" -d "$loop_device"
 	fi
 }
 for candidate in /dev/tpm*; do
@@ -182,6 +215,12 @@ for partition_set in $partition_sets; do
 			reencrypt_existing_partition "$part_device" "$tmp_key"
 			enroll_tpm2_token "$part_device" "$tmp_key" "$tpm_device" "$tpm_key_alg=
orithm" "$pcr_bank_hash_type"
 			open_tpm2_partition "$part_device" "$crypt_mount_name" "$tpm_device"
+			if [ "$FAST_REENCRYPTION" =3D "1" ]; then
+				# expand encrypted partition to maximum
+				/usr/sbin/cryptsetup resize "$decrypted_part"
+				# expand filesystem within encrypted layer to maximum
+				resize2fs "$decrypted_part" "${encrypted_size_in_kb}K"
+			fi
 			log_end_msg
 		;;
 		"format")
diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.=
2.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb
index 3497d95..e3dd515 100644
--- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb
+++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb
@@ -57,6 +57,13 @@ CRYPT_PARTITIONS ??=3D "home:/home:reencrypt var:/var:re=
encrypt"
 # CRYPT_CREATE_FILE_SYSTEM_CMD contains the shell command to create the fi=
lesystem
 # in a newly formatted LUKS Partition
 CRYPT_CREATE_FILE_SYSTEM_CMD ??=3D "/usr/sbin/mke2fs -t ext4"
+# Fast reencryption state
+# It uses temporary partition resize,
+# consider security and data reliablity aspects when enabling
+# (e.g. wiping old already deleted data, hiding metadata, etc.)
+# Keep in mind that a power loss while reencryption will cause data loss
+# (with or without fast reencryption).
+CRYPT_FAST_REENCRYPTION ??=3D "0"
 # Timeout for creating / re-encrypting partitions on first boot
 CRYPT_SETUP_TIMEOUT ??=3D "600"
 # Watchdog to service during the initial setup of the crypto partitions
@@ -68,6 +75,7 @@ CRYPT_ENCRYPTION_OPTIONAL ??=3D "false"
=20
 TEMPLATE_VARS =3D "CRYPT_PARTITIONS CRYPT_CREATE_FILE_SYSTEM_CMD \
     CRYPT_SETUP_TIMEOUT INITRAMFS_WATCHDOG_DEVICE CRYPT_HASH_TYPE \
+    CRYPT_FAST_REENCRYPTION \
     CRYPT_KEY_ALGORITHM CRYPT_ENCRYPTION_OPTIONAL"
 TEMPLATE_FILES =3D "encrypt_partition.env.tmpl"
=20
--=20
2.39.2


