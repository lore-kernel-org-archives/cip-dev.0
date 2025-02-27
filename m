Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316F5C021BE
	for <webhook@archiver.kernel.org>; Thu, 27 Feb 2025 09:13:58 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.82])
 by mx.groups.io with SMTP id smtpd.web10.6983.1740647633443494923
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Feb 2025 01:13:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=msNgRbVq;
 spf=pass (domain: siemens.com, ip: 40.107.241.82, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ex03rD9pNOJWwOTnPnZ4VSg07eS9qwIbW0+1O/4Jpg4wGh8zWBCTdvTkFPP4lg6wxJ93jGyZkHPIQhxv7pFK+mv7P/oRJWGAcGaQyElTnJ5ftaksftBAZli+kVQ6WjFUp74tC6qjiPMN7B0DSFZnCnvd2lrj41f0WYeQ3DhzqnM2UPndYrrhY6PhEFdvx/bMy9gtQPb8AdloVxR7AZhLDZ0VJRrwZUgUOqA8qT7Ce9SCo+pzQdHeZCAY5lATLNEdZT7WAN2NOWozB0PL2f8MeT2rXKh3PiOanQ+oO3vw4okJNX8ZuMz6K3uPy/IDlRgU/nGyGpHlIZ3ZuXaQcNFfDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJBoHLDsH1h3mgIz253klCFqrqCPj7p70FttPUEt4ak=;
 b=W2gINZxYB/5TVLGTeeVjOyaZSsEbqgBbnR/sarGURYofQjmy32odCAlYrIA7PRLSvP+jqrua7nMJzocy8J7n6L7aVU1s22EzpPlu9q7pFKTZib7aMrPkIakEL1qHFCbsb5vfPsfIln+gpsh53urGmnG1WcV6X/b1iE0xj4MN4VT1KB8DabIxNlQ4utFHLmSQkwSMJmp7Okv+zebpvL+kgwU9RJK3o1L266kE1Q6Z6rgpu6gSwJr/wzqvwiYXdkEF5DWBGrA+fo0ssosaJeWwoGxy2D9lZPUwetD4iMiz+FSt+vxS3j69dxhHrFQqaJ5lT/3GK7DOm8g0XnaX+ln87w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJBoHLDsH1h3mgIz253klCFqrqCPj7p70FttPUEt4ak=;
 b=msNgRbVqLv1UXZkZYKiqTvF51WlAUgT4pjgjDNLx3DjdVCM5482Y+NET50h5b55CF0q8VtO0Il1+Uso3tBaHsSM25kKUAxwy5P9oky7Be0GzpVfMU7O1CgxYko9zBwYaA7IkEEcfEdzQJeZF7/46MnFJyBL6WkqNvjmZ8PkGoiV53kWeciRrJdcX/loBrgdDLGCnl+FuXepdAmrmEcT1t3WujHnmmTz1E0Nb44FdoDPwVl43v2+hjDk5CvhHK6MD4J9B9arzWe3ajJ/HX7Xz6ToFj/KnBgFb27KFm0NWeagkkO2IZYzMwgRbBcGp3j9wHJKdM3y9apgrt5OrhmFnTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM8PR10MB3988.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1e0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Thu, 27 Feb
 2025 09:13:50 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8466.016; Thu, 27 Feb 2025
 09:13:50 +0000
Message-ID: <9cab7415-e5fd-4a3e-a36b-70128dfd97a2@siemens.com>
Date: Thu, 27 Feb 2025 10:13:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] initramfs-crypt-hook: make sure that mount path
 exists
To: Claudius Heine <ch@denx.de>, cip-dev@lists.cip-project.org
References: <20250226095921.168962-1-ch@denx.de>
 <20250226095921.168962-2-ch@denx.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250226095921.168962-2-ch@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0109.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM8PR10MB3988:EE_
X-MS-Office365-Filtering-Correlation-Id: 12c8046b-2743-4f2d-ea70-08dd570f0c3c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WVdjTDEwMXZkUHg2K3RUcWdpZkcrdmFvMFI3OUNLT1d6YUJJZVdZb3FHK2lB?=
 =?utf-8?B?cWpBalVzRFZESTZrYnE4bnhsQlhxNHRsTmMyY2RoL1oxdkVTRHFQWmpoUWUy?=
 =?utf-8?B?ZkFtUkxESHZ3MjdOUDlEV2tnOEwranloRkwramsraWZhSDd6TCtwamtFV0hE?=
 =?utf-8?B?Z3VoZXNwQytDNDNzMHRjM3l3eFZCNjNjRThhUmpQR3ZFQmxMVWJuUTRYUDZa?=
 =?utf-8?B?UGZMamd3N0lreGlkeFZxdHRadlhvLzVyb2FqY285Rk91YVZHcjdTRDBzSk5G?=
 =?utf-8?B?ME51WUN3TWdhMDF1Yy80UW0vdHB3Vldkdm90bXArTGlYdFRlMEdKMUlwcFdJ?=
 =?utf-8?B?aVFyY1ROWFRNWXhhUUVqcXc1SGFkRHBBdEhQN3UyY2tOTzhhZGF3ejNYSjh2?=
 =?utf-8?B?U0VCL3FJV1pIY2dIdWVUQnk2bllQa3NFeHVjRDdPZGN6akFEanBSVHZLS1F6?=
 =?utf-8?B?TXlKdUh2MVBnamJmNzVka2ZqZW95TmNDdSswbXh2QmNtM1YwdmdjOHRlWVIw?=
 =?utf-8?B?Si9vTE9VZ2ppcWZ1bWJLTkxac3E0cHlBc3ducnp4Q1BTTXhlYURiVHFyTlZz?=
 =?utf-8?B?WG5PcHA0Y3k4NVFENFlqVDROZWxQZDMxT0VhRGFFbm9uTkYxT0huOXNnS2Ft?=
 =?utf-8?B?aU5UeFdrVlBVNWpIOGhSVDNma3BaR1pRZ0NueHV1QzZraGdRdmlEaW9YeWdl?=
 =?utf-8?B?ZjM0aGduaWx1SWdpUDd5UThWUjBtUkZWL3ZEbFBZaEFxWmp0QUpaMzBvV01N?=
 =?utf-8?B?NHNsbm5rZkxvMm9yZmFvMUN6UDI2U09uMkZaMVMxczdrQytiWDRqUzdBQ2FI?=
 =?utf-8?B?aGRlcGtCNkJVRjloYnRUMExGMCsyeFkwM0ZWZk5ETU1PTVJiRWlMaWJHaFZP?=
 =?utf-8?B?TWc1SUR3ZzRyWGxlQzdWK1VIYzBJMXNxWFBmbXdFSUtrem5ZUDhWNFR3a0h6?=
 =?utf-8?B?emczUjBIMXJxRlcwWUNpL0krNGRxaEF0NlRuQmt2cyt4Sm1jZjN5N3lyNTBn?=
 =?utf-8?B?Z0lac2RCMDJKOTFqMWUwSzMxRmNKeU9wSStmb0ZyZnU0cysxQzY1Skp2WGJz?=
 =?utf-8?B?L2QyWVc0eHJISks4cHRLc2lTNmZpWCtxSmF0bzQxakpheXRCSWJPWEZTTjMy?=
 =?utf-8?B?TVN5a0Z4TXVjemJ3TjlTd1hObVE0K2JTTGxLek0zM3FoT3MwbkovQzJCV256?=
 =?utf-8?B?alUyVkpSVmt0TEhqYTVQZXduR2ZHNVhXREtuYXBCdkl1VVl3YlBUckphejJn?=
 =?utf-8?B?N0w1MXMzUzJzWjExcjBkRlBKSnZybk02UnhCZVRJWE5nNHRLSzRQL01rcEdm?=
 =?utf-8?B?Mit3VVBnSWpKOGxGa2VUakZEdDVzZVNFdSsreDZHL0pVNjhwRXNzM2FHekFF?=
 =?utf-8?B?MGo0bE9XL3Q2WE5aalZUb0ZreER5b3AzOHh0anpZVFFIeHN1RXNiclFvY045?=
 =?utf-8?B?b0w4dmJqTHhLaUNXTjNpc1ZXVWE5djhXc1lSRjF5SENCTjVTS0xMV29VczA5?=
 =?utf-8?B?SjdWWVRQR05qSWdlU1JZZ1FOYW1zQWVRN0tsaW9wUmRMcmg2NFhKenZJdUlk?=
 =?utf-8?B?OXNyQlV1MTVvQjlFc2x1UEpUUWNoSFBqTFAvL0Z4ZHFDbm1qbnNmRXhtS0NZ?=
 =?utf-8?B?TDNWcU1OcStXZlQydEtZQWN6aUIxMG0vVzEwd1FLU0U0VVBaYVVKaXpzQXlq?=
 =?utf-8?B?QzRyZS9CUmRGdzBoSWw0c0xEMVNwd1BmMG1mYTVmYXdXeW9CdERiRTBYQnAr?=
 =?utf-8?B?eE5iaGhpbkVyRHNtR0M4cnBwUFpGSnV6MFhzcGRZRnluTXIyVFltTEJGMlFV?=
 =?utf-8?B?VDBtU1p0ZGtPZmR0NVduRW9Ic1kxN1ZsZVQ2SVlsb2hPOXdZMHJXNm9hV2lk?=
 =?utf-8?Q?orToKcqFnS124?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZnZzbzlHZFRFZ2FweW1GaXkxakFKd1FxK0lJOWYxTjBGL05zZ2N2SlFrd0pQ?=
 =?utf-8?B?Z3U4M2NzMlRyQTdjMEQwS3B3SXVHWDlpM2N5bGhvWTJXdjVJZjUxQmo5ZFl2?=
 =?utf-8?B?WXo4ZGVvWGlRdjl2UGFKK1RjdG1rRXRsR1JSUUhjLzdPYWtvRGM3Ry9sQmVq?=
 =?utf-8?B?YTJMaU9OUDRmUUcycVM1TFVKWm1kVVpzaStFbGxXeG44b1pHc2ZQS0sxYTQy?=
 =?utf-8?B?Vk5OVGxhandHUFZUdnIwMFhpK1JNQjNRK1VkRjZQZHpyRjQ0SmdrQ296N2Ni?=
 =?utf-8?B?L0ZiMWpCRVFGeEMvaEFjMUtJbkpUMzd0dW4wdE0vZTNxUUxhS01KZXp6amUv?=
 =?utf-8?B?cmNaRXBkMDd4dDVpSEVyYlhTWjJKTGpPRzhndXlEZ1ZvTmV5ZUh6RGdqTWFt?=
 =?utf-8?B?b3NvUXFRZFRqTjJNNDZuU0pZdlhxbVd3bjQzSjVySTdmU0JyLzFFdVNlV2Ft?=
 =?utf-8?B?SmhRY2xybUJ4Rkk2K3dNL3lScWtxUEFKUytkQlM4THg3aFNldDNvb2QwS0Fi?=
 =?utf-8?B?VzJBeGJsMkFPVHJVOFdRSldwMkltK096V3hhd0FPdWZYcFlLOGlza0NqTk4y?=
 =?utf-8?B?QXRBYTlXVHU2c3NybkhudTJCOHBid3BsZmltc2cxOGZQeGc0WUxqSkVDdndu?=
 =?utf-8?B?RGd6eDhkNUlZRGR5bm56MElwREVSYlh3VDdTQnJMYkJ2MDB6WVdVU2JoSVpK?=
 =?utf-8?B?Q2hnNER3ekxpRW56dFZ6bzN3eXBmOVhvd0hJUnZXY3VmWFlCdDFQNTZrdk1L?=
 =?utf-8?B?TEJuTld4c1RIRld5aFl1SzVrOCtkaTMvNExSZFRoenZBRmE3YmRGbmVEUG1F?=
 =?utf-8?B?RThsU0NqN2tFK3M1RGl1VUpiOHVFMGtUTVVxemdYSVhEVEpwUU9qS2NJUUVS?=
 =?utf-8?B?T05VSnl4MkdBRS9UeGN3QkowdVViZFFHTUhlRkowVnoxK3MxK3lKSklzVjFt?=
 =?utf-8?B?OFZhSUE4Y3Q5eFVjaU1pYzJUSHB1K1VjQUNxcVFXNXZYbFBxeEVyME0wOWRl?=
 =?utf-8?B?bEViNWZvRVpDRENEbVBGY0wrVDNWS1RXbjBuSjdlUm5NUGxNQ3RLMVVQWGUr?=
 =?utf-8?B?NU1IUjVjeS9wcXQvRFNXcHRCVDhnMGswK2I1K3N0RFBmYlJ1K1FsSE90Ull4?=
 =?utf-8?B?NUNDWklvdDRkZytsYmxNUzNMVXFpTC9vbyt0M3BjR1M2d3lpc01tbm1rRERQ?=
 =?utf-8?B?cTVDMHhIVTJJSDhNSG9DcENXMjc4T253Nk5BSHNPS0svSmd2aFZkS0JmZVRC?=
 =?utf-8?B?ZDZsMjFQcHo5ak8yTi9mMkg0TmVLVTd3NHVZME1weG9FWXB3SHdYU1dHQ1Z2?=
 =?utf-8?B?K2Z6S2hkTEg4WmFYWEsvRTBvK1I0emkzVlhhK1dVbmdmUURlMkpoWkFUYmNV?=
 =?utf-8?B?QXhpczQvcmdyVkd5WUxXOTBxOHkxK24vaUZwK0wxNFJmK1ZFSjFxbktNbitP?=
 =?utf-8?B?MEs3SnJrTzgzcXF6cW0ra0d2b28rcDZwQThLd1BxNnI2MVBuMWtUMEJjaFN5?=
 =?utf-8?B?OXpmZ1NZZU9aQ0xzUG9tRXpsMVBlOHNNZ2tMa1NuYlZpbnJRVnc2SDV1aDZX?=
 =?utf-8?B?VmtVTU53alRVZklBQTJPNUNycEVjZnlzVy9CcUNEbzB3SFd0eXJQMkJ2NTA0?=
 =?utf-8?B?elplMWhWUWErd20xbnBMRXorNHpaY2d3MmpSRStjSFFyQURmeEpqSjVVczdl?=
 =?utf-8?B?eHJlM3UxU1hBNkxLSFJFWkRxQzJQcGlob2dmWXRVem0xNnhkRlJkYWphOW04?=
 =?utf-8?B?ZFV2VXB3V2xrWjI5OFpwTVEzSUMzUkE1RGZndlljTVZUSmFacGN2VDBkVXV5?=
 =?utf-8?B?NGNQZE9YWVBVOFl4UWplNGtRSmVsQWhYWktBZm9zdGVSODNnNlV2QWZGQUVW?=
 =?utf-8?B?SE1jeUlYMFVHL1FIbWVKNkNlVy9rQWltS1UwRVhSVHYzU2IwVW5NV096MU42?=
 =?utf-8?B?OUQvTU5OMEQwR0NpelhXQVdmL2lRR2w4UVBZemVQMjNvcGFMVWtrZkw3azlx?=
 =?utf-8?B?aFpWeHFsTlNKMEVWd1lZdVc5TiszbGQzb1ZuNDVQRjVwT2VaQy9SdzBVSHJj?=
 =?utf-8?B?Y0c1cFg1MEM2RmhpaEpJaDRiTGw4Y003VmhoY2hpS3IyRHF0RE1BZ3cyVlMz?=
 =?utf-8?B?L3NYTjFFRnlhclNGK2kxYkdvOHZpblNVMFIwM1VjT29xK1FPWUJHVE9Hdmow?=
 =?utf-8?B?S0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12c8046b-2743-4f2d-ea70-08dd570f0c3c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 09:13:49.9318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y6WBWlo7x2KKx1USFJkK4yOqYuiHUkajyejMw24XjIHmiBYsLef2e5A4Te9ywRHgH1AN6MpfGlNq+wpceGH6gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB3988
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Feb 2025 09:13:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17930

On 26.02.25 10:59, Claudius Heine wrote:
> In case the mount path does not exist, try to create it instead of
> failing.
> 

Please specify the "why" here. As you know, (almost) every commit
message should cover that, and obvious ones do not even have to talk
about how they do that.

Jan

> Signed-off-by: Claudius Heine <ch@denx.de>
> ---
>  .../initramfs-crypt-hook/files/local-bottom-complete             | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-bottom-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-bottom-complete
> index b991cb4..80553d1 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-bottom-complete
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-bottom-complete
> @@ -41,6 +41,7 @@ mount_partition() {
>  	partition_mountpoint=$2
>  	[ "$debug" = "y" ] && echo "mount device: '$partition_dev_path' to '$partition_mountpoint'"
>  	if ! mountpoint -q "${partition_mountpoint}"; then
> +		mkdir -p "${partition_mountpoint}"
>  		if ! mount -t "$(get_fstype "${partition_dev_path}")" "${partition_dev_path}" \
>  			 "${partition_mountpoint}"; then
>  			panic "Can't mount partition '${partition_dev_path}'!"

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

