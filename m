Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBFAC54E58
	for <webhook@archiver.kernel.org>; Mon, 18 Mar 2024 11:32:14 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.55])
 by mx.groups.io with SMTP id smtpd.web10.41125.1710761531941620416
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 Mar 2024 04:32:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=cRIHsY49;
 spf=pass (domain: siemens.com, ip: 40.107.105.55, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dhf0oAUjiuRix01VlCTpf+42WLKWJs+AEepskBF0P/YYUDDhy4vWWQlxTykzjRBuB2kFGtOnLAmhib6luxoQ0G/BkY6XaHCfeirZDpPVL3MYiOjva7jrfdJ4HCc8te50odbnu0k3OPCgJ/oU9pINrik7t8dkWl1AsfnE2oNWmyKh/QlNEIskn7LyjBDdtxG7lYa1HZbGexn/ZqW1JpwVri8ro95xmgjhwEnPWIMt0dgtm6w/cWTjXVBQAmnC1G6c3HB0pcFiO15VBWS1F7uTscYknuuQD/ZCxOMoe7vOlQ260pijzsita2d3LHYyztIGVYH+FosU/KgGx8z9Jq0rOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5aFvPC5ZVwQPQw8yawW7D5CDqy5RR6P5gYnTHTFCzY=;
 b=Nat1Famx0hryIYuSpCwc79UdsANA9wMrmPUEumtTA4+YcnyXoa4caZMNTYLpMwxLACZhEISBQQbY3rBpuV58FrR8K7CyH02BfAK/S3MkcSNgQmW+or7/HREZPo/mrVdwy+25fB9iM1hd42Z/J4Q31zjilB+2tpt6FUfWWUx6FF6ngee3gOD+u2I30qnQ6MeN82HVDCeN4y8AD+dHZrq2RVXMWKlVRZ9GM2PqA9iIZSNOkDpZZn2qVaklWp/StBDN6XAKQVFxP+weYYczY10eRMHQleI7pxRVTmlKZcxT8kr8EP4CrtQg2pviHOATt/4/zMgUhWIrcvOkhOznJjKFBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5aFvPC5ZVwQPQw8yawW7D5CDqy5RR6P5gYnTHTFCzY=;
 b=cRIHsY49+KtJ7erA4TpZikIgQNj43OfX8kIhuTTIXpyqc71koON2KqyeG0GVl9Yawo+5Uj8GAg+7Zny1IPeCj/a6W/uGKnTe+3fG7WybZOZW7GcDgiXXx0sbsk9/qyRCDq70FzwuIYU5IEF/nX+4RV39LFrYtc2INJdxl9Fu/kgnA6MoameC/x6o65NwXy0W0y0BMvBnKaPgXkTSDyLR+F9gitmAEDnJ5hx/ulXCaqqucWkNanNvtAr/FwFVCK9LI4ePPZVmMC+OENbHnWltmFBONJB0K/1XiHtWfhUPwYzxMMjh7XmZRfOouIxx2/tA4WhJ59RtuhTUap3RH9EYXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7289.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 11:32:09 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 11:32:09 +0000
Message-ID: <cdce2e2e-6a6a-4cac-85fc-10685e44887e@siemens.com>
Date: Mon, 18 Mar 2024 12:32:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH 2/3] conf/distro/cip-core-*:
 prefer swupdate 2023.12 for all distro except buster
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20240314123736.1100948-1-Quirin.Gylstorff@siemens.com>
 <20240314123736.1100948-3-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240314123736.1100948-3-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7289:EE_
X-MS-Office365-Filtering-Correlation-Id: d0f1ca3f-83e9-4a9f-897a-08dc473f0c27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	c7dE93IoHDRovi7BVJnlPQQB+oaigzt5ly0Jfv8+R/sm56iDFOTdEr0Z7Qke4WPCT4snzYmvTNcvFQrL2Aktersnuw7W1nRC59MilRJkip/0KkMdH7rsi5Wc8W/O2mS8K5oSylNf7WM+MIRagKgUVnKbLeuP5g77z7r0+jq9Jh3KilQ0H16hE9/E4jSXXAPj/uNWBQzIBcBquwWMeYFY/CbwhKsE/CCrh1hS2y0LKv0VZ9Ax7fEzDBfRDbogPNItsa7NY9fGcxCwl3Igf5lM0uYaxUvkKJwfPa2McCb464O4A6UeBjVNwXG7pym3bjN6czJa+3LLNbYLlUHxGSRmwOXg6VbuMS79QVACaiddDGnsw2TpUqSw4WleQ0WaOi6AJE6ZCREG/T4WKWnWtVnhXM9ZOawoEsYGxYeXmt22SsrJBcMDhTdz/d4yp9VPTc4n23ABGkO69NYt7PIB5fU88yXq7yay1wsf81Q2xE9NoV9prslFrBiH4jpeUS4rpNRY6UhJ6i0wU6zQhaqCjJemmB1g1HGkC3xzIRuwZQd1v7tvkznk/Rdbbdp1xCo0knw0XL1NcMt1Xfiib3OrMmssox3dQXtcmuU3wHxKQmlJvwdc4qxwGmhADX0z9fMkcTqY98afZLT7uQXPHztVfUilNB/pZK44sM6FjenKIDLwjDc=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZUw3c3craTZiN0dKMW0rWGRYS0lWV3EyT2RlWm1MV0x2K0I2bVA4OFRCekZR?=
 =?utf-8?B?UElKM3Nhby93K1ExNXcwMUE2bWZVNnhyZ0NJT2kwd0lScnZkL3JGa2JON3Zq?=
 =?utf-8?B?Q0xNb1p2RnNjWVd6L1R6NjdMSUd1Lzh1VGx4M1ROWXIxbEVFTUYvMlY5RkFy?=
 =?utf-8?B?U2pHaENSY3VTK2s3eWVibEljajJQc2tHUWVJaEZyNmtYQ2FQa2MwVDRnUmpN?=
 =?utf-8?B?VHZab00xaE9VVWV3QVAwQnpOK3JxeHduRFVPbmk2VlExaFo3bkRMRE4zVFhP?=
 =?utf-8?B?SFRFL3hScGFhL3A4YUhOSE01ODJ1Wm9QNm03bnNjTlF3NUVPOTQ0UGNxbXZY?=
 =?utf-8?B?OU1ZZFcxYkQ5QWtqZ1FqYkxCTVpxUTE2eDBSK2xibTc5Rk5LWFQ3Q0J1clNF?=
 =?utf-8?B?UTVEL0dMZklTTzM0VDMvZ3ZxQUNZOHdVdEhNWWt5alU3WnRVRXI5S0VLZWdO?=
 =?utf-8?B?bERIZ2o1cko5NVoyeFpCL2ZRNkdIa0NhTnBIazRWVlN1b20yYTNpUUpjTTZo?=
 =?utf-8?B?OVF0WlY4dndEL1BSTlBrMzVBaTFnN2pyUFpHY2JlTTdGenNldGFmUURxZVBB?=
 =?utf-8?B?emE4eDkxUHFmTmFnYVlFV2FtcmVDcTZGYmZoNFhnc01VU2s4RXBzd0prSUQx?=
 =?utf-8?B?U3A3dHVSZDBTTitSeGxqSkFGK0NsVks2bC9OQ0Q1aW5FZFJMQUlrUVlUc2Rx?=
 =?utf-8?B?b2daOStiZDFRcmI1VlQ4VUl1WkNFMi96djY3a2wwUXFqa2hXVGNnNmYxaHBn?=
 =?utf-8?B?NDdtLzE4aXVlTW8rS1V6UXlrY0dXMjFrL2JYa3dwQXFDWDJzS0dVa2VhQTRh?=
 =?utf-8?B?Z1lkMmpHUEh2WENkSU91MWdwd3lYd01HbllUVE03bHp5djNvR0pENnZIRmln?=
 =?utf-8?B?V3NqZ1c3bkdKV3I4TnRocUtxZEtWTFBTdEJ6aVB2YVl2ajRoajBIb1ZPa0lH?=
 =?utf-8?B?d2hGTlo0OXQ3VVl5emNiNEJBOWV4elI5S0RjdWYrL28zVVhNWnlOenhxQS9J?=
 =?utf-8?B?Z2IxRHZkOFdyQkdiQ1c1bXI3QkpTcHVlMUFkZlY0VHBKMWVnVXVRSER5VU1R?=
 =?utf-8?B?bkNyR1ZlSFQvZ2xaN2ZGZDh0UE8vSHo2d0RXajRwM0RpcHRyMXhmalg2dWt6?=
 =?utf-8?B?SHV2VFZRSkxwMGFObFFiT09sUjl2MU82TS9UNEZhVFB3bnc1SFVOZXFZWUYy?=
 =?utf-8?B?Vnk2R3lLOWVYM21kWDNKa1BqLytWcmkrSjIvaUdMUHcxODF0SXJBelY1UEJ4?=
 =?utf-8?B?NDlMUHBYSVpmVnlDK3Axc1ZaRHZJN1NPQ0xFdnE1SkZaQzdLMVBXblRpbUEx?=
 =?utf-8?B?NWVaNXR1bHNEVWQzcW1pSWgrZVpRcnV0L3Y4WVpvV0VvemtiZkFGVG1iQjRw?=
 =?utf-8?B?bmZVV0wreFp5Vk5TNnNWOW1ZSC9XQ0JPcG1XS041QVd4LytOTmxrenlla1lp?=
 =?utf-8?B?V29CM1JCciswc0dIbHlLYi9yK0JsZVNybWxIUzlLakFiZ3FvSkh6ZkhEQzdF?=
 =?utf-8?B?V1BTOU5lZUdsaEdhN2hEWVVRVk1rcG9XeEpFSkx6S1ZwcEM4eWxyQk13djdS?=
 =?utf-8?B?WDVyT3JjN1ptaklydUNYbmM0d0V0K3VTdzRKVERDeU9JeitBU0M3VWdTeEp0?=
 =?utf-8?B?Z1lZd09oSWlWZXVsTHNkSVNVbkxlTDJ4Y1ZocmV2b2VIbnlrSTNVeVh6Qnp3?=
 =?utf-8?B?VVhWcUtrcDBpd29oOVUyekFPSms2UHZEYnp6R3k3ckpGbThKbitHM0s5ZTBv?=
 =?utf-8?B?U1Q0SG5DQ3l6dGoxN3hBQ1JxYkdrM3grN203Umw1bjNFR2Q3WTMreUVVblYy?=
 =?utf-8?B?RE1rWGJkdGJLODY5bnl3T2lkSGJPR3p5bStUeG9GVGlMR25iQk9SZlp6QmZQ?=
 =?utf-8?B?cWJ3QWloVXFCSzkxNm8rRFA0SFFsWUVuUTNPSDh3SC9rangxSGMvdVZldHBu?=
 =?utf-8?B?L0t1WDdxcElvaHc0Q1JzMVF4SW04US9oaWsyNUpBQzVXUnlldlpkTVVuc1Rt?=
 =?utf-8?B?Z3FDV1k5MGZScVNOZVdoUnNpN1JqZmhHN2RtYUNud0M5Slh5OHd6bGNUTlgv?=
 =?utf-8?B?OEI4dU1rTzB2MitVUE5MeFBrclNGbWRuN0M3c3V0T0JzM0UvSUtSaDZtb0kv?=
 =?utf-8?Q?O10uOc3SOm4zWsv0sEKrdqkSr?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0f1ca3f-83e9-4a9f-897a-08dc473f0c27
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 11:32:09.3182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Spnb0kQjhLbjBthBwwYvTHsqKpwZcjkk87Ae3WDBiXFH1+h9JYwpdVh6DB5Ng1HRO9BHYSqgBYstXDHzTCJ3PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7289
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 18 Mar 2024 11:32:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15343

On 14.03.24 13:36, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  conf/distro/cip-core-bookworm.conf | 3 ++-
>  conf/distro/cip-core-bullseye.conf | 2 +-
>  conf/distro/cip-core-sid.conf      | 2 +-
>  3 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/conf/distro/cip-core-bookworm.conf b/conf/distro/cip-core-bookworm.conf
> index 9bcf559..634a666 100644
> --- a/conf/distro/cip-core-bookworm.conf
> +++ b/conf/distro/cip-core-bookworm.conf
> @@ -12,6 +12,7 @@
>  require conf/distro/debian-bookworm.conf
>  require cip-core-common.inc
>  
> -PREFERRED_VERSION_swupdate ?= "2023.05%"
> +PREFERRED_VERSION_swupdate ?= "2023.12%"
> +PREFERRED_VERSION_libubootenv-dev ?= "0.3.5%"
>  PREFERRED_VERSION_linux-cip ?= "6.1.%"
>  PREFERRED_VERSION_linux-cip-rt ?= "6.1.%"
> diff --git a/conf/distro/cip-core-bullseye.conf b/conf/distro/cip-core-bullseye.conf
> index 4f26299..110f334 100644
> --- a/conf/distro/cip-core-bullseye.conf
> +++ b/conf/distro/cip-core-bullseye.conf
> @@ -15,6 +15,6 @@ require cip-core-common.inc
>  DISTRO_APT_SOURCES:append:swupdate = " conf/distro/debian-bullseye-backports.list"
>  DISTRO_APT_PREFERENCES:append:swupdate = " conf/distro/preferences.swupdate-bullseye-backports.conf"
>  
> -PREFERRED_VERSION_swupdate ?= "2023.05%"
> +PREFERRED_VERSION_swupdate ?= "2023.12%"
>  PREFERRED_VERSION_linux-cip ?= "5.10.%"
>  PREFERRED_VERSION_linux-cip-rt ?= "5.10.%"
> diff --git a/conf/distro/cip-core-sid.conf b/conf/distro/cip-core-sid.conf
> index aff4572..692c105 100644
> --- a/conf/distro/cip-core-sid.conf
> +++ b/conf/distro/cip-core-sid.conf
> @@ -15,6 +15,6 @@ require cip-core-common.inc
>  DISTRO_APT_SOURCES = "conf/distro/cip-debian-sid-snapshot.list"
>  HOST_DISTRO_APT_SOURCES = "${DISTRO_APT_SOURCES}"
>  
> -PREFERRED_VERSION_swupdate ?= "2023.05%"
> +PREFERRED_VERSION_swupdate ?= "2023.12%"

This is a dead leftover. We are using Debian's 2023.12 already in sid.
I'm dropping that line completely.

Jan

>  PREFERRED_VERSION_linux-cip ?= "6.1.%"
>  PREFERRED_VERSION_linux-cip-rt ?= "6.1.%"

-- 
Siemens AG, Technology
Linux Expert Center


