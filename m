Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F17C3DA61
	for <webhook@archiver.kernel.org>; Thu, 18 Jul 2024 10:32:30 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.58])
 by mx.groups.io with SMTP id smtpd.web10.12258.1721298743786560977
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Jul 2024 03:32:24 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=nnX97XGp;
 spf=pass (domain: siemens.com, ip: 40.107.249.58, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V3mwtuH0CH+hntuaJu2BkK5wBCK8Jag+cm+43XOWNyMz8KtKpeiPGUb3R4QAaAVmaWcNVApL53QTDrqkJKyyk86WOM92rZeoGuym+NrDjhNRe7NAnRjICbHx4czE1wunu/+Xrojoa03w0KFK3/s8qyJ2PdDZB5Ciiz4PO2FD7PeFsj3w2bvGv8HdMFzJegFl4KNbJUcpEoY75Ocqw4OO45r8/HvxCfHClyQ7HUHetWyt2KceIYCeJYWQF9DmSxEkB89/fR04hmxhYAr2BYhFe9YfCH8fpu6Uh718f8lk8Sq7gkZF+qbzDp3uljHwnbBZRTNQsl30DHw8R+RvXMwEDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W5NtRbt7QNLPEYarVwq94bYisbxes2UEJkZcIlRKKRA=;
 b=qwyJScOCqmnvuJlZnzS2ywPm43XEX8hBAdxeJ2hsLDkaqih+XLFUz2DAIgq/vSinIBs4/RatfMEHnPg6WPk3sKKHrnUkW8wh+SIJlF9sNloHXiVjOpgBixglJoD3ebVLyW6QTp979rwXPQkBL2a8dnqCxKUSkTuavj9z857JUOBcVt6qGVgWyA07IlXTML2FjZd/btvzBAk/wcBdobZ4F+rTr9ML5LRRe6lXyrfpEI1ufDLWQI1XQzR416+V7NOoVYvKNMqMHo2C+NlA8rERLOILzGV7ryWjMexe+9EhnLWth2j1b+LYlV3vJzuGLTBK1yY4NX/7T4AOsxHuTvuHtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5NtRbt7QNLPEYarVwq94bYisbxes2UEJkZcIlRKKRA=;
 b=nnX97XGpnYIRODhjpeIIiaVa+BGlNKPziwLeCMfGuJliMD7+V4L7WIzHRn1klVnlQWSOzX8NjBPiUiVjsZA3pqSDUFfLUU9Kf9XYjSaR7ESyGyMhIfDjnG29HBprfCBN9MrBmaAZ2fKPQjhyoYtiB2HNJKHEqdqqlHjfBar/PSTN3vhrKrO7P9JzbgQQtjyxewIgipDrwKSpudDw9Bv9td9H+R/Ur3xKDi549ousommy1aJvFnkFuUeJgLM/mK7tA+rkkHO0vuL2C8EGlShyhRF9Kcb/JK27hYjIxJwW9RLs6pkr81SW4YM7SPH/PxrX4WIkjn/wpiHLZfxRvJcquw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2c2::14)
 by PA1PR10MB8389.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:44f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.31; Thu, 18 Jul
 2024 10:32:21 +0000
Received: from DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f75d:ad6e:d321:cc46]) by DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f75d:ad6e:d321:cc46%4]) with mapi id 15.20.7762.020; Thu, 18 Jul 2024
 10:32:21 +0000
From: Stefan Koch <stefan-koch@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	christian.storm@siemens.com,
	michael.adler@siemens.com,
	simon.sudler@siemens.com,
	stefan-koch@siemens.com
Subject: [PATCH v3 3/4] initramfs-crypt-hook: Allow speed-up of disk-reencryption
Date: Thu, 18 Jul 2024 12:32:13 +0200
Message-ID: <20240718103214.1583403-3-stefan-koch@siemens.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240718103214.1583403-1-stefan-koch@siemens.com>
References: <20240718103214.1583403-1-stefan-koch@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0428.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::11) To DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:2c2::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB4953:EE_|PA1PR10MB8389:EE_
X-MS-Office365-Filtering-Correlation-Id: afd44357-a2a2-4fe5-b643-08dca714e818
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?dHGMfrdt0fX+kRMkK/KollvL70GyJcUlkyZLW+cvjXLsliKmvR2itl/lvCAS?=
 =?us-ascii?Q?XEjGNnE1yw7VusvYpyC+MlyClJH1ugmDxxj0UGO/GcyASa1PUAAQ0J49/U/z?=
 =?us-ascii?Q?u6+NKeaWLAuyqK1pSXTuOp2KPYNS8r6o1uHPBfuDBiWxWsAMyXTalo0z4IeC?=
 =?us-ascii?Q?NORR0i1jhvcfiwuGoej3VuyNEfZAwRHuUVtTB5HC9JhuhekiAWs3biiPJWpX?=
 =?us-ascii?Q?dOm8LHkXJR4Jn7IlEPHsyGssD5XdLLCQDyFWE8jomHnn0CuIVsGYimetsxvN?=
 =?us-ascii?Q?4iJ7o1d/2/BZRo+c3/vEQOR1GsDdMXvJpEu0KWMAfQCNRGkEtUMYEUX3QfDd?=
 =?us-ascii?Q?fwayDtoHu6a4UVXSvuSQinrZQ9D7E2MFDVe5PDTkW8LjEYFzd4aR/JFX2yek?=
 =?us-ascii?Q?vqVymO2qVKnUJyqJjIbOHDf5R2wJWnj4cttoNyZDgWwpizxLmpuvsSlmdNP6?=
 =?us-ascii?Q?+Rvboj0Z22RYsa0ouQT/eURSwtNuwUPy5d1FwFlQjVdf5zqxVOLwgg3laY2P?=
 =?us-ascii?Q?LAcx6WuwfFTGjAe+yu7XF+Cixc7XqsoPOq6RZYUVoq2bqdSHU7OpAusBLKST?=
 =?us-ascii?Q?IXTOxC7SX+FNaFtbjfkzSDJRQsU9FFazatm5k4uKhu+OVbUz6iRafDo3NUgb?=
 =?us-ascii?Q?pA6Zb9/GEomfdhorCUEpMB1KI/UDDHWObenz3K8CHuUvCrZ4H8j2CtiMEwK4?=
 =?us-ascii?Q?tJaoL3KcoVktpB3GGLpzJs8OmJVoERLsSYEuK8gGs6DO89zyyVHapgRY409Q?=
 =?us-ascii?Q?MQy+WWR2voalqQGoxy3JZbTMnv+WSXdbSwZ0+7f+QPw02UZQ6dPciUv8rknE?=
 =?us-ascii?Q?oOMkVDGNG8H1SjCcRwEoqt6jfXLPyiUxQq/dL+Mrr603kY7X5tSbAglrFeh7?=
 =?us-ascii?Q?kJZl75rjA6FfEclzEOmpOXD7X7GwYk4KHbjavEML8igN0wca0pGkLS2/glei?=
 =?us-ascii?Q?gZ8XJ0esLQkLIyCdTqJtDrpeY+84z4mx6r5V1seWrMMjYXQuAZH+LHSVfUW0?=
 =?us-ascii?Q?L/CcK40BcA7bmx1vX1ewzkKX3QeYmm5QSMgRBYyacc7ZSNRdf9KLcMjQvWrd?=
 =?us-ascii?Q?Isri90wlTSSfoA72XeoZjFCLqS3lFxVBV/LFsKLWOmgtFYyyfrgGhzdaAJgy?=
 =?us-ascii?Q?YOo6btBRx1DOWq0Fn7nW5y7WrS2fMhHQVpfGimsJ8Mnx8OTRUeLpsnfXFxof?=
 =?us-ascii?Q?Mb8C1CzRmqopDgPLfFKZ4Hs3d81cfAoP8I4q9Ha2l6FDlM1BOFrFvvjgUbBW?=
 =?us-ascii?Q?TQUHshLQZIMBG0YxC7//+oiaqyeuBEWn6JHg75n2v8fOQnB9Yh5Hgg0y2CDT?=
 =?us-ascii?Q?Lq2C+mYpdnjj/DoTmgbXxi/CNQ1rVJWj/6hCLAaivaI6LA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?NUiBU6CflvjAPHrdVY8ZABzj8IM4AjXYJAk6rBXbSuaIyrEsaH5tQmCleAcg?=
 =?us-ascii?Q?jB8ELmpUtXlyFm9cPu0VMTxoMT6fFkexN+3L4cai87yKTGa2M/3GLcgYyrFF?=
 =?us-ascii?Q?G1j97S+/c+ygLfE8/i1boy/9X/zCCF52TEb88qnVEVdrtsJiny9JVIjHiX+9?=
 =?us-ascii?Q?mg0bg8wuua/fIAG2aZTjsh0+4bX4DLoL3NNn1uPZ9iElCiUBIFl82zrPWFIg?=
 =?us-ascii?Q?QCw4g115H7IbFSnKQhWiumywStd5rTXkbwJPAowInz6mbRq2svuqzwg3S3f9?=
 =?us-ascii?Q?n2KIrffx4ldI98DHXqn7GlKHWK3ofuD1eJpw4rpyj5LrOh97Q15xOCLhYeoL?=
 =?us-ascii?Q?YDF1QleFupUbSJ4CPpMdXCsg3QmzWELbvmXNttdBE+LCB+Utdbxo54vIcQc+?=
 =?us-ascii?Q?Mn5y6KBQ9GeHRCzqytAcZZRy2t14vBsXga9L9ZhDNAqltifcdSuFBQ95mtu5?=
 =?us-ascii?Q?72NsiUzOXuylIzyWXhQxCAGLuCR3frMmU7XiiavhWYbt/Pcl1C76CYE20J4T?=
 =?us-ascii?Q?t+SOAt7VjNO5f6dVvA1JE+yPlXFoEAegva/tykz+waD3dydoIz96kQD3ctqt?=
 =?us-ascii?Q?5B4G9D9qqq024z4EZJmQ2RjI4qHDUNE1EpDaqXZeNQv2NPrK1Z9szTME0GpY?=
 =?us-ascii?Q?jAvT2GAadQGIv20iz+Pl9rl8BeQsZQ3LQEOr+4fpnF55vESSN7CInciNIH7K?=
 =?us-ascii?Q?tvojTf1vxy/OAW97Bqv4hnk9kJRKWA6SrlyVAy/E9/s1gpi5hYgHCOQfepdN?=
 =?us-ascii?Q?KltuVUMOZnxbikyK00x78vibruWmFljeeDkEE9uBvE6h7vnm8Bqp1S7JKNDa?=
 =?us-ascii?Q?p8M3pmTetMIUDdrE28J/f1ziUWxQeHvPFCgEUWAYBfyWhFD0ydyTU2B8DyUN?=
 =?us-ascii?Q?/65WgKg2UcvA2ShZn5l4yfrCRpNUsErqpXiIlUgvWmJJfi5vpSHuDxCzOfpQ?=
 =?us-ascii?Q?QMDixMvf6aLoB+/QeUNBquzFq/QETYyLbhO9W1rRdfRtEWSczrV8QisMzyZw?=
 =?us-ascii?Q?uQnqz6vQUP2AgPe3KX9j756DA6yfIiUIhWFH/MfAnBBj0SvtIcV1HfMFaS1y?=
 =?us-ascii?Q?i3o1GHJGB/5p97vII+oBcYro7lqWYAd287BzPfpJrMj5ScVMTDN64zXxq9/B?=
 =?us-ascii?Q?XTUrqeHu90uyQXtR6+JkgAdvp5qlKT8WuPAbSgnlxl7sTqntmCupPOpXhmpN?=
 =?us-ascii?Q?0Wq7RyOPpxwZUnHUTd6L0gGFvm4RSDL/tdsXISwP3v0KM96ft2rWgjEXvtB3?=
 =?us-ascii?Q?o2FngDHxNLkGxwilUOblogqcAzFCWVnygRs1tFkKsKtvy5xCQ/jtyn/Yo/QF?=
 =?us-ascii?Q?4qxEPWrl+vqeTsXWvDyjQoxh357/J3uI/WsUIhzChzKs3JXjyCuyiRxP2aCA?=
 =?us-ascii?Q?sqeA36j7hPT44nO6ndQqDG68vzAVFk57uPnItplp6tIgP38sHH9pgtRXonRr?=
 =?us-ascii?Q?zud4ZvhOGkBisZWXXgOjE4LyxzCXME7lPfOC94mHJU5mv6DVP+FeiOTbPhPV?=
 =?us-ascii?Q?rsymYxST/n3OfNt1uFNAJVCzwjCdbGsv+hcDVpAwdsZtIv0XMXJCczwTV5hx?=
 =?us-ascii?Q?E90IxoWStMX4CfmYagr7zlLknOZ9QYTvI21/tcFZtj0EPaOJa8DSVB1iU6sS?=
 =?us-ascii?Q?hPkuvvWxw0PlN9pABHQpQ4g6392RkbdFb1xwID7A7UgB?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afd44357-a2a2-4fe5-b643-08dca714e818
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 10:32:21.5863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PjksYOLdiu7kDSxTBrwzVA2dpltkodn7R0daCnbLg+WeXFqynQVhALtKafuwhbFRSVPEWFH0r6Rtq1wmn2y36w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8389
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Jul 2024 10:32:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16581

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
 .../files/encrypt_partition.script            | 56 ++++++++++++++++---
 .../initramfs-crypt-hook_0.2.bb               |  8 +++
 3 files changed, 58 insertions(+), 7 deletions(-)

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
index f943aea..f72889e 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
@@ -54,6 +54,11 @@ if [ -z "${create_file_system_cmd}" ]; then
 	create_file_system_cmd=3D"mke2fs -t ext4"
 fi
=20
+# Path to losetup binary
+# binary must support --sizelimit parameter
+# which is not supported by the busybox variant
+losetup_path=3D"/usr/sbin/losetup"
+
 service_watchdog() {
 	for n in $(seq $(($SETUP_TIMEOUT / 10)) ); do
 		printf '\0'
@@ -62,13 +67,16 @@ service_watchdog() {
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
@@ -84,9 +92,32 @@ EOF
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
+			# use a temporary loop device as wrapper to simulate a shrinked device
+			# because the used cryptsetup takes care of the device size and
+			# the --reduce-device-size parameter is limited to 64 MiB
+			"$losetup_path" --sizelimit "${reduced_size_in_kb}K" "$loop_device" "$1=
"
+		fi
 		;;
 	squashfs|swap|"")
 		[ "$debug" =3D "y" ] && echo "skip disk resize as it is not supported or=
 unnecessary for fstype: '$partition_fstype'"
@@ -96,9 +127,14 @@ EOF
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
@@ -182,6 +218,12 @@ for partition_set in $partition_sets; do
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


