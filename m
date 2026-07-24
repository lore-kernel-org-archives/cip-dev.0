Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BDEC531C9
	for <webhook@archiver.kernel.org>; Fri, 24 Jul 2026 12:22:09 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18040.1784895718929662013
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jul 2026 05:21:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Z0b8k+bV;
 spf=pass (domain: siemens.com, ip: 52.101.84.49, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rr3kT/0PjVy8LLJeTs+PZbwD5XUbZ723u8BixJ+wZ1FFs+FRM/GA2OItk57MHQeRNfYbO0zH3vBG+QcvpDwJfZCJBqkHJygziAP2bPG/hm/FqsH8LpBWcWBXjT9z1Up+1VM5AejbvtP/RryfIqQfNsFXK2c6jiYDCImGQn1VRaskO2s1YnenuM2CudS/osczj8Qo2gi+Xijk97jCSGW5yaHP7fehkeAGBeaQofxl6o7vpYc8BmSL1d4VBpPbtg6iFdVEudA+0Hgr5fLNGwsOYS1RDgsvjk0g6jFjeKNNY8onScUOuM775bs9v3OE4HVvXktaL68uzLp5k6i0PMNU7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rf4gMR17YiwnOYInRKPfkrfjrMiBm4Hz79VS0EPfzr8=;
 b=O/YOb0pSehWdcYm8FA91CIx0vztfpIgnA+XH5XNjXoWnEHmjRQIGcfVrHlOEEw33he+spOQh6tM4RMhgSWF5bf41HPYYVuZH2+KrAkY3++fgTFrXlNuu0bMJUmwdVO5RQ5YV2CHpWQmjlaAFc+nHvhcVOlxzaG/IllibGf4fmnD7x6b9/jMIUJfbq4ASjyAT/FMqQhilj0Std0a9z/6SFEyBoX735/JhtKYJ10srV4Af9jp37ZZboXtRwtsHr1JPDV27yYYDoNyKCPU81plpAx+xB+eSRplrPRdncosAClhKxgoi1OwyamFRs00CO9Wq9afzU+m6YhXcbagBB66G0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rf4gMR17YiwnOYInRKPfkrfjrMiBm4Hz79VS0EPfzr8=;
 b=Z0b8k+bVAVp8PsjxWEWg+DznatC5Qu7bzbE4C/sVLl4wZudIboepicqduB+rOTih5dwZaYPeHjBDttBl0899vLDt3+3H40LcQV/aXllqQk4/bS0Rqd2Gf+fOGQZE7D+T21ojqQBbmngFl+p8Y9swBt2b+0pZF8eMwBijhrcymyWf1+pkOMhgYVCzzRvX60yZGqGPnalW1ZBSDBaKtwUJckKrZf0LS99FnzwRfsfrFZFJqZPGivmXsR9k17JadjwLudMPYBTXiQASwxo7gym/WrUPuLK+am6EB64oT41ujW8iDVzHRJW5G9T/HlfCKvcoAy4L9UwYW8mtut7yvYzjhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by AS8PR10MB6022.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:50b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 12:21:54 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%5]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 12:21:53 +0000
Message-ID: <fb4bc091-0807-41ae-9fae-452e6bce4b6e@siemens.com>
Date: Fri, 24 Jul 2026 14:21:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [RFC cip-dev][isar-cip-core][PATCH 1/4] update to kas
 5.4
To: cip-dev@lists.cip-project.org
References: <20260724105116.3575045-1-Quirin.Gylstorff@siemens.com>
 <20260724105116.3575045-2-Quirin.Gylstorff@siemens.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <20260724105116.3575045-2-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0351.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::14) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|AS8PR10MB6022:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f552708-b4aa-4d9c-ad45-08dee97e257d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|366016|376014|4022899009|1800799024|6133799003|56012099006|11063799006|10067099003|4143699003|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	3HTQxvR7hVrFC6EaTpTdZBh0XnUS3CS1vN1L/p/dZyNsU+wOrjgORoHfS3lXUaBhf89VWhc8xZaFaWs3L1FKp+/TYq9zWvGhCM3pY9Ycs5sIx+42XLSo+93yp2KSA83Hn0oYE37oy0H2vKmbv1qJnPpD3EfkvTNJqVPCNbGL9JA5e+8g4GVB2PQsnAepRM8hdwjynhjz6lhzm9/6/L6izCQCIFLjkl5CyJk/KfZlGZMuayL8Ht/wOqBPtFe3tK8Br63t53Hq1GKQQ5k/5EeY+O7sZDrlljUoIxQo+sjakoesioIas3WKzQ7dWzhDaovcFqaVie3l0GWMOMOoUaTMbm2lOM7FEnvDr4zpqnI10FyPU6CDsmsvSkI3SHStTSSE0ItaxqZ5ZOuc0Q4DdXTclt7XBefGf89zOh//cuzdyKNFpdtOt8nhsiKDiOb47fYxE4ngqgySP0EYjhn76i5I9JQQZHRDeuJ9e8rq6W0a4jIEdhgVaKrJbB0YCSVrVWaSHSdDRGTR834bPbbOUfWl9SBpBp0IzSGkdRHg+RjdZliUE+Fa2pkmgc4Re3oE/bnRFXCqIk1bzy9Act357UFm1wMXCSrbjU9leMDwMBbIxkdfW3GTDQD9t+uH0vnYEhjd
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(4022899009)(1800799024)(6133799003)(56012099006)(11063799006)(10067099003)(4143699003)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NUNZMFB0dFRkeGxYeU5ZTjg5T2s3aEFSdnZxOTdaMytYK1M1M3liTThwNnNk?=
 =?utf-8?B?Sk5pTndIMEJ2QUdXSGlobzRyL1YxU1U3QlcxbU5JenQ0YlJkVjBYVU1icThp?=
 =?utf-8?B?K21XWUw4WmM4dXhmc1cxZWxHcG5vWnFDdUVYYjhCVTN4WE9LbkdxOXdTVXRV?=
 =?utf-8?B?eWU4YVB6d1l4b1N3RlhsajV1YnErN0Z1aEpONHJnUlY4SStBVEx4aFVrdE1L?=
 =?utf-8?B?Uk5Db0xaM0xWNDhlMFhtUlIrZGdUaUZSeHcwR0k1TEh2ZE9ST080aXB2WHEx?=
 =?utf-8?B?cGhNYVRibU0xZnRCbEJndytscTJtb0NFM3dyRHFiazgrdlU5MzhsWGhxbnZU?=
 =?utf-8?B?cnUwU0pieHlUODMzZTlXM282NzNvQjN0WXBkRWplbzYwR3dsMERCUWxqdUxD?=
 =?utf-8?B?WGJsZms5RDFoNmlzT01TdEQ0Qit3cUNSN1dCVi82QXVPblFDRCsyWUx1eGJt?=
 =?utf-8?B?MUJYNktqaHhuMEtmeFdzQkVQMWxLc0NmTXJ4UFg2a090d3NYb3cxWENxVVAw?=
 =?utf-8?B?ZTJLZHlOZ0kxa2tSbWZKaGlIbjZtT1Yxb3dzMmVBN3d2eGhjc1JmMUhRclha?=
 =?utf-8?B?djRFbGNrOEhzUUFuYm1sOUNrNUFsWDQvQndJSFVEOWhhb2NXbHZWRG5NaUxa?=
 =?utf-8?B?c2tPLzB5RC9ZNXRIRTBjYlg0b3Ftd256ZDNpVGlnQkdwNVYxN1JGeVFrUjJG?=
 =?utf-8?B?a3EwcEI2LzhJZ3VrOGtTQ0V6dzF2VnhVUm1iVmZ6Y0ZsaitQcXpOQnNoek0w?=
 =?utf-8?B?c0pmbmIrdTZhZ0dnTkRTdDBkbWJEeG9Ia2lFV1R2ZWI2YUVyYm1pU3lBdlly?=
 =?utf-8?B?MFZmRmMwdnpoUlRyZE1nUVE5bjJGOEhjNk93YUdpa05HN0F0MEp3anZ3RVJw?=
 =?utf-8?B?a2d2NzBxQlNuT0h4WlJSc3NZZVVFWnVPUENsTFZWYVg3NmtENmc5STZPVWxG?=
 =?utf-8?B?WG1ZSjNkYzNkN3JmaEtwbjVWaTRVZGNvUWYxOHFlbkZFQWxYWkZLNXhNYzZt?=
 =?utf-8?B?eVVHczFGNkNhSmFzZTF5bHRobC9JWEhBUklzL0E1dThwRHBKVXJQR05TNWVm?=
 =?utf-8?B?ZkNxNVBCVThCTGRWcFpIOEprZE54bDZXWXpmMzdLTDBLU1NVMHl6K0FUcWI4?=
 =?utf-8?B?NU9XK3Y2SzRhQVhrTFdjeVBGTmRvQ0MwcEdEV1JBaHlocmxxNUtTUmVYRlNY?=
 =?utf-8?B?L3lydXBUWHIybUltUkNOL3REV0UyZ09pbS9VM1FNZVA2WDA3NXM2ZTVDRDc2?=
 =?utf-8?B?UWxHNktJZGxRdnhkdXZIRFl5TythUzlkSzVIMVZSaGhaS0JtLzkyVFBUbDJG?=
 =?utf-8?B?UUZneTBXUGJMOEFFMEpnY09HMzJKcXNxYk52VEtOMmxDQkpHNU9GdW1GOHZn?=
 =?utf-8?B?NzdzWTl4bjlCWmU0WnBjQWVabmVibW5JaTJVNzNKUU14ejNPcStKWmZ5a1hI?=
 =?utf-8?B?ZFFzNE9NdmJUeHgrdTdrakZBMUd5WXNGS0dZdmtvUm9YN3hMMkw2WmRTdXJ1?=
 =?utf-8?B?a21LT200azFsVE51WGZXVzBmaWs5MHF5cjhhMm9EcGZHT3QyU0R1dHFTekxT?=
 =?utf-8?B?cU9kbnN4NlE0eHlJdmVVVEdNeklER3pwMGgrZzY5dXBBbzFFOWtYNXpneld1?=
 =?utf-8?B?TFdpRVpDRysrZ1dHbkppb1NDa202WUhjVnRJbkdEZ0YzZFJhck8wcC9rTlhJ?=
 =?utf-8?B?TStTSFNSQnM0UGNvbldabUVHRnphZzA5MjJHdmFWUFFUMnkrcUk5bnFBRU9R?=
 =?utf-8?B?ZTJLS25ETDI5WkptNmhLOHhSa1VZNCt6aHFjSmpXNW9kV1p0am00bjVHMDFx?=
 =?utf-8?B?WlAwZTNnUlY5WS9xZGRUWE1XQStPRCtzU0Fvdko4WnFnVTFuaHdTeTR0RTRr?=
 =?utf-8?B?dzB1RVQ5elVtbGhIZmtqaXRQMm0yby9zbUdDcEgvVUU2RlZBY1lUaDUrenlX?=
 =?utf-8?B?UGllWnY4dlErd0lsMjZRR3U1dEVjVXVxcTdydmJYMWxFdHZIOVpGc0pJckxO?=
 =?utf-8?B?LzFpTWhwVmgvckJtRDEvQWpBSTlPWUpSaHFIQng1ZE9pYnlYVk94aUZVSGUx?=
 =?utf-8?B?MUJGYXNjZ2thYVowWGR6MGtrTGdva3k2U0MwOXJ5Ni84RzNMQVlyWHBHdTlj?=
 =?utf-8?B?NWU1Q1Vjc3BPa2M0OVRDamgreGhBekNvM2EwbXQzNHVkNWFtMGRMMnRPWHh1?=
 =?utf-8?B?SDdVTHBIWVFxWTl1bDJXbkRCMVl1YnE0c0ZFVlhHUzZBUnhIeGpQaE1aRnpw?=
 =?utf-8?B?NVV2WGpoK0RmZ0xYTmY2R05HQjVxTmF6OG0vamF5bDBOWkYxOFByNENrbmYy?=
 =?utf-8?B?SmoybU95blh1UTkzaVkxVmVKcWN4S3VscjBlWTdoUzlQVUUzV2ZwRFhPbSsx?=
 =?utf-8?Q?tAdnaL/rVDT3hO7M=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f552708-b4aa-4d9c-ad45-08dee97e257d
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 12:21:53.8581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V4Y22bkcd+vOA6PbpBZJkgq+vDQYBb+Fv0zre5pO3/Ifbh+xI5pAsYoG8rd5/olYv/fbVOwDWEv/BHUy2LF5UKRqtvICN0Ul+DrmtoE8bgo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6022
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jul 2026 12:22:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23737



On 7/24/26 12:51 PM, Quirin Gylstorff via lists.cip-project.org wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>   .gitlab-ci.yml |   2 +-
>   kas-cip.yml    |   2 +-
>   kas-container  | 311 ++++++++++++++++++++++++++-----------------------
>   3 files changed, 170 insertions(+), 145 deletions(-)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index b53def4..1e61cb0 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -33,7 +33,7 @@ stages:
>     - cve-check
>   
>   default:
> -  image: ghcr.io/siemens/kas/kas-isar:5.2
> +  image: ghcr.io/siemens/kas/kas-isar:5.4
>     before_script:
>       - export http_proxy=$HTTP_PROXY
>       - export https_proxy=$HTTPS_PROXY
> diff --git a/kas-cip.yml b/kas-cip.yml
> index 23bbba4..6badc7d 100644
> --- a/kas-cip.yml
> +++ b/kas-cip.yml
> @@ -15,7 +15,7 @@ header:
>   distro: cip-core-trixie
>   target: cip-core-image
>   
> -build_system: isar
> +build_system: isar-privileged

Forgot to update the Kconfig to isar-privileged.
Will send a v2.


Quirin
>   
>   repos:
>     cip-core:
> diff --git a/kas-container b/kas-container
> index 993f0bb..55bdcfc 100755
> --- a/kas-container
> +++ b/kas-container
> @@ -27,7 +27,7 @@
>   
>   set -e
>   
> -KAS_CONTAINER_SCRIPT_VERSION="5.2"
> +KAS_CONTAINER_SCRIPT_VERSION="5.4"
>   KAS_IMAGE_VERSION_DEFAULT="${KAS_CONTAINER_SCRIPT_VERSION}"
>   KAS_CONTAINER_IMAGE_DISTRO_DEFAULT=""
>   KAS_CONTAINER_IMAGE_PATH_DEFAULT="ghcr.io/siemens/kas"
> @@ -49,9 +49,10 @@ usage()
>   	printf "%b" "\nPositional arguments:\n"
>   	printf "%b" "build\t\t\tCheck out repositories and build target.\n"
>   	printf "%b" "checkout\t\tCheck out repositories but do not build.\n"
> +	printf "%b" "diff\t\t\tCompare two kas configurations.\n"
>   	printf "%b" "dump\t\t\tCheck out repositories and write flat version\n"
>   	printf "%b" "    \t\t\tof config to stdout.\n"
> -	printf "%b" "lock\t\t\tCreate and update kas project lockfiles\n"
> +	printf "%b" "lock\t\t\tCreate and update kas project lockfiles.\n"
>   	printf "%b" "shell\t\t\tRun a shell in the build environment.\n"
>   	printf "%b" "for-all-repos\t\tRun specified command in each repository.\n"
>   	printf "%b" "clean\t\t\tClean build artifacts, keep sstate cache and " \
> @@ -61,20 +62,19 @@ usage()
>   	printf "%b" "cleanall\t\tClean build artifacts, sstate cache and " \
>   		    "downloads.\n"
>   	printf "%b" "purge\t\t\tRemove all data managed by kas. Run with '--dry-run'\n"
> -	printf "%b" "     \t\t\tto check what would be removed\n"
> +	printf "%b" "     \t\t\tto check what would be removed.\n"
>   	printf "%b" "menu\t\t\tProvide configuration menu and trigger " \
>   		    "configured build.\n"
>   	printf "%b" "\nOptional arguments:\n"
> -	printf "%b" "--isar\t\t\tUse kas-isar container to build Isar image. To force\n"
> -	printf "%b" "      \t\t\tthe use of run0 over sudo, set KAS_SUDO_CMD=run0.\n"
> -	printf "%b" "--with-loop-dev		Pass a loop device to the " \
> -		    "container. Only required if\n"
> -	printf "%b" "\t\t\tloop-mounting is used by recipes.\n"
> +	printf "%b" "--isar-privileged\tRun an Isar build in privileged mode. " \
> +	            "To force the use\n"
> +	printf "%b" "\t\t\tof run0 over sudo, set KAS_SUDO_CMD=run0.\n"
> +	printf "%b" "--isar-rootless\t\tRun an Isar build in rootless mode.\n"
>   	printf "%b" "--runtime-args\t\tAdditional arguments to pass to the " \
> -			"container runtime\n"
> +			"container runtime.\n"
>   	printf "%b" "\t\t\tfor running the build.\n"
>   	printf "%b" "-l, --log-level\t\tSet log level (default=info).\n"
> -	printf "%b" "--version\t\tprint program version.\n"
> +	printf "%b" "--version\t\tPrint program version.\n"
>   	printf "%b" "--ssh-dir\t\tDirectory containing SSH configurations.\n"
>   	printf "%b" "\t\t\tAvoid \$HOME/.ssh unless you fully trust the " \
>   		    "container.\n"
> @@ -83,13 +83,15 @@ usage()
>   	printf "%b" "\t\t\tAvoid \$HOME/.aws unless you fully trust the " \
>   		    "container.\n"
>   	printf "%b" "--git-credential-store\tFile path to the git credential " \
> -		    "store\n"
> +		    "store.\n"
> +	printf "%b" "--git-credential-socket\tPath to the git credential cache " \
> +	       "socket.\n"
>   	printf "%b" "--no-proxy-from-env\tDo not inherit proxy settings from " \
>   		    "environment.\n"
>   	printf "%b" "--repo-ro\t\tMount current repository read-only\n" \
> -		    "\t\t\t(default for build command)\n"
> +		    "\t\t\t(default for build command).\n"
>   	printf "%b" "--repo-rw\t\tMount current repository writable\n" \
> -		    "\t\t\t(default for shell command)\n"
> +		    "\t\t\t(default for shell command).\n"
>   	printf "%b" "-h, --help\t\tShow this help message and exit.\n"
>   	printf "%b" "\n"
>   	printf "%b" "You can force the use of podman over docker using " \
> @@ -143,11 +145,6 @@ prepare_sudo_cmd()
>   
>   enable_isar_mode()
>   {
> -	if [ -n "${ISAR_MODE}" ]; then
> -		return
> -	fi
> -	ISAR_MODE=1
> -
>   	KAS_CONTAINER_IMAGE_NAME_DEFAULT="kas-isar"
>   	KAS_ISAR_ARGS="--privileged"
>   
> @@ -159,14 +156,38 @@ enable_isar_mode()
>   		export PATH="${PATH}:/usr/sbin"
>   	elif [ "${KAS_DOCKER_ROOTLESS}" = "1" ]; then
>   		prepare_sudo_cmd
> -		export DOCKER_HOST="${DOCKER_HOST:-unix:///var/run/docker.sock}"
> -		debug "kas-isar does not support rootless docker. Using system docker"
> +		DOCKER_HOST_DEFAULT="$(docker context inspect default --format '{{.Endpoints.docker.Host}}')"
> +		export DOCKER_HOST="${DOCKER_HOST:-$DOCKER_HOST_DEFAULT}"
> +		debug "kas-isar does not support rootless docker. Using system docker in $DOCKER_HOST"
>   		# force use of well-known system docker socket
>   		KAS_CONTAINER_COMMAND="${_KAS_SUDO_CMD} ${KAS_CONTAINER_COMMAND}"
>   		KAS_DOCKER_ROOTLESS=0
>   	fi
>   }
>   
> +enable_isar_rootless_mode()
> +{
> +	KAS_CONTAINER_IMAGE_NAME_DEFAULT="kas-isar"
> +
> +	# Use --privileged to pass the ambient capabilities into the container.
> +	# When calling from the user session (podman or docker-rootless), this
> +	# is fundamentally different from the system docker run --privileged
> +	if [ "${KAS_CONTAINER_ENGINE}" = "podman" ]; then
> +		KAS_RUNTIME_ARGS="${KAS_RUNTIME_ARGS} --userns=keep-id --privileged"
> +	elif [ "${KAS_DOCKER_ROOTLESS}" = "1" ]; then
> +		KAS_ISAR_ARGS="--privileged"
> +	else
> +		# we don't need --privileged, but we need to run with SYS_ADMIN
> +		# to be able to unshare.
> +		KAS_ISAR_ARGS=" \
> +			--security-opt seccomp=unconfined \
> +			--security-opt apparmor=unconfined \
> +			--security-opt systempaths=unconfined \
> +			--cap-add=SYS_ADMIN \
> +		"
> +	fi
> +}
> +
>   enable_oe_mode()
>   {
>   	if [ "${KAS_CONTAINER_ENGINE}" = "podman" ]; then
> @@ -174,6 +195,7 @@ enable_oe_mode()
>   		# calling "podman run" has a 1:1 mapping
>   		KAS_RUNTIME_ARGS="${KAS_RUNTIME_ARGS} --userns=keep-id"
>   	fi
> +	BUILD_SYSTEM="openembedded"
>   }
>   
>   enable_unpriv_userns_docker()
> @@ -210,6 +232,20 @@ check_and_expand()
>   	realpath -e "$_varval"
>   }
>   
> +# SC2034: DIR appears unused (ignore, as they are used inside eval)
> +# shellcheck disable=2034
> +setup_kas_dirs()
> +{
> +	KAS_WORK_DIR="${KAS_WORK_DIR:-$(pwd)}"
> +	KAS_WORK_DIR="$(check_and_expand KAS_WORK_DIR required)"
> +	KAS_BUILD_DIR="$(check_and_expand KAS_BUILD_DIR create)"
> +	KAS_REPO_REF_DIR="$(check_and_expand KAS_REPO_REF_DIR required)"
> +	DL_DIR="$(check_and_expand DL_DIR createrec)"
> +	SSTATE_DIR="$(check_and_expand SSTATE_DIR createrec)"
> +	BB_HASHSERVE_DB_DIR="$(check_and_expand BB_HASHSERVE_DB_DIR createrec)"
> +	KAS_BUILDTOOLS_DIR="$(check_and_expand KAS_BUILDTOOLS_DIR createrec)"
> +}
> +
>   # Params: FILE
>   # Returns: root repo dir of file
>   repo_path_of_file()
> @@ -260,14 +296,6 @@ forward_dir()
>   	fi
>   }
>   
> -check_docker_rootless()
> -{
> -	KAS_DOCKER_ROOTLESS=0
> -	if [ "$(docker context show)" = "rootless" ]; then
> -		KAS_DOCKER_ROOTLESS=1
> -	fi
> -}
> -
>   enable_docker_rootless()
>   {
>   	warning "Rootless docker used, only limited functionality available."
> @@ -281,122 +309,48 @@ enable_docker_rootless()
>   	KAS_RUNTIME_ARGS="${KAS_RUNTIME_ARGS} -e KAS_DOCKER_ROOTLESS=1"
>   }
>   
> -KAS_GIT_OVERLAY_FILE=""
> -kas_container_cleanup()
> -{
> -	if [ -f "${KAS_GIT_OVERLAY_FILE}" ]; then
> -		trace rm -f "${KAS_GIT_OVERLAY_FILE}"
> -	fi
> -}
> -trap kas_container_cleanup EXIT INT TERM
> -
>   set_container_image_var()
>   {
> +	# if the image is explicitly set, use that
> +	if [ -n "${KAS_CONTAINER_IMAGE}" ]; then
> +		return
> +	fi
>   	KAS_IMAGE_VERSION="${KAS_IMAGE_VERSION:-${KAS_IMAGE_VERSION_DEFAULT}}"
>   	KAS_CONTAINER_IMAGE_DISTRO="${KAS_CONTAINER_IMAGE_DISTRO:-${KAS_CONTAINER_IMAGE_DISTRO_DEFAULT}}"
>   	KAS_CONTAINER_IMAGE_NAME="${KAS_CONTAINER_IMAGE_NAME:-${KAS_CONTAINER_IMAGE_NAME_DEFAULT}}"
>   	KAS_CONTAINER_IMAGE_PATH="${KAS_CONTAINER_IMAGE_PATH:-${KAS_CONTAINER_IMAGE_PATH_DEFAULT}}"
> -	KAS_CONTAINER_IMAGE_DEFAULT="${KAS_CONTAINER_IMAGE_PATH}/${KAS_CONTAINER_IMAGE_NAME}:${KAS_IMAGE_VERSION}"
> -	KAS_CONTAINER_IMAGE="${KAS_CONTAINER_IMAGE:-${KAS_CONTAINER_IMAGE_DEFAULT}}"
> +	KAS_CONTAINER_IMAGE="${KAS_CONTAINER_IMAGE_PATH}/${KAS_CONTAINER_IMAGE_NAME}:${KAS_IMAGE_VERSION}"
>   	if [ -n "${KAS_CONTAINER_IMAGE_DISTRO}" ]; then
>   		KAS_CONTAINER_IMAGE="${KAS_CONTAINER_IMAGE}-${KAS_CONTAINER_IMAGE_DISTRO}"
>   	fi
>   }
>   
> -# SC2034: DIR appears unused (ignore, as they are used inside eval)
> -# shellcheck disable=2034
> -setup_kas_dirs()
> -{
> -	KAS_WORK_DIR="${KAS_WORK_DIR:-$(pwd)}"
> -	KAS_WORK_DIR="$(check_and_expand KAS_WORK_DIR required)"
> -	KAS_BUILD_DIR="$(check_and_expand KAS_BUILD_DIR create)"
> -	KAS_REPO_REF_DIR="$(check_and_expand KAS_REPO_REF_DIR required)"
> -	DL_DIR="$(check_and_expand DL_DIR createrec)"
> -	SSTATE_DIR="$(check_and_expand SSTATE_DIR createrec)"
> -	KAS_BUILDTOOLS_DIR="$(check_and_expand KAS_BUILDTOOLS_DIR createrec)"
> -}
> -setup_kas_dirs
> -
> -KAS_CONTAINER_ENGINE="${KAS_CONTAINER_ENGINE:-${KAS_DOCKER_ENGINE}}"
> -if [ -z "${KAS_CONTAINER_ENGINE}" ]; then
> -	# Try to auto-detect a container engine
> -	if command -v docker >/dev/null; then
> -		case $(docker -v 2>/dev/null) in
> -		podman*)
> -			# The docker command is an alias for podman
> -			KAS_CONTAINER_ENGINE=podman
> -			;;
> -		Docker*)
> -			# The docker command is the real docker
> -			KAS_CONTAINER_ENGINE=docker
> -			;;
> -		*)
> -			# The docker command is an unknown engine
> -			fatal_error "docker command found, but unknown engine detected"
> -		esac
> -	elif command -v podman >/dev/null; then
> -		KAS_CONTAINER_ENGINE=podman
> -	else
> -		fatal_error "no container engine found, need docker or podman"
> -	fi
> -fi
> -
> -KAS_RUNTIME_ARGS="--log-driver=none --user=root"
> -
> -case "${KAS_CONTAINER_ENGINE}" in
> -docker)
> -	KAS_CONTAINER_COMMAND="docker"
> -	enable_unpriv_userns_docker
> -	check_docker_rootless
> -	;;
> -podman)
> -	KAS_CONTAINER_COMMAND="podman"
> -	KAS_RUNTIME_ARGS="${KAS_RUNTIME_ARGS} --security-opt label=disable"
> -	;;
> -*)
> -	fatal_error "unknown container engine '${KAS_CONTAINER_ENGINE}'"
> -	;;
> -esac
> -
> -# parse kas-container options
> +# parse kas-container options, leave build system empty to distinguish between
> +# explicitly set via flag and implicitly via config.
> +BUILD_SYSTEM=""
> +KAS_OPTIONS_DIRECT=""
> +KAS_EXTRA_RUNTIME_ARGS=""
>   while [ $# -gt 0 ]; do
>   	case "$1" in
> -	--isar)
> -		enable_isar_mode
> +	--isar | --isar-privileged)
> +		if [ "$1" = "--isar" ]; then
> +			warning "The semantic of '--isar' might change in the" \
> +				"future. Please use '--isar-privileged' instead."
> +		fi
> +		BUILD_SYSTEM="isar-privileged"
>   		shift 1
>   		;;
> -	--with-loop-dev)
> -		if ! KAS_LOOP_DEV=$(/sbin/losetup -f 2>/dev/null); then
> -			if [ "$(id -u)" -eq 0 ]; then
> -				fatal_error "loop device not available!"
> -			fi
> -			prepare_sudo_cmd
> -			if ! [ "$KAS_SUDO_CMD" = "sudo" ]; then
> -				fatal_error '--with-loop-dev requires sudo for device setup.'
> -			fi
> -			sudo_command="/sbin/losetup -f"
> -			sudo_message="[sudo] enter password to setup loop"
> -			sudo_message="$sudo_message devices by calling"
> -			sudo_message="$sudo_message '$sudo_command': "
> -			# SC2086: Double quote to prevent globbing and word splitting.
> -			# shellcheck disable=2086
> -			if ! KAS_LOOP_DEV=$(sudo -p "$sudo_message" $sudo_command \
> -				2>/dev/null); then
> -				fatal_error "loop device setup unsuccessful!" \
> -				            "try calling '$sudo_command' with root" \
> -				            "permissions manually."
> -			fi
> -		fi
> -		KAS_WITH_LOOP_DEV="--device ${KAS_LOOP_DEV}"
> +	--isar-rootless)
> +		BUILD_SYSTEM="isar-rootless"
>   		shift 1
>   		;;
> -	--runtime-args|--docker-args)
> -		[ $# -gt 0 ] || usage
> -		KAS_RUNTIME_ARGS="${KAS_RUNTIME_ARGS} $2"
> +	--runtime-args | --docker-args)
> +		[ $# -gt 1 ] || usage
> +		KAS_EXTRA_RUNTIME_ARGS="${KAS_EXTRA_RUNTIME_ARGS} $2"
>   		shift 2
>   		;;
>   	--ssh-dir)
> -		[ $# -gt 2 ] || usage
> +		[ $# -gt 1 ] || usage
>   		KAS_SSH_DIR="$2"
>   		shift 2
>   		;;
> @@ -408,15 +362,22 @@ while [ $# -gt 0 ]; do
>   		shift 1
>   		;;
>   	--aws-dir)
> -		[ $# -gt 2 ] || usage
> +		[ $# -gt 1 ] || usage
>   		KAS_AWS_DIR="$2"
>   		shift 2
>   		;;
>   	--git-credential-store)
> -		[ $# -gt 2 ] || usage
> +		[ $# -gt 1 ] || usage
>   		KAS_GIT_CREDENTIAL_STORE="$2"
>   		shift 2
>   		;;
> +
> +	--git-credential-socket)
> +		[ $# -gt 1 ] || usage
> +		KAS_GIT_CREDENTIAL_SOCKET="$2"
> +		shift 2
> +		;;
> +
>   	--no-proxy-from-env)
>   		KAS_NO_PROXY_FROM_ENV=1
>   		shift 1
> @@ -446,19 +407,19 @@ while [ $# -gt 0 ]; do
>   	--*)
>   		usage
>   		;;
> -	clean|cleansstate|cleanall|purge)
> +	clean | cleansstate | cleanall | purge)
>   		KAS_REPO_MOUNT_OPT_DEFAULT="ro"
>   		KAS_CMD=$1
>   		shift 1
>   		break
>   		;;
> -	shell|lock)
> +	shell | lock)
>   		KAS_REPO_MOUNT_OPT_DEFAULT="rw"
>   		KAS_CMD=$1
>   		shift 1
>   		break
>   		;;
> -	build|checkout|for-all-repos|menu)
> +	build | checkout | for-all-repos | menu)
>   		KAS_REPO_MOUNT_OPT_DEFAULT="ro"
>   		KAS_CMD=$1
>   		shift 1
> @@ -486,6 +447,10 @@ while [ $# -gt 0 ]; do
>   	esac
>   done
>   
> +KAS_RUNTIME_ARGS="--log-driver=none --user=root"
> +
> +setup_kas_dirs
> +
>   [ -n "${KAS_CMD}" ] || usage
>   
>   KAS_EXTRA_BITBAKE_ARGS=0
> @@ -494,17 +459,17 @@ KAS_FILES=
>   # parse kas sub-command options
>   while [ $# -gt 0 ] && [ $KAS_EXTRA_BITBAKE_ARGS -eq 0 ]; do
>   	case "$1" in
> -	--format|--indent|--provenance|--skip|--target|--task)
> +	--format | --indent | --provenance | --skip | --target | --task)
>   		KAS_OPTIONS="${KAS_OPTIONS} $1 $2"
>   		shift 1
>   		shift 1 || KAS_OPTIONS="--help"
>   		;;
> -	-c|--cmd|--command)
> +	-c | --cmd | --command)
>   		KAS_BITBAKE_C_OPTION_ARGS="$2"
>   		shift 1
>   		shift 1 || KAS_OPTIONS="--help"
>   		;;
> -	-E|--preserve-env)
> +	-E | --preserve-env)
>   		fatal_error "$1 is not supported with ${KAS_CONTAINER_SELF_NAME}"
>   		;;
>   	--)
> @@ -563,10 +528,10 @@ if [ "${KAS_CMD}" = "menu" ]; then
>   	if [ "$(echo "${KAS_FIRST_FILES}" | wc -w)" -ne "1" ]; then
>   		fatal_error "menu plugin only supports a single Kconfig file"
>   	fi
> -	BUILD_SYSTEM=$(tr '\n' '\f' 2>/dev/null < "${KAS_FIRST_FILES}" | \
> +	BUILD_SYSTEM=${BUILD_SYSTEM:-$(tr '\n' '\f' 2>/dev/null < "${KAS_FIRST_FILES}" |
>   		sed -e 's/\(.*\fconfig KAS_BUILD_SYSTEM\f\(.*\)\|.*\)/\2/' \
>   		    -e 's/\f\([[:alpha:]].*\|$\)//' \
> -		    -e 's/.*default \"\(.*\)\".*/\1/')
> +		    -e 's/.*default \"\(.*\)\".*/\1/')}
>   else
>   	if [ -z "${KAS_FIRST_FILES}" ]; then
>   		KAS_FIRST_FILES="${KAS_WORK_DIR}/.config.yaml"
> @@ -574,20 +539,60 @@ else
>   
>   	# We only get the first build system and let kas check if mixed
>   	_KAS_FIRST_FILE=$(echo "${KAS_FIRST_FILES}" | awk '{print $1}')
> -	BUILD_SYSTEM=$(grep -e "^build_system: " "${_KAS_FIRST_FILE}" 2>/dev/null | \
> -		sed 's/build_system:[ ]\+//')
> +	BUILD_SYSTEM=${BUILD_SYSTEM:-$(grep -e "^build_system: " "${_KAS_FIRST_FILE}" 2>/dev/null |
> +		sed 's/build_system:[ ]\+//')}
>   fi
>   
> -if [ "${BUILD_SYSTEM}" = "isar" ]; then
> +KAS_CONTAINER_ENGINE="${KAS_CONTAINER_ENGINE:-${KAS_DOCKER_ENGINE}}"
> +if [ -z "${KAS_CONTAINER_ENGINE}" ]; then
> +	# Try to auto-detect a container engine
> +	# Defaults if there are multiple options:
> +	# podman if build system is isar-rootless, docker otherwise
> +	if [ "${BUILD_SYSTEM}" = "isar-rootless" ] && command -v podman >/dev/null 2>&1; then
> +		KAS_CONTAINER_ENGINE=podman
> +	elif command -v docker >/dev/null 2>&1 && docker -v 2>/dev/null | grep -q '^Docker'; then
> +		KAS_CONTAINER_ENGINE=docker
> +	elif command -v podman >/dev/null 2>&1; then
> +		KAS_CONTAINER_ENGINE=podman
> +	else
> +		fatal_error "no container engine found, need docker or podman"
> +	fi
> +fi
> +
> +KAS_DOCKER_ROOTLESS=0
> +case "${KAS_CONTAINER_ENGINE}" in
> +docker)
> +	KAS_CONTAINER_COMMAND="docker"
> +	enable_unpriv_userns_docker
> +	if [ "$(docker context show)" = "rootless" ]; then
> +		KAS_DOCKER_ROOTLESS=1
> +	fi
> +	;;
> +podman)
> +	KAS_CONTAINER_COMMAND="podman"
> +	KAS_RUNTIME_ARGS="${KAS_RUNTIME_ARGS} --security-opt label=disable"
> +	;;
> +*)
> +	fatal_error "unknown container engine '${KAS_CONTAINER_ENGINE}'"
> +	;;
> +esac
> +
> +if [ "${BUILD_SYSTEM}" = "isar" ] || [ "${BUILD_SYSTEM}" = "isar-privileged" ]; then
>   	enable_isar_mode
> -elif [ -z "${ISAR_MODE}" ]; then
> +elif [ "${BUILD_SYSTEM}" = "isar-rootless" ]; then
> +	enable_isar_rootless_mode
> +else
>   	enable_oe_mode
>   fi
>   
>   # clean can be executed without config, hence manually forward the build system
> -if [ "${ISAR_MODE}" = "1" ] && echo "${KAS_CMD}" | grep -qe "^clean\|purge"; then
> -	KAS_OPTIONS="${KAS_OPTIONS} --isar"
> -fi
> +case "${BUILD_SYSTEM}" in
> +isar*)
> +	if echo "${KAS_CMD}" | grep -qe "^clean\|purge"; then
> +		KAS_OPTIONS="${KAS_OPTIONS} --${BUILD_SYSTEM}"
> +	fi
> +	;;
> +esac
>   
>   set_container_image_var
>   
> @@ -628,10 +633,21 @@ forward_dir KAS_BUILD_DIR "/build" "rw"
>   forward_dir DL_DIR "/downloads" "rw"
>   forward_dir KAS_REPO_REF_DIR "/repo-ref" "rw"
>   forward_dir SSTATE_DIR "/sstate" "rw"
> +forward_dir BB_HASHSERVE_DB_DIR "/bb-hashserve-db" "rw"
>   forward_dir KAS_BUILDTOOLS_DIR "/buildtools" "rw"
>   
>   if git_com_dir=$(git -C "${KAS_REPO_DIR}" rev-parse --git-common-dir 2>/dev/null) \
>   	&& [ "$git_com_dir" != "$(git -C "${KAS_REPO_DIR}" rev-parse --git-dir)" ]; then
> +
> +	KAS_GIT_OVERLAY_FILE=""
> +	kas_container_cleanup()
> +	{
> +		if [ -f "${KAS_GIT_OVERLAY_FILE}" ]; then
> +			trace rm -f "${KAS_GIT_OVERLAY_FILE}"
> +		fi
> +	}
> +	trap kas_container_cleanup EXIT INT TERM
> +
>   	# If (it's a git repo) and the common dir isn't the git-dir, it is shared worktree and
>   	# we have to mount the common dir in the container to make git work
>   	# The mount path inside the container is different from the host path. Hence, we over-mount
> @@ -685,6 +701,14 @@ if [ -n "${KAS_GIT_CREDENTIAL_STORE}" ] ; then
>   	set -- "$@" -v "$(realpath -e "${KAS_GIT_CREDENTIAL_STORE}")":/var/kas/userdata/.git-credentials:ro
>   fi
>   
> +if [ -n "${KAS_GIT_CREDENTIAL_SOCKET}" ] ; then
> +	if [ ! -S "${KAS_GIT_CREDENTIAL_SOCKET}" ]; then
> +		fatal_error "passed KAS_GIT_CREDENTIAL_SOCKET '${KAS_GIT_CREDENTIAL_SOCKET}' is not a socket"
> +	fi
> +	KAS_GIT_CREDENTIAL_HELPER_DEFAULT="cache --socket=/var/kas/userdata/.git-cache-socket"
> +	set -- "$@" -v "$(realpath -e "${KAS_GIT_CREDENTIAL_SOCKET}")":/var/kas/userdata/.git-cache-socket
> +fi
> +
>   GIT_CREDENTIAL_HELPER="${GIT_CREDENTIAL_HELPER:-${KAS_GIT_CREDENTIAL_HELPER_DEFAULT}}"
>   
>   if [ -n "${GIT_CREDENTIAL_HELPER}" ] ; then
> @@ -731,6 +755,7 @@ fi
>   for var in TERM KAS_DISTRO KAS_MACHINE KAS_TARGET KAS_TASK KAS_CLONE_DEPTH \
>              KAS_PREMIRRORS DISTRO_APT_PREMIRRORS BB_NUMBER_THREADS PARALLEL_MAKE \
>              GIT_CREDENTIAL_USEHTTPPATH \
> +           BB_HASHSERVE BB_HASHSERVE_UPSTREAM \
>              TZ; do
>   	if [ -n "$(eval echo \$${var})" ]; then
>   		set -- "$@" -e "${var}=$(eval echo \"\$${var}\")"
> @@ -739,7 +764,7 @@ done
>   
>   # propagate only supported SHELL settings
>   case "$SHELL" in
> -/bin/sh|/bin/bash|/bin/dash)
> +/bin/sh | /bin/bash | /bin/dash)
>   	set -- "$@" -e "SHELL=$SHELL"
>   	;;
>   *)
> @@ -757,7 +782,7 @@ fi
>   
>   # SC2086: Double quote to prevent globbing and word splitting.
>   # shellcheck disable=2086
> -set -- "$@" ${KAS_ISAR_ARGS} ${KAS_WITH_LOOP_DEV} ${KAS_RUNTIME_ARGS} \
> +set -- "$@" ${KAS_ISAR_ARGS} ${KAS_RUNTIME_ARGS} ${KAS_EXTRA_RUNTIME_ARGS} \
>       ${KAS_CONTAINER_IMAGE} ${KAS_OPTIONS_DIRECT} ${KAS_CMD} ${KAS_OPTIONS}
>   if [ -n "${KAS_BITBAKE_C_OPTION_ARGS}" ]; then
>   	set -- "$@" -c "${KAS_BITBAKE_C_OPTION_ARGS}"
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#23733): https://lists.cip-project.org/g/cip-dev/message/23733
> Mute This Topic: https://lists.cip-project.org/mt/120423678/1753640
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/unsub [quirin.gylstorff@siemens.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


