Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E256C9830D
	for <webhook@archiver.kernel.org>; Fri, 25 Sep 2026 13:06:48 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7743.1790341602152708641
 for <cip-dev@lists.cip-project.org>;
 Fri, 25 Sep 2026 06:06:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ALaXuD0n;
 spf=pass (domain: siemens.com, ip: 52.101.65.49, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VmIf0lBp+wOmnM3ZrK0VAo0NwmqgkLKAO85PLo6tIboiV3TDeS95VuwybT+ZdV6tpPz7XSlqkqmEiEyq2zgd+FzsKYqoPY2jINtjZWVVdZZvqaT2TDZoYnEY34B1y3hwzAslReDyVj7U9V5fReJJXTCbGKUMfigBzOfyK65zyYC18nVn/efkQVT9aBpC9Jl4peYMsykN4mFLbx51firXaEoitDCVTSM+U+vGgFebuPjJQbrfJeJK45EoHCY2TBcG8jmFW218QNC91uWU2xzIe28bXbRLB7OBAqD823hbnjwKyjTyvRsFKGdlrH5yl7WctRc4QsUW52sJXu2NdiereQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GcKSH9RnoNxH0la2u0+k+1qhrmUHaDTVh4ERFRUtKgo=;
 b=Ljk7n2b5LixDx8b4tjtpgSlQIB8LbgsprcHNU52qByogUfu9QekaOJlR2ZAgKxjB52Bspnii+eryqz2SpzVzDLB5S3uQQaljqRdi/saFX7WAspX9P3MtxmNXUVEj3NR7xz3o81vfwPtI7BjcHi9CYrfAQKyykwD0HPDGUL8X05SP55QKBomwMyEczoOrd9jMrLQsGXxKw9/g9AUQDEXljUhmQR663Bxs59KjaohYpKAuasuwF7Y2dMSc6PUZIBXyeVECNUPe50Ws+2AEklXKZYr0QjPqMifDDdpi8ibIJ8xjlfqOpSSgUh+dPqKV9iZZyfK2CcWBZ51s01AybhId1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GcKSH9RnoNxH0la2u0+k+1qhrmUHaDTVh4ERFRUtKgo=;
 b=ALaXuD0nlW9/Hh4UsU9+NwwCAUeMKR2ZsipchlOOIIAfEbWI+k9NRXdiTW0mYQug0lh/iX+9Xergg8guKOSVk7Y6l3X9Z4NB1Cfj96OJwXc402iJeoPkL5lpgS1gpKSfuXWFkniYV4ukO6Ro0lm6JxBdDPdU2U5aBvp1L6eDtmhdfOs8Pz+sJsHy9JoI8bk96+Y2VhKNjrbQzENxIT9VK74AvUxeOO/NbBbOLAP51zVjcd2BYFVJkvnk4sb8KI3wX5paQu1gQBoC9AkozVJUQySOF12ouoj9D1VQkV7kUTxUptOWINbS5h33Uh54NHubzFbvEKXRP7+l5T659kxqcA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB6005.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 13:06:33 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 13:06:32 +0000
Message-ID: <406ab70e-7459-441c-b8c5-69c62574e05e@siemens.com>
Date: Fri, 25 Sep 2026 15:06:27 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] Update isar revision
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P223CA0029.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::34) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB6005:EE_
X-MS-Office365-Filtering-Correlation-Id: c4a97528-3f04-4480-ce2d-08df1b05d1f0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|6133799003|55112099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 
	UjYIJuo9tqC/eJkou8/U/r5djY3Vo2zTsC3f2aQGFH1B95yc6U6KZ1+DUOPvtiJe7iqtXm8VwEsWiF++qFihGFujsh1tqtYmmZouksbV/HXw+Hv4Jc9Suzh985GbRmJLV61rIuC7fQ31BcbxbsNZ1doCJi6sFW5j4heGyBxjLxbU4fnNGrQm5jrEZFO1ZTs8EKYocqDCmUt8wuyXvm/p5q4c6t4KZF8yz0AkkLfOrgPPjJ8Ozg2PrwfhCTLMLs9DppNW7DzpHMPqa6g6XASDP6JcX4nktJr4+fKEO+MLWFPQvOmjkgg/5biifmC5AW4jQCj2NUdJKxm/dsh2ggS6gRCwTDDT3O8gh8tVs05KLKA4qdmFfm5QGFyzy+2cD3psUEA/2/0d2wlelhPpN7uNsgbdawU2nQPreOcN6D5M1DOGdoIf0eCCpM8oQdG26L/QAmaTVtZL/zYYUhNBaG9CXHhfTnJJZZMVADSSbTa7aWRME59hR4kS8D+H1/OPKzmwHmY/MLj74amrMBSUZgCSvQjEo3iRreY00mypWI2PXG3+fa7l3PHFfGROOsqeQ755aL0mFiMW/qBDA/CfKYFbUkOzxVUwg/zodkUICuRqQK4p6ptLkJgGymqD0kMenCWwmSMW8asCoNFz/XzLpVPiEyq8ihBlaFXZS8tRA7+LOaU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(55112099003)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Wjg3dUwvM0hBUUxscjZRTzZNQVBQQkJ6bUl1UHptWGtackpQQXFWNmN5dEsv?=
 =?utf-8?B?cUNCT3JtTzZCVit3c2U3VFlOdUFJNUdBTmZuNlB4S3VqWlpOdWI2ZXBQM3Rj?=
 =?utf-8?B?Y2VGOHVLUkVBMVg2QVNnYllFY0daSGdTYk5GQXJsRUwxQ3Y5MTcvQU5EYTVT?=
 =?utf-8?B?bU81ZHNrNm4xcjB0L0V4SzRCNXh5cURjUWduUGZRcFlYOGpScDR3WWpISWw4?=
 =?utf-8?B?dWdIeE85SnVvRXhmSTNjRi9VVHd0Z0tMS1ZPVXFBVkFaWGY4RkhZSXBUWTFK?=
 =?utf-8?B?NWp0L0I1akl3QUcxY1R6L2hNU2pCc2dLS2ZyWlZnZlpNWHo0eEt4R3hYRHJE?=
 =?utf-8?B?VWFFWS9jelYwVzliTWYxVkVZeUxxVXBEQ3phbEtyMVJUMFRBRXR6RXpLUndH?=
 =?utf-8?B?N0F4K0QwNU5EL3FZb0QwcEthd0NGMURKcjk5ZFpjOFQ5elJPV3FwamlxQkNs?=
 =?utf-8?B?MEFJdUZ5N1NOTXgwSi95NDdmV2hQalF2SCtYcjZpVzdPSjV6NDZ1UDNQakJP?=
 =?utf-8?B?ajVZb3ZqOVA1UTZMUjRhb0pWOVR2bGhzZndDeHNra01KTWJxMjI4bkVCMnlw?=
 =?utf-8?B?UHYvRTJ3SWNtRkZuTURCUkpya2FqOUhjOGxsZVNuYk8vS3JTOUxza0lYZ05h?=
 =?utf-8?B?bks4ZzVZZUNuc1IrLzVaVkVLTEtaVUt0T1dqWk1PTEpFdFVpTUowenRXTWZ4?=
 =?utf-8?B?eUtpRjUzY1l1dFVUd1daZ3lmb0JzUm9iSC9KRTRQT2tOK0w5L0tXaDlCbkN4?=
 =?utf-8?B?TGttSmVoeW56OXBqTnNEMTUxU05zVlk3UTVMeHZ5RzRnN1Bsdm85R2RmaUY4?=
 =?utf-8?B?ZjhzVnBEZHRLdktwZ3crMENxbzUxS2NqZmdnM0trMFY5OGltVHAzTmN1SFlj?=
 =?utf-8?B?K1Mzb3JEamxkNS9KekhFY0FPaVo1ZWlSY2M1OFNzS2pLeUxmMkxiSjRRcC8x?=
 =?utf-8?B?MTIyNE54RGxsS01qemFMUW0wQkNtSlZxK1lnZ0hJMlRBeGJQNmZYeHdlcnYy?=
 =?utf-8?B?aVpCVkFhWGZVUnFGNnpPMEdlL0svWk51VnZ4bVJBcHNyZlh4RmtEL01UUEJM?=
 =?utf-8?B?clExSS9aS0ZiUUZSdENENHFDeStmNzcyWm04dXhDUmJ0Y0FlbHorb1dTcDVn?=
 =?utf-8?B?K0tiTGtjNTNoUjVDTERNRG1PelQ1VjRTM0N5M2FWWE1jYnlyOEk4ZFBEbE1q?=
 =?utf-8?B?dFI3ZER2Rkw0YkhCcmVpcHNRMmNsZ0ppM1RSZXpqdjJMUTFXenFoZUcyV3h2?=
 =?utf-8?B?b2RibldGY1IvWXI0dGM0dStkcWRiSFpNS0x3MU5ldDhYZmtINXdUM0NuWFdi?=
 =?utf-8?B?eWZEVVpWRUFuRFBqSmRSRCtOMnRUZnVqUjdWRFp4L2M5Q0ZpQUZHU1lGUElt?=
 =?utf-8?B?ZjZLaGFDMjFlZTVSck45dWN6dUUxaHoxZ1YxUWc0K09KWjZiTnBJQ3NVbHBL?=
 =?utf-8?B?VEhwRnppeFlkdGRkSklGRCtQdTY4WTh3TGVmQTcrQUM1bGplVXFJL0VmTUhm?=
 =?utf-8?B?aGk0cHNaejBZRGQzanl6Ry9PN0IxTVhQNnQ4WWFzVjF1UFltVDlsK1NPUEdw?=
 =?utf-8?B?UlBMOG5hMm1GZUpSTlUya21IY1VuNVNpSjlMam1ZdDBuOFNUTXVFekNNOUJS?=
 =?utf-8?B?QnpIcE1sdHhPeFA1SG5mMmxRb2w2VktxeG4yTlQ0SUM2RDlra3VwK0MrYTI3?=
 =?utf-8?B?elJDNlVha0xTbVdTbVdsOUNRaWcwRjFpb3Jua3MvdnhyejQ4NGdoOEZiOFlL?=
 =?utf-8?B?dTl2OU0vUG5BaGVjbDNtczJkbVFhOW5FUmxqWjZrZkh5cStEb1UwVEFHMzlH?=
 =?utf-8?B?N3U2ckZsQnk0Z1pPcXUzcE80cmJmVzBiaTVYU2lvVllvYlFCdUplN0U3RXVZ?=
 =?utf-8?B?K3hSTi9XazFVdkhGSnltVVMrVnJ0R01oTTdRTG1yOHJkdFZMdkdCY3k0bEFn?=
 =?utf-8?B?ZGtPZkN5d09zU1ZkV3lzMm5nc2hqbndHNWZXREc2Njg1MkgrZGFBSEtQdTdw?=
 =?utf-8?B?REQvd2R6eEFONkJFZlNTWTl0WmliVzJPL2pRZk5pSWw4VFFOTGs3UnB0cmMr?=
 =?utf-8?B?ZUx2N2Q5OTMyYTVzNDh3cmpJeE5GTHl2cDY4Qmdhb1YyUjJlVGQvQ2hWeHQy?=
 =?utf-8?B?NEpoMzVvak1vSGxqdTZVOEMreGNFL3R6RWpidnIyQWFkTzVqNWdjVWN1YW9D?=
 =?utf-8?B?YXE1QXVUTExIUUY0SURRL3A3MmRsMFZ0ZFhLd0JzVnVwbWNvQllRNkQyK2pw?=
 =?utf-8?B?WERvQ0FaMStMRUozdjR0dWhZR0w0MVZKSW1Td2o3K1NyY1V1WTgrbnZMamlI?=
 =?utf-8?B?MDlBa044cjBMYktqTEtpVjNCVlBuVWlHdzVIUjgzbjdHVFd4L1FvUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a97528-3f04-4480-ce2d-08df1b05d1f0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 13:06:32.2967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uyHO+Ad0wNpJYJ24dPf2XHwueXk5uRZmSTHLksdPo1MctEj9q5hMsww69niLPTGKL241IYwrdpF82tVifCzIXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB6005
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 25 Sep 2026 13:06:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24349

From: Jan Kiszka <jan.kiszka@siemens.com>

This brings a number of rootless fixes plus 2 patches currently waiting
to be merged. The first one of it resolves some forky build issues.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...t-run-as-tmpfs-for-systemd-execution.patch | 44 +++++++++++++++++++
 ...xtension-fix-machine-id-file-being-w.patch | 35 +++++++++++++++
 kas-cip.yml                                   |  9 +++-
 3 files changed, 87 insertions(+), 1 deletion(-)
 create mode 100644 isar-patches/0001-isar-mounts-mount-run-as-tmpfs-for-systemd-execution.patch
 create mode 100644 isar-patches/0002-image-postproc-extension-fix-machine-id-file-being-w.patch

diff --git a/isar-patches/0001-isar-mounts-mount-run-as-tmpfs-for-systemd-execution.patch b/isar-patches/0001-isar-mounts-mount-run-as-tmpfs-for-systemd-execution.patch
new file mode 100644
index 00000000..8102bf7f
--- /dev/null
+++ b/isar-patches/0001-isar-mounts-mount-run-as-tmpfs-for-systemd-execution.patch
@@ -0,0 +1,44 @@
+From ec00b9572eb464e45c0c47f653e1c5a7d9316273 Mon Sep 17 00:00:00 2001
+From: Felix Moessbauer <felix.moessbauer@siemens.com>
+Date: Wed, 23 Sep 2026 16:33:50 +0200
+Subject: [PATCH 1/2] isar-mounts: mount /run as tmpfs for systemd execution in
+ chroot
+
+When running systemd inside the chroot, it might access /run and place
+files there. These can have ownerships (like 0000) which require DAC
+capabilities for traversing and removing. As this is tricky to achieve
+across all cleanup code, we stick to the systemd file system hierarchy
+and mount /run as a tmpfs. By that, all files below it will
+automatically be dropped when leaving the namespace.
+
+This solves cleanup issues on rootless like:
+  find: '<...>/rootfs/run/systemd/dissect-root': Permission denied
+
+As we anyways cleanup the /run in do_rootfs_finalize (image only), this
+does not change the content of the image. However, it improves the
+reproduciblity of our internal rootfs' which can improve caching.
+
+Reported-by: Jan Kiszka <jan.kiszka@siemens.com>
+Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
+---
+ meta/classes-global/base.bbclass | 4 ++++
+ 1 file changed, 4 insertions(+)
+
+diff --git a/meta/classes-global/base.bbclass b/meta/classes-global/base.bbclass
+index 8f81ab70..3d5d1c12 100644
+--- a/meta/classes-global/base.bbclass
++++ b/meta/classes-global/base.bbclass
+@@ -399,6 +399,10 @@ def insert_isar_mounts(d, rootfs, mounts):
+         lines.append('mount -t devpts -o noexec,nosuid,uid=5,mode=620,ptmxmode=666 none {}/dev/pts'.format(rootfs))
+         lines.append('( cd {}/dev; ln -sf pts/ptmx . )'.format(rootfs))
+         lines.append('mount -t tmpfs none {}/dev/shm'.format(rootfs))
++        # required by systemd file-system hierarchy
++        lines.append('mount -t tmpfs -o mode=0755 tmpfs {}/run'.format(rootfs))
++        # required by Debian policy 9.1.4
++        lines.append('mkdir {}/run/lock'.format(rootfs))
+         lines.append('mount -o bind /dev/random {}/dev/random'.format(rootfs))
+         lines.append('mount -o bind /dev/urandom {}/dev/urandom'.format(rootfs))
+         lines.append('mount -t proc none {}/proc'.format(rootfs))
+-- 
+2.47.3
+
diff --git a/isar-patches/0002-image-postproc-extension-fix-machine-id-file-being-w.patch b/isar-patches/0002-image-postproc-extension-fix-machine-id-file-being-w.patch
new file mode 100644
index 00000000..435ce7c7
--- /dev/null
+++ b/isar-patches/0002-image-postproc-extension-fix-machine-id-file-being-w.patch
@@ -0,0 +1,35 @@
+From ac63ef6d3ebbfe6d0ba23caea659c7d4f609a0f6 Mon Sep 17 00:00:00 2001
+From: Badrikesh Prusty <badrikesh.prusty@siemens.com>
+Date: Wed, 23 Sep 2026 20:13:06 +0200
+Subject: [PATCH 2/2] image-postproc-extension: fix machine-id file being
+ written empty
+
+The pipe operation was lost when passing data to run_in_chroot because
+run_privileged_heredoc consumes stdin for the heredoc script, resulting
+in an empty /etc/machine-id file.
+Move the pipe operation inside the chroot environment to fix it. This
+ensures /etc/machine-id is properly written with either "uninitialized"
+(systemd >= 247) or empty string (systemd < 247).
+
+Fixes: 14acf490 ("introduce wrappers for privileged execution")
+Signed-off-by: Badrikesh Prusty <badrikesh.prusty@siemens.com>
+---
+ meta/classes-recipe/image-postproc-extension.bbclass | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+
+diff --git a/meta/classes-recipe/image-postproc-extension.bbclass b/meta/classes-recipe/image-postproc-extension.bbclass
+index 59128c2a..9e37a65b 100644
+--- a/meta/classes-recipe/image-postproc-extension.bbclass
++++ b/meta/classes-recipe/image-postproc-extension.bbclass
+@@ -63,7 +63,7 @@ image_postprocess_machine_id() {
+     if dpkg --compare-versions "$SYSTEMD_VERSION" "lt" "247"; then
+         MACHINE_ID=""
+     fi
+-    echo "$MACHINE_ID" | run_in_chroot ${IMAGE_ROOTFS} tee /etc/machine-id
++    run_in_chroot ${IMAGE_ROOTFS} sh -c "echo $MACHINE_ID | tee /etc/machine-id"
+     run_privileged rm -f '${IMAGE_ROOTFS}/var/lib/dbus/machine-id'
+ }
+ 
+-- 
+2.47.3
+
diff --git a/kas-cip.yml b/kas-cip.yml
index 53d61bb9..818944d8 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -22,9 +22,16 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    commit: 589bee972846c1f88797465262d1efbbb254d4d0
+    commit: 1d8791f5ea178bc31ba2ff3c211ef5030f542c13
     layers:
       meta:
+    patches:
+      p1:
+        repo: cip-core
+        path: isar-patches/0001-isar-mounts-mount-run-as-tmpfs-for-systemd-execution.patch
+      p2:
+        repo: cip-core
+        path: isar-patches/0002-image-postproc-extension-fix-machine-id-file-being-w.patch
 
 bblayers_conf_header:
   standard: |
-- 
2.47.3

