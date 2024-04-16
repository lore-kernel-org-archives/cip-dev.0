Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A60C4345F
	for <webhook@archiver.kernel.org>; Tue, 16 Apr 2024 16:34:45 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.88])
 by mx.groups.io with SMTP id smtpd.web10.25906.1713285275036770602
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Apr 2024 09:34:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=MuD5GGdC;
 spf=pass (domain: siemens.com, ip: 40.107.20.88, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZfhQC9hC+vajUaVTKa5khy9ConoBIJZwNNvWmyVefBDkrxmJb+tjwFKB1izwWHI50GyW/ZasSJnMJNKoTJ3qMTvNLuLvtyqrJ/qcbYz4LLcBeLYcaBxO9NY0imZT659XZ6Pfy7sSH7C5zE56Bf54NqVxQdfgENdE5V+00vYDjiBoA7rDYfWtEQWas1mAoc0WFRaJTkY7dUkozRnY5jobPsuFOFnrufb6YXAXHxXk6owKO74IzP/1kNav8w7q4BoX9+MrGO3pK93GgUewAKY92NinX9oS0wVxqXQfT7hTIkGx2DcWyJqfSu7FYVwNZ/A4fqPkh+YQ77zOJSje7yFLMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tEN95twoRrpG0b7EYuz+/KjaphjyngKvFda75jChmSQ=;
 b=D1ftkuMzwovjQrMocZu9CZug2qG70D72g8E5QL4piY2XZ+qWnbICoJ7BUNj2C5pDHd9zCgLa4oOkX2yFCR+vI0sKi8hGmDgSDbCQ5/uMEsw7H1vh9TTVkaoejRtTHhbg9CiE10cnrOVZ9nc9yoGjEpOl/s7xU2RNIr1RnVrWqAgHO1FxyJOFifnUEeBIYzCmOR2SjWtryX15k9sM3mBooyQ20vowKEKqIFYwMAcxqsnjNPgh53HwRjKJWRDHhP16zbZSCDCw7KShOTep4Tl8ggQu7AwpJfwXqAOsv71ljO0SCSwpRFGAZJdHQMtSGHG7htxlsSkyn1eHHFEyQv0x+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tEN95twoRrpG0b7EYuz+/KjaphjyngKvFda75jChmSQ=;
 b=MuD5GGdCOgO35rN5uGyeNnnygsHJBdo0Xw0PyIUv0Vt/bt6/kgB9/SO4058SWeAFgaIWQZ/QAgIIBzxjqrGyyCLCHm5iGE+PWKbbHLyOG0Anqgncu1qIn4WNwyC1YHnUE6wp0L/m3wcSOR5tB7OefjZfk5COA6JNV+kaGyGvmzZFOsf+oCgK66e49dC6da5FrCIurJ+F2/9I7faipyJJKcOiEjSwGKtFXCaQjtj+Ic3pr2L8c6gOB6wvv6J6QIpaYylnLNlWVCxqvDN81UlQQ/hvas3Asg4p6brn+RaUdccdT8jvEu5uW3R/6nc8d0LlOuAUiSJdnnQe2mIIz+XysQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA4PR10MB5756.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 16:34:32 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 16:34:32 +0000
Message-ID: <f16d3d18-388d-4156-8748-4fc926d9e2b0@siemens.com>
Date: Tue, 16 Apr 2024 09:34:27 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-core][isar-cip-core][PATCH] fix: swupdate_2021.11 with
 efibootguard
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 hannah.kiekens@essensium.com, cip-dev@lists.cip-project.org,
 tobias.schaffner@siemens.com
References: <20240415095749.572576-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <20240415095749.572576-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0147.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:346::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA4PR10MB5756:EE_
X-MS-Office365-Filtering-Correlation-Id: fd104189-9656-46bc-b6f2-08dc5e331833
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Q5I5ls2PQWt63ODxvxOKAChnCtk+ICS840lihyFpKDWQb4YsaT9/wrzEysfkJ3uk/I/U0SBYIJAaZ/42jheeMZDNV0l6Ymjp/1qeXANKtvyXQQe1KZ2gouQ4Luy5QnxeUHoIfZf4lGdiipBA50Hs2bHl2rFWjQ+6ktiW8bPSKAb0pTKMw4wm2VxaLUy2H9yHCWVz0UrumY3BZROa+vEOJob7fy62rLGwjpBCaH4mYcONs6CsR2+haLbou9uGrR6Hs1Xg20T8C+r1BFkpbt1B3eKxh4Sd2XYH8gp/zTif1rHQh2l6l+OSAEmd+xaU2d5XOV5E0v+XsyoEy1vy/X0XN3xDaZVMI5xxQ674rKtvYSiFCT0CwBEJMW8ugWbpT/SiRCJH6hcgo1sAJVrrbJgcCD3fTUa3z0AgWV97e4iHI1BnFzkQv9TiDxyZd1OUSyPSfhfroPZ/NHXclktng3XhkOZz3IeC/0Pd0tZ1v12XpTc6lyewpQeveGmD89V7BQxoO58SInfUZ8SCK3kiEpqMHyzUhfwFBG35q2f+3dFFdrdUHBD9KDisV1O+nDywp3xVVZTnoRu2aI/eKUxf/a+JdaNWvwOSmnU6nxG/WNKOCgKKKO4dvqSVFU2zpANNp0G/5FURzIUgTYonvKTThQHjqXbtDE+1BCbGqQReEkEe8Bc=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VXBsY3pHR1pDSTJxcFFIZ1kxYTFTVTB4WnlzYmVqSjVFWlA5VlBIci9MV0RW?=
 =?utf-8?B?MGM5aThibXlYVEVrN2VEeFFCQkRnRDFKRHRtT1czMHFOVFFETG03R05CV3k5?=
 =?utf-8?B?SXR4bHBFL0Jickh2WU5waDNVZjNSSTdFa2RvU3o0cUlid25rWXBxOGpGejRF?=
 =?utf-8?B?STZSeXVFbHIzZkhCTGNXVjZNdVd3TGtLcy9TcW9zQ1dIbGl1TkRvWUZlaERq?=
 =?utf-8?B?TTFEUW5tWUd2Y2xaWEU3dlMxNnRzUmVZOVB2UjhQYnFHSXBBVVF6NDV3VFVt?=
 =?utf-8?B?WEEvZ0hLQzdWaTJqcEJpVGp0akJKc2RkbmdidlN3eUdueTQ4YksxV3BBWlRs?=
 =?utf-8?B?ZDRGancvZXVlUUR6NXlFQlFRakszM2hybUVvbWZZdXZsSWJHNEQyWlNVVDla?=
 =?utf-8?B?akdkdm0xcUF5VkhxcU5CTnlkbS9jamVNT1AxamEyZjRNdU4zajZCaTJhYm1j?=
 =?utf-8?B?ZlRlak9QSVlObzc5Z0c5SmpXLzVXRmpEL1NmMDBySGV2akowUCswSVA5eXFr?=
 =?utf-8?B?ZHY1dGxYVWYvZnVpK3ZIc1BrTEo4M0FYNFB4RVp4c2QwVUxXMGwvcnk3MFNB?=
 =?utf-8?B?dmc3akdVdFBMNWxkS3o3djlOaXdWaEdrVXNHb1B0L28rWjJCM1NXN2dtNkY2?=
 =?utf-8?B?cVRBeTlEQ0hTZlQ0ZE9GTUNtT0Z3KzZXWkZkVnF2d0lUR1JTWWdJdjBaQU9t?=
 =?utf-8?B?S0xUZnBpbTRtQS9BVGs0V0d5TkwvU0ZtUE5pYlBERmFaU2pTUVpSbG50WDBi?=
 =?utf-8?B?V2NsZ1VnZ256R2ZSR1UySGhldDN5Znh1OXNsblhoRHk2dTQvY3hYc2RmNVNR?=
 =?utf-8?B?ODNKakRSUnVhbk1rU0JNcVpwQzVVZ3J5b2czVzJxbGU1N3ladDU5T2FWaVFp?=
 =?utf-8?B?OWRWd2RBMnNLVnhmOXlvREhDYWVvcWlORmtxVVBBdUtqWmt2b29EeFRHcVU2?=
 =?utf-8?B?RXA4SzlDaGRwbUZvNjVpWHQrQ0Q0VWZLakFQZ1B6RTlsOU9DLytMd0xxNUsy?=
 =?utf-8?B?cmppK0FpZVdySy9MdDF6QTlYWUJLSUtzVm0wK29yQWZmREJjcU9ETjZUZVJn?=
 =?utf-8?B?Y3NTYVViVHhIL1ZlUEphd1gvZm0vVGV3SzVIOEgrRHh6QXhTR05lenRqNHQ4?=
 =?utf-8?B?THVuNUF4a25BY3pzWklNYldmbG1MS1Y1bWtaT2p2TmovSzAyUldIdlZ5c2JL?=
 =?utf-8?B?UEUxQmN1V05sWVFBUUxmNCtrL1ZBbXNJL0ovc0NUYnRVQmpUK2wxNHRjZmcx?=
 =?utf-8?B?MitLb0ZxV0kzdlpXeUJDT0cvdFFkYkJWdmxqYXcvRk5IN3pYVXQwUDN4MUVx?=
 =?utf-8?B?a2oxSXY0Z2lzd3dOTGlxTnd5UG00Q0hIcEdnVW9jdVhBTzFsa1JkU2d2amRi?=
 =?utf-8?B?QTJ1QkVKNS84N1MzWjZBTmtTbjJMR2lzdXViaTdNY3hLQTJOK0lqZ3VPS1dt?=
 =?utf-8?B?ZE1XNFZiNGtIbStvQThoelhCMFcrdGVyMlozanZKSS9zbDNleVF1cldXOFVG?=
 =?utf-8?B?SlBBSGdvWVJLeXJBY1RkUjliQm9ud2cxSE5Jc0ZaMHBib3ZYblk3OVAraGJi?=
 =?utf-8?B?M1dmV1lpZ3Y2dThtTDg3b05jalhSRjJyTmk3Nk9lcUVueGx0bWRvN05RWVpr?=
 =?utf-8?B?WlZ6RndZWXZDM2JVdzNRdWpoTkVteW5pR3VRK1FYS0J6cFkvSndEODJUTUJ6?=
 =?utf-8?B?Q1FNaFZ0N2UwYVd2TlhyU2wzUStaSmVTdnBqaU90OFZtQ29sN0xlZm5obUg2?=
 =?utf-8?B?dy9wT29oRGxRV1FyZFFsbUVUVjJzUnNDV1JiUXZyK005dC9ETzdLb2w1akRS?=
 =?utf-8?B?N2lSRGFmSmVHMDVESzNnd0tka2RZZlo1V21XRGVhZzlLR3NYTytISitYMzd1?=
 =?utf-8?B?S0hDUUlPazUvSUR0bFhQWFJNbERoZ05lNXM5eFJJQnlyZ0VxT3RpbTBab1lX?=
 =?utf-8?B?d1ZEcWE0bzZSY2lhaXdGd1ZDcTdyb0x3MldqQTFTRjFhYkg4TmFiTElGNE5D?=
 =?utf-8?B?QlY4eFdKMVgvWm4zVFQ2VkFHRDlEa1dkRUNaOUJsemtSMXBpWmhVNUd5cVVw?=
 =?utf-8?B?bjZ2d21JUWp4L2p2MUNJMFBUL3JFNXdadU90VFdZSkVVSDA0NXMydkM0Uzlu?=
 =?utf-8?B?eTIyUzF2bWpMVGJKdlRyK2RUYlhSQWlrQUU3ZWFWc2FVUktPUSt5Nnp1cy82?=
 =?utf-8?B?WXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd104189-9656-46bc-b6f2-08dc5e331833
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 16:34:32.3172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /TKGwj0DrYkpGkwQ3b4nXn2ABzQ7toZIu4nlCrJPOBcz9GZpdYtSVb1vzy+Jbc/EkXYqpSin/AVjZgrGTK3gbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5756
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Apr 2024 16:34:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15569

On 15.04.24 11:54, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This fixes a regression introduced with
> 5e2c207abae61e073bc732d0b93ba390891cd0c7 by readding the bootloader
> selection with DEB_BUILD_PROFILES for SWUpdate 2021.11.
> 
> SWUpdate 2021.11 selects the bootloader at  compile time instead
> of runtime. This fixes the following error message during installing
> a binary update:
> 
>  [INFO ] : SWUPDATE running :  Installation in progress
>  [TRACE] : SWUPDATE running :  [install_single_image] : Found installer
>  for stream cip-core-image-cip-core-bookworm-qemu-amd64.squashfs roundrobin
>  [TRACE] : SWUPDATE running :  [notify_helper] : Round Robin Handler: No
>  compiled-in config found, trying /etc/swupdate.handler.ini
>  [ERROR] : SWUPDATE failed [0] ERROR : Round Robin Handler: Error getting
>  key 'kernelfile' from bootloader environment.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
> index 0039116..bb98ede 100644
> --- a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
> +++ b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
> @@ -33,6 +33,15 @@ SRC_URI += "file://0001-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch
>  # DEPENDS += "swupdate-handlers"
>  # GBP_DEPENDS += "swupdate-handlers"
>  # DEB_BUILD_PROFILES += "pkg.swupdate.embeddedlua"
> +def get_bootloader_build_profile(d):
> +    bootloader = d.getVar("SWUPDATE_BOOTLOADER") or ""
> +    if bootloader == "efibootguard":
> +        return "pkg.swupdate.efibootguard"
> +    if bootloader == "u-boot":
> +        return "pkg.swupdate.uboot"
> +    return ""
> +
> +DEB_BUILD_PROFILES += "${@get_bootloader_build_profile(d)}"
>  
>  # modify for debian buster build
>  SRC_URI:append = " file://0006-debian-prepare-build-for-isar-debian-buster.patch"

Thanks, applied (with one extra newline).

Jan

-- 
Siemens AG, Technology
Linux Expert Center


