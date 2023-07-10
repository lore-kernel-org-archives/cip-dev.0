Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29E5EB64DA
	for <webhook@archiver.kernel.org>; Mon, 10 Jul 2023 11:23:09 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.71])
 by mx.groups.io with SMTP id smtpd.web10.37111.1688988185952063172
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jul 2023 04:23:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=lrZYWGWi;
 spf=pass (domain: siemens.com, ip: 40.107.21.71, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SmrLH4HCPlkrELDMFHs5HpFUbAklMALPbmoMnsVMrIdNcBMU8qe6fw5A9lC4jNv2xf8SEfa/3z7aticvTHFyEUCQxxOp1eafp37BfMhIDx8Pf3d+U/mTfkoyRQOKFyy9vNog6D4TUyaozaEJoT0RH++guN/KSbFExZIO56MGYHusm6E7uV2pUc6dkqQX5HY4RuaAB7wgXhOcoq1MHjJFxV+No8jR8wbC88nijESD+InkrwqmJooQnLj3J/dhRGYX03hd+BjXCmCbj7OspM8CjKE+mzaouPTb29BQjg2VTjaRcBD3fCxIJ+6vizzzmJXggRhSAemJsc+A77RJvp69nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=npHDgBZKxQmmqOeBFHKnDqhc09P385SsjgXEtiWOdAc=;
 b=ioKPiov8u48eklbxbEBdIAF7K0E24dbvI2gSKkyaLDqrdIvq+1LUImFGIe8q8LRn0RDpRf7H1hK+kocKNrhN8TB+HuxKLO9UgchX3aqJV5/k3b42w4PCbKBFkbW5HGtLxZOlOwgPRh8p0zexG2C5oVcWT446xoO/L4xs03OMqXkuXMJwAqlwphNpunWvFri0LSuCDuUxHDTNGbsbTRejLeu4B4wT9N1YPkUmGvfxYNZa0LP7BECnLH/MNts4RefH6ohRnQfRMAv3d5qRIUbIDImbb2z+a7lGXbA+Fu1izoxU7iTMbHlnlYxiNJI0EKmY/n++pC5DcDxjOEDtu5OdRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npHDgBZKxQmmqOeBFHKnDqhc09P385SsjgXEtiWOdAc=;
 b=lrZYWGWilQ7Y9LBIhmuHVv8j+xXYBO9yf4gfku14L+Jjx3TJfty+Ool/2gSS2vHid/XDLcc5VfwnAKpYQssyaoORUoeKngm1buMrUNftoFEGH5FTcaDp0FkzP8zaws6F5eOacKknkf2Iz7RchwlXwMFU/r1YKxZ/UVk1e/dAI8Cx5jkcAaPiJxLO1C+RHJD1rJH6SV1qcZ8kl2N/qiyL7QCc6zjwY8YQAWXbw/fyu9akMRlve9waQdlkSv/yt8AnTG+Yj12lBEzgg024awx15oRIzZKZl4XcvKBonBYiS72FJELNdpLdQ/OMaDTqHBAb2PGLeSADmW0joRhq6WlMTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7230.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:61a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 11:23:02 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f964:e0e9:199:9246]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f964:e0e9:199:9246%6]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 11:23:02 +0000
Message-ID: <3d2826f3-bf9f-38cf-6873-228cedf116d6@siemens.com>
Date: Mon, 10 Jul 2023 13:23:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: [isar-cip-core][PATCH v2 2/3] initramfs-crypt-hook: Service watchdog
 while setting up the crypto partitions
Content-Language: en-US
To: cip-dev@lists.cip-project.org
References: <cover.1688630668.git.jan.kiszka@siemens.com>
 <3e0c558a5b9b0643012484839a1dbf671c4708fb.1688630668.git.jan.kiszka@siemens.com>
 <b6ce4543-aa13-f5dd-8ad3-651b6a7027ee@siemens.com>
 <175ddbd7-b652-2da6-02a1-f9758136ab32@siemens.com>
 <b9f0ffcf-985e-ef30-ab83-2fd282947e44@siemens.com>
Cc: Gylstorff Quirin <quirin.gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <b9f0ffcf-985e-ef30-ab83-2fd282947e44@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0029.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7230:EE_
X-MS-Office365-Filtering-Correlation-Id: d876d554-dfae-4df5-8efe-08db81380611
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	wkaM5cGbU+AlOwhKz/l8P2r+VFFJSxKW0ks35AnBWiGfRTzMzNXiDogcCtutpTSKB2SQeP4S6ASUjriFs3qhZE7sN/NvvOS0JxOquVU+bG0z97DTYNTkXJgXDEL+mVhD2/JxEjoDceVMDwS8yIpIf5KQt+nQTFSUl0R8X9UcShvVEjo9Fkev9TjXnjhdnGTC88c3JuJFnCwei6Y6tXmdXZJiu2QfWppsdgtU4MDD5YzdrUrR7HVIzrTY27ZAe0ztNPNigJu9yHBLrE4OWRZ1MSDxM8OInCjOwK/e4VcEF6i+AZ3ZuQfIkZ0nIGTK7CHE2uOejw5clBQfEIhihUg1POaIHX9qrtelb12izY3q/99RyOCPIumWkNz1gHXyYrFyDguZRcN9XAjziUmLd5EfHoEGQhhodM0PeukTdq4Opd4doUsjZ0LsTvfFdKDWpj7oilXoyyi140kkSBl/L6ms4Bf0ubNiruS5pXd8iNrnx/Ni9BbYofQFs8GpN+Bu5ACSbHEUI1SIhqq/aqHFTrQFmt1O6pyJ/1tygYp3QsrQ1wyoEzVxVvWqZCzEJWoKi9b5IDpuIJ3X27YIcUkenvMmq0Y29Yrwf9qXKS0oAW3MGaH83jHmfUaGbCThnHjQwUUU3o1GzGyOSMmuRxUnW+BlsQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(346002)(366004)(451199021)(31686004)(4326008)(478600001)(83380400001)(2616005)(31696002)(86362001)(36756003)(2906002)(26005)(6512007)(6506007)(186003)(107886003)(6486002)(38100700002)(82960400001)(66946007)(66556008)(66476007)(316002)(6916009)(8676002)(8936002)(44832011)(41300700001)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VldRMkx6SUVrbHF2RWZOOWpJcDZjR2Y3eTB2dE1zcW94MjBMN2x1M2F4ZW5n?=
 =?utf-8?B?dFZ4U1kyMHBjTGJzcVc4N1RRazc3WjVyR0Y1ZEJsdnMyckNjZncvdUZzTjJQ?=
 =?utf-8?B?RGZiSTF6K0F0cUc5eTM5S0RXRjFYdDBDU3BySzhNem53U3lGMlVENnF2b3A4?=
 =?utf-8?B?MXNrNnliYTByNXJuUjE0d3RBTkVxVEtCaVBIZVRQS2tXUUdIQndiZjgxUG50?=
 =?utf-8?B?VDBIdjFlbUxsZmJ0Z1VqdXNrYzloWk5FMXllT28rUDFCYXNITEFIZUZ2S0Js?=
 =?utf-8?B?WHNOeGZHdlFaWjBENVNPbDhLS2Y1T2RuUGZrNmQ1VTl6c05idEl6YkdLN3pi?=
 =?utf-8?B?VnEraXBCaFdZbkY1QXRjNEZ4WnNaQmVzM2M4QU04M2pIamhNclBiMWlROWNF?=
 =?utf-8?B?c2ZCcTV3eFZwdDk5RWtJc3VoQTg1bjFNWm1aRkowK2xEM2o0aUIzalkwek1N?=
 =?utf-8?B?SG9tdlNXVjlOd3RXeG5mMm5tTzlRcVVVNUR2RHQ4SXdzVjhYODB0VWVMY0l0?=
 =?utf-8?B?QkRTT3pFYVlPNWdqczd5VExFbDg0UzdDTDNTSFh5ZU5xMzg0Z3RtZitYSitr?=
 =?utf-8?B?ckcyVmZ4QlppTGJndDFEN1ZLUFVpSWVhOFl0ZkxIUCtpbFNvWlN3NmplWWpw?=
 =?utf-8?B?N2Z0N3BuUElDa1VwNDU0V0djanVuSkxreG0xampCaUszbzVDRThOa3JZY09v?=
 =?utf-8?B?VmRQVGRMZStvRkRORFRUaDdMRWJ2WUNDamdaR0Nsa2NNdHVmSDRpUURMeWJH?=
 =?utf-8?B?emErTFF0QXdRV0FCN3ZlR0ZFeGhYVmltbU9RcUJVZDdMVHo3N1g3KzMxWSt1?=
 =?utf-8?B?TVhpU21KUEJ2ZjZPeTdiMW1vWThndXNHeHNWdEJ3M2xPcU4yOXhqREpJTkR5?=
 =?utf-8?B?M1VXcXlSbTl3RTQ4Y3JoTTErT2cyMFViTzk3L0txOWQ0K2cwTGlhWHpRQWJn?=
 =?utf-8?B?YkExTzhuTlNlcGovVFUyVjFWVHFIM3pkVTdLNGZYcnhKR0RTNVRrbFBQd2FJ?=
 =?utf-8?B?OGJzSjVBVW1TTitGNHNvbHZjWjJPZHFhM3ZWR2ZienovTVJWRURsbSs2L0dX?=
 =?utf-8?B?TU1IL0llbGVUNFpEYldJZFk1TU05L2dpcHl5MlJxVzROUVpxRi9kTllaSUI3?=
 =?utf-8?B?cG40U2I0MTB6ZFB3cVQyc0puQ01RQm13UXB5TGVsSkZ1NHJNYTNDelNHYkZl?=
 =?utf-8?B?Z1doZ045THVYSkVKRHFIZm9XYm5ZWUxUZGpxQk01N215Y2VKM3hnTmZoZnI4?=
 =?utf-8?B?alRqVlpUMktmaDB5cmtmaDNYd0ZGcFhzSnhkVGpmMEdvNWZmck9US2hyMklE?=
 =?utf-8?B?ZEVHbWtieGNIanZWMldoZll3WmhhVUFEYU54VGNzT3hwZEZZenZadXB5a0xR?=
 =?utf-8?B?UWhsbW9wS3c0cFgvK2NHRjJ1NnFhM0txWnRlV0I4cWsrcStWUjRESUkrRWk0?=
 =?utf-8?B?cmtPa3R4WDgvaXJtWlRxRzYvWS9Hb0IxcE1KSkFKRTN0SmNjdThYZTFTNjRx?=
 =?utf-8?B?WWlxSG4zdHNzV3U4VXh3YnREYWI4YXhDanVhUDJ2RlpMdFdrdG9VRUZ4T2Nx?=
 =?utf-8?B?dys4c1BaaTNzQ1dTUytuYkQrcFd5OEpUVDlna2owbTlmYlRFWEpFSGJwUWRH?=
 =?utf-8?B?QzVCVk12ODd2TTVPbWpYTmRERmJuejV3Z1J1K2NOMDJpc1BpZi8wYWRBQzhu?=
 =?utf-8?B?RXFndHlDZUhWUEl0SnphaUsxZ2l5bFRqYzJmUW1TSVFITkM3TW96dy9WYkZk?=
 =?utf-8?B?WUNleVdHVzVqN2QxalNLelpZWTB0SGZaZERacnRqbzhQdzhvWTRYV3NEY00x?=
 =?utf-8?B?TkhlOGVMTzdmc3p1ZXhsMTI3OHgzVC9INWkxMFVYQ1hmRnk4K2tLTC9FUHhR?=
 =?utf-8?B?Y0VnLzZxdlEyT0RtYkpIMHlJVXNzM1g2UDNJTENhN1NCbm0xYU9IdVlIL29l?=
 =?utf-8?B?NGdNWldJdDdtRXkydDk3aGk4QmxZZHdMaVlNLytTRnA2RGJ0cm5jaHVjYTd1?=
 =?utf-8?B?blJLUEpWSUY3Q2VOdnMrdnhFVzYxSnFkTjdQZmZyeW9OSXhhaGdvMUFlRFJo?=
 =?utf-8?B?SmhNekM4S2g5MW1MK3ZaOHdZTFp2YldvU0laZkFTODZjblVrVUtwRzM4ek41?=
 =?utf-8?B?b3lpSFVmRmtVcWN5MXhFWjREZWNYTUJ4SmlSQ3V2WVlrRlhkaDduSDJZZ0RB?=
 =?utf-8?B?L2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d876d554-dfae-4df5-8efe-08db81380611
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 11:23:02.4374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KpRHl+fJxZNaB2kvo7Jk0UPCU4mEiLlYrVAOHBgDlAFL0mS5v44WLEnx5Zs5R6W2mdI0cdQQjguksoJy7l8Ztw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7230
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jul 2023 11:23:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12293

From: Jan Kiszka <jan.kiszka@siemens.com>

These operations can take longer than the watchdog timeout normally
needed for booting Linux up to systemd. Add a background loop to both
scripts then triggers the watchdog every 10 s, but only up to a
configurable limit. Also the watchdog device can be configured, though
the default /dev/watchdog should be fine in almost all cases.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - renames WATCHDOG_DEVICE to INITRAMFS_WATCHDOG_DEVICE

 .../files/encrypt_partition.clevis.script       | 17 +++++++++++++++++
 .../files/encrypt_partition.env.tmpl            |  2 ++
 .../files/encrypt_partition.systemd.hook        |  2 ++
 .../files/encrypt_partition.systemd.script      | 17 +++++++++++++++++
 .../initramfs-crypt-hook_0.1.bb                 |  7 ++++++-
 5 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
index fd53c587..899f20e6 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
@@ -45,6 +45,13 @@ if [ -z "${create_file_system_cmd}" ]; then
 	create_file_system_cmd="mke2fs -t ext4"
 fi
 
+service_watchdog() {
+	for n in $(seq $(($SETUP_TIMEOUT / 10)) ); do
+		printf '\0'
+		sleep 10
+	done > "$WATCHDOG_DEV"
+}
+
 open_tpm2_partition() {
 	if ! /usr/bin/clevis luks unlock -n "$crypt_mount_name" \
 		 -d "$1"; then
@@ -104,6 +111,12 @@ for partition_set in $partition_sets; do
 		continue
 	fi
 
+	# service watchdog in the background during lengthy re-encryption
+	if [ -z "$watchdog_pid" ]; then
+		service_watchdog &
+		watchdog_pid=$!
+	fi
+
 	# create random password for initial encryption
 	# this will be dropped after reboot
 	tmp_key=/tmp/"$partition_label-lukskey"
@@ -136,3 +149,7 @@ for partition_set in $partition_sets; do
 	# afterwards no new keys can be enrolled
 	cryptsetup -v luksKillSlot -q  "$part_device" 0
 done
+
+if [ -n "$watchdog_pid" ]; then
+	kill "$watchdog_pid"
+fi
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
index d04be56c..52dbd005 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
@@ -1,2 +1,4 @@
 PARTITIONS="${CRYPT_PARTITIONS}"
 CREATE_FILE_SYSTEM_CMD="${CRYPT_CREATE_FILE_SYSTEM_CMD}"
+SETUP_TIMEOUT="${CRYPT_SETUP_TIMEOUT}"
+WATCHDOG_DEV="${INITRAMFS_WATCHDOG_DEVICE}"
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
index fa37b57a..08ea631a 100755
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
@@ -36,6 +36,8 @@ copy_exec /usr/sbin/mke2fs || hook_error "/usr/sbin/mke2fs not found"
 copy_exec /usr/bin/grep || hook_error "/usr/bin/grep not found"
 copy_exec /usr/bin/awk || hook_error "/usr/bin/awk not found"
 copy_exec /usr/bin/expr || hook_error "/usr/bin/expr not found"
+copy_exec /usr/bin/seq || hook_error "/usr/bin/seq not found"
+copy_exec /usr/bin/sleep || hook_error "/usr/bin/sleep not found"
 copy_exec /usr/sbin/e2fsck || hook_error "/usr/sbin/e2fsck not found"
 copy_exec /usr/sbin/resize2fs || hook_error "/usr/sbin/resize2fs not found"
 copy_exec /usr/sbin/cryptsetup || hook_error "/usr/sbin/cryptsetup not found"
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
index a5bd4fbe..330188a5 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
@@ -45,6 +45,13 @@ if [ -z "${create_file_system_cmd}" ]; then
 	create_file_system_cmd="mke2fs -t ext4"
 fi
 
+service_watchdog() {
+	for n in $(seq $(($SETUP_TIMEOUT / 10)) ); do
+		printf '\0'
+		sleep 10
+	done > "$WATCHDOG_DEV"
+}
+
 open_tpm2_partition() {
 	if ! /usr/lib/systemd/systemd-cryptsetup attach "$crypt_mount_name" \
 		 "$1" - tpm2-device="$tpm_device"; then
@@ -111,6 +118,12 @@ for partition_set in $partition_sets; do
 		continue
 	fi
 
+	# service watchdog in the background during lengthy re-encryption
+	if [ -z "$watchdog_pid" ]; then
+		service_watchdog &
+		watchdog_pid=$!
+	fi
+
 	# create random password for initial encryption
 	# this will be dropped after reboot
 	tmp_key=/tmp/"$partition_label-lukskey"
@@ -143,3 +156,7 @@ for partition_set in $partition_sets; do
 	# afterwards no new keys can be enrolled
 	/usr/bin/systemd-cryptenroll "$partition" --wipe-slot=0
 done
+
+if [ -n "$watchdog_pid" ]; then
+	kill "$watchdog_pid"
+fi
diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
index 997f469d..1c1bf3da 100644
--- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
+++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
@@ -33,8 +33,13 @@ CRYPT_PARTITIONS ??= "home:/home:reencrypt var:/var:reencrypt"
 # CRYPT_CREATE_FILE_SYSTEM_CMD contains the shell command to create the filesystem
 # in a newly formatted LUKS Partition
 CRYPT_CREATE_FILE_SYSTEM_CMD ??= "mke2fs -t ext4"
+# Timeout for creating / re-encrypting partitions on first boot
+CRYPT_SETUP_TIMEOUT ??= "600"
+# Watchdog to service during the initial setup of the crypto partitions
+INITRAMFS_WATCHDOG_DEVICE ??= "/dev/watchdog"
 
-TEMPLATE_VARS = "CRYPT_PARTITIONS CRYPT_CREATE_FILE_SYSTEM_CMD"
+TEMPLATE_VARS = "CRYPT_PARTITIONS CRYPT_CREATE_FILE_SYSTEM_CMD \
+    CRYPT_SETUP_TIMEOUT INITRAMFS_WATCHDOG_DEVICE"
 TEMPLATE_FILES = "encrypt_partition.env.tmpl"
 
 do_install[cleandirs] += " \
-- 
2.35.3


