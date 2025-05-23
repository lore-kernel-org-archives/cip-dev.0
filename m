Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB10C3DA6D
	for <webhook@archiver.kernel.org>; Fri, 23 May 2025 08:27:18 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.54])
 by mx.groups.io with SMTP id smtpd.web11.43853.1747988834174683456
 for <cip-dev@lists.cip-project.org>;
 Fri, 23 May 2025 01:27:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=La7pUciM;
 spf=pass (domain: siemens.com, ip: 40.107.105.54, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q4eCk51qgzmm0yyzEJZgsw9W6DGv3ZEHwqbC7Q+h7NFbbKzfGRl6ZnfFGhZChFSdGVf0lbJ0lvXbBq0Dl2CfNuOrgb3SDr87qr/zrORkKMSX/f3c8ue6D8Jeq3Q+OD0R+Tc28/7oSzT+JV3BuirDjrbnLQhmLc3Yr3jK8Z9u/unJKjO01g1bsu+lmYhxr2zJXOoeLrbA4+znX/xa8FZ2Q26Kpmg7tbGP2ZJn9KbyQARpxvPP2wjtv+Zb9qlDN5zi5IYJqtWMSisd95yg+Obs0RQoWZbLEO/YjlGqnyecWRv78/4vbYr0WBl5X6nAkEP50kiTDde9vpWhPqG28n/LLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gh1KNUme34a7mLNF53uS+2F2nhCIrnXxBQb+Pq0kdh0=;
 b=YKbpsj4O97Wy16Llj/ByA24vgNVqBZwLsk3OCIn8Gf2nkqqlvnrb/FRcFeUQH5zHUTxab1fsuxLQAWak72I9CNnjuElNrw167BjsE+nKTuC1KWCsiPAH/gQC3uyCD8bsQXWno/dDM2G43U+dMDGPvtr+4WYoeB07rAnIH8gDiUSwzFqTLCmxbphunb2nRBwtbRazTc38crBDI3+7T04Ol7kJQFBvbusdryJhz8ZO7/PG58kIpQf7rPFTY9Fcw0gmFgajKnnSr5tp/gsWaJiDDWycNdbwy353HTsSFd1n4e8D988uj9vOb8bm/f0LE9z6Q6aSgvOd2iuclk1cHWshEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gh1KNUme34a7mLNF53uS+2F2nhCIrnXxBQb+Pq0kdh0=;
 b=La7pUciMAo+ITLLMmxYeu8vRN1Aw/5Gpsz6XNSjZs1/IpuD3KulOCtPs+KtbR0d99Ksm5I2/yIsRQW4DKjwwbitpq6zqkfQvUl0Rvarxhw3K3dVdhCRJtfTpUX57XAyXoCQY3KAOizJdrDYusxW7MrtUNfAaiwYE+tnfsYCcv3NFl5wTiXm+fdmkZ12HSyNYiyWjuQJ0Hne2QD7nXKr7SHmG/kypgZV5A4zJRjdqU2/5O2sM8yEgsvHmoAlDlfDCENL1iveVQ9SHB2A8W7nDu2RnWaj91u0rG8GD6aLMwF5Di6nzyfyZZN+W84aaRn9zCycsOdflEXU6PVTV5A549g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8492.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1e0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Fri, 23 May
 2025 08:27:10 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8746.030; Fri, 23 May 2025
 08:27:10 +0000
Message-ID: <845ce66b-a148-4cbe-83aa-71f5ce28f4e5@siemens.com>
Date: Fri, 23 May 2025 10:27:09 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] Kconfig: Permit 6.12-rt for RISCV
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0357.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8492:EE_
X-MS-Office365-Filtering-Correlation-Id: da17ece0-1937-45dd-0ddb-08dd99d39c94
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dUpYT3lHMHlBZ3BlZzdZZEhPdnliMTVWOUdvTnFUcTBFUUduZ1NDL0tuMUsx?=
 =?utf-8?B?SDZvdlhrVEJ3QmtsamxvMzdBalEwSExxTUhLMmxYZmFOKzk2WHBNVGxDYmZv?=
 =?utf-8?B?aGRMbFNLMzdEdXNTVGRPV1R2U2owbE95TFBnWjFQdTdOaGlzZTAzcmg5Rkh0?=
 =?utf-8?B?WXBJZ1pVVXhRVHFXQmlrblpEYytGbWY3NHVrQ0hwSk1tQWVKUHlhcXhGTmJX?=
 =?utf-8?B?TFhhL2hXVE4veW9UNkJEQlhIcVFJYjRWNUVZQlVlVXRUSlUyTzJxcmtRcW1N?=
 =?utf-8?B?RG9odTR1bS9RODdGcktDMGJGby9ZLzN6aHlKTEZjb1FISEJVRE42SFdFOWNN?=
 =?utf-8?B?SnRtYzdVOGVoM0t2bEg2ejQ5WGE4YnM1QXZudFhRcmNzVGh6NHZNR2h5eWV4?=
 =?utf-8?B?V0NRRGptOVdPTWZwbDVhNDlPVGdtbndKUFhZVFV3QUdhOTBQelRDR1VTbURU?=
 =?utf-8?B?QmtrSDRZZG9ZSkdScG9la0ZEWGJFR2x5ZHV2Tm5yNEx5SUZvRng3R2E5Sm0z?=
 =?utf-8?B?N2FtZ2xLUkpNamE0cGhjYmNNZ3h6QXl6UHlxWVdCOUtTQ0tZVmJUaC9QZ2dh?=
 =?utf-8?B?ZGZYZ0NPbEd4d285THFvRnNWc3VUaGFXM1d2MHFNeit3V0U1QWRERFhseWdy?=
 =?utf-8?B?akFGcWRhYk1JaFdWSDcvNVIxYUVoZTVvMC9mMTVVUGV1N3JxTzZzbHFrazlk?=
 =?utf-8?B?U29pY0JZcjg4ZUdtSkVpTnlYM2ZReC9RL253Q205TTBHTjFlUWJHTGdUOE52?=
 =?utf-8?B?Wk5ETk1HYkMwdDVGU1pGQjRFbHhCYXd0L1EvcHZ5NHRVSG1iVWN1MlEwaFZB?=
 =?utf-8?B?YmFhNm84SVNKU1htN1A2L012aytMWXNlTnduTkVMcWhLTG10c1J6ZG9XOTd2?=
 =?utf-8?B?M2Y0c05EOWlmWjQyeVJiTzA5c3U5clRlcjIyaHhHNys3SHYwYk5sSXo2Sms3?=
 =?utf-8?B?WFlwbHUxT2M1WFNSaTRqWFphUnlNQS9SREhLL0hXdVpXT2JDQ3E0cUw4aldD?=
 =?utf-8?B?TTNoWEFsdmNpcU00a01kR1p3djkrOGRjRTJGelJEeGQ1S3Z0ZVR1eVo3OXFJ?=
 =?utf-8?B?b2I5dFM1SUduckhDQ3BSQkkwTnZydGlSMHJKTWVVQ2pXNStHejNaM1RyU0Nm?=
 =?utf-8?B?TEtlSW1LNWxCVnBTSDdCeGVqais2MmdRVWR1V2xzWlk4VEpPNHlMZzIvM3lM?=
 =?utf-8?B?WDZIZmlkTGo0S3Zvd1IrR2M4b3F0YmF2N3F4emxJajd0ZmpNbi9IbTNYSTdV?=
 =?utf-8?B?c1lQaTZOYXJ0cVR0M2lFSXlhcG5jZHFHK3pqWW94d3AwMzlPWC9yQWk1cSs1?=
 =?utf-8?B?Z1A1TVNEQlpKNEZmNXpkbHNlaXFmQ0xSdXdsbUxyL0FVc0VhbDM4d0pxMi9i?=
 =?utf-8?B?YlVRZW5lMTRxVE1NQ2FQNW9MWkVDaVRQY3RiMmtTSzNMbTRtNzV4T3ducEJi?=
 =?utf-8?B?RFBjbnVLNUFpTDlDNGdMVFJaVTNSS3RSUGZaeS9BQWFIQWZJYVBmQk1tOXJ1?=
 =?utf-8?B?SUJRRExER0JSV1Jnc0U4VjF2b1c4eGtIOGNTKzlJVGxpbzZYdjJSVjQ2Z2tH?=
 =?utf-8?B?QnNFZUd6WWk5YTNhblhaVEFoRlFDUW8yclZESjZPa0E5cXdlZy9PeVU3SDBn?=
 =?utf-8?B?dmhZY3BiaUFWQis5U0pBR0ZRNWFVZkdNQVZRakRjZW1BWWluQWNqQUdldEVK?=
 =?utf-8?B?L1h3YVloS0JSMjFKY2VCejlpVGRjU1ptSFVRYzhZV3NndzIvWm1DNk5UYlB2?=
 =?utf-8?B?eTk3bEpMVXpFbjdKVkdwWXFISkYzeFVwT29rOStKanVvRjZDMTV5bGV3WERB?=
 =?utf-8?B?RE5rVTdaazVWSld6cnpmZzB2VEp1ZXlWNDVvdDVnS05aSkc0Zm5udGpsb0hx?=
 =?utf-8?B?M0RLTGZjOG1iQkdjNDlnY3B0MDJLdTNrc3BUNG9UcExUcUZ4ZlcrTGJ5WGVj?=
 =?utf-8?Q?Nj13AuiCGLk=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dnliOEhUdyt2R2tWdTdUQm9lMjZpbTlsaHFOcy9wVkt5Nk0waERtQXdGZ2tS?=
 =?utf-8?B?ZS9waHozTzl5dzM1UHQrMlphWXJXZ0xXUE9pc2JYcjJmZzdEeTNka0FQRFpu?=
 =?utf-8?B?dDFkZUhjRzh5K2VuSDNBSUZKRjlwL2p0MXR1TFFTNXdPTXN3Ly9sTjdsenNU?=
 =?utf-8?B?VkI1OHhmSUY5NldJUnN1T2k3MkJtSGdoT2tJMmxKdSt1Z3NJSkxJTGozSWVR?=
 =?utf-8?B?anVoZ0pra1NXc2NDWHZzM3JxOWl4azd1QkVOa2RWUms1cmRFZktHRDRONmVo?=
 =?utf-8?B?THpoMFR3djBMd3NpMGFVQjFidUl6S0QzRDJ3TlJuRlQzUkJmM0RPbC9HVmJF?=
 =?utf-8?B?OVN3cHR0TVVoRkhFdzB3MVJadFdiaHN2Zldva2FnUW1KZ2FMRk0ySEg4NXp2?=
 =?utf-8?B?aEZ1dXY1U2QvSy8wTWp6VzRiS3dtSHVvRWxzRXVpVFRZQUg5RFA0RmovUEk1?=
 =?utf-8?B?Qk9IVjlvWFJuQXRHNVYySVZSemhoUEhjcktZOTEvWnVGdkt2UERDdXpxd2tF?=
 =?utf-8?B?bUc5SG01WkhyQ2FkVEZyWmhXSzBXaSszM2hZNkVMTUtGUVIyakt6NGtuMjlP?=
 =?utf-8?B?bVQ5UXAyOGVvZ2FEMEplSVBoQU9vN1ZWbmVickhqL1o2cE9tL0ZsaXpGWERW?=
 =?utf-8?B?N1U0TUhqZkpnYnBMSlhHVjczTzNpNWNpSkozaEtDOWNjZks4RHNDQ3JpUVFa?=
 =?utf-8?B?a1pveG1LVkNwdk5va2lCbFkrMU1ObCtwQU1uS0xaVkpibHI1Z202cGdPNWdz?=
 =?utf-8?B?WjNHVXZqRG45VTQzVXdaS1Z2TlpWQTljQXJxcFRVWm1zV0ZXREd6OFoyVWtY?=
 =?utf-8?B?N2hidW43VzF3OC9pTjYrNEtMT1B0MjNWRS9qSzZiRFN2QjZPczRUclNQbVNE?=
 =?utf-8?B?Um1WOVlRSlFhU1dSWFQvWkhrbklTRlE1NlA5REpSK21Mb3VHRk9aODZ3RmRy?=
 =?utf-8?B?UjZic1RFYWNuTTA3SjFZMm1nWitoSTdwcUVwUWF1TXNDTUFmVEtTVkVVQ0c0?=
 =?utf-8?B?U0p1ZGNldTlnRjJFVE4vL2FTZjhjcXh2ZFhOZW1BSGE0WEdQQkdMRXEvdVg5?=
 =?utf-8?B?NjMrbEc1SkZwOVNJY25vSWpUdGp0dlQ0NnpqMmNnTjVDL0VhMFJBcVp5NDlM?=
 =?utf-8?B?T0N4R0d6N21XWVVyNmtYQUtzUWNCeU1zVW5jRlRYS2hXd2JxclBnbTlNWno5?=
 =?utf-8?B?QU1zcHlFTXFaSWQyNC9QS2pLUXFsQzdOMnNwSUMzczFKUEx0elYrbHFpSCtF?=
 =?utf-8?B?Y2V2M3NmQkRJVUdDc0xHaGdnV3pjby90b1VMYmY2Q3hnSnJqK0NpTU00YlhJ?=
 =?utf-8?B?cmJhUU9Ra01VTlZ4bEVaak1vekNyei9rRmNROWF6OHBrMVIycVI2ckVsMHhR?=
 =?utf-8?B?aER4clBJK1RCMVc3OEtqQjRaaVQwaFVUMlpqRGUvOUFTbDRMeUZucjBiQ3VD?=
 =?utf-8?B?NXZzTUJtTHRvY3QxVzVhNU9yL3ZWOWVVYTN5akFQa2JkVVhNVFRCRXBTVEl6?=
 =?utf-8?B?emRUU3ZydlZOdnBkdE1EVXRaWGh2Z3ZlNlh3UytBWkJPYzFSM1hPZnlSTnpH?=
 =?utf-8?B?ajdVWEo0Z0xhZnU4TVZWbmxpOURLNHpuV3cyYTJ3WFZiQy8wMGpyNkxIaUFU?=
 =?utf-8?B?NHVZKyt2dHl2YzNUZzQ0a0pWS1RCTy9aRHNjWW43Sy9CanpqeFk3MVVMeHhX?=
 =?utf-8?B?dG5QanRnYTl5TEFPaDZZa1k2QUNqd0llSTdlekZGOUhKbjNjUDBYZGF3MG9i?=
 =?utf-8?B?UUk2VmxRUTBBbk9NVHF3S1B3MlhleVl0ekdCVXR2ZlM3Y1ZBTFM5c3NTMEtJ?=
 =?utf-8?B?Ym5LcCtvU09MZmJQR2ZYaVk3NnhFZ2d0aGZGc2ZBVzVQSlBlK0lHcVk5Y0FI?=
 =?utf-8?B?NXBwNEluRC8rWjNRN09BUm1ka3RFZnRVZWhYSVJLTGhCKzltM2pTc1lsMVVG?=
 =?utf-8?B?OHpGeWVQNTlVUWNVM2dRdjRkSGQzSXloUGhpNlQ5dURiZm56VTIrSEZTZlhs?=
 =?utf-8?B?V29uT09Cc3ZjcnU1WWRJeXBNcUNqRzdGRmFGOVUveDVObnRCb3VUUjU4YXF4?=
 =?utf-8?B?U2wrNnpTL0lvT0VXVXlLYzRFVUU3OUFjTHYzNzRmcnBTek5GamtkUCtWVWlX?=
 =?utf-8?Q?ixPNnDF67h8x9aEVqeYnN/Ldl?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da17ece0-1937-45dd-0ddb-08dd99d39c94
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 08:27:10.2863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VITCOjOUGR9y2Z1BKuPG0xxPbsSFzVqEgpsnAxy96Qi9MViyc8ELja/AnnTtjWmDW98+u024IUOEYdRoCyE87g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8492
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 23 May 2025 08:27:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18938

From: Jan Kiszka <jan.kiszka@siemens.com>

This is officially supported by upstream as well.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Kconfig b/Kconfig
index f809f014..0887125a 100644
--- a/Kconfig
+++ b/Kconfig
@@ -115,7 +115,7 @@ config KAS_INCLUDE_KERNEL
 
 config KERNEL_RT
 	bool "Real-time CIP kernel"
-	depends on !ARCH_RISCV64
+	depends on !ARCH_RISCV64 || KERNEL_6_12
 
 config KAS_INCLUDE_KERNEL_RT
 	string
-- 
2.43.0

