Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D42C636D7
	for <webhook@archiver.kernel.org>; Tue, 21 Feb 2023 20:42:39 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.50])
 by mx.groups.io with SMTP id smtpd.web10.53718.1677012150170421455
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Feb 2023 12:42:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=lDx9UhCi;
 spf=pass (domain: siemens.com, ip: 40.107.20.50, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lHao30ha3zx31UqLiJuBOiS2TEE0YKdlBOe6RvKvOEuYif48dnpyvkzx30XnKLsuwjvYnpJhfs1gl1teAJrj7V1G7SXOlPOxtlWF+FO3QD0mlKHloj6HlWRZD3DTJz+yinHXYPUZsXPEeXmMtd5GwhV6cYe0CW3UbeIUr748t8FGfUazKAvi8cot/sdhuvoRPdbxVg4l0UTnjD2OO/FCFMkQt1V7yxfPkmdlqEmj+Tlpq8EquQ8LYHXXCg2rkQsbPxOJsy2mw264F30awmWKaUN6t2rv8Gym3XhVQOVwOWfQvYC0j6vZBCzZ+Lumb4hUiKRRX3DrJ+1Z5Uknt7ZbJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5k1WLIv1LComfphr8FzS65tyfwabOEIWItY27O1c4Jg=;
 b=Bcql6NPUZ85xyw3ukRi5kWhG1dKCgqjxJqOBHECabHYwDOGWOoWENpQvFbTqgXbmpOY9ddbzvKD9NuPOzn/Lt/FWofJ1uXpmsrHKIdhVhC1FbfOG58L226u+AiVg6aSbT2jaij7cjOkymZ02gQuz5jidyaAeu/7bvO8DZqW9DqjXGpZWsH/1PT4eZv4Kzpd2a3J0t9SlCWvHBKHP+qIyjHvuePQHwVrMso60Z5wGnQDG8osVfcAzOwuqbY2cCcp4yZMvD7K3FXClFXQ3p1lnKIyG+vLrvhOc20odtXBkS53AkfGGEY8+p9gW0BHCmNEZ5ee35wvjMAZ57xeZVN7b/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5k1WLIv1LComfphr8FzS65tyfwabOEIWItY27O1c4Jg=;
 b=lDx9UhCikD+lyWmlBm7SgSNvn+PDHL2t4xvd6hsL0J3vJ9DaEsVdGZT9zkdaXfOMIURY0ouqyZnN9qpmVjySmCWmDhB4HB/yFhUUNopFFPSYwhYPdjdGICozIX5P1O0O0tMufbZpPsEEa/gtEXNgy8Z8EMrLPUJ/F8e16PUi63CZci37OjZOagUksoQy4Hz0w4m5bAS3/75P891YUGixZoNI7gD0sVhJsua3pGHIGs2DAff0K7M06G4T6nXkBu8kASeqgHpQy18GDgp7m0+GLF2QtdRtN0L+26xepkbGG0H6/3Nn2D0pjS0XEKWodsJ0D0oOyY/5gM7bh56PEg8G3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3635.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:153::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Tue, 21 Feb
 2023 20:42:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6134.019; Tue, 21 Feb 2023
 20:42:27 +0000
Message-ID: <77701639-f705-5b20-f7e6-197cfdf5ee05@siemens.com>
Date: Tue, 21 Feb 2023 21:42:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [isar-cip-core 2/2] .gitlab-ci.yml: Add ci for reproducible build
 checks
Content-Language: en-US
To: venkata.pyla@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20230221154138.15146-1-venkata.pyla@toshiba-tsip.com>
 <20230221154138.15146-3-venkata.pyla@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230221154138.15146-3-venkata.pyla@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR11CA0015.namprd11.prod.outlook.com
 (2603:10b6:610:54::25) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3635:EE_
X-MS-Office365-Filtering-Correlation-Id: 93012a82-0eb8-4897-d79a-08db144c24f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	e+IOhtBGZpheb9Hf7xvC+winmvmp4i1mFzVWWyWq7SS+lmyQXCKmpSfhh62DnbZKzEGk0s5TTzhguNAWxu5lv1UvIKdlK5UZ4ue2MrLlYRgRHrRTn67pSgiNntcMF+w6X/hcP5tY4bYlRvBXlPT5encdedTB5ewA+LbMvjUW0nTEZNIjgKbUMRAXoA5sWDPFr/1zoGfptXraOZdYkXYedGk3yq3Rd61Oz4QOJKm28qIt5pFi0fF9x+MYaa9tQ/hh0t2YcAp48V6pi7xgCa7Qfc6Iy+FqxahOLrQDT0He2QLLf+iIB+g8+mJUiby6nx/6dHmqq0Q5pRgoRS9QWukRfJmTeXmtE4fG/Jh/9sqrjIqFo3tvARZkA//S0nXke13YHSi8axxXaqvOR9oLN24m7Vjp/kniAFFP9Em++D/S3OgLSnO8poQ4ySO13GvznLgmegGKs1i0GuFAmhk9EURV1UVxYz/Q/JsfCGRXb+aqgGwu9nUvHJw3Ehtnr0KLF4Wc+uBKyupe1nfyeKM57HnezEvz68mSeQ0kLjDQ2Z9F/6qLGP1p+b2uRQjzx8sbg3M5+xn80pIM8Et66CceBMoNfOfULZSDWYdZViA7Mfwbr6OiQjidzulRlyjtOGKm2npQ3w0Gu0MkVaxJJMTvUhdJfM3o+BAtYhXjqLbjkvbxLllR66gnAFmNh9RXQ+YxcjZ55X4b47Op+VznkF8ofXtlMlXjSDtomQTU7qAAGDiT/Vo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(396003)(376002)(366004)(39860400002)(451199018)(38100700002)(31686004)(2906002)(82960400001)(8936002)(44832011)(5660300002)(26005)(6512007)(186003)(83380400001)(41300700001)(2616005)(8676002)(36756003)(4326008)(66946007)(66476007)(66556008)(86362001)(6486002)(478600001)(6666004)(6506007)(31696002)(53546011)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WU4vVTloQ21OVDdCbktPcXBWQ1kxMjJ2ZTZYV1hzR3BWcVl5eWJ4YVJtM0xX?=
 =?utf-8?B?c1p1bElFWTduR2RaZUd5c25tVnBCN1oxTjlSOU5oZHlEVzlRSVA0MFRCVGph?=
 =?utf-8?B?dFZ3MHQ4TXB5QytXVFlnZmQ5dnZ1R2lXUjJUZnF6anpIL3c3NW5DTERyZUJm?=
 =?utf-8?B?VHJ1VW5PQ2tzOS9nN20wMlRqdjF6dW1MdlUwRmgyR1NDeW1EVGRKdExxb0R0?=
 =?utf-8?B?L1dRMzRqNHFxWlpSZVQ3OTZTbnp4SFlmanNVOU9pK2lWQkJLWjcrd2dleXVR?=
 =?utf-8?B?RjB3MmtJdWxyWW9xZWRYNXdkZm5jYytpV2pkeGszNmxOM3NBOTQ4dDJ2M0Fw?=
 =?utf-8?B?eWV5ZGJvdXprVjNoT3E5eUgrdmpZZGRWc0N5T0pVUHVtQ3V5aGs2QUxRdGRz?=
 =?utf-8?B?WXRUMW5TTS9UQ2pTRVBwYVRwVzZ3RlhOeTBGOVVncVgxRFZqVXhGUk5ycEpK?=
 =?utf-8?B?cDQzQ0pvMEZQZzBXcHFsWEZudXBrYWF5aitFRjdtRHhuOGV2Z1VZbmRhS2NN?=
 =?utf-8?B?Q3JYUlNRdS8wanRGWkRiaHB2ckExU0lFVmtwL0FFc1pzNkdJZEZTTTFxVk82?=
 =?utf-8?B?NFNTYXg5MzArSXZWZFAzUElZNSt0cFBjUStUQmVTV1BralhURGowRVhIbVh4?=
 =?utf-8?B?MWEyRDljYmViL3JCZUN6b3l0NUV5N2NNWmZWdGRYaXpvdFRrL04zYWlqSXdB?=
 =?utf-8?B?U250cENzSWxtK21WYTRKRk1pNzhNallKRjBZTDdCd3NONnA3QzkxMlNpMVNq?=
 =?utf-8?B?cDZuUXNHdkRhVGQydG1ZeCtha0lPSm9IalRGWXFaM1lsM2poUC9vT1BVUzBz?=
 =?utf-8?B?NGdUWkpJeU9wZmRYR2xXU3JmWW5vRjZyNktlTnpZRHB6UFpUNUE3dExEekxs?=
 =?utf-8?B?ZGF0NzFkcXRMV0tFRHBsaGFjSlduOFdYT2ZwN0thU3NTL0M2ZUhldURCendz?=
 =?utf-8?B?ZElnaHVEaUhJdGRZcDFMb3Y3WWhvRTVtbTd2QVBidGFmUW5RODVMMDZha1lT?=
 =?utf-8?B?cURHLzI4OGhPS3Q5MUNPOFJsVmwyVkw5dCsydTNxUElnOFNuRVJiZ0hqajdy?=
 =?utf-8?B?ZzhxckJ3SmpuTGxIQ25UbURDak1vcHQxMVBpbm93cXNBTHNRYzlFUnZhQXVR?=
 =?utf-8?B?U25aR0lFR1Iza24vTVkwbXhRWm1pczUzS2VBQVZ2TjgxUlkzSWRlZWhqZzJM?=
 =?utf-8?B?MDdqeDBFaEVzcmF5dXg2blNwRFFZdWVMWFpDdzl2TmkyYUVhbUt4UWRXNUln?=
 =?utf-8?B?Z1F5YllrdGpYZERVVzYwaTFLQndNQlloR01DVXoyRHMzT1RYNC96cXhHQXF6?=
 =?utf-8?B?c0gvdUhLaWxUdDVzQStRL1BzRG01eHlhU1dudmxyMEk0OFpnWEl2dXUwa2xz?=
 =?utf-8?B?SjJMbHdCSXVOL0FnS2hpcmxvK0tqeTFzMFVMREhybmFYcWsyL09GWTJIdzlJ?=
 =?utf-8?B?MlhwaS9uOWY1NmtKMm9hcEE0UERwUUZVYjBhdmtjdDdJanpQOEpwWGhidzJl?=
 =?utf-8?B?aG9ocFM2NEEvblNMbE9SakFLcmpJbWtESTZWS0s0VzFUbm9IeDdvWGFTQTM5?=
 =?utf-8?B?c1pYZkgra3REdk5ZZlV0d2MzbXZoWHhkc0pTZUNLM1NPS0ZHOVJlMDJXaUg4?=
 =?utf-8?B?RWFnWk4xdk5RbGd4R2dKelpqcVBoY0tYcFg3TlErd2V2cG8vZXdjSFBjSzRk?=
 =?utf-8?B?V0FaK2IwUzl6MzVYeVpOUURSUGExK3lRelBxQmVMM0ZnUHlLQ3Z0VVFvdUhH?=
 =?utf-8?B?VTJyRzh6SG9tcWxWUFZ2VDlXNEVWeVMyM3UrVy9zZUJmQndxTDhZWmN6K0VS?=
 =?utf-8?B?MEFabHpCemx1Vy9JMU5iZ2h1dEM0T1dBWDNTaUhSK25JNjd3Q0RiVWxrTWZJ?=
 =?utf-8?B?N2c1Slc4M3FPdlEwZ3Fub0N1YkVoY3JLRXI4emZWNWxxNHJiTHhoNTFNTTlC?=
 =?utf-8?B?K2dXOS9KTW5JTXNGTE81SXQ0WlRBNkpwRUU3dGFNMVBWbngwdGh5ZW8zcHZU?=
 =?utf-8?B?d0hSVXJoWlRIUlpuMnJyYkJXVzY0SUlPMVk5QmVwUzlwYzRMNUczYkI2MnRa?=
 =?utf-8?B?cnZHNktyZzVpb1prUTJnUG5vd1RhT1dzcEc5ZGFFTjllRnY0Y3BDdythNWhi?=
 =?utf-8?B?SnFURlM5YmRoWk83L1kzMkR3L1JLV2NZN0RVRlk0eDVzNzgrQjFyRUpENy9x?=
 =?utf-8?B?WHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93012a82-0eb8-4897-d79a-08db144c24f9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 20:42:27.5823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DzXWx35tY7Gw/1XtZYiMQewA0DrfvYoye52SRoHl1qLh4RUD4HFK2fDcDNgmT3aHOW0WzcwwfAjf7FNNyJGgKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3635
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 21 Feb 2023 20:42:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10763

On 21.02.23 16:41, venkata.pyla@toshiba-tsip.com wrote:
> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
> 

Quite a bit of your explanation from the cover letter should actually go
here instead. This here will be archived in git, the cover only in the
email archive.

> Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
> ---
>  .gitlab-ci.yml | 93 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 93 insertions(+)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index f7c8c88..3458a2f 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -13,6 +13,7 @@ variables:
>  
>  stages:
>    - build
> +  - test
>  
>  default:
>    before_script:
> @@ -26,6 +27,8 @@ default:
>  
>  .build_base:
>    stage: build
> +  except:
> +    - schedules
>    tags:
>      - large
>    variables:
> @@ -42,6 +45,57 @@ default:
>      - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG}; fi
>      - if [ "${deploy_kernelci}" = "enable" ]; then scripts/deploy-kernelci.py ${release} ${target} ${extension} ${dtb}; fi
>  
> +.repro-build:
> +  variables:
> +    use_rt: disable
> +    wic_targz: disable
> +    targz: enable
> +    deploy: disable
> +    deploy_kernelci: disable
> +    artifact_suffix: ".tar.gz"
> +    base_yaml: "kas-cip.yml:kas/board/${target}.yml"
> +  stage: build
> +  tags:
> +    - large
> +  only:
> +    - schedules
> +  script:
> +    - if [ -f kas/opt/reproducible.yml ]; then base_yaml="${base_yaml}:kas/opt/reproducible.yml"; fi
> +    # Build 1st time
> +    - !reference [.build_base, script]
> +    - mv build/tmp/deploy/images/${target}/cip-core-image-cip-core-${release}-${target}${artifact_suffix} image1
> +    # clean
> +    - sudo rm -rf build/tmp
> +    - sudo rm -rf build/sstate-cache
> +    # Build 2nd time
> +    - !reference [.build_base, script]
> +    - mv build/tmp/deploy/images/${target}/cip-core-image-cip-core-${release}-${target}${artifact_suffix} image2
> +  artifacts:
> +    expire_in: 1 day
> +    paths:
> +      - image1
> +      - image2
> +
> +.repro-test:
> +  image:
> +    name: debian:bullseye
> +  tags:
> +    - large
> +  stage: test
> +  only:
> +    - schedules
> +  variables:
> +    GIT_STRATEGY: none
> +  before_script:
> +    - apt update && DEBIAN_FRONTEND=noninteractive apt install -y diffoscope
> +  script:
> +    - diffoscope --text diffoscope_output.txt image1 image2
> +  artifacts:
> +    when: always
> +    expire_in: 1 day
> +    paths:
> +      - diffoscope_output.txt
> +
>  # base image
>  build:simatic-ipc227e-base:
>    extends:
> @@ -281,3 +335,42 @@ build:qemu-amd64-secure-boot-buster:
>      use_rt: disable
>      wic_targz: disable
>      deploy: disable
> +
> +# repro build
> +build:qemu-amd64-base-repro-build:
> +  extends:
> +    - .repro-build
> +  variables:
> +    target: qemu-amd64
> +
> +build:qemu-arm64-base-repro-build:
> +  extends:
> +    - .repro-build
> +  variables:
> +    target: qemu-arm64
> +
> +build:qemu-arm-base-repro-build:
> +  extends:
> +    - .repro-build
> +  variables:
> +    target: qemu-arm
> +
> +# repro build test
> +test:qemu-amd64-base-repro-test:
> +  extends:
> +    - .repro-test
> +  dependencies:
> +    - build:qemu-amd64-base-repro-build
> +
> +test:qemu-arm64-base-repro-test:
> +  extends:
> +    - .repro-test
> +  dependencies:
> +    - build:qemu-arm64-base-repro-build
> +
> +test:qemu-arm-base-repro-test:
> +  extends:
> +    - .repro-test
> +  dependencies:
> +    - build:qemu-arm-base-repro-build
> +

Our gitlab-ci file becomes larger and larger. How about splitting it
into different topics and include those split-up files?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


