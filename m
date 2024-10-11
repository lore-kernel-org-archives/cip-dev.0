Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240F7D2447B
	for <webhook@archiver.kernel.org>; Fri, 11 Oct 2024 05:43:08 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.65])
 by mx.groups.io with SMTP id smtpd.web10.5097.1728625384462263787
 for <cip-dev@lists.cip-project.org>;
 Thu, 10 Oct 2024 22:43:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=rN9zULqc;
 spf=pass (domain: siemens.com, ip: 40.107.247.65, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dDJumFaDAL28DP9WY5IsbifYo0xaGTwQpp2BdbQfyQZTSNCB1TCYYqudeXFA8RW00gjNxyeg3QDMjRRP6nszaNs2rvwyG4UYYJFfqMxMWrETw7vzsKuilKU2QNZdOtVhM91xsK7SC9axfld6IuTVhYc4fOHY/NvC6K0V9sk0wzU0Hm9LmMS307XHuK3JqPKvjDReUg6Ogm9f1yJb0VMEp1sML0T0hwh/HpRh9ALohNtU2LqUo/Of/ZupHo3tOPqt5r9Bx646qJAT1e9Fm94HcuvRv7XfPVIHZI9edzf99crAic+qXgY/zYAD5TOdyfVqEfg8IqORhw34HLBgOIjD0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIF0H852e/o/xkB7HF3qo+4zkmcLMAl1nWS4vproejM=;
 b=nez4bvi/dj2nlfEELqF7J0Xadd+f2+UmUeNCBGH8hMeG+Y4Bmr/CITWGMPZMJPQcXgfoCXieQrkBdzqV7C/j8INN6MCtwUf0dnQf6zLe1ma8KS9VVuSVdzU8dNBDAGtvSaP4ogOlFMHbF20cCYDNQkJy2jk/+M3h0TJ1zsZ1Lzzurd7Pcehr4RzPHZrFzNpYYdcUqymnHDJpUXXLF8AQRLET4kcuJazcu7IkKgfyf5ieu72mmclN9ZN2fAxUW5oO48RMyp2n22PUolR8uKURvV1+XJgOIIr/Dc662V//L1UTHHHTreDxu+dvzRYAw6D9AD4sm2RcT5mPSsd4OXLJKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIF0H852e/o/xkB7HF3qo+4zkmcLMAl1nWS4vproejM=;
 b=rN9zULqc7SnB0RCHu++PEa47PUr5U8r/hye0v9MbjT1OLkx1i0P13N5ijgHLpVvNIHh5Thgp/u1PoiolDFKoNnROGWxn6Kt8+Gb9y5Td44XWqGubyx/buvn7ifFPBdM4GKSirWZeJ5hHXm2ZTFXV9xtGK80uT+0+WcrvDPdAzswiYT5ZKyP2EAEjVVJZhk0EcOnW5IL21qYIgUD1gegQIrKWS3FEjX2Or1cO/5b6geZ4O3Grkk/ewH8o9j80iPxclzije9XsqsopGKn9/BXiMIOTnmBb52AxCMoyN33rjZ+GXxT7g/WwYoaPayNvRrSdyGZ0FiFveZiHbjcorizICw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7697.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:35f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.13; Fri, 11 Oct
 2024 05:43:01 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8048.013; Fri, 11 Oct 2024
 05:43:01 +0000
Message-ID: <5a26159a-c773-4d71-be08-f41d026f1893@siemens.com>
Date: Fri, 11 Oct 2024 07:43:00 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH v2] Update isar to latest revision
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0213.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7697:EE_
X-MS-Office365-Filtering-Correlation-Id: 566d16eb-0c60-418e-60e7-08dce9b791aa
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?MTVXakVSQ1NVRTh2bjY1OHlVS2h5UWZpOERwdC9HbWRocGhGNjZKTURPOXVF?=
 =?utf-8?B?YVlZOTBiZ1RQNVl2Z3J1TVpuYTFFTjVUZjJFRUVCUXNzZVhZdXdRVGR0ejRm?=
 =?utf-8?B?bDVRRXhHandGdlNpaXNLN25uZ0Z6MmVDL0lwcVNVa0RXRkg4UDZUTzF6UGhx?=
 =?utf-8?B?eFlSQ2UxdTg3U1p0TEFybFU0allsYnBQSzZab0pwYmF3VVgyV1hWL1N6TFR2?=
 =?utf-8?B?UWZNMm9kaXdyaEFGeUJpWVhqVFFocE9lVTV5dzlJeFozdDE1WDlpdWxNcU1T?=
 =?utf-8?B?YmFFdFUyaTNJekNlV0MzbWZsOFR1dGtjS2QzNUVUeVYxeDNDaEVpU0xXemZj?=
 =?utf-8?B?VkJhU3ROQnhKN0dCZ3o5eVNKSkRGNWVDdnNFKytYb0JqUDhoelYvdnAxdUdD?=
 =?utf-8?B?RmpyK29ZQWZkMks0eHV5ZWlId3haK1lPVHhPRlhvNGRpd0Z5ZmJUcHgreGQv?=
 =?utf-8?B?akhlT1FtNzlWZm9BRjkzajZkSXRaaElGZHlrN1NockFRMEhUeit1clM3b2Za?=
 =?utf-8?B?Z00wejBvbHQvZDJSd0ZrcTE5K1k1UEZiUWRMV0tBZWsrUzJYL0pHZkJNUDcw?=
 =?utf-8?B?V3hnN3J6UnZPQnhWOXhIT1JMdStDZHN5SGxqUUhvMHZQRmwzNjd4SUpXVGZJ?=
 =?utf-8?B?Z2YzTUxpT2RBNloydnZIQURCV0p3UjNIeGJwbmppMkVOTE80RXprTTlORjg2?=
 =?utf-8?B?cVhvV0pSRHlhRmkyL2ppeS9uT29iU1dEY3hzdGRXanA2T0hGSTAxaUZmc2w3?=
 =?utf-8?B?bkdnTnlQeHdnaGtWcnk5WCtac3l4alI2TFNvZlNHR1hkUHhjV3FKeGNtOUdx?=
 =?utf-8?B?Vm9IQTUvdEUxc2lRZUR5bWpUTW5iMjJiYzJ0b1B6ODRJdlVmOVJGS2R0eTFr?=
 =?utf-8?B?d1lBeVVtS014Q09jOFo3WkhIb3FoNXhxUU4yelplenpqcU9kTUVXZjBLbnVw?=
 =?utf-8?B?L1VqMURYekZ0SEJ0SjdPQmd1dXpsWHdTZnJBSWduR2dXTE9UaDlibFZ1bXlD?=
 =?utf-8?B?cm11allEN1NKclVJZ2loakc2bGhpNVVGUTJqd3RTTUZ2V2ZSMVlPaE5ZK0Nk?=
 =?utf-8?B?N09MOThTS0IyVlc2ZFFLYzROZjRuSyt0SDZEWE13WDRDM1p4M0lMREVjamd5?=
 =?utf-8?B?cEhrZ3hhT3pOZ3NFUUJ4UmdoZ1pIUFRLWmNrdGJwcm03WnRKMmJtc2dDclBp?=
 =?utf-8?B?K3hvVWttYzJOSkg2UmdaOERweGZEK1FEWEVIRXhKY1BraHl4SXpIRHdCbzF3?=
 =?utf-8?B?QXZwM29SajhFMlUvN0Nhb3prSEFoRmcraXZiVUVPb214UWtlUzlhOWRZbzN1?=
 =?utf-8?B?TnBaR0VIYTlUc3RtRUFvc0g3NU5xbE9KYTBCNkl2SVdaamVaUUNzV05sUVMy?=
 =?utf-8?B?RmhhWDJsTWg0ZUxidFY2bXd3dVQ3QjJuN3RJbWwvd25PQWFoM0dnVjcySUdX?=
 =?utf-8?B?L0dpZS9VUi9uUC9vcU42ZUl0bC9BQTZQcm5XaEk2WUZkUkQyR2ZlWWdReFhV?=
 =?utf-8?B?cCtZeEREd2x6R0VGdVg2aFEzNWV1azV2clp6b2wzUSs1anA0Z25OZStHWEEr?=
 =?utf-8?B?YWlqZHNPbEJjTU9DVnRCaXh5aVZ6ZHVMUzJ4QlFoQXVaUSt0OVpMQ0VWZkNZ?=
 =?utf-8?B?YVN0cTlKL25oQ3ZxOEJTWWRaTkNheWZNc0RrMHVRc25oOG8vN2xoVHJrR29k?=
 =?utf-8?B?dysra0FiSDJGdXJDNVJJVTdqQk5uNlRraFBlQjBSZGt5LzBuS2ovZVFBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MEFXOFVxWTZWbXFTMk1BcDhSUXEzQnA4d1VlM2Z0WnRaeURhZFdzMERnSVE4?=
 =?utf-8?B?c3RRbkg5MHd1aDhXVnJrNHZOWVNUSkRBWlBNQno5aktHalFIMzczcTB5aVYy?=
 =?utf-8?B?eFZvUXhTdnpGcVh6ZGIxUnl3b0htbzd2U0twNmlqVUVnSDFVV0QrcFN0bisr?=
 =?utf-8?B?Q3lXTFVtdENLdUdVNDZyNjRGaTA5MjA2b1BIQ0xWSjFpTkxqWHRyaGFrU2wz?=
 =?utf-8?B?S3VOY3RTRG5PNS9SNjNvNTNUQmQ5OXdDQno3eDh2dDdXU05QUE8wY05HOTZ5?=
 =?utf-8?B?OFZxTDhPWHBHOFo5amxjd1V5NW5yNGVIMEIzUUg1Zk1CSkpkK1VSTjlPREZK?=
 =?utf-8?B?N21VaTYwSE85S2MyeXBob0ZCQWhnM2xlanJnUGp5RWlkTUlRVmFzaXVnSnor?=
 =?utf-8?B?VFpOL1hSZE1RSXhjZ0VTZXM3MXBtRHZDc0VXNWhabC9rTmlsaWJZdlFVckl5?=
 =?utf-8?B?WXJDdHRrV09abVJURGdldTQwa0F0UTZtaHlIWFIxRERham9YaUwxNkF1SU1w?=
 =?utf-8?B?RXJGa1N6NVNMM3Zzd1NuRjVHWkoyc0N0VisyZzd2MDVqVmRSNTc1cHBNckkv?=
 =?utf-8?B?WnQwd0dsREt3c1JjcG9tZXZLTXpJV1diMXpMd2Z5Yml3bUxRNXZKZ1F3cERi?=
 =?utf-8?B?eG0wOFFPbW5zc0Q3aXoyQkVTV2lINVd2QmhHdy8zWWo1d0pGUnArUjJZeXFD?=
 =?utf-8?B?SGlFQ01zTk4xYXg0dXMvVUszN3pReDdKc3Z4R2djREJ3VXZjRVdPODBEUllF?=
 =?utf-8?B?Z3lqSG9FTUhWZFJsdGJxei9nSW11RlpZSWFvQ054ZHlZTzFjT083cFhIbklP?=
 =?utf-8?B?amp2bjd1ZE56RUVYQTY1QUU5aHNXbVNQV0pzN3dEUjBZSjBFdmlIM2V4Mk5t?=
 =?utf-8?B?aFJLMTRLVnl5ZC9PczRKQ0dFUlZ5cUN3UDVZZ3BGcUVRRmZDZzhqRVNEUVhO?=
 =?utf-8?B?Wlp6V0lISktaZnhvVm10bUJSMmZvT1p6K0tqYUd2ejlNN3BPakRyWVgvTkNB?=
 =?utf-8?B?czBCQ1dCa0JkMHlqbTI0S0EvSkxmNFRYWDQxQ2NOQjArWnAzelZXcmdOMGdV?=
 =?utf-8?B?ZjJtajlUaCtqT0VXQ2xSSjdObEREbVZXY3pCYzQyNVNZNFc1UkJYbFcrVXFT?=
 =?utf-8?B?cGs5TjNDUW9qczlCblNVb0Rnb1NPdEVFdlcxRVN3eXJxM2VrTHU4ZnRHWUZB?=
 =?utf-8?B?SU0za0FQK2FGcCtQSG5jNGJSZnY2SHBxTXk2b1ZrZEpKMnIybnY5aU1ZWGF4?=
 =?utf-8?B?b2ZvQ212N1ZBL0V5em02T29XZW1YemdoMFNWVjB4UEQ0eDQvOHRzS2Q0d0dm?=
 =?utf-8?B?SkIyY2lwT3E0QmM2N1I3RkpHcDZ2a3A5S1RBVkFnaE9GaEpQOWhWMUxiSm5t?=
 =?utf-8?B?OUt2QWVRbGNSV1B6RVN0OUlaSVlLVHhGeTh3K01VRW1TcmpqTFdaeXZkOXlX?=
 =?utf-8?B?dnNOeFVQQmxEYzVMdWFZSkJXUUlSdW5pYks2ODVRejdqeUpuM1NhZlg5Q1J4?=
 =?utf-8?B?SExvejRWejlYaEVpdEZqbTNvblV0a1VuN1BhdXc2NTltWUlCVFA5V1pGVG40?=
 =?utf-8?B?N0lpMkM1RkpqRzZ0YWNaaDFDY21TYTVrRzE0TXB4cWVFKzRIeEx3amx0Vnk3?=
 =?utf-8?B?L01BczRnMHk0c0ZmeUlNUXorMkUrclI4Vng4a2s0QlFmQzc4UklDTXM0OXF1?=
 =?utf-8?B?dm45ZVhXZGVtOTNxaFdVN2ZML3pVM3dOR0psSXpCdUFoeEdLTTlNSk5CZitv?=
 =?utf-8?B?aGNDZWJOKzhEczRFZjQxMzdhdDJhL2UyTGdSbTEydWZPU3R1MndiTE5jWVRS?=
 =?utf-8?B?THhTaXpUTWdHZnF4MEtDakh1UFd5bmJISktLa2Yrb0lTWkJpRGxjaVFJOGcr?=
 =?utf-8?B?MXIrLzdWZlkyRTgyUmpLa0NtUkdqeWFPdEROYnhUUWpkWUF6VzZmOVNUeFpp?=
 =?utf-8?B?NlJHWUNLT0NpU0FjL0lRNW9oNCtxeklVL2ZFclRpQk5wNnFzb3E0R01VdkR4?=
 =?utf-8?B?N0swN0YxaVpSaVJuNUhvWHlZejI1a2NoQzJOZmtlNm5acWlkZ2dMTWNiYjdM?=
 =?utf-8?B?TkZLeEh0MktjZSt4NU9uMEVjSTBnMEVYNjdKek5oYm5NSU9neXFudks5U3Vq?=
 =?utf-8?Q?5OyE83bnetvmssRS7YInH5jll?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 566d16eb-0c60-418e-60e7-08dce9b791aa
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 05:43:01.2694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YHhjJfBrBhkq+zVvovX4BKqbPd2KwAi5xfLispjt1boAKBnWhteftMO78bkP9kSnaQpA6Bzjgro852Rpbei3xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7697
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Oct 2024 05:43:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17030

From: Jan Kiszka <jan.kiszka@siemens.com>

This should resolve some reproducibility issues. Otherwise, no major
changes for us.

Due to isar regressions around umounting after certain tasks, we need to
carry 4 upstream-pending patches for now.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - include pending isar patches to avoid CI breakages

 ...king-the-build-when-mounts-are-no-lo.patch |  64 +++++++++++
 ...002-rootfs-Provide-rootfs_do_umounts.patch | 105 ++++++++++++++++++
 ...Add-missing-umounts-after-generation.patch |  29 +++++
 ...ng-umounts-in-rootfs_postprocess-and.patch |  74 ++++++++++++
 kas-cip.yml                                   |  16 ++-
 5 files changed, 287 insertions(+), 1 deletion(-)
 create mode 100644 isar-patches/0001-image-Avoid-breaking-the-build-when-mounts-are-no-lo.patch
 create mode 100644 isar-patches/0002-rootfs-Provide-rootfs_do_umounts.patch
 create mode 100644 isar-patches/0003-initramfs-Add-missing-umounts-after-generation.patch
 create mode 100644 isar-patches/0004-rootfs-Add-missing-umounts-in-rootfs_postprocess-and.patch

diff --git a/isar-patches/0001-image-Avoid-breaking-the-build-when-mounts-are-no-lo.patch b/isar-patches/0001-image-Avoid-breaking-the-build-when-mounts-are-no-lo.patch
new file mode 100644
index 00000000..8e650445
--- /dev/null
+++ b/isar-patches/0001-image-Avoid-breaking-the-build-when-mounts-are-no-lo.patch
@@ -0,0 +1,64 @@
+From 84fdccc3223d31bded29dd5adf86948f6cf83e81 Mon Sep 17 00:00:00 2001
+From: Jan Kiszka <jan.kiszka@siemens.com>
+Date: Tue, 1 Oct 2024 16:52:26 +0200
+Subject: [PATCH 1/4] image: Avoid breaking the build when mounts are no longer
+ present on umount
+
+This does not seem to trigger yet because we always have those
+mountpoints present. But if that is no longer the case, we will bail out
+when mountpoint fails due to the set -e.
+
+Fixes: 165519a7b314 ("sudo: Fail on the first error")
+Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
+---
+ meta/classes/image.bbclass | 25 ++++++++++++++++---------
+ 1 file changed, 16 insertions(+), 9 deletions(-)
+
+diff --git a/meta/classes/image.bbclass b/meta/classes/image.bbclass
+index 0c162aa3..9d5b782a 100644
+--- a/meta/classes/image.bbclass
++++ b/meta/classes/image.bbclass
+@@ -418,24 +418,31 @@ do_rootfs_finalize() {
+                 -maxdepth 1 -name 'qemu-*-static' -type f -delete
+         fi
+ 
+-        mountpoint -q '${ROOTFSDIR}/isar-apt' && \
+-            umount '${ROOTFSDIR}/isar-apt' && \
++        if mountpoint -q '${ROOTFSDIR}/isar-apt'; then
++            umount '${ROOTFSDIR}/isar-apt'
+             rmdir --ignore-fail-on-non-empty ${ROOTFSDIR}/isar-apt
++        fi
+ 
+-        mountpoint -q '${ROOTFSDIR}/base-apt' && \
+-            umount '${ROOTFSDIR}/base-apt' && \
++        if mountpoint -q '${ROOTFSDIR}/base-apt'; then
++            umount '${ROOTFSDIR}/base-apt'
+             rmdir --ignore-fail-on-non-empty ${ROOTFSDIR}/base-apt
++        fi
+ 
+-        mountpoint -q '${ROOTFSDIR}/dev/pts' && \
++        if mountpoint -q '${ROOTFSDIR}/dev/pts'; then
+             umount '${ROOTFSDIR}/dev/pts'
+-        mountpoint -q '${ROOTFSDIR}/dev/shm' && \
++        fi
++        if mountpoint -q '${ROOTFSDIR}/dev/shm'; then
+             umount '${ROOTFSDIR}/dev/shm'
+-        mountpoint -q '${ROOTFSDIR}/dev' && \
++        fi
++        if mountpoint -q '${ROOTFSDIR}/dev'; then
+             umount '${ROOTFSDIR}/dev'
+-        mountpoint -q '${ROOTFSDIR}/proc' && \
++        fi
++        if mountpoint -q '${ROOTFSDIR}/proc'; then
+             umount '${ROOTFSDIR}/proc'
+-        mountpoint -q '${ROOTFSDIR}/sys' && \
++        fi
++        if mountpoint -q '${ROOTFSDIR}/sys'; then
+             umount '${ROOTFSDIR}/sys'
++        fi
+ 
+         if [ -e "${ROOTFSDIR}/etc/apt/sources-list" ]; then
+             mv "${ROOTFSDIR}/etc/apt/sources-list" \
+-- 
+2.43.0
+
diff --git a/isar-patches/0002-rootfs-Provide-rootfs_do_umounts.patch b/isar-patches/0002-rootfs-Provide-rootfs_do_umounts.patch
new file mode 100644
index 00000000..6ac2af36
--- /dev/null
+++ b/isar-patches/0002-rootfs-Provide-rootfs_do_umounts.patch
@@ -0,0 +1,105 @@
+From 79155ddf156e073a98315bf2f35f7ca0f5ba3a77 Mon Sep 17 00:00:00 2001
+From: Jan Kiszka <jan.kiszka@siemens.com>
+Date: Tue, 1 Oct 2024 17:08:24 +0200
+Subject: [PATCH 2/4] rootfs: Provide rootfs_do_umounts
+
+This will be used more frequently soon to avoid dangling mounts.
+
+Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
+---
+ meta/classes/image.bbclass  | 28 ++--------------------------
+ meta/classes/rootfs.bbclass | 32 ++++++++++++++++++++++++++++++++
+ 2 files changed, 34 insertions(+), 26 deletions(-)
+
+diff --git a/meta/classes/image.bbclass b/meta/classes/image.bbclass
+index 9d5b782a..1eb974e8 100644
+--- a/meta/classes/image.bbclass
++++ b/meta/classes/image.bbclass
+@@ -405,6 +405,8 @@ def apt_list_files(d):
+ IMAGE_LISTS = "${@ ' '.join(apt_list_files(d)) }"
+ 
+ do_rootfs_finalize() {
++    rootfs_do_umounts
++
+     sudo -s <<'EOSUDO'
+         set -e
+ 
+@@ -418,32 +420,6 @@ do_rootfs_finalize() {
+                 -maxdepth 1 -name 'qemu-*-static' -type f -delete
+         fi
+ 
+-        if mountpoint -q '${ROOTFSDIR}/isar-apt'; then
+-            umount '${ROOTFSDIR}/isar-apt'
+-            rmdir --ignore-fail-on-non-empty ${ROOTFSDIR}/isar-apt
+-        fi
+-
+-        if mountpoint -q '${ROOTFSDIR}/base-apt'; then
+-            umount '${ROOTFSDIR}/base-apt'
+-            rmdir --ignore-fail-on-non-empty ${ROOTFSDIR}/base-apt
+-        fi
+-
+-        if mountpoint -q '${ROOTFSDIR}/dev/pts'; then
+-            umount '${ROOTFSDIR}/dev/pts'
+-        fi
+-        if mountpoint -q '${ROOTFSDIR}/dev/shm'; then
+-            umount '${ROOTFSDIR}/dev/shm'
+-        fi
+-        if mountpoint -q '${ROOTFSDIR}/dev'; then
+-            umount '${ROOTFSDIR}/dev'
+-        fi
+-        if mountpoint -q '${ROOTFSDIR}/proc'; then
+-            umount '${ROOTFSDIR}/proc'
+-        fi
+-        if mountpoint -q '${ROOTFSDIR}/sys'; then
+-            umount '${ROOTFSDIR}/sys'
+-        fi
+-
+         if [ -e "${ROOTFSDIR}/etc/apt/sources-list" ]; then
+             mv "${ROOTFSDIR}/etc/apt/sources-list" \
+                 "${ROOTFSDIR}/etc/apt/sources.list.d/bootstrap.list"
+diff --git a/meta/classes/rootfs.bbclass b/meta/classes/rootfs.bbclass
+index f0abd795..ef40cbdf 100644
+--- a/meta/classes/rootfs.bbclass
++++ b/meta/classes/rootfs.bbclass
+@@ -65,6 +65,38 @@ rootfs_do_mounts() {
+ EOSUDO
+ }
+ 
++rootfs_do_umounts() {
++    sudo -s <<'EOSUDO'
++        set -e
++        if mountpoint -q '${ROOTFSDIR}/isar-apt'; then
++            umount '${ROOTFSDIR}/isar-apt'
++            rmdir --ignore-fail-on-non-empty ${ROOTFSDIR}/isar-apt
++        fi
++
++        if mountpoint -q '${ROOTFSDIR}/base-apt'; then
++            umount '${ROOTFSDIR}/base-apt'
++            rmdir --ignore-fail-on-non-empty ${ROOTFSDIR}/base-apt
++        fi
++
++        if mountpoint -q '${ROOTFSDIR}/dev/pts'; then
++            umount '${ROOTFSDIR}/dev/pts'
++        fi
++        if mountpoint -q '${ROOTFSDIR}/dev/shm'; then
++            umount '${ROOTFSDIR}/dev/shm'
++        fi
++        if mountpoint -q '${ROOTFSDIR}/dev'; then
++            umount '${ROOTFSDIR}/dev'
++        fi
++        if mountpoint -q '${ROOTFSDIR}/proc'; then
++            umount '${ROOTFSDIR}/proc'
++        fi
++        if mountpoint -q '${ROOTFSDIR}/sys'; then
++            umount '${ROOTFSDIR}/sys'
++        fi
++
++EOSUDO
++}
++
+ rootfs_do_qemu() {
+     if [ '${@repr(d.getVar('ROOTFS_ARCH') == d.getVar('HOST_ARCH'))}' = 'False' ]
+     then
+-- 
+2.43.0
+
diff --git a/isar-patches/0003-initramfs-Add-missing-umounts-after-generation.patch b/isar-patches/0003-initramfs-Add-missing-umounts-after-generation.patch
new file mode 100644
index 00000000..0f2770aa
--- /dev/null
+++ b/isar-patches/0003-initramfs-Add-missing-umounts-after-generation.patch
@@ -0,0 +1,29 @@
+From 78e8ecbaab9dcf887e46e52d220647ad838b4d4b Mon Sep 17 00:00:00 2001
+From: Jan Kiszka <jan.kiszka@siemens.com>
+Date: Mon, 30 Sep 2024 20:46:50 +0200
+Subject: [PATCH 3/4] initramfs: Add missing umounts after generation
+
+Failing to unmount what was mounted via rootfs_do_mounts can cause
+troubles on rebuilds.
+
+Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
+---
+ meta/classes/initramfs.bbclass | 2 ++
+ 1 file changed, 2 insertions(+)
+
+diff --git a/meta/classes/initramfs.bbclass b/meta/classes/initramfs.bbclass
+index 6886b95a..42013356 100644
+--- a/meta/classes/initramfs.bbclass
++++ b/meta/classes/initramfs.bbclass
+@@ -45,6 +45,8 @@ do_generate_initramfs() {
+           update-initramfs -u -v ;  \
+         fi'
+ 
++    rootfs_do_umounts
++
+     if [ ! -e "${INITRAMFS_ROOTFS}/initrd.img" ]; then
+         bberror "No initramfs was found after generation!"
+     fi
+-- 
+2.43.0
+
diff --git a/isar-patches/0004-rootfs-Add-missing-umounts-in-rootfs_postprocess-and.patch b/isar-patches/0004-rootfs-Add-missing-umounts-in-rootfs_postprocess-and.patch
new file mode 100644
index 00000000..2f6b9d09
--- /dev/null
+++ b/isar-patches/0004-rootfs-Add-missing-umounts-in-rootfs_postprocess-and.patch
@@ -0,0 +1,74 @@
+From 55d8292d600e1d29fdf3f7eecc36f7c2ad6b0671 Mon Sep 17 00:00:00 2001
+From: Florian Bezdeka <florian.bezdeka@siemens.com>
+Date: Wed, 2 Oct 2024 22:31:55 +0200
+Subject: [PATCH 4/4] rootfs: Add missing umounts in rootfs_postprocess() and
+ rootfs_install()
+
+Calls to rootfs_do_mounts should always be paired with calls to
+rootfs_do_umounts.
+
+In case there was an exception thrown within the try blocks they will be
+re-raised after the finally block has been processed. This way we try to
+avoid leaking mounts but unmounting might still fail. In any case we
+tried our best to clean up.
+
+Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
+---
+ meta/classes/rootfs.bbclass | 31 +++++++++++++++++++------------
+ 1 file changed, 19 insertions(+), 12 deletions(-)
+
+diff --git a/meta/classes/rootfs.bbclass b/meta/classes/rootfs.bbclass
+index ef40cbdf..c7011508 100644
+--- a/meta/classes/rootfs.bbclass
++++ b/meta/classes/rootfs.bbclass
+@@ -248,18 +248,21 @@ python do_rootfs_install() {
+     progress_reporter = bb.progress.MultiStageProgressReporter(d, stage_weights)
+     d.rootfs_progress = progress_reporter
+ 
+-    for cmd in cmds:
+-        progress_reporter.next_stage()
++    try:
++        for cmd in cmds:
++            progress_reporter.next_stage()
+ 
+-        if (d.getVarFlag(cmd, 'isar-apt-lock') or "") == "acquire-before":
+-            lock = bb.utils.lockfile(d.getVar("REPO_ISAR_DIR") + "/isar.lock",
+-                                     shared=True)
++            if (d.getVarFlag(cmd, 'isar-apt-lock') or "") == "acquire-before":
++                lock = bb.utils.lockfile(d.getVar("REPO_ISAR_DIR") + "/isar.lock",
++                                         shared=True)
+ 
+-        bb.build.exec_func(cmd, d)
++            bb.build.exec_func(cmd, d)
+ 
+-        if (d.getVarFlag(cmd, 'isar-apt-lock') or "") == "release-after":
+-            bb.utils.unlockfile(lock)
+-    progress_reporter.finish()
++            if (d.getVarFlag(cmd, 'isar-apt-lock') or "") == "release-after":
++                bb.utils.unlockfile(lock)
++            progress_reporter.finish()
++    finally:
++        bb.build.exec_func('rootfs_do_umounts', d)
+ }
+ addtask rootfs_install before do_rootfs_postprocess after do_unpack
+ 
+@@ -379,9 +382,13 @@ python do_rootfs_postprocess() {
+     if cmds is None or not cmds.strip():
+         return
+     cmds = cmds.split()
+-    for i, cmd in enumerate(cmds):
+-        bb.build.exec_func(cmd, d)
+-        progress_reporter.update(int(i / len(cmds) * 100))
++
++    try:
++        for i, cmd in enumerate(cmds):
++            bb.build.exec_func(cmd, d)
++            progress_reporter.update(int(i / len(cmds) * 100))
++    finally:
++        bb.build.exec_func('rootfs_do_umounts', d)
+ }
+ addtask rootfs_postprocess before do_rootfs after do_unpack
+ 
+-- 
+2.43.0
+
diff --git a/kas-cip.yml b/kas-cip.yml
index f00ad74c..7e9ece38 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -17,12 +17,26 @@ target: cip-core-image
 
 build_system: isar
 
+defaults:
+  repos:
+    patches:
+      repo: cip-core
+
 repos:
   cip-core:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    commit: d2d3b3e94874d62d48c0cafb99dfffde6afbc6ce
+    commit: 36b04737a07baafc5af64cdc8aa61fad13fb494a
+    patches:
+      01:
+        path: isar-patches/0001-image-Avoid-breaking-the-build-when-mounts-are-no-lo.patch
+      02:
+        path: isar-patches/0002-rootfs-Provide-rootfs_do_umounts.patch
+      03:
+        path: isar-patches/0003-initramfs-Add-missing-umounts-after-generation.patch
+      04:
+        path: isar-patches/0004-rootfs-Add-missing-umounts-in-rootfs_postprocess-and.patch
     layers:
       meta:
 
-- 
2.43.0

