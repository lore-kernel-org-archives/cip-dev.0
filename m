Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.55])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3319.1795170988771672995
 for <cip-dev@lists.cip-project.org>;
 Fri, 20 Nov 2026 02:36:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=eNdYMBeE;
 spf=pass (domain: siemens.com, ip: 52.101.69.55, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zPI0GWQiWTZSvaHHf3hZanDNAUAHVT9OWBDwBPu94O6i+TsaQvOThP093ujdmLYtXDbvrPnjR0og3uL5PFwNQbWj5B7IXHose8m62yCUtDebkqqievRkSHt6eHxIhktfrV6a73gUfmez61kl2lYAw7tV/k3lxFG/nVLmXfKZhdlYuNJqHhe0mUNpJGzlZW40Hx0zgOWlclwsOg3MVQZ6ghydVNNOSCA5RM9AV0cQFelW8Xwr8nhN23rlI27YTN5s/L0UQp27IAE2jOSqAVEfcgEWwNdIn95Yev5fvDOzfhHysDFsbJwy8mF1M4MDFSr6wUbu+OGrsPX4vBUUsy7+4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hT8a09iNDxjQyjjUGPiiDSPgZ/3h4jhikakOLgEmJT4=;
 b=l6CgZjwSpeBMp/aIgYIxkT4fQrKF9berJX7O30NseJspK3PT1e+MorbrhkptcCylnMQQulhox+m1lzLyUCUYh3S/XhOOoXt6Ug98DDSje2T+wO0uUUXJ/Hh4wNe+ZtPAD/hA3bY8V47sFHYfp3ZkGqM1337joj7RX/bAMM9Tqi/lUfLMXkjReLWjaO3rzWt97NXssYb1ZvNkBnNUZYEdb3XxkYM/JSWKQ71FNLCABlOxZhIpDvJu36P+VDkqD+0NAFFr/oodHpHEYVuA6InBp/rX/yLZGTPhRsXiOQCsOVPV7FCJWUlpZAmmlkFBxTDQSVaNK51XgGuim+D36ySbJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hT8a09iNDxjQyjjUGPiiDSPgZ/3h4jhikakOLgEmJT4=;
 b=eNdYMBeET+2SseqS9hR7NNxs7LAtpdXdzZ8cDZCeyA4Kts8UpseHfGRJkAbe1xBPyZdpMb2gP8ZkYKfVvLOPCQD+7UNQ5Wzna3+pBvNTux62eAEwsYJSWdnNqoJpx6+kMRah9wL9ObF5crYHYz2Z+ljFb2f/I0qGJEBUuYJ853P9lLw3+SdiVhTqhK5SpKPaYbTqzd9PIBsHbiL8hO9osr55Kgc5065pm5ppUn1pYB7qdx5KCY52wM9Mj7gvvnbe+u+ZnXKvQzorVObGov9othlmk3WhTAsjHin27TJDLb2WlWMKSYhiXZUtsQaWpVSGgx4TYQVdReYOjGood8PiJw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by DB8PR10MB3813.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:169::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.2; Fri, 20 Nov
 2026 10:36:24 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0662.000; Fri, 20 Nov 2026
 10:36:24 +0000
Message-ID: <c1209a46-3a87-47ef-929e-33b77caef9a6@siemens.com>
Date: Fri, 20 Nov 2026 11:36:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][RFC PATCH 1/8] scripts: use apt-get in
 run-cve-checks.sh
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: chris.paterson2@renesas.com, nobuhiro1.iwamatsu@toshiba.co.jp
References: <20261120082554.375548-1-quirin.gylstorff@siemens.com>
 <20261120082554.375548-2-quirin.gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20261120082554.375548-2-quirin.gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0012.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::20) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|DB8PR10MB3813:EE_
X-MS-Office365-Filtering-Correlation-Id: 95a379a9-4205-47a7-e6db-08df46f21fc5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|18002099003|22082099003|6133799003|55112099003|11063799006|4143699003|56012099006|10067099003|261021123027099003|261021121427099003|261009223027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: tt4pPd9sDW8LlfrNVcwICMrczX9fEnNURuer/3pIA7y+qzvR0eFO8AE86r7029YZGCOtCzgzKgsPg3l89qoETtXZIF3IQWBDDmmWJ0idpYotuS0x3gis+rIS6LPp0S/iwoa/BAi6+I81DE4oMAfGx2776LEEmwNk3c3Uewfu+7JbGhQTrWL20wgeBy7LIcRpY0a7Tfwnfg3ZLNWsaD1kn1Nkh0diBpmY+PAoKNHZpwFVU7BHa81IcK/vg/+YE3/crXIt4zJKOaurw5kr0HFXxhAMfhJw4Ya7XEjIj7KTYBCEtK9HZA0bkfFQqLdN0GFjx6rrwIPhmUgI1229pprsheI1y/0ehLJc4Xz0E9ABXBKl4yCvpYTJ/7kW9nl34IImXYUlz/HXB3UAmEjqF3VRxwWVGS2cBbdB+PxB8gLiC32rLEHfY2gsNgUzWL5XnO6u2VBvOQVoqze/weTDZp+buapfsOa8FM+lWsifhRZMYt28S/jOew9RW3Y8qKQ84lRxqoqHqkyCvAjVAapytE5xQGqwOBoJ+0a+9yVAt5815iyyjjjxnHd37Clt+G+3gEUhxunfTZJ++cZZczyv6ZKo7SBLMgp7L/nPz+6t9dNrUHdmDXAvWH+gnO5FN8cd8cKABibDjYZtGGLMy+Y82A9zBJ6d6A/B940cIYTCDApudvw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(6133799003)(55112099003)(11063799006)(4143699003)(56012099006)(10067099003)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dU9PaTlYMkxhNmVHNkJEc2h4QzlxdFFOWEx0UWlqYldyZFRsa0Y5NjUxWk11?=
 =?utf-8?B?OXRvU1lrc3VDcHp2UXh5MkpjWmtpRURaa1dIRHIzNWplWXh5eWZMRU00Mjhz?=
 =?utf-8?B?c1pHRFlFTGFUQVAxaG9tZ2Z5UkR1Sm9IL2JoK1JWbm56a3BXdU8xZXlDUkNt?=
 =?utf-8?B?aUpVVnBTLzJ3TWg1SjB2NmpSK3JIbTNzMlNReFY5cXBPMktaT05lOEorWWM4?=
 =?utf-8?B?UGtMOVVSelVCQnMwVzlFR21yVnNucDJwOFdGMnpFVSs2UDhzWW80QjIxSEpx?=
 =?utf-8?B?OUpBdmk0WE1mVXlKL1NBV0JHMzFDT2k1Yks4Rll0eXNDQU9xWUtEVXQ4cDhZ?=
 =?utf-8?B?aVU0NUZVa1JaUVh3dTQ5dHRFNUowVUR3M0tqSFFURHp5Z1RZY1pnaHhTUEJp?=
 =?utf-8?B?clFRUE5sMEVVSjlwSWNIS2YrNDE5eWl6T00wSVBrSkJqSTRySFJaRkpwK1VL?=
 =?utf-8?B?T0J4bytNQXBQcFF5VGpJd0ZMb2h6bHc2d0M0TmplK2tuRlBqUy83M0ZmN0hs?=
 =?utf-8?B?V2ViRGFWcFB0SFY0cFpXdFZRUWxRbi9oN1hnZlRPRjVoWWdWaGtSUWI2NDJn?=
 =?utf-8?B?eStxNmN3cWFjZ1ZUVVZ1NGFxUjdwVk83MzZwR0owUUx3TlRhUzFqWm5NYzVi?=
 =?utf-8?B?NzV6R1Fsb0ZIT051SjQ5L2pQcEFjOXVGZjBKTm5MNlNtMzRQOHNVTXpBYmc4?=
 =?utf-8?B?amFpeEppYW5yamRuUERVYTJVZisvVlNtQXVsaVFPbE9xdWl4OXR5d3Yyb0tW?=
 =?utf-8?B?aXVwclRoanNERDdScU9MTkF3V00vOEtqVXc5ekUySWZJQW1JaUttNmg1YWRD?=
 =?utf-8?B?a09SdFVIVWVOOEpQOE5abjkxRzJXL0F5cDcyZnBRdVk4NEtLMDhCUTM3NENO?=
 =?utf-8?B?ODN4ZzROWFN6VnVlbHllV2txS2JMcUpta1hUdEM5YXVFdkUwMXB4MjF3Wlhi?=
 =?utf-8?B?U3pyNnR0ZGFndHFZWlVmMnJsL3Z2TzYvZDVjdzNwZGJueGdEK1lLSGRoMWYz?=
 =?utf-8?B?SXV6Z1JYYkxhVGxEUWJ5aEhiT3p3OCtMTGdpQVhIREpqQzZnYUhLbEVQWjJy?=
 =?utf-8?B?MHZxK2hQVlc4cmlxUVQ5c2Q4L2QvZ0FYM1d3aFgxN0lrUis0L1RnQ1Zma1l0?=
 =?utf-8?B?RTdHSlVkZWxRaGNFeXF0cDZrMGM0YmxZSjFUM25OenhoOEpYdzFMNVNBRnVV?=
 =?utf-8?B?ek5GeWVxWS8wVzVHek9qZTU5b0YyV1RqeUxudlAxcDZYWVphM3VqaGZvY2RM?=
 =?utf-8?B?c3R5RStON3JKT21uMlUvRGt1Nm1TRmM0YjE2NVVqWlhISHVYVDVTL2ExWXZn?=
 =?utf-8?B?blNUSGRnWDh2UG1vekNOVUdCcVVKYnZzeHFnL2p4dkh3TTZHOXVpVm50ZXd3?=
 =?utf-8?B?eVlBbks3TTJYblROVmJ1enBFTmxMdlc2WlJHNFJYS0JJbkNHTFZjZlhhVmJu?=
 =?utf-8?B?cG85V2NlTmlySFNlcHVIZ1N5R3VvRTQ1WnpOcCt3V3k4WVNCeUFGM3djSmlF?=
 =?utf-8?B?dVBCczA2QTRydm9JcWFzTUN4cVZHNmQyL1piMVdxK2x1Yk1WZWlKdDBQYXJH?=
 =?utf-8?B?MGpkY2U1QmRIK2lHOWJxS253TnRaQnQ3MXRuS3F3azN6YjlrOVlCZHpCMUkx?=
 =?utf-8?B?aVRNQnhlbGsrNGtvL2xIV3VkVGEyTlJ5SlFsaFB3N1l5SitjOWdCUytDdWhM?=
 =?utf-8?B?S3FMRWh1NzZRM0RwWlFLdStOUEMwbCtkcHpQMVYwRzZmMjB0cXgwUis3RjlH?=
 =?utf-8?B?YmgrL1QvV2tPbmxaWkE5OUsvWVpiTC9wNTFCUmRZa096aGk1TUxmaEVGc1VR?=
 =?utf-8?B?RUNwcDAxSC9OVGRqdnBVQjg0bjgxMXNwcXhsTlBGZzMyM1Rvb0F2cHprZUtO?=
 =?utf-8?B?WTMwdHlkUThXc2NnbUllby9hbGRxbEp3U25CNUJYbmNZcUdJWDhuSS9kQmh3?=
 =?utf-8?B?OHZSeldJRHFLOGtRUVI1R2pVN0VIQmRhSXdvanNLMityU2JpT3pmN1VmVHpv?=
 =?utf-8?B?VmVicHl1SEMyK2t1RSs3MTBDdzRnSWt3NWp0UndQWkltN3l5S2ZnbiswYnRu?=
 =?utf-8?B?MmVTOWJHY0VtOXhWSis3ZzVSZ0c3b0VCd2tmbFVkNkFHMDgzNGorNE44UVQx?=
 =?utf-8?B?UVB5Z2hTQkU4OTFLK1o3elFROTFUZ1FDREtqcEhybS9IMEI1cTY4Tkl1V3Zm?=
 =?utf-8?B?Rm1SRDNzSUNZNlNaL0dwZDAvbi82M0NPMW56YWltTG9sQWRaL0NVeHZjczlS?=
 =?utf-8?B?K29JdUREaXUwcHk2blhLQWxTSU93VEZPOHdPRXhMM2JsWURWS1Y1OE5pdDRE?=
 =?utf-8?B?c2MwRDNtVS9NOURiL3dVM2VZSnhJT1ZGbTYyT3JySVhRV2g0SGlqZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95a379a9-4205-47a7-e6db-08df46f21fc5
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 10:36:24.0230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RrCVgScKWr4uoTNMTfOTIRYfA3k+xIBcfEPoILKFxZ/llJZNhrziLpTamfSXCgy5p5uTk2JJLLRp3QTrnyGaLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3813
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 20 Nov 2026 10:36:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25036

On 20.11.26 09:25, Quirin Gylstorff wrote:
> apt has no stable CLI interface for scripts. Use apt-get and install
> both packages in one call.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  scripts/run-cve-checks.sh | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/run-cve-checks.sh b/scripts/run-cve-checks.sh
> index 12fd74ee..12efcace 100755
> --- a/scripts/run-cve-checks.sh
> +++ b/scripts/run-cve-checks.sh
> @@ -20,9 +20,8 @@ set -e
>  # Install AWS CLI
>  if ! which aws >/dev/null 2>&1; then
>  	echo "Installing awscli..."
> -	apt update
> -	apt install -y python3-wheel
> -	apt install -y awscli
> +	apt-get update
> +	DEBIAN_FRONTEND=noninteractive apt-get install -y python3-wheel awscli
>  fi
>  
>  # Retrieve the latest dpkg status files from AWS

If I recall correctly, this job is in phase-out anyway. No one ported it
to trixie, and debsbom can generate something similar.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
