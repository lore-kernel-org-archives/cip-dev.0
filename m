Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D36CAC587
	for <webhook@archiver.kernel.org>; Thu, 11 Sep 2025 16:24:03 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.12])
 by mx.groups.io with SMTP id smtpd.web11.1827.1757607835744138008
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Sep 2025 09:23:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=BqQoSVv8;
 spf=pass (domain: siemens.com, ip: 52.101.65.12, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ELs2tKFfAMIrqeSu+3LfruKw0GXCAX8kIilQvG6g4QVG435mGTia6oaeOLU/K4Bd+W4DnR93imKwgSX9UleZSOpvMMn0MDWKGzgtkv9XLmQTyx3EI95Ek+cL9/4NbtpcyR8ySlMg1CTZppT3yRMa2GhNZkMuEivvJOlofTkeI9Vn9sgddN2/KAwUHBXY8Lz/Wj5r2dTna6drhEEXuTjCdXbt12BpzqniA+f+AiKosLRkSU6t2mWUUTZRhnUvnqKcOV/ZcjJY+59/q47kNqPH4NDF4n96V49NIhnAPR77YGTkr4yQHPvqI0rk4t2quS8dR65+F+/T3fZMxNKT8ZJVHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ctd1+KjHQSloS4eATIpI7kLabhxon4nXr87QFSgzzYw=;
 b=tu4m21OubC6bUKXcSZTeRi7QOYhlzL/BeLs1PxapdjYRPmRfLLaT857KZ/H01i4Up3lrusPjFb1ijkfKQt/lOU1hG1SFD2U3j7/Kh72QVSbN2fmIt7J5i9D+UDqtr4DXkUaEUVxIpYoHhwP6Aq4JR8KQZ8IDnnX9k23+wxUPam1uu0WhTs/QelGo0+NkwjoZYPhYMk9uVB1FlRrbaKsj5CNxnhulBRKBANQ2wk9Xaw516smgRTiK6p6YAZvm/DyJy7Gjsr8Wgg7/KwIairpK5LvmW2wOPtoDUOg4X6p4yQKxaBoGektjZLfAqlAxiC4A+ERNpkNNuVCYip40DOHLsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctd1+KjHQSloS4eATIpI7kLabhxon4nXr87QFSgzzYw=;
 b=BqQoSVv8C21WSM0nNoaSLeEpxeaSJH3cdhnTri7MH9FJaPzAmTC0GH8Q3VhKNTdFJMsoheybDE6232fg39+aWeSKhn5wFYnXajpuGh5wC3c7adq6s6b0Yp/ZjUO8hgwmZ+vmRIq6n4+YmiH6vUyRP8SOQNPNYknPTUm2jnz2bN8RWXHwGC7HHjEadaDkcLiB8eebqqhzmC1c6YkjQ6X7zNqiv9AzEDzi1/QNQo6tNlxg/ojHj3mzpjGTsWBoN2Qu+IpglSmuSMnsLZfKV28wu8JT/5fLl/YD9g648pRWljbhl5l04b48d6KeucQms5/OdHdCxMVU+zsCaqKXABU1+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6611.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:83::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 16:23:48 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 16:23:46 +0000
Message-ID: <f2d5fc54-bd2e-49a8-b177-e3e25d4e39a8@siemens.com>
Date: Thu, 11 Sep 2025 18:23:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] initramfs-crypt-hook: add tpm_tis_spi
 module support
To: David Kauschke <d.kauschke154@googlemail.com>,
 cip-dev@lists.cip-project.org
Cc: David Kauschke <david.kauschke.ext@zeiss.com>
References: <20250909130043.145123-1-david.kauschke.ext@zeiss.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250909130043.145123-1-david.kauschke.ext@zeiss.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0202.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6611:EE_
X-MS-Office365-Filtering-Correlation-Id: b4e38920-57ef-4908-c50f-08ddf14f9520
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VFdRMzJvWFFXbm85aEdzRjNlTWF2TTk1T051RGpya3U3RjlvWnJEVDNHYXN1?=
 =?utf-8?B?a3RrNXpzdllETUxhQy9OR3c5RzF2ZHBxcDJjYk5GdTJTOFc2NktBVmJhSUhs?=
 =?utf-8?B?S01TN284N0l5TGJVQmN3OEQrNDRxcTFHcDlqZFNvUXhWOVpxL05IcFlUZm9U?=
 =?utf-8?B?MlpHcVN1S2RldldaTU9ldUlvR2VvbmsyUUQ5ZksrT24wT05nNnhOTjZmeUJn?=
 =?utf-8?B?M0J2U3Bxc3NLNTQ2VlpFdmVwR3E5WUVtM3UvOGpaU0MvNXRyREVYbk9WTk9V?=
 =?utf-8?B?VTZOOURIbVk0Ly93bDh5TWFjSVd2eG95WUZiVlI3UnJHVVpPbmNVbk9OQ0Z1?=
 =?utf-8?B?eHpiandqVzRwL0lIQzU0RXhEV0RuWWdhVFluS0tOLzIxM29nT0dYdjJRcXFO?=
 =?utf-8?B?ekVJN0UrV05xdmFxWUF2cnFkdzVURzBuTUZvQmJHYlVKVkRSZGM2M1prQ1R2?=
 =?utf-8?B?cDRRelM5R1lMWGpZcEQ1Nm81S0hlaGpEMmlRdzlGWTBGSTh1dmxFbVdTQXl4?=
 =?utf-8?B?Tzd2QVY3ZUE4dVhCdVJoMmtmRE95S3g2M29HblU5b2Q0WDNsNFVLcEhDSG83?=
 =?utf-8?B?OGJCVTZvSlV6dW8rdU9UdzFTZWJDVlpndzZDbE8vcFluYUdqR1FLSlN4cnFU?=
 =?utf-8?B?MnhsMFoyd0Y0NWJ1c21JMDhBaklyZjhiVzVjLzdpbjN6NDZKcElQSXBrdHlH?=
 =?utf-8?B?VUxxdklxTm1aUUx6R2MxUmcwS0loelNRRHVQUEk4Uk9UOEhSK1M4SHhPYkl3?=
 =?utf-8?B?S1BWdTZyYWtTUGJpb2Rqb3d4VWRGSlNrZlM1WnM4ZytDeEVxYTc2RzluMHNR?=
 =?utf-8?B?WlNEL3FvVXkxWnlYQ0dtWXhidTZhRmpsM0srbnJzb2ZZZEl6VGQzRklDOVlj?=
 =?utf-8?B?Sk9jejZzVUp0NUU1UGlteXl2YUpNZndrYko4UFBwWEZEUnowM1pZMDNYVkxs?=
 =?utf-8?B?RHBNdU41Z29Cc0E0WjlhWFZuUWFRTGQvWTlDTnl6dUIyVDloNi9qUHJPOHBP?=
 =?utf-8?B?SGxNaS96Tk9Kc052dEl3Skd1SkpCM3FsS0FRZ2hLUld1b2Q5dzhzWmI3UjEv?=
 =?utf-8?B?OUVmS005S0JDaGt5MjJ0OUI2VnNYUFBSVFphRWQrOHRZczdoZUpVRzBPek5G?=
 =?utf-8?B?QXJWTlFKQjlsdVRFdXM2NThxNDBVODZ5UG9Wb0hvV3BBTlU3cDRZdUZyQkVK?=
 =?utf-8?B?UE9WdkRuQ2VhcXdtZ1Q4aElTSVhwY3dZaUJJMlFZR1h0d2tBeXpHWmhEejln?=
 =?utf-8?B?WWFpSUNSSXM2anZYVmdaaHVuL0VzMVdhY0N0aEorZEk3T21HRndsZ0E3ME82?=
 =?utf-8?B?NktxYlkwQkM2TkZaSC9Nam9rMVZDSWh4NXlqQ2N3N3ZGV3o2S3FJMEVORzNu?=
 =?utf-8?B?RVI1UnZrUkI1NFY2YnM4bHpJVTR0L05GbUozS2pKQVRjYlJsOGFCZjF3ZkFO?=
 =?utf-8?B?OC9ZVGdHSDl6RmJMTVVwOWJiSURxVlRhb0VkZjRqNFcxLzBIWmJBRm1IUDFY?=
 =?utf-8?B?ZWJEc3YrOGFLUFdaQzVTaWlHM3JwYVpta0RyYklFR1c0WnNrdTl6Vlphanht?=
 =?utf-8?B?eVJXNUI2VndQQnAxaDJtaVRNbWQwVjVtY3ZFV2JUUUIyUkJ0TFFXZXB3SitO?=
 =?utf-8?B?TWdBTnFzcnFXRlZpUUtLekg0b2hQOGFhZFdQcGYvMCtWMndzVmN3dW9SVGlk?=
 =?utf-8?B?MGtLem9vMUVZaWxoeC9wNENNRjZ4TmVmaGRVNWt2MUpKNllVejRDYVdXY3J6?=
 =?utf-8?B?b2xSSGFidnVyT3FreGcvRElYZVlkLzRNeHo3M1k2SnNpRnZlZWNBNzZhSi9h?=
 =?utf-8?B?dlpqM1NjWkVoeTRnSDdaUzdackxGV0pqb2RjRUwxVm1IbVZZVEVuajh0RXRG?=
 =?utf-8?B?a2U2V005MXVhNi9ZZEhseVpWa0xBNlBZZU1rVmY2U3E5anlEWFVycDhKNXhD?=
 =?utf-8?Q?9e0Udr8kAYg=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?elJkZy9pNTdpZk9hVHRGMWFRQnpaV0VpWklsQ01TRXJLaEUyb0hFR05KL1FR?=
 =?utf-8?B?YTZ2UUJTakthYUk4L2k0Y21WWlE0RjlMVFBUdDlZVXpEUzBoVVhEUjVFZjlK?=
 =?utf-8?B?bU53WEJhYjRTNWtsVU12VVdjc0dvam9yT0VnUkNMRk1qbkttTnlMUzVOaGpu?=
 =?utf-8?B?aUZyVmdiTmVhR1pkT09qZE9IY3lNMVZWMmUrYWZlRjNxQ3Mvekh4MGs1dXND?=
 =?utf-8?B?N2VKQXZxMk9QNW5wZ3NpQmRjMFVZeWo0UG9ITFhuWDZSUlNHcW5TbWtaN1lU?=
 =?utf-8?B?WldVc3hwZUZnRHplOFBMaUZxdWZ0aW1IZXVyNHpBQ0FYZURBNHF6RUJ1b0N1?=
 =?utf-8?B?NjlqOEVGSnIzTXNDMndrbVFWOUpSRVNITUJ0S2tDTi9qbGVMS3Q3MEtNVnhO?=
 =?utf-8?B?dDJPOU1RYzJuVXY3Um9uT3V2cDFTd1A3blI5a2UzSE1zSDU0cDVFcFFnemI4?=
 =?utf-8?B?cHBKYlQwYkhtbGNTT1NaaEZwOXNsaWozNXRvNkZsMXBwbWw2NFpEUGhhaUJZ?=
 =?utf-8?B?dXZWSXdDQUJVQU02MEJ5U2U1aTNXVllkNWFhS0VLSERlRWZkcXE3anpxbDlE?=
 =?utf-8?B?YjRlZHZlWEtDczNZUTdhbWVhVEl5Z1phUjExWG91K04wRy9SVk5rTVRyZXFO?=
 =?utf-8?B?N1RmSFlIMmV2RkFhdkpsOURoRUU4cGxMYkIzRUJzL0NHQmlRdXZOMW8yaWNl?=
 =?utf-8?B?S3ZBbllpNngwS0JOcGo0NlBnclhrMjJIV0cybjJWS3JtSzk1T3EwUU9vLzdk?=
 =?utf-8?B?eUw4Z3o1WjltclFTbFN4cGUzUFh1UUZVZi9qaFMyM2hlTFdDSks5eEo3QlNW?=
 =?utf-8?B?akF3bDlrWEpRZUQycmdCbkRHL2k0TDY2bFNCSTNMZjhTVnREdVlEbEdCOFJy?=
 =?utf-8?B?NW9qY0dSQnNuNnVNdWJkeTFoLzY5VXpINm1NNUFodmtDbkEvbGlHTTVpemVp?=
 =?utf-8?B?QVVyWmdId2RmUzd4RHVtTnYvOGVoNUdnWWdLMW5EV0s1eStvWVpjWUZwcVRP?=
 =?utf-8?B?QmptK1BGQ0RVNkd3T2NIbGhUSjZWd1RTWUVsZlB4T21NNkt6TXlRdGptR3RP?=
 =?utf-8?B?L2RWMER5eWhwaEsxU3N0bWZZMjNzUGpMblBmVzRNQ2c3VGV0K0hhWHFmVTNn?=
 =?utf-8?B?c0FYZzU3bmtIZi8yakUyT3FpSUNJM2NiZk9rNTRMSUxEMlBZUHZwaVdnL2ty?=
 =?utf-8?B?MGtyRzdLdTVrWWcrTmFOWXdKZTQ3eDhieHU3MlhCTi9rdjFGU21kT2tTL04w?=
 =?utf-8?B?VHFQbkpjNXhpdTRqNmRNTG41djEwbkxkTDdDS3dQUmNIVHhsREt0Zk1EYkN0?=
 =?utf-8?B?eDRVQkQ2L0FUU0dza1ZCUkx1NkJXNDRhNXVaR054SEplbWpNNGJIVXVTMkN2?=
 =?utf-8?B?OVpLSmNyaU1vNUx3YnNlYzhMZ2NLTHFYaUtTUGtZYlVIb3hrQ2wySXJlNS9q?=
 =?utf-8?B?Wi9haFZ6VDJ3TFVSNnpqcjBhUHFmcXNnZnhsSU5PeGlZQVQ4VzUwMFh6aXdp?=
 =?utf-8?B?bFpTY2ZQTndXRmlGK0pxb05GZWF4VWFSVHdNQjRrbW8xL0VZVFdWVVNIOG1x?=
 =?utf-8?B?d1R1aGJ3blU1WVdQWUw2akRvcnNnQVIzVk84WHk0NUpYdGYxWGxtZ1E0SGhh?=
 =?utf-8?B?d0phMmxXOUJiUVEzbnRzY1l4ZDdjanZIY2E2cXRNNllDT1h0b09uU0s0VlRF?=
 =?utf-8?B?LzBJSTFTbk0zYlVjU3E2aVBGZmtyVVBES2U4NDV2WnB1TGk0Q1ljQ2E3Skh2?=
 =?utf-8?B?YzhnOEJnT0VMOXNneGN1VkpqTjdHdDRrR1hETmhjaVBzRjkwelNzdE1mQzRo?=
 =?utf-8?B?Q1VnaEI5MUkzWUtYZ0dEYzhrQ0hjNXpNSU1CSHFrT2ZmQ2RSOUNHWlMxV2FK?=
 =?utf-8?B?QmppdWdwaW5jWjMvcFdvd3pkY0d2NnRVakMwbTFkanNwWjZIckc1WmxrSkcv?=
 =?utf-8?B?aGEweDhaMnYzOWEzMXhmWDJ6VFQwZlh2WU1URGRrNDZ2aFk5M2EreHBvUVFF?=
 =?utf-8?B?ZyswK2dGNGYwbGRWOU5SNmZwR0Yrd3NYVVNwMGp4UHhRdEFnQ0FQWGhIejJh?=
 =?utf-8?B?Tml6a1FkMHovbytGMHdCd3ZOWXNyd1B0ZStzMEM4MHBCZWdSaGM2VXVqTnVY?=
 =?utf-8?B?VlVOWUthbHRwdG50NjMwUldsRXNoYzNQeE9la0J5YVlXWFJKTlZ3TE1tNGM0?=
 =?utf-8?B?QXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e38920-57ef-4908-c50f-08ddf14f9520
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 16:23:46.4595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r0rgmqJsUHpgmlFqZGzl2KFRipn9Iairwy4H85cI/5BZ12XmVv5WLqTg1pgn/o7saR+03aAUx2/B9xTVXPAdRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6611
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Sep 2025 16:24:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20044

On 09.09.25 15:00, David Kauschke wrote:
> The initramfs crypt hook currently loads tpm_tis and tpm_crb but not
> tpm_tis_spi. On systems where TPM is connected over SPI, such as with
> the Infineon OPTIGA TPM SLB 9672, the absence of this module prevents
> TPM initialization during early boot.
> 
> Signed-off-by: David Kauschke <david.kauschke.ext@zeiss.com>
> ---
>  recipes-initramfs/initramfs-crypt-hook/files/local-top-complete | 1 +
>  .../initramfs-crypt-hook/initramfs-crypt-hook_0.9.bb            | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> index 0d42bd4..664124d 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> @@ -42,6 +42,7 @@ esac
>  
>  # load necessary kernel modules:
>  modprobe tpm_tis
> +modprobe tpm_tis_spi
>  modprobe tpm_crb
>  
>  modprobe ecb
> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.9.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.9.bb
> index e2d55f9..e107575 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.9.bb
> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.9.bb
> @@ -39,7 +39,7 @@ DEBIAN_DEPENDS:append:systemd:trixie = ", systemd-cryptsetup"
>  DEBIAN_DEPENDS:append:systemd = ", systemd (>= 251)"
>  
>  HOOK_ADD_MODULES = " \
> -    tpm tpm_tis_core tpm_tis tpm_crb dm_mod dm_crypt \
> +    tpm tpm_tis_core tpm_tis tpm_tis_spi tpm_crb dm_mod dm_crypt \
>      ecb aes_generic xts"
>  
>  HOOK_COPY_EXECS = " \

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

