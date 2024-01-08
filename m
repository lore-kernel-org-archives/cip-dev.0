Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4506CC3DA6E
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 13:54:55 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.87])
 by mx.groups.io with SMTP id smtpd.web10.7115.1704722093002599629
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Jan 2024 05:54:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=r1uUXPE5;
 spf=pass (domain: siemens.com, ip: 40.107.6.87, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hi8bblGBmPQj0ibptfpA5MIVDuLOZX9e5JzpC5DpAIaQ21ftNHC9/Z2BU1IKmHSNGBqo2IRsTSx5bsmwfB4O+rGdiMuVKyyf7w0MJX6oe+KTL94ZTNaTeUY0nmT224FQTQ/MPymJtc9o/uL05rF05ujAInSqbbdJcoxxGkg44DAsk0ixkxo2XXtFjNnDTe682YKEHD2RBXhzeWw+KZCuPo6E54Z0fTMQknipFxMClYqQKYZtkfSY5C0wKg8nxzBYgWXtcNewBUJ9rxirc9+SBPuYmGA4yDgiVGT2mKK+mpR4QlKs8k7xkAotD9CSSDga2QvUk0QILTiu2RetQ9fdQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFNHgRgB5CbtpsIsI9OUYm9frO4SaszagkwMOsQGO7E=;
 b=JojpY0nK04noCQxBmfI3l37x0/oMjJpPvGsGQu/2hmHthBNNKUkGluGc7/6/50q0Yt4AXylJYlpcDvprOa7QiQeH28ADoC5uckPaLg0+rNh3c8F2Icds6/gIfb80+EhA3AJiaHSEowwgj+ZQg82adEYr7a80mMn+Ue4ZLHv5WM1BBj3GqYA8DK4fSY98UWTL9wID/pQ4LqblSHYAVXFww4bd53gktNPpBh6WFIwP09e/P+Q2eQAVcNpyXqqCYomn2sTqtmGbLgQ4xAbHao+yEQ/FLoKoUg5FP3hSreN0U13sF2Jt6uCt+h9TV9Xck8TOhS1cHgFNIdRHocR4COChSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFNHgRgB5CbtpsIsI9OUYm9frO4SaszagkwMOsQGO7E=;
 b=r1uUXPE5P5ZH3Fv03cibBGqzmwwZw8iYdOK4Jj53ROoZgNImY5M6x1in8nxy1mj3nv2VpTMUZkiCoYGeNcChnJZaPjb211+Ib0planFrEteCCI+AmxCKecuS/Q8Wjtfq2GFgvaw8vOCm8tG2mCwF5m95W3X4uiOFcf9E400MiKf4DggYhj490G+1xMIC/BKloMFyVFvkfYi91U4i7HnGXJxCcIcj+T3f7vW10wJsMc5OzF9cSPwy/wynzh2+YVcU20mnDN6qUm44B5PTmMju7Imu+r7YF4bNOemE3rFDOQOdXPwz/ynDqM6atETdYmqSrxlC9X4mSerABwJOFytdMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU2PR10MB7766.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:49c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 13:54:50 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 13:54:50 +0000
Message-ID: <13e760a0-bbc7-4ec5-8639-80c862aa387d@siemens.com>
Date: Mon, 8 Jan 2024 14:54:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v4 1/6] Move efibootguard specific
 settings from include to class file
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 felix.moessbauer@siemens.com, cip-dev@lists.cip-project.org
References: <20240108102638.2966221-1-Quirin.Gylstorff@siemens.com>
 <20240108102638.2966221-2-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240108102638.2966221-2-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0141.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU2PR10MB7766:EE_
X-MS-Office365-Filtering-Correlation-Id: b7d14ff1-7682-465e-1439-08dc105161d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	aq1zxx6aNRybifubNf2+LgtJkkwLqq9P3oyagwUP3iexucbFFpNkrAcqM/23DmAJBlxk2elP4dGF4jP/84HBb78zSL13K9NUjuR6g/24VT/zf+x8TVp493CBAgpPg6lvJ3yAYTgod1tAOY/gxAxTGgoE3RhsAx6DkD2RKXRUcbsHSRYViWr/fvxDxA4OvhyKLNX/Qd/HU1nPc4CiXfTu8NwvLIV5HnQHjO7vmSw6uZlEgvLV4FmDw3dcJdVdX2dDb1Qav6nWi2/TodltrBM9xHOLxUJO4URb50yQQwcDg5VsvDkb3jZMGoGq7IHAWfWxm8evhBMjzlHauW2fa6R+2WA2kPx11vJP4kAr8+wpUqB3jP8hFyNA7MAF0jLwkYEfWAvebJezHyYU3WDY5ipFwJCTWSP609wzwOQlM5dCTwFedsh/8p8dveROjcwWpNU0W+eoo8wtEQZbfIaavCpYBoQh3E4+KPDgdv8qPMtX7gC9sWWF9PyZ8YjdWSp+VRlrNusnByBPzrY9h888H+GCBTSVkD9nv+Wyu2fRHS4givTSBONejmD9p7a1lbAEtBg9Qv79zZCsO3mP4ggo3soyg2QmInOEGoA4aRAH//e4Cvh1wWguI0wBVd7plA/COqtuula/oesupSqNXGVi6su2zA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(396003)(376002)(346002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(38100700002)(41300700001)(82960400001)(31686004)(2906002)(5660300002)(6486002)(44832011)(53546011)(36756003)(86362001)(6512007)(6506007)(316002)(8676002)(8936002)(66946007)(66476007)(66556008)(31696002)(83380400001)(26005)(478600001)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RU9kbmo1TGxoa0EwZ01hVkg4YWtGcEtuL1RxcUdWTzRFVFIxbDJZZ3pZb3NO?=
 =?utf-8?B?S1cxL041NTJZcy9MY3hIUE1vTDhBWTNsQjB4RWNjN2JydU5LVmVhb3ZRRFJW?=
 =?utf-8?B?V211Wm12SXQ5UGhVY2Q1YnhBbjRoc0grcnorQnJqdHkxd1l5OHdxU05uZFNZ?=
 =?utf-8?B?amhrb05rRWF6WjM0akppUHFjL2MrVWdFanhuVHZuWi93NCswSXQ5RytObmli?=
 =?utf-8?B?Mld3RktmeE5CY1U2eldIZzU0cmprdzZ2MWVDTTFIYVc2VWNrcyt5c3UxM3RE?=
 =?utf-8?B?UDNqakZrRTNQL1E4elVLVTFFb1R6OHZrRTNxaFZGM2RITUk4Rm1CR0tieWxm?=
 =?utf-8?B?cWNtUjh3eHVJZXZZL1pGdWpFd1pydHF6b2pvRy81NVVaZ0VkQk1KMndIVFFH?=
 =?utf-8?B?bmxBTk9QbkRpK1dIYU9YUVk0UHNXR0wrS2xFK3E5VEtQcW0yRVRBMTV0VmFz?=
 =?utf-8?B?S2xhTkwxRzN3Yi93V2dKak9Tc1RGcG9xODkwbGtaekVCUVYyQVU3L1llMUVk?=
 =?utf-8?B?OUdKNWdvU1lYdlRzSUEwb2M2OTBYa2xqV1lueERYK3FaVm9FcnlURnkyaGlH?=
 =?utf-8?B?T0RHRUI1V0FCUWZIbG5Wbk1Fb3RDc3VxbUNyWEtrWTVrbHdOTEpGc2xncDZK?=
 =?utf-8?B?WENjN3h1emdhTXNaUnJaa1RxL09LdFpVN3VxV3ROUGFyem5rR2VWN1RyYzZK?=
 =?utf-8?B?MWd6VmlUeTZSdzAvN3g3Q0xITk51Y29TOGhocXdtemtPV3dacHU5Q0dNYWhF?=
 =?utf-8?B?RFBLMUhMNEJVenJHd3RmOW9zUDJLRStiNUlONXN0RWZEOTd0Zis0N1l5RmNz?=
 =?utf-8?B?MTk0VXVFdGw1K3Z1UWpidjFRdThFSWszejlKWjNHd3QxS3FMandPdndXVm5u?=
 =?utf-8?B?dVRvQUZ2SEFOSnhkdXBZTUduM0ZMV3dacXZ1VUJ3aUVneTdQQ2FoMnlUTmFV?=
 =?utf-8?B?TG5WaGc3REtBWUFvQWNsTjlVTWtwbnhKa1hHeTg5ZjhXYmowMWkzQTc3cW1q?=
 =?utf-8?B?dU50MTlVOStUYVpDZkdyWml1SEw2MkNKZUNHeVFXUUFYMnhqM3Y1dnFDL3lI?=
 =?utf-8?B?bzhKVVRwdWxwNEtJZy9tVTluVlNISi9sTVFTWGlCR0VoQWdDZjdxUURVT0N2?=
 =?utf-8?B?TXB3NVEvZVZJWHg4U0tGbEt0NlhNSVFQRWtsQXZQOFQ3M2NZRTlVM05EQ0R6?=
 =?utf-8?B?aXZnZVh6aUpLU1QvUmRlREtsOUdTWGpWOVF1eTZlTkZ5RlRMQ0tNejN6ZnBE?=
 =?utf-8?B?aVlBTmxPUU52bmJEMTYyVjM0SXdrSVlWRGgvTVF6WkQyQ0ZoeWhpTHBRRCtT?=
 =?utf-8?B?R1FuR0c3d2prakI2SXllSzFDU0xhMjlMbFczU1dEaXBoM1RGMTdob3QvNEgz?=
 =?utf-8?B?aDQvWG5ING4wQk9lcy9CWExLRG4zOEJrQ0pLTnlLSFVTcW5QSGVhM09hZEQx?=
 =?utf-8?B?cXF0ZldIaWp0Ym92MTU3ajFuQ1RvbmtLdm9kTlZjM2pxNWdWR1dVUXdhR2xU?=
 =?utf-8?B?WTh3UjY0bkd4b2MrY2xIem5DZ0QxYlhUcFRjdXJvN0xxdFFWajBWNjNLVW1F?=
 =?utf-8?B?dDVEYU51UVpFR2doRzd0NmFrMGZ2alZvaURkTjZ0SUNMajBaakl5UlBIc1A4?=
 =?utf-8?B?V0UySkNWMlVJZisvcXI4cmZ0SWdlS243a2NEN0xQZEZHTU9yd0tWMXN1VWRj?=
 =?utf-8?B?OUdUaUNvUGZ5Nk1qMmFzZ1JtdFlCM3BvOW9LZVlmSmtkVWNYOXBadVVvY3F5?=
 =?utf-8?B?UG9tazNyNEd2NWMvRndHYjZGSXRGY3dMdTJpR3VCU3hwOGVnb3VGQVF1aXZT?=
 =?utf-8?B?bW9FUGhnNmhtM2R5UTZISlJMdXRNTWR1NlFvVVp1TFJPWXpnN1BRdlZ3WTRD?=
 =?utf-8?B?eHREY2Nrd3BHbG9ITm1qSHpvTFJ5Zk5qN3cxWE9RSG52ZWNQTGthQjYzaHZn?=
 =?utf-8?B?bGNJM1ovN2pKemtSamVlREd2NlN1U2FuaVg0Yk1tYkVDd3dhUUZrM1JmSFFT?=
 =?utf-8?B?OFJVZ2UyeThQZDE2RUhUc3YzSEs2YWVHb3JyTjA3enhHanpYMjFRcE1FZXRj?=
 =?utf-8?B?NnFDUzgyK0RUOHhSQkVhNXJtM2d4dDFOaGxuUUtIYVEvUzBkcGFDeE5MV2pt?=
 =?utf-8?B?LzgrRmNQQ21HUzRJdFdVckxuK0wzUm1EdXpTWHBkYTZkdVRsRUFJZklscXBQ?=
 =?utf-8?B?OXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7d14ff1-7682-465e-1439-08dc105161d5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 13:54:50.0663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E6o2Ko5epcuX/KGUsZ40k9KQQ9UI4FLtWwWqZSrShKcK2rSCiMZwTNyX03zEIAvxLDO0xejWDnr3T7fhufitCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7766
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 08 Jan 2024 13:54:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14280

On 08.01.24 11:25, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This is done in preparations to reduce similar code.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  classes/efibootguard.bbclass         | 17 +++++++++++++++++
>  recipes-core/images/efibootguard.inc |  9 ++-------
>  2 files changed, 19 insertions(+), 7 deletions(-)
>  create mode 100644 classes/efibootguard.bbclass
> 
> diff --git a/classes/efibootguard.bbclass b/classes/efibootguard.bbclass
> new file mode 100644
> index 0000000..bc99d3a
> --- /dev/null
> +++ b/classes/efibootguard.bbclass
> @@ -0,0 +1,17 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2024
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +IMAGE_INSTALL:append = " efibootguard libebgenv0"
> +IMAGER_INSTALL:wic:append = " efibootguard:${DISTRO_ARCH}"
> +WDOG_TIMEOUT ?= "60"
> +WICVARS += "WDOG_TIMEOUT KERNEL_IMAGE INITRD_DEPLOY_FILE DTB_FILES EFI_ARCH EFI_LIB_ARCH"

EFI_* vars are likely topic for patch 2, right?

> +IMAGE_TYPEDEP:swu:append = " wic"
> +

Extra newline and EOF...

> diff --git a/recipes-core/images/efibootguard.inc b/recipes-core/images/efibootguard.inc
> index 0f26b7d..f512b3c 100644
> --- a/recipes-core/images/efibootguard.inc
> +++ b/recipes-core/images/efibootguard.inc
> @@ -1,7 +1,7 @@
>  #
>  # CIP Core, generic profile
>  #
> -# Copyright (c) Siemens AG, 2020
> +# Copyright (c) Siemens AG, 2020, 2024
>  #
>  # Authors:
>  #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> @@ -9,9 +9,4 @@
>  # SPDX-License-Identifier: MIT
>  #
>  
> -IMAGE_INSTALL:append = " efibootguard libebgenv0"
> -IMAGER_INSTALL:wic:append = " efibootguard:${DISTRO_ARCH}"
> -WDOG_TIMEOUT ?= "60"
> -WICVARS += "WDOG_TIMEOUT KERNEL_IMAGE INITRD_DEPLOY_FILE DTB_FILES"
> -IMAGE_FSTYPES:append = " wic"
> -IMAGE_TYPEDEP:swu:append = " wic"
> +inherit efibootguard

Jan

-- 
Siemens AG, Technology
Linux Expert Center


