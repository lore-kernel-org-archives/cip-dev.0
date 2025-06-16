Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119AEC71159
	for <webhook@archiver.kernel.org>; Mon, 16 Jun 2025 19:13:17 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.6])
 by mx.groups.io with SMTP id smtpd.web11.556.1750101193837673976
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Jun 2025 12:13:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=w3nOY4Ol;
 spf=pass (domain: siemens.com, ip: 40.107.130.6, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mUEnz5136BVfQsNynmI863gHGyXwt644xa/+7EEtlDTwyCOdMbVQbPThH0JIGklcPOKc+kU1gIMt0CnbV21px+PUku+YI4CJyBLMdDxLfsSrQyItJX60EmIdsDwnJ1cpTuEu/bcWyIbwcYA50nW+rWihbfqOw6zdteFByf9Ckq99glvBHtKEXQJrqGaopDkoPQFda7wYt+u+G72p2Y8og+6q/YI+oxUmyLSaxSg090KEdV1zI7EPxVOaaPj+YS419NkmF3XYwkKkrYXmL4uTFjbDjWx3RBBRVF5bllsDgDtIkkN+6E5P3bx9QILWOTqy9VzdLSugaeR5YvO1wAj4DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BNyYbfJ1JS4e4iIycWzparSmfU2g1HPFskSNLnac7jc=;
 b=yJG2iMyNb1JBl8wHe4kAij0/0LGbcfh38+XxHDwQGYpFSyJtbSgrRHpo8n8Z9cYQvnZpDpH17Xf8R9gq8evFu78oMntC8ebD7ObyOri4L9niIYxYLRb5jFVQwHHURsTJgfGTOjNsz9hpfzhsICuDjPpNpRkm83q0+T6YpGPDrhjJepPIyNHusbDfpkKzGr0Qkee+0OhxlP1RXs+NmU091h/fu+c8Y6Yf1cMqgaAwWRFpMBRsmOvTpS7rhZTlJNA4OQVB94OymkEnk8mzUGCueYSn5MhAkyG+rdRvwflN+MxYTAd4Yz5eEhb4aXD50yfB4nCB4R17dHeZipEmxdLJfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNyYbfJ1JS4e4iIycWzparSmfU2g1HPFskSNLnac7jc=;
 b=w3nOY4OlfH4jsSot8wGrQJ+ZIqekzPf7qjJi88rVwIv0TDqxvHe5hHRHcpLKo8whR1d4WhfLRzflKp+RjsSKizCa3RLb+pjAUWRtq0P06zfXS3IuO+4RrQ86P6pAv5o4kExS/mPmIyvVME5YSNAxY174A1TId3ZW/i9QBckzoGtVuFiq4vw1L81DP/K1zXu3FLotXjGFeZeBWdhi/6Oyh03S7IHkH0ruQbgc1n8Cr+jJW0Icitud7IsDKjfIY1GeqZmdu1h/u7VugPmbkvMj/jSc2Ahtgibv/brgJ3g06zIGee0BQWEJsqpyLzDaV8cYOFgHzVRnIUPnAd+VkVDeaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS5PR10MB8123.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:650::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 19:13:09 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 19:13:09 +0000
Message-ID: <d159b4ad-c6cf-4858-97db-1dbd40d37d7e@siemens.com>
Date: Mon, 16 Jun 2025 21:13:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v3] fix: Shutdown the TPM after
 disk are decrypted
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20250616184432.2170407-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250616184432.2170407-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0020.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS5PR10MB8123:EE_
X-MS-Office365-Filtering-Correlation-Id: 80fe4e0e-3e48-46de-ff6a-08ddad09d496
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?anZPZlJwZW9vdW9lckl3cWxOV05qQXE5YzdFSHJKQVdJSmMrS2FlOTJVTDRO?=
 =?utf-8?B?WkMxMFhtdG1BdmhoeVZYR1RyQWVRNVlsYTFPZi9yNFNKQk5VdzN3MHlMY1R6?=
 =?utf-8?B?blE0cldjZ1pMejBQWEtaTnA4NkM3cVJkazczMy8zeHVKaGJlMEpVR0gzWUcz?=
 =?utf-8?B?RUlYUlFESVNiTW9oaG1VcXlPSzEwdWJ6Uy9xUTNTT3lha1V1TzR0bkhwcEhy?=
 =?utf-8?B?M1J0Z3ZINnNaSTgxbDFnWEhyWGI3NEV1bFRhV2lKU2NxdXhUN3h5Q1RPamR1?=
 =?utf-8?B?NnRURVJiOUdmWkExWmxzTytZdFQzRHRtUDc1d3BOZE9yTGphQ1ZoQXBwZ1Fs?=
 =?utf-8?B?b0YrbHBaWi9FM1VxY3BOZW43MS9IZkxkRWI5VUtPbkFqZXpzcldJQThxQTVs?=
 =?utf-8?B?TzRkSDVMaTFvOWJaTldhOURUMkpaTExacjNscUtzaU8vaTBQL0hmZjlhZDhF?=
 =?utf-8?B?RGJGR1BLcWFpVU4rL3J2Tlk2RXRrbHFocDlJRVBFZ0JnQ0tLOFR2M0c2SWdr?=
 =?utf-8?B?aEorNW14VEJicjc5UW9SRWJiYlUxUHIyRyt4WUM3V0REVFZ6M0VsN0lhSG8w?=
 =?utf-8?B?WHZKdE1KYVM5Y3hkYVZvMTA3N2hlQjN3OElkY1Yzc2Fib2pKMmI3aTYxZjJP?=
 =?utf-8?B?NVowbCtHUWl0YW9iK1dJdloxUVUyclRDUTFXV0JjYzRPTzQrejE5dHJQcHJ5?=
 =?utf-8?B?a1FrVE1mdE80cTNtN2xTY1lobUFVY2xJdjFpcHFMYlpoamwySDFhSS9tOXV3?=
 =?utf-8?B?cE1wVzJRajFHb3pHaE1SWnNFd1ZXei9qenZRb004Z3hWMkRUUTV4OFRyWGdQ?=
 =?utf-8?B?WS95L1NaVEdTYWlwNTJmL3M3WDlyT2ovc3FpU1RLdkh2VDJUSjhVTXhWbVpC?=
 =?utf-8?B?dmkwTzI4cGU1M3ZQT3Y1M3MvNmdab01yZGxNekdHc3FNMkFvcEtuUUpJMnFj?=
 =?utf-8?B?bHdjMU4zYnBoaUN1TzYxem5zdFZRQVJteHVRbjNWbU9PT2pyU3owcTQ4M3hu?=
 =?utf-8?B?Vk5xMFRtbmkrbE1uSHJZaWY1VVpsWXF1a3lISFkxa0ZjTFVjUVI1bGUzNWg5?=
 =?utf-8?B?ZmRiaUVpRFVFV1JRa3E2Sml1K0NuSlBLY05ycVg5eEVEUWtYSDRUd0x4OUg3?=
 =?utf-8?B?VTVMNHZXQ3RlSEh0TytXL3phZWpGY3J5K1lXVzBLSU1JNEN4ZytONDU3MDMz?=
 =?utf-8?B?QnhYUDBET0E0RXB1STVmOVkvVDRwZTZORXA1U2hiV0NLcEpuNkU2ZnIrUUNn?=
 =?utf-8?B?U1pOUUErY1JEY0tjK1NVNEZ4cWNiMFFyWXFQTEUrenJGc1p0STZLenZOdEVk?=
 =?utf-8?B?M3c4em8rY1oyTERkekp1UjMveUg0SUFJYmlzeGVrYlNCRnlaR2pMb3lxeGl2?=
 =?utf-8?B?RTYzV0FjRjVxWlM3T3dBV1ZISlEyS3VaWmdpSG9sWGxoVTViREN1S2diRlBo?=
 =?utf-8?B?SXNXZDhtTlB3bXZteGZsSFB4SlY2bUszbXVTMzJBRldxam1KR1YxMkEzblFX?=
 =?utf-8?B?cDZWeDZKNUg5cnFXdDRaSzdiTXJETW9aMlV6Qy9tV1gxRVQ3NFNjeXMydjk0?=
 =?utf-8?B?UGRkYjJ2YzBDREdRc2NWWWRBWHk5ZUJQRFNWckxIRW1XRXp1UXIyUGVDekZz?=
 =?utf-8?B?ZzFqell4RjdDS1NlQnVGcXlVYk90cEZha083NTV1bXlpcmhKQ3Q1UG1ENlJQ?=
 =?utf-8?B?SVZKRTJaVzBRdTBYT09qRFhHTU0vL2kxTGFrQ0lNRjZvcDVHMkl3QXZKUE5Z?=
 =?utf-8?B?YWFBSVNpSldwQ2J0RWpEUE84WDZ5YkhyMTAveDNxVHNLTHNyWUdqQW1FOE5I?=
 =?utf-8?B?a2NzZVlMalF1UmdxeDR3V2xNNk5qVU1pR1MxeFdwam54aG9HSlRZejU4SEtX?=
 =?utf-8?B?N2dJMnJEaEF5bmF2TzNlWkdSbmltVGhSajVqLzlJK0U5V3dHK3BnTEJXSDNR?=
 =?utf-8?Q?Cpg99nyKwYk=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WFgzNWlZb3duT3VNaWNMWXBGZjJaUE90eVpyZXVTbXpFSjNCM01YR1dOZFJT?=
 =?utf-8?B?UUlCWlBPT3lRZnk2RDRsQU82Zy9SS01JcjN3Z29HYmZTS3JOdUdNN01yYUtL?=
 =?utf-8?B?cXVSRENFTSs4ckF0VzA2eCtBY3lYMkRQZ3p4Vkg3TWp0NlZNZFRVWlhRVDV4?=
 =?utf-8?B?OXNZc2xRWlVPZjdSZ3JCb1hnaU96MW5YMXQzRmNRQlV0VXJjRDhvTnUvaHdS?=
 =?utf-8?B?bGkzaTFiVWlPdEFlbHkybHFaWDlwOGRpdHFnRXpuZjBPZ2VWQXk2Y0VUYzRU?=
 =?utf-8?B?bFZkdFo5UUk3TDRYdmU2VTlQbDNkQWVHUVVIUy8yL2JYMUY5Wm1wVTZUTHNH?=
 =?utf-8?B?Y2Y4ZVhqNTNzVytZSCtLS2J3cjVkQU4zTlZnczhja1ZmV01zUW5EN1MxNVdU?=
 =?utf-8?B?UzFyazhDWENjY0tDRjZJZGlGZlNpRmtBaTlRNHNRQ1JLU1dCVXZtNkRFSEdk?=
 =?utf-8?B?K1RzSjdOUnBKcklrVDFRNjRPamJVUmxiRVpkbzBXelVITWFFZy9yQlhkbEZj?=
 =?utf-8?B?aFdnTm1MZTdDMmFhQWg1T2RlbDhiNWkvSSs2L2J6aW53QW91Qy9lNGtXcTRT?=
 =?utf-8?B?cVBnLzZ6eE1pRiszb0g4L1pVOHFqaURJclVwWkFaZDdJdVNOSXZ2OVpaajdh?=
 =?utf-8?B?ekkwUU5oVG9GUU1zZjVPUTh6Mko2WFRmdjJhMnA1UFZoWnhRckwvbWRTL21t?=
 =?utf-8?B?Tzc5TFhlRkQxaGFYOVE2TTBqWjNlT0dYWjdDUWltc2dWYnlVY0prblV3ZTlB?=
 =?utf-8?B?OTdhUktINGVSalR2QnhTREF6N2NZQzNKYnhDSm0xOUpHQVV3aUgwM3cxSDVw?=
 =?utf-8?B?dXRaaTd0OEtHK08yUFQ4elRNZVA4NnZBOXRkQmcrZ1k0aSt4cDJQczMrTFZG?=
 =?utf-8?B?ekJlM2hGK1NpeXJiUEZzUTlvejRJSVptaFVOb25UY0RSSlVLdXVFcU5uSWdh?=
 =?utf-8?B?ZzNuWjlsTElwYVNFT3p0a1JOS1ZvQ3dKZWJGakM4UENuL3hIYkljZVhaeWVt?=
 =?utf-8?B?ODZ4R2pQUFBISHNIaEd4TmdnSk5FSUFuNE4wMWRBSnlBS1hnWnRjUFVLOVlq?=
 =?utf-8?B?Y1NaL2VkU2UvSnZvbWxEbS9YQ0kwTER3SFhlbW4yaHFKZUYvdVFoaWFwUDJs?=
 =?utf-8?B?SmFSbzZmdDYvR3lTNE1nMUlGdGwvdUg4TEl5cWVZQ2VuS2JqWlBWdDIzUlFq?=
 =?utf-8?B?dDllTTU3VUlFdXFNYzVKV3dTcVVFdmhNYlp1Rzh3aHROZlNFUjBlQncwWXJV?=
 =?utf-8?B?OG16TkFkeWI3aVlyVzV3dkdTcGJsRnV1QWoyQnNxUS84cFZXN1NYZFBzeEE0?=
 =?utf-8?B?Y1lKMFRzajl6NHZLa25KZGFYZUhWOHRXRHFzMy9qV3VhNDg0QVJiTk95UFZJ?=
 =?utf-8?B?dWtheEozTUN1QytWZmxyRWVwT0cxYzJKQU1ITlUvTHdlMGRvanVFbEh5TWhR?=
 =?utf-8?B?WGZvSjdCUnIvMkdnT3JPZ3FjUXNGMDhnOHh6bUt5NkVPUjFIZitlZnFRcUhP?=
 =?utf-8?B?S1ZBNmxzWDZVQkRqb2V5Qnh4SGJQWVBjSE1IbDBGTHd1R2JxWXBPRDZGS2Za?=
 =?utf-8?B?VTRVTzQvVmRnMnJsaGQxaTBCVHNSeTNEQnBFUy9nWWxVcVhOUTJnMEJ1UERU?=
 =?utf-8?B?YXM2U1ZrZ2Q2Rm5ERUtDM2oxYVlKREdvRUdHMFV5RS94YlROWXhzSUd2T0R3?=
 =?utf-8?B?UmZxWUdCbHc5TkJLT25kMmdsV2Z1bGxqNHRIbm9OY0ZqNlZrN2FpSEp0M016?=
 =?utf-8?B?VGRDd1Y1TU5LOE1Ub0k3UTg2S0pyKzlieWN5L3plUlJDQnZDQVZKSlZnR1hY?=
 =?utf-8?B?V0V4blhmU1lxVjR0ZXArZlptdVVYQ3BJVEZCcXY4cjlsS1ZYeVpmeDd4M2Mw?=
 =?utf-8?B?Vlcwb2ROMGx5VHFxaDdmeW9lRnVQYVd2T29QdjZ1bTUyWElCRWRyYjBBL2hF?=
 =?utf-8?B?K3lzaGppRTFzSDd3SW1GYXVVR1JIZTU5bU5EWHpQVzV4Um5pZFVrRFluNHQ2?=
 =?utf-8?B?dXB1MlZKRG90RVF4VzhQNWIrS0tWUFAyOXl2U3QwMUIyOStINVpqNUg2UUxR?=
 =?utf-8?B?V00wUXRuQWtJOE0yNHY3UEQwdnhxM25iTVpPRVhWMGV2OVU4c21XQjI5aTRk?=
 =?utf-8?B?azYyU0phWFVlVTIwdFFkV2NyL0cxOWVaSEFOS0hJWEJYVVVyWUxIQkgrTGJ1?=
 =?utf-8?B?amc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80fe4e0e-3e48-46de-ff6a-08ddad09d496
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 19:13:09.1943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xAcvKBgmMVudbRqLI8KWt6RDZ5kennTkzFLsEJYtebBkvI8+R8tCl1pZl/4r6LDY4q254ddrk4YtEdi4ixIa2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR10MB8123
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Jun 2025 19:13:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19112

On 16.06.25 20:44, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> If an power failure occurs and the TPM was open/in-use the DA lockout
> counter will be increased. If enough shutdowns occur the device will go
> into lock down mode.
> 
> tpm2_shutdown is not available in Debian buster, therefore Debian buster
> is still affected.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> Changes v3:
>  - increase version to v0.8
>  - exclude tpm2_shutdown for Debian Buster
> 
> Changes v2:
>  - use tpm2_shutdown direct instead the wrapper command tpm2 shutdown
> 
>  .../initramfs-crypt-hook/files/local-top-complete            | 5 +++++
>  ...itramfs-crypt-hook_0.7.bb => initramfs-crypt-hook_0.8.bb} | 4 ++--
>  2 files changed, 7 insertions(+), 2 deletions(-)
>  rename recipes-initramfs/initramfs-crypt-hook/{initramfs-crypt-hook_0.7.bb => initramfs-crypt-hook_0.8.bb} (96%)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> index ae0dcef..2b4bed0 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> @@ -293,6 +293,11 @@ for partition_set in $partition_sets; do
>  	finalize_tpm2_encryption "$part_device"
>  done
>  
> +if [ -x /usr/bin/tpm2_shutdown ]; then
> +	# shutdown the TPM to avoid DA lockout due to powerfailure
> +	tpm2_shutdown
> +fi
> +
>  if [ -n "$watchdog_pid" ]; then
>  	kill "$watchdog_pid"
>  fi
> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.7.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.8.bb
> similarity index 96%
> rename from recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.7.bb
> rename to recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.8.bb
> index 80a4755..f3b6c82 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.7.bb
> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.8.bb
> @@ -42,7 +42,7 @@ HOOK_ADD_MODULES = " \
>  HOOK_COPY_EXECS = " \
>      openssl mke2fs grep awk expr seq sleep basename uuidparse mountpoint \
>      e2fsck resize2fs cryptsetup \
> -    tpm2_pcrread tpm2_testparms tpm2_flushcontext \
> +    tpm2_pcrread tpm2_testparms tpm2_flushcontext tpm2_shutdown \
>      /usr/lib/*/libgcc_s.so.1"
>  
>  HOOK_COPY_EXECS:append:clevis = " \
> @@ -58,7 +58,7 @@ HOOK_COPY_EXECS:append:systemd = " \
>  
>  HOOK_COPY_EXECS:append:buster = " cryptsetup-reencrypt tpm2_pcrlist"
>  HOOK_COPY_EXECS:remove:buster = " \
> -    tpm2_pcrread tpm2_testparms tpm2_flushcontext \
> +    tpm2_pcrread tpm2_testparms tpm2_flushcontext tpm2_shutdown \
>      clevis-luks-list clevis-luks-common-functions"
>  HOOK_COPY_EXECS:append:bullseye = " cryptsetup-reencrypt"
>  

Thanks, replaced v2 in next with this one.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

