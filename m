Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5641C282C1
	for <webhook@archiver.kernel.org>; Fri, 28 Feb 2025 15:44:09 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.69])
 by mx.groups.io with SMTP id smtpd.web11.18835.1740757442304837571
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Feb 2025 07:44:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=iA6Gq/Xv;
 spf=pass (domain: siemens.com, ip: 40.107.104.69, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MEPatB5UttJ+ZPkaiKnW9LS1OgdQQA8lkvLlwz1+WgIdaiM7fXWh3vw3ZEGh7Lw2hlCCp0tDu8WbTm5tFqfkQdWbxSPtii/HlVzHTm/9MGKAGKV9qRLNYM8MExKVRHf1EJNxzqQDbHx65sMqoxPkm1ECA6j1ldmL5fDa4EEHN0jvTYwuHaCLU0QILsFvWXDIXyXTcASOHTY1mTwg3MEuVHMiBFaBbjdEyieZSfC9GQznBOyKBcQKu6IjT7SXXutFkZQ1JZZgdEi21MHUJbepODr93kboYjVEorRUHrcHYlG4o+9qu7ZNK+hCX8MKCorS7X++yIOJ6oK7Ygo7M3no4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UCkjQ79fpjP2iSmee9iogQ6GrYFkZx5pjd5VUf2EEos=;
 b=KuLAwN56plCuOmzwMsca3q0VeYO23D71rZgO1WNhXlMBoiqdk+CGZrRDvsem31kEZT3P2oRJNowloy0WjnfGdrGHdXRu38SX12+2WlXTas7+04toW8qQGAVl91lJsg2ll68Vlu7VU6Zvmfsk+zz1z7CZkXoWkgNbJdXPI5gsAtAEKSJPM1+yTvMIluWl2bIzgRWaa3eANZhv1cQ5RMTtsHr2CwFptkDqoCwrOddwBnHJyRHNzcGIuNEk9TzieaPvVuL8dWtR6CFrY5WlXmC6BDPHrA41IFL3j0Sp3QROj+R6JokFYumBZANGlnq487VjtVp7ZU9rMsl+EYALROeWBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCkjQ79fpjP2iSmee9iogQ6GrYFkZx5pjd5VUf2EEos=;
 b=iA6Gq/XvQwzUXH/09Lpms/DulbbPR3NYYo3/24vjDk2UqmtZFaKEZTIZa+XLZwl2Y/Vb3CwPwo9fRUbOBPjEWjpiaBUmBR1RvQaiwO06yI8yUYLCyOiRaN7VFmafpMrfwMp9yBTo+unFHlqz9tnKcbDXqR75YTncV1CugOouv72pMurb7mZq/Mvwv1T/r+YSJdkZ6F6kO9zrQcHJZSJyJldr8jpgvz/Oa6DViN+OmhNJaZPmjZPUtLvFjVh9X4jOASS/ycFKgSmYovTEz+wbWjSTfWf/x4JUjW32tNPm93M6fkHopOoebjUyuVxrFPa8s/xtEeQFnJtJcBjrS6hUpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:51f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Fri, 28 Feb
 2025 15:43:59 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8466.016; Fri, 28 Feb 2025
 15:43:59 +0000
Message-ID: <e0ede60b-105a-41bc-85e1-2b58c14eaee1@siemens.com>
Date: Fri, 28 Feb 2025 16:43:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 1/2] scripts: Add automated recipe updates
 for LTP
To: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
 cip-dev@lists.cip-project.org
References: <1740727183-24538-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <1740727183-24538-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0179.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5992:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f9dfffd-5fd0-462d-d647-08dd580eb7a5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?QnBkSDdINU5LOW5oaWw2ME5jaXJxRFhHTUwzUVdrY1pxakNGR1RSMDF1S3Fo?=
 =?utf-8?B?a1RaK1NoUHVLNXkxUkRhRnFXSnFWZXFWTEwyQnFrN2xyR1JRSmZ0UlcyUVEz?=
 =?utf-8?B?TkV3N3k0S2I4QU9MTzd0L1czZ3FQdUJETG1BZ2tNa0dZaVRVa003WDNHZ0Nt?=
 =?utf-8?B?bFpzcENuaHJNOHlLZmhYNFZ0bGxhQXhsN0FEVGFlWFRQZ1hJL0k3cVV4T1hs?=
 =?utf-8?B?aVBaTis4dU9OSkh5Q0dnQis2QkF1bnVxRWFoMTNDZW94VUxUMStOd3QxSjBn?=
 =?utf-8?B?RXlJclBIV1NtYTM5dFl0NlBGSmpyTlY5VU5qT3IrUC9SeVFzdUk5SElTRFlD?=
 =?utf-8?B?aHRmVThpbml5VFF0U2V2K1VlZGVJUUhRQW55ajNxb0VCbnBTd3FaOVdqV2lm?=
 =?utf-8?B?bG0zaFRqRzFhTjBMSklPbkl0WTdXYVdSZFNCL0NhWUZqNXNxaFY1Ulg4VVBu?=
 =?utf-8?B?UnA4YnpTRmUxYUxRbUtMUC9IRnovaDlZTkxzSUVNdE9iUVo4YTlJaVVNYTBy?=
 =?utf-8?B?a1duNVoyY21NRlUyWmwxWTQrSU1hUG16NXN3MWFUVzFrSlp4azUxTkJNU1ZX?=
 =?utf-8?B?QTJCS3hlVHpsMUpjQU5KYnlaSE1OTEViQnJUam5IN0lMUTdNUkltZUtCV0h1?=
 =?utf-8?B?VkxQWENRL0JhdW0wZXR2U04zUkFMQ3d6alNBREpvVlZxRWJhcnZXNjNUV01L?=
 =?utf-8?B?Z2tDTTFIeUZlR1ZrSXYxQXBoUW1uaEF6bktHdUh6M1BYOUN6VGxyYlU5Tncy?=
 =?utf-8?B?c1Z6YkxUOXZQYlhTUHVJUkFnMlZqb2NmcVl5dnp3VjNlU0s5ajhWZ2UzOVJJ?=
 =?utf-8?B?bFdQSDFsUDVSS0wrYkpUb2RIYkE5SmZIQ2h3S25UODF6MlNvVm9aVzE1YWJj?=
 =?utf-8?B?a0ZMdzVJVnVWeWhzbk00OVk2RUVyTVlIWHRLVEY4ckM2Um0wdUdERWIrUzFl?=
 =?utf-8?B?STJpTDhYU3M3Ykc3YVIyQk5CU3Y5WFcrWDJPRVdITzJRTzVZckFyT2tKYXlr?=
 =?utf-8?B?dFBNNE1tMTZsaXl3M3dQQXlhZTJidDdoQTFNTUJ1T2lXaTlOUW1xcjVJT20z?=
 =?utf-8?B?T1R1WEJEaklZaW43bmRuTXJwU0syeXpNQ216ZlhDRys0WEZjWDBWdU1jOHlH?=
 =?utf-8?B?QzNCOE9qVEhNS0wvMnVWNitNejRrVjM2MTFxU3ZzNTFBamNBMm1MRDdJVm0w?=
 =?utf-8?B?d09haDlmUjFoNXc5OXNVVkRxWEhDYmZ5MGdmZ29qN0xvb3JrSWRUVnZheWtN?=
 =?utf-8?B?aWl2emNhWXovNDFJRXpkdXFyUStkZnNZY01OK2V5SmtmTDJkMXY4SGhBd0tl?=
 =?utf-8?B?VHVjMkNPa1dIQThYenlpeHpkN2E4M1VyQjFRRWNoM3FoVWRIYVVKaXVQVWNQ?=
 =?utf-8?B?Vk9jVUI2WW9NemNxMHRHTCtMdGt4Z2lWRWhwU1duNUxrcUx4RTJvVTRyd24r?=
 =?utf-8?B?NFprOTdzeUFNSEVsNjVFZjYrVXVHVGNIaWt6Tkh5NWRjMHFIdEgyVDhZSXlK?=
 =?utf-8?B?dWFFN01iMEVaQWx2Z0ZTcWx5SUlwY0FxRTd3Q0VMUzdNUENoc0JzcTFOeDZh?=
 =?utf-8?B?RXJ0bmtJUWZzTmViU2g2LzM2NXdrSW52amhVU09SKzNUZUxrYzFBcWw2Y2th?=
 =?utf-8?B?d2x5ZzVITzVRTEdSTzNqNlAwS3RIemt1LzVqTno2SGtMT3ZSNUZiSGw4MjUr?=
 =?utf-8?B?NDFJZGZYVlpTUzh5b0dGR1VmVlk2U3E2blBjYkpIVkp5a1VlekUreDk5MDNP?=
 =?utf-8?B?d2xLcFpzeW5sbmRSblZ6cHlPVGRmRnNERjRlMmZydDJwQ051d2h2MUg4RUhh?=
 =?utf-8?B?SDU1WHBxWWZ4MmpSeFhFY250VHZDNHN2N1hJZ2s0ODdKZ2JKM3hUbytNQlZk?=
 =?utf-8?B?THVGUHl2SFZBR0RoWlZYYlozb1FWamJvc1BKU083OU5YdEE9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NVJNN3JkVDdEYXRIanl2UzlzMnlVQU1NMVloMzdwaHBydDZWOXZMc2NtNS9q?=
 =?utf-8?B?VU9iVGtveDRlYTRRMVYvVkZwbzBUSllkWmZsVHZuSkU4V3loZ3pUYzk5NnNS?=
 =?utf-8?B?MUlJMDZUUitvTTV0dzBQZU5Na2ZVV0JlMzVHM21MK0RzaFJ4NlcweUZJS1FW?=
 =?utf-8?B?VWx5OUxJRk1DNmNKZE1OTjVjYkZINjFqR1JaTDZFT29RQkZsVmZ4bVV0NVFw?=
 =?utf-8?B?SEFjY2hyblN4eFd2S1dBODhQU2E2b3FyUlNsdVRnVFViSDF5OXYrUXlUc1pG?=
 =?utf-8?B?WnRXVzF1alZqcGF4MEc4cUI2WWFYNE1ybUR6RGN3djBqT2VESnphL2d5RTNL?=
 =?utf-8?B?M01wcUZGalQwaVV1UTNEVGlFOWNsVFN0WmtOV3UzbFpEbW5yb1lxMTVwSXlv?=
 =?utf-8?B?UWVPZlV5R2dVRFc2OVpjVXhTUmdtTXJaNlI5cDV5b2ZpUTF4ZjZyKzQzWUp3?=
 =?utf-8?B?bXUrcUNuWEdZMmFPT21XaEFRY0Q1VFNxakxzTENLcFZab1c2bUV5YmNiOTFD?=
 =?utf-8?B?K2NmeDR2TjNtOE5KdGRFQTlCNlViMERJZThJaVZnWHNhcjg4Z0lFQ0I4YkM1?=
 =?utf-8?B?U0JhUi9hTVh0UFB1NUlMak41N0R6SHR2L0NEV3h4bmFUZlA2c0cyUCt1OEdm?=
 =?utf-8?B?YlF1OVBOMWhzTmJpeXZHUENkVmFoQnJlRHJDU1RSWEdZUDAxR3pqWDZrZHRh?=
 =?utf-8?B?Y1RkTUtoSHlJODdDdExsYXpXZEVMVmYrb2hRdFlNTy9xVE1xc1ZJSnMwSVR5?=
 =?utf-8?B?SU8wbDBPb00yUFpJWkxrV2xqTVRXUGZXbDJaellrSU1yZVV2eUdkS09kZUkv?=
 =?utf-8?B?TTI2cTJSbmtFRUFXck1TRmxqRXB4cW9GVWFyOXZvMDVLYjJ5U0RkNzBCdVJy?=
 =?utf-8?B?bmExSE4wYmFFLzlpTXhsUEZpVDdhdVl6UVkrKzZPN290bTg4Mk9OMDJSbnRC?=
 =?utf-8?B?QWdFRGJLcG1GZm5ENVpORXJJSUU3amdQNVJKT2lwT2NoNmczRWhvaHpXR2JC?=
 =?utf-8?B?K3JrckZSaldPWnBtWEZXbTJJMFM0c2psY1RiLzMrcHdwZzlsZkxTVVF1OG1O?=
 =?utf-8?B?T0hjQkowamExMUxaeU0xbENXQUx4VFdPWEFhc2gyUEZuUERBVmMyWE5LL3M2?=
 =?utf-8?B?QVlXTmlpVXJvYjYxNWZKMzUrV1dLNEoxeDZiVDhSRm1VN2ZVV0dsRExKK1Bl?=
 =?utf-8?B?YitvMDJQSkRFWFArK1BQdDVtb1BFYjNDaG53RkJVSGM0VU80SWQyUWR0RDRG?=
 =?utf-8?B?eGt2dC9mYlpYRzE2U0lTYkpSTCsxNWNFNmpseFhtb0NOb282M3dQdEJReWpC?=
 =?utf-8?B?bHRHWStiSG01RmlqWThReHBMUFNPbVpIYjdWZ2Rwck5OZjJDNVY4MjFYYTVq?=
 =?utf-8?B?RU9lbDdOamlZTVZDUnlLdm91R1pibERwK3BjOXdSb3M0TUNGUHpXejhZbGI2?=
 =?utf-8?B?NUdjNU9NNlBYR2dNMjlUWWxQNjJ5ZUpQb1N2cFlZMXRXVUh0NStVSkMrY3U1?=
 =?utf-8?B?WmZUb0dXdmx5Y3R0aHdJY2JUdmU3MFR1bkE1eUs0bmhyTU5FZWZQN1g4K25O?=
 =?utf-8?B?b3pJQVJ3MnJTcWJkdlpOODRKRkJKRjcwc2V3cFB6UjUvcWpyZmt0WlBrZWpN?=
 =?utf-8?B?L0JvQ0o2UHVSMGJuSVUwTHNlTjJHUjVnaG1JTlN6RG5lZU5QTWdTcmtmYUsr?=
 =?utf-8?B?Q3BCSDNra0VUeTgvWkZDYUZFdWdIWHhYMWkvRWNhNnRNV1I3MzNuc2pVSHdJ?=
 =?utf-8?B?UWd2VXJpS0N3Uy9KY2VZV0FuNVdHTjlWSkxyWXI3ZDhsci85c1NIREN0VHdU?=
 =?utf-8?B?NXl6SzVsMFVZd3E3SkNtSm4wbjVQSFR1SXhzME5STzZseHNxUjlXT01ZaC9B?=
 =?utf-8?B?SDRWQjVPdHg2VWUxUUl0MWZCdnowaGJETGczdEM5TmpEc0x5djFEeWdzZ0lr?=
 =?utf-8?B?UWJGRTArUUh1d1o1cnkvSDBTVWpEelhSOUJCcFVxU3pNc01IMHl3UTNtVmRO?=
 =?utf-8?B?WG04emp1YUlITUpQdGNHdjJyV1RBSkIzSXdkbWV4WmVaclBiNGNHUG01TStu?=
 =?utf-8?B?R2Q0YjZrb09xUGxMWjFuWlJZWi9sQVArR0lTTzJDaGVWcUQ3cHRRTUgvNCtV?=
 =?utf-8?B?WUVvWmxwOEZYU2txbDl5RFJ1anVYcGtJNmZQOHpGbUs3QWNDcUJNMmNpUStx?=
 =?utf-8?B?cHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f9dfffd-5fd0-462d-d647-08dd580eb7a5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 15:43:59.1672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sAJF6/iBwp/pRFcwhxb+5eId/xOdjR0kojxv2v/SfgEev5a2t8g2UZfSpFZYt12mp5N9+i5zVLAShvRhZjQdjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5992
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 28 Feb 2025 15:44:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17991

On 28.02.25 08:19, Nobuhiro Iwamatsu wrote:
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---
>  scripts/update-ltp.sh | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100755 scripts/update-ltp.sh
> 
> diff --git a/scripts/update-ltp.sh b/scripts/update-ltp.sh
> new file mode 100755
> index 0000000..99b75b0
> --- /dev/null
> +++ b/scripts/update-ltp.sh
> @@ -0,0 +1,29 @@
> +#!/bin/bash
> +
> +REPO_ROOT=$(git rev-parse --show-toplevel)
> +pushd ${REPO_ROOT}/recipes-core/ltp > /dev/null
> +
> +LATEST_VER=$(git ls-remote --refs --tags  https://github.com/linux-test-project/ltp.git | \
> +	cut --delimiter='/' --fields=3 | \
> +	sort --version-sort | tail --lines=1)
> +
> +SHA256FILE="ltp-full-${LATEST_VER}.tar.xz.sha256"
> +rm -rf ${SHA256FILE}
> +
> +wget -q https://github.com/linux-test-project/ltp/releases/download/${LATEST_VER}/${SHA256FILE}
> +
> +SHA256SUM=$(cut -f 1 -d " " ${SHA256FILE})
> +RECIPE="ltp-full_${LATEST_VER}.bb"
> +
> +if [ ! -f ${RECIPE} ]; then
> +	git mv ltp-full*.bb ${RECIPE}
> +
> +	sed -i 's/\(SRC_URI\[sha256sum\] = "\).*/\1'${SHA256SUM}'"'/ ${RECIPE}
> +	git add ${RECIPE}
> +
> +	git commit -asm "recipes-core: ltp: Update to ${LATEST_VER}"
> +fi
> +
> +rm -rf ${SHA256FILE}
> +
> +popd > /dev/null

Please have a look at what shellcheck is finding. Seems it's mostly
quoting, but if we don't go to zero warnings, the next change with a
real issue will not be easy to spot.

Thanks,
Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

