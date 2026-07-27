Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FFDAC531D0
	for <webhook@archiver.kernel.org>; Mon, 27 Jul 2026 06:07:41 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.63])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.25085.1785132451540424364
 for <cip-dev@lists.cip-project.org>;
 Sun, 26 Jul 2026 23:07:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=elbeBCgM;
 spf=pass (domain: siemens.com, ip: 40.107.130.63, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CxqdlZy/NBWFgh18LZ+cG9lAAcGkhiG0eFstSXqJ+hMf9trwmRjblv5SOhvQvp+4QUMN87xAtqfQGPBkKMt+lZRvWoHjGg0ZlJgbOzXEAFPLOHopzWmKb21IBhpWZnFkVPMtsZzTRiINiRbIwguWxFu+Sj4rArTUPhyQ24SLhPnKhaO4xVpgpEaG7SJilvE9lMuVxrCTUV6z7Z0/+fPWgrhSfW8Es0g8D4J80JbE1IuKt9wVhUQA964HfeCjyIP/JowC4ywXUMBGfSH/1ZVjAeXmHKjzjJNmW+8aV4lEPo9UQi7p+RQULMs/Ky2MDVFu5AGKYOVRSc/KSWM3QdcCdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dEMSXY7yZKSchGVBuSh0hxyD9X5hU50jTZaB16bGjyQ=;
 b=n5OYxAoxtJ7DeRDrTI2LKsJkdMLQCX2Q5TZJZ6ioPebeDGP73vatQXCxgrkwEUCjb+l49+onJ8C3WZ9boqgMGCQ7EK7Ni8tgkHoEnhf7rzkGGlwB9WY3+fCpqNTifFfq+HLCS2MBnYczmfxDlvDbxIu9uO0mhe97UQtvNE8nO0w84TnxyTFucGKn/BrjJQqJUlO4wx5uF7FGvUAs258d/0Qdoa0fpZNMCZQqjw7+Pb7+P7XpdoJE9kT/IPSzB8nELjHUNusHI4CRuWv8xr1fmydNOoG2bYtwL0/gbcigD0s89YVQiQw2uDF2ExXhOkOHDdrPvix7XdSp8C/LogUxpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEMSXY7yZKSchGVBuSh0hxyD9X5hU50jTZaB16bGjyQ=;
 b=elbeBCgMJv8/FGmECAQCNG7ujOnfKCNWBdbUMR5LwcNYmn9hu4ht/RszOpMQQpGQ34gII/DrivMd1R2umy4nfVC2+op/lvJD01xO2S9sxLW64sKTi21VLJhvtC4yFg2LkasE2Psvhw4WldmF7UmhTvLSwqVM93+AgT7oX1Ru/prb8nOGMaFQTD6NUP4/h1Gab7mkl6zoPgmYnwfuYW2Hu99nrCTZ81uccV2k1yuPASyhHIAscf+a9amrrcGczOQtCJjPK5spITWwJaZVPCjRH2T7Rk2EauO1s+88lkEkxzmw6RbuNwGOhQklfM5vqsRjrmVF0fzoO3wEZ/8qzMnLcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3554.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:15f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 06:07:26 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 06:07:25 +0000
Message-ID: <ccbb8f6a-216a-4546-ae7a-8ac13a785d2e@siemens.com>
Date: Mon, 27 Jul 2026 08:07:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC cip-dev][isar-cip-core][PATCH 1/4] update to kas 5.4
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com
References: <20260724105116.3575045-1-Quirin.Gylstorff@siemens.com>
 <20260724105116.3575045-2-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260724105116.3575045-2-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3554:EE_
X-MS-Office365-Filtering-Correlation-Id: 52055a27-63f6-42b9-7df9-08deeba554a5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|4143699003|11063799006|56012099006|10067099003|6133799003|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	kb8ITAOGjZxT+spce5EgC9vUJu/uBe34HL5QeorbOiB7PmiNEZhb3k6Hjj6QQ6WyXBlZkOulzygPsVBURMhq+imyPBcTU4s+MIDZRulL4MX/l/GEJ6fM3w3RuvDY7v0QCq7YTsOp4qKLSSmlG1EgZzC4DFlxbUqlMvm8/V3r04V7gAvgjqMy0ZWxHqkZ6l8XaSn1mR8XE1RE8ZJWRACyVbd/0NS5H2yJXJzCfpSFLJUPBvIjWvryBSNbaBHD+dBtLsGGZBP3QzbhKrkP4QvR/EVsdVYjA3jUpofwZaIpn0wEgmLejCk+uvtItyYubHO8P8Uytm1Et8RPXa1nFxhVBPV7lH8VK98+tMs3x6mISh1JiLiIVSgLZtY11IgiJXaWbSLUAr13VsuEOurO1QQpeB/dI4Gkbd8DyCXtQul7hIgFDK5BTYuIGmCVHwJ17/eiX5PZEHtz8de7cx91mUBYJymqg4iSTkdxpCQvytb2JZH4RyG84wip2arhzO+7jaBmCDumpOMpdXhRA1CIWnniFAsrZ7sL85WkKqLFt0/6G9lNQQf1AIklGl9nfjWNIWYqUgaXwZV6ya49x1GF+ecwMi51dCY2aOgylsCcjYbaermo5h8bIZURXCFx1I5AQ7k3
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(4143699003)(11063799006)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bE11dmRYRlFiZGNzNXk1N1FRVGxaeGZrSFZORTVpTC9nbG53ZDc2RjQ0NTEy?=
 =?utf-8?B?V1J5UWpKdXljdUJBVE1Ka1dKUDBoNWxCMEl4QjBSWlA5V1c1ZzluMDU3RXk3?=
 =?utf-8?B?cDNsS0NqbDV4RkhKazlYSFdabkRnblB5TzdNSkRuRlZVaTBUTkdRYndUUVBi?=
 =?utf-8?B?alRhS3hKVzdFNzdNUUtpRmNKaytzSVpNREhpSDZmYmhCOW1GeldPUGZ4bFlP?=
 =?utf-8?B?UXVMYWtMT04wQ2x3WHRjQ2gxVVpDN2pFSkN2Zi9vZEUvUjYzdEk5YjNtSGpn?=
 =?utf-8?B?ZWRtMzJ2MlMvVTEzSUl6UFJvSzJTSnJwczM0b1c5aVU3Q1RIY0FzaGZWZElG?=
 =?utf-8?B?VDJBQnBFbEFPbjRoZGdqa0crY0xwRG9aR1pnak03d2NsdkZzblJ5T1N4YVQ4?=
 =?utf-8?B?THV4V0hwV3lZNTJVektHVjZ2SXEzREJvdldDODZNMUszUEl6a3M1eWR0UFpo?=
 =?utf-8?B?VXJzektUNEhHMFRocE5KNGJqTVdBTk1xTURxS1lLQkZkUlpwOFZaZWNUdC9N?=
 =?utf-8?B?dGovSzlJUjd2L0VxWUlGN3U0d1doL3hBRVBISXhUak9oUGlkUkRQanFVN041?=
 =?utf-8?B?RnRzMzNHcC9jK0FZNWZZMkRjZDRwK3dRSXNRQTQ3blNCRHJnS0FhRWdRR0JZ?=
 =?utf-8?B?ODJFbCs5dlFUMDdVejBzZFFaK2hjTmNNSVlHYnQzZ2R3UUtoT0pCVlk1aStV?=
 =?utf-8?B?ZmZhb1VabUx5S0tmcGc4L3RKVmVCQ3VMV2FSZythanhoT2g0Uk9BUHFjVWpk?=
 =?utf-8?B?d2lWem5oNTd4blJnUVpJRmJVMDkyVWtXUmYzNnFZb1BGYXZoNGllYUpYcDlT?=
 =?utf-8?B?TUZoNXl5K0JvNW9tSWRMQVlFZE5xZzlIOW04TzBxMVE4dW1lT3ZhZmJHMytl?=
 =?utf-8?B?OGR1cVJTbXFmeXlQeHZLSkFMRFh0Z3laRjdIckV1MlFZQnlpUHh2VWUyQ2ZG?=
 =?utf-8?B?eEJiOVBDb1FmbW0vbDZseGtjL0tVZmZOcFlsNlVUWmtsYU82cGlsVlQ4Q3dY?=
 =?utf-8?B?dUdnaFg1YWxOekN4TGp3RzFZTTdXREprdFRqTTdhVUNrc1dtTHRvcXVFNHIw?=
 =?utf-8?B?bmV3eFFlN3V6TkxmRUpJLzVIVEczdnhBZ2liSFN0dkRLc21JcVNEWUQ2Nkpt?=
 =?utf-8?B?SytCY0d2TU0ySTJjWmFaaEpLU0xpMjNXa3A3ajY2TlJpK3VmazJhMk1GUDhE?=
 =?utf-8?B?d08xSXk4cEtWaVpyZE5TZlJZM3loeFRGaDZrMXltWWgxc2ZHN1c1TnJqNUJG?=
 =?utf-8?B?TjZybm1zNFowOStkWWVBL0hteGJHNjNwZTlmcEVXQ0dIUUpqUWQ5SGJaenJr?=
 =?utf-8?B?cGpuWk1ZZ2FQK01iNzlEVzVwVTZDWmhTbk5wVklCS0VSdnpncXJJckl5d2l3?=
 =?utf-8?B?Zml4M0txMGRCa2JPVVJpT09PNGw0SHRJbFFPVDJ5a29vZG1ITlhCOExueHY0?=
 =?utf-8?B?bW15RnNJSXNYMUlYek54YzVZZDUrZjQ2YUQ2bHV3WDBGSjRrTXFaYytNVEVL?=
 =?utf-8?B?YUswMzY4a0huU1FJbU8zNiszTzBqNGV6QTREd0RES2hTU2J2Wm82aGpBejZz?=
 =?utf-8?B?WWZ0YVFNYXJHazZqN0NyREo2a1ZDck5VSUhCSzV2SFdmQi9ndlBBTHBtSjg2?=
 =?utf-8?B?MEQrSGNEelh0S1hzQTVoZzRDZ2s4YVZQck54K1RLOE41amEzRjhSeHkxa2pL?=
 =?utf-8?B?SlhHMnJKSWJFT3pCLzIwMUJjMWtuMnpqcnRiM2NNL3RyOUFRRGQxbUUrdTNZ?=
 =?utf-8?B?eG54OFVoSmZRbWpvUFlnbHRRRFRkUElXNGtEc0dYUUxiNVJOM1RoMlVyOFM0?=
 =?utf-8?B?QmxjR1RiaHNsYzZOWjNyWGZzRmJDSUNySW9MUVEwK2JUcy96aU9peVVoSGZo?=
 =?utf-8?B?MGJFOVBkRW42M0tNam9wWXllWklKVWtWSDhLVkhEYTNXQUJBcTFGSEttN2hu?=
 =?utf-8?B?cUhNYk9ybTJOdHFJWGEweDRRejk5aFdsM20ycXhDakx2SzA1NFNXQllWbEhO?=
 =?utf-8?B?TEpQdy9DQVRpSWcvMGRFMC9sbXc0S3BGUDUxekx6ZUgrU0lpdjF4SUdpN0p5?=
 =?utf-8?B?SFMyMU5LL3NLTngzcGRGbEJ0UEMwd0VOU2Y3WlVmUmY3b3N0cDhPbW5UWnZX?=
 =?utf-8?B?ZVNVdGJJNVFXUUhoOG9EM3lqejBsZ1ZQZk96OXlaTVhoS3pUbDA2bW1GMzhz?=
 =?utf-8?B?cXNEVjFtRUthNVBHdTVrTUc1TUpkeWdic3NnOGZZWXU5Y0lEZlNwbWxWRzRW?=
 =?utf-8?B?RmZyNEJ4TUUwaHhMTFF6dDdPOTNsaWxYWlpjRGV4ZVBXanVFMWJEWHBzeGhq?=
 =?utf-8?B?b2NCdlJPZm1oRk5SZHB6VWs3cDFFb2lTZ3R1eDl3U1FNaUtvMTZidz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52055a27-63f6-42b9-7df9-08deeba554a5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 06:07:25.7901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C7hI3InwasPfBQZd8oflVCj+4D7OM0ZQTHMyW2mCjLIbG8OCm1m0kh1PQW5J6UWFR4qEJg3SQdVMsLJmjxIk/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3554
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Jul 2026 06:07:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23750

On 24.07.26 12:51, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .gitlab-ci.yml |   2 +-
>  kas-cip.yml    |   2 +-
>  kas-container  | 311 ++++++++++++++++++++++++++-----------------------
>  3 files changed, 170 insertions(+), 145 deletions(-)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index b53def4..1e61cb0 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -33,7 +33,7 @@ stages:
>    - cve-check
>  
>  default:
> -  image: ghcr.io/siemens/kas/kas-isar:5.2
> +  image: ghcr.io/siemens/kas/kas-isar:5.4
>    before_script:
>      - export http_proxy=$HTTP_PROXY
>      - export https_proxy=$HTTPS_PROXY
> diff --git a/kas-cip.yml b/kas-cip.yml
> index 23bbba4..6badc7d 100644
> --- a/kas-cip.yml
> +++ b/kas-cip.yml
> @@ -15,7 +15,7 @@ header:
>  distro: cip-core-trixie
>  target: cip-core-image
>  
> -build_system: isar
> +build_system: isar-privileged
>  
>  repos:
>    cip-core:
> diff --git a/kas-container b/kas-container
> index 993f0bb..55bdcfc 100755
> --- a/kas-container
> +++ b/kas-container
> @@ -27,7 +27,7 @@
>  
>  set -e
>  
> -KAS_CONTAINER_SCRIPT_VERSION="5.2"
> +KAS_CONTAINER_SCRIPT_VERSION="5.4"
>  KAS_IMAGE_VERSION_DEFAULT="${KAS_CONTAINER_SCRIPT_VERSION}"
>  KAS_CONTAINER_IMAGE_DISTRO_DEFAULT=""
>  KAS_CONTAINER_IMAGE_PATH_DEFAULT="ghcr.io/siemens/kas"
> @@ -49,9 +49,10 @@ usage()
>  	printf "%b" "\nPositional arguments:\n"
>  	printf "%b" "build\t\t\tCheck out repositories and build target.\n"
>  	printf "%b" "checkout\t\tCheck out repositories but do not build.\n"
> +	printf "%b" "diff\t\t\tCompare two kas configurations.\n"
>  	printf "%b" "dump\t\t\tCheck out repositories and write flat version\n"
>  	printf "%b" "    \t\t\tof config to stdout.\n"
> -	printf "%b" "lock\t\t\tCreate and update kas project lockfiles\n"
> +	printf "%b" "lock\t\t\tCreate and update kas project lockfiles.\n"
>  	printf "%b" "shell\t\t\tRun a shell in the build environment.\n"
>  	printf "%b" "for-all-repos\t\tRun specified command in each repository.\n"
>  	printf "%b" "clean\t\t\tClean build artifacts, keep sstate cache and " \
> @@ -61,20 +62,19 @@ usage()
>  	printf "%b" "cleanall\t\tClean build artifacts, sstate cache and " \
>  		    "downloads.\n"
>  	printf "%b" "purge\t\t\tRemove all data managed by kas. Run with '--dry-run'\n"
> -	printf "%b" "     \t\t\tto check what would be removed\n"
> +	printf "%b" "     \t\t\tto check what would be removed.\n"
>  	printf "%b" "menu\t\t\tProvide configuration menu and trigger " \
>  		    "configured build.\n"
>  	printf "%b" "\nOptional arguments:\n"
> -	printf "%b" "--isar\t\t\tUse kas-isar container to build Isar image. To force\n"
> -	printf "%b" "      \t\t\tthe use of run0 over sudo, set KAS_SUDO_CMD=run0.\n"
> -	printf "%b" "--with-loop-dev		Pass a loop device to the " \
> -		    "container. Only required if\n"
> -	printf "%b" "\t\t\tloop-mounting is used by recipes.\n"
> +	printf "%b" "--isar-privileged\tRun an Isar build in privileged mode. " \
> +	            "To force the use\n"
> +	printf "%b" "\t\t\tof run0 over sudo, set KAS_SUDO_CMD=run0.\n"
> +	printf "%b" "--isar-rootless\t\tRun an Isar build in rootless mode.\n"
>  	printf "%b" "--runtime-args\t\tAdditional arguments to pass to the " \
> -			"container runtime\n"
> +			"container runtime.\n"
>  	printf "%b" "\t\t\tfor running the build.\n"
>  	printf "%b" "-l, --log-level\t\tSet log level (default=info).\n"
> -	printf "%b" "--version\t\tprint program version.\n"
> +	printf "%b" "--version\t\tPrint program version.\n"
>  	printf "%b" "--ssh-dir\t\tDirectory containing SSH configurations.\n"
>  	printf "%b" "\t\t\tAvoid \$HOME/.ssh unless you fully trust the " \
>  		    "container.\n"
> @@ -83,13 +83,15 @@ usage()
>  	printf "%b" "\t\t\tAvoid \$HOME/.aws unless you fully trust the " \
>  		    "container.\n"
>  	printf "%b" "--git-credential-store\tFile path to the git credential " \
> -		    "store\n"
> +		    "store.\n"
> +	printf "%b" "--git-credential-socket\tPath to the git credential cache " \
> +	       "socket.\n"
>  	printf "%b" "--no-proxy-from-env\tDo not inherit proxy settings from " \
>  		    "environment.\n"
>  	printf "%b" "--repo-ro\t\tMount current repository read-only\n" \
> -		    "\t\t\t(default for build command)\n"
> +		    "\t\t\t(default for build command).\n"
>  	printf "%b" "--repo-rw\t\tMount current repository writable\n" \
> -		    "\t\t\t(default for shell command)\n"
> +		    "\t\t\t(default for shell command).\n"
>  	printf "%b" "-h, --help\t\tShow this help message and exit.\n"
>  	printf "%b" "\n"
>  	printf "%b" "You can force the use of podman over docker using " \
> @@ -143,11 +145,6 @@ prepare_sudo_cmd()
>  
>  enable_isar_mode()
>  {
> -	if [ -n "${ISAR_MODE}" ]; then
> -		return
> -	fi
> -	ISAR_MODE=1
> -
>  	KAS_CONTAINER_IMAGE_NAME_DEFAULT="kas-isar"
>  	KAS_ISAR_ARGS="--privileged"
>  
> @@ -159,14 +156,38 @@ enable_isar_mode()
>  		export PATH="${PATH}:/usr/sbin"
>  	elif [ "${KAS_DOCKER_ROOTLESS}" = "1" ]; then
>  		prepare_sudo_cmd
> -		export DOCKER_HOST="${DOCKER_HOST:-unix:///var/run/docker.sock}"
> -		debug "kas-isar does not support rootless docker. Using system docker"
> +		DOCKER_HOST_DEFAULT="$(docker context inspect default --format '{{.Endpoints.docker.Host}}')"
> +		export DOCKER_HOST="${DOCKER_HOST:-$DOCKER_HOST_DEFAULT}"
> +		debug "kas-isar does not support rootless docker. Using system docker in $DOCKER_HOST"
>  		# force use of well-known system docker socket
>  		KAS_CONTAINER_COMMAND="${_KAS_SUDO_CMD} ${KAS_CONTAINER_COMMAND}"
>  		KAS_DOCKER_ROOTLESS=0
>  	fi
>  }
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
>  enable_oe_mode()
>  {
>  	if [ "${KAS_CONTAINER_ENGINE}" = "podman" ]; then
> @@ -174,6 +195,7 @@ enable_oe_mode()
>  		# calling "podman run" has a 1:1 mapping
>  		KAS_RUNTIME_ARGS="${KAS_RUNTIME_ARGS} --userns=keep-id"
>  	fi
> +	BUILD_SYSTEM="openembedded"
>  }
>  
>  enable_unpriv_userns_docker()
> @@ -210,6 +232,20 @@ check_and_expand()
>  	realpath -e "$_varval"
>  }
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
>  # Params: FILE
>  # Returns: root repo dir of file
>  repo_path_of_file()
> @@ -260,14 +296,6 @@ forward_dir()
>  	fi
>  }
>  
> -check_docker_rootless()
> -{
> -	KAS_DOCKER_ROOTLESS=0
> -	if [ "$(docker context show)" = "rootless" ]; then
> -		KAS_DOCKER_ROOTLESS=1
> -	fi
> -}
> -
>  enable_docker_rootless()
>  {
>  	warning "Rootless docker used, only limited functionality available."
> @@ -281,122 +309,48 @@ enable_docker_rootless()
>  	KAS_RUNTIME_ARGS="${KAS_RUNTIME_ARGS} -e KAS_DOCKER_ROOTLESS=1"
>  }
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
>  set_container_image_var()
>  {
> +	# if the image is explicitly set, use that
> +	if [ -n "${KAS_CONTAINER_IMAGE}" ]; then
> +		return
> +	fi
>  	KAS_IMAGE_VERSION="${KAS_IMAGE_VERSION:-${KAS_IMAGE_VERSION_DEFAULT}}"
>  	KAS_CONTAINER_IMAGE_DISTRO="${KAS_CONTAINER_IMAGE_DISTRO:-${KAS_CONTAINER_IMAGE_DISTRO_DEFAULT}}"
>  	KAS_CONTAINER_IMAGE_NAME="${KAS_CONTAINER_IMAGE_NAME:-${KAS_CONTAINER_IMAGE_NAME_DEFAULT}}"
>  	KAS_CONTAINER_IMAGE_PATH="${KAS_CONTAINER_IMAGE_PATH:-${KAS_CONTAINER_IMAGE_PATH_DEFAULT}}"
> -	KAS_CONTAINER_IMAGE_DEFAULT="${KAS_CONTAINER_IMAGE_PATH}/${KAS_CONTAINER_IMAGE_NAME}:${KAS_IMAGE_VERSION}"
> -	KAS_CONTAINER_IMAGE="${KAS_CONTAINER_IMAGE:-${KAS_CONTAINER_IMAGE_DEFAULT}}"
> +	KAS_CONTAINER_IMAGE="${KAS_CONTAINER_IMAGE_PATH}/${KAS_CONTAINER_IMAGE_NAME}:${KAS_IMAGE_VERSION}"
>  	if [ -n "${KAS_CONTAINER_IMAGE_DISTRO}" ]; then
>  		KAS_CONTAINER_IMAGE="${KAS_CONTAINER_IMAGE}-${KAS_CONTAINER_IMAGE_DISTRO}"
>  	fi
>  }
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
>  while [ $# -gt 0 ]; do
>  	case "$1" in
> -	--isar)
> -		enable_isar_mode
> +	--isar | --isar-privileged)
> +		if [ "$1" = "--isar" ]; then
> +			warning "The semantic of '--isar' might change in the" \
> +				"future. Please use '--isar-privileged' instead."
> +		fi
> +		BUILD_SYSTEM="isar-privileged"
>  		shift 1
>  		;;
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
>  		shift 1
>  		;;
> -	--runtime-args|--docker-args)
> -		[ $# -gt 0 ] || usage
> -		KAS_RUNTIME_ARGS="${KAS_RUNTIME_ARGS} $2"
> +	--runtime-args | --docker-args)
> +		[ $# -gt 1 ] || usage
> +		KAS_EXTRA_RUNTIME_ARGS="${KAS_EXTRA_RUNTIME_ARGS} $2"
>  		shift 2
>  		;;
>  	--ssh-dir)
> -		[ $# -gt 2 ] || usage
> +		[ $# -gt 1 ] || usage
>  		KAS_SSH_DIR="$2"
>  		shift 2
>  		;;
> @@ -408,15 +362,22 @@ while [ $# -gt 0 ]; do
>  		shift 1
>  		;;
>  	--aws-dir)
> -		[ $# -gt 2 ] || usage
> +		[ $# -gt 1 ] || usage
>  		KAS_AWS_DIR="$2"
>  		shift 2
>  		;;
>  	--git-credential-store)
> -		[ $# -gt 2 ] || usage
> +		[ $# -gt 1 ] || usage
>  		KAS_GIT_CREDENTIAL_STORE="$2"
>  		shift 2
>  		;;
> +
> +	--git-credential-socket)
> +		[ $# -gt 1 ] || usage
> +		KAS_GIT_CREDENTIAL_SOCKET="$2"
> +		shift 2
> +		;;
> +
>  	--no-proxy-from-env)
>  		KAS_NO_PROXY_FROM_ENV=1
>  		shift 1
> @@ -446,19 +407,19 @@ while [ $# -gt 0 ]; do
>  	--*)
>  		usage
>  		;;
> -	clean|cleansstate|cleanall|purge)
> +	clean | cleansstate | cleanall | purge)
>  		KAS_REPO_MOUNT_OPT_DEFAULT="ro"
>  		KAS_CMD=$1
>  		shift 1
>  		break
>  		;;
> -	shell|lock)
> +	shell | lock)
>  		KAS_REPO_MOUNT_OPT_DEFAULT="rw"
>  		KAS_CMD=$1
>  		shift 1
>  		break
>  		;;
> -	build|checkout|for-all-repos|menu)
> +	build | checkout | for-all-repos | menu)
>  		KAS_REPO_MOUNT_OPT_DEFAULT="ro"
>  		KAS_CMD=$1
>  		shift 1
> @@ -486,6 +447,10 @@ while [ $# -gt 0 ]; do
>  	esac
>  done
>  
> +KAS_RUNTIME_ARGS="--log-driver=none --user=root"
> +
> +setup_kas_dirs
> +
>  [ -n "${KAS_CMD}" ] || usage
>  
>  KAS_EXTRA_BITBAKE_ARGS=0
> @@ -494,17 +459,17 @@ KAS_FILES=
>  # parse kas sub-command options
>  while [ $# -gt 0 ] && [ $KAS_EXTRA_BITBAKE_ARGS -eq 0 ]; do
>  	case "$1" in
> -	--format|--indent|--provenance|--skip|--target|--task)
> +	--format | --indent | --provenance | --skip | --target | --task)
>  		KAS_OPTIONS="${KAS_OPTIONS} $1 $2"
>  		shift 1
>  		shift 1 || KAS_OPTIONS="--help"
>  		;;
> -	-c|--cmd|--command)
> +	-c | --cmd | --command)
>  		KAS_BITBAKE_C_OPTION_ARGS="$2"
>  		shift 1
>  		shift 1 || KAS_OPTIONS="--help"
>  		;;
> -	-E|--preserve-env)
> +	-E | --preserve-env)
>  		fatal_error "$1 is not supported with ${KAS_CONTAINER_SELF_NAME}"
>  		;;
>  	--)
> @@ -563,10 +528,10 @@ if [ "${KAS_CMD}" = "menu" ]; then
>  	if [ "$(echo "${KAS_FIRST_FILES}" | wc -w)" -ne "1" ]; then
>  		fatal_error "menu plugin only supports a single Kconfig file"
>  	fi
> -	BUILD_SYSTEM=$(tr '\n' '\f' 2>/dev/null < "${KAS_FIRST_FILES}" | \
> +	BUILD_SYSTEM=${BUILD_SYSTEM:-$(tr '\n' '\f' 2>/dev/null < "${KAS_FIRST_FILES}" |
>  		sed -e 's/\(.*\fconfig KAS_BUILD_SYSTEM\f\(.*\)\|.*\)/\2/' \
>  		    -e 's/\f\([[:alpha:]].*\|$\)//' \
> -		    -e 's/.*default \"\(.*\)\".*/\1/')
> +		    -e 's/.*default \"\(.*\)\".*/\1/')}
>  else
>  	if [ -z "${KAS_FIRST_FILES}" ]; then
>  		KAS_FIRST_FILES="${KAS_WORK_DIR}/.config.yaml"
> @@ -574,20 +539,60 @@ else
>  
>  	# We only get the first build system and let kas check if mixed
>  	_KAS_FIRST_FILE=$(echo "${KAS_FIRST_FILES}" | awk '{print $1}')
> -	BUILD_SYSTEM=$(grep -e "^build_system: " "${_KAS_FIRST_FILE}" 2>/dev/null | \
> -		sed 's/build_system:[ ]\+//')
> +	BUILD_SYSTEM=${BUILD_SYSTEM:-$(grep -e "^build_system: " "${_KAS_FIRST_FILE}" 2>/dev/null |
> +		sed 's/build_system:[ ]\+//')}
>  fi
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
>  	enable_isar_mode
> -elif [ -z "${ISAR_MODE}" ]; then
> +elif [ "${BUILD_SYSTEM}" = "isar-rootless" ]; then
> +	enable_isar_rootless_mode
> +else
>  	enable_oe_mode
>  fi
>  
>  # clean can be executed without config, hence manually forward the build system
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
>  set_container_image_var
>  
> @@ -628,10 +633,21 @@ forward_dir KAS_BUILD_DIR "/build" "rw"
>  forward_dir DL_DIR "/downloads" "rw"
>  forward_dir KAS_REPO_REF_DIR "/repo-ref" "rw"
>  forward_dir SSTATE_DIR "/sstate" "rw"
> +forward_dir BB_HASHSERVE_DB_DIR "/bb-hashserve-db" "rw"
>  forward_dir KAS_BUILDTOOLS_DIR "/buildtools" "rw"
>  
>  if git_com_dir=$(git -C "${KAS_REPO_DIR}" rev-parse --git-common-dir 2>/dev/null) \
>  	&& [ "$git_com_dir" != "$(git -C "${KAS_REPO_DIR}" rev-parse --git-dir)" ]; then
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
>  	# If (it's a git repo) and the common dir isn't the git-dir, it is shared worktree and
>  	# we have to mount the common dir in the container to make git work
>  	# The mount path inside the container is different from the host path. Hence, we over-mount
> @@ -685,6 +701,14 @@ if [ -n "${KAS_GIT_CREDENTIAL_STORE}" ] ; then
>  	set -- "$@" -v "$(realpath -e "${KAS_GIT_CREDENTIAL_STORE}")":/var/kas/userdata/.git-credentials:ro
>  fi
>  
> +if [ -n "${KAS_GIT_CREDENTIAL_SOCKET}" ] ; then
> +	if [ ! -S "${KAS_GIT_CREDENTIAL_SOCKET}" ]; then
> +		fatal_error "passed KAS_GIT_CREDENTIAL_SOCKET '${KAS_GIT_CREDENTIAL_SOCKET}' is not a socket"
> +	fi
> +	KAS_GIT_CREDENTIAL_HELPER_DEFAULT="cache --socket=/var/kas/userdata/.git-cache-socket"
> +	set -- "$@" -v "$(realpath -e "${KAS_GIT_CREDENTIAL_SOCKET}")":/var/kas/userdata/.git-cache-socket
> +fi
> +
>  GIT_CREDENTIAL_HELPER="${GIT_CREDENTIAL_HELPER:-${KAS_GIT_CREDENTIAL_HELPER_DEFAULT}}"
>  
>  if [ -n "${GIT_CREDENTIAL_HELPER}" ] ; then
> @@ -731,6 +755,7 @@ fi
>  for var in TERM KAS_DISTRO KAS_MACHINE KAS_TARGET KAS_TASK KAS_CLONE_DEPTH \
>             KAS_PREMIRRORS DISTRO_APT_PREMIRRORS BB_NUMBER_THREADS PARALLEL_MAKE \
>             GIT_CREDENTIAL_USEHTTPPATH \
> +           BB_HASHSERVE BB_HASHSERVE_UPSTREAM \
>             TZ; do
>  	if [ -n "$(eval echo \$${var})" ]; then
>  		set -- "$@" -e "${var}=$(eval echo \"\$${var}\")"
> @@ -739,7 +764,7 @@ done
>  
>  # propagate only supported SHELL settings
>  case "$SHELL" in
> -/bin/sh|/bin/bash|/bin/dash)
> +/bin/sh | /bin/bash | /bin/dash)
>  	set -- "$@" -e "SHELL=$SHELL"
>  	;;
>  *)
> @@ -757,7 +782,7 @@ fi
>  
>  # SC2086: Double quote to prevent globbing and word splitting.
>  # shellcheck disable=2086
> -set -- "$@" ${KAS_ISAR_ARGS} ${KAS_WITH_LOOP_DEV} ${KAS_RUNTIME_ARGS} \
> +set -- "$@" ${KAS_ISAR_ARGS} ${KAS_RUNTIME_ARGS} ${KAS_EXTRA_RUNTIME_ARGS} \
>      ${KAS_CONTAINER_IMAGE} ${KAS_OPTIONS_DIRECT} ${KAS_CMD} ${KAS_OPTIONS}
>  if [ -n "${KAS_BITBAKE_C_OPTION_ARGS}" ]; then
>  	set -- "$@" -c "${KAS_BITBAKE_C_OPTION_ARGS}"

This is not kas-container from the 5.4 release.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

