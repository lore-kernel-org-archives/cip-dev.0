Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585DBC3DA49
	for <webhook@archiver.kernel.org>; Thu, 18 Jul 2024 10:48:20 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.80])
 by mx.groups.io with SMTP id smtpd.web10.12458.1721299690165530923
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Jul 2024 03:48:11 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=YDIUDkK8;
 spf=pass (domain: siemens.com, ip: 40.107.241.80, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=epZRouhJfLKuL0lRzbuv7oIzUx1Zawul4NnyumpXWcSpUKdnaR4cESFPBR/f4i0SFvx+LA/H+0ux3np1Uhf1uIF0aICuRmWONd+VwbJUp8Z5LDl+BOoDQ/+JOSFnzs5/RHZHZpkGvBo/UW+jzwhnVe0oCiO1LLeqvAg5gYtpeHQX0sLQK9ugPDzucbFlrua2JC3lAM6R/Mecv/onSu5PIgk75YBZbgu+j9mrXUz/JJJnLkyt3tnFgu3r/Kbfohf32qMOkGQjwqrwhuBpkPe4moXHly7dtAKgYV3CzE1NaegzKbZB8qU+KfyAplQjYGn7dAc+/5tNRwTFOO20XSbOYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NjRthucpiue/kAu3GbHwBhEulpSGI0+jVjAx68PsivU=;
 b=vlqQxtHFB1PNqG7FjhDtbfYwLI/fO9/7p6lPeAuf8s1nuWeK6IJj6S+qezWYzjJak3mR4PRG50uY29wblofVgyNpelIBhmikSL69QLkMg5CsQjUzMbI3zFmf98hP9MjRoZ35M4L57CETHGZgsSb6wHWBkXP0QO7YClZ6nB9j/Q6zY4XmNc0egPUhV4k2XSrYEMFnDW/4cONeyRvhbuMFO9sB9PpOFVSVWVZTdt2WKcDtTHNMmU/OPxYvKXfXHg3ppPXlQOkaOl+Nwsf3lrJ8TZkKaTG5lPpLEbdlzIHVEnqynkorVumK5s7+Xfoxr53l9GjhpDizghjh3pGm6NGp7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NjRthucpiue/kAu3GbHwBhEulpSGI0+jVjAx68PsivU=;
 b=YDIUDkK8ioVwpMjyAeABbrd6/FJxikJC3dcILWg/dG+tzx6TUMxZCaq3VJrhBgTmrcoBcrsrccmQrU/jMF5bDygWnVnsN/Yn9lINPC/7hucKArzokxij6Wr+Hd1Re1fO7DFaY32WT5u/RIAYOgHAbqHK2HhjugONvyQc7SBS051IfGEP8QtutIa7Ih6ntoX6hE2ltBx8LPox1phoSj+nZO0lcTEyu2G7tRX7HUiSb6JwSBQWZ4odwQbbgSaQXuVpyKpBkkYv4xy+2YYv261taX/FO/zT9Y/vhuzU8j4FvnxljkWcQgo+aw7LFtbj0KZHAS8bLpVjHrFGKRGSwQ6T7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2c2::14)
 by AM7PR10MB3224.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:10c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Thu, 18 Jul
 2024 10:48:02 +0000
Received: from DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f75d:ad6e:d321:cc46]) by DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f75d:ad6e:d321:cc46%4]) with mapi id 15.20.7762.020; Thu, 18 Jul 2024
 10:48:02 +0000
From: Stefan Koch <stefan-koch@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	christian.storm@siemens.com,
	michael.adler@siemens.com,
	simon.sudler@siemens.com,
	stefan-koch@siemens.com
Subject: [PATCH v3.1 3/4] initramfs-crypt-hook: Allow speed-up of disk-reencryption
Date: Thu, 18 Jul 2024 12:47:56 +0200
Message-ID: <20240718104756.1603687-1-stefan-koch@siemens.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0235.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::20) To DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:2c2::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB4953:EE_|AM7PR10MB3224:EE_
X-MS-Office365-Filtering-Correlation-Id: a1bae5ab-3d2d-46c4-ed07-08dca71718e6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?gPWstUggulSHPhA6gRik0riy2jav3EqmcjDL920+xUYv/Yzd2rVi2frxXt1J?=
 =?us-ascii?Q?2H4+7KrFkStiu2v0uJCWajUB7qy2MOTlbT2ZnKjuXl1Rwh6MSckS2ZD8a9be?=
 =?us-ascii?Q?yFl0511L8old9pydL7cHSusltmkvulKS6rmIgJNsC59Dv8Nf0gKqoZOCy88C?=
 =?us-ascii?Q?YBv0Kt0SLv9eu9HgwPsYN4/slEX6m9v94+89Z7YDfACgmCVV431zdXOwnUXB?=
 =?us-ascii?Q?kPQvhRXj626pcY8rmTwaWTUUECvOMZ0DHUu7tjabW4uun51c02q47PJX4aii?=
 =?us-ascii?Q?totT4EZQMt0aXz95LByLDpggjUq9v2Hl4tRekSxVsQzqJQNR9IUDjKlybdVS?=
 =?us-ascii?Q?6bYlSwX7OZujIwTS720JSI9HXRdPhSm4LrSwxO/H6Ffvu3w0/KrmoLLre354?=
 =?us-ascii?Q?/fgXxcSufdbwDVMMBhQsuv0VNnHmijlGjzCBUxVFFfmmv8TPapRS+gBndNat?=
 =?us-ascii?Q?s+dddfC1CxBcq/AXrSMjmu44Uliotkqck45otp7RcODG+iSIJAHwHf2fTWj6?=
 =?us-ascii?Q?A+M0b840+a35FdEoGrJvV+VgBtyAvwQJezfePqjtwtAZ+9S6RMv+hCHsTiAX?=
 =?us-ascii?Q?aScyvWkaU0ydrjcoDcZdq0VP/ENLUQY2lVPPGmU7IgpSsKkPCr/o046amsXR?=
 =?us-ascii?Q?FRbHwxU0pGROpGr98XuO62rlBxBbBbBGAyOqKsJuQ5j2yWgXXn/8AwgU1F2D?=
 =?us-ascii?Q?6Nxzt0+Ff/0400jNsyynwJJfwpNQV8xU8gX+0Q8qBhV3TcwFQsbMele6Ohvp?=
 =?us-ascii?Q?MCSRNyjELwmO/VHYp6RVGLiLdRAud5jzCSlvbAbC3nyOADUcw623U3PuOFKK?=
 =?us-ascii?Q?S3sUTJdDCrid+LnhB5dM2wtgDa0T/Xk+TBlBGbmK4ttjtc8kTmdsfBxNcOlV?=
 =?us-ascii?Q?yof0S/AR9hyCKh4IXRFafeCwMwVWluvWKZwPmzSq/Gx3HEVSiS4JBk09LwRk?=
 =?us-ascii?Q?HqCTNJk1wlB59SIuN/ejP8G6BAEnzdKs03FlVJ99m6gr5HRZ/pLnXHaH43fT?=
 =?us-ascii?Q?ZPqqfkp+ouOoc1U7z7DhGtvhqw+OxfZ0z3UVtoAEGXrcbpN5wl+Haf4lc10a?=
 =?us-ascii?Q?HpJ9FdvpdCUouyAuFowtGY59p53lDSB98ZPcTvLVkXYbk2h7Qx4k1gCFUSk/?=
 =?us-ascii?Q?EW63Ws+5fX/eTC3eHuwC0nrl8S2LXCrHrjQzmwfECoo+Fru5/XmKD7to5Lfr?=
 =?us-ascii?Q?E5qRcn9gm8lOvIfbXUPP5lorS77Ch6hItnzxlP6IhZoWLKx9eYRhtF8W2qDd?=
 =?us-ascii?Q?cl4B53edDsqrjNWPFtyYKJmU5UU+UdqhL3ThbwlrdAJKVBMBAduyzM2yq/Lp?=
 =?us-ascii?Q?1wFri6L5kupo98bv2JSl0sWFrM7tRtAseGHdsa3pwb/XNA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?twk3Hut0R8xQ9pWb0vYvgIa7T4WZJrtkj+mkB5xoC80C1/B4E5ZeUQNgd4yI?=
 =?us-ascii?Q?1QD4it+oEW7Pz3/5yPLRJh8i2puoWY3inpCwIqczXQNdg2e7+MJjYfYBRBGa?=
 =?us-ascii?Q?tb26h5C8zLWqROzWL4gJ7kyRMnX8GJ3cEdNThk/Bfbz2bCntdj94FZ9IpYna?=
 =?us-ascii?Q?9iBcNPQm59ype20IQD+XzqzMJYYkqd6pgSj4WWo61kBzmxrV30cvgwgPVuMV?=
 =?us-ascii?Q?HpFBM1aAGtc9ABsdk3u/ngvz1kaf68HCS270GE8NnfoO4MB6Ur39x5S4nTJs?=
 =?us-ascii?Q?EwGbqVLh71KcUORom0yj/qraCQ0R8nb5eJoEk5zWmqn+Wt39wirfsyBRDUHK?=
 =?us-ascii?Q?Czi07dJ6iWTqEv62p8E7xh32gYIHn3EHyA7nLpB1BHnap/7WP+O+Iw9bQuHq?=
 =?us-ascii?Q?XidtlxgTSwjX26CVLMJ3hfpCboxNAT7JYpAFdkTIr9u6j3Ckpa3dgNdnIHne?=
 =?us-ascii?Q?dBogX6v6lVGMBnTtDooYTxbfBehVz4f4jz0Mw6vDTRKbwDuRde0raT6OFFhM?=
 =?us-ascii?Q?EHv8zBjcV8DKrKgAbXjfjAByb6UCbnRnPWAlo0urUDZAtnfBxJPxCywIhfuY?=
 =?us-ascii?Q?6SVofvaUkCSyJXAtt049JxawJwstk5cw019gxNoSSfLNuoSLl4vHQi1knBxM?=
 =?us-ascii?Q?Zt78wBJ8woqHL3kYF8GVacpLU/CKH4MVi0W5sPrj7VUsgHPhwrsdSPEzyj0x?=
 =?us-ascii?Q?6jkvq/Hxs2PsRc551O2EvK8PIckW0wHv6YCZcNU1aUg/7QMWmcIsTprw/FEe?=
 =?us-ascii?Q?NVQpSLWI40XCK9C1N2Q32zzPLmcbKdaml/2g9HzfGm0h/gQCm5auDmtxXW+S?=
 =?us-ascii?Q?gP5shtLYX6rP0DwirU1+8jC6Hn4osBC7eJ5ENNmGxlUlPz+oXz4ZW8YPhYZM?=
 =?us-ascii?Q?QcZWRM1rcTTDQN8wLvvDFWUbBP1l/VsHGBssqwYyJeLurO3Wxdgq8SkOYq8a?=
 =?us-ascii?Q?HgA03C+wfPBo3otyKVw/lxaFg+wByxeKp9sDKHdxg47wHsT4LnfTbq3s4MCE?=
 =?us-ascii?Q?CtG4jSIPeeYcmDNqgdqTWwVlUYzJEurGS2FC3Zz3frMz2v9WnglK17Fw0Uwn?=
 =?us-ascii?Q?YftoZ+zsDVVqmXFBEy270PNl8f4w/mL9iloLNbIzqgpFMSWDkXLrFfHzzXUj?=
 =?us-ascii?Q?QM1svdDzzgyXyI/Z9n2s80COH3h84XhX4AO3VGZuseQGGaKyEh6NBqXoJsI/?=
 =?us-ascii?Q?fvrE/rasaK7cRliCGS7vGXolqDniOOdD0sMMt5LtgH7/PI42VgYwWI30bLox?=
 =?us-ascii?Q?kCWfdwZqWjN7JEY15Xx534gTzwT4VXw/3Kv89A0M+q/Y+syhHeknPUDBAUWY?=
 =?us-ascii?Q?PjmnPpiEgZ3HBUOuMk7ARo4SWtrTMLAhaYDbm8g1NLuLZKXn5BhOobry6fh7?=
 =?us-ascii?Q?6g0IQ2QzGzu6ki9LPCtyKeSR9Q5525rfidoLelsqnUMrItyHkTi1f1Hgpnoy?=
 =?us-ascii?Q?BUwsr6GdwEerLjuVXoKCiE4Z3tuiaslO1yt+oGGnHgkQLbODGU4EtqoEJbrj?=
 =?us-ascii?Q?r9vn0cJAWrEvghiAopci9wXLmDUSeXH5LsZ3xY39OCNpYjwoXuj3f8gLbF5g?=
 =?us-ascii?Q?SfIV1o+L7oTT7HdirUbRAeNUmOLCzbnsVQfdWynl//5M4x8AfRER8RWur7Yg?=
 =?us-ascii?Q?xNU5C9jTWk8UeHyJRcR+6kgwwJTXYuYNhOvVBjdhZabtqlORTfOKhJnZOK/d?=
 =?us-ascii?Q?0SW+ug=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1bae5ab-3d2d-46c4-ed07-08dca71718e6
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 10:48:02.4426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Scb1H/7km1q/PnmVLijICtjKFEZ9NWJno4TRymRPrer8entiSnYrr4wVAiXRrAcRXjlqQU2fwYGUdoUXm0d4KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3224
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Jul 2024 10:48:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16583

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

A temporary loop device is used as wrapper to simulate a shrinked device
because the used cryptsetup takes care of the device size and
the --reduce-device-size parameter is limited to 64 MiB.

However, this speed-up lacks the described security benefit of
implicit data overwrite. In general, there is no support for
explicit random overwrite within the initramfs-crypt-hook, that's
only implicit for the reencrypt case without speed-up.

Some disk encryption implementations like within the Debian installer
will overwrite the entire partition with random data for security reasons
(e.g. wiping old already deleted data, hiding metadata, etc.).

Keep in mind that a power loss while reencryption will cause data loss.
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


