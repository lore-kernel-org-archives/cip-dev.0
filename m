Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ACA3C678DC
	for <webhook@archiver.kernel.org>; Wed, 11 Jun 2025 15:00:41 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.17])
 by mx.groups.io with SMTP id smtpd.web10.310.1749654032851702050
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Jun 2025 08:00:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Pd/TqWB+;
 spf=pass (domain: siemens.com, ip: 52.101.84.17, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ahtzMGnIuIYZSVIZyYIOZwCqkvlEhAtBjg5SlCyp29lNkE4hj3d44xZRCTZM0DQRgS2ds8ZVfhna4+czm8l6iHshWmSa3GW/ugNvhXd/GjSZvRrnd08EocwcS9ZqIeZeW0bL7jw0UXV/MxKlObJ7kqqbz5j3Hrf2jJeJ54GfXqK0twgPZOG7vNUg0I2CzZ1KCd8HIpr+bbBYPQ3BdhKPMURpH0Bur2SnvF1OV0580Hke+iJihyuameXilJ49/U4lM/VrKiLznotAkN1LXmhszUpffrXyBbQiqnVAjirfCQ76oN1q+EM4wsC9LC5M9ZunlLVsDijhBDxLdmeECS/oiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yjoa3hpsyavaNy8IEqKEwFoVVhvIsN5qbvGCjYRsF1s=;
 b=uBRcRrC82vZ0kZQiI5i4VqcToerM5kfn80uTs4X/J2dip8MaSm9bsGHN/yX49U8zMnEJXOwIMKzKn8EGhwZpV6eh90Zx6XvGSsVMfc+ng+BwVBKZFhfK1tpDE+HK7VpzND2JRmPHc5472pUzIOEy4U3Dhy4Y1CRzmiPFK9toLvVgnbg/GNrmSXqxuZ3xRLCgbzN6/7O38Y2zevpXYMeCG7v+nU5cYOl3xXa9Je4PMpTLT4snB+67U0IkxpCAgU5789oZUa6ou/6JYe2MuMPVdYDMCLdvR7Du4ozUBsDZ4/gN0UZdLX0ON7AhJ3geS9zSDIsfWQaQZuvdW0dLFoxbeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjoa3hpsyavaNy8IEqKEwFoVVhvIsN5qbvGCjYRsF1s=;
 b=Pd/TqWB+G1cUG/vYLOZwTuoWI3odbiQx+a5W+gr7NuGGN2IU7iChX8o4lG9T4lrajInRLHa4vsA+JGkmT63B+ThpIsdc3ezqlVSyLFKSWnKMFbaKjJMaqvde3zUWkJcN7WIC84bKOQftVdrPCFwUbDIdhuTWo2c0xtcQgJ78K5+kn3YMO2JnGuih7XTLUq+T9cNHGJXY578jyG9sE4iBaMW+6yMmhpwfmr3fumwAxrlaTyhFvFZ+/vYjpRKhMXBBc16EuUwticZyo4j2Ou21kg7uyJUcvn2e838MlE98drUmyR1htE5WVOk32wOJmEHApJvWkUoRybVmeOA6LwcZ5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3577.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:139::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Wed, 11 Jun
 2025 15:00:30 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 15:00:30 +0000
Message-ID: <873b1039-c54e-4539-b710-17a36a62434f@siemens.com>
Date: Wed, 11 Jun 2025 17:00:30 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] Kconfig: Allow erofs also with kernel 6.12
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0132.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3577:EE_
X-MS-Office365-Filtering-Correlation-Id: 9feabdef-c881-41ab-5702-08dda8f8b568
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?R2RNV1RMdURtSTNsQVROU1BXajJnNEZ5UFFMSTFMNXR6M2RHV2NiSEhOcGg5?=
 =?utf-8?B?UUdXc0tRYjFXUjZyekhERXNERVJVMVBPazEzZjI2OVAzWFNiZUUwQm1YMlQ3?=
 =?utf-8?B?cFFMUEZIZ3F2M2FpdXc4MElIZDBPNGUwcWVmemtwMzlxc290b0Q5b1prcVVR?=
 =?utf-8?B?SFR2ZE1IUittQmpTSkpzaStHT2YycG1aR0tBdUdMR21FY2NUYk5xTjRNTnRk?=
 =?utf-8?B?Y3dEbVRvbzlDN3Z1WFFobGptakhQQ1pjQ1p2RmljckJPVXl3QTNxcGViemp0?=
 =?utf-8?B?SFhHQXdWN3h5QlZkK21JaUpJZUVCOC9oSlhrNk9QZU44RHdwRkdUQktHS1Mz?=
 =?utf-8?B?TkVzZU1TNnJBdE9uQjBVV1hzSTI0NUdMaHdydmRkOEEzZ3k3MWZQVC9WS05u?=
 =?utf-8?B?RXhQZWUxZCswdnhvMUpQUU16eFplZkZENGFtZGh3RUdURCtCVVJLUHo2TWRQ?=
 =?utf-8?B?eHhhK3FhaHFFSnh2Z1ZJQ0U2bW8zbklYcUVRNnMrOEN1US9aSnF1TkxneHpQ?=
 =?utf-8?B?eDAxakhhcUx5dGxzZVo0MVpOOW9nYXdoUUFKaUY1Z1Z0bjZvb0Zac2NTWGtL?=
 =?utf-8?B?bjdseWRaa0txVWNEOW9uNmFPMkRFVkhiVXFZb2JVcjdhSDhLbGRDaVZ3eDlx?=
 =?utf-8?B?VXhJTnZFdlNYeEZCUk9odW1VcGhuQXF2QnlFODFCZndjY1pkNkVwWFQvU2Er?=
 =?utf-8?B?SnZ5RTVJa3BzSjVoR3dFMllyTmRMbnp3cWZFWnFOeitFZEVGSXcvVCtQRGxF?=
 =?utf-8?B?NUhOZFZCUWtsWld2NDA5UzJjTERQMi94MndRb1grb1lwYWJBU1htTElYbmNK?=
 =?utf-8?B?L2NpdHl4LzZlNnFPb2R6enVJdVo5VVZTK1NNaGZKSlFaRE1xMkJvK3kxMTl4?=
 =?utf-8?B?b3laK1RmVjVWYXU0UGxnVXptTmEvRXYydU8zYTB4MWlNMFpEc3NqNTNHUlgv?=
 =?utf-8?B?UzZlMytuQ1RiVHRSNUloZDZlblc2ckcrcmlkRmdTamczOUtubEN5blNwOEw5?=
 =?utf-8?B?ajVsVWkxRUtnREVpNzlqT0xqaUhzczNzcTJwZktTYXhkdlJCR1l0VVZnRmVG?=
 =?utf-8?B?L050L3hjZGl0L2g2a1Y2b2hqM0ppN1dGNmpncjlSa1A5Szh0UThKL0pybGFq?=
 =?utf-8?B?QllQMlZBM0JXbUFsRzcvRDNyZWt5RnVvU1lENWFpbXZ5aDc5b0VFV2NCeHVI?=
 =?utf-8?B?SkVBSTNBMThrR3VQVWVMQzVNZmk2ZWxRVE9aaGI0czlzbGJWcEQrYjJ4MGdi?=
 =?utf-8?B?bnhZYkZpb2FEWkQ0dDUwYmIrbGlqZ3RWQUQyeXZJb3AxUFpSMC94QVowS2gy?=
 =?utf-8?B?M1o2dWs2R3BxcHZPaEFLQkVsTmE2QmUrUGxMQ01GNWdZcnM4ZkZVZGRPTWIr?=
 =?utf-8?B?aGdNRXd3OGlURGJVMWpUcWFTQ2VjNTVvQVB5ZnRGaGkyaHhCVDEwVmp2Unhi?=
 =?utf-8?B?bkdyRzNSMjd5bGtMM0UzUTdmYUZZczFhQnBzUUMzZlN3eUZNTk1DVUFISFlU?=
 =?utf-8?B?cS85T2gwUnpkNHlBbkJvbTljb1pUQjhyYkxmSlEzVmdzTWFuYkFBblJBWkNG?=
 =?utf-8?B?ZldCVVA5bWNSRDVwT1VvNlFvZGg4RS8rRkZPc2FibU9peHM5MHNDZ01tOWpY?=
 =?utf-8?B?aVFsQUtLWGplS1ZlUk9QQWVZWi9mNkQxY0JkQUpxd3FHM1ZGUUFiMGdGVUc2?=
 =?utf-8?B?L3kwYVA2N3pQVDJVKzJqeEs4VmxXSjllSVllUEZEclVFWUl0RjhvaUE4aWlF?=
 =?utf-8?B?MDBxWjUvTy9UYmtlK2xuL1pYVDZ6SVJMNmFVdlhjcG5jQWRwQmVSbnU1MWZm?=
 =?utf-8?B?S0M5eU5ONHAxN01NYU5LYXY3QVhGaFYxRG9BV1poQld1dnFVV1NEcFIvNDRR?=
 =?utf-8?B?SnpLTUFHN0w5VkNBN1hrcXQ5azRFRnpQa1JMaUFvMHJKOW4ybjlxTDVqWEFu?=
 =?utf-8?Q?rP6nbGpfumA=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RVkycy9qMjNYelFTMFBiZDZDMGdUeE1Ma1VIQjdaNUZHaGVUNXM5MHpyYit5?=
 =?utf-8?B?SjUwWGFNeWgwamhLdnNzaDkxazhUVmtPOG02ZUtIcytjdGR3SFVhRGF6RURG?=
 =?utf-8?B?RFFHdzVRZE90UFAzWWxDYStQUlI5Y1VUSjBSbllGNFpjQis5a1BjczRNWWNt?=
 =?utf-8?B?eHZvOGo4R3p4ckpBVnh1WnJxOGxMa0lUTXJUYndLak5EQUQ4aXpWVGgya29a?=
 =?utf-8?B?U3B6THE2UlZySTg4UUNHODU2bmtvRXNPcWVSYUgybi9jbklmVnhBaFd6SEdK?=
 =?utf-8?B?S3RxYmFaVm1HVVFSTGxVU2ZJMnNsUmVVMFh2ckJKQjZ0UzludFVhbjdIejd5?=
 =?utf-8?B?UU5sdUtyNDZhWFl2d0pscjJPV3cxdUNtQVpxKzlrd1hiend4c25NajA4Sml6?=
 =?utf-8?B?VGl4bzFUMlJnMVByZzcrOTZ3QkUrWmIzK3dGZXg1S3dyL2k2NlE4cU5hb1lt?=
 =?utf-8?B?S0NFT2dFa09oU281VXVrZ1A0aW5VTThzSEtFeXpRVWU4QkwrUHdEZUR4NlJF?=
 =?utf-8?B?amxNR2lRblNGT2VVOEFtYXRyZnk2M2VvbmdsaUFCYW1qS0c1YTFlR2ZvMnBL?=
 =?utf-8?B?dzdaTjZIRElkaG5BekF4T3p5d3luN1A5eWlsRTA5UGVrdDYxZnJqQTBDRDd1?=
 =?utf-8?B?a2d4aFR2cEIrQTlQS0VtNjRwRHIrUWh5ZlVtalR6cXFKSi9pYmRPTFpXYmF1?=
 =?utf-8?B?a3dJK1BLWkFPbmN0RXRxcng3dUQ3TkFUMnhsV3VYRk1CZnl1Z00wSzhwdnlD?=
 =?utf-8?B?WlRZSUxxdFRwTm9RS2xNTGtzbUFBRW0zcktEWVRKNmNxMERRZTJsdi9xTHlB?=
 =?utf-8?B?SXgvVlM4VnZzNlNpK2JmTDVkMy9laDJZbE5oU0h1TTdjaVBwT2hyeXFiem1G?=
 =?utf-8?B?K0dXOGxRUUFWZXF5aFRWN25hMFNORUZXajZtcGkzeWcwMk9ZL05jN1J2Rmoy?=
 =?utf-8?B?aVZyeXZqdzNSYWJyRHB2dDd3VlBaOStOODVJMmpOTXdTb0Y4VStSc2lFczN6?=
 =?utf-8?B?OFVZZERMdUxBNTJuWm42ak1ZVEszdTVJc0UrMHkwSXorUGhLZGdnM2ptVkVM?=
 =?utf-8?B?S0VVU3dvODk5MlNNbjZ3RElmeDNWYnZIWm1IZFVvRGxaNS9qMENqbGN2K0lL?=
 =?utf-8?B?VVZ2K1VnY0RJNTlYWkJZZzIyODlWNlBGNktwd0d4K29lR21NYlZpSURwaXMz?=
 =?utf-8?B?M01Qd1lPampvVG5zY3VJK1d3OEFlT09VNmVFcWszamU1SHlIQVYxZEJ1czdL?=
 =?utf-8?B?cjQ3c1FwVUJxZnErY2RRWVIvWnVIak1EdWsrejN4ZERMekpxMWM0SXVGMnVh?=
 =?utf-8?B?YjY2NkVUaDR3QS9XVmxMdDVTbDhrbHpaOWhZRHNhOXZVa1ZoQ2dBc09DaEFD?=
 =?utf-8?B?OGhiaElmR3JCL3FUNVoxMTFJUVI5QVNuUnJFWGM3SWhCNDBCWDJxNERFdWZp?=
 =?utf-8?B?Uzc1SkZXUnpKY1ZnZ3R5YjZPL0R0dmhVUFhFaDFsZGg2UU1SNGYyV1NVYldu?=
 =?utf-8?B?NTJOM1dON2hrZWNJd2tlbjBqZnVCUzltMFk2K1BlY0N2QVdLdGZXVjY0WW5m?=
 =?utf-8?B?UEZua0RaRlRuS0RMY09qOTBLWUZFT0VNZkxyUWI5bk8wOXh1ZWR3ako4amwx?=
 =?utf-8?B?OCs1Q1FUVFQyNkRmeC9LM2lXTkZ5d3ZORXZuTldvNnAwWVVCVXpHQmJrVCtj?=
 =?utf-8?B?TS9SZmZDTldOcXZhOTRBeFcyR3pGTDFnbUp0ZFNEUGEwSTVHOFlhY2FPb0VY?=
 =?utf-8?B?WEd2UXdiWURvMGJQSkZTUVZZeGNoNDJId0s0NTN3SnZsRVUyT0lJUDRQajVR?=
 =?utf-8?B?OVZzSXhlMkJFcDlTSHJZNWR4akwwRHZoSlJndFdGSHhsaW9qSFN1a2k1TDBG?=
 =?utf-8?B?cVU3YzV0dFNSRUtWelZZWC9lUDFYeWxXd3JRSU9IdjJMYzlMOXF4TEp0Zmd3?=
 =?utf-8?B?SUY4YmNFWGJiWDFNcHhmMjJma1pxRml3dDlkUmc2enhtVEJtWm5QaXc1d05O?=
 =?utf-8?B?ZDJDODlQblNSbG0zNVlmZ3hCMEt2d05OMU1ua1NQenRvRlF4d082eG1JdW1V?=
 =?utf-8?B?L0sxcXorWlVJcmNKY2VKam1PZXpiZlJiN0hWa2QvcURBWnhtS3kzaFp4UTMv?=
 =?utf-8?B?VGFEWXNGUnBNMDhUMTlRcGpJeEs0cEp6MEtwUEFEanU2WkU2OW9aOHloOTFK?=
 =?utf-8?B?aWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9feabdef-c881-41ab-5702-08dda8f8b568
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 15:00:30.6562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uCjrpgiufcD+3Dn9Pj+7vuIAC0LLSo6pIppXo0nZZlAHC0Xe4CGT4s3OFGZgKmF1YWiypc2k47gqC0Gv46C8Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3577
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Jun 2025 15:00:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19031

From: Jan Kiszka <jan.kiszka@siemens.com>

This was forgotten while adding the new CIP kernel.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Kconfig b/Kconfig
index a9f28fd2..582ceddc 100644
--- a/Kconfig
+++ b/Kconfig
@@ -230,7 +230,7 @@ config IMAGE_RO_ROOTFS_SQUASHFS
 
 config IMAGE_RO_ROOTFS_EROFS
 	bool "EROFS"
-	depends on KERNEL_6_1 && !DEBIAN_BUSTER && !DEBIAN_BULLSEYE
+	depends on (KERNEL_6_1 || KERNEL_6_12) && !DEBIAN_BUSTER && !DEBIAN_BULLSEYE
 
 endchoice
 
-- 
2.43.0

