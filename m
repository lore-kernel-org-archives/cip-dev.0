Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB12C369B2
	for <webhook@archiver.kernel.org>; Thu, 17 Apr 2025 13:22:58 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.36])
 by mx.groups.io with SMTP id smtpd.web10.8606.1744896173693453975
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Apr 2025 06:22:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=iNLQTLoz;
 spf=pass (domain: siemens.com, ip: 52.101.69.36, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LPQZKy/CwlDBjiOBiizd+aGF1GECtGiAN/Mv0D2V5HsaQpWEU6/x/HijwmI66OtSdorfkzwtCRHohq4GzNtXDy5A64Wcb1ht1VPwqg49vM/de7dnhPM6kBMeOQHn2lk/pmdakR9NHm0NhLxWVVNdDvGDtSOkv69RIAUWTuDpSelHA20q0+yUmHebeJaR8CR6E8SCI/A6HWDVnDCzfILkVuAfkwmPmfDlAALSTrDWU2RidiXUwu2/ZD3ksApjIxCg18PSe0X2Mt4JNvumdYU3tBxxLq6r4aVM4IdaD9r9UCixbzAPBYvkBcGfy8O9XaRc+EMRVf2YlvVdq+/gWsfA0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KhyGsh6AzpJlVsH7fglmz/iO3AiqibvGw+S1FCvrCjo=;
 b=J94PAD1gV0jC+9kfjOQojOmNf9RkOx7dz8Ccaw3UDFa0DGkNWlq32WKA9L4AZmVRvEKcC6cG77Rd6crA1MIKfZzTDPrdPNhJlc919HxUOj3RWfq/9ZEVi7mxlfBm7UZjhc39L+X7fpDh4uDlLQXyvVm5R9p40srFZRiYVbSIgGkmpXTTKClRCGYN6GxIIUHvqnuR4pNvx9D/UO+3AbT59r8oYw+iX1ilW3ZN6z0s/wnEkvmHOZ1tcsWBFIg5b1YRFxQEMnUVXdE5aaOI2C3x23P1Z/xm3tyLalqEzbdcvnIiJNbq2Wr9t5jXqKLZCRmDrOd6zzcby/hqczKVZXyjzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KhyGsh6AzpJlVsH7fglmz/iO3AiqibvGw+S1FCvrCjo=;
 b=iNLQTLoz+m3CXx8/RO8Td9Xht+iYaa2J/z7StDL1UdIQRhYTTtVtlU7eP+7xMLocOPxJZE2iPYpB7O1rsp/Q/hbSGexkSCQFE3xFBZELXBcOMNNFnOGKx+wISG5s6EDhkyloXyvlV0n8YFNJHbY/x2Ivud5d4GZF5mckaz1kSLybEswGEX3OL4Thyj/RuYEkTD8cP32UdvEYNLkqBnVLEBdhsGqLDKh7V0Bfg8ca55TfTtxu+CzpZr47d5o9GNePKwdrtzwdRIj0uXWIL0mXZCsFb5XDpdw6sd1B3pOF3s6NS+EWT7a7qz381HcFZAaMCxp5OVExYyE0U2OXN93SMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7110.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5ed::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.36; Thu, 17 Apr
 2025 13:22:49 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8632.030; Thu, 17 Apr 2025
 13:22:49 +0000
Message-ID: <7fb7d0ce-f588-4d85-a01d-ea8678588aa3@siemens.com>
Date: Thu, 17 Apr 2025 15:22:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core v4 2/2] IEC_template.yml: Update IEC layer tests
 revision
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20250417072708.2757909-1-Sai.Sathujoda@toshiba-tsip.com>
 <20250417072708.2757909-2-Sai.Sathujoda@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250417072708.2757909-2-Sai.Sathujoda@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0123.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7110:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ab79523-ca5d-4d78-ccd8-08dd7db2f319
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cG96Wm16d01BbnB5UUZxZ0dlZ0dKb0ZCWWo1WFY3TWNOb0ZXZGFWUm9Ldjg5?=
 =?utf-8?B?MFNhQXppbHJ0Q1VxOUZjcmZnU1BDQzJwWWtHTkNxcUZKZHJaQms1QkJGMERs?=
 =?utf-8?B?UUNVRlZjMjAzY0paRHdac2s4OHVUa1F0ZHMzNjNUbnFkZ1RoZUF0ajB0MXNw?=
 =?utf-8?B?OG00RGNJVXp5UnVLRjJ5djlDRFVjdm9ZTW4zSWhuMHd1OGM1U093cTFUVXBK?=
 =?utf-8?B?MVdpZHBrTEJyNFhxcUdqd1gwR21wWWJYVndtZ01wRGNUeFFiUzdZTUhXdE5y?=
 =?utf-8?B?VHM1c3ZISHpiaGFiY1N2TU5sd01RR3h0czA5NEtpVW1CbnJPZlBNSTlXYXZ6?=
 =?utf-8?B?TTBoNzBLRTJ3d09yQjVyTWNwTmowYjhBNDVHeXowcmlMdTFOVkN2R1BEUy9B?=
 =?utf-8?B?aStvWGNxR0JpQkJ6OXY2WnkvSUQxb2pJM2dheDc5bmNGNTRPT2pFbXltdjhp?=
 =?utf-8?B?RkdMMkJ5cjdidmV6Vk5PdmJpUGwrWWZXWHE5Qm9jMzNCQTRGTDdZQlI1S1lU?=
 =?utf-8?B?Y2FMNzJVb0tJbDFXTHlNemR1QnFISjJnS3FIblVQdmJXWFgyc01UVFFzMmdO?=
 =?utf-8?B?c0hUa2cyMXRFUVBNMXhSc2h1bk9Vc2lUaWpSRG9YS3M3ZG1HY2pIVmRIRVdN?=
 =?utf-8?B?OWZINmZMTWQ2MnBmUUdvYVNBSzh4TGpkamRLdHNrcDFqWUtaZnZCRFJGRnVN?=
 =?utf-8?B?MUZjdy9DVUFwbVYxTzN6YzIzeHhlK1VUYkFjQVoxMmo5MUFpbVo3c2VscW5X?=
 =?utf-8?B?a3BFbFBTakxBbnZSTWpEaWR2V2RWNkIrSEt2NWs0VWx2S1F2dkJXandUVEY2?=
 =?utf-8?B?VGFtM0gzRFpQamh4ajNGK1A3VldIRStISjdIaXZLYndBOXR0U2lacnJTdE5i?=
 =?utf-8?B?UkJSeURmZDI2QW1uVkNSemVib2xiZWkvVzNXK3V0a0tqek1qTjB5OFJNUk54?=
 =?utf-8?B?Zyt4Q3VXeTY0MHdQcktuSGJkUVdwdHd1OWR3eHM4RjFQODljTm9jZ2NJLzdB?=
 =?utf-8?B?c1JDNFpPMzVCd3NKU0NSc21Td2hpNzJrVGYrbWx5TlZvdkEzYWNPd3RYaWd2?=
 =?utf-8?B?RVZpa3VHNU5qR1dCTVc0RDB2YjBLdVZYa2p2N2ttNlhKSExONGVlQWU3alVh?=
 =?utf-8?B?clpOTlJxd0N5K2lCZUh3M3hjSkwxZGJTSDkvdUJSa01DLzkxajdJQk1wM2V3?=
 =?utf-8?B?anNablZSRHVCSVB2Lzd4cTVWa2k4R21YUzhmMmN4WEtGT2s4K1JDSlUrOEJP?=
 =?utf-8?B?dTFMQnlIcTdnRjYyNGpXc0NwR2tQQVZOUzQxZXhIRjlOc2FzZEdZLzdBRXZW?=
 =?utf-8?B?Y2gzdlZjazNPUUMxcDdlSnJmaHgzSXlmUzBNRUNxZXYrNkdDZWs5bCtYUkRw?=
 =?utf-8?B?YTJZYVplNllja2pTNGk0STU0djBWNDNqaGNwZHl2dDhnVkRhV0tFUG93Yjc4?=
 =?utf-8?B?RU1IWUwzRU9mVE9qZWFzaXYwTWZMMDJvSXBrY2E2cGh6Z0NFT1dhbHFxQkpN?=
 =?utf-8?B?Tlp0MnQrYnYwMm8xV3V5Tzk2eUovZGlJbG53RmdqaWRzbG5aMmg2WGtiemlo?=
 =?utf-8?B?Zm5WSkczZmtBMnRpSldFYTBSNng0UVZJdnVkN2lUZWN5ejhTRnI2UURIcEZK?=
 =?utf-8?B?T3V2aEUybkp4UkdkalJqZmpPc29pdlRmN00vVTV3bVVTNG9KaUdTd29ISHBH?=
 =?utf-8?B?UHd6Z1pXWWtRL2k5Tzhaak1Dd0cyUGt6eDAxbGg1MTNKTy9YMmJnME1ZdlZZ?=
 =?utf-8?B?VGo2WGtYNlluWjc2aC81STNoNjBnNUl0MzFIQVFDeTZUSm9zaGViUzdobHpD?=
 =?utf-8?B?aXRNcVVaQW9MaXB5NFBkaGNVRGVvU3lGTDJ5RlpuRHlBYkhXbFNLZGFiblBm?=
 =?utf-8?B?OXdKR2R4SS9uL3VpT0ErbDYyVEVOU2ZQb3pQbXhJV05ueExjdVZlYjNaamht?=
 =?utf-8?Q?On8tPjIdmSU=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TDI4UWFwVVhuejg0WXR3bXNNMEh1bUZzKzhmdWVRbXlyN2ZVQjROT1FZY21X?=
 =?utf-8?B?aGVGZEtDZTRlQXZoSjJFSkJOZTZWWTNjbVdwUWQ0eE5Ja0JkUXNuUC9kOENQ?=
 =?utf-8?B?R2ZVQnV6RmZOVGNWVnNIZnhhWkJZYWdxU25hM0N3VE1lMTh4OE1tcjFFdmQz?=
 =?utf-8?B?Y3ZFczAzcGdMTEI3UllrQ2FVWHJ4VEFhaCsvK0lFV295RCtyOFkwN3BLWkIw?=
 =?utf-8?B?VzZINHEvSjJ6UXVESW9weXRtOTNCNGRUM3FRSFR1U1owZmNKVnZvaFYydzdr?=
 =?utf-8?B?ZmF3RVJVcVBack9vR25KMUNYZFJDenRBQ2x3cnBHb05FaHc3NVJpaG9DSVhT?=
 =?utf-8?B?SFN2WFFEUGVMd3hqS3B3dnJFQTVLeEV6MDhyNCttWndwMWh5WHhXTUJ1U3Vo?=
 =?utf-8?B?OEJVa2NRMEdXSHpaUmVsSjRSTE92b3RwYlp3dWlwRStua2lrUjhuc0lHTUNH?=
 =?utf-8?B?dnNMRlIxbG45Tlk2LzZVMjZIU09BOWZSZTQxUnd3b1YxTklKbkhLeGVXWk9X?=
 =?utf-8?B?Z2ZRUkxUVDkzMmZ2VjV6VHhVc2FrM2IrdnNGcVVmL09QQjYyTDJMa0dBaE5C?=
 =?utf-8?B?REczd3A0VGxDRnRLWlRWMzFpRmpiMXlRZlA3NmpjWHVnd3ZYWGZvcjdsOE5W?=
 =?utf-8?B?M1FlbC81MkpvR0RPRnU4eUNGbk5kT1ExbExvUjdGdXFjVEJ4M05ZSHo0Vlhk?=
 =?utf-8?B?ei8wKzZ4dkZ2QlRaalZEd1lwc2JVSFZJQTRGSnJkNmJXcDU0QUVPU1lDTDhW?=
 =?utf-8?B?UjVSTVhYekpROHphc2ZuOHVKNENzYXBjcjVvS0pqTWQxbXp6ZGdCbDJDWGRz?=
 =?utf-8?B?WnR6SllBd3RtOERGSzFPd1A5NDVGbkRiQzZrZjRGMFpGKzZnTTRvdkw3QnZE?=
 =?utf-8?B?cGZraG5wMUE0aWJLSDhFdnRsdHB3MThzLzNvdjEyMHpsNjVoY0FjYjdqcU9w?=
 =?utf-8?B?eFI3SlpxMkVEajZaeG1JUUthYWFHRUl5bDVYajBFOGVCRWZrRjMvNFdGbm9z?=
 =?utf-8?B?YkFnSGwwOWhnendDa0V1VzRPejMyRkhkMGRjMUZYc0R2akwwRmlMWk9MVFpi?=
 =?utf-8?B?K0QreS9IMmN4dmlCbkRUU1hwNDhKVTB4TWRHa2NicGp5K1Vvbmd0UnVNd210?=
 =?utf-8?B?TVFsMVVTMTVoRUNmUm1FNWMrSHN6aWRkNy9maWNiTWZuZzNHTGtDb0N3YndS?=
 =?utf-8?B?Tnd2cWRSQ2JJVFQ5TGZsUm44QmRuQk84dzg2R0FhTVJzbW9mbTFmZVlLcTBF?=
 =?utf-8?B?TFF6c3pJcUxWWThhR1hDcG40TEdyU2NlZ0dUOFQ5QmhmWGFJK2ZtNURpN2pK?=
 =?utf-8?B?eHJkdFVRMTBwRCtKNVoyUFJyb0xCWThSN3JjRmRLczRJakFhRCtQSTlCb1lK?=
 =?utf-8?B?Z1Q3WE1PYUlQejJQMWdDMEIrUFFNZ093MUxMUklJTFVER09qZDlsRzA4ZHRP?=
 =?utf-8?B?SnFuRitHMGtYNnlDTmdDUVRUM0NtckdkR0dJY3ByaG1QRDJkclJCT3FyTits?=
 =?utf-8?B?Mmd1aEdoeUtML2RUU3psa1BPY0pDMUJQM3QxSE1lT3B0UkN3Y25uVlRPTUVL?=
 =?utf-8?B?WTBIckwyTS9FQXhZV3dJNmxCUG02Sk4vMmxzWGlqZHVZYjVLaytrWWNLUjRM?=
 =?utf-8?B?ZldvbHIrQyt4aU0zcVJxdWFqMjVPOVk1TGlqL1dlSDVvOW9uU1dHN1VLSzAw?=
 =?utf-8?B?ZDhlY0dqT2tBUXV0d01PZ3VlMHZpUXlKa2s3RFBqcjJxbXhibzdVUzR1KzVX?=
 =?utf-8?B?L0NCTXNSSlJpSVJGWktrM0tQa3BVSnNxdmJwd3JtK3kxME9vRUpIVHBJNFh0?=
 =?utf-8?B?Rmo0WVRMcW1rRjRhSW56QU8vZnlPS1hzWTNJK1dFZG55b0pBNmlpMjY1cU1u?=
 =?utf-8?B?eUEyekxRSGNNQU5QS3F6Vm9kbFpDampZbUJybkk5SkRLSVZiZVhZOEpzbEly?=
 =?utf-8?B?NDI3dTN0NGpyVitqSFcwVytlTmZuOWoyTWdhK0t2UnJ1aVdjQldsS1owZkZD?=
 =?utf-8?B?L3VqWU9RNDJOczhqaDlUbUtUVHYzd2tDMFNQWHU4UDdNRWpMUG82c2pzbmNs?=
 =?utf-8?B?U1dsRzRxeWg1TmFKVDRYTDM1UlpkMEovc2pld0hvbWp6RXNWL2t6THdzMzVQ?=
 =?utf-8?Q?NK2skipMgMs7w/h7hb2HBg07u?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ab79523-ca5d-4d78-ccd8-08dd7db2f319
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 13:22:49.4499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J4SxmGvVsIuwIaCle6euLza2q2PiBrNGNcfwGOQAt8/phxx9EzIGkazE14CKaNFR/iHysq2wbn8GCyOknpG0WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7110
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Apr 2025 13:22:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18522

On 17.04.25 09:27, Sai.Sathujoda@toshiba-tsip.com wrote:
> From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
> 
> Major changes in this update:
> 
> 1. Fixed instability of TC_CR2.7_1 (Concurrent session termination)
> 2. Added TC_CR1.10_1 (Authenticator feedback)
> 
> Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
> ---
>  tests/templates/IEC_template.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/templates/IEC_template.yml b/tests/templates/IEC_template.yml
> index c8efe40..b93ed4b 100644
> --- a/tests/templates/IEC_template.yml
> +++ b/tests/templates/IEC_template.yml
> @@ -64,7 +64,7 @@ actions:
>       definitions:
>       - repository: https://gitlab.com/cip-project/cip-testing/cip-security-tests.git
>         from: git
> -       revision: 5dbc47f55d4a43449dcbde4363e5d23d6e96344f
> +       revision: bb19990c2b29ea96eea309e54124c74ea3246f18
>         path: iec-security-tests/Singlenode-TestDefinition.yaml
>         name: Security-Testcases
>  

Thanks, both applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

