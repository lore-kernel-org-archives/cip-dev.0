Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A819C0218F
	for <webhook@archiver.kernel.org>; Thu, 30 Jan 2025 13:18:00 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.0])
 by mx.groups.io with SMTP id smtpd.web11.15133.1738243073926001053
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Jan 2025 05:17:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=JRbfM5W4;
 spf=pass (domain: siemens.com, ip: 40.107.162.0, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zTVd/jxi3QLLw/gghdTihRvnTuzop82g/23H4vqvc02KET2Cn5BzgFKcbQr8PSsKsK/R3i34d0y5QqaVuJM5iScaOxhUFLfNW7sIXGg9Hnn9SNdxFFql9nZXU3pi7skUhCxeeuylFU0wM+H+K1+zgI/BTA3InwqRaq3/nOwZsiQGxd2I8fLWeUmf+llXTjl/MVGX8GCddLqehwjhL95+BNvtyZFo/s+419/i+F7T8xcKAEmo0xkOt1nkhWvQllUWLioQgJIK0klBKWVlb/W4/YYcZADVD2GBCn6F7HlIaO2fwshUbn34Ef5ITRbFZjzX5Qno9aO60cy8QT784jWdRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Sk0xKgEBTprQM1snsUuqy18T14AzMuV8JvG4KaSA0k=;
 b=ISDDyNch/Ub0MrIEaXEfTRU2jXz/K5WK3jTdJDTaJ6HgKO5t1LC0Nzuvi1FMgnpy0FC6lvoPJgEgqrwgmE6QhkqCgaeYvEOPkwuW5T1h5bJjPtB1JD6ahk8Mu8XqwOBXO1Pj5c0baXlkaEjnRuIHbZIUJ5OHrF3ii3dW8x+T8dtE102cf37dXbS1RY0ndsKL8KF5Bf3Ovgow2d72n5rQ7CMOKYA+izr0r8zYiQQ4ubWUXe6s/0GZuV5ElZo55EcaowNwPFFLoj/hQsmrcabWVLvDsy3AvZhVqjqTxKhmRtO1Q2kIk6SCRF9t7T2VjCGF3XLmKHzNRFnJ7b/bAPPMZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Sk0xKgEBTprQM1snsUuqy18T14AzMuV8JvG4KaSA0k=;
 b=JRbfM5W4vLlY1cgEZQkFAj+LOgr+9BFe5KNwXUVi3UwtewL1W4osh2cGSlCNW8Wg25woHbtJqab4r1NxbHL+vQlEMHwdlU0Rm+QxRMXiOB6dlUfe7k0dpzMq8ed1Ss1bAaGeIl70Ccq/eqEpzBtDYaZVAYeNW5ZOgA2vQuvoj8QNsIofaqFJ//B+SxFzyBHKb5VdC35H5mrtykCcW7Dpub4IrOS9QPGp8JFJMZACt+imcOYS1KAaT5t7ciq/T5ymjJ2vE9cNCETkIU5Y3w6jWZWFgBOxDtgvfd/GPpmD3J4ez12utVRRwhhtq3JhF0C3fY4i0z3xUjpVHKgZYdp8Cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6137.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:ad::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.14; Thu, 30 Jan
 2025 13:17:49 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8422.005; Thu, 30 Jan 2025
 13:17:49 +0000
Message-ID: <16a8dfdd-802b-4ce2-98f7-f0bb235a9285@siemens.com>
Date: Thu, 30 Jan 2025 14:17:45 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] Update isar revision
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P221CA0004.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11c::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6137:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fb989fa-ec68-4560-692b-08dd41307e4d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?NUNQeWg3QnF6ckc1V3hKdWxDRkF5eFBNL2hkc3BDR3BNamJUT0dmSEEvaFBF?=
 =?utf-8?B?dGcrbUx2cmdTR0h5d2pQS1NvNk03bUhsRTFRYndHNjNxMW42eWduUXBqTFg3?=
 =?utf-8?B?eEN4Z1dIVHVsNU1rQWNTNnRKSnFhc2V5Z0JKLy80dHZaMjlZaWNMSHI4WlpR?=
 =?utf-8?B?UGNnMERNRzVmUjhTeWpZMzFkUXc2UjVWS0Q1OFVzWlVwOXUvbUtHeFpnUHli?=
 =?utf-8?B?MC93eWRNZmdQV1owditGWE5MWkxWTnZmQllnUXdMLzJqZDROZjJGU1d0VXBm?=
 =?utf-8?B?UVQ0RHpoQWhYeWxiamo3VU1xY28rTGxCaDZSeVYvKzQyV2JTQnJia1gxNVZr?=
 =?utf-8?B?MEJOYXpVMGYwbHFkMVptWTM1YkNVU005dVYzc3FPVThOVkJtRTFZZWh4eDQw?=
 =?utf-8?B?cEhwc0p3d2xseGc0ZmZDVys1d2NOOUFKNzkwNFY5R3M3enR1SnFZZno4ZEVE?=
 =?utf-8?B?ejI3bFVhcWpDaVJOcVlxU1lsZXJkMElWaWdnKzlhYmQxMHBpOXZzdS94K2dK?=
 =?utf-8?B?TDNsRFFueFZud1ZNU1ZFdTZUZHhULzVpbFloK2QraVEwUy9WUTFmR1FGTHd5?=
 =?utf-8?B?c1V3MFRCb04reUdpNy9ENHV2WGxWeXJ5WTJseElqQVVSVDhrcHRlZWVwN1Qw?=
 =?utf-8?B?dER1V2hVVDFBODFHaUVYZzVZT0JSTTJOOG5JSHhQQXJ3ZEljVGJJeG5SR0tJ?=
 =?utf-8?B?eTI0TGo3clFpWE1TZmRQeHIxVGVvclpwb2xFeDFOdlVrUnVrMlhBY0NhVzRE?=
 =?utf-8?B?ZXdScjdmZjNHb0JiTHNWT3A3NXJGMEFBQzU5bXVWaHI2MjlEcWx5NklTWi85?=
 =?utf-8?B?MmlsdXFLWkdMR0pQek1naHc2YUJxRmpHVWgzdThWWmVrUDlEZUpLYjZVT1c0?=
 =?utf-8?B?Q2FuUjFDaGxCWmtPVWVHVisrbnYzcmR4N2dsT3dzbFp6ZWFBM2g3am1seGpO?=
 =?utf-8?B?Z29aTDZ4SEUxUlhIN2ROQm9uS1lnSEI5YXFtdFpSMms0M1prRDcwRWZPejhh?=
 =?utf-8?B?YnBYUkdGK3pMSkkzTklJbWZ0eG5FZytjOU00akNCNTFHNGhUK1h3cjVhTTJi?=
 =?utf-8?B?TWx5bXhPcXNBV0ZMSXZXUUJCNHZZejNzVzdWa0dCcFBqY1lRSHYrMjBLSzE2?=
 =?utf-8?B?SmJVNDNTSzE4Q2NIOC9MN1FOSGlNbW5uQkcxNHRDcnpDanE3aDEyNjN6WXVI?=
 =?utf-8?B?RFpHdzVRbFZnQ0JlS3FOdm9nS3ZxZVEydUl5ZTBvL08vQjFNZS84dmdhSHJ1?=
 =?utf-8?B?bnlONFBLL3A3Zm83dHNwYlFOTzVDYlRDejVROGIvcTR6V3VCTmpBazVYMVFH?=
 =?utf-8?B?TzRVbGJLeFl3Y2N2dFNmdGhFVXNZb1RKby9zU1lOT1hzd1lzWUJrcElpRnlT?=
 =?utf-8?B?V3hqQ1BJdlVvMkE3NFF2N3hCczZVdTdsaGFMWVJ4YzhJemVmTzJBVmcwRWpk?=
 =?utf-8?B?cDdaQUhZRU1wcEZhNC8wQW5uUjZpN0thdlV1NUxYOFdRK0tESEVPT29yRE45?=
 =?utf-8?B?VkRDaVpSaDliSVFJbGs1bHZvV3A3aDBhenRYdGUvVzNiWlNodlhMK0JNeU9H?=
 =?utf-8?B?ZU9xM2FDRVVYTmlMTkR1bzlQOHRMS3dwa09pTDlyMjRWazZ5M2hoQVE1UTl3?=
 =?utf-8?B?U1kyWnpsTWhBMjJxeTBDZlZ2VDB4d2d4aXdndDRqT1YzSHNTU3ZtZm1oaXFk?=
 =?utf-8?B?R1JuVTJ3S28wWDVtUytEUXBuUjVtbEQ0dTdRMjBHTmNndU5NOVMyL09OZXh6?=
 =?utf-8?B?T2Uwd2hVK08xV0UvRHBKcmh2czNUVVUyQXJFOXBFZmFhdDJVdXhZQ1pWVnpW?=
 =?utf-8?B?bUt1TklDVHlTeHkvWlN0ckkxUE9BMHd6Y3BGMGthWitmL0QxbStIZDQrZ0o2?=
 =?utf-8?Q?PPwARH4Urq/B+?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bGk4aGJsMjRJd0lvZ1RCSm54ajcxNE05MzNTbFJZZXNsUjEzQUZWbmpSbVRQ?=
 =?utf-8?B?bStzeWJxc0gxMm9ZM2dLU0ZQaG5rM0E4QXowSlR3Q2tUay9kQXp6eGpWcjlD?=
 =?utf-8?B?cVYvanI0cUtEa0pqcngrc0tOeEV0dndZbDQ1d3lielArY0dkMzdJKzhSbEZF?=
 =?utf-8?B?Q3VvS1JlSytDUzRDNmtuUGNyNmgyY0sxZU9CWjAxS1VaOUdXZE91R2hYMG5t?=
 =?utf-8?B?djExZlVJMk9Oa1AvMHF2dzFZSTQwMWVocWRCbUlLay84MHZaVHBXNnpMbW1l?=
 =?utf-8?B?MVR6UXdWU0NaTG1yVFlPSzk4M1RhMmVFMThXejd2aStoMVNsSElndFdzWmpi?=
 =?utf-8?B?ZEMvZ3JjY3hmVDNXdytxWEk2cEVnamxDcnJ6MFg0ckI5enl2VVJXVzUwdXZj?=
 =?utf-8?B?ZlY1VVVFQ2hZOGxSQjVaK1RpV1hTQ2RMUk03aUF2ZkZJVWpMZC9sWWUwZFVO?=
 =?utf-8?B?UVNGelEvdzhPamRMaktSalBNQXkxQjJCQWYyeTFQSUxrdUJHYTVBQ2crdStz?=
 =?utf-8?B?ekx6dklXQVlCRlNUdVlPUi9nNDJRTXJCK1VWbDRZVEJ6NnNaUmlsdkZPbXNs?=
 =?utf-8?B?RHV1MjhkczJRT1BCVTMrbmlIT0UydkVVZXY2R29DUGgyeDJJWUxoT3FCcFMz?=
 =?utf-8?B?b0JNSUorRXdxUm9vZEVaTU95SHFPTWtvbGZKbUFxeVhvUW91S3gySk1vSk1E?=
 =?utf-8?B?WVZaSkROL1V4UHRZQlB5ZnF3SHpGWnpOakFRQWJ0SW5GSGZhcGJ1aHdaTmRv?=
 =?utf-8?B?aXFuWU1YRU1UTXpsMVkzMm9IOXBlWUkzbnBNN3p0Z0VoMTM5ODVlTnkwM1g1?=
 =?utf-8?B?TXlKdGQ1OWk2TzUvVkdxZklWNjAvTGNaQ0lKRENSNm9xY21HZG8zZVNKYjU2?=
 =?utf-8?B?cWZuWEw5bWZqcjZiUjBqTzkwMC9yQ0xHeVBDWWpSbms4RGwvcWJHRGF3N25S?=
 =?utf-8?B?ZW8xUERtRUdBZmwrbUw2TVIvVHRQcnowRHN5eXFKK1V4Z2owVUxQTFdIUDNH?=
 =?utf-8?B?MVRmVXBEL3VqOG9DRDIwemUra1M4dExzZTgvNFVNb2RDMlFXcWVEaXF2L0l2?=
 =?utf-8?B?MEZHVHk2K0pNZXlPczVLYXpnWlhmUWVVRnk2anpjWUpSdDRkZnZCSFBrMlA0?=
 =?utf-8?B?RDcrczhrRjd2b1l6WTZtZEo5UGZtSHBLRzk4V2JIY2hoeFRBelcxUjRUTjcx?=
 =?utf-8?B?THZCKzhqd0MyUkZ0ZVhpQjJRcWlLWE8vMCtHVk5SckR5YklTTytjbkpPdW45?=
 =?utf-8?B?V1RaQm5yTjF1MWNFbjZTM2ZXUUpQQmwrNzZraVpkeUttVGFMbzNzeWhIbGFN?=
 =?utf-8?B?NE5GZi9qcnZwUGVKVlJiU1JFeWlhNUgxUUVWbmlBNEp4VitpQkE5RExKcE0w?=
 =?utf-8?B?UllaVFpqeTJDbVdUYU8xYldBcGxEaG5sbEl2SWpiQktLRUtyc2hSM0k0dHRI?=
 =?utf-8?B?aUs3MzlEQ0Y5KzQ0aXAwTitLYlB4bkIxbzAzdkdjUHdZVENjZlhVbGd1WTcy?=
 =?utf-8?B?L3F3bEY1MkluU002VkV5L29kZEg3OXJGdGZhM1lnSkVmRkdSeDFNMXpwaWZu?=
 =?utf-8?B?ZktYeGU4UVNZeGk1Z1RNZ0dRZm9wQmlMYUpYVy94NDExcTdTUi9DVkw3Skkw?=
 =?utf-8?B?V0RIeWhWWlB6Mm15NGZVME5hdWU5RVRQWndtTDlLaC9lODhMaXJqZmRoZ0Zh?=
 =?utf-8?B?RC95eW9yTnE2VVpRcUdMcWVUSTFPb2dCTGxiYnRlNk5lVXZGR000SnY0V0xk?=
 =?utf-8?B?eU1DUnI3VmpDMm5Lb1N2YmlKWjhjemhPSU1aNkhIUWJkOENMcDhzYitVS2Fp?=
 =?utf-8?B?clNQb1c0M3ZHR29KN3FJYXlvM0F1dUxwVVpLY2t3Y045MUg4clNTdTlqUUJk?=
 =?utf-8?B?V2RBVXVCbHkyK2lRRE5jaXV0QS9pb3JLNEh4V1FuTVZUdUVIaTRnOWpVYktF?=
 =?utf-8?B?eXVLbnNQaTNLejUxc3FSaU9WTTA5STVCYytmV212NkxIWkZLU3VnQ240Wkto?=
 =?utf-8?B?c3k1eGdLSHg1OFNGT29UWGxZRjBmK01yVWVvZFF2UFB1TlQ0SnN4cENxNGZL?=
 =?utf-8?B?VUQ0a2FpbXFUNUFrNDFUaStPWlIyY2lQb2Q2eXh0cnZkRWtJL3RQSzlQQUx4?=
 =?utf-8?B?ekd6WDB6Y0t6dCtEZEw1SGRJeFNOMmlCbkxBeG93WGRvQmRqMXcvRmhPMndV?=
 =?utf-8?B?dFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fb989fa-ec68-4560-692b-08dd41307e4d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 13:17:49.1632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: igZuEAFg+sSthDWBITSegrboj8Ct71d9ca8iK59+L0IYWLSvLxbx9exjbAlc4AIqwIp8rDmhXk13K/+NsH5CwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6137
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Jan 2025 13:18:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17710

From: Jan Kiszka <jan.kiszka@siemens.com>

This specifically fixes riscv64 booting of swupdate images.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kas-cip.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kas-cip.yml b/kas-cip.yml
index 1c868afc..f653b9bb 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -22,7 +22,7 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    commit: 37cb017a0e63f9cc26c5ff1805190a95cd0cfad9
+    commit: 09305ffad6d86fc63ec7ccb4f1aefb4ea488e9c2
     layers:
       meta:
 
-- 
2.43.0

