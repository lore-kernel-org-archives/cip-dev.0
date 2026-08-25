Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41CC2C61DBE
	for <webhook@archiver.kernel.org>; Tue, 25 Aug 2026 14:53:08 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.3])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23863.1787669580192498140
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Aug 2026 07:53:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=RomKnPnG;
 spf=pass (domain: siemens.com, ip: 52.101.84.3, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=akM5MyFd86f02PIFwn49Mqhk1XS9HbbOmtGFfFWeC93tSBlYRY5AWaq4A1ASQxSrzrKYsBTG//na5XKMwFWlVHASu8i4RHHDA/k3qbahYUomHY4xEZObqEssxC048bNcMAIPqQGfDBBet6+H7p5klX2eG27/nT+6AfsAaeCSYZtnT4q00yf1Lpx2rk34nShQPQmt7mnu3pvQgQBRPcx6NcVj6PVA7n8BhjFdu7QPOxMiND2nALI6p4E52Y6ssCpWE74vUdfPSgtThuR5PQDEBI6lAR+p1mwM+Zykz64WuzV2bl1CDjljCgDfJxTQ+gDANb6zKNV4G5Glc0pfB7ZqNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1bWeY4OK0D86rcpueBKzFW6qOQFZ+LyQaLZ4PXAJ3sA=;
 b=MDMp1DKhII9Rzr7XrVWiCqnEJyosYs34iXFrxkAU3LbGjQt6kGHgKDLmmurSwO3CaotER4fUw+OeOCpOhaolFjHNRMYO6eKHGrWM2wB4uZ9rzSoa6uqv/0WQkoffeHL0cWAedS3t0F6IWo8ISIsSeb/qe4Y+UrwlWWy3zwXZB7QhlW7NlIzQQ7h4XmsnOEp6uV3s6AsB7k7Ojy61jiyz0o/KTUeqDPT5AbUsUMIhZG6w7nhW5i3UtAkEh/ACE66vSA4JMYtnsV535i98F7ZLsB7kAZn2zHVEAh4HqFFxDlhLtVtbC/y02deWDsyORgsWD3kH1oY5p5NeR4NXomvrvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bWeY4OK0D86rcpueBKzFW6qOQFZ+LyQaLZ4PXAJ3sA=;
 b=RomKnPnGUE306O2o2aVofXvIc0tqG7btTGFzJJPVRiEV60E8xxjzm+zYhxm7uJw7P66ya2z5F3IPbTcuOr0Z+0ldsXOxsw0v+sRuP+BDA0k2hyrcT9V6rJwKYbuwW3xxi2wnSbYxFDF7daxuVq5bIf0xNJpo2JLxfTuP9Y1HmCXBc+aUZcPBFBFI0fS74m/c+dChpa2J6kS6T1oqv9/GU2DtJXF+kuMh5cZXPcET2s0O+9zbtJSGiYisuju9bN3jmg037MHTG89z2wgg2WCaFEnU+nyST0VkbnEdHSDz+RitDwRvLw/KMbj7PAsjmJq94bo9/jT7iYgluX47P1O3Qg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PR3PR10MB4093.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 14:52:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 14:52:55 +0000
Message-ID: <55c253df-f5a3-4885-bba9-c307726c9b31@siemens.com>
Date: Tue, 25 Aug 2026 16:52:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC 1/2] initramfs-crypt-hook: Move
 service watchdog to cip functions
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, alexander.heinisch@siemens.com
References: <20260825143802.3764929-1-quirin.gylstorff@siemens.com>
 <20260825143802.3764929-2-quirin.gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260825143802.3764929-2-quirin.gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0258.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PR3PR10MB4093:EE_
X-MS-Office365-Filtering-Correlation-Id: bbcd2366-63e2-408a-99ba-08df02b88be8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|6133799003|10067099003|4143699003|56012099006|5023799004|11063799006|18002099003|55112099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: 
	CoXAcy1+AASwY0dje1pCJOlvZpdAgDgF/vjP0FZv/ZrkyUlLBq1YbaXS7x3o8gYjWob5a7hzwe5sHvC3/V4qJD94H+KQlEfkKROwQsFyiYgLfJX9gAFmASdToSsYus3uHLcjwzD890zYRD8UZac/v1UlsU0iqjPVP7D5iWH017Q6OVzdViAtq5ST58OaHlCs1AI6nlN3v5wuTOvXjf3pd+tXqgYNbJJyLhojt3llr4JboWvZ65bs9enmPltCHlNz4crlY4teXZvNuiijCLisxd1/iakmB1IdEM8+GrffXvMTxIK+EvHT/0TTcCXspksCtBqiuTd7RHhOkbfCNvFhjkLoYJSrGuiWpd2IP+k/CZNIVqC3hT5SOt823Vdnojbwtr6Yo1pG7q+WLnxT2bTm9HoKxyAbAOxBLyW1VP6rctYfqVaEaRxsYwr5uQq2rtMRvhaKKD5+phDKPwEjRVy4KVJUKpllWP6eE1lTqyeeKd8jZWFZJXtAXwExlJwXWRuUACFxbqTcWXpEHp6L7TOfgVGvh644sjQFN5JvMS79sni0COFd/7yMkH8b5LPYh4Gp+kuLw7LHoXKxmpfgZH695L3zcnlTRD2ryPvdnXj2OpnOOQYG24mOhl+b8P8ZQn77XDgVmJOBJCgg+/Tik1diJafe6gKXQ621ZaYWMHVukuI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(10067099003)(4143699003)(56012099006)(5023799004)(11063799006)(18002099003)(55112099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?U2djVU80T1I2NitSMnNFOTlVaU1Wa2tzejBpeWllMjlxb0I2SjhzQ0ZrbUhZ?=
 =?utf-8?B?VTdhRkNjMWY0VGx6clN0Y0VWbDNqL05kSXJSR3l6ZkxtNkZkV1ZLYlpSWWVs?=
 =?utf-8?B?Nm10d2FqYWlHQTZSS2xHM0tYUEJkYXRScmdvTGpXcnNJTlpQTmZnWk5IOFRh?=
 =?utf-8?B?R1BiYmlDYzFKMWp1bnQxbEp1bnlESUVRd1ZVa3Fuc3JhcThqQXpuOFQ5dlp1?=
 =?utf-8?B?Y2lvRWZoWHBrQ2FkL1NuMHpTV2loMVJ1YVhFQ1VYSDZoTTZqVWkvRjJmWCt0?=
 =?utf-8?B?eDlOaFN0aWhuY1RXTXhGV2pZYlRxMmQ3YVZEOWcrVml5aVYxVHpmM3NobWFa?=
 =?utf-8?B?Q3dmY2xpT0JxbGh2ODhsK3l4aFIvWndQM1N6QzV2c2FUMjk1Vy93RVZZYlJr?=
 =?utf-8?B?MDZWb2l1QXRFKzN4UndPTmtZUXNnc1UyUjJDa1pSOElrQitwYlFLS1hMWW52?=
 =?utf-8?B?VlN0S0VTaTlUdEVXRTZ1cVRqYzJ5RUI3L081SllTd0FFbFZVUGVSNGRZL0dD?=
 =?utf-8?B?dDFLOXFFQmt1dGZaS2J4Z0tNZmx0RHUrWTg3V2dtYTluczFmRWtubDBlTFZv?=
 =?utf-8?B?QWNFUzhEdGZFVEcrYjl0ejRhL1QwNExiWmNsRXAxb2FVejl2S0FmQ0dnYzhs?=
 =?utf-8?B?ZG5QYXkyZ29SbjUyQmEwbjIrRnZyT085VVJNL05nU0lPaENPaVM5MFJnSW93?=
 =?utf-8?B?TENDbmpRdDM1MWNyNHdiYk9WeUl1K3lpUXMreVhGY2crODU1WnNyZHhkZXds?=
 =?utf-8?B?YVRCWGo1OUxJSENHNmw5aVlpekMzMnZXejhhRzR3YVozOWdaelZhVGJidFBE?=
 =?utf-8?B?a3B6aHhueXhVQ1F4MldJcEpYUmNwRjRnL3lqZHVKMGtsYmlMT3NvV0RnZ3RV?=
 =?utf-8?B?VHhYUG5MMGlZNjJ5ZStLbG9zd3Z2ZzF5Qi9mdVI3Y283Y3ZLZVZCc2FvOTlk?=
 =?utf-8?B?N1NPZ2wxcGt6MmlmQlVWdmROcklyMkl4TUdFSkNEMHNrVnhwMklNeEp6NFY2?=
 =?utf-8?B?M24wY1lTbUtMdXkxNzh3VVZmV2pJdEczaGUyb05MR0puN0xrUkJQTlhiSEl4?=
 =?utf-8?B?N0ZOWlNWcjBDYkxNaDBsOGhtN0FqWjQzQ3k2V01QMHJMVHQ1Q1lYN09rMUcy?=
 =?utf-8?B?RE9tTERDUkhpRGZHVnQ0aWVOQm1XNjMwT1VkdEFRQk1aR29MalF3a1llaGdu?=
 =?utf-8?B?TVduYWxQeW10dTBhVU9PZ3B0K080RzJtUmNhSFZuMDRhNnpTUFZmMDZ3V3da?=
 =?utf-8?B?bkh3YWxoWE90ZVNZc0hsWHdrWnM4clgrdU9CS1JQQU1xbEw2eXRHNjlRQ084?=
 =?utf-8?B?ZERzMGUvQm5saGtkZ0RKOU5kTWdPTGJ2NHlHNzlwR2pOVE94VmtCNHYvTGRQ?=
 =?utf-8?B?WWVXVmFUaTRSejY3cFgydjdhbEYvVFU0Z2lLcVgzVkIyWldVTm93REJVM3pa?=
 =?utf-8?B?WlNEQXFnc1k2V3RLN2lpUGpCOUtTRjNpZ3VCTHdvOUJPYUtXSDZ6dFBXRG9h?=
 =?utf-8?B?d0lUbmFFeldIUDN1Nm50cFdGVTVKSFpBVHFqV2NSZTV5WkZidGZsZ1JBMkxH?=
 =?utf-8?B?NXdpSXhWeE5LczNjQ2V4TksvWnVXUTFubGtnOFNXYWJYejJHZFRnM0ZRRExS?=
 =?utf-8?B?TGl4NnVhNFdvR0s4QUVmenU5TFhWcFBxbFFKV05DblVIWWNQR3NQRmJnamhx?=
 =?utf-8?B?TWl3Y1NRcXg0eVF6cDlTVFhZRm9VVStJazMzZWQxQWgyb0lhY1RCRjdqaHVU?=
 =?utf-8?B?d2dwUmZueDhpSllycW5XRGl4RGVEUCtDdE96M29FdHk2elEwaFVJcVVrSHhT?=
 =?utf-8?B?N2VEMkxwa3ZkY1U5VEdKSnhRSm1KdXZLSSszdGt6aHh4c0ZSd1Nab2dqbXpr?=
 =?utf-8?B?UytLbFRWZWp5Ukd4cjBJSGRYTmU5NzlmMlF4b1NPM3J0RG5iOTl2aUJPaklE?=
 =?utf-8?B?VTdMUUZpVURjeld6cU9ubDhyYjNvbitUUkxxRjhCS1dvYTRZNUx0VWxkMys4?=
 =?utf-8?B?TFlVVFJMRExwN29vNlVvVkNWK1hsQTNCcThoanI2dHBVZjhtT05sZEM2VW5W?=
 =?utf-8?B?ZVY4RENSaDd4Rnc1N2lOS0pvN0lybGNZSFpzRDJVa3NzaTZrN1VZWVNZMXds?=
 =?utf-8?B?TkNmS25MMG9VRSt3K2M0VG5HZnVldjAvcTJhT0xWUXdyOG90b0ZRQzZLcHJn?=
 =?utf-8?B?Rm1aZGFLRW9xYkVBNXl6bUpDeGxZNTFJREI0L09YS2IvWURhSVJjRngrSUEv?=
 =?utf-8?B?NDBZTmZZZ2JsVnk1bjhJdkk5MXlSQjN3MVk2N0xqUTJ5N24xUlNRNXdwVlhn?=
 =?utf-8?B?c0tuN1l2anoxOEpCeDVUczIyenkrMEQxeFdyS0FEdXBLWmU3SmV6endvaFpj?=
 =?utf-8?Q?Ou2P7SsGVOXpmWGA=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbcd2366-63e2-408a-99ba-08df02b88be8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 14:52:55.5636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a/IXMmBNEhYbHe0U4zR7H+LrdE9UDUxGYqcmAtnS5jllJBRTxOGwX9lq8wkTsV0tQOHNUKoZJ507EpmcfbaxSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4093
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Aug 2026 14:53:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24001

On 25.08.26 16:37, Quirin Gylstorff wrote:
> This is in preparation for deleting all data during factory reset.
> 
> Also rename CRYPT_SETUP_TIMEOUT to INITRAMFS_SETUP_TIMEOUT
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .../files/cip-initramfs-functions             | 43 ++++++++++++++++++-
>  ..._0.1.bb => initramfs-cip-functions_0.2.bb} |  0
>  .../files/encrypt_partition.env.tmpl          |  2 +-
>  .../files/local-top-complete                  | 23 +---------
>  ...k_0.11.bb => initramfs-crypt-hook_0.12.bb} |  9 ++--
>  5 files changed, 50 insertions(+), 27 deletions(-)
>  rename recipes-initramfs/initramfs-cip-functions/{initramfs-cip-functions_0.1.bb => initramfs-cip-functions_0.2.bb} (100%)
>  rename recipes-initramfs/initramfs-crypt-hook/{initramfs-crypt-hook_0.11.bb => initramfs-crypt-hook_0.12.bb} (95%)
> 
> diff --git a/recipes-initramfs/initramfs-cip-functions/files/cip-initramfs-functions b/recipes-initramfs/initramfs-cip-functions/files/cip-initramfs-functions
> index a4c1fed6..bffd3f21 100644
> --- a/recipes-initramfs/initramfs-cip-functions/files/cip-initramfs-functions
> +++ b/recipes-initramfs/initramfs-cip-functions/files/cip-initramfs-functions
> @@ -2,7 +2,7 @@
>  #
>  # CIP Core, generic profile
>  #
> -# Copyright (c) Siemens AG, 2025
> +# Copyright (c) Siemens AG, 2025 - 2026
>  #
>  # Authors:
>  #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> @@ -68,3 +68,44 @@ scan_for_partitions() {
>      fi
>      return 1
>  }
> +
> +service_watchdog() {
> +    watchdog_dev="$1"
> +    setup_timeout="$2"
> +    if [ ! -e "$watchdog_dev" ]; then
> +        panic "Could not find '$watchdog_dev' - Please check your kernel configuration."
> +    fi
> +    for _ in $(seq $((setup_timeout / 10)) ); do
> +        printf '\0'
> +        sleep 10
> +    done > "$watchdog_dev"
> +}
> +
> +start_watchdog() {
> +    if [ -z "$1" ]; then

This function has two parameters. If only the first one is empty, you
may check the second one here.

> +        echo "Watchdog is disabled."

echo is bad (though not new): initramfs-tools has a knob in its log
services to silence outputs.

> +        return 0
> +    fi
> +    watchdog_pid=""
> +    if [ -f /run/watchdog.pid ]; then
> +        watchdog_pid=$(cat /run/watchdog.pid)
> +    fi
> +    if [ -z "$watchdog_pid" ]; then
> +        service_watchdog "$1" "$2" &
> +        watchdog_pid=$!
> +        echo "$watchdog_pid" > /run/watchdog.pid
> +    fi
> +}
> +
> +stop_watchdog() {
> +    if [ -f /run/watchdog.pid ]; then
> +        watchdog_pid=$(cat /run/watchdog.pid)
> +    fi
> +    if [ -n "$watchdog_pid" ]; then
> +        while kill -9 "$watchdog_pid" 2>/dev/null; do
> +            sleep 1
> +        done
> +        rm -f /run/watchdog.pid
> +        unset watchdog_pid

Why unset? Will that var survive the function context? Then why not use
that var between start and stop as well, skipping the creation of
/run/watchdog.pid?

> +    fi
> +}
> diff --git a/recipes-initramfs/initramfs-cip-functions/initramfs-cip-functions_0.1.bb b/recipes-initramfs/initramfs-cip-functions/initramfs-cip-functions_0.2.bb
> similarity index 100%
> rename from recipes-initramfs/initramfs-cip-functions/initramfs-cip-functions_0.1.bb
> rename to recipes-initramfs/initramfs-cip-functions/initramfs-cip-functions_0.2.bb
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
> index 787172f6..c9ae70a6 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
> @@ -3,7 +3,7 @@
>  #
>  PARTITIONS="${CRYPT_PARTITIONS}"
>  CREATE_FILE_SYSTEM_CMD="${CRYPT_CREATE_FILE_SYSTEM_CMD}"
> -SETUP_TIMEOUT="${CRYPT_SETUP_TIMEOUT}"
> +SETUP_TIMEOUT="${INITRAMFS_SETUP_TIMEOUT}"
>  WATCHDOG_DEV="${INITRAMFS_WATCHDOG_DEVICE}"
>  HASH_TYPE="${CRYPT_HASH_TYPE}"
>  KEY_ALGORITHM="${CRYPT_KEY_ALGORITHM}"
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> index 7bc08e55..308527a6 100755
> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> @@ -63,20 +63,6 @@ if [ -z "${create_file_system_cmd}" ]; then
>  	create_file_system_cmd="mke2fs -t ext4"
>  fi
>  
> -service_watchdog() {
> -	if [ -n "$WATCHDOG_DEV" ]; then
> -		if [ ! -e "$WATCHDOG_DEV" ]; then
> -			panic "Could not find '$WATCHDOG_DEV' - Please check your kernel configuration."
> -		fi
> -		for n in $(seq $(($SETUP_TIMEOUT / 10)) ); do
> -			printf '\0'
> -			sleep 10
> -		done > "$WATCHDOG_DEV"
> -	else
> -		echo "Watchdog is disabled."
> -	fi
> -}
> -
>  check_partitions()
>  {
>  	found=0
> @@ -303,10 +289,7 @@ for partition_set in $partition_sets; do
>  	fi
>  
>  	# service watchdog in the background during lengthy re-encryption
> -	if [ -z "$watchdog_pid" ]; then
> -		service_watchdog &
> -		watchdog_pid=$!
> -	fi
> +	start_watchdog "${WATCHDOG_DEV}" "${SETUP_TIMEOUT}"
>  
>  	# Create random password, store it in the tpm2, sealed via PCR:7,
>  	# to allow continuing reencryption in case of power-failure.
> @@ -370,6 +353,4 @@ if [ -x /usr/bin/tpm2_shutdown ]; then
>  	tpm2_shutdown -c
>  fi
>  
> -if [ -n "$watchdog_pid" ]; then
> -	kill "$watchdog_pid"  > /dev/null 2>&1
> -fi
> +stop_watchdog
> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.12.bb
> similarity index 95%
> rename from recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb
> rename to recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.12.bb
> index 49ccc076..27b186aa 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb
> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.12.bb
> @@ -24,7 +24,8 @@ DEBIAN_DEPENDS .= ", \
>      tpm2-tools, \
>      coreutils, \
>      uuid-runtime, \
> -    initramfs-cip-functions"
> +    initramfs-cip-functions, \
> +    psmisc"

Was this dep forgotten so far?

>  
>  CRYPT_BACKEND:buster = "clevis"
>  CRYPT_BACKEND:bullseye = "clevis"
> @@ -56,7 +57,7 @@ HOOK_COPY_EXECS = " \
>      tpm2_pcrread tpm2_testparms tpm2_flushcontext tpm2_shutdown \
>      tpm2_startauthsession tpm2_policypcr tpm2_createprimary tpm2_create \
>      tpm2_load tpm2_evictcontrol tpm2_unseal tpm2_getcap \
> -    /usr/lib/*/libgcc_s.so.1"
> +    /usr/lib/*/libgcc_s.so.1 fuser"

fuser seems unused.

>  
>  HOOK_COPY_EXECS:append:clevis = " \
>      clevis clevis-decrypt clevis-encrypt-tpm2 clevis-decrypt-tpm2 \
> @@ -89,7 +90,7 @@ CRYPT_PARTITIONS ??= "var:/var:reencrypt"
>  # in a newly formatted LUKS Partition
>  CRYPT_CREATE_FILE_SYSTEM_CMD ??= "/usr/sbin/mke2fs -t ext4"
>  # Timeout for creating / re-encrypting partitions on first boot
> -CRYPT_SETUP_TIMEOUT ??= "600"
> +INITRAMFS_SETUP_TIMEOUT ?= "${@ d.getVar('CRYPT_SETUP_TIMEOUT') or 600}"
>  # Watchdog to service during the initial setup of the crypto partitions
>  INITRAMFS_WATCHDOG_DEVICE ??= "${@'/dev/watchdog' if int(d.getVar('WDOG_TIMEOUT') or 0) > 0 else ''}"
>  # clevis needs tpm hash algorithm type
> @@ -102,7 +103,7 @@ CRYPT_BTRFS_SUPPORT ??= "0"
>  INITRAMFS_CRYPT_MOUNT_OPTIONS ??= "defaults,nodev,nosuid,noexec"
>  
>  TEMPLATE_VARS += "CRYPT_PARTITIONS CRYPT_CREATE_FILE_SYSTEM_CMD \
> -    CRYPT_SETUP_TIMEOUT INITRAMFS_WATCHDOG_DEVICE CRYPT_HASH_TYPE \
> +    INITRAMFS_SETUP_TIMEOUT INITRAMFS_WATCHDOG_DEVICE CRYPT_HASH_TYPE \
>      CRYPT_KEY_ALGORITHM CRYPT_ENCRYPTION_OPTIONAL INITRAMFS_CRYPT_MOUNT_OPTIONS"
>  TEMPLATE_FILES += "encrypt_partition.env.tmpl"
>  

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

