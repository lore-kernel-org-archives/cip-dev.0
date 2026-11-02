Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.19])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9813.1793615556842004310
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Nov 2026 02:32:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=zlDPUwjd;
 spf=pass (domain: siemens.com, ip: 52.101.70.19, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dpsI/t4T+7CY5iLmJxK/Dslz4rzF1PGVzhAx95Gbkou3r/eGZWEuC6Oro+X+i/tmktTGkh8egeNp0H7bh5j9vXt/C2WuiAjhkVIcd46dQSr9tr443fQai9JB7A8OeEaHQ2UZe+a5gBcs3mq+vzDtDHlJaISr+1WAMYMfjB8KKAxcoJXv7k9DL0N4m1QmDR2LVYj92HHyP6oejsR4Fdj8+c/IFo8hqyR58OaNomCqKrUz4LjVITMCcIGGx/GUEWAtRKiwnfrpdceDtu0WbI4/D9d6AUuiP6nIuV1io3aIIttiDyaluVEArjFgxoFDCxBlubincDwBdI2n5Cgm8x58aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8rDS8Q11RCJmE6LVQjhmTszZNqRfHOKhKL9g24FeMwo=;
 b=B+UEsuJqGLK19L0G+BlCbz9itp38Jzaofc4dWSzeStyrADXwJC1KxAefOddU+wyHbQf86fHXddF/1hiT6rCtlyFte4FQQIBgrB/J+mZJdsipTCabsdRa5pV9YkTMpN+CkY2FH7sGZPc5DmqA8cq13aB2aBfQ+bVBXN2nnDlIjIolHXrP8wp8kfv6zEVgVsVcYFazCpAZfQEA5m8+xRiNc94cIcRzcgu0v1Gp40xqSxJ67HoYyR2+JBoUzVt45Dj9HyXDkOAxV5b/oJrgQdD8kH4YTwWrPwp4x5tHT9WgFp0eZXIDi9IyUkBC1gOux/j42Y1u5bePZ6cR+gPvApWUZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8rDS8Q11RCJmE6LVQjhmTszZNqRfHOKhKL9g24FeMwo=;
 b=zlDPUwjdYlFkFtTe0mr+yt7fHw5czcvnLygqLlyQTKJlzCV7P3QQvtidUKvV4BUB3+TtjeK6ayT3xbzL1l2w4pyVKtP4w8f7EYZ8ty5b/J8eCKuVC4MkeX3MxPMgqB/C5b4VbmR3wUpTWIJWgu2VSM8dHmUVzkSvvrDztXyQIRkwcw2M3kgEwdrDRs7cYH0UmEIYoKm85iF7h2MiVm1ILcnddeh/rbUNLGK+80bJvNVSK94AeituZoZcLLJGe0kuHoubl8TUqNBH0OSNBR0jJYNJ+omWjuiFOylGiRqPI0r4F4i8BaFDEQsSlFX+fzzUWWJW48GY0n9BH+TX0YMdsg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by AS2PR10MB6640.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:55f::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Mon, 2 Nov 2026
 10:32:32 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0592.007; Mon, 2 Nov 2026
 10:32:32 +0000
Message-ID: <db01b604-c5dc-45bd-859c-8e36731015ac@siemens.com>
Date: Mon, 2 Nov 2026 11:32:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2 1/4] sign-swu-cms: Refactor signing
 script to be reusable for out of build signing.
To: alexander.heinisch@siemens.com, cip-dev@lists.cip-project.org
References: <20261030115543.111644-1-alexander.heinisch@siemens.com>
 <20261030115543.111644-2-alexander.heinisch@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20261030115543.111644-2-alexander.heinisch@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0043.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::8) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|AS2PR10MB6640:EE_
X-MS-Office365-Filtering-Correlation-Id: 27962f83-a6fb-4bab-0814-08df38cc9a41
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|6133799003|55112099003|18002099003|22082099003|10067099003|56012099006|3023799007|261009223027099003|11063799006|261022105027099003|261021121427099003|261021123027099003|261022075727099003|4143699003|261028144727099003|261026121527099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: ilfr6kG+PDKKOuFTtzh6cqdjjui0GHkwk97BjvKIptE1jlsmbFvPDRNwGGN43uuuJlIXL3PBYmqwQT1+OCvfr6AJFOI7FLO2lPpXVY9ReoO4T6iwI+1pQVc0SqbhE9vof5Q1s0N5+qYUL6kMLwVPymDSsuncdoobsRchiAZsgaf+a0d4Pd9je/RYXMTLPSx44uXtBK1bF4d9Pgx59ZPBLLsPScSxYSJL7b4lDCaS6rnpl9xBen8+Q640Z5GR4T8yHVWfT/vsusJm8IF1iiU/DG/UHbifbBraoLRtbj3j0jSHUt3DXKCTC5Ow/6S0Go/6MuExwNTjzAfTAqxSVHK5aGuyf3aiWXhafzMImiJvbvhklrJ1/LCZL8679LZZw+XPxnKxiYuuZ+GkAK/CMBI3pzevBkIlzq2PhRahr4xwPbCe7N2UoEtK9EU+pgFWmgaCao3QrNFnmgkgNJvq9ouiM+aDO7tu8AR8I3W0mP4j1PrPHRvt6vjMECw3GzD7w7nL+DzkQJ4gU1PN26XkzEKOSfxUpBRGqQpg86J/+gg5TjsXFIxwLx3thSPLLwAuePHPo/ADX/jbgMlWEzH2z+EV+DBLIJYkgWnLHD++ENIUwaCCxBZawKk3GTWEZk0T438j6LHtOSIpicGOT1AywxSnoUEunQ/iLN8Qyp4W0YSnDQw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(6133799003)(55112099003)(18002099003)(22082099003)(10067099003)(56012099006)(3023799007)(261009223027099003)(11063799006)(261022105027099003)(261021121427099003)(261021123027099003)(261022075727099003)(4143699003)(261028144727099003)(261026121527099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sytvd1Z6NGZKRTRQTUlIL1JTRzJpYW9IM1JqVysweXpPbHBzVCtpZFpmL1pS?=
 =?utf-8?B?WGluUVhzZFdWQ1JLMlhhUXVveHVFRElBVFRZOG9KamwwQzFTUW1HaHI4WEpp?=
 =?utf-8?B?c1BJV0RYWmlUQXBwZGRMWHU2SDREMWNvOUpvdE5qSjllU2lDNWVlekVScExU?=
 =?utf-8?B?NmtwRnAzTmFQU3Y5aHd0ZjJ0V3RVQndTWnp3Z3RqeS9MN2ZvZ0wwUEVXMENH?=
 =?utf-8?B?OFZaQWZhdmZBTTRVUXRzSjFpTmVpREcyNkJUdzdkeksxRG9OQVhManc1eVpK?=
 =?utf-8?B?Q2paNWlRTjlWVzlFUW9iK1Qva3BseWM4UFFSS2JWeDZhS3RCZG1aeU83cWh1?=
 =?utf-8?B?S0NWREZHRlQ3UWdMNTRQS1UvbVlTYzBjZUYxcjBKWStka2QzMlgrWWNUR2hk?=
 =?utf-8?B?WXBUWFZyYmhIWXBuUWZPU21TWlNRLzRDZFcxNUJnRmNpSXVVTXpkU3J3RDZQ?=
 =?utf-8?B?TGJIRGdZbFBCbDVrTzBDdTZGem1OR1g1Ykd4YXR1VVVWNTc4cWJQd3Avaktr?=
 =?utf-8?B?eHRaY0prWWQweHFjNFhJL2RZeXQrMW9EL3RrNGNZdGtYUjl3S0s5NkxSUi9Z?=
 =?utf-8?B?RTFMZVRJYVAwZXpmdmpYNFB1RmYyeGpwdWR0ZEpvSzdOa3Y2djg5TzkybE1X?=
 =?utf-8?B?SG5ORFNkazcwZlRFOUZ5ODdNWUZPTllZZDZJTUJlcHhCSTZjVkRLbitGRWh2?=
 =?utf-8?B?NXI2aGFmaTdpb1Y4TWlISi9VR0Z5enRId1RBMjVaa1hyV3N6WTZMTG91Qno4?=
 =?utf-8?B?MWJqQVVtQjc2MU4yQ1p5OUxLdEYzYzVzTXkrazBqWHlqZDJ2Uk1NZTdtOXU4?=
 =?utf-8?B?ckhxZnFySjhScW5RM1hsL2s2QWZhRDhKWWhPTkxrZ09ZajFJYUJ4S0VnbXI1?=
 =?utf-8?B?cDZxQ2pHUnNoQ3g1TnkwTGV0OUJhWTF3am1wRytHZ2UzczM0SUx5ZDdpSzFW?=
 =?utf-8?B?Vm5vYzdQN2NuQ0FRU2V2dmdNYk0xSWFBRnFUbVdOeVpwSVNiWHNtWjVucUN6?=
 =?utf-8?B?Z1NnbkJ4S0FQRC9rbmJZZjRvNkptbnYyc3VZREZKUHZCY2lnSkhKTUlEcXVp?=
 =?utf-8?B?YWNLS01QbW1QNVJjWVJCUklKeUpoWG5LV1FWdWxQNUh0S3JzMHBlQ1diMmhD?=
 =?utf-8?B?ajNxeEYycGpNWkhMVXlPVnorQUJTdzd0dGlYMFhUR1dNb3N5VlZzTmUrb1lB?=
 =?utf-8?B?bTFLcjlmYVptVjNZcURLMUZiOEtWUnZMUEQ1QXlxNzY1NVRHVXBqMGZ4d3dl?=
 =?utf-8?B?ZmVoNGIvVjdlSFNxV2pZYkZRaHJPS0Zyb1NVenJ1dGpMekE4amN3dTd6bTFk?=
 =?utf-8?B?MlpqeGtXNGlZK2tRdkZnb3d5d01UL0JmUjhNM3BmYnk5Y1NrM1pxQjNCMlVl?=
 =?utf-8?B?M1BWRXBOdXkzdjR6c2prSlVlV0ZJOE5Kc0R5UlZrS2NnMTk0ZmFEemlCMVFh?=
 =?utf-8?B?K0xvQmluOTFJK0F0Z1JOc0NPYkRuV1RvWVVKZE5JajlieWVlc1QzMUtZTFJn?=
 =?utf-8?B?Qlh2ZURTZ0c1SEJ1aC9YYjRDWEc5aWRsNXlRRTY3azRCWFBESDZIaW5qbWdu?=
 =?utf-8?B?QVBVR1BkZVdXaFVWbitFdzEvYktzM3VleWZpcXlFeWs2b2tYMjh1WHR5eWR5?=
 =?utf-8?B?UERxTk1PVi9jeGpQSDVUdFBndGY5dmIrQ3VkTGZSdXo5bUFObjhYNHF3dGlY?=
 =?utf-8?B?SmRGQkVYTFI1KzJQTkV1cWRWRVZzbXlnOFRVM09jL1FxUEwvMHlDMG9EaERM?=
 =?utf-8?B?L0d3dVVOOTZtdTAyYjZLNmNmUEVNWDA2Tjl3RGh4dFhpZzl3YUp3WUZvdFJX?=
 =?utf-8?B?VzgyL2pVZ3p0bHdIcnhuU0JLTDlvRDlHdjNtTkRFRlhzMkQ5alZ1djZ3dzBW?=
 =?utf-8?B?aUFvSlJRS3pDU0tDc2FwVlJqUUdQb1h4Ymg3d2Z2QUtzbmRRb0ZyTGdDbmlU?=
 =?utf-8?B?dWRySVJVemMwOWFLa0xRZVp6ejU4clZEUXJ1dW1MRVJ4czZVNkpuMEFDeitz?=
 =?utf-8?B?MEo3cmhCS0FJNTU5Y01PZEZYbFprNG5SZmw2Z0pDRDJzMVIzZ280N2tvdHd5?=
 =?utf-8?B?STRlT2RLWHBKaU5yeGp1akN0bVdoWlpDK0VMUTRPNm5BWmJ5SFVtM1J0bVJX?=
 =?utf-8?B?cGVtSzVnUS95eTlOU25BMDhJQVBSVmhQV1JRN0VqcElQaVkyL1VabUxzZGVs?=
 =?utf-8?B?T1d4c255ZXNIREFVcFBTZG9Lb0ZubkxkaVlJZlZkY2dYK25CUUlxZldpb2FM?=
 =?utf-8?B?cWFYaTJtZEpjbllpMDhDR21iNGF1czcvQzNmNEZOQ2VlcnpEVzBsbVExMUFk?=
 =?utf-8?B?bVBmeVRBZHpqdnlkOG1ueEhEQlhnSkVPNGtPOGx4K0xpQW81akhSZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27962f83-a6fb-4bab-0814-08df38cc9a41
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 10:32:32.3063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S36/dTOvYK9wYB9jMlWywyuU2KkxhBx7Jmynpd//jz8xAEOfnpgtNOXIStPSIJPtHUHgf5utWgHOa4CZMJ1jZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6640
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 02 Nov 2026 10:32:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24596

On 30.10.26 12:55, alexander.heinisch@siemens.com wrote:
> From: Alexander Heinisch <alexander.heinisch@siemens.com>
> 
> Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
> ---
>  .../swupdate-signer/files/sign-swu-cms        | 86 ++++++++++++++++---
>  1 file changed, 75 insertions(+), 11 deletions(-)
>  mode change 100644 => 100755 recipes-devtools/swupdate-signer/files/sign-swu-cms
> 
> diff --git a/recipes-devtools/swupdate-signer/files/sign-swu-cms b/recipes-devtools/swupdate-signer/files/sign-swu-cms
> old mode 100644
> new mode 100755
> index bc1ec130..686c959c
> --- a/recipes-devtools/swupdate-signer/files/sign-swu-cms
> +++ b/recipes-devtools/swupdate-signer/files/sign-swu-cms
> @@ -1,34 +1,98 @@
> -#!/bin/sh
> +#!/bin/bash

Please stick with standard POSIX.

> +#
> +# Copyright (c) Siemens AG, 2026
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#  Alexander Heinisch <alexander.heinisch@siemens.com>
>  #
>  # SPDX-License-Identifier: MIT
>  #
> -in_file=$1
> -out_file=$2
> -inkey="/usr/share/swupdate-signing/swupdate-sign.key"
> -cert="/usr/share/swupdate-signing/swupdate-sign.crt"
>  
> -error_msg() {
> +set -eu
> +
> +default_inkey="/usr/share/swupdate-signing/swupdate-sign.key"
> +default_cert="/usr/share/swupdate-signing/swupdate-sign.crt"
> +
> +usage() {
> +	cat <<EOF
> +Usage: ${0##*/} [OPTIONS] SIGNEE SIGNED
> +
> +Sign SIGNEE using the specified key and certificate, and write the signed output to SIGNED.
> +
> +Arguments:
> +  SIGNEE                  Path to read the file to be signed
> +  SIGNED                  Path to write the signed file
> +
> +Options:
> +  -k, --key FILE          Private key to use for signing.
> +                          Defaults to ${default_inkey}
> +  -c, --cert FILE         CA certificate (chain) used to verify the produced
> +                          signature before repacking.
> +                          Defaults to ${default_cert}
> +  -h, --help              Show this help and exit.
> +EOF
> +}
> +
> +signee=""
> +signed=""
> +inkey="$default_inkey"
> +cert="$default_cert"
> +
> +bail_out() {
>  	echo "$1" 1>&2
> +	usage >&2
>  	exit 1
>  }
>  
> +while [[ $# -gt 0 ]]; do

"test $# -gt 0" would keep it posix-compatible.

> +	case "$1" in
> +	-h | --help)
> +		usage
> +		exit 0
> +		;;
> +	-k | --key)
> +		[[ $# -ge 2 ]] || bail_out "error: $1 requires an argument"
> +		inkey="$2"
> +		shift 2
> +		;;
> +	-c | --cert)
> +		[[ $# -ge 2 ]] || bail_out "error: $1 requires an argument"
> +		cert="$2"
> +		shift 2
> +		;;
> +	-*)
> +		bail_out "error: unknown option: $1"
> +		;;
> +	*)
> +		if [[ $# -eq 2 ]]; then
> +			signee="${1-}"
> +			signed="${2-}"
> +		else
> +			bail_out "error: incorrect number of arguments. Expected SIGNEE and SIGNED."
> +		fi
> +		break
> +		;;
> +	esac
> +done
> +
>  if ! openssl rsa -check -noout -in "$inkey"; then
> -	error_msg "key '$inkey' is not a rsa key"
> +	bail_out "key '$inkey' is not a rsa key"
>  fi
>  
>  if ! openssl x509 -noout -in "$cert"; then
> -	error_msg  "certificate '$cert' is not a certificate"
> +	bail_out "certificate '$cert' is not a certificate"
>  fi
>  
>  key_md5=$(openssl rsa -modulus -noout -in "$inkey" | openssl md5)
>  cert_md5=$(openssl x509 -modulus -noout -in "$cert" | openssl md5)
>  if [ "$key_md5" != "$cert_md5" ]; then
> -	error_msg "key '$inkey' does not match certificate '$cert' "
> +	bail_out "key '$inkey' does not match certificate '$cert' "
>  fi
>  
>  openssl cms \
> -	-sign -in "$in_file" \
> -	-out "$out_file" \
> +	-sign -in "$signee" \
> +	-out "$signed" \
>  	-signer "$cert" \
>  	-inkey "$inkey" \
>  	-outform DER -noattr -binary

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
