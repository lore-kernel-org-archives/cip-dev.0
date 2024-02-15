Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85876C48BC4
	for <webhook@archiver.kernel.org>; Thu, 15 Feb 2024 14:26:47 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.55])
 by mx.groups.io with SMTP id smtpd.web11.15121.1708007203973899934
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Feb 2024 06:26:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ccup/S1N;
 spf=pass (domain: siemens.com, ip: 40.107.21.55, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EUtzOiaBL8PtKmBdaSmIpgzom0RK03QZHFnSoeH9M7WYTUFT8vKeC1XTWEJpPPV4AgkJcSswkVJZIbaJFL6IOinf9yDzonlOH3QhoCIRBNI/JYZQi2FKVl56bcg1x2cl+k1DQnl/cnWR16HP8HCNw4w7eGn1aXFjbe1mcW3AcYm0iUWJG8FiqGamCxcFZamH5aUv/PEPIQlfsXmck9V0wwSiMEkU5FJW0rkRq7xPjI3buCeJtKnm7srPVLSKGejTufYfezxwUngrhqQDqhi2PtxWegKP6f60PM+sLyjEWdpTwwSv8JEKHVPWrZMMxV7JQgDgrbipbUwZ6ZL/oTvhuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=npFNGJj//rfVNRscOWg/D8zmyKh6KJuwcoQWIFB6MAQ=;
 b=CyHKuWo9Z8xSzCR6nbY7Ihds5h+ZkAyD9k6Kr2QYuYv+tUOFgO3ycv/76aQ4+MiqIylEhfxwqfSlmAc0S+P3qA9MCqXN9vyG9+O+H0xEyGO+zdgwqzkPMC1ek6sO9PpAwEseEV3O/Zpe8izvKy29BJjYf/y6FCPEcBU/41MFWR9JOsIigfEI4UAwCjPjS1zzcGsfWHklhtBBBSnoeNZbaxmkFFjBqkbrfVaxL9Y0xgFpd5zC4gth4CftRAr7u87fHx6LC8AAmLnrLY3vd3CRXTS2mTmCSJBtqeCGz92f9+svlW+o5a4uYVPBX0fRqkvgIsIgS7U/NXjwICc6SWa0cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npFNGJj//rfVNRscOWg/D8zmyKh6KJuwcoQWIFB6MAQ=;
 b=ccup/S1NsFaaFA8soL7pUEwwOswTrAHrQRZMBHIV4YC+4wHGgVCFdc12DlM7ctaRCefoXrySpHwtx8CUNoidEiQymUKPumoNRlXkFzyd0NLYJ5h8rnLcj5FXo6k51veqboHKWKBGUGs9X3vRTGzO9IZdw4wVFWZc9G62Gy8NiO2AzayHUhn5hA8me+B+4AaiwYS5T3moYyDJln2iUjZnrhrXdbPRaNrOPSZi2peJ/CHbJ13BfQ3J0sXAgCA0WK6T/y8Cmo4Zn0+uHV8BL4jTRl0zwaVsGBr6gwnnskBe0KFd4X0+ic3wDEdXT5um2lBdDHIZTVvmBV7sakZPzojqrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB8209.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:38d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Thu, 15 Feb
 2024 14:26:40 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7270.036; Thu, 15 Feb 2024
 14:26:40 +0000
Message-ID: <69cfca66-027e-4a49-97fb-84a916e5a029@siemens.com>
Date: Thu, 15 Feb 2024 15:26:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core v4 2/2] .gitlab-ci.yml: Add condition check in
 .build_base to build v2 image
Content-Language: en-US
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240215135837.3557922-1-Sai.Sathujoda@toshiba-tsip.com>
 <20240215135837.3557922-3-Sai.Sathujoda@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240215135837.3557922-3-Sai.Sathujoda@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0033.namprd04.prod.outlook.com
 (2603:10b6:610:77::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB8209:EE_
X-MS-Office365-Filtering-Correlation-Id: 643eda02-0a67-4024-89be-08dc2e32201d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	TpHy0w+ROj20xV4lELOj5W1/XGl9v+rdlO+ido2VdnCuLE1QBfbIjBJgn2p7k5wIO/2IjCXauPc7VQP04u1/ii69acwrJiEhVUxLRMz/E9J6cxoqRK6WN9lOAuVslSHxAcxqUrfFZhy8nWcNbu5498Wk+viLNMfjtbG6bGifOhEaKUteMLHoHS32nOz+oTQ7yTQiJrSCpVxIXdhnzJ5/WjDgO3mDav5Qhxho/nxBQP/DdeZa1gyIFhb8yt8QI7PPhpWPFt5J9FKhNjUEt2DkLNrwWz0anpiFEF9Zmf/WtDxZHJPRNb4CKXF7r0tHGzWOvIuvcUQtbzEqCv3EpGMpKmIKo7WV43tgiEE6OWH0k5Ne7dbpoq5i46IYtoxbCtm+QVINXqMetMSCak6i0kvLXzue9hckIvOL5975ze+miHKRGTrzBs9a39Tu1wwlzwgMDodXnB9owfTrV5zruuJ4TcmZde6TIh0QOE5NoERfv6Y4rvscrd1oFMsGN2PppJu06O59i3rWBExToV09kAXDRtxy9D9/UjQ3gqv7e6Bi3s8t6KTka4Bf9dqskAHAp596
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(136003)(39860400002)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(44832011)(4326008)(8936002)(8676002)(5660300002)(2906002)(53546011)(83380400001)(36756003)(2616005)(38100700002)(31696002)(82960400001)(26005)(86362001)(66556008)(66476007)(6506007)(66946007)(6666004)(316002)(6512007)(478600001)(41300700001)(6486002)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?djN5ZUZnOHhodlcrQmZheE52VnkvQk00NkJVMGdLR3p4Q1prWmFHVG9qaVo1?=
 =?utf-8?B?MkhoeXB3blhWNXB6dk13SHdtUzE5SytxSytZcWpNcTRrckNockhEZmZZOE9D?=
 =?utf-8?B?cjNab1NaUTlXTnR3Z1NVN2haYmtGQ05wdDZUdHVtWG53OTNON0ZON1QxQk42?=
 =?utf-8?B?OTJZMmRobWNLUjBUd1NJMTFtSUJZbHhRT1J1SGJpV25aYzdvM2psY0RMSGZM?=
 =?utf-8?B?cnBTOEZFK0VBZTJjeXdONUhlbU4xVzZDcGIxN2RBNXZ6dUJib1NqSi9STE5s?=
 =?utf-8?B?SHpCNmxITGVweWRyQ3JYWkQ0U2F6b2VHdWFkaFpjbnhHWFZRTWVaSW51VXRE?=
 =?utf-8?B?czRpUVJvK3lBV0QvVklodStKUVJnUE1YRC93UjVtd0kwRHRPM1BBSzB5Zkpv?=
 =?utf-8?B?R0hML1JWNlQxTXNGcHdtT1dTOHRoaCs3OVZYZ05UQTZjY3hnT1pYSDh1ci9F?=
 =?utf-8?B?eEo5MGFpSTN0NWN6eG41dWMybEZxOXhKeGJiYmRNeCtNQ20vRkJIcmZubjJu?=
 =?utf-8?B?N0RoYitpUTIvb2V1aWw2aWtzam5rUVc4eXNzTjcvcjlISlVXMXdkRHpTRksw?=
 =?utf-8?B?eUs2L3I4TC9Danp6Sk1Nb1ppQWNyUXZkZE1tSkNQRUVvQXl4a3NCZHowQkFJ?=
 =?utf-8?B?Qk5lOW9adzhwempnL1hyS2dCN0o4RTQ3NHlna3NVRlI1WkVmSDh3STBXUFJR?=
 =?utf-8?B?eU9DQlRocHh6aGR6VmhBNDBFa0RoMSs5blJFNExWc1JTa2lWRExwYzlESUpU?=
 =?utf-8?B?KzlMNmcwSFMwYVhTYzNRT0s4TStlYWhtWGo0MHBTQURuRUZ2UXNDWHRBSDlF?=
 =?utf-8?B?eUg0aG1iQ0RQckVraHBtYVJVcFp6cDUwYk9xLzFZQ3FHb2taSVJaTFhGcDNp?=
 =?utf-8?B?TC9VUWZCdW1GRUxsNnMxNlM2QVQ4NnE1S1hGWXJocTc3MWVSK2d6clNwZS9s?=
 =?utf-8?B?YXkvcmQ5Vm5TQk15QktDMU1NNHphTWFWQzBDOTJxcUFjYm8rR1NPMktwNGtB?=
 =?utf-8?B?eGExK0xTQzJsOVQ3K2xHSEthRC9VN3JwRjM5ZmRwaTZ0dHlrZEN2N0h3Z0l2?=
 =?utf-8?B?Uk9tZmFyWU53YmhsQ1ZjWnBBc0xRUThOSEtMZEVJak5jQzRyQXoxTlV4RVpz?=
 =?utf-8?B?VHVOOEs1eHlFVXhuZW1aeGJEcGVwYlJoTlVnaldLSGFmV1poZ0pJVGNKQmow?=
 =?utf-8?B?QmRIY1A4RW9QcktoWkR0RHhCaFhpZ3ZHTHJJcWo2cUZsQU4zdkYzdWdpQ3BI?=
 =?utf-8?B?LzN0amxNQlRmK1JtMGU3OUkzWHFMNXdQelk1V1RoWkJvUkFxb3VidWc0WWs1?=
 =?utf-8?B?Z2E4ZnltaUpJblNKWWhiVlVjdnEzejc0NDYzWnYzY3lud3d1QUFxVUFkVHo1?=
 =?utf-8?B?R0Z2TEpUSURGNmhJd1JKZkdvbVZGU1EzcVB2em9nWmtON0NET3M5elgwUThm?=
 =?utf-8?B?aXNCQWxLdktuMDkwNFlFYXZPd3R4SW5kc3J3TTdHVmVGK2M4SkFZdlpKajht?=
 =?utf-8?B?R1NlYnRJR2hYVW0rdjY0eWpMZi9zdDg5azJ3Y2tZeUwzblVGdVZGUGhna3hw?=
 =?utf-8?B?WGVUbEdZVzZOdTZ2WUVqZGc0ZjlNb3lpMDdZU3BEQTBxSWwwaWtwc0plVE1r?=
 =?utf-8?B?c2Njc25TNDFXUzhMUGs1RUgwTmxRRzFrd3VRU0ZLRmtqRlU1MkIzanN0eU5K?=
 =?utf-8?B?VHM0bGRaZXFDajRQcm1YY1VUckt4NCticE5idytFYVBJeEprY0F4cnhnaFMw?=
 =?utf-8?B?RGRlSkxWMFZsV1R2S0I2d25BVUxzSXp2UXJSNzM0bmwyZEVCc2Rsd0ZBZzF5?=
 =?utf-8?B?c2Qwc25zNVJtdlA3MnlNOTRWMHZvQnRaWWZXbEpUYVpua0lHM3VJK1Q4b094?=
 =?utf-8?B?OFBXTW1qN1JuT0RhaG5laWVjeldxZ0hDQlRPNWtLMWV4dEM2TDAwTnRjdGtR?=
 =?utf-8?B?RlR3V0NEbVJFaERweVhqV0RPZVYyYzFOUXM3VDl5ZUloUk5wSGFMTml2Lzcx?=
 =?utf-8?B?NDJkNU1ZWkJiOEM4czdEdXlhZFNhZE5yc21YV29zVnlhMjNoTXB4aTl1Y1VP?=
 =?utf-8?B?czM5Ukh2cklFbjNkdzRjV0dJUjNabXFiUEdzdzhPRm9NcmxVdDNmSkJrajNK?=
 =?utf-8?B?UW1Gd1hvWktnLzI4VzVCaDI3MW1uK3p0MTg3UVB2R3MySmduOVhYWGE1Qi9y?=
 =?utf-8?B?eEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 643eda02-0a67-4024-89be-08dc2e32201d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 14:26:40.3888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nKDmFjs6pzUtB0XPYVYsE3ORLFabm9Sn7xcELZk4YYzana5eoawhVsaXt2HXR0UQ/0oFXXXK205NAZ+DEo0aEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB8209
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Feb 2024 14:26:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15000

On 15.02.24 14:58, Sai.Sathujoda@toshiba-tsip.com wrote:
> From: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>
> 
> To re-use the built artifacts of v1 image, the consecutive build must
> happen in the project directory of the job. So if build_swu_v2 is enabled,
> then a consecutive build with a minor recipe change is done to get an .swu
> artifact for swupdate testing in LAVA. deploy_file variable is default set
> to wic so that after checking presence of .wic in the deploy script, all
> the artifacts like wic, firmware etc. shall be deployed except .swu file.
> Only .swu file will pushed when "swu" is passed to deploy script.
> 
> Signed-off-by: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>
> ---
>  .gitlab-ci.yml | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 4f87ec3..1c6816c 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -25,6 +25,8 @@ variables:
>    dtb: none
>    deploy: enable
>    deploy_kernelci: disable
> +  build_swu_v2: disable
> +  deploy_file: wic

Why making deploy_file now a ci variable? No job changes that.

I'm dropping that, hard-coding the related deploy-cip-core.sh parameter
on invocation. So, no need for a v5.

>  
>  stages:
>    - build
> @@ -65,7 +67,13 @@ default:
>      - if [ "${encrypt}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/encrypt-partitions.yml"; fi
>      - echo "Building ${base_yaml}"
>      - kas build ${base_yaml}
> -    - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG}; fi
> +    - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG} ${deploy_file}; fi
> +    - if [ "${build_swu_v2}" = "enable" ]; then
> +          echo "PV = \"2.0\"" >> recipes-core/images/cip-core-image-security.bb;
> +          kas build ${base_yaml};
> +          deploy_file="swu";
> +          scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG} ${deploy_file};
> +      fi
>      - if [ "${deploy_kernelci}" = "enable" ]; then scripts/deploy-kernelci.py ${release} ${target} ${extension} ${dtb}; fi
>  
>  # base image
> @@ -105,6 +113,7 @@ build:qemu-amd64-base:
>      use_rt: disable
>      wic_targz: disable
>      targz: enable
> +    build_swu_v2: enable
>  
>  build:qemu-amd64-base-kernelci:
>    extends:
> @@ -127,6 +136,7 @@ build:qemu-arm64-base:
>      use_rt: disable
>      wic_targz: disable
>      targz: enable
> +    build_swu_v2: enable
>  
>  build:qemu-arm64-base-kernelci:
>    extends:
> @@ -149,6 +159,7 @@ build:qemu-arm-base:
>      use_rt: disable
>      wic_targz: disable
>      targz: enable
> +    build_swu_v2: enable
>  
>  build:qemu-arm-base-kernelci:
>    extends:

Thanks, applied both with the mentioned adjustment.

Jan

Jan

-- 
Siemens AG, Technology
Linux Expert Center


