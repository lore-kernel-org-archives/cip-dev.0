Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.62])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8486.1793356333888948629
 for <cip-dev@lists.cip-project.org>;
 Fri, 30 Oct 2026 03:32:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=GMi3A6ys;
 spf=pass (domain: siemens.com, ip: 52.101.69.62, mailfrom: alexander.heinisch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PbqIcsmycD+83TcvJVCVDbg8UzisMnvuoDGpjiZbeawYKgEVEmO1cbQRnpJxZLqVel4w5o5ZhXagZznG/AG3VtkvxUNpYBJvCITOvqDgFKpDjq1Ux395k22fR3rmgN0HGjBYyyKaCfEjlczgvm76akNq1BDdGpwVTNUVqdrYnSNXe5bTndcT0bL+Fh4+cdDLPmKvfxsTmKua753iVRJnm+J8mAO4qmI08SMIlDEpR3pimrhWu3BO1jzoz5ouPyAniRr6x4cVxQHX53NpqdsesQ0HcUQVguOqetHOQb8WPk1EZh3bb4GFfZKh0Y6HVVVBQvOTUXFfkviQQCfITAP+DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+I7cUtIyiPQ3eLBrQxflkcCP7ZNtjSnlQdw3DsyaBMM=;
 b=YParyPS4XHTOCvQBdkgle4f0ggaCxbLfuMo4M64nCg0CFaQo0piYGFACx77k+F69QZX7DjejAHThFWyjW+jlPC9lzNEKCFDh4q/E6HF/Mv1vRNj6M5ahJCniVNmKCqUhm/TvcCKfvOtdLsfavXn/Vsr4ddPPMT1OlSqfC6cqvGfCLXfox0rtkSLtKTvvVImmfYxnkl55qphdAL5HQf1P06LqY1w52F9DAlf1NQlQ/dVrnWG947y+dhletvI6+gF62BDjGdUv70yW9pdzCY9u+YsVbPf4eSbOGqUjSuEZCo/lwPCMwXSqoxTR8WX7D+1iHkIkA+Vr8MVtrUxwKBN6KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+I7cUtIyiPQ3eLBrQxflkcCP7ZNtjSnlQdw3DsyaBMM=;
 b=GMi3A6ysD5hL0lZ+Ggf0q7W8FJNexsOKwo0O01e+hq34RSRzhCI/l/SHrh0qei6+j7Bk7KNd57ryR+SeeBNIKIOARLq7ppgKzsugb9wLdD8+kUfNwwjqFFXQoPl6X6ROdeGnyaA5t9xEL7esG4lKTipDqzOm6T5+7Ge0U5rG25Sha44cDsFSiW28bnOYajmlQi8LkgSYJqTrY7NDokvpocVLfsXri7hp0a9vADX0ZhEqwL6UiR9nSYFVciZz8LiXuiQ3EupJ25V2cDZwvnzmjg1u6uYtT6wgy2cDkChO/rnxa7VjZ5Iau4HO1Hf4qXj3SjF+QAztrPsFU/iIYcFJhw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ed::14)
 by MIWPR10MB411592.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:290:e6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.4; Fri, 30 Oct
 2026 10:32:09 +0000
Received: from DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2339:186:874d:c405]) by DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2339:186:874d:c405%6]) with mapi id 15.21.0592.003; Fri, 30 Oct 2026
 10:32:09 +0000
Message-ID: <0d0540d2-7ece-44b6-92a1-b962d86ef567@siemens.com>
Date: Fri, 30 Oct 2026 11:32:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 2/2] swupdate: Add out of tree signing
 script for swu files.
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
References: <20261028184403.301959-1-alexander.heinisch@siemens.com>
 <20261028184403.301959-3-alexander.heinisch@siemens.com>
 <ab95b821-f047-437d-8fbc-40720e9972a9@siemens.com>
From: "Heinisch, Alexander (FT RPD CED SES-AT)"
 <alexander.heinisch@siemens.com>
In-Reply-To: <ab95b821-f047-437d-8fbc-40720e9972a9@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIXP296CA0014.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:36c::17) To DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:4ed::14)
Return-Path: alexander.heinisch@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB8045:EE_|MIWPR10MB411592:EE_
X-MS-Office365-Filtering-Correlation-Id: 437e6835-33db-4826-7c58-08df36710d47
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|6133799003|18002099003|22082099003|55112099003|3023799007|11063799006|5023799004|56012099006|4143699003|261022075727099003|261022105027099003|261022115727099003|261021121427099003|10067099003|261009223027099003|261026140227099003|261028144727099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: qNMH3xKIoGy+oPfJjF8YwknKXBzDFRhx39hpNdWX+glxRPr0ZvMojG/eCbwcU7yWHjJ4wCEcQ23qEf+6hD+tRx7uFDyBei9UVVwOqBFetFqVqYn/kJ/AYqqZUZMm7yCf+2M1Do2sw3ROyCWQtyb4fsxjUzAmWKHCHAsRlxpBiz/JxwXRjC+lqctOPFh1FG0Bte0ViMgcycfYmTh+FwIZ7UEdzHCYjsPdC1S2UNwulHnpHX8Bg2/w5/FJV/T8CBxYpprTXUuLXM5RAJwDZOozjuWuCTLI4T8tq4oWYRqfd5kFMlCJWesLNFUb+OkQ649NW5LrtSPINlVAUmWE2gn5xnJZySYNllr5wMN0WnKsJuqEmUVUWA4OK9Svo7NcHaWnpLG6tq+T2eXvWbO3OB94YATzO4JeJTiLcXIuIw4LZVEcvGlF8CrwlcB3POLVdyzT98pEgsCqhB8Xqvvad1JSxrJVg7gC6EwPLDBeGxxCor/4kImmtwcygj0h2qvBg3XsI3t7sBpWWfUxYwnbDPd5WYE4xDbWQ6BsldFEvsdV/V/qMZLFddZM+WnQ9lugiHWy8MmzcEkePBOEjj2F7xMgBCBXKWx7DtPsyklWT9LrCh9nsi5lDqb+NAQzMX0HvA0dxyCN1aDMBkH++iRq7GdWONWOnXNynO4hF0RwZpxz7d8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(18002099003)(22082099003)(55112099003)(3023799007)(11063799006)(5023799004)(56012099006)(4143699003)(261022075727099003)(261022105027099003)(261022115727099003)(261021121427099003)(10067099003)(261009223027099003)(261026140227099003)(261028144727099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmlCWldqSTBHZXFzU3BBbERrdVcwS0kvRllKS1ExUjMwTWQ0NW5vdDlxTzJE?=
 =?utf-8?B?NmQrT0I3eHZOZit6VkhDcVA3RVZ0UDIrL3NYZXZHWWM1TFdXSFVyMmVMWndj?=
 =?utf-8?B?eDlrUHIzWUVOOHlkSktrMVo5eWRWaFdXalQ4alRZSndoQ2VIV1lKNE53VEZr?=
 =?utf-8?B?N2lqR0dYOTQ0L0Z2K2NiVTBoQldna0JNaDBLT0RHbjRPVXdxVHoxYmQyNWxz?=
 =?utf-8?B?cThJTmI3OVU4aEpFTFhoUE5EMjNPZkNyK0srWHFpWm50aGZKRHFMaUdWZnRa?=
 =?utf-8?B?NWJSK2xuMnRhaEY1QVNxT2F5UG5CbXdqWHB2ajc4dVpZelhhUGkvdytVeFZl?=
 =?utf-8?B?a2pGSUhtNGZrS0VsUmViY0dlZVg3Z0hpWmFTQXlUMXhPMkprY3RXczB3WDlB?=
 =?utf-8?B?SFlCOXgvc1paK1JBSUNrYlJxYjBvZXJ1ZW9KbTZvK2ZLUmt1WnpEdnRKZDVV?=
 =?utf-8?B?czMzY0gxbGxaWENoRm4zMVNNZGovR1VWME5RM243UGdVWERQbTNRVUxKZ0U3?=
 =?utf-8?B?MFhpZTVQelZLc1dZVlc2Mm1hNnFDZGxlaEhjU1Uva3lvWVFhTWVSMkhkbWY0?=
 =?utf-8?B?QWNRL3lYUiszL0xPNFFXcUJIRGhLVUV0RW84dlozZjRha0JkSXBWL0FMSWhT?=
 =?utf-8?B?NUNWaTloRGhTUzNDS0NhNWpPcVFIRktRa0VTaXpQK0UwNklRbjNZMmRScTY4?=
 =?utf-8?B?SzFyeHRxaXI1Ui9jbkdNL3ZrMjR6Nm9LdlBiVUM1c3A0VlhNU1M1UFZxUGwr?=
 =?utf-8?B?VDdYd0VKYzNSQ3FaRDhmbXdKVUs4a2hST3hvc243eXBvU3Vzb2F4TU9ZdFFa?=
 =?utf-8?B?aEtrRW52RUUvL0F4S3hQTmlrSDkyd1RvSmhKMWE4RS9rUTczM3g5ZnZDWGtq?=
 =?utf-8?B?MEpsOTR2UTI4djQ1Qy9ZQ3haVlJCc1E2aE9CWHRUdjNDeVJrN0pVZmtFMGRY?=
 =?utf-8?B?NzVPcE1tbWU3ZDhoQmc0QjJzQW0vdlBXNFhtYWdkbUN0MUZZaTRWYjJoYmJi?=
 =?utf-8?B?REcvWnV5cHpBVkV5K3NwdmRFOW56b2RRYWNTMDJUamhHUW1HeGtoTlNtc3VQ?=
 =?utf-8?B?RGxmQVBzTVQ1UGlRTFBTUnJmVEcxQyszOTFacm03cjdQWXNFOXNuTWNITmhY?=
 =?utf-8?B?UFV1KytYdnRTYVBwdmFHcFp5cW5YRERWR2ZCbUdvWWJ4ODVSaTg3SkErclFV?=
 =?utf-8?B?bEExL0pZNkNUazVjT3VHZ25wV3pzNnJHMFdPd3BKdWV0SURKRTNRTjVHTENG?=
 =?utf-8?B?SkF2U2lRZkc3ZXI1UWYrTG1Td3k3ajFVQ0lXYmI0RTBLMXk4ZFFHM01qTlZY?=
 =?utf-8?B?dmhLeUZZV2xiaExTdVcrL3ZlcXhMeGRzcHR3cHpveDlXMHowbVY1VzZGRy9w?=
 =?utf-8?B?RG44UDY2cTZ6M2hmTHlKQ2NBQ3ZIMXNKTGJrcVRNQkRGOWNGVGhNLytvREpu?=
 =?utf-8?B?V2RNYldpNkhzVVBxTWdpR3dQRG92Nkt0eTZTQ200Ulh2VVBXejJWWjJLdVJZ?=
 =?utf-8?B?azB6VnA3TnJnalQ4ckZRSGFpbUxkbXNZdHdxR0dPcHpNYW9pQTkxdUZ4a1Z3?=
 =?utf-8?B?UTc1bi9vTnMraVNJdnZaOWlQeEIxblpLUU9oa2EvQjgrUTBlZXIyNHJNS3lC?=
 =?utf-8?B?WWd1bUF1Smk5RDJGUjV3R3pHb0ZZYWhFaDNsVUtocHV6cEw0N0h2L1RrK3Fx?=
 =?utf-8?B?MTJCWVZwbzhhWTVPU2F4UzUzMS8rNjRPcXYwU3NyOTVuNjRWbjhmL1lzNDZa?=
 =?utf-8?B?MFdZclNYT1UwUk5zUHJ3VGxpckxzcmhnWGhEbUp4M1lidzY4cnkwYTVPUTZ2?=
 =?utf-8?B?SkdvN2NXYWdqYm5EaWJkREh3NC8zQ2V5bWViQkJuN2d6NkNORUdQVVNSTkdJ?=
 =?utf-8?B?L2tITE5DTVl5VnBPcWE0TUF1NUZET0JNYThOa1FVVjNVMVdrVjFTa3FFVjhF?=
 =?utf-8?B?MWRiTklvc2QrVk9zN1dJTW51TDVNWmpNK3k3bENQOExtdzR1RUdOMHFEQ3hD?=
 =?utf-8?B?eDZlOEhSaldMOElrWldCS0MraW9KQkRDRk8zTmFxR1Z0anZNRGpONzZRLzky?=
 =?utf-8?B?MGVaUldUd1NrZ0p0cjZNeGlMSFZnOVhsbnQrTUxXZDNYNGhpTmp4R0hIcmpu?=
 =?utf-8?B?T2xNcm5EMXd4cWNUNlg4MHBjeCtXK21kMElDcGhwVG9UVmVqRkEzQldHSHlB?=
 =?utf-8?B?eS95MllxUkVWSHBncUttSm5XcVFRcWV3WWdMUnBDT0cvMFZTb3ArRHB1V3k1?=
 =?utf-8?B?blJHU3E5cE1yMUJFQitMVnl2bXFjd1JDTTloS0t3dkxYWVp4dnpaOVcvMUxy?=
 =?utf-8?B?SnA1SkRLdmhUNlIxMzBUSU1BL0M3d2xQSHBpczRMeUpyYW5LNmFFV1oxMnpJ?=
 =?utf-8?Q?u3FW0XY2Xjnr4YE4=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 437e6835-33db-4826-7c58-08df36710d47
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 10:32:09.3164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hZsh0iUNR+dMZTTLCdA3/QBMyqdQuLHkr6kxQUvPVi4yGWl/3TuWOL1+jyMuiP7nqEywqE0EnBCHVu/iLZwA3JyAN0N+GPwm32rYRiYwa5s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MIWPR10MB411592
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 30 Oct 2026 10:32:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24584



Am 30.10.2026 um 06:59 schrieb Jan Kiszka:
> On 29.10.26 02:44, alexander.heinisch@siemens.com wrote:
>> From: Alexander Heinisch <alexander.heinisch@siemens.com>
>>
>> Added a helper script that unpacks a pre-existing .swu file signs
>> the sw-description using a custom signer script and repackages
>> the swu file including the newly created signed sw-description.sig
>>
>> The script interface is:
>>      sign-swu.sh [OPTIONS] SWU_FILE [-- SIGNER_SCRIPT [SIGNER_ARGS...]]
>>
>> where the SIGNER_SCRIPT interface follows:
>>      SIGNER_SCRIPT [SIGNER_ARGS...] SIGNEE SIGNED
>>
>> SIGNEE and SIGNED are provided by sign-swu.sh
>>
>> Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
>> ---
>>   scripts/sign-swu.sh | 128 ++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 128 insertions(+)
>>   create mode 100755 scripts/sign-swu.sh
>>
>> diff --git a/scripts/sign-swu.sh b/scripts/sign-swu.sh
>> new file mode 100755
>> index 00000000..9e418cb5
>> --- /dev/null
>> +++ b/scripts/sign-swu.sh
>> @@ -0,0 +1,128 @@
>> +#!/bin/bash
>> +#
>> +# Copyright (c) Siemens AG, 2026
>> +#
>> +# Authors:
>> +#  Alexander Heinisch <alexander.heinisch@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +set -euo pipefail
>> +
>> +script_dir=$(dirname "$(readlink -f "$0")")
>> +default_signer_script="${script_dir}/../recipes-devtools/swupdate-signer/files/sign-swu-cms"
>> +default_signer_args=(
>> +  -k "${script_dir}/../recipes-devtools/swupdate-certificates/files/trixie/PkKek-1-snakeoil.key"
>> +  -c "${script_dir}/../recipes-devtools/swupdate-certificates/files/trixie/PkKek-1-snakeoil.pem"
> 
> "trixie" will eventually be outdated, and I bet we will miss this
> reference here. Any chance to use something more flexible as default?

Couldn't come up with a more "flexible" approach. I wanted to make the 
script as convenient as possible by default. Nevertheless, downstreams 
bring their own certificate material anyways (hopefully!). But I agree, 
Trixie will be outdated eventually, so will be the defaults.

> 
>> +)
>> +
>> +usage() {
>> +  cat << EOF
>> +Usage: ${0##*/} [OPTIONS] SWU_FILE [-- SIGNER_SCRIPT [SIGNER_ARGS...]]
>> +
>> +Sign the sw-description of an SWU image and repack it.
>> +
>> +Arguments:
>> +  SWU_FILE                SWU image to sign.
>> +  SIGNER_SCRIPT           Signer script to use. It is invoked as
>> +                            SIGNER_SCRIPT [SIGNER_ARGS...] SIGNEE SIGNED
>> +                          and has to write the signature of SIGNEE to SIGNED.
>> +                          Defaults to: "${default_signer_script}"
>> +  SIGNER_ARGS             Additional arguments passed to SIGNER_SCRIPT.
>> +                          Defaults to: "${default_signer_args[*]}"
>> +
>> +Options:
>> +  -o, --output FILE       Write the signed image to FILE. Defaults to SWU_FILE
>> +                          with .swu replaced by .signed.swu.
>> +  -h, --help              Show this help and exit.
>> +EOF
>> +}
>> +
>> +bail_out() {
>> +  echo "error: $1" >&2
>> +  usage >&2
>> +  exit 1
>> +}
>> +
>> +swu_file=""
>> +output_file=""
>> +signer_cmd=()
>> +
>> +while [[ $# -gt 0 ]]; do
>> +  case "$1" in
>> +    -h|--help)
>> +      usage
>> +      exit 0
>> +      ;;
>> +    -o|--output)
>> +      [[ $# -ge 2 ]] || bail_out "$1 requires an argument"
>> +      output_file="$2"
>> +      shift 2
>> +      ;;
>> +    --)
>> +      shift
>> +      signer_cmd=("$@")
>> +      break
>> +      ;;
>> +    -*)
>> +      bail_out "unknown option: $1"
>> +      ;;
>> +    *)
>> +      [[ -z "${swu_file}" ]] || bail_out "only one SWU_FILE may be given"
>> +      swu_file="$1"
>> +      shift
>> +      ;;
>> +  esac
>> +done
>> +
>> +if [[ -z "${swu_file}" ]]; then
>> +  bail_out "no SWU file given"
>> +fi
>> +
>> +if [[ ! -f "${swu_file}" ]]; then
>> +  bail_out "SWU file not found: ${swu_file}"
>> +fi
>> +
>> +swu_file=$(readlink -f "${swu_file}")
>> +output_file=$(readlink -m "${output_file:-${swu_file%.swu}.signed.swu}")
>> +
>> +if [[ ${#signer_cmd[@]} -eq 0 ]]; then
>> +  signer_cmd=("${default_signer_script}" "${default_signer_args[@]}")
>> +fi
>> +
>> +# Here the actual work starts
>> +# 1. extract the $swu_file
>> +# 2. sign it and
>> +# 3. repack it to $output_file
>> +
>> +workdir=$(mktemp -d)
>> +trap 'rm -rf "${workdir}"' EXIT
>> +
>> +extracted="${workdir}/extracted"
>> +mkdir "${extracted}"
>> +(cd "${extracted}" && cpio --extract --quiet --no-absolute-filenames < "${swu_file}")
>> +
>> +if [[ ! -f "${extracted}/sw-description" ]]; then
>> +  bail_out "no sw-description found in SWU image"
>> +fi
>> +
>> +"${signer_cmd[@]}" "${extracted}/sw-description" "${extracted}/sw-description.sig"
>> +
>> +if [[ ! -s "${extracted}/sw-description.sig" ]]; then
>> +  bail_out "signer did not produce a signature"
>> +fi
>> +
>> +# Only replace the output file once the image is complete.
>> +(
>> +  cd "${extracted}"
>> +  {
>> +    echo sw-description
>> +    echo sw-description.sig
>> +    # Keep the order of the remaining files from the original image.
>> +    cpio --list --quiet < "${swu_file}" \
>> +      | grep -vx -e sw-description -e sw-description.sig
>> +  } | cpio --quiet --owner 0:0 --dereference --create --reproducible --format=crc
>> +) > "${workdir}/signed.swu"
>> +mv -f "${workdir}/signed.swu" "${output_file}"
>> +echo "signed image written to ${output_file}"
> 
> This scripts is just lying around now in a folder and has no reference
> in any documents. This should be fixed.

Will add to README.signing.md

BR Alexander

> 
> Jan
> 

