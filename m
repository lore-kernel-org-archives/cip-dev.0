Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECE3C001B0
	for <webhook@archiver.kernel.org>; Wed, 16 Aug 2023 12:47:49 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.71])
 by mx.groups.io with SMTP id smtpd.web10.159841.1692190061232268092
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Aug 2023 05:47:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=YrJH8PhU;
 spf=pass (domain: siemens.com, ip: 40.107.241.71, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MK0WEn9N6RCjJMgdWNgIq5rVH2vnSBx0sjN8vdT6+ouVz/H6MTw6EIMlrqMZX7v8N0vlBRVKoPB5FRK1LByULTEMnU+9JrgBe3FfWam7HNMVtJdAuUGdqNvvZrLCB+OYDevwyxrn+udb7EYz3wA4rDMlYmWKfW55+qOnbgdfJw1DbmYUy0oxDWH09G1xaimdGPrL1GQFEBbk2nyCOEqSPddvgpnyaecPmfu9/+m06PjhFkLiebCj3bnNbIE0hgau8ffUMrtFqdKSJWl+j/oLrJipbIw97IwmTr0I6rqCwu9Zp2lBSWfXH3EaFoMUXtSc9HOtuY0UvTQGVfukbdItHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+mbZaOnUHDvSEp3qieww1vIlc4TyGsqyT6KL18m/Np0=;
 b=kOxEBIEvtyl+oyY2W+tib5/jlDBAOm2BfgtcTj6x6DZzCZEK9zHHdLXYtorxTZEtzxEamD8e0tpmbte/2PlWlCga8aq78TtVBJSf/sGUIfTtlztUsqcSOEdcLTfct7OPzswHvsgoIlEhx1ASC+BA7XWOenjPpP6f0wIdT3mtgkP/SYIzQ2aqClGr5uIt5zrIMYtf90suHq5EWcLIaRarwgi7TAYTHj1nFBVXq4SDaIrRsHIeqiNFkWv5zSjIQt1zcTnRte4paM1mqubu2a1zbi4r/Qy1gTntUjx4WMwZDE+bM4H04LqU8pous4z69knKH8UDikk06Aa9BctwFA3lSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mbZaOnUHDvSEp3qieww1vIlc4TyGsqyT6KL18m/Np0=;
 b=YrJH8PhU/2SAFI5vrkpA/JH2QCT5Ru9rq1uhajvax3c8Efi/9aTkBwtdlFBmpUQnenYhgNVaD4u0+O3ktg0bFwTSKX4KQEjGsQODXkZvVBzQOz3fdLgGk3rF6X8gR5CnU+bVF2678NEK2VQkSKZNGpbqtLQdzw4klWz1pm2Bg4HobLLtFnLrdJ2Oy2exO7LhtZwg0EXmyRr5DqPbxMt79wBSGb7SWcQTSJ1zr2uIhaevtTYp7sJ/+b9X9wWXOaHalj0M8MQMT5rQjd78T+ywEkOrDQ6oqyewxU7z+kmrBULorutlQR1P3nhGsYgB1zdikoa3c+jOwxVSvbN3yQbo4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB8066.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:384::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 12:47:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 12:47:38 +0000
Message-ID: <e4fb5477-18a7-4c65-9caa-4d647dae6a07@siemens.com>
Date: Wed, 16 Aug 2023 14:47:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] .gitlab-ci: Create amd64 release
 variations for KernelCI
Content-Language: en-US
To: Arisu Tachibana <arisu.tachibana@miraclelinux.com>,
 cip-dev@lists.cip-project.org
References: <20230816080300.5559-1-arisu.tachibana@miraclelinux.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230816080300.5559-1-arisu.tachibana@miraclelinux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE0P281CA0028.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:14::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB8066:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b286551-340f-48b8-6acc-08db9e56f8cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	SkztH6fMQsp5zehcg8LQfkFsaewP+SPm3oBwMbLZzpNwEOHQwfZYiUkKfJmVN53HWeDUi4O0m20IVS8a0+L/owL/YfZpldl7Oewz3lQcqdsngBNTfTEDDdKw6AL67HRa9Ty7knXpNFm0ER0QArfifnCFhyYlxpClMEO+wwSr7JMB0v20DPEU+5rNXb929cwnSKsuzv+bXvlkk2/+Jj5kpFo9302klcig6H4blb9RdxQIiWO9KNUJmejq1jPE7F5smFl8LBgbH5wa683HxmbPtVJM71KIBAFh5KREF0rslqs67QyPFOfqr3jQ3knLX2JhFUkS4+Hu0JYimbAjvvB5Jd3SP79uGetxAb1GNaoBN8MMzB46zXkWC2Wtvx9hRYxFVbzlZu8Kkl8SsjSsFd2PMu/s41RRaTp3m22G/1JErATspqnBLm7SJx2c3Fjqri6Ie57eXK3RlTCc2gA/y8I6u4wPGD/b+HVmcPbQ69E2GGwTTDZv16xYdQ0feX97QedpB9rtAkJ26yBHPjkmMthWwegYL26pH+Ij6ar/f7tqWHIBu3UFSwjCdOMGHK0XXMeGmYe48DEVnefH8EwuPCzXTvG6nEmOJD3QlalCuMaRP9sZnvthkhD5CXCW5yL11e9sDnkFzktXFL4az5GTOYk/LQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(1800799009)(451199024)(186009)(316002)(66946007)(66476007)(66556008)(41300700001)(5660300002)(44832011)(38100700002)(31686004)(8676002)(8936002)(82960400001)(2906002)(83380400001)(26005)(478600001)(86362001)(31696002)(6512007)(53546011)(6506007)(36756003)(6666004)(2616005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZEpmcUpnOVZPeWp2ZThIZ2VDVFloNSt1VUVQS0FzSkhSL1k0cFl6c2tQRSta?=
 =?utf-8?B?WTlrdG5KUXNvTHJGSERmK0RNcmJPMDA5QmdqbVg0Z1dsRUtVcEE5MWdvb2ds?=
 =?utf-8?B?Z2FXaVZxazdIVzk0cWxwY0g3ajJjaVp1cW5HSGswaExVcWdPZ3pBMzFzZjNQ?=
 =?utf-8?B?ZFEvYW1zdmU2RlIxbzBsWXVUaWJvQXdPdDVKM3RGQ09DWkJTUHdKOXhpdERK?=
 =?utf-8?B?WmpYMDNkTWV0RitScWJ0WkZhMmk1RFVLTEtTY2pBTEFJNjhmSXlMb1pVU0dL?=
 =?utf-8?B?MGd0S2kybkE4M3EvTjhHdkM1b3hwSm5YajhRMVlxN1pnbXBtYVBjenpvVGhw?=
 =?utf-8?B?UG00N0RpTVRwamxvZjcxbU5CaGw4VVcySVN6b05MVk5Xam5vTHRpSXFKMmRl?=
 =?utf-8?B?OWladlFiUWkzRGpXSVpBUW1LRDduRlpDZ2NxSE5ySTZ3VnZRcnlxR29FWUc2?=
 =?utf-8?B?dE1LZ2w4OVdWWTdGazMyOU5lZkx2Qml2NnZVY1VwS2UxTWlRby9MbjlUTTlB?=
 =?utf-8?B?dm42MktELzJlUDRSQTRzSGI4bkFpeXBCLzVRTUlML2FXK3dxUTRtSTlGS0NW?=
 =?utf-8?B?QTZNaW8zOXpCRHpySmZmL0NYNTBXYTAram1SMU1OSVQwQ2hCU2ZNcGdReTE2?=
 =?utf-8?B?TFNObDhOQ08zNCswNHJaSmM4OTBHVnoxMXUrcE9DaWxQZHZiaDFPYzkyUkE3?=
 =?utf-8?B?cXdkL0tjT1FOdnRpWXNGKzVPK0lVMUZxNGluSHdWNzVCTmQ0REtkdXVxanY3?=
 =?utf-8?B?TkgwZUl2dlRJK0pmQy9BNGVReVU5QkR5S3NDVHBvdUh4ZWIvQk9sOTZhTUJF?=
 =?utf-8?B?UzFJUTM3ZGdESWZIOVl3cGY2aDVPRVhJUGRwMkJIM21IQmw0aUR4OWk4Skts?=
 =?utf-8?B?cGtzOWdYZlJQNlREazIzUFIxeU52KzdtK1M1ZDRzcklaaE5tWEpLS1c3Zitl?=
 =?utf-8?B?dWpFVVNEbXBwYTFBNXlOTzQwWGJWY21YOXk5Y01ZRyt6QTZFbUVqOWUxV016?=
 =?utf-8?B?NEt4VjE1TzFyK2hTRThxY3FxYkZkOGQ2R3h0VlNmU0ZsQlRhZFpWZFh3czYw?=
 =?utf-8?B?aHJuZFV6L25lb1dkRTFrelB2bzVjUlNIR3RqTUdzSi9NTnJUMko2SkR6TjUr?=
 =?utf-8?B?NVZFK2JqaVZpVVZDQjExa2t4eFBHSlUyTFM1YlorZFJoZUhjU2k2c1FNZTIx?=
 =?utf-8?B?eTRGTmVON3gyUkFRVlk1NWRtR09KT3FYVld2cHVjSnJxVHNLMEpsb3NHQlVO?=
 =?utf-8?B?b1FQZFF0ZHVUZmczS0RTcnJnOE1EOHJ6UjQwOXF3ekdwaXNDcHRDUTZGVG1h?=
 =?utf-8?B?SDNjcmZJMUQyaFhVYWsxMFg5dG9IaG9lR2JNaENJV0RXN3lDSkpCSGZZZmI3?=
 =?utf-8?B?UnJYTVBUaENsZWErMFJJclh6VStlVmc5WVYyY3duWElHaWoyblh1aGI1NVNM?=
 =?utf-8?B?aFZ0VEFsUEZFaFQzS0ZhTkJ4UWFRMFJCZDRWM3Q4cmlnV1psTysxSlRTUGFj?=
 =?utf-8?B?VDRKbkN1dVBiVnJPRjN1RExKUVVFNU8zS2h3Ymo4T084SXFXUm1UcDJBeWlo?=
 =?utf-8?B?bk5XUW4zNnBQeHdJaENObnc5Rkd2Q1VmWWt1UXhnWUhZbTNKVzhaK25xaTZp?=
 =?utf-8?B?cWtjSkRCanZpS0RRc0sxcHNYQWpsQTRObCtCdGlFNWRqWHAwMlljV1NzV0hE?=
 =?utf-8?B?Z2RuREh2Qk93WTNxdFJiTnBHQlRXdXVEMVhUUm5GV1dkMFVBWFBvbTBZeFRJ?=
 =?utf-8?B?TXd2R0F4QThPMCtDSmlPdnFoaWVOMmRWdzFKa0U5SzhBdHRycnhNcE9vM2NF?=
 =?utf-8?B?eTR0OVE5UGlzT1dZd0NuS3dnNmdqUitycUg2UnlIQ05TOVhKSDFlZXNOVGNT?=
 =?utf-8?B?WlI1dVpERVB6Q1BoWXc0S0hQQStoMTRaVyszMG1yT2xocUhlRERJenV2d3hh?=
 =?utf-8?B?TzJaMnRCWUN1WDBDVjdZRWVxaHYvSkJ1bERpMnh5U0hFWDBEeFNYREJNa1B0?=
 =?utf-8?B?N0xHV2dhUEV1WGtPaWpsNXVva09INytiUGtyMXNHUHFRM21VWXJvUnRMcGx6?=
 =?utf-8?B?bEk5TzRYcTY3Q053ME9XM2kzTktEVEM4aTBvdjcwRDEwbm12aW10QTNxSWUz?=
 =?utf-8?B?MDdzVHk0N0NsSXlIQ2FHazBCLzJGb1hOa3VJTHNvZ2IxRGd0YVJMdXhnMkFx?=
 =?utf-8?B?T1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b286551-340f-48b8-6acc-08db9e56f8cc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 12:47:38.3427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SSFSkXYao5HMmQrElQJpVvc2+853zBBm20D17E9lKyeDYz5XxwsYV6c/x50hDLiJkWkdtV4sDkNUhPpIAMPj0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB8066
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Aug 2023 12:47:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12674

On 16.08.23 10:03, Arisu Tachibana wrote:
> Force the creation of buster, bullseye and bookworm images
> for KernelCI storage with GitLabCI
> This images will be tested with the relative linux-cip 
> kernel version
> ```
> buster with linux-4.19.y-cip
> bullseye with kernel linux-5.10.y-cip
> bookworm with kernel linux-6.1.y-cip
> ```
> 
> Signed-off-by: Arisu Tachibana <arisu.tachibana@miraclelinux.com>
> ---
>  .gitlab-ci.yml | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 892ba92..183efcd 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -101,12 +101,39 @@ build:qemu-amd64-base:
>      wic_targz: disable
>      targz: enable
>  
> -build:qemu-amd64-base-kernelci:
> +build:qemu-amd64-base-kernelci-buster:
>    extends:
>      - .build_base
>    variables:
>      target: qemu-amd64
>      extension: kernelci
> +    release: buster
> +    use_rt: disable
> +    wic_targz: disable
> +    targz: enable
> +    deploy: disable
> +    deploy_kernelci: enable
> +
> +build:qemu-amd64-base-kernelci-bullseye:
> +  extends:
> +    - .build_base
> +  variables:
> +    target: qemu-amd64
> +    extension: kernelci
> +    release: bullseye
> +    use_rt: disable
> +    wic_targz: disable
> +    targz: enable
> +    deploy: disable
> +    deploy_kernelci: enable
> +
> +build:qemu-amd64-base-kernelci-bookworm:
> +  extends:
> +    - .build_base
> +  variables:
> +    target: qemu-amd64
> +    release: bookworm
> +    extension: kernelci
>      use_rt: disable
>      wic_targz: disable
>      targz: enable

Happy to add that - just wondering if adding those two targets may allow
dropping one or two others which are implicitly covered by this now. Did
you check that as well?

Jan

-- 
Siemens AG, Technology
Linux Expert Center


