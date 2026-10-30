Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5632.1793339977900312520
 for <cip-dev@lists.cip-project.org>;
 Thu, 29 Oct 2026 22:59:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Q4fRb0k+;
 spf=pass (domain: siemens.com, ip: 52.101.65.45, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tt9F3vok6E9lC6TLEWt9xpmJQLqBUpvGnvYjmD+Z8zWwk1CEjC8Y0RZTURYK/kY2MPzzVDeWmhrAbC92fZuDZ3FsY8UVTpzQx5YRSckpc5IYGboD5wAuhSC98WiC+aAsMwrwLPICYwd2i2CeXJmEHydwK1uyjJ77KhswZadd5qzJPkid8KnY1KDBsq/8ADS5GRB+ZQauP+nnApxYyTfwIJdVdxKnn3/Cjj5JtSIxjVlGWl9/1laHLexuKXD1FgjqYyv2egPdF+654ibeyb4zi1c0TsBrEiWBJxTphXXceZr7ttXBTvXibixcB9bo36PE357lFzGX9VOPbUmZk6OAng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iC7WtO0Mo8McrMxsmvh7GH5z1hkH1kP2A4Jk1lGLxV4=;
 b=vGxDdZHrA3U5fKEM7R2a+XP/Md4GUVz/zI8tEmzKxIG+Xg9llqDABgvQfz1j99SNAD6MxL1ipU+CBWt+b41rdB+EDAfkFPS8J90oyjB7Q0nX8CvFI8//va2ZR3RNXB+S5BdGAfcmHtVPHLOb1C3pLMGDE8sVGfVbY1nC85dG1xrEtw9oB+rMitRkX8yfAWAR+g8C4SoFs7mZa6TDaDPPnqWwSpE/KOLJWZYTTuBjU3xXagphKkbrsXx64Mpv7BsC4VTRw808Lx5/lI0OM8t5k+gFwUJ560gCIWcjKpgay5d1F30VrmezsCso3IcqAnAiW8JZyEOHZFPx4tQ4cSKWwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iC7WtO0Mo8McrMxsmvh7GH5z1hkH1kP2A4Jk1lGLxV4=;
 b=Q4fRb0k+1QBn5wNqnEHppdIZjArrTayvNNMNJCa4Tmt0oIBIAccb9hp1HOJjriny/sN4e2J5Ax7QH655xTky1dNWmR1g0+oVVMdpzyxevw5dAcJoKTbxv4XU8BZikKW4hGE6FYve85HaNPJTg5L8iW8iMiZl+qImP2nUIGmkiEGOBji5cXQrTIKLXn/vaye0B7CdE7zmx9mGa360jgoNtFptl+ZlJ1i4VU9rzIiblNNUzD7SvGrRENHtuvl0emnhYgkkjex5IT3xWyugP4n7b68zZ/EGEmtPwvY3eDuwH2y1waxdIEjqOUosnQzoHlG1J7Y9MZvWP7+3yaG+HQrShA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by PA1PR10MB9051.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:453::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.5; Fri, 30 Oct
 2026 05:59:33 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0592.003; Fri, 30 Oct 2026
 05:59:33 +0000
Message-ID: <ab95b821-f047-437d-8fbc-40720e9972a9@siemens.com>
Date: Fri, 30 Oct 2026 13:59:25 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 2/2] swupdate: Add out of tree signing
 script for swu files.
To: alexander.heinisch@siemens.com, cip-dev@lists.cip-project.org
References: <20261028184403.301959-1-alexander.heinisch@siemens.com>
 <20261028184403.301959-3-alexander.heinisch@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20261028184403.301959-3-alexander.heinisch@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0126.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::7) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|PA1PR10MB9051:EE_
X-MS-Office365-Filtering-Correlation-Id: 985463cf-c549-459f-de95-08df364af860
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|6133799003|55112099003|18002099003|22082099003|3023799007|56012099006|5023799004|11063799006|4143699003|261026140227099003|261026121527099003|261028144727099003|10067099003|261021121427099003|261022105027099003|261022075727099003|261022115727099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: jjKnTmqEGD9hQ5PUCIaFszEGIfcoCEXqVcg7XBbyuZmbWRAeRfUOquMR2+2gygHtJuj1u0uzxxHJIjeFJwSFJhzZEPTRyrIJD1EH3H673QNpuB2hX+Z1ck83zAiYTXoziXzm5ho/44iaBHIM8MSxfBCo0GscIDNKLj9hW5YE7Se4lnyDTapUH3B5mpODAQwGwHz9ICy2tvgMWlUez/o35IXLzS/unDfn/D3wbYTT7T8Ib8SG1o81MoqJi4Mvo1HM5TcyWD9hCMZEc1J7iFM0qts0MtvNT/o7GkqxqXsPRSBYvAzSb146KL4jwt6LYnjOdH/WtUMHWaimWnQvOC3/82F8tX94sF/iVYz+gJljvGzp5Xp6Bp2ho2bkp0oxT6BeeAUmbfBntzwclV4Q99MxrmFk+/imYn8SJCvysbb33esaFDH9BS1lM8ZKQUIW0zbLbAjmViGsqEiBzODFUuuIx0c0odgdb5Kx95N5pEKVA2ztpahNqocazf9OfX/L38imGyHVZfzo5Hjg2Q5Usi5nsEqE06w9Kk901La+b+lzRQWKkCvEycO4RHgyVLSDEsL0tMz5B/my5UfsQ4+cp4M05E3C28lBtdExjc69NpKx2nT+EOfFZBm8q11pWQrIYM6c1x74hkq0CEcmI3bgIRjgTZjfJ3TNkMgMmjgXnwloetU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(55112099003)(18002099003)(22082099003)(3023799007)(56012099006)(5023799004)(11063799006)(4143699003)(261026140227099003)(261026121527099003)(261028144727099003)(10067099003)(261021121427099003)(261022105027099003)(261022075727099003)(261022115727099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlNJQ3ArbzU2alR6L0hiajh0Sjg3UlArQnhqSkY4bDF6RFVjQTdHL3RJWXBE?=
 =?utf-8?B?aUMyUzRQVmlEbkVjQ0g2WTQvZGF4aTZETExpTlZONGtwM3BNcWh6RkN2dEJC?=
 =?utf-8?B?bWZFYnRIZ1g2REttUHhQYlgxK0pkSFpUdnFUemx3YTY5Vm4zYUtVRVdmc0F0?=
 =?utf-8?B?V25ld20ybTJIOXIvUjRtVGhDTTdkdStZY0h4ZTZaRk9SQ2k2eG5LV05lL05M?=
 =?utf-8?B?MnY5MVhpS3ZTR0ZiM0E3bGtHUHVHUlhwTmIzR2xLQTdGeXUzMU4zWG15WDNp?=
 =?utf-8?B?RzVGTktibUpFLzNkTTI4U05KR1pCTndBU0xhNW9PK0ZEY1dzNlNQdkFaZGwr?=
 =?utf-8?B?YVFOcDROVTFocDR5a2doWHFQZFF3OGhMSlEwU3QyQ3NGV0RNMzhpKy96NitD?=
 =?utf-8?B?QXBscFExME5kVWYrbXFzMXFTbzd5RU9MY0tqZUVpbjBMWmFiTW1xakcyYXUz?=
 =?utf-8?B?MldZUXNJaVcxZkxNTnpNVkFQMkJuMmNUcndhbzBGUWFpNDM1eEo2cGdzYldM?=
 =?utf-8?B?TklmTk9Jb2ZjeWgyek5iK2w0a1VhYWlDd3RKRUk4eHhoajFkM0FvWlZwbWh5?=
 =?utf-8?B?c2tVcXlTcWhhejVBUDZZbGlLRWVVMHVReXRBa3ZBbXpNL21PMW9nbW5ZNWdt?=
 =?utf-8?B?UVp2N2tCZGdMVHRjMUI5THE1ZEdiZjlUdnRhdnlGaFE1YkxEUWhmVEplNERS?=
 =?utf-8?B?MDJ2UVF6WCs4ZGRZQngyUTM3Z3FJdUJTTStYMGxOd1VtMktoK0pZL21YMmEv?=
 =?utf-8?B?cHpZN3ZUUlhkNWQ5by9uT3JoRU9RcWIxVmdhK2h2eXByMGdWRFpjRHJrZzNN?=
 =?utf-8?B?MVYyblNSeCtuayt5aUtwZ1l6ZHlGaFdFOXc3Y05ESHR4Tmk5QTdLZC9Ed1F6?=
 =?utf-8?B?NWt6dzFZZ0pCRHJUNDFsbUNFTVNucW1KMnpncjJoR1N3TnY4cGdyL2FwQmRR?=
 =?utf-8?B?emZoMnlReE9pcVBSUHZLTjB4MU00Y0dhVStKSzQ2bnIxMkZrb1BYVHBINWpx?=
 =?utf-8?B?YmFWalpIQlV3TU15YXNDdnlYVG1SVFFCdDFyR25OMnFEd29uVUtKVjJ4UUMx?=
 =?utf-8?B?cHZVL3MrWFBZN2FKclBsU3g3dk1BR0lWYm1MSzdxblBWejZQVEtUaCtTQ0tr?=
 =?utf-8?B?cFp4QW1UeElIV1V6R25sTFZBTkR5L3dLblA4U0p1ZERkenpkSEdqaWlZWW1R?=
 =?utf-8?B?eGp5eTVoQzBUVTlESi9lUlRQamRzVFkyYTV0MzFsMmw2U3ZQK051c200NjNy?=
 =?utf-8?B?YjRTUlpBN3RDNmxYei9PbnMrSmI4L0pVNlVNUHNuR2NGZlRBOTZJSUluVUlR?=
 =?utf-8?B?ek5wNlZLZ3N2NDhqSjgxTm5sMVY0ckU2TzI0c3J1R2dzbkhyV1NsRitYL1li?=
 =?utf-8?B?b0tKRFpoa1VaeExWNW8yaGJnNHowc1djaUNyQnllZi9qLzBUblNqak5Zd3RG?=
 =?utf-8?B?OGt3aDN4NTJtM1NkR0F5bDZKT1ZtRU0yd0pJc0ZJSDdaUnFrWlA0STRMd2hY?=
 =?utf-8?B?cXJiS0RwN21Ta05NdjQxUUtLdERWYm9zQXdQeWFncHY1cFY3YUx4Y2FkZE9N?=
 =?utf-8?B?OWFML1pCaHBORFFEWTI2S056eW1FamI5VXkzQ3J1T2RjVVdlbllDdG1IYjdj?=
 =?utf-8?B?VkNUcjdkWmcrNkswZngvcldEYzhvNnQyTyswNWxha29ZUGRPR3ZmU2JVMTFh?=
 =?utf-8?B?TVRMMWlka1dDc0hza05sekJjWE9vc3FYUkdKU2UwSUpyUElvcmIxMzJDQ2RB?=
 =?utf-8?B?cVhOTVd6elJtUmN4Wk9JTTgrR0dPYmlVMytaUVU0Z3FCWmhkczc3THFwdHlR?=
 =?utf-8?B?dTlHNVF5TzBFdDF6T2FIcVN1QmlrSHNXMTNYc2JYNlhGS3pqMDRKVDR2T0Ji?=
 =?utf-8?B?QU9XN3BTMFd5Um1GWDdSL0hSWHE3d09MTlJjK1F4bVNSTDRET0ZXQUIvbmZK?=
 =?utf-8?B?cUh0RHBmd3g4ZW5ZZDJVZDhwYnlBY3VFejYzTUpaOGhpL3pjUnA0Slh3YnZW?=
 =?utf-8?B?TWdlTm9kaUZ3aU9pZktHc3RyUllsa2FVb0JsZTJxRUMxYTIydFdTVXJvU1pH?=
 =?utf-8?B?YXFqY3NlUVZYYzdFL1BKOFA3WDk4TkR0K0x5RjN5eU9aeDhnN0lMREFsb0Za?=
 =?utf-8?B?c3pJclNndU4zU2dkMlRjbGZLK1d0NXRHQUF4Ym5rRFlFcUphMWgxNWRNVjZr?=
 =?utf-8?B?eGRQd28vQTVKWFh3bjFvU3dITHgzR09nSG8vVE9LRDlLYlVPUmxRS2VJeWd4?=
 =?utf-8?B?VnFFb3pSOG95VmNTejZFMmdrUHZkdEx3dENoaThyaUhQTlJ1MmF5REdUaDRi?=
 =?utf-8?B?OEpic3RsRXlTZkRZa2RGMHJRL2kyVlpxYnY3KytPRkZOT0FTWWNpdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 985463cf-c549-459f-de95-08df364af860
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 05:59:33.3325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mDKe8a9kHUX9wVJdzzNd2Fic0HZzp2bKvPZ/wkASph4HhtO98Yh6Sy5AEJ0FLBJQC8ILvjxsQsrinGFezDnMNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB9051
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 30 Oct 2026 05:59:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24581

On 29.10.26 02:44, alexander.heinisch@siemens.com wrote:
> From: Alexander Heinisch <alexander.heinisch@siemens.com>
> 
> Added a helper script that unpacks a pre-existing .swu file signs
> the sw-description using a custom signer script and repackages
> the swu file including the newly created signed sw-description.sig
> 
> The script interface is:
>     sign-swu.sh [OPTIONS] SWU_FILE [-- SIGNER_SCRIPT [SIGNER_ARGS...]]
> 
> where the SIGNER_SCRIPT interface follows:
>     SIGNER_SCRIPT [SIGNER_ARGS...] SIGNEE SIGNED
> 
> SIGNEE and SIGNED are provided by sign-swu.sh
> 
> Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
> ---
>  scripts/sign-swu.sh | 128 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 128 insertions(+)
>  create mode 100755 scripts/sign-swu.sh
> 
> diff --git a/scripts/sign-swu.sh b/scripts/sign-swu.sh
> new file mode 100755
> index 00000000..9e418cb5
> --- /dev/null
> +++ b/scripts/sign-swu.sh
> @@ -0,0 +1,128 @@
> +#!/bin/bash
> +#
> +# Copyright (c) Siemens AG, 2026
> +#
> +# Authors:
> +#  Alexander Heinisch <alexander.heinisch@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +set -euo pipefail
> +
> +script_dir=$(dirname "$(readlink -f "$0")")
> +default_signer_script="${script_dir}/../recipes-devtools/swupdate-signer/files/sign-swu-cms"
> +default_signer_args=(
> +  -k "${script_dir}/../recipes-devtools/swupdate-certificates/files/trixie/PkKek-1-snakeoil.key"
> +  -c "${script_dir}/../recipes-devtools/swupdate-certificates/files/trixie/PkKek-1-snakeoil.pem"

"trixie" will eventually be outdated, and I bet we will miss this
reference here. Any chance to use something more flexible as default?

> +)
> +
> +usage() {
> +  cat << EOF
> +Usage: ${0##*/} [OPTIONS] SWU_FILE [-- SIGNER_SCRIPT [SIGNER_ARGS...]]
> +
> +Sign the sw-description of an SWU image and repack it.
> +
> +Arguments:
> +  SWU_FILE                SWU image to sign.
> +  SIGNER_SCRIPT           Signer script to use. It is invoked as
> +                            SIGNER_SCRIPT [SIGNER_ARGS...] SIGNEE SIGNED
> +                          and has to write the signature of SIGNEE to SIGNED.
> +                          Defaults to: "${default_signer_script}"
> +  SIGNER_ARGS             Additional arguments passed to SIGNER_SCRIPT.
> +                          Defaults to: "${default_signer_args[*]}"
> +
> +Options:
> +  -o, --output FILE       Write the signed image to FILE. Defaults to SWU_FILE
> +                          with .swu replaced by .signed.swu.
> +  -h, --help              Show this help and exit.
> +EOF
> +}
> +
> +bail_out() {
> +  echo "error: $1" >&2
> +  usage >&2
> +  exit 1
> +}
> +
> +swu_file=""
> +output_file=""
> +signer_cmd=()
> +
> +while [[ $# -gt 0 ]]; do
> +  case "$1" in
> +    -h|--help)
> +      usage
> +      exit 0
> +      ;;
> +    -o|--output)
> +      [[ $# -ge 2 ]] || bail_out "$1 requires an argument"
> +      output_file="$2"
> +      shift 2
> +      ;;
> +    --)
> +      shift
> +      signer_cmd=("$@")
> +      break
> +      ;;
> +    -*)
> +      bail_out "unknown option: $1"
> +      ;;
> +    *)
> +      [[ -z "${swu_file}" ]] || bail_out "only one SWU_FILE may be given"
> +      swu_file="$1"
> +      shift
> +      ;;
> +  esac
> +done
> +
> +if [[ -z "${swu_file}" ]]; then
> +  bail_out "no SWU file given"
> +fi
> +
> +if [[ ! -f "${swu_file}" ]]; then
> +  bail_out "SWU file not found: ${swu_file}"
> +fi
> +
> +swu_file=$(readlink -f "${swu_file}")
> +output_file=$(readlink -m "${output_file:-${swu_file%.swu}.signed.swu}")
> +
> +if [[ ${#signer_cmd[@]} -eq 0 ]]; then
> +  signer_cmd=("${default_signer_script}" "${default_signer_args[@]}")
> +fi
> +
> +# Here the actual work starts
> +# 1. extract the $swu_file
> +# 2. sign it and
> +# 3. repack it to $output_file
> +
> +workdir=$(mktemp -d)
> +trap 'rm -rf "${workdir}"' EXIT
> +
> +extracted="${workdir}/extracted"
> +mkdir "${extracted}"
> +(cd "${extracted}" && cpio --extract --quiet --no-absolute-filenames < "${swu_file}")
> +
> +if [[ ! -f "${extracted}/sw-description" ]]; then
> +  bail_out "no sw-description found in SWU image"
> +fi
> +
> +"${signer_cmd[@]}" "${extracted}/sw-description" "${extracted}/sw-description.sig"
> +
> +if [[ ! -s "${extracted}/sw-description.sig" ]]; then
> +  bail_out "signer did not produce a signature"
> +fi
> +
> +# Only replace the output file once the image is complete.
> +(
> +  cd "${extracted}"
> +  {
> +    echo sw-description
> +    echo sw-description.sig
> +    # Keep the order of the remaining files from the original image.
> +    cpio --list --quiet < "${swu_file}" \
> +      | grep -vx -e sw-description -e sw-description.sig
> +  } | cpio --quiet --owner 0:0 --dereference --create --reproducible --format=crc
> +) > "${workdir}/signed.swu"
> +mv -f "${workdir}/signed.swu" "${output_file}"
> +echo "signed image written to ${output_file}"

This scripts is just lying around now in a folder and has no reference
in any documents. This should be fixed.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
