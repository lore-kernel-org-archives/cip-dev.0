Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792B3C3ABC3
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 08:01:52 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.72])
 by mx.groups.io with SMTP id smtpd.web10.9301.1746777706958092505
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 01:01:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=rbj1SyWn;
 spf=pass (domain: siemens.com, ip: 40.107.21.72, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P2lYIZiRAEvN/thfoGc4fLixD28hOZpNvBnltW4nvn9rVvreeAGM/09aSq/jJuSzy1MDuBowHb6hNjAsXounQ/VrVsKTdG+hoEVm7arz8ZUHDEs8bkivv4f/Wp0LTVD+CzoOeDIW6V19yGQGsFRYwfNOFYPv2+T/OKqmZ53/5HdWxwp6oqcHVAjkUs7WI2sqGsrHPkipUaAsuRQdlqRoskcfCuUq8x0maQKt4hDoH0AdJLqsyjl8RLt3Kh9LoLQmoRhYa0DwAqL4cH4TFQoUphsdfo9VQW7R9osageNEpgWdZv5peLl2qpzFVYKLbh9K9QfAUQVjl45QXSdefET+eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/VEMpecJCkfum2pGGEJWxGINXHb/vJ2ziSU47cNHMM=;
 b=ofi2JHR96jE0eNvn12eliM51rNlkWy3URxZhgXHf1qO6cjnnDjScPF6dt1tlvkqIzLMrVJtWNtRlml91NRJ9fJyN4psqwaCynrunhbWW8aseYEdpA6UgUQ6BJTGeNKC7Fq+9KBxRX9m4QCYr3Y5QMInmdB0uCfR3x2XZ9Cjul+f9cLOv2qb0JMYdbvArLb9VYDuAlT4GDYjXqh289CPKkJCHF6aQPLkaAp5dRpmOEUV2vJhIq5vd/dacStLzTfvOUN+Ns0W3YswGQ3g7FCwF9gBFc5J81HPbIy1yRDyyjzgr0ChwPxs7nD+N5wDu/EloWFlx41+hcqi9eDy7/fPQ3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/VEMpecJCkfum2pGGEJWxGINXHb/vJ2ziSU47cNHMM=;
 b=rbj1SyWn8eS0uHYMNV8QcxGKr03EcGg0rhv69JlIGPMUckKdfvDlrXSguv0kGD9eZPLVRQ5fCv71Ea7zaqVI1NLna2MgyrZUkUL00LaigZMLWBNCTAOckk8Tn1NPxIaoDUkw+Xu+Rp4vI4k+2rzhXtCDKIODM2x9lKbC0lvKXUl6BeAVofgU32u8iP1L+c1dU3BxH3I8piYu1FgZRGoUUtOACVe9+Ze0F2N1aCX5LIybbdtkrZpn0z7YXnRX86qMkQD6a6lE956EZ77vlNoIGkCQe2wewY5tjoq+hsGvWPQCCWV77xU/Y/qy+TBRvbFyjErW9dVaa8MhwPXGrkB7Hw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DU0PR10MB6899.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:466::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.20; Fri, 9 May
 2025 08:01:42 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%4]) with mapi id 15.20.8722.020; Fri, 9 May 2025
 08:01:42 +0000
Message-ID: <6492478d-30e6-4009-9005-792cb2874dc6@siemens.com>
Date: Fri, 9 May 2025 10:01:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC v2 2/6] add factory-reset-helper to
 set the marker file
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
References: <20250506120807.255675-1-Quirin.Gylstorff@siemens.com>
 <20250506120807.255675-3-Quirin.Gylstorff@siemens.com>
 <e6dbfadf-97b4-43fb-a407-c740ef343bd4@siemens.com>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
In-Reply-To: <e6dbfadf-97b4-43fb-a407-c740ef343bd4@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0420.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::17) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DU0PR10MB6899:EE_
X-MS-Office365-Filtering-Correlation-Id: a0517964-6778-415e-079b-08dd8ecfbc0f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WUR5UFhuN1JRM1A4bTJBL1hYNWlRajM5ZkdPOElMQ1FpdERqT285MXlWc2ow?=
 =?utf-8?B?dWFrNFovWkNvVytoaWdQMXI5SjBnRXFVcUs3em1RM3MvL2NYbCtZRjAxTlFW?=
 =?utf-8?B?ZTQxbysrN1VRRHgzdDhwWXFCWlZydDU0VzEwa2J0NnlWYlMzc24zTVJMMXo0?=
 =?utf-8?B?K0hyN2hDMjlnS0lDN0xDVHRRRWhLSmNmc0RLTUZQOFhRYzNrTUNWemZwNUVW?=
 =?utf-8?B?cW8zai85VGllc3FpTU5NdFdYQVRxbitzTnB4NzJrY2tMeHBncnIzMlYzSkpU?=
 =?utf-8?B?TWdNZ014aEdueXNVSndVak56VFpSZXhRL2FOZElLOXYwYi9BZnp5NUE5K2pQ?=
 =?utf-8?B?SVRNdWk3eEQvR1pkUkZqUzNpbXdBYWMvdmlFYXlacHRGSWtITXg3VFJjT1dW?=
 =?utf-8?B?cGlHcG5Yc2tVYmlSU2hPRlB0TzVUNW9Nc1g2Q1RELzdIOVEvc21yYnpLZHZJ?=
 =?utf-8?B?N2U5aHBKQ2hqSE16ck1keVFxSWF0Mlo1QXovWG9heWw4TXlzRHFYT0tMNEUz?=
 =?utf-8?B?b2VNZ3NwdGkzeHo5Q090ajhMUTZlY0o4QW02dUdBYVBORnNZMUlUZGlWT3Av?=
 =?utf-8?B?ZGF6OFlBRnNEMU5KRTRYWTNoWUV1QzRRaGFUQldMMGFlc2JIdzhXYXRLZFFt?=
 =?utf-8?B?SVkxVEtSa2xvUmdOMmZsNjJJS1I2clF4M1NFdHB4TjU4SkdVcUgyaldpWi94?=
 =?utf-8?B?SWRhdkdyVk5maFJ0MXZmTnBFMmsyL3FyUW1VNGtRU2JkaXFLc1pydzJxOHFa?=
 =?utf-8?B?RmRXR0s0NS9BQVBQclN0eVJmS2E3cFNGeGtKMUVpZGpySXJYbnhCaTRpTWtX?=
 =?utf-8?B?N0lzNjhaMWY3NGphN1UzTW5XVnkwbFV6VmQ1a2R3RUN5c3JaSWwxSnV1TjJL?=
 =?utf-8?B?eFFOcDB2TVhCZkxVUTJLT01vR0EyVCsxdWlzdWsvZlNYVXdFK3U1NCtORXNl?=
 =?utf-8?B?TmxjdWx1RWs0aDZHQjB1MVJPU0ROb2hEUEQ0Y1g1MXhFZDFyTzk1ZUhJMUpE?=
 =?utf-8?B?Z2wzYU9tYWhzdmZlOE1yN1dwV040QVk0bWVUWmxYVHZ4V0VJNnQxekxMeUFx?=
 =?utf-8?B?bGh1RHBWcHRFZmo0dXNWUVRQTkhFNW9aL3phVGhSaFEySDQyUllaaEY4Nnlm?=
 =?utf-8?B?V3JWZ0RQVkxxNkhMbG5MeWFVbWlhaVVJQk9ES1dIc0RVNU1xWFJWY1lvdHVn?=
 =?utf-8?B?SmVZb1FGdEp3YnFlOTJZcC9TdFdZWFk5VFhITnpBYWExOFFFNVMvM3JWK3RL?=
 =?utf-8?B?SWtBcnZTeGhCL3VzMzNQNHhiRDEzdk9qLzZlT3FhMHkvYVN2SU84UjJHQmFP?=
 =?utf-8?B?a3JSZkkwdGk1TkFyU3p2bndFN1R4VkdFL3hEcGlxaWZEaUJLaE9Pb2k5Tzd6?=
 =?utf-8?B?dmltZUloY3VKekl1UGNvcmFxVFlpaHRkTkd5K3VPYS9XelNxR05pTWFtd2R2?=
 =?utf-8?B?QXFFYXk2RzhVTjhoWjNTd2hYOUJDTVRQOHNXNVNoYmtwd0dWVk5ublBhbzFE?=
 =?utf-8?B?dTRDbHZoV1I3Z0tNT09DMEZ4SnRlK1FTNVlCTnJnb2FFZzdvRFNweDZQdVli?=
 =?utf-8?B?L1lEWjVUUWs1N0FaZkxzZ2s1eGladUhMNUs0cUJqbHMvZXBFcSsvNjdtb2JL?=
 =?utf-8?B?K1lkOXp6WWVzc0xzTE5seU1pbG1TdVZlc3JwQkM2TFRBMGs0WTBNU3N0blFR?=
 =?utf-8?B?QUNwU05JVWZJWlYxSjFuakw2UnNUUG8rSTUzTGFHN1lRY2dRK21uUU5DRlZ4?=
 =?utf-8?B?ZUVUUGo3OHdYd2tvVnVJdlJDWUpSVFhhZ2xXZDQ5SkJ3RTlVUk8ycExMWjRW?=
 =?utf-8?B?eGFRUmlEenpHeVVTeXhzdHFhQ016azlhaDZDTlBMMGNQRHVjdnZaYlNnclZ1?=
 =?utf-8?B?SVhNY2F2aW1Ld0ZPQVk1ZnR6M0lxL0xTcXYvWFVvSDFJOXpiSURzWDVVazJY?=
 =?utf-8?Q?zcXU051hkFI=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VHV4SU82NjJTUWdtQ2l0YzBvdklOZkRsaGYvUzdCbVRsbldWdnFvM2FmNTZT?=
 =?utf-8?B?UjEza0pEb2Zxek1NSGJ3M0E0cFg5anlDTDc5aUdJZkprSXlaamc1M2dGRW0v?=
 =?utf-8?B?aEZJZDAzdWFYYm5QbEEvSzN4NG1iVVBVQTIwaTI2SzQzckNHVTNpRThVTFUx?=
 =?utf-8?B?SlNySUNkakRvd242NTdYQmNYaEtEWFV6blhwNmJpQzJmSk1Sd3FHZStUTmt1?=
 =?utf-8?B?cnpMWm5CS2xVaEZ2Y2xuS0oxbktseG9MUVptVHYrVG5FM1lxTUs3RjRpWE1S?=
 =?utf-8?B?NjhrWjRMcFVRM1oycXdXSUlUczBCV2FiK3hoT2J1SGlTQTVqcFdXRjkyTGcw?=
 =?utf-8?B?Q21SaUdWb3pMV0tndnJTRjhnR25CeGtNbkFVdTVIR3JxblZ3eTh6bVJHMTh6?=
 =?utf-8?B?ZlEvLzJzRlRDL3dHdWU4UnRPdDI4VjdySjJHei9vMUxTcVZZQUgxcFZwSmE0?=
 =?utf-8?B?RWI2MU5xN0dvYUtJdGh4T2dLLzgwb1I0R2F5QlEydXRNQk9DMTk0QjhySHg5?=
 =?utf-8?B?akxNaEhoSlIrV1VvaWZnZkl3aHV1VTBWK2JLa0xLUDJ1dUFUNlMyK3dmMXE3?=
 =?utf-8?B?a2tBWktWdDhEVU1sQWE1T3UwZmlQVDl3aHg0RVZZL0Z4QUtQa3JIb1dQSU43?=
 =?utf-8?B?eU4yVzZzaGdiYnhVaDBkWTNrUHk4dERQcU9vVU1NV05TQnhUZERDVVZNM1dp?=
 =?utf-8?B?ZUVHbWlldE52L3FpSGxsbXlxWkVrc1V5Mys2N2lMblpYK1VvNEw2Mm9sdk1i?=
 =?utf-8?B?aE1uZ1hzanE0cHZvcUVpUFYyb0VQZUFqQ2FjODlmL3Rhc1Z0NmsyNnZldFZs?=
 =?utf-8?B?MCtaMmNmb3VQcGp0VUFBdGgyeHZJZ0ZPL0M0VXhYSjhzMnRMeFBaejZ5V1pj?=
 =?utf-8?B?R1Y4SDk5M250Y1JBUXY2SlZYUXorNU5ISG5INVRwZVRTa0dPRUI5azBTdE01?=
 =?utf-8?B?NWhiL1JzWEhlaHptZkUzQ0xKL1pvLzl5U09MeVFjSzVHMU5MZGtMQ3BIa1Ur?=
 =?utf-8?B?a2tyeXZ4RlZ6UExwUFFKcERzVVJxWVBVQ2lYS0FROVF4d1N6eXg0YnV2aS8z?=
 =?utf-8?B?RTQ5bjBmU0NCdVI0cldWUkNTUkNKamkvdHBhR2g3YTAwU1lDYTlPd3Y2cW9F?=
 =?utf-8?B?a1laczcyWkFUNmFxay9DNGRGZ2haU1lra3BJbERqem1GU1N2K0dtUUliRGVk?=
 =?utf-8?B?WUJpc2N2NmtOVEJ1d3hlb0hQb3l5S3VkQWRCWURxbkxlK3lOcEVXREhrdVhM?=
 =?utf-8?B?cDNPVncxQWQxSWlaKzN3RTdzQXA3czFzVTExTDRMbngzSUIzMnQyeUVNd0Nv?=
 =?utf-8?B?YjJHKzltQk5hQmI4aVNqbXRpWkNnQ2tmejJ4S2RveDJoRjlKQ3R5N1lOekkx?=
 =?utf-8?B?R1o2VHVOZktBblZVR0NkaVplZzhlekl0NkFyYVBxSHZhZk52YkI0VTJXenB6?=
 =?utf-8?B?Zjk2MUR4TFVpVXFNQXpMQ3dXdFptZkNOclFqUDdUbkljUmwzR3B6dlZDWkhO?=
 =?utf-8?B?VVVCTzlHMVo2L1RvUlErOGdqUmhzcjUwRnBCRDZTUlY3VzlqenFCRHdzMk1k?=
 =?utf-8?B?NlZ2dlZLcDkySVJVVXhKbTZwSjVqRzAzK2pncEhIMDVWTGYvZnlCTnRtNUhK?=
 =?utf-8?B?cEFlbkxQbEJtKzUzZTY5eGxZQjJZaE9iYkViYkszUVhuSTBkdVBYOE5kNHpK?=
 =?utf-8?B?TGZOaGVmKzNacFVQdFpTaWNpVUNQcWx4ZW0xaFB5TWpkakUyZEs1ckcxbU93?=
 =?utf-8?B?QzBtU3NwbERlbEZGMGd5RnBURU8vdWsyL2ZVVE9YWDF1enBGeTlXaVNIQjFG?=
 =?utf-8?B?bEpXU1Ircm1HQTV1QTVBSEtvTlZrY2UzWTR4cEZ4RlE0aW93NWR0aFVoZ2Rm?=
 =?utf-8?B?MEsrOCtlb3dmNlNsYmFSNE5aUjNId1ZlYVR2VHd0TWZVM1VMZHVwZXl6Q0R3?=
 =?utf-8?B?UkU1SW9WOURYZVQ1VmtVQjF2OGM3c1VGb2draldmSlIwL3NpajhwNnFLM084?=
 =?utf-8?B?eWFtTHlHSndHekswWUdBVkYzcFI1U29GQS81SW9CZ05FUDhXZXhNWnhUUCsr?=
 =?utf-8?B?cmNhTFY2VlhXdEdRUVFDcDg1alpkayt3YjNzVFZ1NFZ4RkJsMWN4R3N6ZFZL?=
 =?utf-8?B?ME1GTGlxTFdqdDViQkYveVAxR2xYQnhxM2FGUk5BWTJtWVJ2Z0dmWXBHY1hP?=
 =?utf-8?B?dnc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0517964-6778-415e-079b-08dd8ecfbc0f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 08:01:42.2883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4kYH8u0tOHbOWjvylSFJ39ZizkAw3jSyeZFu/4QI4Z80WAlx1eqUWU79rllEGZyldjjjmMoKuO9Yd068H1ghqIgENMj1/1T2ZTT5uLP0tC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6899
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 08:01:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18786



On 5/8/25 14:51, Jan Kiszka wrote:
> On 06.05.25 14:07, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This adds an helper script
>> `/usr/lib/factory-reset/set-factory-reset-marker` which writes the marker file to
>> the correct location.
>>
> 
> Missing description how to use this. This way, it's just some piece of
> script, lying around in a folder that is on no one's radar.
> 
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   .../factory-reset-helper_0.1.bb               | 34 +++++++++++++++++++
>>   .../files/set-factory-reset-marker.sh.tmpl    | 28 +++++++++++++++
>>   2 files changed, 62 insertions(+)
>>   create mode 100644 recipes-support/factory-reset-helper/factory-reset-helper_0.1.bb
>>   create mode 100644 recipes-support/factory-reset-helper/files/set-factory-reset-marker.sh.tmpl
>>
>> diff --git a/recipes-support/factory-reset-helper/factory-reset-helper_0.1.bb b/recipes-support/factory-reset-helper/factory-reset-helper_0.1.bb
>> new file mode 100644
>> index 0000000..72cf5fd
>> --- /dev/null
>> +++ b/recipes-support/factory-reset-helper/factory-reset-helper_0.1.bb
>> @@ -0,0 +1,34 @@
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Siemens AG, 2025
>> +#
>> +# Authors:
>> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +
>> +inherit dpkg-raw
>> +DPKG_ARCH = "all"
>> +DESCRIPTION = "helper script to execute a factory reset with a file"
> 
> ...to request the reset via a marker file. It's not executing anything.
> 
>> +
>> +# if this file exists execute a factory reset for the given
>> +# list of factory-reset targets.
>> +INITRAMFS_FACTORY_RESET_MARKER ?= ".factory-reset"
>> +# use labels as crypt setup replaces the label links if
>> +# an partition is encrypted
>> +INITRAMFS_FACTORY_RESET_MARKER_STORAGE_DEVICE ??= "/dev/disk/by-partlabel/var"
> 
> This is duplicating configuration of initramfs-factory-reset-hook. You
> should make clear that the expectation is that these variable are tuned
> at global conf level, not in the recipes.
> 
> That leads the point that we are missing some overview document that
> describes the adaptation and usage of this new feature.

After our discussion, I would change the marker to an efi variable or an 
ebg user variable. This remove the need to define a specific marker device.

Also i will move the read and write of the marker to this helper script 
which will be included by the initramfs-hook to detect an marker.

Quirin
> 
> Jan
> 
>> +
>> +SRC_URI = "file://set-factory-reset-marker.sh.tmpl"
>> +
>> +TEMPLATE_FILES += "set-factory-reset-marker.sh.tmpl"
>> +TEMPLATE_VARS += " INITRAMFS_FACTORY_RESET_MARKER \
>> +                   INITRAMFS_FACTORY_RESET_MARKER_STORAGE_DEVICE"
>> +DEBIAN_DEPENDS .= ", coreutils, util-linux"
>> +
>> +do_install[cleandirs] += "${D}/usr/lib/factory-reset/"
>> +do_install:prepend() {
>> +    install -m 0755 "${WORKDIR}/set-factory-reset-marker.sh" \
>> +        "${D}/usr/lib/factory-reset/"
>> +}
>> +
>> diff --git a/recipes-support/factory-reset-helper/files/set-factory-reset-marker.sh.tmpl b/recipes-support/factory-reset-helper/files/set-factory-reset-marker.sh.tmpl
>> new file mode 100644
>> index 0000000..eacb8fb
>> --- /dev/null
>> +++ b/recipes-support/factory-reset-helper/files/set-factory-reset-marker.sh.tmpl
>> @@ -0,0 +1,28 @@
>> +#!/bin/sh
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Siemens AG, 2025
>> +#
>> +# Authors:
>> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +
>> +
>> +marker="$(basename "${INITRAMFS_FACTORY_RESET_MARKER}")"
>> +marker_storage_device="${INITRAMFS_FACTORY_RESET_MARKER_STORAGE_DEVICE}"
>> +
>> +marker_mnt="$(findmnt  --first-only --output TARGET --noheadings "${marker_storage_device}")"
>> +tmp_mnt=$(mktemp -d)
>> +if [ -z "$marker_mnt" ]; then
>> +  mount "${marker_storage_device}" "$tmp_mnt"
>> +  marker_mnt="${tmp_mnt}"
>> +fi
>> +touch "${marker_mnt}/${marker}"
>> +
>> +if mountpoint -q "$tmp_mnt"; then
>> +   umount "$tmp_mnt"
>> +fi
>> +rmdir "$tmp_mnt"
>> +
> 
> 


