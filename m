Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7774C3DA45
	for <webhook@archiver.kernel.org>; Fri, 12 Jul 2024 08:12:00 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.69])
 by mx.groups.io with SMTP id smtpd.web11.3144.1720771916444724822
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Jul 2024 01:11:57 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=Zzrz/XAI;
 spf=pass (domain: siemens.com, ip: 40.107.22.69, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nkroddKBJUFQqqsf6P/HlCZ9+ixY5wTI9zMYjupX2u/PDO8NbPOWt9OI85YEkS659CYJyLAHAEghA1R5gPrjKPb9/kL6qtFNXjISfgX3+vwuq/WBpluB/8yyEpOiMAUhaEpNwr2VIZ/orsy09nsQLFrzeuLSmkFxcBi5qsHwEUvWaKABGUyquYaodHJ1BDxT5APd/0jcaDuLcKMqpkrhatV/LgfcvXON0sQZ5IDoY56sjKauP6uO04miOJWkxqMxUma4ndXnfWxWukfVxJUSn0bKX5cLHkpb3yK3ZvFsAtzjXwehRt2bVwv8fFBOrgCVYHs/FqwN/vbC0XE6AabTPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ba9y4KDCaEb23d7FS43uUh/ESktNEkzhli+JTZceamg=;
 b=oP2DW9LB1wB53mQKqrep2HORQLDZ2bPwUdwobs7+ZiOD8DII7JHJYim5vVn0NOpQefwkfuOuR9HX0+YZ/ySVURk52QixvIgd45yXyT2Q5OIxcdnMv3xrfgcYTc1n6TjPx52qoPzM9yC0/InfH0vHauTVJR3VtqpS0s3wRs+PI2wOOwDpY7iLpEeMSpKvnlV2jYI03HAMTLI6GoyK6PFsZ2P2vJPmW96Zs7+NSRDqPFqPxrZtzZCB9s3Nbic8erPzpXQrE48oMwoXyMhwGNZDu9WfKYMrN0TJuVIhE9HlLi6A13A030FF22LsxL32tFAQhxJsbYT67WGr3cO/uXBqlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ba9y4KDCaEb23d7FS43uUh/ESktNEkzhli+JTZceamg=;
 b=Zzrz/XAI3GQp0qwi0bx8Qh9i0a8d3mWuA6UrAzSOue9WiJWJhkFSWRStZCZUabwj0GOj/nkBTjklYFBiQtqpmPTNgYlqLOg4t/8ZPBl+U6q6qvFejiRM4VM8hOdv27hI38xLf16XhaM1FThWWkwUrl33jgQ0pP+IhIJ2wjGc6gr38XlCIgjJqkNC99LGod4iSlhEbGqenn6445w6HVUhj1tXJm/MhKWLX43mjPQYi7xm9fJEl8aVUy0dZGN6zBfysgxbALHXVLd6zdXyfc1+I6AuKKCDbFGJlXYXcJheJ0KupRf5wSD90t5GpXCHi9Dky8yl6WLKMc3KNgOLptRtIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:41e::11)
 by GVXPR10MB8316.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1e4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 08:11:55 +0000
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec]) by AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec%4]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 08:11:55 +0000
From: Stefan Koch <stefan-koch@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	christian.storm@siemens.com,
	michael.adler@siemens.com,
	simon.sudler@siemens.com,
	stefan-koch@siemens.com
Subject: [PATCH 3/4] initramfs-crypt-hook: Speedup disk-encryption reencrypt
Date: Fri, 12 Jul 2024 10:11:42 +0200
Message-ID: <20240712081143.1376952-4-stefan-koch@siemens.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240712081143.1376952-1-stefan-koch@siemens.com>
References: <20240712081143.1376952-1-stefan-koch@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0032.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::13) To AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:41e::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4959:EE_|GVXPR10MB8316:EE_
X-MS-Office365-Filtering-Correlation-Id: 40c9bad7-70af-4c83-df00-08dca24a4b04
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?L1nj/DFkDxvr7zjgchc6BJr5NxpFbcgV27l+ybwWuTelMIlIYQbmWgvzvzRt?=
 =?us-ascii?Q?XPvxShUb88H2fiZ11NqbmqGeQoy8E3KRfARKZHQHyFQhKxQKLAfIUYVihK2l?=
 =?us-ascii?Q?qXJZXDCDyn3bH/33jcXjmq3oIV7jAjoa1fdnrKzjdvEMPcbONLgD1N9wpKos?=
 =?us-ascii?Q?1ob2BIwq31QlqxUGutlGqX5lTHKoaiiSWQJvYnFz0zw9nb+BRDoO/l84/TBD?=
 =?us-ascii?Q?DIV75nVRlmnu1afhyqllKBXI4ituxS4DK8geU7si9NpCHYUH3p0FXf8tOoiS?=
 =?us-ascii?Q?4gpYsA2X6EOZTW1A/dUh506F7WYdZuTl+TarAun/1OCmYakD5XH0xgbgCaC9?=
 =?us-ascii?Q?cU0CdEO7VAYNPnAnh/mn71T1jmNUlXjTtq3beEuJlR2CaaCumsgACw5eWV4v?=
 =?us-ascii?Q?yxRi7gBy8ipLwCg3ejqYzgSr45k6zsscpHsZ14hr3EMsSNMlj6KS68HD/LrF?=
 =?us-ascii?Q?yjsbNAndBaBhCkwbPOuyagsyiuv2uVBKtQYoiVZu6WdJgpcOiPPkmQlJb8be?=
 =?us-ascii?Q?X+Ck+YXpyicnzVb29eydkf2j/CJBzBJlUGDwgsCnWu6EiUfUeHb1cYGkfd8i?=
 =?us-ascii?Q?dyhgh3VHfZTuK3xdCMtQY4lJ7hUk38xKZkjaNVCkrt9KJWA+dDmkYhiS4LZA?=
 =?us-ascii?Q?tIbbIDY6rixP8XuJQlu9gkKMaavM+e5oh01a0x9vl4BRw4UE9FjJaQnZUOEN?=
 =?us-ascii?Q?ppOMsHSXWzPsvvSE8sg9JxeA0nMoOhLwaCBqCGPtJMMuDQ4rwWqOoq8Y/v7N?=
 =?us-ascii?Q?NMu5BH1xibuHNwJh+ZIn+wCRfufGGa42xrotx7o2XRK7eRuVlqkcGW4ISI2V?=
 =?us-ascii?Q?P8oXTU0tULuReo1qtJtHsuGBnCXtf4MoLgQDQ/fYmQThMy5btKhwjzCEwYLy?=
 =?us-ascii?Q?kQBz4FESce04n/BY4XgfuRoNSD5oho1Y/DQNF8tHZKCoG77qfHROcCMP5GJh?=
 =?us-ascii?Q?+BQitrUmloBCEzYLyu5fST04IH24hvMGfLmDpR78z/9Q+OASrzHpAvCQpCto?=
 =?us-ascii?Q?M0BDkQzTrPtIab53R7c0w0qz1wFzQNzvEDkVbsBLfax7zYsS0McXhjH4XVbX?=
 =?us-ascii?Q?fUz6CXCwfZT+9H0L1Vzpgrdb8qc1G+0NnGDrLACtsduCHHqf1G+Y4gjh+6uE?=
 =?us-ascii?Q?TZgCN2BVGhcbUFh4IvFrR7OnxBNJ59Cr8PxbjVIQAs2zpTSL8UmJ7eKnx2W4?=
 =?us-ascii?Q?GHzilEuqFMgApe1GeimGR4yteoSVeREq9QKXNKQZzzWWv2aT84HaVs6jiN1y?=
 =?us-ascii?Q?mGkjs8QVliLfWL7Yrk4+kTJ3SJKbEcAhlqCgBbG3f4XmIp/muYs29v9HUtoq?=
 =?us-ascii?Q?uP3jCii18XNEWj0feLbCvJmWePaydqz2Y9Yww4Ambld7Kw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?heEe8UHXdAIn5R/51+OtuaB7+Y35y2HOIAqnMMnPV3yNto5VJKJIwCXbA27a?=
 =?us-ascii?Q?eS6F02+QRl1zbi43wO7OrDFGLizjCv34ljD7uSvMeIsKGMNww4XjkILe8N8c?=
 =?us-ascii?Q?7XNA2KuWIEukV8ct87iGb4vfb57vRB3QMjtrhxyy+k8EVGARRuua4GVbJLDE?=
 =?us-ascii?Q?+Yro9W9asoeUKqEAFN7WV6aqJ/OU0EY0y4SPQXb6SphJfZNsFtgcvR7S7Wzj?=
 =?us-ascii?Q?7va9EaQCRbmweiJ/T5dawGKArS4WwagpEYckDAOA6nbajiV58jatJCsH4MWz?=
 =?us-ascii?Q?Fb4jEpe5axVXJF3FfK/F5EamA7hq2+y7kyPanXS6HNFM2zY+dj/uDKwoNfyo?=
 =?us-ascii?Q?3FWTgn2TGh1SKDVA76FvmnjC8qc50w3/LqBWv+5yR/ey66sWfJ6gOB066FOn?=
 =?us-ascii?Q?Q8AnBELEyCLUS7d8e29cTOiz/CKBrVWUuTLW6MrttvG2JSqntUuSOlPH3p18?=
 =?us-ascii?Q?4J58ttrYtYgCfWjcO0UnVxqhei0sz/YR2bminIxWg/2KCRYj1GGH5STEbbea?=
 =?us-ascii?Q?TYmSibq0d7feXBMnK3Lmwc0GRKua3EtHiSafdZ/QMRF+spxGZbe8KTTW5T7/?=
 =?us-ascii?Q?1+8Uxb7kr0BzS+1QCgcebR+IKHGvJUhymgcInkCPiZOMr7LcSDemR6eovW7j?=
 =?us-ascii?Q?MiZkN8pLnygak7LMgETqh75iFEZGJO/FPvhisreu8cBA1w6lfcEIhDlPEMVj?=
 =?us-ascii?Q?Uc1H5DtDHsVZrvGs43lYaeeBeTH4EH0gmCy83dqqyeUQRjh5z1JV0MALEcH7?=
 =?us-ascii?Q?kxHSVpDu124TbcpZRq4t+YfcYXvxbYMkvt7pZ1aiYKQ+WqrIk8kKhkKXMrfj?=
 =?us-ascii?Q?OfgeKCAITfFdOH9DMiAawaxOv32mo+ncX8h7iJgy8yyYyIEPA6HFkbwMAYAo?=
 =?us-ascii?Q?TK6Njj4f0NoszLrnC3RCLKU+7W+GW4IBxODPGsH3GD3pR+FZG69oOLcPeEUu?=
 =?us-ascii?Q?U6VjfvdGauMa6HabxXxPHIn8gX+WvL+jFIiU+isifmVZ4AV9N5zOMvE1t5Mf?=
 =?us-ascii?Q?ElUQbDNw22KI4HKkPUUZNvJyYzoyWAiuUSiAibTA4KNWmxEHZKIcWnihphgs?=
 =?us-ascii?Q?0lGjGvmfRrnyOOBoWPERSbBSbM0+C8yU2ftqVitfn+pM4+t10z/WDeleZbpA?=
 =?us-ascii?Q?+aLOAnwRgiTDICGLusgviiAlbDK0zPFMcOFugFKh7LSxncNSdh2ExONS7/jU?=
 =?us-ascii?Q?udwg963J7xiPbObTIfYajP91LOY57sDbiElZlutER+EQo5EMEu1Klrp7ZZAm?=
 =?us-ascii?Q?IZQ5RnfO4RgLiNy2SUxwhE6vD4jTWecLY9UblC8B82TDduD8FH7jmgxODUHF?=
 =?us-ascii?Q?oGn07wZl+mc8QyMkmDUNPPYOdmddNKK1MUEOXxzG/a7Atd9U9v9S4j5CnwTd?=
 =?us-ascii?Q?rIvxDFfPKjvjPVOcZyUKZeEHBZEkIR3RrRRK2HTm/XingXQnkDwdxIH/SNfG?=
 =?us-ascii?Q?4Znj6lHvXL7rYYlj6tVTgZkWak8GheVmzy+YoiULd/RmZPpOQl2iGVpbdZoK?=
 =?us-ascii?Q?4FY4QOeEpmbQsIqttHeWK6tQOzJZ0OAxiVhCtsORMSwGfGjPD/kNu/eDWe3i?=
 =?us-ascii?Q?6XUYYZn6SU3LOyG/xZ5Iwjt8Gq4l6ArdERQ0ttkB7mae+h3VEzyprIHLQFms?=
 =?us-ascii?Q?wKGrGLTp0s9KNglMoUGHPdcWKmUMeJ/7klXb//HnEweK?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40c9bad7-70af-4c83-df00-08dca24a4b04
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 08:11:55.0636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xz1CcqZQ6Y0V6fCdSqJ3YQLmbLizBxeTlXILnySo/D81/j34GjaqPUe0r3j12Q7f4TMLG71fuUdUXORFkJYHCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8316
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Jul 2024 08:12:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16460

- When "CRYPT_FAST_REENCRYPTION" is set to "1" (consider security and
  data reliablity aspects when enabling):
  - shrink partition temporarily to minimum
  - encrypt shrinked partition
  - expand encrypted partition to maximum

Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
---
 .../files/encrypt_partition.env.tmpl          |  1 +
 .../files/encrypt_partition.script            | 50 ++++++++++++++++---
 .../initramfs-crypt-hook_0.2.bb               |  6 ++-
 3 files changed, 49 insertions(+), 8 deletions(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition=
.env.tmpl b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.=
env.tmpl
index 72033d1..9f3df4f 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tm=
pl
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tm=
pl
@@ -6,3 +6,4 @@ HASH_TYPE=3D"${CRYPT_HASH_TYPE}"
 KEY_ALGORITHM=3D"${CRYPT_KEY_ALGORITHM}"
 ENCRYPTION_IS_OPTIONAL=3D"${CRYPT_ENCRYPTION_OPTIONAL}"
 LOSETUP_PATH=3D"${CRYPT_LOSETUP_PATH}"
+FAST_REENCRYPTION=3D"${CRYPT_FAST_REENCRYPTION}"
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition=
.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.sc=
ript
index f943aea..e768b54 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
@@ -62,13 +62,16 @@ service_watchdog() {
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
@@ -84,9 +87,31 @@ EOF
 		if ! cryptsetup luksUUID "$1" &> /dev/null; then
 			e2fsck -p -f "$1"
 		fi
-		if ! resize2fs "$1" "${reduced_size_in_kb}"; then
+		# shrink partition temporarily to minimum
+		min_size_fsblocks=3D"$(resize2fs "$1" -P | awk -F ": " '{ print $2 }')"
+		if [ "$FAST_REENCRYPTION" =3D "1" ] && loop_device=3D"$("$LOSETUP_PATH" =
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
+			"$LOSETUP_PATH" --sizelimit "${reduced_size_in_kb}K" "$loop_device" "$1=
"
+		fi
 		;;
 	squashfs|swap|"")
 		[ "$debug" =3D "y" ] && echo "skip disk resize as it is not supported or=
 unnecessary for fstype: '$partition_fstype'"
@@ -96,9 +121,14 @@ EOF
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
+		"$LOSETUP_PATH" -d "$loop_device"
 	fi
 }
 for candidate in /dev/tpm*; do
@@ -182,6 +212,12 @@ for partition_set in $partition_sets; do
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
index 1679133..76ce72c 100644
--- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb
+++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb
@@ -59,6 +59,10 @@ CRYPT_PARTITIONS ??=3D "home:/home:reencrypt var:/var:re=
encrypt"
 CRYPT_CREATE_FILE_SYSTEM_CMD ??=3D "/usr/sbin/mke2fs -t ext4"
 # Path to full (non-busybox) losetup binary
 CRYPT_LOSETUP_PATH ??=3D "/usr/local/sbin/losetup"
+# Fast reencryption state
+# It uses temporary partition resize,
+# consider security and data reliablity aspects when enabling
+CRYPT_FAST_REENCRYPTION ??=3D "0"
 # Timeout for creating / re-encrypting partitions on first boot
 CRYPT_SETUP_TIMEOUT ??=3D "600"
 # Watchdog to service during the initial setup of the crypto partitions
@@ -70,7 +74,7 @@ CRYPT_ENCRYPTION_OPTIONAL ??=3D "false"
=20
 TEMPLATE_VARS =3D "CRYPT_PARTITIONS CRYPT_CREATE_FILE_SYSTEM_CMD \
     CRYPT_SETUP_TIMEOUT INITRAMFS_WATCHDOG_DEVICE CRYPT_HASH_TYPE \
-    CRYPT_LOSETUP_PATH \
+    CRYPT_LOSETUP_PATH CRYPT_FAST_REENCRYPTION \
     CRYPT_KEY_ALGORITHM CRYPT_ENCRYPTION_OPTIONAL"
 TEMPLATE_FILES =3D "encrypt_partition.env.tmpl"
=20
--=20
2.39.2


