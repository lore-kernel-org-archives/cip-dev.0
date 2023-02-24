Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB06C7EE2D
	for <webhook@archiver.kernel.org>; Fri, 24 Feb 2023 16:57:31 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.75])
 by mx.groups.io with SMTP id smtpd.web11.23267.1677257842011845727
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Feb 2023 08:57:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=a5qJ8paH;
 spf=pass (domain: siemens.com, ip: 40.107.247.75, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E4rCDuPEMyssIFSlJUsvWFJCBF0/0oZgqUkUiPRTASrXa3O36aYKq+fKxqUXcFtUgIZz2VhAyFW+dwLp6KyQ/qH8gsCfsBgdqrl/H9Pm5PUqhwhmbqX+PkRxjUwSoeJHVSG3tjs1UHRcfRdUqNNn7S5hhKBvqjcl0lsFqdH+62+V8eELM439bov93Qw+Oti1fwDlIL1crZkSEDUlbKdKWxQO13ysMSJBdBLuxfT1WMMpqK546VduQq4GNoaBDfsFM71sqVtz5KyJAEqX0pKjfAJDYZThNEzFk75RbV6L0ojfU19EOk/SVWBalLad6BPNUl9whoP9GxR8Gf1T5HVP2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VGXFo9zVitoR5DXcR8Zo40pjm11kvFOcxMqpw1pzw18=;
 b=Q8F9FgClWwQ3z8FaYWFyEj4y+BsvTL0AtJRVJ909CbEn7nz4MaobhgnFeaONvy1OlK8fWbTnqlYK59s4J/4fPLf3eCyZ96kBzHdsDaOGNIyiT7LhPYQDkUzTHRz0rVbCPAF9WVc4gnlYcAg1Tc1YsE9oX3SLC7kHhprCARsSNbH2GZI59DkxGOGeSusWPhpVnnHJlW0Ulln71WurMwXbGfByo78+ZadPmtC6KZyywqRnwvpl64ecrMCGPEz0ztKUGquS0eFygHBtbOO9kewdheSbkrVSWg+VS9KplrAq+wJFC5Cg4jf+R15T5kBrFfSqtKvaUw5hb8+Q9LSA5FKR0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VGXFo9zVitoR5DXcR8Zo40pjm11kvFOcxMqpw1pzw18=;
 b=a5qJ8paHAEL/Doa2MGAv7+3pUKVcYQddjFcvcXsmyb1f+MJknDBXtMFImoaheCo9e121S6Cvy4n8kxrsfqT1Z1jVAheLP/akplnvYDW2LB10SwewFgsMx8RM4eFdt+lX6XKsoQAuPyd1c9rx1COWzl1gJId0HqbKr0Z2VYQ7aOc2fad4xv3QzTHCEJuxfgu8RhXGF2gw++yVxrNBYc8K73igENJ7j9vQHE7FBSJwP19xhdEC3bup/4Ia2IEbUkhopPQ2GDODMcdGDpiTgu8hzng8LPkH5y2eqNkHr2yY+xw5XBM5phRbhTmPmB1zwKNirjB90ByQgI/uUGFgVTSstw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5232.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:28d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24; Fri, 24 Feb
 2023 16:57:18 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6134.024; Fri, 24 Feb 2023
 16:57:17 +0000
Message-ID: <b9582ff3-34fa-4dfb-caea-9d1944cd5a2c@siemens.com>
Date: Fri, 24 Feb 2023 17:57:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [isar-cip-core v3 2/2] .reproducible-check-ci.yml: Add ci for
 reproducible build checks
Content-Language: en-US
To: venkata.pyla@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <2e6c36f78e3873f0627fa5c3912108fe1283438e.camel@siemens.com>
 <20230222114408.32155-3-venkata.pyla@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230222114408.32155-3-venkata.pyla@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR05CA0110.eurprd05.prod.outlook.com
 (2603:10a6:207:2::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5232:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cee2713-12a7-49e6-6f9e-08db16882fd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	UYIigEFDM6z26k5I0giSZtEE7wSqJqwEw07hQWNbL1Ivk89EX1fn4P0ZMbMcsclZkV5n9TFz+7BIJSOXxXDFuPCYL4ZEx2Qq4hdPcXkeK6HMCZQlIE6opEeAQN2QokRSKU+2mWrLRLItm/R2k1RDyP7qIGuyKXAyfD82J7j2uK32Q/hLUbmwByYlgC/9yfnVRl+xda/1gPZxkKewsWR0591NvwrQwvJvukHO6wjLG8+G0B2ss46POm9MIon4OyWiG3h+8MUtUTTFTMUozp7Gaa1e9HmwZ3FAYUr1MWhhNRQvKknq5Q6KlXAYvkKaUVy9mwdAkRaiQMmansDCQka6HujUBNV4k2yj1kedjczKh94bbilLjtOs7foseG755H75GHd3zED4/XWrE331zZJb8Ut3B4cyiHiw7P6E49A6ExQFhVWD6nLs9zIl/KLrRIgeR/WvFq1PVDd4X9W9kAIlH9sKfC5XMENo+yA2+GJvNoW9ms5AAwjpOEw/5p6Q12gBAIf2CjKAn2BHSriBwDf6MBsyf9OLnPDCNBy7XRwmP5wV3bDEDK/Itcvv8trJ2Q9o4RachicuMyPEU7qdfwtEvW6CdFTqyOoo/b4Cu6a7rmdfynKCdgAADP0wXCLMMO4hmXUXg9O7IBHhK6NEHDgPV6IHbIVHiHRIBClGqozrbEcOfy8PHeUlnX93p/i42dAetFk2+0WqjOv3NELHnHDPvOhcsxJhTxapOSGRZ64YBnc=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(396003)(39860400002)(366004)(376002)(451199018)(6486002)(2616005)(83380400001)(66556008)(66476007)(66946007)(8676002)(4326008)(36756003)(8936002)(5660300002)(186003)(31686004)(26005)(6512007)(53546011)(6506007)(478600001)(41300700001)(38100700002)(31696002)(86362001)(82960400001)(316002)(2906002)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?L0dBaUgvOGhVWnZMQ2Jlc3dsTmVPVmVxeHZmVDIzcnhib1A5bkpWbXp3eFdt?=
 =?utf-8?B?RVp5b09JYWpoOUhEdjdSLzBlSm9JQUd5ZzVJM2Y3aGR6aDVIbm8zNXV4TXo5?=
 =?utf-8?B?K3AySlIwWDh5bzc3SDExL2crekpBTHdLOHoxanhRTVFRaDdkYVJhcVNnTXdD?=
 =?utf-8?B?c1NSRVdvTXM5WXRJdnlucld0TVBuZC9DTURmWXNqMFNTSFVISnkxVzZONkt3?=
 =?utf-8?B?bFhoVGFkMUdZckhobVF4UXNlL1ozdkFVWldWM3RUZmd4N0UrVG1idVoyMXBO?=
 =?utf-8?B?WEJzQ0NRTTVTMDBqaUF3UllvVGc4ZWNHMlMxY1FJWFlMaHFyUGxsdVdDaVRM?=
 =?utf-8?B?UnRDNGs5K2U2b0hubC9QVUhTMVBpT0pMNDI3cFBSWjEzMnVIUytoOE9nakFw?=
 =?utf-8?B?M0JrdFlIQlROZ0l2WUljYUJKcy81cG4xRTBFakVPQXBsMnBrcEM5QUNQVjNO?=
 =?utf-8?B?MVgzekVMREc3VU9kYWNFVkRHZHRYQng4NG5zb0xzK0Z4UGh4bXlyOXBoQ3dL?=
 =?utf-8?B?eHAvSjJTbWszR2pJVHBsRFFYUHNVTFk5Q2kvUVN3eUJGdFJYU0FlOWRhTHha?=
 =?utf-8?B?WXhUVHUvRUFIMnBIUGZ1c0NGbmtMVzgrVHlUYTlCRTJCSW43TlhTR29YRXpL?=
 =?utf-8?B?SEVjajNJemRFSWpiYVZFRWxVc01JQmp4NzRUSFVjU3l0aG9EVFFPdlBtTytY?=
 =?utf-8?B?Z0RTYWVkQjRUTS9SOGhTM1lKOEw3OVRkbXh0Q3kzSUdaTENUeFArV0pDczZO?=
 =?utf-8?B?OFJDajVQN1lnWFlTcDg4WkdWYnJHY3dETzE4REF1Ykh5TUpUVVBLWjRJYk9j?=
 =?utf-8?B?aGRQVEhqNEJXTXR5WlpRajRTeGpZYVlJYjhXUzNHemlSeFFXaUlFY1NEQkJ2?=
 =?utf-8?B?UUFubjdJSFcrcjh0R3Vyb29pRVBrcitSL3Y1eFdDc25pMFhtcTIxdnp0L0ts?=
 =?utf-8?B?M25VYUI4alplMExtdmhkalVIUFcvRGtpOEtUczB0TzdoZlFRa0xhNHNCYTNh?=
 =?utf-8?B?RFJHMUhEQXdEbXVMaHFVejFuM1dMWnhKZHJCNXlxNENUUG9QZlhwRTlpbHAz?=
 =?utf-8?B?dHUvUU5FeEtKRitSVmhhUmFkRnJlSFh2K0JVRG80eXB5RUw2TWdMc2lnTjd5?=
 =?utf-8?B?cExVVWFJcjQ3NVNoNmxNdjQ2RDZTbXBHWVB1dS9SMm5MUVBhVzZKVjBSdjdF?=
 =?utf-8?B?V1d4dFhUVWpwSDQyM0VoK1ovb1ZFUTZVZHhGTVpLM2VCNXprZjE5Q21TSUpD?=
 =?utf-8?B?VDRUVkZrVUVhRHVXa1puYVlTZGZYcGpKdGkwdFpOQXpBVWwzOFZ6dDFBL29t?=
 =?utf-8?B?V3RyM2hQTm5NRFYzRXNKcTkrMllzMVdEbHhlSzI0a2FkTmZWT3R3R0VxT0Ft?=
 =?utf-8?B?T2VrMzVuek84Y1J3SGV3Mnl3bm1nbmgrT1htRWRiT3UrUTVZSEd5NmlrWDVQ?=
 =?utf-8?B?T2IwcUNNaG1xa2F1MlgvN1F1K2VNckV2RG1hSG9Nbk9uMXBuZFRJZzZBU0E4?=
 =?utf-8?B?MmtFQlh6bzE0OUs0eVVmL0VydVNEb2g4bm9GOVd5TXNPOVk0Rzc0aWY0WlB0?=
 =?utf-8?B?S3U1UFBVRlJlNkxBVHBFYTZQNkc4bFdsWjNPVTBjY1JURmloLzlDY0dYU2ZY?=
 =?utf-8?B?RnNqeGZsamN5QU5lRHl2NGoxYzlEL29BQXI5ejFMdVZOL2plUlpIWURpa05h?=
 =?utf-8?B?cjJxVCtsdU1aSmdyM3hzcjR3QUQ1YkdhMkdOQXVuL2JuTEhneTlYSXhLL2F4?=
 =?utf-8?B?aEZTZllMRmlVSndLc0dUMjZ3R3B0bDNvNHhhN25FUmhGc2J1NDNTaUJZWlhF?=
 =?utf-8?B?VTVLdkwzTlYyRHEzcjZMcjF5NkZReXRoeTFOMm1YNStGUDE2WDBlMllva0ZM?=
 =?utf-8?B?T0hrSkFJTnduUzh5UGVoMUxwKzVFYzVTL1pGL2hZTmZIdVB0MVNDTDA0MGwr?=
 =?utf-8?B?eE50VXkraVNlYkw0TVZkNGtTaFZPekZJeXkyMzFUY1k1TFRWYjJxc0xtdU4r?=
 =?utf-8?B?WDJHSEpiYm9JdzdnZTA1ajZ0dkxhWE9DaXFXSzFmY05IYkhEL3BMZXloWXkr?=
 =?utf-8?B?ZFpRaVVkR0Faa3NNOFJIY3dqbk1taXpPQjlEWEdGbkczYzVCZFpCUHVnV1J6?=
 =?utf-8?B?SXJJbTBMN1BkRVB3Zms1TlJ4NmgvVzRVVmZMSmljZ25rVFpQSnZjdEVlMmgy?=
 =?utf-8?B?TWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cee2713-12a7-49e6-6f9e-08db16882fd0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 16:57:17.7703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RKyDo+O+pki7c2iKpOuFPzyhXObXAgTaQfm/OEOfcI3Gcwz6JqLd1xwKU3GoiQ4gV/4mB7aQ1DK6syxsnyFsXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5232
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Feb 2023 16:57:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10823

On 22.02.23 12:44, venkata.pyla@toshiba-tsip.com wrote:
> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
> 
> The reproducible check is added only for scheduled CI's in order to reduce
> burden on regular commit pushes and monitor only reproducible checks on
> specified intervals like bi-weekly or monthly.
> 
> Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
> ---
>  .gitlab-ci.yml             |  5 +++
>  .reproducible-check-ci.yml | 91 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 96 insertions(+)
>  create mode 100644 .reproducible-check-ci.yml
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index f7c8c88..3642661 100644
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
> @@ -281,3 +284,5 @@ build:qemu-amd64-secure-boot-buster:
>      use_rt: disable
>      wic_targz: disable
>      deploy: disable
> +
> +include: '.reproducible-check-ci.yml'
> diff --git a/.reproducible-check-ci.yml b/.reproducible-check-ci.yml
> new file mode 100644
> index 0000000..a50d683
> --- /dev/null
> +++ b/.reproducible-check-ci.yml
> @@ -0,0 +1,91 @@

Missing copyright header - yes, also in .gitlab-ci.yml. I'm picking the
one from kas/opt/reproducible.yml for this file.

Jan

> +# extension to gitlab-ci for reproducible checks
> +
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

-- 
Siemens AG, Technology
Competence Center Embedded Linux


