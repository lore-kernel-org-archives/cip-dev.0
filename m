Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59FF6CCD194
	for <webhook@archiver.kernel.org>; Thu, 16 Oct 2025 10:47:42 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.1])
 by mx.groups.io with SMTP id smtpd.web10.5172.1760611655086814023
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Oct 2025 03:47:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=rxyjuIsN;
 spf=pass (domain: siemens.com, ip: 52.101.69.1, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xLbrvM9kKYVPBKeWx+M9NJLhBA3wuBKEhxEPjPXi4zr3s3PtA8I/njntD6F8zbzVPxOnespsM9YFaVUhxiu/LERcpOjt7DBHUvd8C10biwEUrcGcO1Ozm8zRdgErsNfCwVACaHycdVI5hzQCB//Pxe28j/WmvZ7j4qv2JtYjlOgSxYXdbHHRwJO+A0hWt8ajvD+zXP+SJrQ/aDL7erLyd/EO6YEU31BA/zlKVb4uVv8WlmbLgPrCCr9v573R5bYK7lej/CJ14S3gXf5nliXEzLZxolWC7B3D2lp2LDRf042wnHDwerL+Hm0T9zUV4CVvSLLZAc8tBZswJLq3fqYMkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xsVaObeS6slDlNHnNzxMNwZIxbKdLhR5mlgtnNe4Pvc=;
 b=HyGdZAtSAaPdbm+f8YVOiSn1hCyELVHjJr+g0Bmj28SmbAGaqSnS9/ShgOP0qOyhUFJCvKKa4uCKGpyAOscmF5Gi0tsa0mOxN0hDtoBxQxMnFCnJz3CLxnlltv5e8KlkpmF4JT9Lm9A8BbWT3I6zawiQFYC3wL7+JI+nVJzLul+0eRHyvo9pT8+r356Xfb3UML8nLi4//PU58RuL/1elwm6PFDFr2rSwLniecR0DASuh0j4PWzY8iOJ5CfGwXIVIcwEdNb8O+GDMwanFiCpmJeeZohxQnDZ22fvzwHutLPL3Yi9ufB6U7vhuZP+2JK5Ys+bxECLlOR+X9zKf9Xd3uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xsVaObeS6slDlNHnNzxMNwZIxbKdLhR5mlgtnNe4Pvc=;
 b=rxyjuIsNJ2C0fE3TWkeaKwdGUkmNsX/IqO1N+OcUhwk3plkCr73qfikMxGmlsV7hnYlwJMqLXitwodRGSujJ05lJ+zzlPZLcdV13O0awCJ1D3D7xMQ3wVTvmzTTbRS9rz/h0EcZSoL9ougHT48MtEXL+3eXU4mcCTDMtBCQZVpPVOq8OBkcTblpvoqDkN/p0ItZituTEVEKg1A7/ouUgdqHybhHSJhrcP93h9MmzVMNLUTSzCBZVQYJkYUNkQ6Etxr2EGk5QdRzTJfIFbU6jKLx3eyBjIwn3t0L0fd7Tj26OJGvaenMC6pIjNpus3kEyXb0FVjiUsNkshyvkNFV0Hw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB6518.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:55a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 10:47:31 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9228.011; Thu, 16 Oct 2025
 10:47:30 +0000
Message-ID: <ffc78fb6-f2f9-41fa-a39a-aeaca7b0c9c5@siemens.com>
Date: Thu, 16 Oct 2025 12:47:29 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 5.10.245-cip65 and
 6.12.51-cip10
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0094.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB6518:EE_
X-MS-Office365-Filtering-Correlation-Id: 0775a7ac-e8d8-46c4-041f-08de0ca16790
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?N3lac1J4RUliUVJaVmdUOWVkekRPZHd3d3VaRUZubVVhTjIwaC9kdk5yYmlw?=
 =?utf-8?B?SFluMGVrRjI5M3NGekVlRmQrRFZrQ2Zwa3piclI1cERQWnh5bThabGpMaFM4?=
 =?utf-8?B?SDZzbGFlMjRWeTRJcTFDZHdiamJ4RU44czFhMzh5TFJPdnFaVTFReUY3SE03?=
 =?utf-8?B?QnpvTnlRYkQ1NVkycW5iU2NzcVpNN1ZiSUFpM05jdzFCYTMrWG1vNUJhaU91?=
 =?utf-8?B?UTh5a0JjZTh0d2VmZkxFTklGUDFVS0hQNi9ZV1J6MTZJL2hCMzd3dDRqVGV3?=
 =?utf-8?B?UWtQY3VrSnRjRVpnYlFhakpPTjVuQStvV3I4T0JXdFErSGR3WE5iSjVZd3NC?=
 =?utf-8?B?dzk1U2Zyci91NDJZSHplQldqMFFISG9iZ3FtUWxpVWttMk9BQ2pWaXhpSkdP?=
 =?utf-8?B?SnlOT3IveFNUNU1CODIwTE9WSU51aXhFaUc3K253V2ZuVGUxbUxKRkN6b3ph?=
 =?utf-8?B?NWlKYUFzektkOHAyeCtBY21Tb2hod2ROWVJJUEFqd2cyY0xpMFJsRnNBRlE3?=
 =?utf-8?B?WmJVZGpYK1dLY3JBN0RBdGJieHh0UWVMTk0yTC9RMUdLQkJEMjRmaGNkS0E3?=
 =?utf-8?B?V2Z2blNzY0toQUNzaHRISTNVN3dxMWtQRHNCZGxqRjR5Q09OU1FKSS9FaGdM?=
 =?utf-8?B?c2RJUXM3VWFMYXdEMnpZeFk1b2NDeEV2K0lHWkwxUzMreVkvdG1NMnoxSWNP?=
 =?utf-8?B?LzNqeWFDcWgyaGJPWnh2Wkd2dm9qWHdjdFk3SmF6NFhKcG9CNGNJMGJTc1Q4?=
 =?utf-8?B?NWg1YjBMRGZUQWJ5KzRqcnNRTkNJZW5xc05VeUFnNXpaT1NubE1xZFdEZXM1?=
 =?utf-8?B?bjdjd2RZaTIzclgySUFYYnRucEJQT3hZd3dnTWZscnZFSjNFVGcvQkIxblVn?=
 =?utf-8?B?Mks3cVdobUp2ZTExVWhycEFYT0dHdTlEZHBLOTB6SEdrd05HTmRnL2g3NVEv?=
 =?utf-8?B?b1ZsMVM5ZHVSRXhqdkdXV242TlR0RWFqZXNhQWM3bkV6N0cwQ1RUQlluRUFZ?=
 =?utf-8?B?OGRJSWc1L21OTVZWUnhiZU1ybzYwOGhsNk1KRFN1NjJGaFJDNEZoR1Y3YWVM?=
 =?utf-8?B?SGxuVExZTGdXWjIyM0xaQ0hrdkdtLzVzMXd6R0NOWktITEcxRGxOQ083TGdM?=
 =?utf-8?B?Tyt3eFJDa0VBRktHakRrOGVMY2dJMEE5YnJjZmNRSUYzZ3ZHOUxORE9YcGVZ?=
 =?utf-8?B?ajkxMCtVVENndHZ4NHNBTm5FYnVvcHphayswUUJHTlNuRXZPZ1AzZmY0OHBZ?=
 =?utf-8?B?TnVmYVp6Z1J4U29HbEhGU3QxdVlLSFlSWEI3Vkc2bnFVWnZsUzhnZXFQOU0r?=
 =?utf-8?B?Vk00VFk2M3hsdk0vYmREekxEMnI0eDN4ZFU5d1hVd240aDRoWG02eFdleWhk?=
 =?utf-8?B?emw5TXA3dUdqaHhJRTFqWCtXUEgzdUpsQjQ1L3E2M2ZVdFpYallrV3k0aHZp?=
 =?utf-8?B?NFBBUkpnOTRyaGt2OWRianZqUXUrYW5CR3BxNXl3bXdtdkJkcXFQeGJyWGlm?=
 =?utf-8?B?b3czUGZpSW1xeGw2dXdxbE8wWWxKaVBScVM5TzBhTUxBVlM0UWt3blZNMHdQ?=
 =?utf-8?B?YXoyUmpYajN2Tnh0QkhyTENxQmsxZ0lkeWpxNVYrODFJdTl4N0VhWU1oU01D?=
 =?utf-8?B?TmZidW5aWExweVk2QVdyeUZoWHVTa0UwVWQ1dzZUTkxkYTBvb0FqejAwaE0z?=
 =?utf-8?B?U3pTUk0xZEdxMExXTGNrZVpVYldHbVg0RFVGY2J4M2MvREZpOHp0RjNqS2F0?=
 =?utf-8?B?bnV5eWZZZW9QWmNGU3grRHpoRGk0K3F1Z2RSc0hKU2MrbXZTK0ZTYzE2V0Mr?=
 =?utf-8?B?THRzd21IR3NTcHFCNkM0c1U1MVV5TXRrSSsrTElFQlVKTzJWRWFRNlFFck14?=
 =?utf-8?B?NUFwOFJFNGRqekRnK05XWTk1R3pDcjZoMUQrS28yKy80RnVwNkluVkNZQmc5?=
 =?utf-8?Q?8TGC9HVVoCCDQJ699C+s4FG/RrcIHO2j?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WFExK0hGZ3hCKzUwNlVyWXc3WlZZRHAyWW81RC9kSTVsRHIyR2h4Nmc5ZWt3?=
 =?utf-8?B?TXJVUGhqc3RmSHNUTmJJWExFcVgwYVFHSEdEOGo4NGEzMXhMbERmNHl3OFBP?=
 =?utf-8?B?NFh4cVpCMnZQbzUzR0J2S3UzbjFpUnF5Ni96cnQwYmNOaHNMWWNIcWlKYzNa?=
 =?utf-8?B?N1ViQ3EzVmxoSW9DWkxBaWV2V0MvRlIwVzBrcVJZT1lIWXppYXBtMXNhQ0pN?=
 =?utf-8?B?U0k5MCtSTWhlajdzY2phME43RUNRd1E0VDYvYVNwR0NrYWNzWVFMUEsxSDhl?=
 =?utf-8?B?cUpIMitmOVpMdXd6anZBTWg0c3N4dW1scTZvUEFPRGdiVEVqS1RGRTJxYUp3?=
 =?utf-8?B?M1U5M1J1bXdnL2R1UXhaTUVWRHh3NmMyREFJZXRueVlpUG5TRng5UUFwSUtN?=
 =?utf-8?B?VHN5TkVsa3FIaG9KTGNIS0FzRGhSMjRPSlhTUU9zcTBwSklCaTVYSnZ4Kzlz?=
 =?utf-8?B?ajdZN0dlWlB5T1BCdUxOWXhNSWpSTDdPS0ZhUHRzRXYvNW92cFhYOU1GTXBQ?=
 =?utf-8?B?d2tSUldiN05XU0ZiYjk0M1pJVTJDSHR0dHI0WXJVWDhsMHY0TWc3dTlXOEZH?=
 =?utf-8?B?MnFaNlJUcW1sZWFvRUNRNE42Y3VJZG8veXBoN0JjN0pYUzd3a2czRWpySWZp?=
 =?utf-8?B?Y0VwbnZESHU4Z1ptK2RIM3dqVlFtRGVDMlI1YzZjM3VNYitFWXg1SkVaclAx?=
 =?utf-8?B?QllFeTJ6NTdlQm1kblBReGQ0UGpORUR4OFk3a3NlZld0T2lYZ3d4S1gvOUhk?=
 =?utf-8?B?NWlka0QzK096bktpaTVjWkdYVm41MXFSK2FVSWphNjJqL0VrZDBUNkZLRElJ?=
 =?utf-8?B?ckVpN3VGei95ekpBS3dWQ1ltM0VqajgxM3R3eWIwK0xmRDdqbmwrY05CNC9y?=
 =?utf-8?B?MTNvSHBkU1ZaMGFWL0QwWTZCRXdBcnA3N0trcEZDU1hnSlRmeDdndHBRMXVR?=
 =?utf-8?B?dnFkY1pubUtjZnZzUmc1NWtFTzBFNVB5RmNXdjhDTi9TdDYyTjEzYmlXNXFv?=
 =?utf-8?B?Y3J5a0dmQUhweE42U0k3NnVYSnlEaDhlN09PTWFhQ2w2dm90QWNYRGNoYnIr?=
 =?utf-8?B?SndVNTRjKzhvazEydElTSGZtbngzRVdGeklsOW5hNmVSOFl1NW02LzF6MUdT?=
 =?utf-8?B?NVg2TDRaaTcwcllzOFZYbGx5OUhsaVdOb0NQcHhZY2tOWDkvanpIcGNheHNF?=
 =?utf-8?B?ZHJLNEViRUxKVWpweE12ZFhDY2ZHcHhoQWRBM1dZZEw5MVZOWm4yNVk2RjBu?=
 =?utf-8?B?bDRBNlkydWZZUFZvUXFRSURrYlA0blVQN1FySTNRYmdHRmladCtmS1orT29t?=
 =?utf-8?B?Ym5FbWJLdkZ0di9Ya2EwQXdROVBuMTgrRzlVV2RLdkJHV0t2bEpKQytEUGVD?=
 =?utf-8?B?ekF5Sm1BVnppK3RrSENRL0dmT3BuY0ZaMngwK1g4QlNnbEowTzFEVXkybmdH?=
 =?utf-8?B?Y3c4ek1DL0huOVQ5VDEwUnVuM0F3Mk04eEN3TmRXSXlIdFYrNlBTQ0ZBS2NY?=
 =?utf-8?B?bVJ0eWtTVnRvYUlTZWJ6SWhZcnZpUlcyUlRPcWZmQXNTQ00wSUZrNmpIUDhC?=
 =?utf-8?B?VDcrNUxYMEdqczJMSlVqQ0JRRC9ydENleE9kZ29iZXpIdnErMmFBcE9rRVBk?=
 =?utf-8?B?YkFYcEVpdzVaelVnR0tTVjhJNzVqTys2WmplVlZWOHJUeE41YTY3T0tyY0My?=
 =?utf-8?B?K3F0N1dsb0U2S0RXdzR3aVUzcDFhaGQ5SkE0aDRydVV0eVU5UUxVNzFoS2E4?=
 =?utf-8?B?dm9JaDBKeXFGZUV4Y0hndVpSenBIWHhZd0I2Z2FjWTZtNyttMVRSajVLaUNW?=
 =?utf-8?B?aFNqQy90Z2psT08rNXFDajlPL1l1QXdnMmZVRHZ3RGloZ0ZXbTcrZXAyQTZU?=
 =?utf-8?B?bHNKY2V1VEh1eWVteHRIRDUxcHVyWExkVjNNdUJrRGxvREdQS2hqc0ZHMkds?=
 =?utf-8?B?WExzRm5yTWUwYmZyS1o3enN0YkF6VzFKNVQ4VWluV3Y5Z2xDNlRXSDdudllz?=
 =?utf-8?B?eXFNWHc0dVBkVndXYVB4aXdTNzRNOGwrUWp6b1RWR1JycGtlUHZBWVpnNlJ2?=
 =?utf-8?B?VHFLRFR0YlFxdzRiTzIrbEJNUDJCSkprNVB2TCtaS0F6dlYrVm0wNGF4VFo1?=
 =?utf-8?B?c0VJL1pLNFV5Z2dXV29wUUFvZkRxU3ptUHRIVVNUNnRXNTNjNEttQi9lOUNz?=
 =?utf-8?B?cFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0775a7ac-e8d8-46c4-041f-08de0ca16790
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 10:47:30.3807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ASRZHgh4lUvtG/G4MyPlY100ef2InyfBmJWkeJ+vFRUHJ+ZzGPGZEUfFmmKdj4bxYly4KIlYG2vKCa0vEmySZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6518
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Oct 2025 10:47:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20185

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/linux-cip-rt_6.12.48-cip9.bb               | 1 -
 recipes-kernel/linux/linux-cip-rt_6.12.51-cip10.bb              | 1 +
 ...{linux-cip_5.10.241-cip64.bb => linux-cip_5.10.245-cip65.bb} | 2 +-
 .../{linux-cip_6.12.48-cip9.bb => linux-cip_6.12.51-cip10.bb}   | 2 +-
 4 files changed, 3 insertions(+), 3 deletions(-)
 delete mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.48-cip9.bb
 create mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.51-cip10.bb
 rename recipes-kernel/linux/{linux-cip_5.10.241-cip64.bb => linux-cip_5.10.245-cip65.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_6.12.48-cip9.bb => linux-cip_6.12.51-cip10.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.48-cip9.bb b/recipes-kernel/linux/linux-cip-rt_6.12.48-cip9.bb
deleted file mode 120000
index aacb13b0..00000000
--- a/recipes-kernel/linux/linux-cip-rt_6.12.48-cip9.bb
+++ /dev/null
@@ -1 +0,0 @@
-linux-cip_6.12.48-cip9.bb
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.51-cip10.bb b/recipes-kernel/linux/linux-cip-rt_6.12.51-cip10.bb
new file mode 120000
index 00000000..6df87a9a
--- /dev/null
+++ b/recipes-kernel/linux/linux-cip-rt_6.12.51-cip10.bb
@@ -0,0 +1 @@
+linux-cip_6.12.51-cip10.bb
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip_5.10.241-cip64.bb b/recipes-kernel/linux/linux-cip_5.10.245-cip65.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_5.10.241-cip64.bb
rename to recipes-kernel/linux/linux-cip_5.10.245-cip65.bb
index 9c206f1b..d2fe0e66 100644
--- a/recipes-kernel/linux/linux-cip_5.10.241-cip64.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.245-cip65.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "b629bb6a300d5204baae478b3f80434f43cced6a500aae356d57e38c2956cb95"
+SRC_URI[sha256sum] = "23996d35b4264c02839705539390cde672da51150fca655ad30cee01b8f7e4a8"
diff --git a/recipes-kernel/linux/linux-cip_6.12.48-cip9.bb b/recipes-kernel/linux/linux-cip_6.12.51-cip10.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.12.48-cip9.bb
rename to recipes-kernel/linux/linux-cip_6.12.51-cip10.bb
index e50f42a0..4c000d7b 100644
--- a/recipes-kernel/linux/linux-cip_6.12.48-cip9.bb
+++ b/recipes-kernel/linux/linux-cip_6.12.51-cip10.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "66b016c46f369496c1993267efba83725b548a40ed0826d067691e89ea0a4aab"
+SRC_URI[sha256sum] = "729b2987b444e3dbbe85551d37a416fd9d06c9e53926da0680342df89b9f525a"
-- 
2.51.0

