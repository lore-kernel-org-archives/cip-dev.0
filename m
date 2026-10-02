Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72962CA5FDD
	for <webhook@archiver.kernel.org>; Fri,  2 Oct 2026 14:06:31 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13043.1790949990513010531
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Oct 2026 07:06:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=RaDJYlVE;
 spf=pass (domain: siemens.com, ip: 40.107.159.57, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hg3YPy2MHVeaTR6kaykHz9t8467LnweXlAKztnRHeJADIxB+8W0Y+3c5BEq9YBhBsPvL9h/1Rb/ULabB+EU4g80laGJBsAgaEmV2Ldnm5UdWja9r9LzyWH9eLuscR9C96FzhBinaA2zw/TydZbW8DAsCBYHtNHDa3aNHdDduIfAqOCy4Cxhxzu8YzgGbN+485F1rY/DR6WdLRRjC+7ggox2ULzjm+FEJI/HL47W0Jzo7+ZmJ1J8iWxzfY/e95oMASsIgHIwBhKq5UGrXGJJBJFXUIVGECcdG37IH6O+00IRBbfDJm69FazWt2EoGVhDugp7nqU1WJ/1JhJ+ijGTYNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rwiuNeLZI/UrkefSqYLJeWaHECYM3se4szM1zroDaiw=;
 b=awmhQNoj/8HWu5kMtZL/qml38lweAZMCRTOo9bdbTfQJ3s35zsFpdn0DhRDHqDeUUZdn4NxjKHB2RegwEVi+zBlmjSoB81aAkZ3C9Go54LwUPpvHIwOly7mehBGaPwKFsbE5uaxuTKHEoskILtlALrSzA2ddReWw6My8O2KKCDP1mrkhsSyS2zKl+G1h7SOjQyqyuok4Q5vpMjV9h80aerV2agYEmTBE73NmiU841LTJxPthJ73XMLrb6f8OmCf19KDNIqV+9PgTSUJ2QEMM0tcYY3DgP3Hn+ONWICTGTvXnqkhyqssxsAUzlWQOg/v8cQCcvUGWpMpMOxCFued66Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rwiuNeLZI/UrkefSqYLJeWaHECYM3se4szM1zroDaiw=;
 b=RaDJYlVE8WJoXKTJAUNM8sw0ctuPyIvcfbyWaeh5Q+dT1l2aj78bitycYDjd8Fw03VkL35+kvM2xZM81IchXUttH4YKCinrUr0CV+ErSx5xXdSVHWyldi2bVswBnBLrDypml/f+sSUxHFBiOObGFY20NkWAthZ1ityg7iTTHjwxoaJc6kSjEyUpG/9l0D+J8soUr6mwn47hRV95eN9UmvWAEodQ7czyBZw0RRycMLGk+TA923SqRpxienbJ2yBseIAAbzv3uqICC7yFOhMbMknuBDmSA0R5nZj58RGL+yucoc8g4C0lEEiIWBvZqafMCkxeIfDsbKCc1shgso2imug==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by DU2PR10MB7815.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:49f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Fri, 2 Oct
 2026 14:06:24 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 14:06:24 +0000
Message-ID: <fbd1412a-4290-4ec7-9369-b1c4130540b9@siemens.com>
Date: Fri, 2 Oct 2026 16:06:23 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] Update isar revision
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0179.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::9) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|DU2PR10MB7815:EE_
X-MS-Office365-Filtering-Correlation-Id: 04b8a77c-d58d-4855-535b-08df208e57fb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|56012099006|11063799006|18002099003|55112099003|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: 
	jitoxRvbKhQ8zbrx/YbYDEkYnLSWRiLs9dDcbmlKr6cG991ueFiS7Qz90luWIrMDmj5XudsuZdQqtxkao2D9E7xAoecMhCivLSA1Yr1NexY8XXLi/ls5gib1wkxlc0TSlBc5f2jn7AG3zXXI55/VPWA1DX+jo7JqGvkz/zYVFmywCNz16muop1DC0LRXwd4jUObbE0iWtZitZ3enZBJAdYAkGRq8lz0YZAspGn3rIk0EaE9YPTESCYiwUVipQG1T4HwzdZpI3SoPtfPXv10HzxgHo6QO0Wnxf0yhr1HryGM9YpUzIRl5RRQEVqzTZDh6IjJ3bZHDUAsg59PvyeRy1+mGtPI0hCLYbRwDkn/AmYZtcPfOg+RWwn3TdsAhW51u1/9zwKuGSn4DH/sv9x75wMEMokmtLNXpFKC73KiXhmU/SXZeVwZd0fn33pR+T74Ak7B8qLPCpA4/4cY3rVWAayfnrM12Flxgf2PSslu6Q8zfWLtM7E8rZp1DZ7PfsYoFELOV+8arAjJWQGVTk1Ef0KkXv5GTc4hXcTzrs5mFtww0G1DTJGJYpxzwg4LCKUNO137R+Y69m/sOzZYsB5ReBMHJ8gUhnKk4frhoFgYDGnj889XcoUe/S50cqeDDc+UJYK2xNdrlr4FKbvg5h5dAm6UN8StgsjIDGQijXH1tA54=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(56012099006)(11063799006)(18002099003)(55112099003)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Yk4zUk1ycDFsTWw4Z0pRYmMwNUViekVIRHE1VUg5Q3ZsL3BKa3YxZ1E4dXk4?=
 =?utf-8?B?SHhNYU5PRmdhL3dVV2pYMlFnb2FNNW45S2VTV3J5NlZmQUpUbHQ1anc0a1c1?=
 =?utf-8?B?dm9JcmJESWdhZTloUjRPR2c4RkhEb2JrQ2NYU25CYVgwWWhxK2grQkxnZS9P?=
 =?utf-8?B?RDJZWUo5VnRTTmlJdGlHd2FzRU5NS05VMHpEbkVBVmVRc25uck1DVmU0NjFM?=
 =?utf-8?B?YVhwZmNXbDVnVnlUblZ0bmd6U212NU5RNDZ4UmxLNTVlVWxtMng2Y21qeE45?=
 =?utf-8?B?OGowUE9hZC9NQlRTcG5kU3hmSzNnMlFiMUQzRThRYm80ZXh6S3ZFWmZWZEdH?=
 =?utf-8?B?ZmlyRTNkcklxY0xpRGFYOWROUFVwcEJuMW1XcC9qMnRRUlE3eFdndUR6dWxP?=
 =?utf-8?B?V2dYZ3EyQWs0RlJTYXBpalZoUDFNcDBxV2YxbW1SUEM0bWo5T3NQYTlHeWlY?=
 =?utf-8?B?czBTNUNZZUxkZUV3aE9DWCtzL1lvNlhleStjZUY5aUl6ZnBnZlQrQ1RNQjRa?=
 =?utf-8?B?K3JNR0tmQ3crd0xZN3E0UFZtNStmYkM0WE02Z1A3eUFvWVFXQXN6UVJEc1RF?=
 =?utf-8?B?M2NjRkpzYnF3Y3NJRDJ4T3NTaEJMby82YkE3SktwVys1Mll2bER1M0JVcHZm?=
 =?utf-8?B?SER4aXoyMXRFM1gyUVdvbVg0MWdrL3JBNDdFaHhoSUZWdUdLTmlwd1Y1MS9D?=
 =?utf-8?B?R0lrb3pCN3IxL3NOQ1N0d0ZlQzlKeVlLRjFRT24yOENyd0N5L2hqK3ZDVFhw?=
 =?utf-8?B?N20zL0IyS28ycHExNkRHSnZNU3ptZGx3ZEc5NGhnRFZGN08zbytkY0tCNEVp?=
 =?utf-8?B?SE43VzdCbzc3VFgwbSs1Z3JFa3dtUHl2RjlCWkhZQmNITEtKMENwU2VSbDVo?=
 =?utf-8?B?dUZieEUwWmVzWXdvcDgwSEJMUXdYNmpkL05tajNKVm1NcWg2NGZYYTFEa2Iy?=
 =?utf-8?B?ZFFYVG5yWC9PWXNLclU3dGlaeVdwcXlwc1F1Y1VzdCtxTnJycFVoRndEUW00?=
 =?utf-8?B?NWduaDZXNjIxcWxUcTk0Q3BrVHV6bXF6VUo5SmdqQ29wSy9mcllhMlIyMlZT?=
 =?utf-8?B?c3JkdFZzRzhNanMyT3ZBTXpqU2xiSFdjcEcvN3FlWkFaVUpYWU9VQjc2RUM5?=
 =?utf-8?B?VkEvbmFkMCtEZURTcjlWTG9nWFNsNTcyMFJIYmNFWWZRRmdjd2hEVnV5QU45?=
 =?utf-8?B?cXdQRTUrNlRjaWZaajlwVjhMcXJKTlZCaWlqbHJONFAwL0pJc3hOQ1hKMTQ5?=
 =?utf-8?B?TENzbWlMUDJBZm9sL2J0eFd4a21DaXhVNlpzck8xaTVlRVpqT1A3bWdNQU8r?=
 =?utf-8?B?bVRhN2hGYXg0UlFoNHdzZ0t6bU5mcTEwRGxJYkdLU2RNZU02dDhQWC9iaWlL?=
 =?utf-8?B?QlFlRFV5TjA3dW9UdzZxZGNVWnl4eVZnYkV2Sm56QjFvbXE1bnVTNDVEYUhn?=
 =?utf-8?B?dnVHZ0xnL09RNXArSTl2VVJZdVVCcU5Kbm1KQnVxL0RnL0ZhRFF1K0RQWkds?=
 =?utf-8?B?WTErc3l2THgxazllZS9hYmhkNExiVnVlM0txOUp5MWRPWWl5d2dxdmNvUjVZ?=
 =?utf-8?B?KzBuSTJGVVVYK3lEVWFuaFU1V29WcjN0TTkvaWdTWVZVNjNvSnhMTmpmdWNX?=
 =?utf-8?B?WFQxREJMUFh5eCszaFhaRmYvZVUxSmI0ZEVUcTNWcjZpZk4yeXY0RWxKMDRt?=
 =?utf-8?B?OHFXOTR5ZGE4THZzdUlNWFNZZGpTL2ZDM0d4bGxrSk5EODcvSU5YL055VXJK?=
 =?utf-8?B?bDAyejFVdS9uSmp5MjJZbkt3OVlLZUpXQmMyeEdrL0tzcTFRSDdnVm1EaC9y?=
 =?utf-8?B?OTZYUXU2QnErcHZJcXovODJnN285eHpaK3J2ckVhUUpaNlJGRWhUVkhONFNt?=
 =?utf-8?B?L2g3SStRSEVCWThiK1BZUXFEMWVJZWEySjY4anpMTVd3b215U0Y1YVkxRVN4?=
 =?utf-8?B?UTNrd0Y0b2hHM2NNRS82aXAvSjFVVWpoQnhtaDJoTjc2Z3RkRW9Dd3hwY2JH?=
 =?utf-8?B?RWFEZFdWWEJaRlBueUZ5TWVmSWhEdnROcGNtR3FoOGxHbEQ3SmduSE81NVlh?=
 =?utf-8?B?SVFRS0ROaFA4SElGRVA3Q09ObGJGZXhkK3lkRmdYYy8ydHZRR3dqclF1dHFO?=
 =?utf-8?B?RVYzWGhUUXBQVlBPRzdDVWlHQmtoazVPODhualBRdWxKdnJBeVVTdzFmZzVv?=
 =?utf-8?B?RzBPNHV3OE5kMk1Henk3M2lJeFJmOVJ5OEJOUHhEbXgyYzJpekFMNEpSeXRo?=
 =?utf-8?B?eUQ3NlFQSzl2anpLOUdGZE9FaUZZNnQxbjI0aFdiTWZQREtZdVdzaHZBcnpl?=
 =?utf-8?B?NDM3SEhYVTZ4MW1LdjNpUEQrREQrRzlVQ1RtTWlwd2cydEk5blpNdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04b8a77c-d58d-4855-535b-08df208e57fb
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 14:06:24.4073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xHVJ+B6+rPgMQdQWNqKHp1ZXHbJQeXIqKiYgNR4ire3mXNupSAbHWOKKiqt14I/E1E4Y3nh61iQkMW10byp+YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7815
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Oct 2026 14:06:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24421

From: Jan Kiszka <jan.kiszka@siemens.com>

Allows to drop the meanwhile merged patches.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...t-run-as-tmpfs-for-systemd-execution.patch | 44 -------------------
 ...xtension-fix-machine-id-file-being-w.patch | 35 ---------------
 kas-cip.yml                                   |  9 +---
 3 files changed, 1 insertion(+), 87 deletions(-)
 delete mode 100644 isar-patches/0001-isar-mounts-mount-run-as-tmpfs-for-systemd-execution.patch
 delete mode 100644 isar-patches/0002-image-postproc-extension-fix-machine-id-file-being-w.patch

diff --git a/isar-patches/0001-isar-mounts-mount-run-as-tmpfs-for-systemd-execution.patch b/isar-patches/0001-isar-mounts-mount-run-as-tmpfs-for-systemd-execution.patch
deleted file mode 100644
index 8102bf7f..00000000
--- a/isar-patches/0001-isar-mounts-mount-run-as-tmpfs-for-systemd-execution.patch
+++ /dev/null
@@ -1,44 +0,0 @@
-From ec00b9572eb464e45c0c47f653e1c5a7d9316273 Mon Sep 17 00:00:00 2001
-From: Felix Moessbauer <felix.moessbauer@siemens.com>
-Date: Wed, 23 Sep 2026 16:33:50 +0200
-Subject: [PATCH 1/2] isar-mounts: mount /run as tmpfs for systemd execution in
- chroot
-
-When running systemd inside the chroot, it might access /run and place
-files there. These can have ownerships (like 0000) which require DAC
-capabilities for traversing and removing. As this is tricky to achieve
-across all cleanup code, we stick to the systemd file system hierarchy
-and mount /run as a tmpfs. By that, all files below it will
-automatically be dropped when leaving the namespace.
-
-This solves cleanup issues on rootless like:
-  find: '<...>/rootfs/run/systemd/dissect-root': Permission denied
-
-As we anyways cleanup the /run in do_rootfs_finalize (image only), this
-does not change the content of the image. However, it improves the
-reproduciblity of our internal rootfs' which can improve caching.
-
-Reported-by: Jan Kiszka <jan.kiszka@siemens.com>
-Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
----
- meta/classes-global/base.bbclass | 4 ++++
- 1 file changed, 4 insertions(+)
-
-diff --git a/meta/classes-global/base.bbclass b/meta/classes-global/base.bbclass
-index 8f81ab70..3d5d1c12 100644
---- a/meta/classes-global/base.bbclass
-+++ b/meta/classes-global/base.bbclass
-@@ -399,6 +399,10 @@ def insert_isar_mounts(d, rootfs, mounts):
-         lines.append('mount -t devpts -o noexec,nosuid,uid=5,mode=620,ptmxmode=666 none {}/dev/pts'.format(rootfs))
-         lines.append('( cd {}/dev; ln -sf pts/ptmx . )'.format(rootfs))
-         lines.append('mount -t tmpfs none {}/dev/shm'.format(rootfs))
-+        # required by systemd file-system hierarchy
-+        lines.append('mount -t tmpfs -o mode=0755 tmpfs {}/run'.format(rootfs))
-+        # required by Debian policy 9.1.4
-+        lines.append('mkdir {}/run/lock'.format(rootfs))
-         lines.append('mount -o bind /dev/random {}/dev/random'.format(rootfs))
-         lines.append('mount -o bind /dev/urandom {}/dev/urandom'.format(rootfs))
-         lines.append('mount -t proc none {}/proc'.format(rootfs))
--- 
-2.47.3
-
diff --git a/isar-patches/0002-image-postproc-extension-fix-machine-id-file-being-w.patch b/isar-patches/0002-image-postproc-extension-fix-machine-id-file-being-w.patch
deleted file mode 100644
index 435ce7c7..00000000
--- a/isar-patches/0002-image-postproc-extension-fix-machine-id-file-being-w.patch
+++ /dev/null
@@ -1,35 +0,0 @@
-From ac63ef6d3ebbfe6d0ba23caea659c7d4f609a0f6 Mon Sep 17 00:00:00 2001
-From: Badrikesh Prusty <badrikesh.prusty@siemens.com>
-Date: Wed, 23 Sep 2026 20:13:06 +0200
-Subject: [PATCH 2/2] image-postproc-extension: fix machine-id file being
- written empty
-
-The pipe operation was lost when passing data to run_in_chroot because
-run_privileged_heredoc consumes stdin for the heredoc script, resulting
-in an empty /etc/machine-id file.
-Move the pipe operation inside the chroot environment to fix it. This
-ensures /etc/machine-id is properly written with either "uninitialized"
-(systemd >= 247) or empty string (systemd < 247).
-
-Fixes: 14acf490 ("introduce wrappers for privileged execution")
-Signed-off-by: Badrikesh Prusty <badrikesh.prusty@siemens.com>
----
- meta/classes-recipe/image-postproc-extension.bbclass | 2 +-
- 1 file changed, 1 insertion(+), 1 deletion(-)
-
-diff --git a/meta/classes-recipe/image-postproc-extension.bbclass b/meta/classes-recipe/image-postproc-extension.bbclass
-index 59128c2a..9e37a65b 100644
---- a/meta/classes-recipe/image-postproc-extension.bbclass
-+++ b/meta/classes-recipe/image-postproc-extension.bbclass
-@@ -63,7 +63,7 @@ image_postprocess_machine_id() {
-     if dpkg --compare-versions "$SYSTEMD_VERSION" "lt" "247"; then
-         MACHINE_ID=""
-     fi
--    echo "$MACHINE_ID" | run_in_chroot ${IMAGE_ROOTFS} tee /etc/machine-id
-+    run_in_chroot ${IMAGE_ROOTFS} sh -c "echo $MACHINE_ID | tee /etc/machine-id"
-     run_privileged rm -f '${IMAGE_ROOTFS}/var/lib/dbus/machine-id'
- }
- 
--- 
-2.47.3
-
diff --git a/kas-cip.yml b/kas-cip.yml
index 818944d8..d618a6ed 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -22,16 +22,9 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    commit: 1d8791f5ea178bc31ba2ff3c211ef5030f542c13
+    commit: bbb81cd0eec51f224123efedcd7cd7c9f610a7e7
     layers:
       meta:
-    patches:
-      p1:
-        repo: cip-core
-        path: isar-patches/0001-isar-mounts-mount-run-as-tmpfs-for-systemd-execution.patch
-      p2:
-        repo: cip-core
-        path: isar-patches/0002-image-postproc-extension-fix-machine-id-file-being-w.patch
 
 bblayers_conf_header:
   standard: |
-- 
2.47.3

