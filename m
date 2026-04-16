Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD88F8D755
	for <webhook@archiver.kernel.org>; Thu, 16 Apr 2026 14:35:27 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.36])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15772.1776350126036752416
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Apr 2026 07:35:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=UAZ2+PD+;
 spf=pass (domain: siemens.com, ip: 52.101.65.36, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=loWa0eePOguRqJGWAxutqkuRAoXvqKxA3Hs5y0M0NoD9yZxdLW9xuCHkiDLdLyoNQlzFPiwF6mvDt2b95hMFMa/5aTgAJI5HmK02ZnGosmP8aqDCYHYEoOzg11uXmJkJUA37ZG+c58TyM6bjYURm79XHgZVrtVVjgghWZubLCGDog+R8ESqDibu4BJmuhDPNIL3L2Nf9+Rrt6yIF4ubnj/jknUn+I97+G5f2QGA8+T6HTB7RK71DueUP1D2FBtOxrOinhu2Cb7h334hRGjD7aA4OT7VC3TIJ8H7AfaDFONKhA6qXyPmx7N6FavTxft8XLgEd//8WNlo4nd7jGmPwwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vsh1kPgbI32slZEHXTS7cGxhisxQi11FdwP8tqniSRg=;
 b=AmTIJvnfGYFAtcwnslUyaWqZgqwP77eFcX1OhUJa8bWnl/9uDutZ20JzTzjEL7MfRc2lGEeHCtilLbV83fzXIxhSyEVCeIwh+vYYlCgrUX4QoPsKqrlZGJ/1b0wLuXqosQlRPiikWz4tQPDkGzjGTAYjrdVdo01oM18G5RSMS6wh51jdbT38k+85AH3IKAMKWO5X+NcTMHUFu57nchu/XKPtC02z2BWyfSG30zqbUWBQw0gRtHnHpUZKZRL1HAgtG8NOogEHfaAmGKx55LTt+6U0y6ldjJMRzho+ls1MFZz0YoZPphoNPw99lrP15oHVD9SsZ8SpsmN3VpRLutGLTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vsh1kPgbI32slZEHXTS7cGxhisxQi11FdwP8tqniSRg=;
 b=UAZ2+PD+eFRx/xXFgbbaMJYJe03oCxFMDvayYlCsGNE0//0OpVnTUbS20duF1pFCQVF6PKKEq/CWWRDuhFFJY47iTXaPWGw6xikMEJGfCUM8n92PrmLkh2CKCxe3y4EqH5/HKpaLGQpNo0Q/XZx+nK3to8sJ0UFEFAuW1Nbc7ujgWzZ2xW8g2BGWYXoWLDzUW06dlpwV31CIIvkPpMsc+Sbh8z7A/C12KTV/sAs4HNpldbMRlK37rxhoG1bL+dGaXukdPb0GOW6oPmKPI82zoGt4jRvjQzudRPxwUjQQvExr3DneEqpgJJsqhrOPPUFXCKIlb5pIvi/i3mwyffRJig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB6914.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:30d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 16 Apr
 2026 14:35:21 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9769.046; Thu, 16 Apr 2026
 14:35:21 +0000
Message-ID: <291aad79-9d66-4fd2-a0e6-820285129ee6@siemens.com>
Date: Thu, 16 Apr 2026 16:35:16 +0200
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
X-ClientProxiedBy: BLAPR05CA0036.namprd05.prod.outlook.com
 (2603:10b6:208:335::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB6914:EE_
X-MS-Office365-Filtering-Correlation-Id: f4a91639-d4b4-4b14-2f83-08de9bc5633c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|22082099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	p7tfPZib7mfX5Q1Cm2TGk6r4ZtnYURbtTT/OuD5KYv/D7Kcx5F+HHdOJG7kQuG3J7Rluv/jPBvsC9jZFfjXqpcpJ8IZvFJfzE8ndOgSSz6zttytYZhLPdK46jTIVRCq5ChbLoujtO+1XiBPdMn6QISjCM4BTuhQssjk1FJ7d+EADccb+XaKumbj7VuJgi2ApItvlV5+e0ebYlxJxwerlluJHHHL5MeeVRwqcvp3KwsBrDBFLkGlOZe0UpeIMppzgZqi6rCGpxBu3KFvN1z/VCo11ISrMD+uVC3Z7COYjBJDRqv48GYB/Y9Ifnluven7zIj67qGBZT+cxA7VGy9FhbCGPF8f2JHQQNTOWsofOAomCiDBu82AJ7FnwVC0ixRi5rGIW3DBams2PqSjGGgerT5HMLeJau7LqPEazZmrqJp6DDD485yhjwKlU8gMJTAgRNFZVl9gSGuwqUaqnzcns6vVIZAF5RQrvHKgft3JkvdTjpNlTE7to1LIR1Vbnu2C/Y4Bgnp3+rIP4uP0whNsBVeBISjWBjSzUpYlpW7/r4jXbKVUl4u+VHWEqpymVuny787JPjPL+KgThRJ1HoAeS0fHEFoVheU5D5EtRPwYDimS+ty8+A7N2a1f9P9kKGZCtDiRwtE2fbFdvMwHD08UN6mhVmw28Lek+dJnBg6xRJBNyU7DIG7E7C6IQTne2yoAevMos8bcc+sw9vOm0AZSVeHNQhnfshFQj35kRVMU+sd0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YS90Z0R3T0t1ZDZjQ21hNE5aaFc5SVNpbDNRSzdLNExQRm1RU3ZEdGpoZmF0?=
 =?utf-8?B?eUZyWkE0bjN3dzE3U0F4T0dBUE5GVElidnpSb2xGclBjTFRyYWtIR1BEbGNn?=
 =?utf-8?B?QUV4MldCL1Y4bVhlUEZoWFBRekVaSzRDQnRadGpidkU1R0tHc3hYNVgzdGFx?=
 =?utf-8?B?ZGM5d3lvdHlLN3ZKdDdPd2JWdzhEUFdsc295dEdiWG9jMmNwSWNKNk5ReUp0?=
 =?utf-8?B?ZGRRam0zUGtzcWVwYlZLSnZoR095QWJ6TGZCWHpzL0pJUEp3R1pNMTdSU2lG?=
 =?utf-8?B?VUhUUGhMeTMzZlBBSytZY0I4ckFFcDZUUVJpMHp1c3ZadnoxUDZBckdob2Rr?=
 =?utf-8?B?RXExWGV6L0xrMnp0WkJKajkwTldWaVV3UUtYM1lEVmRjdHFkcFl1VWhmRS9G?=
 =?utf-8?B?eHIxSEYzaENLb3pnYlROQWdKTU15Q0o2N1B4R0o2Y2FhMWxLRDVGZVlpcXFR?=
 =?utf-8?B?MkZVWXg0UU92a2JvNkdlcWRtMjlQQjY2THJWaG9PbU9UTUJPQkk2cm9YNHZM?=
 =?utf-8?B?SG1IWk0yam1xa3ljU2RqV0w5cFhma1dpc0lJQmoyaHM3NGI0dHZzV2lKall3?=
 =?utf-8?B?RHlGVS9BejM2M0VpMHp4TjE3Z3hGUWJDdm1RUjV4c0NXM3NVRTgyeGdyRmhZ?=
 =?utf-8?B?QW4rSUExN2dNcVVTWmhiY2krdkEydDBFWkxjL1phZkZpZ2hiczM0STJsS2dN?=
 =?utf-8?B?TlJzeW5qbWNlQVljM2pTK3ZwdEhUWTJ5azYxQnBjTENBRFluU1BOM2o5ekls?=
 =?utf-8?B?RUZHV2dYMW9NZXRMVlpLWlJ4OHozZEpIVW12UVpKcytMcmRKVnBOY3ZvdUhq?=
 =?utf-8?B?ZjZBYlZVdEJlVmM0dTVQcGRzenlMWFU2S01GTTRMRWYyaHdydCt5bjlRUWhJ?=
 =?utf-8?B?QlZobFVhbmVmMnUwWUxEMllybFhtN2V2UDNrNDkxcklBMlE1UHpSS3NJUkxE?=
 =?utf-8?B?ZjJkOElWelRkZFZnWkhpL2ZrVEFEWTlQNGN2S1RKYjVVc0lxYk40dW1JaWw0?=
 =?utf-8?B?Vm1HVVVtZXJtN3FxK3o0SkJPVlprejFmWDdwcmpybVl1cVRuS3dzNUVnRjdH?=
 =?utf-8?B?dTdqQWFmUDcrSTBaZ1pwUDM0cTJrT0Noc2VsTWJhQXZpUU44RmhJY2Y3cUNM?=
 =?utf-8?B?WjlPUWJlcUwxYi9kSzZ2ZktuNG5XdTVUWDczTFpuQlEraEl4Yjcya0dXaVo3?=
 =?utf-8?B?Wkp1WFhLVll2aG5QQ2FkU21QMjJlU0hlejBlZmpRWW1aMnlaT0VuT2FjR21I?=
 =?utf-8?B?NkQzSWRTSHBRVkQvUGJ2dy9UZXFNNksvQXdQcGZhSU4yNWNwOCtUK09YMFRJ?=
 =?utf-8?B?c2tscTdhS2c0NU5BN3U1NFppOXFuK0VtV2N6eWZqaWhUcG15OHBFaXVBb1dz?=
 =?utf-8?B?Unp5L1EzVk9EVXU2Nm1PY0Q2OEhuaEVzalRxbXdXbG1YZTdvSTFaQVpWRGpR?=
 =?utf-8?B?eU9MMzgxYndzcFBUZjVrWURSYmc2Z3ROZVJkODBmWGIzVVViY0tUa0l2SWlx?=
 =?utf-8?B?ZlRoSnpJRFh1SjAzYUJLZ3hVMzE4ZGdiaXJXK2pwNURpaWxQcHNVdWp4R2E5?=
 =?utf-8?B?dndCN3diOWgrTkR0UHU4LzQzY3ZSY0FOTGphK2lIaStpUy9LUGpEQW5RQ3dV?=
 =?utf-8?B?cjhlb0VQTzl4cUVCMmpXUUR2NVlGZFIybW9JckwrSW5XNHdWbzlWcU16MDNV?=
 =?utf-8?B?eG5EdnEzUE1JRktwYmhsM1gzUE5VMFQxSkpaNUxxVk1pVC9jQlFSSkVray8z?=
 =?utf-8?B?UmhWb013bnlNWTR4NS94djJzTXNnTVgybUZUd1lkaGtzaGJYVlo4R0dNTzBO?=
 =?utf-8?B?WGN6Q3pGM3VKNndyWC9mY2dHaFZsZkI0UFRzRk9YcEVGYVcydS9hWnJVaFhC?=
 =?utf-8?B?cVhJc1Z2YldUc3JWN01pNHlPV3VtWk9wQmZhZmZ1bU9sU084REFZRENkWmRY?=
 =?utf-8?B?cnhwclZmRXlEMXBRT080NjNRaHNLWnVSVXk2b3gyUHFxSnZvRGxoYXBRdDlW?=
 =?utf-8?B?KzV6QXArYTJ3MGpyL2Z5aFowMHUxN2pHTlRWcy9obUM1RVErWll0VElXdXlx?=
 =?utf-8?B?Y0txWFF4SlRrVGlTRkIrODRyZnNmdi8zSDJ5ZEw2MURPVFFVcGwxQytBMmZF?=
 =?utf-8?B?ZWpuTWdQejJkNVlMYzR3REl1SXNhQzhHME5LRlZyQ3hLcUZzUmdxbU5TaS81?=
 =?utf-8?B?MGFMN3l2RU04VFRyNzJySzNhRlJ5RC9ubmFpT2tVSUdhVDVkL0V3T1dDcnJG?=
 =?utf-8?B?TXlnckdyMFh2K2RLdVN2dStsZVFNUXhnNnQzeG9iQXJYMllXcWQ0YUNGWnZJ?=
 =?utf-8?B?SExPTU1jM2c2S1YxNDhPSXVNWkk0QjVkZ0JQZ2tzeEo4UE9pZXBQKy9NOW5r?=
 =?utf-8?Q?FFshFSwLO2KVy1lU=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4a91639-d4b4-4b14-2f83-08de9bc5633c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 14:35:21.2827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yqfe5GcKo9seWOzPNtGER6eX5VFp5gb3WrLXVTmZ2cWYEZqdzsoPU06U/+fz/uBfzP1YeFHASFJXbpOkzWiVWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6914
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Apr 2026 14:35:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22745

On 25.03.26 13:25, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This avoids errors due to overwrites from followup jobs.
> 
> This change requires a clean up in the storage backend(e.g. S3) to avoid
> storing outdated build artifacts.
> 
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

Thanks, applied now. Please clean up the storage eventually.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

