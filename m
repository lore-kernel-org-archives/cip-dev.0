Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BECC88E75
	for <webhook@archiver.kernel.org>; Fri, 18 Sep 2026 07:01:39 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.22])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5758.1789714896675604683
 for <cip-dev@lists.cip-project.org>;
 Fri, 18 Sep 2026 00:01:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=nnNdzj8b;
 spf=pass (domain: siemens.com, ip: 52.101.69.22, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MyjRZy52Xh0JPLiMn6A664YPzwNU1VRsk0cqjZ58PPWAhGmpeCp0dB/gj8gKm1cgNTMK1ec4wayfAc6EGUCD8JqzbtmrdXfM/Q7NS072y9XCPWmriUtF3MOiSsB9bSHrP0SeLfl+Cgt58byVPtDcZH9EOgID2GYMCeOBpVCvihytISFr8VNHAsW7Eus7xUNpyGPvUkTBLar8pNXxoWvjB8CeVDRZW9daq60tZLQWWysP1+dz5MFZm1fWitgNHEfmrdwT4E25kiVgfaPcRnUf1dQ8NjfhdJCZrUbTJXXiRbcFf3ekEottgnG0EmbBGeu/aZAIAsaoz1FXiK8RQGUWzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CrZtIZFg1O1HNVQzea9kjcz09XzwEA4KWih/9cNuTTQ=;
 b=QHpfxkYPzN/yR3mluwjEuiR9Njwzfy4Kacn+BPaX29o1RBfzeqQDC1GTAqQ7lMZlQkqIF3GLeHUs2kQbIWmxAU+53pGNHM6WVDiACw13nG37RJcOYHIv/68NhPUDrRvCe/zCtwvwIOALHrZhSjKFw4O7wdgwAvfrt1jcA7Rr+G6AjR2UuuxQ2/Cb14yp5xw5duP+jb1UF0L+HS/jmGT9BSuz2P7cuwxsVWaDNdpx5/60Xvdx2w7eB/fhLzGm16+GyawC/iq94FwyvQjZ5FoolmOH1k96HG4YkHonlM71QFT7ntkHB0XnL6ZSiL1tVtS1YFElS4GRDTJpRxK//60ioA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrZtIZFg1O1HNVQzea9kjcz09XzwEA4KWih/9cNuTTQ=;
 b=nnNdzj8bkL5hvAMKTb/FOVlO9hAgJrokQYL7i8vvBiulnbFVPFsXqmOB6Ajnxb3yzGurZxvbr3Cvay0mTF9gVnt2MzW/6TXEQmkD415PZi8286VdNRwCsvdmB9WscqnRWWRvwatwTZLCOXL20UZn8owB0aaqUBN25gZTVbyfk9svaSL0gmGipGRPkvXvyHOigEcVd1rg9+/Q2C+7JiRTFrt8KjRI/QJLBxrmP6VTaWQUBNhTzlp1MdyoNss33lg0SHjJmtp3TlqwL0/3DcHqRxCjCzQw31Hzltlj+FjJ5cRvh1Id9UW55xtzJhePM13TX9pk48l+Xk0DB9WvlfJFCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3507.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:159::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 07:01:31 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0428.008; Fri, 18 Sep 2026
 07:01:31 +0000
Message-ID: <24948470-d604-4ca3-97f7-3bc1a7675690@siemens.com>
Date: Fri, 18 Sep 2026 09:01:29 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH v2] initramfs-crypt-hook: Also set watchdog
 when using u-boot-based firmware
Content-Language: en-US
Cc: Enes Colpan <enes.colpan@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0313.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3507:EE_
X-MS-Office365-Filtering-Correlation-Id: c0b1e57e-34d1-49d4-5720-08df1552aad8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|3023799007|10067099003|11063799006|56012099006|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	EHSmRi8vSAA6A2gvjzJsZSb5Qi5R15wFUc2rK/2nilKfvKdxliiwsy8jPEWcuN/A4UNf9JIJ0HtbLtzxOCUAGf9Rs8Oq7ejf/jff+AvYDueynDRbG/6gGDAxGno3fX9fdlgU6yi/dkXg+bQYIW9Q4Jig2OVHbYHSULjyl9AlHUmUmA3zKYF6f1rco2es+Py35kVIOP5LNz/ZJpYD25N0YAu3mnxp88klRY3lNUXcNPJPdcTypbJWAZ8TUS+1T8Y0yNX72knHo9wh5nGZ1c3VlOD8x7ZOJGCaZIsLtvNhA5+SHsSqT7O3HRDGLBbhDM16T1Ze0G+EXizotCsxBm9lcQG5B1FlrvhoXMmDk3jRxrhEiETUY51cB+wOqtyJfpmdepNFI8t8ss306s71ay8zfSIvXNLBn2A7GF9lK2tBz8faJUlUh9yUJ+4nSDF9bxEYouRjLJNbU3jaxp3QgRCEASMediKpPc8Vn2/ZLg/l9kuL3Pix+i2hrkCPTKgfvJoKbzQG/o6ODfnbBSin9bH+eTQpTlcRRYUZnqx4syiXoUu+77u96d9mKcVP9WZRZ4IFKGj6OYry8ix+LVjbUia4+LukohExUz9u4ow3idXOhra3FXc96lf9g6MvcyNp1MRs+On23Zz90rtxKebPH6Yud6oCn6MctZ4uI9/Kj/4UUY0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(3023799007)(10067099003)(11063799006)(56012099006)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SU1wc3luZTNDaHNqZHJGNGhxU0FVQkU4b0g3L3loTmwydlNBRkJLWHE0eWZK?=
 =?utf-8?B?MEJ2NjhUZlVETnR2TXFSc285dHZ5NDhiV1RrSTlpZ25wMkhHNmdGM2MwUVkx?=
 =?utf-8?B?NThJK3h5aVd6M3Q3TmF1WlVkQjhqKytPam15YXFXYmJWTHdIUE5VSVluQVpW?=
 =?utf-8?B?aE1QUzc3Q1pCdnZuSE5wKzM4enoxVGtod2FrY1BTV2srU0hJclpWRFYvaVRt?=
 =?utf-8?B?MVU3cDJaTXBQV0tJYytFdUJnSnd1ZWtSTHlLaENmMTNZcW0yQXh0Q3FyUGF1?=
 =?utf-8?B?NStvQ3NYaExraWVjdmcrNks1QUM5MHg4ZmVkcGl6ek83M1hJclc3Nlk4K3o4?=
 =?utf-8?B?em9UbzdzOWRBUFlNMmdYTUZRUFd5b0ViVE1OcjByaEhGUGV4ODVWQlpvZjdT?=
 =?utf-8?B?b1NUai9FNFhQMmZqcXNZaVluMCs5WGJlR2dSUG1lVXkxaVZHaTY2a21ZbFpR?=
 =?utf-8?B?ZENXUzVQZENtRGxXbjgvbWVnMDVrdmNwbmV1ZjdvVWVETWx3U0dxdkx3bDFs?=
 =?utf-8?B?NHo3Zkw2VXRudkJhSHpuSnlhQ2lUNC8raGFvYzI0YWNTSGRwQjlDUFZ0dUM5?=
 =?utf-8?B?RFB3WVVpTGdITFpSazN5ZXZ4QlUwdEtDZ2xRN0lkYTJicVRRb2xhMytCb2R1?=
 =?utf-8?B?OWRGWnA2S2hGQWM4T2wyNlNjekJ2dG5JQWNOcFl6WlpMRVJha3A3Vm1GNk4x?=
 =?utf-8?B?eis5ZWgzY0lUV2Z4ZXdrYS8ySkRLaFJDNTNBZk5WaUltTjlRaGM3MVdnVmhp?=
 =?utf-8?B?S2pGbmRZZ2ppMjVaQU5hWXRGSVQyNGpESWhSS3JTZ2xhTW1qRHNZL3BSUzVp?=
 =?utf-8?B?bVRFMkN0N0t1a0U3M283R3FBZU5LcTVlUmJWM25UTm91bGF5bXl3bnVLVC85?=
 =?utf-8?B?Nzg4cVM4ZjJHS3hOR1d6MFJ1cm1LVm1hVitiS1hjUXoyZTg0VmlZdEplYUFm?=
 =?utf-8?B?Ym5WdEkyN0FTUnlVSHpIUDBlNnVoK0h6VmlUY3JJZTNLVVRqUEZuZlBzMk1l?=
 =?utf-8?B?c2VpU1dhcVIvYThSR3Fva0NvQ2tkVGR3NnNtTlc3eUJVeWZGREJ3d0JIblow?=
 =?utf-8?B?cFQvbWpqelMzY2hMY2RkT3pDTVptek5rYlNDZWlVeFFFMXBFcjBXR295WUhI?=
 =?utf-8?B?bUNzSkQxK2NqZG1QdGlDcGh4K2EzWWJrZnpsQXRaMlNxVE9vd1FwdWZ4LzZJ?=
 =?utf-8?B?Yi9IMjNvMFQ1NnlBZmlOZk9EZTdaZ3dFaVZVRlNaNzk3QUltN0JDdG1Qemp1?=
 =?utf-8?B?OXUxQkxNVkhtV0dxZVdBNXVBcTlyY1NhK3M2MlVMTmJjS1ZjQ0RvajFnb0lk?=
 =?utf-8?B?VCtYZXhrK25sbS9FWFFOTkw4VDhPVjU0TlorQXVwN293MmxOVjRTQTNWbCto?=
 =?utf-8?B?dlEzVHg5QTBOTE40SGVrV3NPc1Z6aVlUaUt1OG02RmdoWnVMZzVWSitlMlRO?=
 =?utf-8?B?dStkTTdIMFpmellyZmxpejJkT2xmU0R2VnZsU3hldHh1aTVZWG9DVGZHcE1y?=
 =?utf-8?B?MWs5ZjExU3FTN2x3TWxVeEhMODNzOWJrTVJYRzEzbktqS1VEZWVaaE9PR3l1?=
 =?utf-8?B?ZDU4WERSVVg2NEJsbDdEQjhvTmI4ajVJTDYyTlJUT1doSUFYUlczV1gyUDIy?=
 =?utf-8?B?QUduVUZ5N05ZZUhLa1gxN1VMSnB4WjRhZEpqK05tTGNoQmRpb2M4eFBoenZP?=
 =?utf-8?B?SDRVZFFVWFRqR3JIWVdnb2J3QUVRZkI3c0FqQ2VpeVRDOU9mYVdkS1cxT2pB?=
 =?utf-8?B?UEhoUzk2aEgyTFNETUZTNVZjaU9oaEhMYU5YT0k2VWJUanlmZVNSNC8rc2Jw?=
 =?utf-8?B?bkdSVUFTZFNrUUhIVzdhU1VaVWVmcnVWbUcveG5SYjRidVJKZ2dYSU82NDVn?=
 =?utf-8?B?Y1NmNlJSbzlPQTlaRHlFWk9IMjRrNTdMa0xsdVRObG9ncU9mYXoxVzkyOUhw?=
 =?utf-8?B?aDIwRWFMYjgvUUtLNFdqYy9kdldUNnl1QUhPbklZRy9CSGFFRGc1TUsxY0x2?=
 =?utf-8?B?UTh1L25yUWlHc2ZJSFdoNWhZbnNLclJYQ2ZCL2pHOGxtdFc4VHZER0t1Rkxq?=
 =?utf-8?B?N1VVS2g5bUtCZVk1cllldGZnWnpqY3FEb2c5dEY5d3IvRDVNdFBIdjlPV1l5?=
 =?utf-8?B?SElPWXFQZEJaK2x3QlNKOTlvaDZHamsxWTJaRDlOUlpFMDlEMHFxajM2NDhj?=
 =?utf-8?B?Uy93VEJVaVlTM2lSRUludTg2YkZkT2Zna0wzcGtDcDNEMkNLdWVRdU96aHRx?=
 =?utf-8?B?QVNVRUptQjIreFFvNmM4TFNCSU5hNXN0ajNGL2UrMFgvb3NuK3YzM1V0YXlq?=
 =?utf-8?B?VzJTN1dxR05WazMwcm9Nd25hTWVSalhOMzU0MTREWkpOb1ZqR1VDdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0b1e57e-34d1-49d4-5720-08df1552aad8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 07:01:30.9651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ed5DWxyaI8HQskr2YaxXDHyANdNWynVrMCDKOI3Jj28fjgbssFOJAvlL1KBgV/IskzSx01OtNpAYShDZgdRpLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3507
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 18 Sep 2026 07:01:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24236

From: Jan Kiszka <jan.kiszka@siemens.com>

In our integration, enabling fTPM/StMM implies the usage of a
U-Boot-based firmware which may enable a watchdog early. Make sure we
are feeding it while encrypting partitions.

QEMU for non-x86 still lacks a watchdog, though. Until that is fixed,
keep INITRAMFS_WATCHDOG_DEVICE empty for those targets.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - keep watchdog off for QEMU targets, or we will panic there

 conf/machine/qemu-arm.conf                                    | 1 +
 conf/machine/qemu-arm64.conf                                  | 1 +
 conf/machine/qemu-riscv64.conf                                | 1 +
 .../initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb         | 4 +++-
 4 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/conf/machine/qemu-arm.conf b/conf/machine/qemu-arm.conf
index 17c01fa6..e0fe9603 100644
--- a/conf/machine/qemu-arm.conf
+++ b/conf/machine/qemu-arm.conf
@@ -14,3 +14,4 @@ USE_CIP_KERNEL_CONFIG = "1"
 
 # watchdog is not yet supported in our QEMU executor for this platform, disable it
 WDOG_TIMEOUT = "0"
+INITRAMFS_WATCHDOG_DEVICE = ""
diff --git a/conf/machine/qemu-arm64.conf b/conf/machine/qemu-arm64.conf
index 3d590e1c..314d1430 100644
--- a/conf/machine/qemu-arm64.conf
+++ b/conf/machine/qemu-arm64.conf
@@ -15,3 +15,4 @@ USE_CIP_KERNEL_CONFIG = "1"
 
 # watchdog is not yet supported in our QEMU executor for this platform, disable it
 WDOG_TIMEOUT = "0"
+INITRAMFS_WATCHDOG_DEVICE = ""
diff --git a/conf/machine/qemu-riscv64.conf b/conf/machine/qemu-riscv64.conf
index 281c4249..2158a964 100644
--- a/conf/machine/qemu-riscv64.conf
+++ b/conf/machine/qemu-riscv64.conf
@@ -16,3 +16,4 @@ USE_CIP_KERNEL_CONFIG = "1"
 
 # watchdog is not yet supported in our QEMU executor for this platform, disable it
 WDOG_TIMEOUT = "0"
+INITRAMFS_WATCHDOG_DEVICE = ""
diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb
index 49ccc076..7d198582 100644
--- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb
+++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb
@@ -91,7 +91,9 @@ CRYPT_CREATE_FILE_SYSTEM_CMD ??= "/usr/sbin/mke2fs -t ext4"
 # Timeout for creating / re-encrypting partitions on first boot
 CRYPT_SETUP_TIMEOUT ??= "600"
 # Watchdog to service during the initial setup of the crypto partitions
-INITRAMFS_WATCHDOG_DEVICE ??= "${@'/dev/watchdog' if int(d.getVar('WDOG_TIMEOUT') or 0) > 0 else ''}"
+INITRAMFS_WATCHDOG_DEVICE ??= "${@'/dev/watchdog' \
+    if int(d.getVar('WDOG_TIMEOUT') or 0) > 0 \
+        or 'ftpm-stmm' in d.getVar('OVERRIDES').split(':') else ''}"
 # clevis needs tpm hash algorithm type
 CRYPT_HASH_TYPE ??= "sha256"
 CRYPT_KEY_ALGORITHM ??= "ecc"
-- 
2.47.3

