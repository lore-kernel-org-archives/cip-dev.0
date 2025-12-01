Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B85D116F1
	for <webhook@archiver.kernel.org>; Mon,  1 Dec 2025 13:57:20 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.69])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.21858.1764597430991232587
 for <cip-dev@lists.cip-project.org>;
 Mon, 01 Dec 2025 05:57:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ZJ3CH6uK;
 spf=pass (domain: siemens.com, ip: 52.101.72.69, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y0Q2GyenMYOG2oqSEj2OxSumJFSoZCykAEwHUpof/g/3rJBp1hA7TxcilPuAjBotLWE6o80/bdryAOlaC9uulG97m9FIwikAspUx9xt9y7qiPprXIG9PpmUFoK7HZBL3/8HGPRMx/hmkzHT993kBpXueYmHgmf0pDxQ3nvTUfYQ3Gz2ZUrnafbvMhFyrPEbuB7mCVLXwa/wB/7sqxKeNfjMFhRu7qw+T9lW0EOiLsY1+TUXI4Ethg8PfKhKHCv6Onw6qrQBpG0upwT9+Bl77YvbLCaGIn2YXgzP1N+dVmr01OPk18n2aDbKHTkJoP4axN0y/GC44bqFK2rpvO7djpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E+/B1KBByec+ptqb79pWPNR/1YkOKp4b9nwanWNzmeM=;
 b=QS+lnt+5g5HNJL7xvxdvkhK5xp8S9/P/oW+nTyxwxMjqjXFUI0PbsaV91EzlGG4EiK8z78agcSr5CzheUEiAd5Ay5bsUusls/zsIfO3gCmxqx7oaJgqjx/LsD2TZmrLl+ueqpQ8qwaTNuiD8qBqkdfwiRWiAhRd5HMByxqv+f7U5K+89iTlHQgLdBhJea/QMiOetDJV1a0RK9MuGE5q15FwjHvZeDGIj76DAr4JJGjQQgg/6s8rV5a09/wydPCkSOIJUOpFlWJc5lgmDg6/iPyTDSFmtnQoHN9wZ5i4qEK5/PCr9MjDwDbWDP9DeRnRDRe9A3RtgjomUW70uyhlpcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+/B1KBByec+ptqb79pWPNR/1YkOKp4b9nwanWNzmeM=;
 b=ZJ3CH6uKQPFP1WC5JojJ33i498iYR+JX/rqfVNIrSFFQTlf2iasQDbdX1KuIguu7GjOKiZYfzabiApGAQREBZ1U2JvvSFgJXHS3rEUL/234VgqLicG/kzHqcV9pYLo18RFlit8hs6fRRPBOKfV/Q4NG7x/AbSTMLkLFcrqjrClj2cDhQmuO55WhKQ9vcZ3fdkGK60TZ62t5AXhBsCwsCbDEAa9IPiDgxSpsx+SCKPmCZqslIoBJ1HqjBeDITfhNIWoJyGVVyN5bLV8KoPB/8c6/nuTG4iWg6wQo7QrDAp3OhwEBuCEncnsrABxubB3LLRGbfXAHRe+JNJ4lTbHcneA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7216.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:448::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 13:57:06 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 13:57:06 +0000
Message-ID: <685300c8-4196-4fa0-a99f-c02edb6ba6ac@siemens.com>
Date: Mon, 1 Dec 2025 14:57:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] 6.12-cip RT testing
To: Chris Paterson <Chris.Paterson2@renesas.com>, Pavel Machek
 <pavel@denx.de>, cip-dev <cip-dev@lists.cip-project.org>,
 Arisu Tachibana <arisu.tachibana@miraclelinux.com>
References: <7f09f540-8d58-49bb-83f3-811eacc77a20@siemens.com>
 <TYYPR01MB15132251A0B56FB7ADB41CA1DB7D6A@TYYPR01MB15132.jpnprd01.prod.outlook.com>
 <c2a68a07-435e-4a70-af85-0e34a7884946@siemens.com>
 <687ebce7-64c8-4bfb-8ed1-3b36ab1f2dad@siemens.com>
 <TYYPR01MB151320DF527F486189DBEF103B7DBA@TYYPR01MB15132.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <TYYPR01MB151320DF527F486189DBEF103B7DBA@TYYPR01MB15132.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH3P221CA0020.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1e7::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7216:EE_
X-MS-Office365-Filtering-Correlation-Id: f006e91e-ee4b-4429-e565-08de30e18319
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TWFCUzBYSE1rK0R3bFE1U3N6Z3A2T3c0aDUxd2hwZlcvczNDanppNFdHcnlO?=
 =?utf-8?B?c0JBbkdXa3krcXE5TjEybHpKd2JsckJXV20rOE42clJ2ZjdNajdZclNaaDJl?=
 =?utf-8?B?K1ZDdWZaNVE2ZGt0Mzc3TjRwVDJUSjNFdW5EMGtaOFB0MEZGVytwNXVJbzRo?=
 =?utf-8?B?TkcwcnRKR3JtOU5nNVg4bitUQ0RQTW4vT2lYZS92a0Y4QnhMb0VnT2tPYm5t?=
 =?utf-8?B?NFg0V1ltNXRRUWVBOU1UNmVZdEtUZWJnMXRSRHNBSmNoaHZPTTdJZlVZU0R2?=
 =?utf-8?B?MXlKU3VDdU4zbGg5UmIrVUVQWjRHNUw0aUQvN2cwK2pJaEZSTDFBUDhBUDg2?=
 =?utf-8?B?Y0VPckpuSFd1TlRLREJCbzQ2T0VBcU1zSmkvbUFmSW42SnA3WUMxdmplVnhV?=
 =?utf-8?B?SmxTNTZEc0p3d1p6c3BEeWhQSU1IVXpGNHFYYkZFcW8zSFpEM3pkcU1BV2FK?=
 =?utf-8?B?YUh5UVVKUE55ZE1hRTJuM1pOUk1nRURMNlZtalFabUdSVzRMSXdBcDdWcThw?=
 =?utf-8?B?Zm1Na2c5UXZJSTkycUVmU0hQMTZ3VFFZVHNtRmtjZ3ZxZi92dDJ6bCtra1RN?=
 =?utf-8?B?OE1HOWNwQUpFdWVUYnlHSVdzOHB0ZUlFRVJ6YnpldEtNYlM4ZU92RmtBdThV?=
 =?utf-8?B?Z05ZWGFSdGplb1RmVUJoYzVJdXo1bWNOMnE0NytPYi9qZUU4NURtbDVuZFlQ?=
 =?utf-8?B?QVNtNHBPNHRhOW1nKzIvWHVQb1hLM0cwREl2R3J6N3ZRcWg1SklaREFkS0M2?=
 =?utf-8?B?aXQxOEZZN0VydEZSa0JENHdXeldYRHFGc01jdmtLMlErMkZuNjRhWWtxbytX?=
 =?utf-8?B?c3JJT1hrVVB0MkZFTEkrWHptNVJTUmZ6ZUZBTnJjNUdJUTNiVlNwbCtTL0hh?=
 =?utf-8?B?ZFpXbVVMYjdNMWJJaXFjWUpuV2NDWUlyQmNaMFhYYW5TWXUvRDJTTkFkQ1pD?=
 =?utf-8?B?NnNhV0hKZGJOcEpjbjNlUmxoRldSTkt3Mk5jWXdhR0FGK3V4UU5nSjhUd2xT?=
 =?utf-8?B?aElGY3JnVmN5dXNGQ2lrWjhEb09nazFDV2xMMEFrRm9zcmMrZkswRXJwckZ0?=
 =?utf-8?B?ZjlUcm1INFF2QTcyN0JmWTFKWCtRSmE4emdPRzRPOHc0a1FDeEZ4a3BJT2Mr?=
 =?utf-8?B?ejhaWWRkTW83M3pqSk85S2Rsa2lEYjNkclVJYTIvZkJ5WmxUTmM3c1JWMUF1?=
 =?utf-8?B?OVlNeTQzcTNvUE5BMnZpRndLZ3pGSXhITHZSMWRCQUVLejNCRDRnUWdIVUtX?=
 =?utf-8?B?TFlWUXp0UmNLWUhQTzZsb0UrTWNlb1VkbVhqcTFXUG9kTlVFZWVYNkZ3Q3Fk?=
 =?utf-8?B?M25lMkkrNzVxVkc4eDVRdnlTTHNnaS9kWGJQcldzU1hQQkhBa2RqWGp2Y3RY?=
 =?utf-8?B?QUJrMEtBOVVGbHVRNHUvNmFEc0JjZDRUT3NlQTNsY1hvaGZkblFjbUNMUVJw?=
 =?utf-8?B?MUdOSXUrQVExbFBtZ1crYzkycElVd2dKdDBNOEl0QkNHQ3U4cHl4cW5wOVox?=
 =?utf-8?B?UktxLytxcFpQOVhObkRObkczQjJSclFiZ2FtWFB1QmZycnIrV3cvUEFLUTdo?=
 =?utf-8?B?OHNBMGdWNU04RERuUVZTUlRsTU0rUlEvampNczB6cWw4L2s2dmVDZzFkcWFO?=
 =?utf-8?B?OUJvSGgyeGhHMmp6MEVzNjRhbVdySWpsUi9ML3dSbWZZS09HUXQ1R3lrek1h?=
 =?utf-8?B?RTl4QXliOEw0bnpTQmJXUzRUSjMxV0kxVnpqcXNsaG9UdGpsOEJja0lIQ0w4?=
 =?utf-8?B?b21xRVQra0t5QUlwSU9Zb0dBbWt4TGY4bjBkSEJYSEVxbVo5T0IzL0o5UE1w?=
 =?utf-8?B?QkRIZ2liakZ3alZnL0taMlRPZlM2WXFWMnhmWWU0aEpFYlZzdGNiYTJwZ0t0?=
 =?utf-8?B?UEwxb3AvdmlJaXhycDF3Wmdxc3VjNVFrdzBPU1Y0SkZHenc9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QTh2RjRTNjRQdGdUTlJsSTdxM2l5V2JwYlZMUE5WcC90RzQrU3dFTTlVZGdr?=
 =?utf-8?B?UU5ZamZpZkxxTnhQVHgrYU5HUDJjaXRJOFM0aEhBUVJxbytHc0liZkdPaVBu?=
 =?utf-8?B?aWRVQktjc2RaRG1YdzBZVnNCNzBBSVphV1pyVExET2NsOUF5dHF2VkVzdXBu?=
 =?utf-8?B?ZHVYREJML0JiRzVqMlFVWEQwb2NlSGp6Ulh1UFVqbnorajVScE5TMm9GVGpk?=
 =?utf-8?B?cnRUM0krSEJheFZWYzNCb3dpYTVsdDZVQ0xMajdMcmk0cks0UXo5RW1wZEJK?=
 =?utf-8?B?cTk3dEpYeEZUUGhrcTM5aUh2WlFTSVBTM0E5WVB5SVh5N1c3TG5jUnRRekNu?=
 =?utf-8?B?NW9wTU5xNlNURjg4MkEveUJJRGM3ejVKNjE2azhaSDNUUzMrZndWTHNFenh3?=
 =?utf-8?B?b0pKbmhJTEs0TXEza0ZFa2pLSUtFNjZJeUMvUEFVVmpEYnNjenJocEE3TStn?=
 =?utf-8?B?SGNyTlJNRTROeDZQell5TTBYclhseXhsVG1yOGJyV0JNRHA2Y29KZ1pLckdV?=
 =?utf-8?B?a0Y1YkpLZ1g4bXVXQVo4czF5dkV2T0g4WHNIWkdGOVdTNGhGVWpSUFNEMnRt?=
 =?utf-8?B?S3ZJYmNEbWxacGZBS1lpdWV6L091OGNMRGo4ckVZMTdxRmFmN3NMcVlGbXFz?=
 =?utf-8?B?YmMxcFF4cHVlcUYwdWhWVEcrb1p2WkJmbk1ld0tZbmJVM0RGNk5BeHZudVdS?=
 =?utf-8?B?dDFVZHVtQ0tLalJSbFJMdytPbTJoMXVMa1owMkNGamhBZDVxd1d0cXlQRTFQ?=
 =?utf-8?B?UjVDaFl2SG5SWUVHWVVVM28xVCtMT2ptSWc0eFFydS9jTWhqRWhRU0ozQXZt?=
 =?utf-8?B?S1kwT1JPYzhQaURsYmVqcHNpVUZPK3U2dlowaWpWUU1peERZOXNvMy9SbXRN?=
 =?utf-8?B?UGJCVzArc21jdnAwdERhZHVKbXg0QTFxQkJLQk44M29OTzVDMnNmNTBhR3pV?=
 =?utf-8?B?VllyVXFRMkFwWUJFNXhVMWkyWEFiK0o5UFdkK3hXMWE5ejN3a0lMSGZYQUNp?=
 =?utf-8?B?b2JRZFpGaGRNWVpuVFg4aTFoZWxRSFlpMHpOTHgya0VpOTh0cFFVdkF0dVUx?=
 =?utf-8?B?TnpPSkdIaEs0VGN1WVdJK1ZyQXZrN2lROHVub1VlU2IybXpWbU4wajl2UTh0?=
 =?utf-8?B?OFhCeCs5WXRqT1hPcHJ2QXpQUGJTQzA0cjFlMVp1TE01bFFoU0UwWDNqMkJH?=
 =?utf-8?B?Z2pWUWFOS2gvRG93UDFEeUNYdjlTODFma3M3SDRsdEVGNGpnR1RpLzZiQ2JT?=
 =?utf-8?B?Kyt0enJoaTZWQkpaTGtJNmFqbzlybUxoQ3J4cm43b1R5NDBpZjJ3UVkwbUV3?=
 =?utf-8?B?QWxMSEhpMnBYREJCV2hKNUpkeVIwcis4N2tJaTIrMUFCZTZzVXVDRCs1UEVz?=
 =?utf-8?B?YzQvQkI0dVFvKzB4ekpSaUZmVCtFN3RReVp0NmxwODlmQkExZFczNHJDYmZK?=
 =?utf-8?B?eXFyRGlpNmpicjUzRU10WW9yVFZMb2RQSWd3TnlqVjlva3ZucS9oN2ZuRE8v?=
 =?utf-8?B?ME1Mb1BjTDJ6ZHRyMW5wTTl0Z1d4S1FNV1V2R29oSklFTWFRMDAreGNmL3V1?=
 =?utf-8?B?djRPTnkxTEhYWmJWTjhrVlczVytXbWdjMjdMY1RrUFF0d2xvdGNiNGx3T01T?=
 =?utf-8?B?SitRenhUdk55b041MzVBMXdJSENLR1NuS1VVbWtZd2w1SzJVcWZiQzBYemtD?=
 =?utf-8?B?SklabGEzZVFUQ0cxTHRxQVZ6SzE2NHlYL0toYXJuSWI2TnIxdXllVzRxYzR0?=
 =?utf-8?B?S0JJWEM1UjhVbkZVZFVXTlB6c0kzeGJlRG5meng4NDBydzVwT2RLZFpmL3VL?=
 =?utf-8?B?bmplcU9hSTh4T0lFM2t2THM1N1hTK3VRRm91OUVvQ1YybzBDVjdVQTVpVUZH?=
 =?utf-8?B?VjkxZktsMGhWNURoYXV2TnhydmdYNTJnamZ4cm5vVTF1bXFWa2ZjVzhla05J?=
 =?utf-8?B?MFpaakhiZndMeFVtN09yU2g2d1BaNVlWTWw5NnYvUENpekluUjdRSWJPdFlx?=
 =?utf-8?B?ZmpvWUxYWGZLeTU5UVFiZk91bnlUUlZBMzgxNk5uQVVvdDdMd2ZhWERLZE5J?=
 =?utf-8?B?cTFoblZ5RnB6TnpNUzJKSlplVGVmZWl4LzNVYyt1aXFBK1o5WWtyTDZKUGZC?=
 =?utf-8?B?N0dzQUVIQWdieHNma2dUOWJZT0o5TUwyb1Z6VTc3Z3pQQlJYbVcvTlFMWHhY?=
 =?utf-8?B?NFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f006e91e-ee4b-4429-e565-08de30e18319
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 13:57:06.0811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WVNGGrdE5yIRJfQhxMVRnWifWtprHvlRzGsGwMz0NamNifoCS4wrbhuoPMzY9hC55QwHqjrcTSPE1j5fx2xsXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7216
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 01 Dec 2025 13:57:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20782

On 01.12.25 14:20, Chris Paterson wrote:
> Hello Jan,
> 
>> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
>> Behalf Of Jan Kiszka via lists.cip-project.org
>> Sent: 01 December 2025 09:12
>>
>> On 18.11.25 15:12, Jan Kiszka wrote:
>>> On 18.11.25 14:04, Chris Paterson wrote:
>>>> Hello Jan,
>>>>
>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>> Sent: 18 November 2025 05:45
>>>>>
>>>>> Hi all,
>>>>>
>>>>> lost track about this topic: Are we testing by now a kernel
>>>>> configuration with PREEMPT_RT enabled on 6.12-cip? Initially, we
>> didn't
>>>>> IIRC.
>>>>
>>>> Currently we're not testing RT on 6.12-cip.
>>>>
>>>> I've just started investigating how to enable this in KernelCI for all
>> CIP trees, but I'll start with 6.12.
>>>
>>> Thanks in advance!
>>>
>>> Can we add [1] to cip-kernel-config, maybe even migrate it over? We
>>> already agreed on not trying to maintain separate configs for rt as that
>>> is doomed to cause even more config-rotting that we already have.
>>>
>>> Jan
>>>
>>> [1]
>>> https://gitlab.com/cip-project/cip-core/isar-cip-core/-
>> /blob/651c38c1c9d837331fb4c4a68a4a75c27163ced6/recipes-
>> kernel/linux/files/preempt-rt.cfg
>>>
>>
>> Any news on this? Help needed?
> 
> I've got a PR [0] open that is clearing up the CIP pipelines in KernelCI a bit.
> Once [0] is merged I can continue work on adding RT support [1], which is currently adding build, cyclictest and cyclicdeadline tests.

That's great! Hope this can get merged soon.

> Currently it's using KernelCI's RT fragments [2], which I haven't tested.	
> Once some tests have gone through, I'll look at adding the extra configs isar-cip-core [3] is using.
> 

Yeah, it's also about functional vs. performance/latency testing.
Normally, you do want lockdep on (which none of the configs does) for
some functional test, but surely not when you want to check for
excessive latencies. I notice that kernelci turns some tracer on, we
rather turn some latency sources off.

Jan

> 
> [0] https://github.com/kernelci/kernelci-pipeline/pull/1382
> [1] https://github.com/kernelci/kernelci-pipeline/pull/1368
> [2] https://github.com/kernelci/kernelci-core/blob/main/config/core/build-configs.yaml#L684
> [3] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/651c38c1c9d837331fb4c4a68a4a75c27163ced6/recipes-kernel/linux/files/preempt-rt.cfg
> 
> Kind regards, Chris
> 
>>
>> Jan
>>
>> --
>> Siemens AG, Foundational Technologies
>> Linux Expert Center

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

