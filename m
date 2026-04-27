Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A03DFF885E
	for <webhook@archiver.kernel.org>; Mon, 27 Apr 2026 09:11:16 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.39686.1777281070071469350
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Apr 2026 02:11:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=OrJb5lBP;
 spf=pass (domain: siemens.com, ip: 52.101.69.44, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tch23nbh5zzHMQagQ5gud4acOQzuDgvjS4gl5s/8nJUh0JrkPU29XmoYtHCjikuHeTTn+UW8eeDhk7vn3EgjnhRbl2Sa2UlBlPBD9TowRTfUXT/nCV9eXvkHZFVIyF+dpfD+7Gq0an/xmnYzcFbPrx5KYun5JUL3Nv8nFs9F3r0dCPyPny1lCdRBA8+M5cnBBWVIe5aNJQrhhuY7yr3ks3a9B15oPp4a9rQgjHCrXFwumKD4YPqqj7RJcTE89UB/7zGuzv+n/omP9Of6RiASI+fyqO1xMheV1rsfmKR6cC2MBPDPTwPULetKDWf64Vqz7ABVWwpVFOJCYUXBPjaMag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dKbvIwq/HLplswqV0DiSs1FiYRdIosR5ApIyw/E8rl0=;
 b=PsDtnL6mXnXIzMpE1hSUI9jOVeUKX2d+WsU9e1i1wIh/EOIo9q1HYbB4pByCpbWa1aAHRM1sucCJP4z9L/9pl7sf+6g5xioMl1tJwAGMNhHjsEMGgRs3YnFJJ3JuBwJwqB3ycm0eFHBh74bA/lbBvB7OaVz16JEEaFbhS1wGrd2G6bJB/k/stoZZTCSN+JcCob6M8+Pp2AmQ1a8xVJyikYZRBVFPKNtKqNkl+fe96cUK2RqEbjbUZ8PiLGBA4olCN9Pa+x8RBfBkXGBiLhQBOYOxOnBjyXHHTmY+fSveZhlFrq4E3LzjzxeevdObdw07RGoENqG6bMKXIQQHlrjTbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKbvIwq/HLplswqV0DiSs1FiYRdIosR5ApIyw/E8rl0=;
 b=OrJb5lBPlfTHz80zftfCDEf6eudgIWVyjsi0FlWBhArKHby7Vyh9knnmsBEFUY7X1B+VZVT49cKO32wcp+xtwVjgkYgktlMYOxOiwxEOsG4P7bBD5zYKmK/OMlM7rYKm/V7w7C+06fMNGApuJZnjd6GwVhrsBoez/jbgCKqpX1MGBXH3lqeaGRFjX6rcCGVa4wbLYnCRhWJu5RWJRFuGlzlDKsjHBSuInY7WiMgC2QsXZN51hIKnuT86/GXZlPkwYm8S+XmDcbVIQOKsNNSuHPZS+0IdB+Hsbh1Y2N47hVHgmAo+4FNd2JYjFXQ6LAxxF+y2GyZoaZJzBiRsfT2Ukg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7249.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:60a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 09:11:04 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 09:11:03 +0000
Message-ID: <680d5aae-7d7f-4cc4-b285-d034d25a2e9c@siemens.com>
Date: Mon, 27 Apr 2026 11:11:01 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.4.302-cip110,
 6.1.169-cip54, 6.12.83-cip21
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0333.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7249:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ea763fa-16de-4324-397a-08dea43ce83c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	PJNHTxnUYSPit1r1aUb3OwbKw6zlSJalYluP9PCxojC/rhdHQnE0f128kPi6KZZc3tqT3d+2AMdTPDxoCGNn5KutfsHrbZl24modoQRSMYfADGrBh8vLGnOElUSYPwYRz6AwzWe6N+cizI4CXCRPNqXtuBpcTNVDRvM0DBzGpVWu9+285Jmr5G4XEL0v+RwaMDpHaMkiOmpXVFAHhF/K8NRSLBU7uO7GJ6Oy1JHGbVqKtgENNo3kJar+I9IMXH1ogj0Fdzlg1y8eK1hFy7+Gycf1x4MgDq4WJIQvKjetRwmOXP1S/C75HdZm10A9i2mNozZHvF/KKtKnjuFKZ5XU62VBfilD8roz4Es7yCLSCwvQFF+p8vWMpCC9WszDxBtHhi4BmaxnQdePdZyFNmuaSsgYi3o3uMZjUPyfpmFFfJpNuCv4RNneEAb8f9Ujgv64miq79N0Pt5x/m/buh+87NW5O5lf8VdHOHfj+D2PvMVUELPI8CtHUlC2Kp1FxjwDpS76Np/im69rsNIqBNchzusVrj7Gw8JAGymdgwfuTwGAMq24W1tMsD74QLJ4bHmX17sMGkAK1ZTdtl9XTB+7H9EGGvkFnjbyKp7fbSd3PC4dbXtljXmlTmAxeY95EOEvBiytyMyysbPXRnIVy4SUM7eGKY9irAtgr016xNGIRJErzJa4lD+8fzt2O+f6AaqMHpGgdmBA8Fot+M8EEf+JbOsz1GmuAGu2cLILp4eD7E/0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RldKdE1NYXI3aEVoSlcvNFR4a3NTK2lHTjkxSHpWZUM4SFVQb3FXcjVNZnFq?=
 =?utf-8?B?M1lqd1Q2K1hGYzcrWnRnbEc3UnlUVmpkUzJ0aEl3S0tRSWNyL1paYnJ3UGJJ?=
 =?utf-8?B?MXlMUDFydlVhRnFBM2wzWE9WMmNvWVdJa29adW1IbS9ZSHhFVDZVZkZzQkVN?=
 =?utf-8?B?dEUxUDZkWUlCSkh1L3lKSXU3ME8xczJycUZCOHdjRHErM0x2RDFvcE1uM0pK?=
 =?utf-8?B?TlZadHVWLytHQmw2UVV0MlBVWEF2ZU1vUm0zcHRYbDZHcFRoTFFheURjSXkv?=
 =?utf-8?B?QUU5WUVRMW5Ua0x1NXlRdWczNmNYKzZMZWNmVStYODIvQzBYa0J2VDVidVpx?=
 =?utf-8?B?Z0ljMnZQNDBRUXhqOGZtbno5UFZoS2NpUXpoQUJQZmtIWUl4M1JYR2ozNElz?=
 =?utf-8?B?c2tYNzdsSW5ialo2V0JRNXRUVzhMUWVONlhJak1BK1g4MTJGRTI0aSs1ckI3?=
 =?utf-8?B?a1pob0ZjUkpGWU5hR3I4c1FKbXhscFBsZk11NGNFanRvRlVkdjVmZ1JEeHRm?=
 =?utf-8?B?N2pBQU8rWXhsaVplWXZoM2JkKzFmZldQeG8zdFE0TmQwN2l6NTcybHFFcHhX?=
 =?utf-8?B?dlRnaXJna3dwRjRyalpsT0xkOGVHb1FrMkk0U1Vxd1Z4TGVqM0VoMjJzeVJk?=
 =?utf-8?B?YUZlV2t4S1dwS052VWtDaVgzc1ptV3JValhRMTRPQXc1c1NDQ01sZFpkNnJR?=
 =?utf-8?B?Zk5DUXl1aXdXNjFNV3E0dUJ0WGR6cTN2VHh5bWRpQ2xkSFduL1dlYXNkd0px?=
 =?utf-8?B?SVZtNzk3eFRJYjJQTWcrMUl4RU1QcWJkSXViLy9ydFhmbWVMOVlFRWY5ZTdL?=
 =?utf-8?B?MmNNanZIMm5KQTltTW9HSm41WS9aY1FRUFVRLzJibG9pblRlcHdHOWI2UmR5?=
 =?utf-8?B?b3pSOTBxRzVPU0EyM3Y2LzVGS3hOR2hBdlYybXZxMVp3bHIvdFFKZW5Cbndo?=
 =?utf-8?B?UzZleFhZbEhVQlAyeUNEWURHZGMxWElBdWlQR1NyWFhOUWNYOVFVU0czY1Bt?=
 =?utf-8?B?ajgxWFVoMC9wam5CU1V3N3l4SCtaSmxxWHFORkt2OXQ4WU0vNndBeTFYWEhs?=
 =?utf-8?B?bk9aTnNWQWVQeEJQRVV0OUxEdjlyOC9oSDRrcnFMS1ZOUG9sL2hEVEdRMzRh?=
 =?utf-8?B?ODc5WXRZZU8zYytYWmxQTHA4ZE9tc2k1bTNaa3hmd0NCLzBlT0ZmeVFiZyti?=
 =?utf-8?B?S0pZNHV2bGJNY0Fza3lpSFZaNU1kdERxTFVXUjBLTVBETW5uUnA0eitGSzdB?=
 =?utf-8?B?V2NGMU4wQmxhMG92OVNqbUN2R09ReWl2VXpsYXZJY201NFBRQVBrSzZNVEsr?=
 =?utf-8?B?YlNYUTFTdnJLcng4Q1g5OGRaRUppNFNHem92MmdOT0J4TERkK1FmdVVFN3Mv?=
 =?utf-8?B?WE96OXBodG5PVTE2bytWY2tndnlCVFdxREpYdkMyZ083QlRIQ0JoTGhFeVBY?=
 =?utf-8?B?TVJ0K1gwOGpiQzJTQmI2S3dXU1NwcUJEUDNDV1JQVTZzZ294bVdqb0hSLzJp?=
 =?utf-8?B?d3JGWkdWMS9sWGJDbFgxSUd2UnFFaHpVR2ZQeTJZa096WHZUZ3JLOGp3eHNy?=
 =?utf-8?B?WUhBU2pzQ3MycVU5amdVWDVnWDdEZGJYNSt3ZFp2b2NGdDY5VFlBdlJZdVk1?=
 =?utf-8?B?RTNUdjZ1OEV2aW1YSmZzSWVWL2syL1RLWDNCRGxkMUNDOWtuUDVrVjdSWEt0?=
 =?utf-8?B?cUh6YnhHb1dwK2pXbDZMdjAyM2hxWjRTZmZ3UXRxbW9FV2xGVGZmQzdMS0t0?=
 =?utf-8?B?SlNQcWdtOEdoQ3l3MjhKdGVtYmFPSzZYazNKc2JTQUVZN3RJWC9FOTBhbEJn?=
 =?utf-8?B?Z29HMjVIRkNrcXBhMm82a1RJQjBCczBWRkFBU3dSQXhJVU5rRCtQVDY0M01G?=
 =?utf-8?B?anZZRjhmaGJ3VG1SSlUxV0VRLy9VMUZxS2EwelMwZWhDelFDaVpQSk9hWVp6?=
 =?utf-8?B?Zlo5aXhCaVBRWEt6M3hyMTVEZTR3T3ZFWHVnYVFHUWhCTmQ0dzBUOUdGMW42?=
 =?utf-8?B?cHNQbnB1YzBqUnNKNXd1Z0NvTlIwT1Z2RUM1STVIVjlqR0N1UWs2eXhvYkJ0?=
 =?utf-8?B?Y2c3Q3dhQ2xDQ2Q2cUN1OFBWTlR3TytoWi9jVUhsU1dvYzRiY1ZZZnZveFFB?=
 =?utf-8?B?TkVYWGpUNWo1aFp5VEpOQXVqeWNnZUwvUHoyUk5lWjkyNHdTaWg1eFVSRGlQ?=
 =?utf-8?B?YUdzWTRVYUhBdVNGRjVHd1o4Tm9uc2ZYb1IydDYwY1lHNUdPVWVnL1NaUFVG?=
 =?utf-8?B?WDhJVkJmc1BlV3RqQytjZW1DdHV1SUJtTDFBL0svMTIxbEt0ODhLc2tGMDZK?=
 =?utf-8?B?a2VuOHFhNUNpNzd5NndOUng5SUxYQlNCbkVabCtObnFKZzJkOXpmQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ea763fa-16de-4324-397a-08dea43ce83c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 09:11:03.7536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yi6PSlQiYS+DLB+rw+23OeE/tihagJS8Qg/Bplw5YRkWfpsJnoiHhzi4XW06kCbM1w/OzwneEz2gJJRcANPpgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7249
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Apr 2026 09:11:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22813

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/linux-cip-rt_6.12.80-cip20.bb              | 1 -
 recipes-kernel/linux/linux-cip-rt_6.12.83-cip21.bb              | 1 +
 ...{linux-cip_4.4.302-cip109.bb => linux-cip_4.4.302-cip110.bb} | 2 +-
 .../{linux-cip_6.1.167-cip53.bb => linux-cip_6.1.169-cip54.bb}  | 2 +-
 .../{linux-cip_6.12.80-cip20.bb => linux-cip_6.12.83-cip21.bb}  | 2 +-
 5 files changed, 4 insertions(+), 4 deletions(-)
 delete mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.80-cip20.bb
 create mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.83-cip21.bb
 rename recipes-kernel/linux/{linux-cip_4.4.302-cip109.bb => linux-cip_4.4.302-cip110.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_6.1.167-cip53.bb => linux-cip_6.1.169-cip54.bb} (59%)
 rename recipes-kernel/linux/{linux-cip_6.12.80-cip20.bb => linux-cip_6.12.83-cip21.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.80-cip20.bb b/recipes-kernel/linux/linux-cip-rt_6.12.80-cip20.bb
deleted file mode 120000
index 6d9f41e6..00000000
--- a/recipes-kernel/linux/linux-cip-rt_6.12.80-cip20.bb
+++ /dev/null
@@ -1 +0,0 @@
-linux-cip_6.12.80-cip20.bb
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.83-cip21.bb b/recipes-kernel/linux/linux-cip-rt_6.12.83-cip21.bb
new file mode 120000
index 00000000..21dd76c5
--- /dev/null
+++ b/recipes-kernel/linux/linux-cip-rt_6.12.83-cip21.bb
@@ -0,0 +1 @@
+linux-cip_6.12.83-cip21.bb
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip_4.4.302-cip109.bb b/recipes-kernel/linux/linux-cip_4.4.302-cip110.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.4.302-cip109.bb
rename to recipes-kernel/linux/linux-cip_4.4.302-cip110.bb
index 9163c3de..55e57d98 100644
--- a/recipes-kernel/linux/linux-cip_4.4.302-cip109.bb
+++ b/recipes-kernel/linux/linux-cip_4.4.302-cip110.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "a836b062ee48b08cda5d06cd79e40a8eb05ab719e0da405b9243abc1a4d057a3"
+SRC_URI[sha256sum] = "d4c2646e4691e59c33c95d67b0d13fe00f463f43f3ecbfbe0295ac186cb77ab0"
diff --git a/recipes-kernel/linux/linux-cip_6.1.167-cip53.bb b/recipes-kernel/linux/linux-cip_6.1.169-cip54.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.1.167-cip53.bb
rename to recipes-kernel/linux/linux-cip_6.1.169-cip54.bb
index a332dfa9..9033bd64 100644
--- a/recipes-kernel/linux/linux-cip_6.1.167-cip53.bb
+++ b/recipes-kernel/linux/linux-cip_6.1.169-cip54.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "9ea8ea5da3ec1c75b36210537d850cf41024655fca8fb412ef425dc82abc0b0b"
+SRC_URI[sha256sum] = "795cab37cff6fda51255915b419c83481d98624aac9ebbdf63b60da65f5489fa"
diff --git a/recipes-kernel/linux/linux-cip_6.12.80-cip20.bb b/recipes-kernel/linux/linux-cip_6.12.83-cip21.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.12.80-cip20.bb
rename to recipes-kernel/linux/linux-cip_6.12.83-cip21.bb
index 15e2192d..9f1e5a0d 100644
--- a/recipes-kernel/linux/linux-cip_6.12.80-cip20.bb
+++ b/recipes-kernel/linux/linux-cip_6.12.83-cip21.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "851df39e8535f3cd60fbfd8500696abd704344288d7abcd7dbf4fb96b988ee3f"
+SRC_URI[sha256sum] = "e72ddfe5db1a6514bc564f54cc41503a1ba16e651c1f535f25b93eecde2d5f19"
-- 
2.47.3

