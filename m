Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E262B109C026
	for <webhook@archiver.kernel.org>; Wed, 25 Mar 2026 14:40:27 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.1])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23857.1774449625517593996
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Mar 2026 07:40:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=AbLT35Ta;
 spf=pass (domain: siemens.com, ip: 52.101.84.1, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vmOBDQLdU/2VbctlmoVGfjXipUXqm48R6hnUNrlapDdz6ALT0s9p4gZmITMIqDO7T1tzz1mymGOcQwz2v0y2hHb5C8FPN1ZbOTWccKsSt1ZCa4vqXjh/922IKZLuadlsJ/A71RgS/heiSW26oJiGvwijDYtd+eXt99CgxkS+lGE1dWpXmCNutM3baa9b2B8fHtRQoBRWfMrWL9jNc6RSFn41fLBTgsAdV4uba/cqrlWgv9HO/SKxf41SEVyNwlU3TpvOoqD26dFY59yzVCQvQ0ArEwwhOTVacR4Z/Wn0VMBv9ot3GgnpfvoWpudH81HT+MBkazffbook5S5fqLKiPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6SzKA5NBAQrNe+GbgOOpPdXqeYdjz1sPYa4PR1KJw0o=;
 b=MF8/4oX/M5Kn9NldywOrUgzSle6bXT/ezjJcFHGxHTeU+7t490L1I0zDdbc+G0/4q3o1fmPbSVXTTfkN7dDE7LbNyajwo7FKVFOygDSoUdmwvV8f3LHBEXE+bjvIhCsBdwvEeEOfVl64AEDkqlFIVLRAa7fE84cS42ANFOputNJV+L/keDk+0bzrlXQUbbzKcqxZqhuIcUUt89cYml7Cln6CYoj7MylqjGMRoVoqaPUU3LaaS2vJJ7BYUScfK66NcYSv2PvyKa3Ta9kDyDfAlodpzN95G87khYiiPeiWLf21W76ATCNIOyd+GUbLS5zrTAeJoFZf3DZnMxOjLc2dXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6SzKA5NBAQrNe+GbgOOpPdXqeYdjz1sPYa4PR1KJw0o=;
 b=AbLT35TaOEtaAJkPUuWBUq/eOG6XxhRavx8mTjCq+0/5fETmlVHZQEistb8w+Q8Dw+wjtlDfdT6v6QjyyD8vlMN9os3FF75Sc2TdQIgqQ2v0HXXaWCuMFkjZVhcssG4hhrJ3S3Bd6MPJCMvuW9XT5CWiqtWHPlZpkjpnBUZOJofs/jZUAQvcYZB3fvmMwVBbU4f5bANUEyS+gglxFazqp19gg9UZJ0i+WpPe3NvvC8cDiC01JlLwEC16UrBooseR+8ErEiDcIqd1luXVuoSES4u5yHQaoqiq6xuIsYRFXgIzZifWMWSWarlF8MlNOFGtV5V7yDIqLZ9FEyHIXUcBQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by PA2PR10MB8964.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:41f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Wed, 25 Mar
 2026 14:40:21 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9%5]) with mapi id 15.20.9723.030; Wed, 25 Mar 2026
 14:40:21 +0000
Message-ID: <100318a9-325d-4d1d-a2b4-36ba664ae048@siemens.com>
Date: Wed, 25 Mar 2026 15:40:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC cip-dev][isar-cip-core][PATCH] Use pipeline id instead of
 CI_COMMIT_REF_SLUG
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, chris.paterson2@renesas.com
References: <20260325122615.424136-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260325122615.424136-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0141.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::9) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|PA2PR10MB8964:EE_
X-MS-Office365-Filtering-Correlation-Id: 77fbb043-eb7d-47f0-1b17-08de8a7c70e0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	3j4pa79ZlQtcTNSQH0DdusjtS4EMvV3Xh2QFC5VTw/xD2DWVwpA17Iy7SAvvZt2Ig9dagSaHYoPDKuwE4l9a/Vq1ghgX4fbVwA1jcqkfnAqlOX4UnJc31iJGyk4l5GmM+29pr0W2VQQCo0IqsXeC866S2hCrABOxVL19wH4fNnwce/ql5qBy5hvd8RI8aB1/zT5dHlCsvr7HMM90GbNG4NTIgVxCwlpBsxxoItzmQwfNwrdHIZij2aRFbWudN14+GyzFzi4ugTPX6YiS3sE3TmJkYyEwy2lCZU6nrUFGgXfFG7D1L/k2Us9kVGDj2WkbiHTIiIWBCACZ0fQeGgezWPOFvSEbg3H7mDq0Qx0b1KAKP1jX5A1j6qK9HndwkBP8H7a3g+8QAzQKBHdNXb6yCvj16NwXV7UI8o1mZdqj2XLCaKXulCp9Yqd+KpubajkCEyHxPXqWtXrqQPGvZmkF/OrBLw2HuvjgGteVZf4b7YUK4okp5jkMs9BQlbEh1Q759I1FqufVoU8XjKToEWeAVYoThWwqDcuzj/XcztSzZkwA1Bu9yNUw6RdW3rBTVxFn23Xp7kETEGb05bLnoTHxdRbpxkgvvVrZKrcnnATp2bwKGHZUg+ofYJXaYybGmcsbC5/baG1Am/E0/Pj+AoRltYjc0bqRon56yZA7QAtrWP3aB4oX1P50b8lWbF7JhkZa6yK4XoTWafIigD6mlTyHES10z4JaVJ1EL+WPOZq3Pak=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dFZieFoyWjVGSkR5Vnd3eENTVGZGOUMxTERLRUtwaUw3MVlnZ2YyRHF3Zmdq?=
 =?utf-8?B?V0ZrNVYvVmNKNkRBSFJIaE5iSHJJV3RxNFpzdWhBSjMxcVd5a3FDUXJJN0Vt?=
 =?utf-8?B?bXdUQlhUcVJQbHVpNTQ2M2tib2dWV0pYa2NWZ05hREp0RVQ0RlhhYWtrZll4?=
 =?utf-8?B?RlVTWDkxTHdMbXFlN3JIbE1tRG9VdHJpak0yMXFrc29LN09NYkpRM0t2ZDRo?=
 =?utf-8?B?NnhhSWpqajc5Q0M5dUF1YlZtQStDcUx6eSt2bGt1RXZoMHBhNkx2VGRHNlBN?=
 =?utf-8?B?Q3hFYmx3dm9CTzB4ZnZBVkVWY2ZFektnQnRvcExBVVM1TkpoMUpuOUNHTnBl?=
 =?utf-8?B?OUpQMXBRd2JqQUFxTjBLcStoVUY5TjJVMFUydVNqbW5Nd240Q0M5MVZmbys3?=
 =?utf-8?B?MWFocjdoT2ZoNkNaVVpTNnlQVS9WODFxK3dndjc3R2pNVkxPcTVSREdBN3kz?=
 =?utf-8?B?Wm1sNUU0VnVxZFU5UWZuOXpjMzFOajBDNkY3T1lhUytBYjlXN0JtbHVKRTda?=
 =?utf-8?B?RkpmNnNFUmdPd25yR2NoeFFqUkdXUHkrSnBDMnZOek5UOHZib1AxSWppTFJl?=
 =?utf-8?B?aGlHdlYvTjhJQlNkR0R3UEJnY0dpK0wrdUg5eVNGd3ZoMHltYWtsaFNxUHJP?=
 =?utf-8?B?cGRVd2FPQXBUazN6T2tqeHR4SmNzb1cxdWd1d0VWajFBQWkycjlpT09oZjV0?=
 =?utf-8?B?YWlUWGU1WjAvR3VRbTk3TW9mYk85VEhrWUxISzBTeEZrUCtCb0dIWThEYTlx?=
 =?utf-8?B?SnhrT0FQbnBtWmRvTTBRZERNMTI1MzJqejB2cEVjWTdkcUZITkdDK25jeTFZ?=
 =?utf-8?B?aGJJWjZJczhjL05lWWpGcGxXUVNYSUVOdFhpSzQ5OEYzdFFTU1V4VTVaOGx3?=
 =?utf-8?B?ZDhHcXJyRlZCL2M2RnV1eENoNm0yVG1RU2hrYzYwK3BESC9pcDIvTkNqbmx0?=
 =?utf-8?B?bkxvL3pOcGd4emZ1OW1iV0VTUndtZ1NwTWhZd1lOQzJWRTFVZTNaeXJ0WFRM?=
 =?utf-8?B?MjV4V0V4RXJOZWZXMWhsaERrZG5rSjFHc2QvenFxb3Rta0k0VWc2SGUrOXVw?=
 =?utf-8?B?dDJIRkFSbytQZFFWM0hUaTN6WExqbUkrbHliZWFYNUtwUSt1dHlQUHVwQVdB?=
 =?utf-8?B?bVJxVTc4QXZ4eG9aMmZHb0dRREpvaWZaWFZmM1dNTVZxOEcyTjN3dEIrVWRq?=
 =?utf-8?B?dFhKdi80OS8vWWsxVVJUYlJlaGprcFBRb2lMRklYcGZlZDJNK0dUaXNpVWJP?=
 =?utf-8?B?SzZWbXZyNEpnYjB0ZDVnZjVFQ2NhZlAySnBWN3ZpTjNYSmdsbTVsQkExTUw4?=
 =?utf-8?B?SDZDK0FtZkdTRE5aajRHTmJDdzVNT3NPY1lTeUVycGREMHJVL0hkekhyN1FP?=
 =?utf-8?B?Nm1Ic0cyaTRCbm44eUZET1orMWpxb0RDOFpvSTRUS25maGtKU0gvcitReitI?=
 =?utf-8?B?QzRSM1VkcUVDQm9sVW1VdFdIcGVhTzhTcklCR2ZtbThuT0VYaW55UlBOeGVO?=
 =?utf-8?B?Q2RETmpTUmliNTZ3OVNnUVZpUDd3bWg0UXFPOFZsRWUzaFNuNHM5VEIydGUv?=
 =?utf-8?B?eXVrK2ZxU3RiM3lldzA4MDBtaTIxSE9XdzIxSCt6OThIL1dyUEFScVNnREtr?=
 =?utf-8?B?ampSbnc5UGFvRFdxMTI3akJDNkhhakRYU3NIdlVzYVpuSVFGUFh6djBxMzlU?=
 =?utf-8?B?R2tESzJuNWRsaGV3cTdwVE16MW94MkhSZjNoVFBRTlRtNDMrR0t3bVNzRU9E?=
 =?utf-8?B?dkdSWElQaitrellCY0h3aFFrOGZjZnRFSk1Fdm1vYVEzRjV6SmNBWVhWZzVx?=
 =?utf-8?B?NEFCRnJ5SW1GZzgwd0ZnR0d1cFNpL0tkYlY1dDJQNGpBRDhLMjlnQ0FRLy82?=
 =?utf-8?B?cWFwLytFY0M5bHh4aTJqUk9pVE45RFpYZ2NrRzVWa0dMcnlORzRDaDFuTXRR?=
 =?utf-8?B?OHh6NzlHWnhBV3YweGZXNjBwa09oaVdWdnJzb3lGMSswT1NJSTliYjU2L21Y?=
 =?utf-8?B?anUxc0ZsMXRLOTYrNDFLU3kxc2VWQmgvcDhPU0VJb2k0SC8wQlM1YVNDUFJn?=
 =?utf-8?B?U29TTnlhMXhGV1hMdXJJZU9uNWVoZm5Xd2NVSFk5ZXQ0cG1qejNrYU04K0Ev?=
 =?utf-8?B?UVV3YnZkd09URENBQU1mOUhldVJVNXNVbTkzRi91RGZ2cCtaRlRSRjlJS1dT?=
 =?utf-8?B?WU5DTjdzSXJxK0NpaXpyUzRESEoveWdLWlV6WVJjQXFMbVpia0lWRVVFNlVG?=
 =?utf-8?B?ZzF0R3lwVTcyRWt0YXZSU1hVSWR5QjVkWFVFZVlBc1BWdDZsS3FYNTBSa01D?=
 =?utf-8?B?Ny9sOU4wNThtaE5TeSszeVJZdUtPdjdjeFdoME4zeUR5K0dER1k3Zz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77fbb043-eb7d-47f0-1b17-08de8a7c70e0
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 14:40:21.0266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gx1h7gQ1Uc8ynSbEZQSP5jUQUNmO/WyyFOf98wsTZPhcAs6GJpeCW+vPFX+91EHXyBFr0m6qUPG0rdeh2rhJsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8964
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 25 Mar 2026 14:40:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22568

On 25.03.26 13:25, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This avoids errors due to overwrites from followup jobs.
> 
> This change requires a clean up in the storage backend(e.g. S3) to avoid
> storing outdated build artifacts.
> 

Who could do that, and how to coordinate that best with applying this patch?

Jan

> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .gitlab-ci.yml | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 602c503..75f0502 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -71,7 +71,7 @@ default:
>      - if [ "${no_kernel}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/no_kernel.yml:kas/opt/targz.yml"; fi
>      - echo "Building ${base_yaml}"
>      - kas build ${base_yaml}
> -    - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${no_kernel} ${dtb} ${CI_COMMIT_REF_SLUG} wic; fi
> +    - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${no_kernel} ${dtb} ${CI_PIPELINE_ID} wic; fi
>      - if [ "${build_updates}" = "enable" ]; then
>            mkdir build/previous-image;
>            if [ "${extension}" = "security" ] || [ "${extension}" = "ebg-secure-boot-snakeoil" ]; then
> @@ -90,7 +90,7 @@ default:
>            for swu in build/previous-image/*-broken.swu; do
>                mv "$swu" build/tmp/deploy/images/${target};
>            done;
> -          scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${no_kernel} ${dtb} ${CI_COMMIT_REF_SLUG} swus;
> +          scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${no_kernel} ${dtb} ${CI_PIPELINE_ID} swus;
>        fi
>  
>  # base image
> @@ -359,7 +359,7 @@ build:qemu-amd64-secure-boot-buster:
>    tags:
>      - small
>    script:
> -    - scripts/submit_lava.sh ${test_function} ${target} ${CI_COMMIT_SHORT_SHA} ${release} ${CI_COMMIT_REF_SLUG} ${iec_test_timeout}
> +    - scripts/submit_lava.sh ${test_function} ${target} ${CI_COMMIT_SHORT_SHA} ${release} ${CI_PIPELINE_ID} ${iec_test_timeout}
>    artifacts:
>      name: "$CI_JOB_NAME"
>      when: always

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

