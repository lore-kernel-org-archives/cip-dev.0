Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53141CE7AA9
	for <webhook@archiver.kernel.org>; Mon, 25 Sep 2023 17:13:14 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.86])
 by mx.groups.io with SMTP id smtpd.web10.66709.1695661992316917723
 for <cip-dev@lists.cip-project.org>;
 Mon, 25 Sep 2023 10:13:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=se7DL3g+;
 spf=pass (domain: siemens.com, ip: 40.107.20.86, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H3MaF1EJM0KFhaP1bAZCxyoG7JvKsHMy//7Amv6rOZerq2i1ruuZlOkmO1nhDxxwxfjkrimayDSXvB0eh/IRqPQOzR2GTk4PE+yC4E/r08kVuBHtstQ5+Lx/1x1rasiINN1cOkXItu8rI/G6iPCmQZcYp9JsOQJBdBPstXTfVP74VdLPQzGu7JsH2cnH04weA/zx5/ZkvOSO6OwJ67LB0z2BzvOG8cgjRp4/5AhWcKYtoSyGPZw7Nxeva0f52x7n5wnGItKcN/h9oX4SGEGNWE8NBX0hhcco5Gs9/Sb3J44Va/nErfpSacvqxSsaPNbLQsRVMcEbxQq93RCaHy+vHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5oL81f+r2zYk25/8gJhFC/Q0UsHoowEEsMvLz/M2vmo=;
 b=nCn4jfFKxDZK49tX79ZTckYMo86oJlzF3l5thuLBPtil1jRwSU0tBoDitpCdWZVn7WwVm7xL+IlZJ2KX0uTjv05p+5Oe3MN89N5cT5VOzQraStM1P5zZq/h6CIB/bkGMfMH4RGcqk58RoxmsNdbsTa5vwh35q5annWOhmm6HjbYbPpw+0KScd/gsGksjGnoAg26aePmxryJldLBnMKE1f2+vu9cO9Xot6vjo/D/obFyhoRxEo3MBkkWAU/S636KS/Leme8PzKLvwRwnryd1mp9fiK4TGPBRjvL4Gn5dx8JEJWjwk7ytVaDFQsmzCfG0DknVJSAFx9F3iSuQB6ZtPrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5oL81f+r2zYk25/8gJhFC/Q0UsHoowEEsMvLz/M2vmo=;
 b=se7DL3g+8wXSkyxjOx1VNky55M+gIJA3Kv8vIsmmDfJJEqbs3MmIBVlshSGJsJbglYsu1su+XKuTpIgyefCCNTqydgVczyOm/eeNF5ojJXpG2EMdfd6hSD2p0pYYknkQhn/WbNCgGLyyyDU6BVAxiD8xco72yJHSzO1UtfcpSO/Oo9/p8R+k4Dska4c2FYrax2gKdLf9CUdP/yvuO2o+038RgKClxkWFcgOjRRwBEn7qiVr4faAs+6/mQLxk+e8OA8USvSM56NHAfhWdRCniOHGxUV8CZFCjzBfk1oiZNiscREO/hJB+vtGbUkVHm5sbBL2UAINGdRmaQzkS9vqcmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB8253.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:119::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.27; Mon, 25 Sep
 2023 17:13:09 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 17:13:09 +0000
Message-ID: <ce684bce-a09d-4313-b231-132737797f21@siemens.com>
Date: Mon, 25 Sep 2023 19:13:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core v2 2/2] images: Add dosfstools as DEPENDENCY to
 all images
Content-Language: en-US
To: venkata.pyla@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <51a07da1-b0a1-4a3b-b463-739e3ea208f2@siemens.com>
 <20230925165833.2696-3-venkata.pyla@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230925165833.2696-3-venkata.pyla@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0006.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB8253:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ac0038e-a24e-46d4-d8ba-08dbbdeab0c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Xh28QRDNZ/WR5NKORLWWcfH62E823dK2NHpVUi525JtRCREu0UgIMfN+p1aBts5TYMxJu7mTZEzBzieOtNOVYCJ1uivTOfC4ukIzA15MAugakfu9ujeCDBwSruaI5Dg9p+YU/2Ai5B5rB1shyYCtkivUi7uBCp7GGrf599cZUxfK2jQ4YUZcy0D1mPDYH5YXOt9a1pkzWt1RiDF+C2hbkugG6kx8AEdPSbYlZsy/6ovrkNs8j0Gn0EFfPGEUQdlsZNTb9BK/C+a5N5g5yxq0MowUT5vJ+solsUXoTW2/mzo3reXIe385/xdwnHvqnT9SWpHu1y/Bw93N+GsZUk7iPxEu2xI3zaaswJq4nLOyjhvhyC0tLZTOWLZ2t7SOnU8NFFndBkcsilsUtgUZNiXttba8JOYa1RQJCzmUXQl4lFtFEnrnU75QYZEJmrXC/nNEhDPMrfyt8648dKy/7yyvCNOGrJ+6RYNfVrqbPSADj7EwaFLb0tj9v3tZM3bGvBqF07UcZMez0WsvDbWBepARnt1VT8tBdXxsW39rDCNxRoLJs+zkIN+lqFoxqMWnPbAohcgPN83A/shQGw32eqdJOp7C32K4x4+nRqem+WRLa/nrqn0/BCnyGp/i5xdkty6NlYeQFJF90vTSYIgmlAqZ2w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(186009)(1800799009)(451199024)(2616005)(53546011)(82960400001)(6506007)(6512007)(5660300002)(8936002)(36756003)(26005)(44832011)(6666004)(8676002)(4326008)(478600001)(316002)(66476007)(86362001)(66946007)(41300700001)(66556008)(31696002)(2906002)(38100700002)(6486002)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VWl1OFV5aitGbkwybFlzNmFKWVRkK3lsTDREVFlVWk5QYU1CUjdSRVNjNUpJ?=
 =?utf-8?B?UEI5N0I5cFFhck1TN3BtNytEMStiYk42NXFFaEp5N3dLNURBOXVlSWJUWUZk?=
 =?utf-8?B?aGhQTUd1TzdlNFdUWmthT0JTdDRsYzBTVUY1OFQxeHRGYmFmTEozM2RrMHJm?=
 =?utf-8?B?SFBVeEJxU01DS21zYjhHVTNKMW5TUnpSRTA3dkFMSzdLbjZTZ3IyYkFWNnFH?=
 =?utf-8?B?b3o2S2ZWK1FOMy94NC9aeGxNV3ZDaFBCb3hHNFFCc0dvTDM4eWVJMXZORVk4?=
 =?utf-8?B?eS8xemlJczlGN1NXWEdCbTduUmpEWVpabFVVQUV4WFhubEh6QVNadktHbGhR?=
 =?utf-8?B?ZGZYZXBxbXBXY1FEVHJDTHdIeHA2M2NpVTdiZEZvbTY1a0d5N1RldGovS1ll?=
 =?utf-8?B?ODI0aWJkeDl2M2lXQldPeHNFZTYwYktWNUd5eDhvYm1rZDN1blNsYlBpb2w1?=
 =?utf-8?B?YnJFZ1dING0yYlZSalJTWnpjT1l4NjdoQ3ZZQ0p1M3h5MDhTYmc1RmhYeDA2?=
 =?utf-8?B?NC8xcUMxTEp2M0Qra0dIMy9hTFZhdzU1SGpxR0g1ZFdObEk0VkM5aVpJY1A1?=
 =?utf-8?B?bWZtQnBxZS9zQkhvTlZDYk83eklqTTg5N29CZ1prZ1FaT3I1bWE0Q0EwcUNu?=
 =?utf-8?B?ZkpDN3VRR1RtNnNTTmIxbzFFVXJYdXhTTC9oNlloQU4wSGZTU0prQUxMSGxV?=
 =?utf-8?B?QUhxbTdxSUQyU1hraEYyQmwxSUtYTHFsMThYeUVITjYzdmpwTWRiWVhpMzFM?=
 =?utf-8?B?VTlsZ0U4UFFKbE5QaktiejVBd3lTUU4xUjBKME56OGdRK0hFWExPQ3RzeFk3?=
 =?utf-8?B?SlNaU2d2cUM2WTR3a1g1czgyOVpZNTNQbzJ0WjgxaVJWOWxuT2labmNCWXBO?=
 =?utf-8?B?aCthNGlFYUdBc2xYYnhwS3BXMVNwbkZzRnJRK29GUi9zeGh4TU9GZWY5SkMv?=
 =?utf-8?B?eENjOWQrblk4SFRRKzZidDFvTVVNMjlMQithZEVxajhndjRCbWIveFhtcE5k?=
 =?utf-8?B?RkhXYmQyRWdBSkJRMllxUXpOckNZLzFCRHhuMzhwKzhXQ1QrcTZaWGwxc3lC?=
 =?utf-8?B?emZNRXVFc1d0T0pBUmdSbWpBcU1UajRMT2Y2Qjh4UldJZHNKWTF2Y3g5a3JQ?=
 =?utf-8?B?eWEzSExRTkRUZm9Oa2d4SVdCQkxkN05aa21Dbzd2Y3NSNDl2ZkpWdFJYR28r?=
 =?utf-8?B?Y0I1Um9OcC85WlM1MDMrNEFzQXhNQ2ljb0xkVTQxNDJ5MlZKbDJ1WGxhaEVa?=
 =?utf-8?B?Y3pwWHk2K0xQWDVzbk4wZm5nLzAvdko1ZjNxeTFadEljT2Zlb2RONTNyeDVJ?=
 =?utf-8?B?MGhGY1A5c1VreTNLLzhMZ2tDWFJhNjdoZHIvSm93dnBWbGRsOHdBVlhGWmRQ?=
 =?utf-8?B?N2ZKTVVDbkpZTllSakxTTnFQZWV6STB3UU1IdjIxOUMyVVVxMzRPVDdOeVdm?=
 =?utf-8?B?dmFsak45SVZFbDRFTkdYQTc3eU84NXoxYzF1cW5QMi95TzVndkdOZ3BSaVVh?=
 =?utf-8?B?WERjeFl0L3pmYzNrVmNSOFJtOWRSOC9Ea2RINUR4RlBVT2dOSmtEcnc2TENN?=
 =?utf-8?B?ek1uckNkeEYwRDEyV3M0V0xhbmd1VHZjNDl2TGIzRklRbDRYdmpwN3ZaLzZB?=
 =?utf-8?B?U2g0aG9FVWl0d2s4RWpnc1JWRHY4K1RhM0d3MDMzeTBJcDd0S001SWJBRXJt?=
 =?utf-8?B?NTYvbzhFZDdzUldVWUltY05IVTloQlNWR3g4dUhUdHZydlI3dllXa0ZXNmVU?=
 =?utf-8?B?MTlxNnZYUzNqMVF0VWVudTZwZElFMXZZWmlmMjliZ29qdXg1eHFHM21tK09T?=
 =?utf-8?B?dWhVbkdJNVhXd0dLWmFRbEdnRHBBU0o3R3NtNUt3Q2E1a2VEZTgzMXBkaTIy?=
 =?utf-8?B?UzFWTDFRRU0xSTRoRXV3NTdMdElDN2I2Z3hBQ01XQ2poOURrV2lNQjdtdzEv?=
 =?utf-8?B?SllTREpaOTJLb1I0eG8vd2xMSnNPWnVNNjRRSWdTN0hIN1l5RVBmaFMzejd2?=
 =?utf-8?B?ZFZyRFQxNmJTU1ljam5YOFVWZ1FmYTBHQXJoRW1jQmlQM3BxSmxjenJaeXNz?=
 =?utf-8?B?NFpDVE9GWFgzM3BNTzJYdHhpdm9OeGFEdDA1d3hZOVM1QkJaV1JGZzhHZVRq?=
 =?utf-8?B?Rjd0RkxMMkVnZGM1bWpWd3lNUTVlN3B1bXZPRnVmUm9TVVRMUzF4VnMrcjBw?=
 =?utf-8?B?V2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ac0038e-a24e-46d4-d8ba-08dbbdeab0c2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 17:13:08.9474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rFSwHPKa7pITVi2RYlg9a/G4CzDh5ygDisRpgfn/eqOSJ2VJFcOe3qXCt1Tnq1xZWM9gnxKWKC2DDlJlIrm+Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8253
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 25 Sep 2023 17:13:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13222

On 25.09.23 18:58, venkata.pyla@toshiba-tsip.com wrote:
> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
> 
> Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
> ---
>  recipes-core/images/cip-core-image-kernelci.bb |  1 +
>  recipes-core/images/cip-core-image-security.bb |  1 +
>  recipes-core/images/cip-core-image.bb          |  1 +
>  recipes-core/images/common-image.inc           | 13 +++++++++++++
>  4 files changed, 16 insertions(+)
>  create mode 100644 recipes-core/images/common-image.inc
> 
> diff --git a/recipes-core/images/cip-core-image-kernelci.bb b/recipes-core/images/cip-core-image-kernelci.bb
> index 479c14c..8a58e7b 100644
> --- a/recipes-core/images/cip-core-image-kernelci.bb
> +++ b/recipes-core/images/cip-core-image-kernelci.bb
> @@ -10,6 +10,7 @@
>  #
>  
>  inherit image
> +require common-image.inc
>  
>  DESCRIPTION = "CIP Core image for KernelCI"
>  
> diff --git a/recipes-core/images/cip-core-image-security.bb b/recipes-core/images/cip-core-image-security.bb
> index 3421ce5..f114974 100644
> --- a/recipes-core/images/cip-core-image-security.bb
> +++ b/recipes-core/images/cip-core-image-security.bb
> @@ -10,6 +10,7 @@
>  #
>  
>  inherit image
> +require common-image.inc
>  
>  DESCRIPTION = "CIP Core image including security packages"
>  
> diff --git a/recipes-core/images/cip-core-image.bb b/recipes-core/images/cip-core-image.bb
> index 0ec7220..711d3d3 100644
> --- a/recipes-core/images/cip-core-image.bb
> +++ b/recipes-core/images/cip-core-image.bb
> @@ -10,6 +10,7 @@
>  #
>  
>  inherit image
> +require common-image.inc
>  
>  ISAR_RELEASE_CMD = "git -C ${LAYERDIR_cip-core} describe --tags --dirty --always --match 'v[0-9].[0-9]*'"
>  DESCRIPTION = "CIP Core image"
> diff --git a/recipes-core/images/common-image.inc b/recipes-core/images/common-image.inc
> new file mode 100644
> index 0000000..863f817
> --- /dev/null
> +++ b/recipes-core/images/common-image.inc
> @@ -0,0 +1,13 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Toshiba Corporation 2023
> +#
> +# Authors:
> +#  Venkata Pyla <venkata.pyla@toshiba-tsip.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +# Install in build system for creating reproducible DOS filesystems
> +DEPENDS += "dosfstools"

Why this now? Patch 1 is adding it as IMAGES_BUILD_DEPS, and that should
be enough as you correctly analyzed. Do we want that change rather in
conf/distro/cip-core-common.inc?

Jan

-- 
Siemens AG, Technology
Linux Expert Center


