Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A821CD5BBA
	for <webhook@archiver.kernel.org>; Thu, 13 Nov 2025 10:21:47 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.1])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.20565.1763029297522727144
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Nov 2025 02:21:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Ry/JEeT8;
 spf=pass (domain: siemens.com, ip: 52.101.72.1, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JnFT4LngRMPj/EF1LQcyRQINri8VFiacpnSdlDzYvO36jao7qadIwlJoWLnMZCzhxaqtGPS2BP9SFw6mJKn0g0I1uQpuCDtNs1OgIIMifSZe6FzoB0T/reYdj+7p827HldVBluQV7/DXTWN8hwm3kND6GbXf9kEpiOPrEjuM5TQOTQiWUcUw/ku6+TgiOfnQFrDcpoq8xZeZ+xvhTIWjMdJ47j9g64qypLNIh+jj4XyRGwpuWoQpqtHanvq0BmJ0reVPcaDZx5Ca26/ffJbRKFsE5ruRv1J6cEQCT/0GaEhqcf6GgFm/Bw7a2EhdmjDLu3u/XsMWLI3TljTOTxFNAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fIGB5+A4/ElxphC4R2N6QMZREQ8rJTfOGKU1BxgvtM8=;
 b=nLRyhTBJt/FymrNXmYPLumfmCY2mFLmxQW4M+tUPB7geVMVewLCoN8kvSbJ3omR4qsMxuGQ7FB27eb9EVLm7qhi+Km8Q7xqgke7For1cWcdsqBTp2S/FfaoKdNgU3NSPOyRn9fiwjE2Eg2phb8u9ptJxb7Iqq5N4R9i+lsEnhyDyVZWPeN7VD6I1Z1M2ZEIe5+qqgzWlP4gXmEW8cAhFrJNnWCuvPFkBf6aJ3uVZdld73WqVgd6a/A6B6InyZSPrxxP6nYzW1YRob6qysJ6meMR3MJc/zUbzGR9hHyWma0sLCuiiViuo5kUrjl3514PD+IKwDzLqh5sR15Ai055fFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fIGB5+A4/ElxphC4R2N6QMZREQ8rJTfOGKU1BxgvtM8=;
 b=Ry/JEeT8oLxFmrQ9nyZxdbVDcI0X5i+HLmYl0dwXUKLc9nq2FgsnTssLrEY15Dv3LfsGfOi+1GVQXtVOybhjorsmLlpOiJuo86ove7yNFymXcNtttb7oZ4Cn4YSzBqYWj0bhODYfFWd2fN+9Qc9VTmh97lG4Wgj9XFbOD+NCVwodrgoMSja7hTSpsDOwU4shtvjFEmCqGTw4ULu3/JTroOMLw2AxdUQkdWIVOCJgpOKimubwglnsyLdWXoyaSeUUKvgEkXg/ypNTTlyOrcl1vFetAAPpuR9qsjvlMWPNywNWWQsNIBQCdftbwiWwK37ehILzp649+HFXL9vAlO3JtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7309.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:447::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 10:21:31 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 10:21:30 +0000
Message-ID: <a7504bc2-d148-4275-997f-e94d2cf88cf6@siemens.com>
Date: Thu, 13 Nov 2025 11:21:27 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH 1/2] initramfs-overlay-hook: Rename
 INITRAMFS_OVERLAY_MOUNT_OPTION variable to plural
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P222CA0012.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:610:1ee::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7309:EE_
X-MS-Office365-Filtering-Correlation-Id: 18dd7879-089a-4ced-4ca1-08de229e69aa
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?clZlOUExdkhBamZKc3FhT2N6ck45STJjTU5ZSE1uTHFSSEJXWjNjOVpZeERE?=
 =?utf-8?B?cUJTVlJOeG04cTNHdzA4dXh3ak9yWDFHME8wLy9oQXNCWmRkc1VscENIT0F6?=
 =?utf-8?B?NEhSelJLSjZab2JmT1cySXRxMlIxdGVpcjJzY2VXZVIyQ0owMCtDQWZYZzdS?=
 =?utf-8?B?cXFndzFlZUNiNU11a1RHVHlBemYxUE8vMzZnbVcwZ0VLNnNMRFhqUFpJb2ZM?=
 =?utf-8?B?SHpRZENvVC8rOStJOGQzQmRxeXV2RnZyZnN6ak04NDQwUGZYSkNTMWlzbHZx?=
 =?utf-8?B?a1NiZVl0c1Y1R2JjcnIvK0VDVnRjYTlJQlIyeEVVQkQwNDA3a1VXc0tkTHhz?=
 =?utf-8?B?UTBYRU5OMXdvR1NVdTNORW16cE84ZHd6VmoyMDdKS1hzR0ZwK28zRm1LdXJD?=
 =?utf-8?B?N1NRZWFUTUNUYlVZakRXdkJkcVFsaWwwVXA5dVhkajZXOFFianFnN2x5NEpS?=
 =?utf-8?B?eERyUEtwTWpHQTFtaVpNT0g4RGc2bGFoL0ZIUXUySTZCSjJKTm9CbUZiR2tp?=
 =?utf-8?B?RXhkdlBsZENiK1MydXdISUlLWnBwaHpWdnRrYlI1Rm9nc09kc2U0ei9aV3Yr?=
 =?utf-8?B?bytrQjdaYjJONTdLQTI4NTA4d2VRK3B6b05KSHNJVjNNeE1pTklhUnlkdmR5?=
 =?utf-8?B?WU52RStzV1lDNEw1RkFkbnJjL29rNmNGWEFrSHBJOWU2WVRRbVhEMVVoSGI0?=
 =?utf-8?B?eFh2UHBUNUUxZXM4b2Q0N0VZSG9YbUliWlU2TjFMT2J3M2J0UFF6MW0wUXIv?=
 =?utf-8?B?TVRnb3d6SFBKVEEzVWcxOWdhd2pMamQ1Z0xjZE9JU2ZSeWtzSFN0NThuZ3l1?=
 =?utf-8?B?OWxHOERCa3hCeXRacFc1dHhtbXptN2xlYVF4Zy9lUmhvUzlSWWF0Y1pDWFZM?=
 =?utf-8?B?ZjdCVDlURitrWmIxc2hVSURiZ3UybDNpUFozZm10UzYvZU45a1BQRDk4M2pq?=
 =?utf-8?B?WjRPT3hyRzFBd2phNTRxa21vK0ZXRWgxUlNVdWZnWWJkUEsxU2lQQlhkcGNF?=
 =?utf-8?B?aGRsTnpHc0VlOHY5TUV3STYyS0dVUWJzVllMRnlKdnQ0RGh3OGRnM21JczY2?=
 =?utf-8?B?ZzhCbEd2YzVUUm4yUTBwYUZRekluWWE1b3FpWDBWOU5zekNlOTFGR0U5YmRr?=
 =?utf-8?B?ZFphbmJJN2pDU2Y3T0U0VnArWXpqZytFaVFHeW52U3V1YWVjUFFvUWFsRkZC?=
 =?utf-8?B?bDlyZU4xYWZBTWlvSWpUYW1vWnhwcnhEZXBhbU80Uk9kTlBYVFM4M2xacTNo?=
 =?utf-8?B?d3AwOVVaSjRqbUJaK1EwOGZsek5pM3J2RjNNQWY4OGtBYS9YRitYR29iRFdp?=
 =?utf-8?B?eGlKS1V5cWZvdjM1ZFU4K3RCTVN1SlR5STVLUlF1blpEUjMvVkZzUm9qclc2?=
 =?utf-8?B?eE5Vcy8rbHByUEtTSzB6d2duZHZKeXEwMVdpQ25kUDNHRGtZeEordHNnQkda?=
 =?utf-8?B?SEkxWlhCTzhRUWJhMjQvUVJ2TXdCZFJVNGVXN3VBSzRUaFFCNHVtbk1EeWZU?=
 =?utf-8?B?c0JmWXdsZEN0cDN6eXdkMmVST1RyL0VDT2ZLVXJ3KzlvMTZUd3c1cS90L2Vk?=
 =?utf-8?B?d25PcDRBbDZPZWtjVVZUV3AwT0RGZTlCMEp4UHkwMjlramZaU1RoWVhrbVJT?=
 =?utf-8?B?cFpzNFFMcFZLY1hrOEV5eEVGUk1kNmFrekk5bzFIT2hvUytlWUdwQ3c5cVpt?=
 =?utf-8?B?QW9BTnVrL0x5TUpCdFFUQ281bGtPUmd0cGZWeVF3UWVxR01qaGVianpwVzM4?=
 =?utf-8?B?YTgzT3g3aVBNampjV0ZJRFZFUUJPMnlDb1dOQkhCR1hEL1BDVXVWc0JlTnNt?=
 =?utf-8?B?R1U5VGpJejZiLzNwZHdFbmJsakhMWWc4MCt6bksrQUMvMGhlT2U3NWR6Mkcx?=
 =?utf-8?B?dHBXQzZqbXcxaVk2TlpDSmZidWtrNzA4YlR1NzBBdW1CbWRhWEJnMHJYc3Er?=
 =?utf-8?Q?pPL1qpRmik7YqPhXKNBOnqMgYrTgu1qQ?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ak41ellqU2h3SXByWjRvUHVjUnJLMG5TWHZQaEtVU1BPVkNzZHZBU1lGU1Ns?=
 =?utf-8?B?OC9YUU50NTZ3WHBYYit6K0d4LzFqcElGOGJLMVhyYjB0U0JkckREZUtPdUl1?=
 =?utf-8?B?am9yUjNlS2ZLTnFGaUR6SVF3S2RISDV4Qzg2RkczQmhseE1WMGJ3aGVTdkNr?=
 =?utf-8?B?RDdhRE9BL2Q4dmpQcmFVellSVzMyd2JwamRDWUlzS0RJdnNoUit2eE5oZmJ3?=
 =?utf-8?B?ZnZWV0pYb1N3TGQ2ODkxRnZxTWFWNlhVSWcwMDJFRWM4ZmpzT3hCL2RYTHlZ?=
 =?utf-8?B?RU5zRFBzYU9zcVJDQlowWDlWNURqVlBTWlVMQk5ZWDZyRUtPUnJUeFVFa055?=
 =?utf-8?B?RDU2d0R2WjU5eFpwdXR0Yk5VM3RMUGhuRHFGSVdKL3lNVWFkdklXNWpDOS9M?=
 =?utf-8?B?bWV5aW9CWldUdkFQRUtFb2NxRnF4SEQxQitYcm9xUDVuV2dVNWp2RXRJckdC?=
 =?utf-8?B?VktXRHNEUy9VM3BkNU1XWUtuTXd4Qzh2TFMrUGNodHdJcWdOQ0kvUnlJQXpH?=
 =?utf-8?B?WHJVeGV1YnlmVy9hTTNMMjNBVGVyZmMrajRUSW1KcnQydU8rN3dBNHVGUHRp?=
 =?utf-8?B?N2xaSnZVdVNDWnBhM3BndythbXFheW9DSkUwUENkc1NnZHlKSlEwQVZqK1VC?=
 =?utf-8?B?VkpSVzBXMUlYbC8yd3FPNzV0eWpJK2t2eXNkRlliRGJxTGhtVGJ1N3lUVG5a?=
 =?utf-8?B?TDN4VzltNy9FRk1wZHhtRVBKU3JJcDdVa3JHQ09YSm91M3NxMWh6Y2gvdE1L?=
 =?utf-8?B?bXY0bnRmR1RrMVB1V3ZEMk5salVTZEM1eitGQlVVNUZPaXpCa2hJeEhWU1NJ?=
 =?utf-8?B?TlF3UmVsQ09XNUtNci8rdU43dDZXWk1wakxNTktuNEZhUTJsbHp2TDFZd0Z3?=
 =?utf-8?B?VjgzUW55bUZ5dTdPVUdxU2l6T0Y3Z0MzVTIvY25KeEZaMk9NSGxId1hNbi8y?=
 =?utf-8?B?d1p0Z0M5VnJ5SkxQanhVM2VmZVF5bXU3OFBxMWV1WnZRbS96R0ZrbVdtSWM4?=
 =?utf-8?B?ZzlScWpEcEc2eTV6N1Q4ZzdwUHFoa25pZHFzc1ZaS1A2TldRZjdxVDZFMWFk?=
 =?utf-8?B?TFZERTlqT0ZlQy9KU2hHM1ZlL2xFVzE4ZFVCU05WQ0taaURZQVhLSDU5TmEy?=
 =?utf-8?B?a05BN2FLVWxJWGRjQ1dETXprRTM1alRsUW5LNjRwNzRCY3p5cnB0SkdGMmFm?=
 =?utf-8?B?SjJMdGxsMlRTbXhncXQ5dHBLOU5ocE5rcmNyOHNPa1RCekdMS00xdFZmbUhs?=
 =?utf-8?B?OURIVU5ZOWw2NU5SbUlWd2czcGdEUHNpRVFxTmZYR2NpaUMwM1F4aDUvbDZX?=
 =?utf-8?B?UHluZEhKUDBsYi9BS0JaeFlQOEdLQ3Fac1VQOStKckJObVl1Z2FGcVk1aS9p?=
 =?utf-8?B?aEhwYjVrWXUvaThnbnBkL3phdnhTZ0l1V2cweTZRRDNiMmlZRm1NbXExZzdV?=
 =?utf-8?B?MzdqTUFRNlQ0UkdkaTlOczh5R2pQSUlGQ0EvOWFtZmI0cW11ZlBoZnZ0Zi9R?=
 =?utf-8?B?WVliSUlXTk0zNUo0YVFsMnFzc09KdDFpeHI3Wm9CNUN1MWF2bWc0ci8zNTZs?=
 =?utf-8?B?eElPMFRmajNDZWp2OWVYMy9Tck9yTVpITEdqMFJyV1RSVTA4QkVzMzFVZ0lj?=
 =?utf-8?B?dVpWd0VFUGp2dVQ4cjVGV0xrOGVxN01vSkMwdmxNUmJjOUZXM2xsTHljdHJy?=
 =?utf-8?B?d1JOK2s3a1daTXpDejdvSzIxWGNKTEdMRVYweTZITGRrNGRKakQyTVhjdmJl?=
 =?utf-8?B?SEpRMEZaSnl5bGxPSDA5MlhKN2E2ODFIbi9iVjhvZkhSaDhwMlI1REhlNmN2?=
 =?utf-8?B?eVk1aWI4OHN0SVNwdlJPZmtxTlFHbytjaUtBWWxtSVV3RXhMMVhMeXFYYUw2?=
 =?utf-8?B?eThudEVmais0T1RvWTJIQmNlOUN0dnZzSUMrOGhWUGRMSGNGUVJSSWxKRFMv?=
 =?utf-8?B?b2lheTgxNDBXeE96ZzBiOVlGbmNVRW4rU1hGMVFCWG5DSVo1U0Y4NW4wT2Nq?=
 =?utf-8?B?Wko3TVNvK3YwMytXdlJ6MXFqTXFPN3V2NHFrZ1NHMFVzZmwvQVp1dkVqMmRX?=
 =?utf-8?B?bDBHRXI5bFJ2L1pPWlR2c0RsWk1NQ0xCTEo0Zi9FRGdMMHFyOHBOVnROWmdn?=
 =?utf-8?B?YUdlZmU0ZnlNLyszNUVGSnNmbkNlNDVoc0c5OXdJUTM2ZXpjaHZZVXIwV3NZ?=
 =?utf-8?B?L1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18dd7879-089a-4ced-4ca1-08de229e69aa
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 10:21:30.8458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gbW/vThADnEY6S3UKlRcd2VlBpMxEqAohhbY8DTkHfYhBJb+KATTggXZnzqzjMozIoGe+KE8yCeeQ7f777Iw7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7309
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Nov 2025 10:21:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20529

From: Jan Kiszka <jan.kiszka@siemens.com>

There can actually be multiple options. So make the variable name more
intuitive. Provide a smooth migration path, only annoying users with a
parser warning for now. The cleanup date is set to two years from now
which should be enough.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../initramfs-overlay-hook/files/local-bottom.tmpl |  2 +-
 ...y-hook_0.3.bb => initramfs-overlay-hook_0.4.bb} | 14 +++++++++++---
 2 files changed, 12 insertions(+), 4 deletions(-)
 rename recipes-initramfs/initramfs-overlay-hook/{initramfs-overlay-hook_0.3.bb => initramfs-overlay-hook_0.4.bb} (77%)

diff --git a/recipes-initramfs/initramfs-overlay-hook/files/local-bottom.tmpl b/recipes-initramfs/initramfs-overlay-hook/files/local-bottom.tmpl
index 71cc63c5..e296b142 100644
--- a/recipes-initramfs/initramfs-overlay-hook/files/local-bottom.tmpl
+++ b/recipes-initramfs/initramfs-overlay-hook/files/local-bottom.tmpl
@@ -16,7 +16,7 @@ storage_mount_point="$(echo "${ovl_storage_path}" | awk -F/ '{print FS$2}' )"
 
 if ! mountpoint -q "${rootmnt}${storage_mount_point}"; then
 	ovl_partition_device="${INITRAMFS_OVERLAY_STORAGE_DEVICE}"
-	ovl_mount_option="${INITRAMFS_OVERLAY_MOUNT_OPTION}"
+	ovl_mount_option="${INITRAMFS_OVERLAY_MOUNT_OPTIONS}"
 	ovl_recovery_script="/scripts/${INITRAMFS_OVERLAY_RECOVERY_SCRIPT}"
 
 	partition_fstype=$(get_fstype "${ovl_partition_device}")
diff --git a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.3.bb b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.4.bb
similarity index 77%
rename from recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.3.bb
rename to recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.4.bb
index a5b39d9a..35f847b3 100644
--- a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.3.bb
+++ b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.4.bb
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2022 - 2024
+# Copyright (c) Siemens AG, 2022 - 2025
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -33,13 +33,21 @@ INITRAMFS_OVERLAY_STORAGE_PATH ??= "/var/local"
 INITRAMFS_OVERLAY_STORAGE_DEVICE ??= "/dev/disk/by-label/var"
 
 # options to use for mounting INITRAMFS_OVERLAY_STORAGE_DEVICE
-INITRAMFS_OVERLAY_MOUNT_OPTION ??= "defaults,nodev,nosuid,noexec"
+INITRAMFS_OVERLAY_MOUNT_OPTIONS ??= "defaults,nodev,nosuid,noexec"
+
+python() {
+    # to be dropped end of 2027
+    legacy_var = d.getVar('INITRAMFS_OVERLAY_MOUNT_OPTION')
+    if legacy_var:
+        bb.warn("Legacy use of INITRAMFS_OVERLAY_MOUNT_OPTION detected. Migrate to INITRAMFS_OVERLAY_MOUNT_OPTIONS.")
+        d.setVar('INITRAMFS_OVERLAY_MOUNT_OPTIONS', legacy_var)
+}
 
 TEMPLATE_FILES += "local-bottom.tmpl"
 TEMPLATE_VARS += " INITRAMFS_OVERLAY_STORAGE_PATH \
     INITRAMFS_OVERLAY_PATHS \
     INITRAMFS_OVERLAY_STORAGE_DEVICE \
-    INITRAMFS_OVERLAY_MOUNT_OPTION \
+    INITRAMFS_OVERLAY_MOUNT_OPTIONS \
     INITRAMFS_OVERLAY_RECOVERY_SCRIPT"
 
 DEBIAN_DEPENDS .= ", awk, coreutils, util-linux, e2fsprogs"
-- 
2.51.0

