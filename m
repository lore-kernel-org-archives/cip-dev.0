Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D112AC48297
	for <webhook@archiver.kernel.org>; Mon, 12 Feb 2024 18:38:00 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.41])
 by mx.groups.io with SMTP id smtpd.web11.14507.1707763079413686254
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 Feb 2024 10:37:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=uSu06cT2;
 spf=pass (domain: siemens.com, ip: 40.107.104.41, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZpRyKqpDcsDztKcyX4C2dU+8DrZISKDsSoVNq6F0oOFLAbcrGq2xNjjtP5unq/ZP2BrxRhomTzRavviu5WoViAEuaMYT4zWsptUA4V6sJATcnSlmYQOIS6t6f9cyTz5QXr+mWowqz4N05wDqRCsIpVoYyeusLptzgoN3dnfGo1zt6hT7E8d/BGKKFOpATAnrdkkzdL6ShoHczaA6hXkWXknmAyo7tQ7SzVQ8SWocw5jhVCgHNde4o2LeiQiwBflgG/eD1hBnrc2Fs4rHcjxLWPv2HbUB00CXteFM+wvQniWfUMY80BQjfngmdUQaMFmZ/79DfDmy7ZKsVk7JxiQgYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ro97MEQcLXJOrt4rMOmFxByaSNFLAgd8Pc/b89VxHD0=;
 b=IWIKvS4S9pQKmbnb6VqfQRN0GmYrw/GB3yansbK+A1yt+zfp96MzXKKMx0ZmKY6dF2w5L24pZFMRGnr8FQT+F8dddm2dLjOsjdBd2ObYXuJqsKV75SCIMvdFRW4H9Jfr1Qk2BjUOyBbBldm7zhHzQEqglp/UKcvzsmIDGAbb+cxejdGSNlBFMk9tGfxi7/EHtTdr0S2w13NqJdIyTk+i+wCi1sAi1WpVWJxTFbkp1j0KSC0SQZj3vj/tLWCOSm7kxObl1D1AqNAdZtCfyqLSz+2G4uPiefYPBxiwzcoeM2bOziFeoscZCJf0LgqPVJQuX1/kJ1eEkyNLQLxmzRNIGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ro97MEQcLXJOrt4rMOmFxByaSNFLAgd8Pc/b89VxHD0=;
 b=uSu06cT29q6COu31cexrMYvhXlBwAgiOoCI3uy4/DZyTMdStI72ugvY0OlPuxifbFg2R6weuWYhb7oXBuu7QNDO4/qK0eCxtEM3XsSN9QykAGHZHKp60qbFb2MhzxyHMQWxjV+8sNkQBbaR3tXUHfq30rYrpm4Qz0HBaKLCm5viy++muO55MuU+IXP3pA8mYC2OXYPjK8eUGCnAbMUVjvBtL6XIKbZyRfacbI9HznJKG+MgibrxLo1OyvCzf/y+9dVbKuUnX7lNpC55O2bBpikWVmc/xC8gZMKBSAPuxynlLVOvdJcvUTMR3WbvR9uITEuyYMc29LBmOvAYeCoXLow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5577.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:475::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27; Mon, 12 Feb
 2024 18:37:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7270.028; Mon, 12 Feb 2024
 18:37:56 +0000
Message-ID: <3c9a0de7-fd52-46b3-ad95-9076449fb285@siemens.com>
Date: Mon, 12 Feb 2024 19:37:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC 2/4] swupdate: set SWU_HW_COMPAT
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com
References: <20240122123751.83696-1-Quirin.Gylstorff@siemens.com>
 <20240122123751.83696-3-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240122123751.83696-3-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0282.namprd03.prod.outlook.com
 (2603:10b6:610:e6::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5577:EE_
X-MS-Office365-Filtering-Correlation-Id: ec379786-b389-4618-8b98-08dc2bf9bb09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	qQDzjR2Pr3n6VrwWmeOeEC14sAgcrJhfLX4pIdQqdRDZYw94PC0r/Si36IFrLVKUJ6UJCCsRbamWBKXwEmdmMV77XzQw/lAcmPLPHQVER4sJQ6lVEyuszvtA97FG0M9KJ/c7ghlIQvvLt/rXPq3kOMk2BHGUnLsPe47V3vlaGL5j32ntzouh2TU9D5WEHeZ/i7NCZuq1wl95j7Q1l1hOlcR7ppesnIxP7DPCXZNRhwZC1OJThx3x2nXEQVHL8Mx5ChwCjKi3JsVEfdE8++d86NjtG8IL8WLmzy7gRdwoPEkC1XwPglPsCho6FQ72mZKsNnQYgpLeBp5vegMYc4ooev5XHBlMNmDokqxA+ISD4aNOK/o/1DZkjbjJMTr6b7+SpL4MvyPzn8q6LKf7Rm5S3i/hREWdvZtK2aQTP1UHo5u7P3Yer9X7A3Ta+yl9lCm/hK9jLrCsBt2GTUrxbOl9yWNLKYUcaqK7PYYFPfSu7z5/2faNmJiatWBcz7xWPNGVlPK+nfDJQnGQllLFDLduJCDvSjHF3JfqhcPt9JXOhOAH81SvF+pIebFFFEXW5aLi
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(366004)(376002)(136003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(44832011)(8676002)(8936002)(5660300002)(2906002)(83380400001)(2616005)(86362001)(31696002)(36756003)(38100700002)(53546011)(66556008)(66946007)(66476007)(6666004)(6636002)(316002)(26005)(82960400001)(6506007)(478600001)(6486002)(6512007)(31686004)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QzkvTGFNaEdRcHdMU3FLQXIyV2Y3VTF4K1lERjB6NlJRdkppVlRpQVp3c2ZE?=
 =?utf-8?B?eWgwUG92Z3ZXYWRKaXN6M1I5aWFuVXNCekxMc3AybVRnaDd0bXRBdnBZczY2?=
 =?utf-8?B?c1MrNVRpV0g2M2xaYkIraGNvYitlM2ExTGQxZkpGb2djRGJHN0Z4K3pGQnBt?=
 =?utf-8?B?enhiNjU1R0IrUzR4cnN3NkN2RC9hMytJY1JUUE4rR0JuNlhjblo5UE5lc2Jh?=
 =?utf-8?B?aGJqdy9ZV3FDZUtTVXNSMU5HbkRybTZLTHVGMHlhdWs0M2tyK0QyZmw2S0Rx?=
 =?utf-8?B?VlZ1MnIxbmd2Q3RGSmh3eTh2VlF5MDI0azAzRkd4TTUwS1haS0c4c3BSUnht?=
 =?utf-8?B?WDlJT3MyUG1KNkVGeVBqN0ZIYVBEUlpDVFNJbkJqMG0vbWhZUXFFUXJxbENE?=
 =?utf-8?B?a3NuYkVmSUdRY0ZSdzkvNEJOencvZVZHNzJIelVtajJmMFpwUzh5b2VjbzFk?=
 =?utf-8?B?ajdUL2JqWUUzY2FsY1NzMlNTSVg1c243eDBIVU91dkZyZDJBekVUUzBCUjRC?=
 =?utf-8?B?dEthSk93SjFxRkxoc2xEOHVJWnpmNzcxWDdGc3dxMU5nZkphclh6Z2ZTcS9M?=
 =?utf-8?B?V29KUjh2bnBtdm9NaTVsbm1RUVZMRmNpREpwZ25LTXFTcjVkVlVXWlN3QUdo?=
 =?utf-8?B?T1NqeUdlbmxXV3d0V1hxelJjU01SMGhFMnoyay9QeExoMjBxbUp6d3VydTZW?=
 =?utf-8?B?bG1mbU5UdG5IeGdsNkRURTVWUGZveEJnMUUrbUhUOERWY01QMm5aRnF3dk9W?=
 =?utf-8?B?WWQ0NWZZdko4WlBINVJKSWpBUWswTFUra0JBVGFNSnh4V3U5bDhIb1J4cUFh?=
 =?utf-8?B?c0NRSDNuYU1Dd001cTA1WS9YeG1ZVUsvZkZ2YnJqRkJpdjVQN1VkVGZBaGpN?=
 =?utf-8?B?aDdkYlZrVm1GdTVMM2NhUEhIVWRwRWlhRVBRSnVZNWtzSkhCU012SmtOQXJG?=
 =?utf-8?B?U3NOUHlwT1JUSW5BMUVOYTIzdEV3K2t3T2NweFBSUC9aWXpISW1OemdXaEpU?=
 =?utf-8?B?NnJVeW1HemNWTjZXUFdqVWliTHBxa0E5TmV3NnpPQXdJSnZDZnlBdm5hTmpa?=
 =?utf-8?B?QU15WFNvek53RWc4Vy85M3VUWmVXUWd4clptOGFMT29UbU80SkRDamk5WXMv?=
 =?utf-8?B?WWs2OUFrYWV2N0tKaXNqVzZyenBOZ0lkd28xamlPZkRXUE51MUtqZ2ZpWU9W?=
 =?utf-8?B?c05QcmVlNTZCbW5YMWJSUC9ocWxjbVNEZ3dnYkF1UkhQK1RTVjNGUlhxOWlM?=
 =?utf-8?B?UUFRa21mU2pxNGJTdVZyYTk0Q2dZS1FGNDNYWDQwa3EwM0dmaWVJdG53RXc2?=
 =?utf-8?B?RnpTTTRrcW1NRWZKS3BTWXMyLzU2S2R6dCtsYk9MaGU4dG5Fa1NkbGJaaTFN?=
 =?utf-8?B?NnB2N0hGTWpHZVpuMytvYnZUWFNldDBSVEp3cGJiTGZ0NTJ3VUxuM1hlWTg2?=
 =?utf-8?B?bnBpUnU4WjU1ZGNFYU1oV21LL3cxUDNvdk0xY1ZiZ0RTZmwwTlIyL2h2UVlP?=
 =?utf-8?B?VzVPSVQzY2ZDTElXajlNUkF0UGN4WWJEdHRrSGJzMkgvWEErUjRtVElVdWV5?=
 =?utf-8?B?YjU4ejE2ZzBKdEx1ZHNUZFZCYVd4bTdBSkJaUlN4cGo3dm9HdUZsRmtrU3l0?=
 =?utf-8?B?MTc0Mm16SXFiSTc5VTNJKzdBTnFjMjZsMXoyYU1FRUdJaXNVaEFGVGlRTnZR?=
 =?utf-8?B?NlQvRG5kcFN5Skx0S3BhSUFoSkhFWTdjOFFsbm1MVytPcmtPUHE4ajlHOTV1?=
 =?utf-8?B?dHlEUlZOYnJkTUVpY1p5bmJkbzllU2RuYmdkUGkxTDZHOEtZcmRlelpRUHEw?=
 =?utf-8?B?ZldIQmxpL2pmVXpYRldFZTd4bVo5RmlZOEVhYjZYTHlOOHJoZmpBZ05kSkVD?=
 =?utf-8?B?UW1FNGhkY0FReHpET2pKVElQZXZNSmxlQXNnRlhVS0taN0ZHQnQ4T0R2aG5E?=
 =?utf-8?B?d0FyVGN6MjZSdDhvQ2tHMHV6Wml6eG1Xa01MdjZ1TFdJckUyY3dodGlxOXFI?=
 =?utf-8?B?Zjgyd3RpbGhPck5NbE5nQWJPK2UwSnJWMkZVMStYZmtOM1J4RlFTL2U4N2FT?=
 =?utf-8?B?YWRPWTk0SXVCcEkxenVUTEJKc1VTSW9rR2M1U0s3WGFNcXB4UWR0STRyZUVx?=
 =?utf-8?B?YnhqMTRXNU9rUDlHNlEyMFdMY0cxN2huSTc1Q2JEaWhqZDA4WlJKTmR3U1Fa?=
 =?utf-8?B?b2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec379786-b389-4618-8b98-08dc2bf9bb09
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 18:37:56.6671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7SzMO2cRWS7+/037Pa2DdaGIDDOvJ7gWxHsk67wV+EDjm9f4e5BIhpJILRgVna22YntIZ6ocsg/zull4644DOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5577
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 12 Feb 2024 18:38:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14927

On 22.01.24 13:37, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> With this item SWUpdate from Debian can be used in place of a
> build from isar-cip-core.
> 

How does this work?

Jan

> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  recipes-core/images/swupdate.inc                    | 2 +-
>  recipes-core/swupdate-config/files/hwrevision.tmpl  | 2 +-
>  recipes-core/swupdate-config/swupdate-config_0.1.bb | 2 +-
>  recipes-core/swupdate/swupdate.inc                  | 3 ---
>  4 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
> index 4983f7c..183503b 100644
> --- a/recipes-core/images/swupdate.inc
> +++ b/recipes-core/images/swupdate.inc
> @@ -13,7 +13,7 @@ inherit image_uuid
>  inherit read-only-rootfs
>  
>  SWU_SIGNED ?= "1"
> -
> +SWU_HW_COMPAT ?= "cip-core-1.0"
>  IMAGE_INSTALL += " swupdate"
>  
>  IMAGE_INSTALL += " swupdate-handler-roundrobin"
> diff --git a/recipes-core/swupdate-config/files/hwrevision.tmpl b/recipes-core/swupdate-config/files/hwrevision.tmpl
> index ec1d667..1eb0996 100644
> --- a/recipes-core/swupdate-config/files/hwrevision.tmpl
> +++ b/recipes-core/swupdate-config/files/hwrevision.tmpl
> @@ -1 +1 @@
> -cip-${MACHINE} ${IMAGE_HW_VERSION}
> +cip-${MACHINE} ${MACHINE_HW_VERSION}
> diff --git a/recipes-core/swupdate-config/swupdate-config_0.1.bb b/recipes-core/swupdate-config/swupdate-config_0.1.bb
> index 6991321..260c0f1 100644
> --- a/recipes-core/swupdate-config/swupdate-config_0.1.bb
> +++ b/recipes-core/swupdate-config/swupdate-config_0.1.bb
> @@ -14,7 +14,7 @@ inherit dpkg-raw
>  SRC_URI = "file://swupdate.cfg \
>             file://hwrevision.tmpl"
>  
> -MACHINE_HW_VERSION ??= ""
> +MACHINE_HW_VERSION ??= "cip-core-1.0"
>  TEMPLATE_FILES += "hwrevision.tmpl"
>  TEMPLATE_VARS += "MACHINE MACHINE_HW_VERSION"
>  
> diff --git a/recipes-core/swupdate/swupdate.inc b/recipes-core/swupdate/swupdate.inc
> index cb1716b..818b431 100644
> --- a/recipes-core/swupdate/swupdate.inc
> +++ b/recipes-core/swupdate/swupdate.inc
> @@ -34,9 +34,6 @@ DEPENDS += "${@bb.utils.contains('DEB_BUILD_PROFILES', 'mtd', 'mtd-utils', '', d
>  
>  DEB_BUILD_PROFILES += "${@'pkg.swupdate.nosigning' if not d.getVar('SWU_SIGNED') == '1' else ''}"
>  
> -# deactivate hardware compability for simple a/b rootfs update
> -DEB_BUILD_PROFILES += "pkg.swupdate.nohwcompat"
> -
>  # add cross build and deactivate testing for arm based builds
>  DEB_BUILD_PROFILES += "cross nocheck"
>  

-- 
Siemens AG, Technology
Linux Expert Center


