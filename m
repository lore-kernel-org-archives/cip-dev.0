Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EDDC021A4
	for <webhook@archiver.kernel.org>; Wed, 26 Feb 2025 05:47:28 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.67])
 by mx.groups.io with SMTP id smtpd.web11.72.1740548843285967503
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Feb 2025 21:47:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=oGOtThz0;
 spf=pass (domain: siemens.com, ip: 40.107.20.67, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Trtz3juzUmxxwuoaYIfoJpdv1ePJQFxtDnU4IIXxHbABGYzDnCLs+PkvU5vWb/Gf85xUrSn2Kp3FbexjJoIaSJ4CkgUEpX5GCqcEmrSD89Qt36OE0/D7xlXzBsM5dFzmJ8voqU5J5UkiQmlwd2KiCJpXxRqJjLsW8kY1zj3/cSdceg4sJoYffhDGf+sTtJthj9K4zoI1tOIXCEUnfE7fqiNtHPOkYk/czcoPg/jb+uz1eRD3GvOE+V+pLaIOV7g3N+4hdyF6phdHSv09Lm8mBuzQKKRnnY+Dwp2DvF8YvUqdka7XTXJcXHV+T87SkSOf4YwaZZD7V1ywBnfd6tmFTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S90TnHignwVhs6yAfCor+k4KhzN1qdrZIs8wKll7R1Y=;
 b=C46l5Q0LCLoqsqCESl0gSPR9mUdalDks9bcWSL/82cULl4ctP3YJZ3Sb9Xdwtsm0Kzy+byZ+NZWaBt8bYMmtXMMR6OpDcMfVfglj5DSImLDig+L2BlLfygFSgYZNtiSj5fWK6/Tpi20k0Tmo0UYDlEUr/rgGlMOQH5sy1fdY0I5Y7UH9nNkn2pdhhtKQagXMEsUzI+mo7JYOhAudZu0odIdAdz/KArdBu5css/wYAMG59nwEnhzyrh3C26We7jUe6DhcEU8S9Gf4c9hP1BssXtaiHO/hY3sEn9GlUGcY8QvTEnCFtkg7dlfM4vXd41apJg7SopshyK3LuXLet5ybnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S90TnHignwVhs6yAfCor+k4KhzN1qdrZIs8wKll7R1Y=;
 b=oGOtThz0wtroXxtvejveq90gP7qcqYtBohpBDiuo4jQ2JNumogFHPftOzUzCPmpmMALUwL+Gn/4jalhVDv6g6PiV7MhWYPjNVhWx5dAuJ57dUJvUOaVT733aABWGsp5yjKvMz39pTjn5H0VE1xYJjvgZ6FSsc636cQ6pq8FuuPSzTurpco0+f5WRrAkCPqSNgqK/eLGxCvdEvySWCKQrv9W5RCCwkZOqZW4iTvAC1b4gJ3u4h/QKA1ukdCTXVFFQnbt8DnSq8uj61OEkpeXzEArEIJQwgPvCF0s1zTbXFkBi7Ix7e0/qnydunaExTYErkXtgPPgGfqGtnl3PfEoQ0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB6992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3f4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Wed, 26 Feb
 2025 05:47:20 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 05:47:19 +0000
Message-ID: <465fac99-b1e2-4b2a-87fd-541004da35b1@siemens.com>
Date: Wed, 26 Feb 2025 06:47:18 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] Add isar patch to fix riscv64 builds
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0066.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB6992:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c0d1356-221c-434d-400e-08dd56290895
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Q2RSZnJTRVNHSSttZE1YTHJ2K011SXNLVjAweE1QajROL1V0dXRhZjFkOGts?=
 =?utf-8?B?SkQrK1VXTWs5OGdVcFJxUm1FQVZIaGo1VWlYOWVTK0t6VWJtNmUvSXFlMWk4?=
 =?utf-8?B?SnRhR0dBSDh3dnRWcG5OcnF3UHhtb3BWRStHSUF1TnU2d0ZWMFFObGx2Z1M3?=
 =?utf-8?B?L2FuYnJlL040VDQveFlEMHFjY0lsRUFEcnRtWWtXaDZYMnJrTDB5UHUvb3lt?=
 =?utf-8?B?UWx1WEQwV2trVG9icGJRNjM1RlV6OFFZTUsxT2lnZEUvUllhMnVGQndzQk9W?=
 =?utf-8?B?ZGtZckhwL0RSb0xJcUR2d1dhS09kdmNJWUd1NWgxb2ZjcDJoVmx0RytlTGtY?=
 =?utf-8?B?SnBUQUdLL0FBN1BnK3E3S0ZSRDBjSFY1T2RYRC80WWJ4d1V5Zis0TGxvT2I2?=
 =?utf-8?B?T0pMYjVCLy9id3hTSUJRVms5MFhkSWE5dXBWdW10bVJIZGNwODFiZTkvTC92?=
 =?utf-8?B?b3RyeVNOdmJQM2JxZ1g5SXpPaDZaa1ZKcGJwN0RKTDJhMVZsZjVaK0Rma3Iw?=
 =?utf-8?B?YzRPcTZac3B5QkRqcS9xcXhTV3ZnMUFCWnlGVVJNU2Q3a1ZZTDBxdXJTeGpV?=
 =?utf-8?B?VWFJTnZXSWM3MGljNzhXK0hRRnBHNU5XSVJLRkM4YXFpOW5TOEtEeVAvQmJR?=
 =?utf-8?B?SVB4UFk4MGNhUFhaU0t6QW96SW42eC83V2FpUXljTk5PLzJkdTB3TmFmdEJR?=
 =?utf-8?B?Qy9hOGhnNGx3a1ZxYzcyRFhWNjhFQlR4TjJZT3p6MytaY0NDVzJsblI5bWdV?=
 =?utf-8?B?Y2g2d3djRFZBaC9Dc2pBR2dXOGUxNktCT1VSWHZGUUd3NGlNYTI4ZmV3TFpB?=
 =?utf-8?B?WEFuK0kvVm10VWN1QkZqa05CVUJCTXVSd2dRbkVQTDFhWFhDMVEwMHR6Y3VZ?=
 =?utf-8?B?U21rNk8xa0RJaUNnbGxGMDBvbHFCOEJmVDV0YnZ0Z0lNUzV2RWVOQmlLcFRi?=
 =?utf-8?B?ZWpBclVmZUdaQWlOd25mZ2U5ZjlHUnBHTjgzYlVFOTYxdUpMWm1rUG5jZ09Y?=
 =?utf-8?B?eExUQVluTXJGTkNDWi9KZWhFNG9SekFybjFnSkQxekxvS3hxbnYzNzhUZit1?=
 =?utf-8?B?Njh0aFhhN2h0QlhyRmU3SUcwOE9zYjA0SVNsbVFnREw2NURBNjFyMHVCcVJR?=
 =?utf-8?B?bU81aG8vdkdOakVPMlZqUjlDbmFoTmRpUTYreS8zeDhXZDVuc1VGdkRxNWp5?=
 =?utf-8?B?ZlFOK1BRNjQwdHZOYzJjcENDbjFwcXNFbFJZYkdVTy81K290UVZtbzhqZFZt?=
 =?utf-8?B?aGkvY2JpdUhQUDYycGRuYnU1eWx5ZVFrYThMOXc3ZjJOSWhQRzJ5WHFLZEl2?=
 =?utf-8?B?R1AzbVI5bWowQ2N5N0IzbWVBNlUxMEFFcVR2dVBPV1E1QnlvNFZyVkh1Y1Fs?=
 =?utf-8?B?Q09XbzI4MlgwQlVZN21IN3U0Z2cyMjJPM2pSRjdVOWtjZjJvakcxVHBiVUx3?=
 =?utf-8?B?SzEyTktOU3NyTFlzZFl5OXV4cE5jT0srd0RVaE1FNTNyZGp3MmRKZFU0TzZZ?=
 =?utf-8?B?NjVuNzlPaTNBN2lQWCtUWVk2TG9xWmVPY2RQU29SSDV3NDdGdnBFRVNrbFVV?=
 =?utf-8?B?eUp4NWpZdTFaMnpGWHVwd0xqOUV4cy80TFQrUnJNQVc3TjlZbGlaWlQvUVlI?=
 =?utf-8?B?emtrZXc2bTQ2NWRrblR2clAzMmN4V29JTndzbGp1eHQ3ZGQ0RllsQ3RLK2J4?=
 =?utf-8?B?WHhSaG81ckJ5Y3pZOGVIekFFWnlnenhJMW9aWGpaVWRKamRzZGo4MEVrOUZl?=
 =?utf-8?B?OEtEOTl1dGJSQjN2L2pNTEdYWHpwSlBzc1FuZ0lhbndTWmVaVEZEOXlFOVN5?=
 =?utf-8?B?Yll2c3hQRURYVTZiT29qZz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QU53eFFZOEJ1UVlsaEtUWUtvcEcrMmk0cE5pTEJpMEpNQnFvcUJGbmR1dDVh?=
 =?utf-8?B?ZUIrTUlhdE11T2crUzFkZlhXUGE5c0VxWThaV29mWTE2WU90ZHlCNU8vcGg5?=
 =?utf-8?B?VDFLRS8yYUU4ZTBEbC9GT25XQk9QOWdqSzBCS2pWZW01SkdCY3dFWTJ4NU96?=
 =?utf-8?B?eUxTRkprb1JYZWVLOUV5UG9TZGpXSWx0RkZsczBkazlOdGZSZDNYWDlYWjlv?=
 =?utf-8?B?djFnM0s4ZHQ0MUpxUlNPMjBXSlFLSGNZeDFwWDhadjZsc0ZuSDRMSlJOMjNC?=
 =?utf-8?B?NlZZakFRZXhGbkI3cUh6bWFPaUg3c3ZkN1AxSTAxWkRUeEZISDlCUzc5WlVI?=
 =?utf-8?B?RnJCaDd5L2NSZDlab0xBbVJLWEtBSjdFU1ZrRFBQWnVmYis2bWIwbldhRXZT?=
 =?utf-8?B?Ym45N3BlZC95SGdSUElSOTVuMUQxZXc0ZHRHR1VMVHJTaG9UQ0V1dXpFNHkv?=
 =?utf-8?B?N3FUMlZOT0F4U3dsd29EcVhOQzBRK3NnZjVUT2FyVHdLWmcxcXp1M01PenNk?=
 =?utf-8?B?RE1waEpmS3hUQ3VwK2d5ZnFCZkVmT2RBRTUyMWZZYU5WTWpQSmwwWGtabmM2?=
 =?utf-8?B?L0NKSCtEWDZIY01GbnR1RzdvWmUyVE9WVnNRbkNDR1lVV0RWcDhETWE5WHJh?=
 =?utf-8?B?bjVUVXNkemlyTEd1Uk9KYlhTOGlneW5UUjBBUXQ1MkdndU5kQmo3N1JucXhn?=
 =?utf-8?B?dlBwRzVqRllHNU0zZU1KTjZVMUQ1Tkd1WTBtd1RsVnJnNWU1Z3VwQ1JSRVFY?=
 =?utf-8?B?VXBxT29RbmNHeGc2cE9XM3FJbkFOQVRxVXd5a3RRZlo4TldmdWV1S2VlRDEv?=
 =?utf-8?B?T014d3NlTUd5ak5DL2ozTVc4UVNncDlJNkhmL2JjOGNQdGEwclN3N3ovTWQx?=
 =?utf-8?B?MllGVFRaRy9VWjhMUDRIS2doTnhxc1Z2SDVFbjBLVkhvVVp1Q20zVUIveUow?=
 =?utf-8?B?L0lEWTd0QysyVXFPSTFhZUtVVUdxdCs3OXZSOVg0OHNCcWZmQW11ME9WLzBr?=
 =?utf-8?B?ZVRLVFF4SzJqT1JCbGVTSjFrOTRua3puK3M0bDQxNnlETXpVK3Q5TEdJaHR1?=
 =?utf-8?B?bmpIeUtBa0I0Z2wybzJFVU9ZYTRpNE5JbE9LUmE3UDNsM2gveTF1TkJRM1pM?=
 =?utf-8?B?d1BJVXNNR1lDU3g3eTRhanQ0QlhDdkg3bTB1bEJBNzZHT2lMOXpJeTJYaita?=
 =?utf-8?B?WkJ5Y0FjYy9YUmRkSlZKdSs0b3Z6TjNMVm1maml1eEw4Nm80aEJvbVZpYWJ2?=
 =?utf-8?B?K0JBd3VrU20yMGx6RXA3VHJCNERSR3I4aUh5QWpnR2JZUmR0L3YwYnVYdlA0?=
 =?utf-8?B?Sm5SMVBsSmVQeDlxTFZMakhQR05jSFVXRm1CbWlXdXdSSHhod3NEeUw1NThW?=
 =?utf-8?B?c2JwaUFWNDVmUjUwU3Y2ekQvM3JCYjhuRktMaG1rdGU2UkVqYnBwSGpjRnVx?=
 =?utf-8?B?b05LSDZYd3d3UVI1UmdnanJDOHBjTWdYOTg0NWNOQkJDRzBudmVOc2JlMWhI?=
 =?utf-8?B?eGt6TVBtOG9waGVxVHBBQXJ4NUE0WU1zV1EzdkRnSDJVUG9PQlpiOE9rQUVp?=
 =?utf-8?B?Njc4ZnBhYVpLUzNFSjZMWkZLazd3VFJKcStoNG1zc05PY0hoUUpvUFFDN3hW?=
 =?utf-8?B?T3FFUWxlZGd3M0lYNmw4TGpLS3ZoL2haMDcxMEFBUmZJYTRWOTVTUHZJekpn?=
 =?utf-8?B?NnNLcXpZZzVsaERMVEluWTBEN1pEOXVvYXFteS9IeDQwamFOOTFuOFBrTG45?=
 =?utf-8?B?T2NUaGMrSFNRRDB3b3lVbGxvY2hvMWd5eEZGK0xtaitvN3hzVXB1WEpyWHhV?=
 =?utf-8?B?eWVYaGRNYXBBbTRkVHZHaEh1ZU0ySjJhb3JueEhONTh6cDg4SXRaNHIxNWZB?=
 =?utf-8?B?UURMV3VMOFhPQlFJajkyUjloSndnWkhZRmRkOUZrNXZRSjRQaCtRcXZlbzFk?=
 =?utf-8?B?MHJObEZtVUY1NVFDaGlIQm9aQVREYmR3bU55VFRBVWRUT0p6cDB1L1UvZVJs?=
 =?utf-8?B?Y3hveUZpdlUzOCtSTGJWaXdBRTFsRXFmYys2c3prcVA0bXVNSWwxZTJnWmlW?=
 =?utf-8?B?UEFXb00yc1N6QWEwbGRhNzdScEU1TUdOeC9uZEp4RXJzejlWVGJ5YnhsYjJ0?=
 =?utf-8?B?dHBBMk4vT1dBaHBybnNveGxMaGV2UGg1NzAxOW1IMll2cEI2WlJXRHJ5VCtI?=
 =?utf-8?B?bXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c0d1356-221c-434d-400e-08dd56290895
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 05:47:19.4963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y0uvoCtFPhT8DvWUZ7K0jHfsnIOMyw8BnIsR93BQtAIJGZXG5ouycgJZPZ2ysbE8WvaExJtpjJ7u2jScsdQnHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6992
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Feb 2025 05:47:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17913

From: Jan Kiszka <jan.kiszka@siemens.com>

Pending upstream: https://patchwork.isar-build.org/project/isar/patch/e0283029-6862-4282-a235-0dab237a143e@siemens.com/

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...op-no-longer-needed-and-now-broken-r.patch | 32 +++++++++++++++++++
 kas-cip.yml                                   |  4 +++
 2 files changed, 36 insertions(+)
 create mode 100644 isar-patches/0001-sbuild-chroot-Drop-no-longer-needed-and-now-broken-r.patch

diff --git a/isar-patches/0001-sbuild-chroot-Drop-no-longer-needed-and-now-broken-r.patch b/isar-patches/0001-sbuild-chroot-Drop-no-longer-needed-and-now-broken-r.patch
new file mode 100644
index 00000000..fc4f6bd6
--- /dev/null
+++ b/isar-patches/0001-sbuild-chroot-Drop-no-longer-needed-and-now-broken-r.patch
@@ -0,0 +1,32 @@
+From 5dc3f7d755b5adf447b419816002076bed21b8e1 Mon Sep 17 00:00:00 2001
+From: Jan Kiszka <jan.kiszka@siemens.com>
+Date: Mon, 24 Feb 2025 21:25:49 +0100
+Subject: [PATCH] sbuild-chroot: Drop no longer needed and now broken riscv64
+ special case
+
+This was forgotten while cleaning up for trixie in 735dc16c1e. However,
+it continued to work - until these days. Fix the riscv64 build by simply
+dropping the obsolete package list.
+
+Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
+---
+ meta/recipes-devtools/sbuild-chroot/sbuild-chroot-host.bb | 6 ------
+ 1 file changed, 6 deletions(-)
+
+diff --git a/meta/recipes-devtools/sbuild-chroot/sbuild-chroot-host.bb b/meta/recipes-devtools/sbuild-chroot/sbuild-chroot-host.bb
+index 255d6937..3f0888d8 100644
+--- a/meta/recipes-devtools/sbuild-chroot/sbuild-chroot-host.bb
++++ b/meta/recipes-devtools/sbuild-chroot/sbuild-chroot-host.bb
+@@ -18,9 +18,3 @@ SBUILD_CHROOT_PREINSTALL ?= " \
+     crossbuild-essential-${DISTRO_ARCH} \
+     apt-utils \
+     "
+-
+-SBUILD_CHROOT_PREINSTALL:riscv64 ?= " \
+-    ${SBUILD_CHROOT_PREINSTALL_COMMON} \
+-    gcc-riscv64-linux-gnu \
+-    g++-riscv64-linux-gnu \
+-    dpkg-cross"
+-- 
+2.43.0
+
diff --git a/kas-cip.yml b/kas-cip.yml
index 1a0f6946..16e54d63 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -25,6 +25,10 @@ repos:
     commit: b5f7aef4e4fd26d852f8b09e545d5ade551224df
     layers:
       meta:
+    patches:
+      01:
+        path: isar-patches/0001-sbuild-chroot-Drop-no-longer-needed-and-now-broken-r.patch
+        repo: cip-core
 
 bblayers_conf_header:
   standard: |
-- 
2.43.0

