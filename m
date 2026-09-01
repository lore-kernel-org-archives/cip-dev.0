Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDBCC624CE
	for <webhook@archiver.kernel.org>; Tue,  1 Sep 2026 12:08:53 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6391.1788264530827809579
 for <cip-dev@lists.cip-project.org>;
 Tue, 01 Sep 2026 05:08:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ehJjNRt8;
 spf=pass (domain: siemens.com, ip: 52.101.84.4, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b6xlBTExBOIdVD69d5tXdZYF5b6s7YG1cxSIyr+62/IgCIoc/tWEma7ZmkTH1MJT6Tos6C50cgqkm9KKJGlCFuSEKK7NDTh1uKuagOCMrifu3de7Nx6TeZ9HhPWjHiZPn0n0EIgqxHczxUJbBpoF6DPV8jUlev+GObBlxuuVpdo9z+YDhMT8UV/qXVvTbBnkeiMPBPr7ip8TetkrKgGLBh2b2XRBgnyDQgDpXPFtX2iXX0xDEWoXQdDWF4vSjSeMkY2+YaLulA3qUINEbFj5PqQf1ki+KNVLvaF9ijk5QEcDac8ytteAabQN+aYZX2kAgmR/vGoI1iM+yPZGRo3Bag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KONb9FTf3vPASXj+mgGKhbHPKd8UQpMF9Gvf0mr1QHY=;
 b=T1FQEsmFhGP/kxqSjTeBuHbh+hhCYLVxC1Qr7B3aYpGKYV9/eYhBb2lVviTHnVoWvxseu6SkLK0xN5I4wg8loLUkH+JyKJ/B9noSYRAGmKvYzW1ClDfpSTf1d+RT8SgFJc9E/OvCZqZ5/n0O+vG4Gx4ex8i+wQ59N55Ly/5SlZB7AOjXhwk8WfmaJo54iw8dI0PaernlQnF2YFHrqmdmngpfgC1dA5qI3bTm7m+7qOyyFet2VQTwJ7LxM+iHc/eroWCA75E44BW9IWWZ6m4t9eFFJGo99d6v63qklv707k9nBucL/o/SSgAfZmlUBMiFvxSYKLs/1RS43ulhFG8ZqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KONb9FTf3vPASXj+mgGKhbHPKd8UQpMF9Gvf0mr1QHY=;
 b=ehJjNRt8c/hWkgNVKCul16cB56D2KsYgfrERxUcHa/hYkUwLZWft+CZ7qDp3g8zBnHBq+CgoGZw4N1j7sbtJ8McHCsaP3p2qQHPykqNDcUdaaeI3dU2kBNG9SzdasVrmCWHt/XXjGLG90FxUNCZo5Vc0vigGZApDjjnHL+RJ94H8jq/PkGTYrtuUqfEvVY4ohP0wtSx1iw1f2eP5dc32348MBK3wgBDbJjpBOAX+0qdIPuEFc+tJSQgGIulYxK2ukKVd8vQeOV8jcWKWHgRJYvDeddBdw1yQyvHiAlPUsb2S+5rjq0e/4D/C0+Gcm/2yZm8Y3oU8kxAnw4SGyVFY7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB7936.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:471::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 12:08:47 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 12:08:47 +0000
Message-ID: <b1136673-e247-4715-b272-00f76ca0776a@siemens.com>
Date: Tue, 1 Sep 2026 14:08:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core] ci: use kaniko to build lavacli container
To: Michael Adler <michael.adler@siemens.com>, cip-dev@lists.cip-project.org
References: <20260901120111.174696-1-michael.adler@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260901120111.174696-1-michael.adler@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0057.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB7936:EE_
X-MS-Office365-Filtering-Correlation-Id: f29a12e6-7b33-4e44-fb8c-08df0821c6a1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|6133799003|10067099003|11063799006|22082099003|18002099003|55112099003|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: 
	21+wIfAVDo/C5O+aD0RRMbFbp1pBm19SSH2lYwIkjHXb4KRsX35YSvSe3owPlk3hVsf7d8iUtiVshhlcY01eC0/R6WyEwC0NT20PhUrDazUvg8hrU9ar2ugpVBk0pR3F8MjyBxlgaLcj8RJGXhw4yh8DkMiqWTScxSccNTrh6FeynKxBSKOKmT4AyoG+iUOnVa/EyKWPqNTHpN0Y2m6YeGVv3QRC9yzHCnAFkuQGRrFodwCq47PxNtqewCLZkpjnLdrBizIPckHXWjAMOypgC6pvrJVqD04sTeFsAjwKGH8XMkKUVKX676AQoPTZlgRjr564E9zoTMOP94GQ5PAg4hbWZ0ETsgbfRbpuwwZajmvIdHYzgj4OyaCN07nHK227Izb0prNWvE1DbvhinK7glCt1nL1NpenhZQ++VrdfmxIz8Cbsx3nsZF2F56QBAAeicqH0cfOmbB0op63sqAfX7aN/9HIVdn38JWXLqI7LtvWDzlwPPNWhCSapNf7GPtwP0Unaadgw2RIv+Tq91A08Kl2CJmbIulMugf89+GwW7dWS7AcXb6lzZnYQNYJn931Zl6ZmmhWbbrzS+xkGAYL/4ojWXR1u2x+hcuM7pKyYbM2aGSjzW9EMjVfC17mckyUT
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(10067099003)(11063799006)(22082099003)(18002099003)(55112099003)(56012099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NTc3MHZGMnEzQ1hDTFpOSklkVVdCN2RjMjF2cHluRVl2WU1oOHg2VFZPQkJa?=
 =?utf-8?B?VklISjVyNlcwR3lYeitPaFhDOUx4OGUvaDhxU2FjcDZGMFFpTXpYSkliUmY5?=
 =?utf-8?B?SEJIZGRQbWg3UFQyb1FBTHRYOVU1SFlvdWRWT1RrK2IyTzZrVFBRUldSbVR4?=
 =?utf-8?B?bnBlMzAwL3lFbTdTaGR2bll3YmhKY3ZWa2VPYWtubnhLdXNyMk13dDJQS2Zq?=
 =?utf-8?B?SGNuTnRTUUFaOFdNOXFlR3VZTFF1aHk3KzFWQmlNcWFoZGw0clYrZ3BHQXNZ?=
 =?utf-8?B?ZVlPeG53b3h4NGh0K0lnN0U2TFArM3h2c3pGL0t5OFpvVXgwOEVnZDVUMHRt?=
 =?utf-8?B?YWZxUGk2OGh6Y21TeDFGdUtVMU1TMjlFTmFZbk5GeVRSaWFUdUtCVGZScDRM?=
 =?utf-8?B?YjZsZEdvQjJtaGFQK1VQVXJrdnBkdWJkYnROMFpKTXlDNmxjWUF2b3RmQkVY?=
 =?utf-8?B?Wk1DdVFsTlVWMWZ6Y1ZObjdRek9HT2JibmIxZlAvNkxjWDRXK3h0UkY1NWtO?=
 =?utf-8?B?OTRFOXNUTWp3UlMrdStsWStlVVNtdHlyblo1bm9JN2tkMGRlQ1dDb09xK21h?=
 =?utf-8?B?M2MyeGxUMmhkekxzeGM2czl1MGl1SnU2VUdzbk5zRGFOb015Ylh5T1gwQVBD?=
 =?utf-8?B?VEVvQnhOQlc0U05iSm1GVjFGbnF0TjJGbGUwZjU5Qjhha0dBNkIrSHNzRnlK?=
 =?utf-8?B?eDJRYWV6R0JQeDJwU1A0c1hYeGkrL0tudHpRbDU1TEx6TWFwVW51OUNCYXpr?=
 =?utf-8?B?eFlwOTZSRUdGSVJYcUEzYlFLNm0wQ3lHMUdsNVg1L0pLcGJ0TEMxRUJoQzVz?=
 =?utf-8?B?LzA0VFRnVTJON1dTZElzamFxVHRFOThpbXVqYkh6azVSUlplM2RYeVhmTkpl?=
 =?utf-8?B?UCtrSG1IMFk4MnNvSG9Za0Z4ZEhTb0E5NnYzWU50TlgxMVlZTXFmSjFkWDQ3?=
 =?utf-8?B?YW0ya0hPaTcxbTlTZ3JjVWRIZkg0LzNncVQxd04vY013eVRVOFNObWh5bmtW?=
 =?utf-8?B?dkpUKzM5TjBUWXJranVGcVJhZXc2cU9MOVNwd0pqTUJaenF6NG5wRFdqSTBz?=
 =?utf-8?B?dmVzRjMwRi9WWWkyOVNCRk9mWnZ2aEtqT1VwaWdpZHA4M1pxZHN4SURYci9S?=
 =?utf-8?B?aTlaS2I0TlB0MUordHFaYmthS3d0d3NvYWYrTEVlY2YwYmJoOU1kVm1JdTc3?=
 =?utf-8?B?SXAwNTRQbVYwWnhNRTU4Rk9vdXBHblBNZm1tRFZVTGJNK3dXZVdXODJQRmRC?=
 =?utf-8?B?aWJhSm43djRnaVduaEw2aHJHczFBTCtBZVdmSmgwTGNDNnEvZzdDUFRWR0xF?=
 =?utf-8?B?NHhNZlBDekdwMWVTVlBOOGNFMmJRNmFURzlzVVU3bXR6a21jVjFTRkVKcEFP?=
 =?utf-8?B?azMzRDc4eVEyWDdHVWExektxNis0eThnN0c0elRYWGp0aXVIRTZtbFFIN3Z1?=
 =?utf-8?B?MUQwSHpNQURYNlRSb2VvK3lMalNzZ2RxQUlKb2NET1c1Z0ptVEhJSlA0TC9i?=
 =?utf-8?B?eUtPV2V6bHgyZzAwc05QS3VRdzUzWlZSZFgraHVtcnZ2aTlLL1lWdEp6UXpF?=
 =?utf-8?B?aUZLYXBBVmFKbXphVk9RaXlWTG5hYVhGS1BUbWVIZC9WNndEeWdRaW04Nks4?=
 =?utf-8?B?aEE3RUUwQ3lZNGFLNDEvUUNvL0JkMXBMQzhHZXlibDVTNXVhUHZieEh5RFB3?=
 =?utf-8?B?L3p0UXlnbDY2QmM1anFNbFczMDhzNFNzZ0cvQzByNHJIdjRYcmQyQ05saUlw?=
 =?utf-8?B?R2tpMUR0eFlUT2lLalBTeW8weG5oMFU0SDZSUjF5ME1BOHp6YmxmSGY0UG5k?=
 =?utf-8?B?Y0FyNVkreW9YRUZKQnEvczJzRWlGS0JRRTQ0VEN4QWJrSU41NTYyWTRzN3pq?=
 =?utf-8?B?NlovL051MG1YWXM4MlVKNk5TV0xwQ3NadmorWmZ0TW5BUjVxM2xQS3Vob2FP?=
 =?utf-8?B?R1MzUkRBRWZRY2FzSWVCQ05sMkVCanFOSFhPL0l6bExPQ3N0eUxWdzVjbzlu?=
 =?utf-8?B?QVg1RkQxT3hyczgwT3VZMWVpaW5CaWNJTzdPL2piNTZXR2ZvNkp5QmpHMUdG?=
 =?utf-8?B?VzV0ZE5ZNHhWY3RGUlRIVm1uR2NpUzkzZFZVdmg4MitVOUFVQmcrdkg3ZGNo?=
 =?utf-8?B?T21TcFVWakxIRGdSSmRqaXZFL0owSXhCQ2xxdnorN29hc3BFNlJ1K1JPS2Fr?=
 =?utf-8?B?cUh0d1NmUkJLek4vOGs0YXI4WFFJMnJNdzMzdHZBL3RYQ3JFL3prT0xYQjhy?=
 =?utf-8?B?NWhOWEg2c3lnN1hNQy9ocHBCZVZzV3Foc09BOEpNOFRwdnZBNEdCcWJGVzBH?=
 =?utf-8?B?THhKbTE3RmxuRmJsczMxYitwMENtcXgybXVra2xPZ3R5cEY2K09SZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f29a12e6-7b33-4e44-fb8c-08df0821c6a1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 12:08:47.0891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GHebj4mewKQDFrnZkEU8MpIzO2qEDNHOyGtq6vHKJyp2i+o+D9UL8/NVNzSPByWEhOqETt2Y2l5DlV31jTw77g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB7936
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 01 Sep 2026 12:08:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24051

On 01.09.26 14:01, Michael Adler wrote:
> Avoid privileged image builds and run the job on cheaper small runners.
> (note that large runners cannot override the Kaniko entrypoint required
>  by kas-isar because of a GitLab limitation).

Thanks for fixing this, but looking at the code...

> 
> Signed-off-by: Michael Adler <michael.adler@siemens.com>
> ---
>  .gitlab-ci.yml | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 8dbe62d..75f88e0 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -934,13 +934,18 @@ include: '.reproducible-check-ci.yml'
>  
>  lavacli-container:
>    stage: build
> -  image: quay.io/buildah/stable:v1.41.4
> +  image:
> +    name: ghcr.io/osscontainertools/kaniko:v1.28.4-debug
> +    entrypoint: [""]

...like here...

>    tags:
> -    - large-rootless
> +    - small
>    before_script:
> -    - buildah login -u $CI_REGISTRY_USER --password $CI_REGISTRY_PASSWORD $CI_REGISTRY
> +    - mkdir -p /kaniko/.docker
> +    - umask 077; printf '{"auths":{"%s":{"username":"%s","password":"%s"}}}\n' "$CI_REGISTRY" "$CI_REGISTRY_USER" "$CI_REGISTRY_PASSWORD" > /kaniko/.docker/config.json

...and here...

>    script:
> -    - buildah build -f scripts/Dockerfile.lavacli -t $CI_REGISTRY_IMAGE/lavacli .
> -    - buildah push $CI_REGISTRY_IMAGE/lavacli
> +    - /kaniko/executor
> +      --context $CI_PROJECT_DIR/scripts
> +      --dockerfile $CI_PROJECT_DIR/scripts/Dockerfile.lavacli
> +      --destination $CI_REGISTRY_IMAGE/lavacli:latest
>    rules:
>      - if: '$CI_PIPELINE_SOURCE == "schedule" && $LAVACLI_CONTAINER'

...kaniko does not yet seem to be made for this use case. Does no one
package or more user-friendly container for gitlab-ci?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

