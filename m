Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6150CCD1BF
	for <webhook@archiver.kernel.org>; Tue, 28 Oct 2025 15:24:49 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.34])
 by mx.groups.io with SMTP id smtpd.web10.14682.1761665079722898352
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Oct 2025 08:24:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Kfb4RXp8;
 spf=pass (domain: siemens.com, ip: 52.101.84.34, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F/E+iKA3MUDOAmLvteXWpJX2i79jqZso2TwwjHT6PryBaKB1DU9OWgnPoQ83t0uv3tRxBRU5Dc71Gu+YD+RZ7c3/Y1CNWFPYdM72YGfCQA47pwRWB58cUiO4FBEv3b5KpNVt7RQqbFD1661/NG/FpKAIhD6XRK98suDdmJD32DIk/8cACeh70VOoDi9LCgCVD3hiTjoFLq3qi21jj8J2PBGbr5dNBNvd8APqmZsHfHQWV9a9PU03X87i63KFyUnJDnDDPrQw2WbEMAJndofj7RJBHp0V/akuo5XdKSRAfHyT8HnFBWIIqoPJspATkGl1TjtnvXD7r2ywkjLvGA67pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nDhzJZ3YHhCPZZ+SkpwVpcAcFN6VDXdWMH9SD2FnyY=;
 b=nYwc3rdJYuzmSNGzn4xV4EmO7q9onh9j6GNOFUFiQi3DUTYivAeM0+3Df6j6LKUlxboneBkNVtvq74zQm7bmvyDY6uWocD+ikkBru5/9gpQ2QDsGRBOxmdqP12t+/pLs2Oxqn9otqbHBfqvQUMlz3QnZWBtAdnOkxd/DXKW6GVbdVwEM4JQvaQ/PtVvDWNuUnDDsMjMxvvsMdslqktBnWNiSKnstR3qb6Erq+d2FQERN77KvXtugymd7J3FIrpN4y0W2s2v8Y/pwE4/wByDrdH68Pt53xBy2lHvTjAfgllpi7tp5kHaNvyHhZr4328or0UCfD26EgQ9mjdPUD+zFcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nDhzJZ3YHhCPZZ+SkpwVpcAcFN6VDXdWMH9SD2FnyY=;
 b=Kfb4RXp8xv95/WUfAmEkeAWv42qEKrRtdefdjLRUnT35JEOTZu38+RgQODngXGYJkmxUb1kvXmHiySlrZBPS3bQXukZgX8TfmLWN0ZENaj96DxagKZuWKSFgDg2dpDSKmK5+May2QdyxjSEQSouSXg/sEWNIHGnbNbvnAvAfp/G9NmCP9OFrwA8MVP5G/rbBot/NXkGaKkHpBiDux+GTwSqrIWvDRM+vIBvnU90ecN0qjoBRwXVNmTysRJYaRUZ36hWdVXXBjp9ABwxzmcNOERogNMxS84QluS0gyBYuYl1Rv0g5Yy+NyYYbApNxMfJK5KvVPjPWRGHsdg1+eVUvmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB8458.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:445::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 15:24:36 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 15:24:36 +0000
Message-ID: <f898ef4f-dbd8-41e6-8edf-9552acee3e78@siemens.com>
Date: Tue, 28 Oct 2025 16:24:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][RFC v3 5/5] doc/README.swupdate.md: Add section
 for software update with wfx
To: Adithya.Balakumar@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
 kazuhiro3.hayashi@toshiba.co.jp, akunuri.sahithi@toshiba-tsip.com,
 "Adler, Michael (CT RDA IOT SES-DE)" <michael.adler@siemens.com>,
 Christian Storm <christian.storm@siemens.com>
References: <20251028122042.2355451-1-Adithya.Balakumar@toshiba-tsip.com>
 <20251028122042.2355451-6-Adithya.Balakumar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20251028122042.2355451-6-Adithya.Balakumar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR07CA0003.namprd07.prod.outlook.com
 (2603:10b6:610:32::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB8458:EE_
X-MS-Office365-Filtering-Correlation-Id: 05112cf3-2be7-4b56-be20-08de16361aa7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SlVKNGlocDZSbWpUU2tGUk9rcmk3VlZkN0l3b0dnRCtBdFdrS0NyS0t0VVRy?=
 =?utf-8?B?YnhDMzBsaWM0MzlDd3VwR1lEZTR3UnlwWkFSYTFES0RGcE1Ma3ZIVTNXNVNI?=
 =?utf-8?B?TjgzaU1DeGxabEhZYTVHT0ZYTE9PMFlWZ0NYRnQ0ZnJ1enFGa05OdlVnWGxM?=
 =?utf-8?B?LzBmT01oK2Z0R3hFM1Y5VVhvYzJYWmxCVExQN1padkFkS284WVBLSmdGOTEz?=
 =?utf-8?B?VlVWaUJ1ekVWRm1DeDc2ajlnMmVSeTYwQ0RNRXdZNXdXRUdTU3I0ZW55RVdp?=
 =?utf-8?B?eE9Cb0Z5cVNsUVZnczFYSHY3SDdFZGhiSXB2TkFvM1JweFphRXFQSVFoaCtT?=
 =?utf-8?B?TjdMUGdSZEVDUHZlRjlRd3NITXpYVFV4WUpPZ0FCaHJzWllLSW9ITFdsSE5o?=
 =?utf-8?B?czFWMDBueUtoWXdjOHF6Y3NFK2FLdlVRR0pxT2JsMkplMmhUZ1ZJVlBtVnpx?=
 =?utf-8?B?UHo2RjJaVTFFWXJhcis4Z1BRek1vaFVyRmxUTjlaenBqbllCTDJqNS9rUDUw?=
 =?utf-8?B?Y3JXM3NqajFSbHV3ajRCUlhNRkE1b0dlNW1OSVlaREFpejlEa3Y2R3cxMWFB?=
 =?utf-8?B?MHIvQ0lRT0kyWk1xb0h0NjdNQ1U5NUZhWXZ1amc5c1pSTHJVTWYwMUF2SVM4?=
 =?utf-8?B?SmJvRTI2YlhnN1YyWTRJdUlWM011a3JkZ2JMclk5NzRkSG9vQVEvL1Z5REdP?=
 =?utf-8?B?TEpXQ05vb1d5bUVuN0ZKcE5pRUxXdXNiY0dtUDVWeThQRk5lTUZLbm5JS2pu?=
 =?utf-8?B?K092dU8vTWZCMGErU3YzL0tPU0kxLy8wRXRZQTlQTHFnU0MwMGYwVG9qMjJz?=
 =?utf-8?B?blNRMnBGcVA3NlBvMkdMV3NkbFFXTzV1WkZ1VGl0cnZYcWZYSE5qS0RUeW5p?=
 =?utf-8?B?Qit0OFdmSzR5QUlINHREbnZqOC9XK0o0b3VwQytsMVhSWCtTZHhobkhTMVMr?=
 =?utf-8?B?ZVd1Qm1NU00zZ1pSWnoyWXNXdXF3VVMyYlpwSmRVZ09BT2xnV3BWVG4vcGV2?=
 =?utf-8?B?UlpxQW1lNnM5QTBOeUw2a3NtQTJGS3Z1RkJVY2dpZEdkaG9YVWN0cmNBYjQy?=
 =?utf-8?B?TWsrUXlxY1JnMStZYWMwaDJxdnVaL2pTemVPOWRJMlFIb292cGZlSlZjZG43?=
 =?utf-8?B?dWh6elp2aXN4QkFrRGx6WUV4aHVsaTZLU1NzeGR6M0lPS2l0TmxRbzJPOVQx?=
 =?utf-8?B?VERLem00MmxQTkFWQ21BWXllNTRHZTdHeU1uRkI4V0F1aXFuZmtsbVEvNlp6?=
 =?utf-8?B?TGJlYTBBY1dFQkhJbEdsZlBBUFpNQXhtbXVDYXc0OGtIbXNUOXFtTWhaYXg3?=
 =?utf-8?B?cUpEQ0l3OG1rMzBXelZFbTFiVWJGRldZOGdRdEtQMG04alVpUmNpRURpVk51?=
 =?utf-8?B?c09kSGdDRDVOZTZNRjZ2VHZRUzBrUjVjZG9tdlI3V0tlYVZuOVAxUkJrdm0y?=
 =?utf-8?B?a0JoeWVyVmpJUjEvYy81ZGVELzIyWkZkTk9ueDU5WktCYmFiL21Tdm1halV1?=
 =?utf-8?B?cXhNQVc4MnlhaEgxdnFUMHpMQVBjVVM3WklialpCRURqNUhCT3VpTDFVK3lL?=
 =?utf-8?B?K0tHaW9UeUw3MU1ldDBYUkJRRGN3ckRFdkcrV3JxNmRQYXE0eHN5UXBpdkNL?=
 =?utf-8?B?bzZRUDJKbTk1NGNnN3JNZmU3NFloMUZLWnprazh5SUdVUlJJcXlrMU9GNENQ?=
 =?utf-8?B?QWNPUWhnNno3WmIyMHB1TUJaMlUvVElOdUZKNm5HNzk5VUsvZFJXSi9iOXZm?=
 =?utf-8?B?b3hlUXpaSFh5eEZpNWxBOVh3MUp2bEltV1l5Y2dMb2t5c0hacFh0a216bWhM?=
 =?utf-8?B?cURnSnAra05QYzRFU09zZitkckFsOWxlNXFKaDhpYlpSL3NWME8vTUQ4QVh2?=
 =?utf-8?B?dTN5UU1rL3BCYkp4b1hsNVB3MjN2THUreW1NMlZSMFVQRVE9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?L1BrTzVFMG5qanZ4YlIxVkNCQ2MwaVFkaEozclJaNEYrWmJBTVV4NUJlQU9V?=
 =?utf-8?B?Z1k4cnZEUGhNaWlzSmF0dDBpOGJ4VFhBYUlqZDdUNDIwSHBBYWM3cXo2ZjhV?=
 =?utf-8?B?NHRHeTFTSHR4cDU0eEV6dnRReEJDZ1g1T1FjbHBZZHY3L0pQalhVS3ZSbnBC?=
 =?utf-8?B?QXRGOVRPUFdZd3dFcUo5VVRyWHF3WldveEhSNTFDblFrZW9KWTdzNFRMaWwv?=
 =?utf-8?B?Z1hXMDh1SXZ1dHl0d2ZTbE5Tc0xGUmt6UGUyL2kvTnpJT1R3QWIrTWh3Q3NS?=
 =?utf-8?B?dk40OVFvT0FtUEZWbDNFY3Q0cUswaVdtNHpNU2NFRHZHeXRIaStQK1RyWlRH?=
 =?utf-8?B?MTNVL1gyYXl4bndSVFlLMDJCdHpQV3R5UG00WFdGQSt6NFd4M1VRZnkwVVVy?=
 =?utf-8?B?alhibmovbWU2MnowazVMTHBXWEs0WWphT0FOS2NBc2kzRDJVcXQ5dUZhVURW?=
 =?utf-8?B?aGthV0I1M0ZJNkhUcUlEditQMTY0ajd4RW5GR2dYWlMzWklwb05KNS9tZy93?=
 =?utf-8?B?Rm1mNnRVcG9XZ3RGWWtTY2hPaUU3V2FhTXFIRHJKdVdIS3pxWjd6U1F4Sk90?=
 =?utf-8?B?ZFFUU0Y3NGliMG1oNDBMVmxOM082d1VzSGYwOWxscE1hL1E0eG5mTnc0MUY3?=
 =?utf-8?B?RVB6enZWcU1jc2g5bkYyWVFpQXNOcm9VRERIbWc5aXhvS1ZvbG9HSkQwUC95?=
 =?utf-8?B?WnR0WHlMNURDWTR3akVxQmM1ZVh5UUd1clVBYTFrbG1OSUtqeUxMUEF5NFFh?=
 =?utf-8?B?M005bjQrZzRZMWI3ZkxBMUwrRnJLaVdvYmJCZEF2Q2V1bml5RWppZnJlY2lG?=
 =?utf-8?B?UERmMUdRRHQvL0V2VktKT0NYd2tCbkhGZGNpbDluWVpkZE5jZCtaakdXcVlR?=
 =?utf-8?B?ZmxmVkZCZ0tPeEkzQ0JYeW1tUjM3bUtrQ1JxK1A3RUloY1drbkozSVpNaDBj?=
 =?utf-8?B?WWhZTHlFVkVzOVY4OWczYnZzcmdQZjFiaEc3V2x1QkZyV2R0NzNhWUhuQTBX?=
 =?utf-8?B?eXJKaENiYm5XRFZIOGdpbTl5TVFzUFRjcXhGa09haWdoMk0vT3c2TmhKZ2lB?=
 =?utf-8?B?djNiNUtlR04xRHZ3TWtweENwdytPOWtaVXlGVWtZYSswVlptMzUwcHZNL3dV?=
 =?utf-8?B?RmsyRnJ2cW9rZkFXMjhOSkJQSDJJblZnd3ZyMUw2c3VyVXJJb2FmZ2RqZ05i?=
 =?utf-8?B?dGg5QzJmVXhxVTJlMEdoUjFaakI0a2F5c0RxNG4rZFhVVkRiT0dPYThnVjIr?=
 =?utf-8?B?bjZ4VVNWWW5Dd2VZRlliWjBmSHEvSGhCK2VlMnZ1Q0pkckZuQVNyS2RvZFpB?=
 =?utf-8?B?OU1aVDUzN2VtZUdLc1FsRUhFOVNSeU5WS2drMGVnMldnVEJ4MFo3b2NIYWpQ?=
 =?utf-8?B?MEsvUVRVczlUWHgrc2VHRHBuRkNENndXc0N1d0VBL0REbzBCYmI5eWc5SGZR?=
 =?utf-8?B?dGErUEpyWVpFYmZmdE1STlJYcHhmdjdvaVRmbWZRcGIrNkd5V2MyaXRLUzlo?=
 =?utf-8?B?b01rNEJ5TTZ5aVJUajQ4aFVmbm9kSmliL0hFeXlMeHNJVkVkTXBiOFNKQmdD?=
 =?utf-8?B?cDl2eTRPRHBpcGoxQ29xUlZyVzM2NzdsK295bm5UeVpFN3dGb2FPbFhoZ3Y1?=
 =?utf-8?B?WGJvWXVSenZITElLb1oyVUx5dURjS0twdC9ITGZOUHRRRjJhWHBKdlptdUMx?=
 =?utf-8?B?VFpIWE9BZ3V1UXpUeGlDcTBQSVVjVnlvQXpJOStIeWljZGV6UUpuQlBWNjBS?=
 =?utf-8?B?Z2lhY3JtZUlnMnAxc3ZSa3hCbXlLUkJuUVJhWEV5SzhZZGlQVTc5ZmpPcUFR?=
 =?utf-8?B?RzNKa0ZSK3hEWStlQkJzVzlMUk1rczhkTVg5VWVRZFdqdEtaUSt0OWFGdFJV?=
 =?utf-8?B?TlF6Y0JrNHVhU2ZySmxkaVFNcE53TGFTTkRwODJqZHBaeS9iTE5DQWZUSEJQ?=
 =?utf-8?B?b2RZazJoN240eEVzRzhkUHd2VlFsbG8wbjRXbFo0VFpkMFhnVUZyMkloczZ0?=
 =?utf-8?B?eXZrdjRPZ0JNVFlaSlIvMzRtTnFzV1JxT0YwUDh2SlpLbUF4dElmdzdqUStv?=
 =?utf-8?B?RzVqVytpTXV0bnBpck9IOGxjdXZOb2JLWlIwVUhjVC9TRkNhejNyak5YQ0hn?=
 =?utf-8?B?a3ltNllTdTRBMHc2dk1xVDgwcVZDampuR28yYkwvTWMwUktudm1Ka1kwZUk1?=
 =?utf-8?B?OWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05112cf3-2be7-4b56-be20-08de16361aa7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 15:24:36.5882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MvzGFDVOBQPwGArf/NQo3SlUl3uZvMuQQM2nagkWSxG3Gqh8emtw5Jnlx3QSFoytY7h0VOLYgi1qNtlJ9LR/dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8458
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Oct 2025 15:24:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20265

On 28.10.25 13:20, Adithya.Balakumar@toshiba-tsip.com wrote:
> From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> 
> Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> ---
>  doc/README.swupdate.md | 124 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 124 insertions(+)
> 
> diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
> index b68b5b7..5e01b02 100644
> --- a/doc/README.swupdate.md
> +++ b/doc/README.swupdate.md
> @@ -464,6 +464,130 @@ Any http server (service) can be used to host the .zck file as long as the http
>  
>  Follow the steps mentioned in the section [SWUpdate verification](#swupdate-verification) for verification.
>  
> +# Software update with wfx
> +
> +**NOTE**: In the following sections, please replace `WFX_HOST_IP` with the IP address of the `wfx` server.
> +

Does this have to be an IP or could it be a DNS-resolvable server name
as well?

> +Set the `WFX_URL` to `http://WFX_HOST_IP:8080/api/wfx/v1` in `kas/opt/wfx.yml`

Please do not recommend hacking checked-in files. We have Kconfig for
this, see e.g. WDOG_TIMEOUT.

> +
> +Install `wfxctl` in the host:
> +```
> +host$ mkdir -p wfx
> +host$ curl -LO https://github.com/siemens/wfx/releases/download/v0.4.1/wfxctl-0.4.1-linux-x86_64.tar.zst
> +host$ tar --use-compress-program=unzstd -xvf wfxctl-0.4.1-linux-x86_64.tar.zst -C wfx
> +host$ rm wfxctl-0.4.1-linux-x86_64.tar.zst
> +```
> +
> +Build an image which will later serve as update package:
> +```
> +host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:kas/opt/trixie.yml:kas/opt/wfx.yml
> +```
> +
> +Save the generated swu build/tmp/deploy/images/qemu-amd64/cip-core-image-cip-core-trixie-qemu-amd64.swu into a separate folder
> +
> +```
> +host$ mkdir -p /tmp/artifacts
> +host$ cp build/tmp/deploy/images/qemu-amd64/cip-core-image-cip-core-trixie-qemu-amd64.swu /tmp/artifacts
> +```
> +
> +Next, rebuild the image, switching to the RT kernel as modification:
> +```
> +host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:kas/opt/rt.yml:kas/opt/trixie.yml:kas/opt/wfx.yml
> +```
> +
> +Now start the image which will contain the RT kernel:
> +```
> +host$ SWUPDATE_BOOT=y ./start-qemu.sh amd64
> +```
> +
> +Check a generated client `id`. This `id` is later used to create `wfx` job for the client:
> +```
> +root@demo cat /etc/swupdate.cfg
> +
> +// trucated output
> +suricatta :
> +{
> +    id = "d93f5e37a20f447cab0c4110202f1c97";
> +    url = "http://WFX_HOST_IP:8080/api/wfx/v1";
> +    polldelay = 20;
> +};
> +```
> +
> +Start a docker container running the `wfx` server:
> +```
> +docker run -d -it --rm \
> +  -p 8080:8080 \
> +  -p 8081:8081 \
> +  -v /tmp/artifacts:/var/artifacts \
> +  --entrypoint wfx \
> +  ghcr.io/siemens/wfx:v0.4.1 \
> +    --client-port 8080 \
> +    --mgmt-port 8081 \
> +    --mgmt-host 0.0.0.0 \
> +    --simple-fileserver /var/artifacts
> +```
> +
> +Create `wfx.workflow.dau.direct` wofkflow:
> +```
> +host$ curl -L https://raw.githubusercontent.com/siemens/wfx/refs/heads/main/workflow/dau/wfx.workflow.dau.direct.yml -o wfx/wfx.workflow.dau.direct.yml
> +host$ ./wfx/wfxctl --client-port '8080' workflow create wfx/wfx.workflow.dau.direct.yml
> +```
> +
> +Create a wfx job that updates the device. Replace `WFX_HOST_IP` with the IP address of the `wfx` server and `client-id` with the `id` in `/etc/swupdate.cfg` in qemu:
> +```
> +host$ cat <<EOF | envsubst | ./wfx/wfxctl job create --client-id 'd93f5e37a20f447cab0c4110202f1c97' --workflow wfx.workflow.dau.direct -
> +{
> +  "version": "1.0",
> +  "type": ["firmware"],
> +  "artifacts": [
> +    {
> +      "name": "Example Device Firmware Artifact",
> +      "version": "1.1",
> +      "uri": "http://${WFX_HOST_IP}:8080/download/cip-core-image-cip-core-trixie-qemu-amd64.swu"
> +    }
> +  ]
> +}
> +EOF
> +```
> +
> +Wait for the next swupdate polling round (every 20 seconds) to see how swupdate downloads and applies the update.
> +```
> +root@demo journalctl -u swupdate -f
> +
> +// trucated output

truncated

> +swupdate.sh[432]: [TRACE] : SWUPDATE running :  [start_suricatta] : Suricatta awakened.
> +swupdate.sh[432]: [DEBUG] : SWUPDATE running :  [notify_helper] : Suricatta querying "http://WFX_HOST_IP:8080/api/wfx/v1/jobs?clientId=56d08a92-b08e-9211-e8e0-45ddce7a4c04&group=OPEN"
> +```
> +
> +Once the update is successfully installed, the device automatically reboots. After reboot, suricatta automatically updates the bootloader state.
> +```
> +root@demo bg_printenv
> +
> +----------------------------
> + Config Partition #0 Values:
> +in_progress:      no
> +revision:         2
> +kernel:           C:BOOT0:linux.efi
> +kernelargs:
> +watchdog timeout: 60 seconds
> +ustate:           0 (OK)
> +
> +user variables:
> +
> +
> +
> +----------------------------
> + Config Partition #1 Values:
> +in_progress:      no
> +revision:         3
> +kernel:           C:BOOT1:linux.efi
> +kernelargs:
> +watchdog timeout: 60 seconds
> +ustate:           0 (OK)
> +
> +user variables:
> +```
> +
>  # Building and testing the CIP Core image for BBB
>  
>  Follow the steps mentioned in the section [Building and testing the CIP Core image](README.swupdate.md#building-and-testing-the-cip-core-image) for creating images and .swu files.

Adding my colleagues to give them a chance to check the wfx setup as well.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

