Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C81C77B73
	for <webhook@archiver.kernel.org>; Sat, 27 May 2023 17:01:01 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.79])
 by mx.groups.io with SMTP id smtpd.web11.13977.1685206857450657136
 for <cip-dev@lists.cip-project.org>;
 Sat, 27 May 2023 10:00:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=AhimVlpk;
 spf=pass (domain: siemens.com, ip: 40.107.249.79, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rsse9vxv5/g9ib+KLKG1gI1KqlBgJzu97bokUhhk01ZzntFutBBdRbS9vNdqHRVMUbNJOYgWtripMiUOdAGPGFcHHjks+MN4w0+n8Weoqj7vZKjbb0kVgVVEvfb1RMmJkAYYomzo+7sI2Za75UXzRQ15Hqv66BSZqjp2lRb1cwgEpcmWw1jV9dAtHAr7ta1JrrLurmUeio6cT3wMCnOvxQqIS9tGpasmTmnkC6vBUv78sagKOieUGHI4zpDMO8W9zsw7hKrDH9q6svT/qVE50MqYFEQzSA/NCMPI6J1LTcvigjtFluZuR+0A9JdbbfJlohhxTxhtPD95fMlzrwXl3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=syOK5xlycz6o9cgQxndAyvANRTACIzJbSj5BtFkijxY=;
 b=k4qGxEIMx6cBLeUJvf/adSI1G8mbMWDK9yZWy7QGZCWyF3orVusGnLdzS2yXkmWTn9xO4tSGpo8wTgSac2ToZ1zZ7LhzyEgJB755hjUJaubVhTCRJ3n2RowaUAIRy7b8RTcsFJ3ccj85U4DjsT0/crlOraU+3AzRbMx5FZMoQiAERAvxMet1xsGk7NwbHl2UhaGl/w28whvK990enrNExZBtM14tFM6JCKAGwWipiokGOPsVUta0ta7mbQiPz7HUDpOcb/ysldj6T47qe4D/Gp52t1VAaUvzK+M+IKYO+wGGdosSKtkxkdxfERwIcGkKKepmDg+7Iw8hAwawY4JCXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=syOK5xlycz6o9cgQxndAyvANRTACIzJbSj5BtFkijxY=;
 b=AhimVlpk89XICfNsbkqfDLsQHhrlX9dwHbzFDmmmesVKO5E2rbmOytTVrBPg9YZD1bC88ridj3SD0YcB3+WPLMLLny0MfjFz31bFB9vtc1SsksK2xGDmcvZdoyW+bo8Xk2SbDz6+JylYJkqUvpiA8o1KMi0jPYieYLPYle/iKYIt0CW8Hbk0oWsbKCQQumdwhCsxka3bqQOqLWabKXFZu4MbeRo/f0b6hlTNpfcsGAJNJn1Fnh9ESiG9IFdtnfWsJEt7bwusMTOuqcAkpv6RZBnVhf9nCKnxh+CvB7zmKjiVuQugwf4NyHtZjRyad1J4UPEUAJaQCiSQNyuX7QDcWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB8196.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4c1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.19; Sat, 27 May
 2023 17:00:54 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18%7]) with mapi id 15.20.6433.018; Sat, 27 May 2023
 17:00:54 +0000
Message-ID: <13be5ee5-609b-fca7-775d-969603378b1e@siemens.com>
Date: Sat, 27 May 2023 19:00:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [isar-cip-core 1/2] scripts: Add script to test different
 artifacts in the image are bit identical
Content-Language: en-US
To: venkata.pyla@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20230523135611.31234-1-venkata.pyla@toshiba-tsip.com>
 <20230523135611.31234-2-venkata.pyla@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230523135611.31234-2-venkata.pyla@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0164.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB8196:EE_
X-MS-Office365-Filtering-Correlation-Id: 2781a2f0-23dd-46ce-2953-08db5ed3eeb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	LDh7aUkpiBMq6InmBKYwtQ5/1EvLP9+VxfF4/dlCBVWXNOMFOp0fSNIZ4YqQfnXJiRB4Ogi7Ddow1yWrnFeG9tE9uMepbCivmYVv34IqM7SOklR32Vp52Zk1a1qlid7NOrfhe4O3K1k6vHh3wyLkkgdP9am0uZFE4DKVNKV9DBvEN89M4KhUL1g9oKvzTXsF4kCzCVb61l7rWQnCOY/LGsteU5MbbRjJ7AOdOnfuEmbRZNzO768S/Z4W15dxI5IPhicmFw6XnM3QWpID6l3Dp1jQXPSqPxDaB17mT+Cp8FKF/XF4V0hj2c/Kpqz3zu0EZp/IDgJUgYswlKuVdGspqT75M/Wl6hNdvhVkv+tQK5SOFti3SBk/inwXp5Z+B6l8e5fblREWAj63xUe9r2ij6W0CtpxTMnGX7YyOV0LPYUBruU8bxNqtjrk2mUlxE1Hg/LrONkAgg/c5tdnTMVx4OoGE9cfQv5TS26KMQhWrUwirJCuEfbrVxL21mB50oJs+mDAIM2f+1HhT8wmRARdBIeV17CstkfTDRIr0hZJc5vFqh+f456hM2bxWoNEmJgEqP5sraxe56ISO9738QTF1YAN0r2Xfd7nZGIG7nW3igBsFWQPA7dDIwffrSez6EyTl7rIfJ7DetNn9lNX6FNSi8A==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(366004)(39860400002)(396003)(451199021)(86362001)(2616005)(31686004)(2906002)(186003)(66476007)(66946007)(66556008)(36756003)(4326008)(82960400001)(6506007)(53546011)(26005)(6512007)(31696002)(44832011)(8936002)(8676002)(5660300002)(38100700002)(6486002)(316002)(41300700001)(6666004)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cktUUmpQRUVaR3FuOWJTK01ZY3oraXlrdkZVVktxS2FnUmlsWHJ2QndZSURQ?=
 =?utf-8?B?TFZneDVadDd6UE96OEtaNkVNK29DTWphOEUxQ3VnRkRJZzdVMkp2Wi9YbCt5?=
 =?utf-8?B?YTIvWG9vZFplaCs3c3hJMUJWajVqU21NeFZKTWY3NDZ4WXFXdVR6MUJlQVRD?=
 =?utf-8?B?VkJNWFVyTUJLYXppY1lSdTd1dGxoQWxwdjU2Nmd4cEFyOWZ3SVgybHl3UllZ?=
 =?utf-8?B?c3M2cGV1QW43K1pBUmFJVjhKOGV2WnNxVVU3b3FmTGkrcC9ZWGttR0FCcnUx?=
 =?utf-8?B?bitMN2NVVTc4MkRBUk9DVHZWeFYyK0ZPNmlPMHJnUGUxNVVLeTVNRFNseTNW?=
 =?utf-8?B?bkRqbE9QUFl4clQvU2JnZ3p1dEdRakZteTM4YTRlMTNUcWNOWWZIczgxdy84?=
 =?utf-8?B?QmV1Q3UxMFR4ZVQwZkQzNmVBQU9jUEM4czMycWVUQmJGeVF1dzd5SUQzWFFJ?=
 =?utf-8?B?b0ZlVW1LdVBLTFpxZmRDbDZCaXdRZDluZVN0Zml5VG8zMlRUSk5xRVNkbm91?=
 =?utf-8?B?bzdYZ0tYVXRERitsS0dqS2gxRWJnU2F1S1drdTk5TFZlRGFUd3E0WmIxY0xO?=
 =?utf-8?B?QnJ4aU1CUG9RTEIxTXlyWVNKVmQ3NnR4NkV6cVRpdWlJK2xmK1dpSzJvb2ha?=
 =?utf-8?B?cy9qQWhxbDhmS3BNRkI1cDlMVHRZc2pZNFk5dVlvOWd4RjJMKy8vLzQwUkNm?=
 =?utf-8?B?TW53RW9Idi9nUTN5Q28vNjd5YzZxZXUxV3lrWHZGYzhIeTVZZG9yN2k2d3ZG?=
 =?utf-8?B?aVhtWXZSMWZjeXQ4OFFYZHJsdlhnN3pLRjM5NVpNeGU0Zk9NTTE2dWt2OHVQ?=
 =?utf-8?B?SjlkVG93cGxqcDY3dHduekwzNmtoZGR2cnMrMnRtZzlHTWZwaXRLMm1uYzVL?=
 =?utf-8?B?dWFmZ2tza2RKK1VQZWFmbWN2aUc1SHZESExsK0E1d3U0dm0vZ01oenBPd25R?=
 =?utf-8?B?YjNWSWZOYWxlVUhIMnltL0lIYy9wRFNwRmVzSDlobnBBNXpaUzNzenkyUy8x?=
 =?utf-8?B?Q3ZrVUZvZ0NPdzZ2dzltd3BHZHRVZGhaNFFqS3hhU3BwWFE1RTdlN3lMYVVr?=
 =?utf-8?B?aWZsWHNlTUxqdjZ6TDFRQTBuZ21GTnFEdnhxZkZUWGprRWhTV0RtZnh4NFVy?=
 =?utf-8?B?T1lHVVNBOE5tVG8wOTBRd2FSSGcyV0krNE45TmwvQTcyeVFkVUdQeEtNNHM2?=
 =?utf-8?B?UFNlTlpHTkNxbmZFdjB3amhRUjEyUXdTYmllK01uSDlQOWVzT1MzN1Z2THlO?=
 =?utf-8?B?TFFpL3d0WEhadnBvWlBPbHpXdFV0WW1DMjlQZGxIS3lzTWtLcXYvNk9ZcG9Q?=
 =?utf-8?B?aGhEZzZLN2htbHVabDBZdUpPamxDdVMrc1FuaCtxT01hNEVIOTV6TUtRUVNQ?=
 =?utf-8?B?SThVMGxEeWxQZnBSbnFQUHNtRmdjanpWbEc4WnZVUnlPcXBjS0lPU2N6bUox?=
 =?utf-8?B?ZSsydkpOTU9RdE9GSnpOcDJnRWRpaHJrN3lwMEYzaHR4cGRCZ3d5aG92eStB?=
 =?utf-8?B?QUdMYnB0WW1zVUhraUFvd0k4S3J6ejVVTUFCcTdtVzFIdElNVkpGR2ZwS0g5?=
 =?utf-8?B?dUpFSkErMi94RER3NTY5SzF1WnZDM2xlQVdXYlg4N2xRQzBoajNKOE5SaVM3?=
 =?utf-8?B?d0QrMDFCd2JjN1JLbkN3VUNhVThnVUZlLzQ2ay9JekFXYnZObXJaTERGVmlE?=
 =?utf-8?B?MUxhTEkwdTdKT1lKWlpzUTFxRHhuVVRxTmJPeFpnc2JKVVVlUXB4UFQ2aHBF?=
 =?utf-8?B?RnB3U1AweFE1RC9jdWxNR2lCSTI4dWpSQTVnbi92Tnl1dUx0dVdPUHlQcGlw?=
 =?utf-8?B?TktyTFlKVDBuUnRENks5V2NpKy9tNVdTWElkbFNuam1xRTNUenc3ZDd5c1hW?=
 =?utf-8?B?UU9rMHhjYmZ4NVhwbWIySStUUVlmSXZuTVdDTGxiczVLQzFPbHJDREVIbU5J?=
 =?utf-8?B?OUViTnIxZVM5N1BNTTBwT2d0QmZQMU42NWdlUFkvOVJsTTJmVWIwL0dXanpM?=
 =?utf-8?B?dm9BL2VCYnNZazVveUhkaHU3cnZpR0duVjc1djQ4WkQrTTFPbXltaFZRUldi?=
 =?utf-8?B?cjVMNW1EZEloRHcxaFk4c25wd2dFcFFqSnpzRHBDbkkrUFN1cHJzUmlCNzJX?=
 =?utf-8?Q?pbp9Zl7BM+DGCwgukm3pFBsiQ?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2781a2f0-23dd-46ce-2953-08db5ed3eeb1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2023 17:00:54.1857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YNaOV8X89buqvcdW+CTv49RHya0uj0D0rhtt2U6o4ppuuN4XkYG6sNwgQEbRoJ/bTQePoxLlktUhmBR9kRlUGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8196
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 27 May 2023 17:01:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11668

On 23.05.23 15:56, venkata.pyla@toshiba-tsip.com wrote:
> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
> 
> This script helps to check the reproducibility of different artifacts in
> the target build like vmlinuz, initrd, rootfs, squashfs, ext4, swu files.
> 
> It uses diffoscope tool to check the artifacts are bit by bit identical.
> 
> Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
> ---
>  scripts/repro-tests.sh | 91 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 91 insertions(+)
>  create mode 100755 scripts/repro-tests.sh
> 
> diff --git a/scripts/repro-tests.sh b/scripts/repro-tests.sh
> new file mode 100755
> index 0000000..f767839
> --- /dev/null
> +++ b/scripts/repro-tests.sh
> @@ -0,0 +1,91 @@
> +#!/bin/sh
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Toshiba corp., 2023
> +#
> +# Authors:
> +#  Venkata Pyla <venkata.pyla@toshiba-tsip.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +set -e
> +
> +usage()
> +{
> +	echo "usage: repro-tests.sh [--release RELEASE] [--target TARGET] artfacts1 artifacts2"
> +	echo ""
> +	echo " Optional arguments:"
> +	echo "  --release RELEASE: debian distro rleases e.g. buster, bullseye, etc. (default: buster)"

"release"

> +	echo "  --target TARGET: e.g. qemu-amd64, qemu-arm64, qemu-arm (default: qemu-amd64)"
> +	echo ""
> +	echo " Mandatory aguments:"

"arguments"

> +	echo "  artifcats1 and artifacts2 paths to test the artifacts reproducibility"

"artifacts1" - fixing up while merging.

> +	echo ""
> +}
> +
> +RED='\033[0;31m'
> +NC='\033[0m'
> +GREEN='\033[0;32m'
> +IMAGE_BASE="cip-core-image-cip-core"
> +RELEASE="bullseye"
> +TARGET="qemu-amd64"
> +DIFFOSCOPE="diffoscope"
> +
> +while [ "$1" != "" ]; do
> +	case $1 in
> +		-r | --release )
> +			RELEASE="$2"
> +			shift 2
> +			;;
> +		-t | --target )
> +			TARGET="$2"
> +			shift 2
> +			;;
> +		-h | --help )
> +			usage
> +			exit
> +			;;
> +		* )
> +			remaining_vars="$remaining_vars $1"
> +			shift
> +			;;
> +	esac
> +done
> +
> +set -- $remaining_vars
> +artifacts1="$1"
> +artifacts2="$2"
> +if [ -z "$artifacts1" ] || [ -z "$artifacts2" ]; then
> +	echo "artifact folders are missing"
> +	usage
> +	exit 1
> +fi
> +
> +# Define files in the artifacts for checking the reproducibility
> +set -- \
> +	"${IMAGE_BASE}-${RELEASE}-${TARGET}-vmlinuz" \
> +	"${IMAGE_BASE}-${RELEASE}-${TARGET}-vmlinux" \
> +	"${IMAGE_BASE}-${RELEASE}-${TARGET}-initrd.img" \
> +	"${IMAGE_BASE}-${RELEASE}-${TARGET}.tar.gz" \
> +	"linux.efi" \
> +	"${IMAGE_BASE}-${RELEASE}-${TARGET}.swu" \
> +	"${IMAGE_BASE}-${RELEASE}-${TARGET}.squashfs" \
> +
> +# compare artifacts
> +res=0
> +for file in "$@"; do
> +	if [ -f "${artifacts1}/${file}" ] && [ -f "${artifacts1}/${file}" ]; then
> +		if $DIFFOSCOPE --text "${file}.diffoscope_output.txt" \
> +			"${artifacts1}/${file}" \
> +			"${artifacts2}/${file}" > /dev/null 2>&1; then
> +			echo "${file}: ${GREEN}Reproducible${NC}" | tee -a diffoscope_output.txt
> +		else
> +			echo "${file}: ${RED}Not-Reproducible${NC}" | tee -a diffoscope_output.txt
> +			res=1
> +		fi
> +	fi
> +done
> +
> +exit $res
> \ No newline at end of file

Also fixing this.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


