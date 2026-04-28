Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28523FF8868
	for <webhook@archiver.kernel.org>; Tue, 28 Apr 2026 12:41:34 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12458.1777380083638909305
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Apr 2026 05:41:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=vxffpSap;
 spf=pass (domain: siemens.com, ip: 40.107.162.48, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LOy8mKLx8f5LgKmmfJuRn3I3s7kPBqAh4EonELLLaAfWzQFZapoqYP3cHQA89TgCIflUDOBTuF1KeLNPfWmuI+y02zWPNaJIZGEfytUPESkharRIe+qx6qy/az6S0xVOTJzMexuFivmpSb0fx4Im+plhyxBrkzoNXggQlFnlCsNVjNyIxAHNPGO8um3Xg/B3HE8n5FmkH3V/DPoCyebsksEWQRDe02Zs7CweAakWVzC+ES+BR4sD/6i45tKpcAHCh1DpLfqxk8i7aNuXfhitUgQW3VGo1LWyeNw01yoNu7FEtb/1TkZ1so10+Xj44YU5UU83arGNyP03GYwbq6k0Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UpU0OC3jf1tmdsXJsQQLWwlXHD9aiFNGeHUvLJNH0aM=;
 b=FXyapl69XHk/K41pu3QyP5jjKrAcNDgPV3kAt3K09GDlHQl3xFbhE9kSZVdPAHHK/snZ17OzlhHyHa/USmcFdLpoXHoI6a9zj4YnWIW/IES+TiwqSSOTm8LOL92jSDpEXn3Thp2mUQUeLQxgm9eKyxNgQTs4L/mfkHf2XhwS5wNvyLMsmaO9UwEfUAafF+syJ4O82z8SKhnkh0O+FD2nTyVObaVXZXPpvfoDfmQ1UjIpuhsYHVAoKXmeYK0TIiZmQMQkcV4F3Cy7b1hXBWlJn8rbNsiGB6e3IrEt/t9iz/QWHQJOIyaV0lfprzA9NjBXn0I7ePZRQw3tdAYbqmbvbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UpU0OC3jf1tmdsXJsQQLWwlXHD9aiFNGeHUvLJNH0aM=;
 b=vxffpSap5WFunyB/FG8hSmLn1hg2CEFkafD9FOQzpe0iVMmSyG21T3ReTdJp4AlSS7XDHD/IX215ZlFGKL9NUeguWytHBakqldx4N80stkUn+dzeuPQ66xQHJ31HkMPOykmHogRCo64yF8/4Ck7Rq8a4SFFG2pzrOpMX8jnR9mXjPgwk0k8oUTKyw1Uth9or5gOFei0uzCjE8dkY7CDRnbEATvUBAw+ZIEh6yszE1JwqsP6k++9cVxZ3+G2fBYxEmc13wit5wSCmaKt7/nSGzKQ1bAtU09XOHQBMCL4CLR1YjwghYZsIdeWhqs4EZdoyBWrwRKiO8UoSjKq1fNrBPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB7965.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4fc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 12:41:18 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 12:41:17 +0000
Message-ID: <bc7a255e-16a2-4c96-a7fb-1baa31e6956b@siemens.com>
Date: Tue, 28 Apr 2026 14:41:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2] crypt-hook: Check if
 WATCHDOG_DEV is set and available
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20260428113247.27835-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260428113247.27835-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0185.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB7965:EE_
X-MS-Office365-Filtering-Correlation-Id: c5b43166-2d3f-4cdf-37d7-08dea5237151
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|56012099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	zJ+1GNDgJmlB5AYtvRyJZVYv5i5jPgS8bjxCfzLxjDaPRg19J6qvD90PBuYY291YCseyy4uJAi+DZIEKnhNx272mTrGLPKrOoxO1XR6LbyKR3ie/yCTzhyld2KX857eodaTw1/HQRAi1NWZrQ7P64hUMBoSdOZRU94x2KwAAQKqnocy0EEZohIEpIVWJn17F0m9BquN3YX4x4fP58T4RQEgHnT9yPlDDcKEZXkCc7TZsa/4XuPMnZjwE3qgbSxomSxatG3MGx75ZabkUmnrLC+lwek3E8FoJBMgEijQ0Hal23wIdvQtwycUNNO48D12uVrT0trPgaKUczMSdQ0mpMhZ15Ke8QfuGBC+pwHJyjRMA64tSkltid5tXQrarKfiNwkzPQfwCpuU5PhO8Vj2yo8ii9kFj9hdlnkvjEk45D8Pa+YwFtSS5d0EIw6l7TJNr72iEGW8ipmZ1lcWrftkNxGyFhAS0fYsfG6zojqX4xOwOgNWGnQDr/jGa4uNwnmmmV3VoRTW44r9M149n3rDGTbFrCZwswQCa05b7j5rZU7ny4apQd7FZx80+3FwOCKjJRXFoZLkNJmKqrF0KhARv792yxuUVR2ZAhUJfyqJywXhVumkCM+st3ag7IybuZ3suXaXY/F1qkBaTw8PFWgwPvjI0m173MR6STPqbeePukeifbjkOXcyyRP7IV6VdJoBw0XRm/cE7+U4UdzsuAtEmRyjDb7pRg3Mb6w0UsEpeD1o=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OGlGL0FyR3FTU2xiWG1tZm5IZk5HbkR3MDN1VGJKb0ZYK1pYUFBJeHU2Vnox?=
 =?utf-8?B?MmhnU1R3MGJwc3I3RUIxTGxSQTVDTHVkVXFmZHl4UDhqTXVidVNkdFJYblp6?=
 =?utf-8?B?bmlybmFsK0kyb1RFc1hWdk5KKzR5dmRYY2U5R0ZGYnFoNk94cmIrbHd4eG9j?=
 =?utf-8?B?NVM1Y0NuQnptYmdZeitlYVFGeTc4OUgyRHJ1Z1J0NkFBMkFqKzM1cExHT3lG?=
 =?utf-8?B?Y1RrVGNHNTNiaXNWTXdqd01vajNPWXF1T0FmbG5aWmJGdnQ2UjhhR0Zzdjdo?=
 =?utf-8?B?Z2dpY25mNG1LeWtQWmVxV25FTUFqcFk1TVZTZ05PUnNUSStUVTcybzlITVJC?=
 =?utf-8?B?eHAyOGhocEMxVVdXNmtDeUdsODR2STJHbzlXZ0krSEgwYUhKeU1IUHBRcXlM?=
 =?utf-8?B?N25Uc1hvYzVZejZDMDlLMU9KWllMdzY1c081RFc4ekV6U3NmS0djQ2ZrT1VW?=
 =?utf-8?B?MU1SUEFhKytVcC84S01QeXZzTUY0UmUvUkhtQ21pbWZ0UUVVWUxYbEtVK09X?=
 =?utf-8?B?MlJyRXRKcVE1enp5TVJIcFc3ZTI4amJERXRHV2cyUUNjbW5nSUlKb2sxNms5?=
 =?utf-8?B?VXRydUF6U3NOSkluNEdwMWZ0N0ZualVIQjk4bS9MT1Z3Qnc1S3J3MlhhMWtv?=
 =?utf-8?B?YlQ0YWRXS2dxUVA1bDlmWlo5MUpBeG5hQnBUWko2amJaMXJqdUd6NUs2SVpY?=
 =?utf-8?B?QUt6cldsdFNMUmFyUmxjcW42U1lUVzJ6YTAzYjZ3aVpNWjg2cVNpbXZreTRF?=
 =?utf-8?B?VE1SdnBqSDVKWnQ2cEdsYmFibHJoNzE0T3dOd2lLNXR1TzdOdE5pUk02YXEv?=
 =?utf-8?B?Sjc1UTNDMDZWMnNyeTJqNFZ2VmtHQTA0WldhYlBQdi9hY0RqdWZ4QTFmYlJy?=
 =?utf-8?B?cDZZcGZoeUVCdElreEwvVCszcFJ3NXJZV3VML0dxSHRHUmFnOFRtejREdlZI?=
 =?utf-8?B?c2xpcXNNWlY5QWlGYnhXbGJXQW8rSGRaSUpac1RrT0Z6WnR6YU9yYWdZVHRH?=
 =?utf-8?B?Wlp3Y0E1T2o4Z1JMcTIxTnY0a3VZaEwrTXhNbXFtamw5NDYyRDU2cTVXQXo4?=
 =?utf-8?B?VE5tVW1uLzFMQ2hpUmwvaDBaVTBGdVh4Zk9TL2dVd1FUSFhKeWg3YlhpeU0z?=
 =?utf-8?B?V3NjaVlRVnJPWklzVVVRazdTRnhPNHVVTURqUmdqWC91bFl3dGpxcjl1VnF4?=
 =?utf-8?B?VmhWWnhHcEM3KzV0RjQ1QlZyMkh5bENrUEwvKzF3K29wajBDYXV6eEsvVDZN?=
 =?utf-8?B?RDMwWkJPMm93WXBKMjl3ZnU5aFdVMFMzV3ZvSERMaDZia1E0R2JYMVNlN2c2?=
 =?utf-8?B?bVRmQ0RWN2swOVNhY2NsM1UzQ3hvVEdXS3NtZUNVYnUrZGQySmVHL2ZReHp0?=
 =?utf-8?B?cEZ0Vk9xMnNuR09QTUxHTms5NTVNMGI3Z0NJNjN1YmlNMnBQOHZEMFBkTGxu?=
 =?utf-8?B?bCt4bFErOUxOQ3Y5RERBZktSNDR2QzRjR09Gd1R3RzdtbHZCNTBDaGFCUHFq?=
 =?utf-8?B?bkF4Q0YzaEVlWXRQTktIUExOa0k5WEtlT3dqTVhyK2JJMFhEdTBlMjhGdTFx?=
 =?utf-8?B?OXhXMmFGN3F0WDdUVjg3ODZLMlNMK05nUGg5ZW9nc2F3ZTNmdkhjOFB5WHcr?=
 =?utf-8?B?MXlGWGJqV3gwN2RBZWZkbG1NY202QVVXaEZ6M2Yvc3A4bUhZT1JJQk9kMnF6?=
 =?utf-8?B?QnVQMUtoT1JxSXMzTFEyeHJrOXB1NFhMR0hYa2d3UnpIZ1EvUkIxMU4zS3B3?=
 =?utf-8?B?bUhUZmpDcWhoR3FZQUs5MnMySzNFUGx5aVJHYkxIUlNJU1FHMFMvY2o0SWg4?=
 =?utf-8?B?dmtPRmVoOTdUekhTQWRzRkk4MUlBN1ZSN3lXak85dGZGSU9NU0F3UTEzTUdP?=
 =?utf-8?B?dFdxekZ3Rm5qWktDcmZKL0Z2YlVaNk1obzY2LzFVdVVoZnZNdmVsRnM0S3JX?=
 =?utf-8?B?YXhtTEl4aHRaSjRFTjhieHBRemt6RGxTanBNbEc0d0tmZHd1RTZSKzBDYVlQ?=
 =?utf-8?B?OTd0Yml0UXF3SHh2WVdvY3h3UHJKekUwa2dEOWlDczNWdW4zczhabE91MWtP?=
 =?utf-8?B?NTZVZEZHbjhBRjlxMnFzazdkS0tuYW5SMlBKZ3BmenBWa3k4cnEzZVRTUG02?=
 =?utf-8?B?ZEQ4MWxac1Z5Q2E2WDM4a3JCSFFWYUdYZnZucURWc084d0dwV24rZUNZMXhR?=
 =?utf-8?B?MDF0RkdXVlhmQy93eTY5WUMzT09XMStLM0pmbDg0MFlkTjgrcjVvVG5iRC9v?=
 =?utf-8?B?aHFKNmxRK25VVHpUWVlKaXMwV2doRDJsR0VaekFJZjY1dUFJUHJOa204eWQz?=
 =?utf-8?B?Mms0YzRuWHhkS213V2hoM3kzdEtVU2xwRm52bzk2Zi91MXpYRFVndz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5b43166-2d3f-4cdf-37d7-08dea5237151
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 12:41:17.8754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lo2JD2lU6hcuMOfsRGHPjtzXD/WknzhLnUNXe7UrHQZGfVWU8iYOJ43q9eIFJDeTsu/hZHnlr8ktHdduAca+jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB7965
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Apr 2026 12:41:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22819

On 28.04.26 13:32, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This allows the user to disable the watchdog by emptying the variable
> `INITRAMFS_WATCHDOG_DEVICE`.
> 
> Also add  a panic if the watchdog device is configured
> and not available.
> 
> Reported-by: Stefan Koch <stefan.koch@siemens.com>
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> Changes v2:
>  - if the watchdog is configured and not available panic the initrd
>  - add a message if the watchdog is disable
> 
>  .../files/local-top-complete                    | 17 ++++++++++++-----
>  ...ook_0.10.bb => initramfs-crypt-hook_0.11.bb} |  2 +-
>  2 files changed, 13 insertions(+), 6 deletions(-)
>  rename recipes-initramfs/initramfs-crypt-hook/{initramfs-crypt-hook_0.10.bb => initramfs-crypt-hook_0.11.bb} (99%)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> index 4f3eafc..e802f0b 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> @@ -2,7 +2,7 @@
>  #
>  # CIP Core, generic profile
>  #
> -# Copyright (c) Siemens AG, 2023-2025
> +# Copyright (c) Siemens AG, 2023-2026
>  #
>  # Authors:
>  #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> @@ -64,10 +64,17 @@ if [ -z "${create_file_system_cmd}" ]; then
>  fi
>  
>  service_watchdog() {
> -	for n in $(seq $(($SETUP_TIMEOUT / 10)) ); do
> -		printf '\0'
> -		sleep 10
> -	done > "$WATCHDOG_DEV"
> +	if [ -n "$WATCHDOG_DEV" ]; then
> +		if [ ! -f "$WATCHDOG_DEV" ]; then
> +			panic "Could not find '$WATCHDOG_DEV' - Please check your kernel configuration."
> +		fi
> +		for n in $(seq $(($SETUP_TIMEOUT / 10)) ); do
> +			printf '\0'
> +			sleep 10
> +		done > "$WATCHDOG_DEV"
> +	else
> +		echo "Watchdog is disabled."
> +	fi
>  }
>  
>  check_partitions()
> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.10.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb
> similarity index 99%
> rename from recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.10.bb
> rename to recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb
> index c0572f2..331a662 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.10.bb
> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb
> @@ -1,7 +1,7 @@
>  #
>  # CIP Core, generic profile
>  #
> -# Copyright (c) Siemens AG, 2020-2025
> +# Copyright (c) Siemens AG, 2020-2026
>  #
>  # Authors:
>  #  Quirin Gylstorff <quirin.gylstorff@siemens.com>

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

