Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DEAC001DB
	for <webhook@archiver.kernel.org>; Thu, 10 Aug 2023 11:31:46 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.53])
 by mx.groups.io with SMTP id smtpd.web11.14940.1691667100275024937
 for <cip-dev@lists.cip-project.org>;
 Thu, 10 Aug 2023 04:31:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=gv65gf2I;
 spf=pass (domain: siemens.com, ip: 40.107.6.53, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TT9J6OIzyZhlbjWSyAf1O+idj1x+VPHluVQ/1KGwrXRRyFVq6/X31OjZx9nl7J6bGmG9Q60jb4mNiXqu/MjceWrRDw7Rxv3m7gJCplqRhkaCgt0oSfoEZTuMn6X2NXOmzj0gPVpPkDZ3QfMxBO1oYhLclTCFg0Z3MPmrGP3GtypAdJOL5ywBs1d/hU7+qZfYeLE0gC6sQsMpuN5rlh454Pn0APUztA5i/OsLs3b+t4kpeTQOhza34OFBx8Ls/YAEDS30m6S7LxS/LkpYjejP0TrqjTvZo0WZrP7EvaITc43DzuJ/JPH3HjCYHsjnZQXq78uuFTapKx0sSSI4JixL/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IE9e/CfAsFWB/KKuVXmciVL1+EsqJ1Btafn2J098AGw=;
 b=KyYjtgwAGbA/H5tTUkfaY5tFdnOjDkK/56+ihMLi3QX5i9+rhdm3Txf/VlVjEg5f98YkSHceudFoQc0VuI48XG590FrYb33SB0kfb0eX/Wm740Klp4tqWfTiXXTTxW9LWJDKxUYnzJ1G4/xF5u5ESA7XPpex4KQC8TstxjqrmZeRTtZ9HGmarTPcBWfoJuArlDVdMUWlbrkKZs8eeE6WqeKerj+ffVLKfhLoeGBm9I3mpkJA7/VryqU4Vmh/UQR3I4r527DsiIV3lpzaNensONBgUSLDzZR3aqFUEWRH10lRMIT8FnVK4GqkdC2ZQX5SScmP5S4wTn+J4MEdFXr2Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IE9e/CfAsFWB/KKuVXmciVL1+EsqJ1Btafn2J098AGw=;
 b=gv65gf2IU0ESRrhuH4eiYl2bceLgo5ztLN5ffY/TctN6u72x/6s/dyoqKTK1xJ6I6agWQvRUVu9lXX+sucPVh/DDH7t0BIDqswdD9Lqy7eGkUd0aIeMpaKxVz051k9l/oobc4/dP6Lv4yCDU6tIB2RunEjE3gdUpafCgMVuTpJwxEUxV8Q+uINrfel6ENxeQwYTIqLIP+o/va4qeOi6vx7mZoGDi+aDUh2vt+NNNl+qqOTBgwZm0QBVF4IFgm7OqHN5uCOmc1X8ASmYwnMDmBfcmzCTAdFZ4j9uVSiD0CEPJRHBqhC/p72mevKQm/gTvXJfeSIRJ5kgSA74TWZfX4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB6117.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:38e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 11:31:37 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 11:31:37 +0000
Message-ID: <14e1c827-c770-4f84-8b24-279dc54699d5@siemens.com>
Date: Thu, 10 Aug 2023 13:31:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC v2 3/3] swupdate: Enable signed
 updates
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20230717105417.27761-1-Quirin.Gylstorff@siemens.com>
 <20230717105417.27761-4-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230717105417.27761-4-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0093.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB6117:EE_
X-MS-Office365-Filtering-Correlation-Id: 456cb975-e8b8-45ed-a922-08db99955bd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Ti/Y7s8egQAHc3K02Y1U2Emw6tsYoe50g0bgmXgvvhoD+lsFJy1v3pKsPjL5zzpptBFYbmBl0PksCdCx2iaSuXmHMF9GEzpSnDBk92KT8CitCpjEWxGFj7RppMXy6AY/mWCxZhK9qiBPuiv5yYJ3+6PeDmEXKZpLmFnKEnZxIZpbkiNZRpxFDUWBHKtZGdJrfArv/PZvdPAr7svQXQ1riFdu7f3mU3MgpA8LW4YnUqStX3NCj00srld3rpbf3JKvQMU1rCtUUkKvAnUwuE7gHQb+trVDkMHAOWZkDfIzM4tFnm+BlkCQ4TuHFaldMog4ZU1M+bG7MR4M9Z36mVHrZHWM5LfBPRg96jdYP6JwudiANugCDzI3S78JeC7J8oFaZxQdRxlPKYByDBiCZaesj++cTxK2V8Em6VRff9hUsBPJvgEMtAIb2q8wqQUuQEGgBcpGjUIqS1sZ980r06WoFkQpvLE4uY/p1zX0cAiOlkX/QNB4beiQXxPunJD9UHzlXqsFnufF41qBrmFnz/4a8ieWlDkjoUH8piGEHwZjqTaHqQx04y8ZUfg7EuIFVelhSLA5H988UJcPcms0ItrlP8s+qDnAQXBuvKej5OGrl0ZR/b9sjLQ1EOnOlvvgcZfdL1c4SV7ydjQcjaQPYxlNfQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(346002)(136003)(376002)(396003)(1800799006)(186006)(451199021)(31686004)(66946007)(6506007)(53546011)(66556008)(26005)(66476007)(478600001)(36756003)(83380400001)(2616005)(41300700001)(44832011)(316002)(15650500001)(82960400001)(6512007)(6486002)(2906002)(86362001)(31696002)(8936002)(5660300002)(8676002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?R0NQbm4xa2hUdEhjLzVYODIrWVpmM2xod05KWnp6TWlMUTlVTTZKajZzcjUr?=
 =?utf-8?B?dmhCWkxYUU1UMDhWbHJQYkExZ0dIZVN0VDA4a3FGZW5ySkNjS3FLM3pNWHUw?=
 =?utf-8?B?WjRuODJvSDQzdkFIWGpVbjBSb29sV1BWUWdmdG0vT01sTDFlRDRITVR4OGds?=
 =?utf-8?B?NStDVUJ2Mlh2MDBMbnZJR3ZGZTJmZWZpMndLZDNDOW5MQ3VMVUlrUVpNZk85?=
 =?utf-8?B?K1F0QVN0MkxTRzhtOGlvdnBEenlQV1VEeU11a3N3MXBPczUxNVRQdU9MWG9h?=
 =?utf-8?B?VmhEOXlvQlhjckV2Z2xTTy9DU0l3ME5VUm1pRmZ4bmJZdTFWa2MwWFlpdVFm?=
 =?utf-8?B?Q0lab0hZYjBjVjJNeE9USG9yWnFGM2xSTHFzT2twTUp2TlhoNDE2bmVaL05Z?=
 =?utf-8?B?OWV0emtqKzBlNEs0SGJvb09FaUVQb0JzeTh0bnI5VkY2dTJ4WituQzVuSk5F?=
 =?utf-8?B?Ym9ldDJuaktLa2RKR0JZRDB6WEdzcHhLdjBMbHFObVNHT3g0UmRzUFAwcGJs?=
 =?utf-8?B?Q3BhaWY3T0VwcGN5MFgxY1UrczllMWh5MklJY0VnWFFjOWJzMUl2K2Q3Q25W?=
 =?utf-8?B?SU8wRWpvWjFGYWcxUzVGK091aXBKTEsxT1NKOWRueGM1bzVjYXh4TlRmWUVL?=
 =?utf-8?B?WHVvc3BvZTNJU3Q0QnlmLytpMWhDdEJIWHpaWHpJam0rdVdpd01JYk84dHpU?=
 =?utf-8?B?WFYyTHI2dXFnSFpMUWZZTE5pM3dqN3VtOGlzdW9taDExV05JZ0c3eG5FZktt?=
 =?utf-8?B?SmNzOWdpOUxUL0lKdW42b2cxWFhuQXl1bDVISlRKMnd4cmJzekJ3VFBscml2?=
 =?utf-8?B?Z2U1dXR0Z1lpcnZ0b09ySVBYVjlDLzNEbUlPS2YydUk4a1dtdWpSbWV4c3R0?=
 =?utf-8?B?WkZ6aUgvUUNSZ0lwK3YxRkFiaytuazZTMDVsaWZvQzZGNEQvMEhjZ0pzQ0N1?=
 =?utf-8?B?YTIwbi9RY2pkSDJZVy9WbUtuSitWeTJnNkFzR2tSb2doaGFWUDJ2eVlhSFNQ?=
 =?utf-8?B?aFo1dEdwZEUzQWtPWWpwUVhuaGFyS3daTlgwbGhnSStMR3FObEZWbXd5UkRP?=
 =?utf-8?B?N1BLbzI1V2NQa3dydmVEN3NTYndKMzVMYmdObHZWQ0dvWHZnNjRYZDBJVVV6?=
 =?utf-8?B?Y0UrdzFMYU94a3FtVnpwZVc4VGZ0UmlSclJNRkxDUWdXMkpHcU5Yc2dNL2gx?=
 =?utf-8?B?VGVtVjdZbHN4WkFkUnphTE01QnFpZXNUWFVVVG42djR3VE11b2cxOXh4QVNh?=
 =?utf-8?B?bjVQR0M5cG11ZGNZOHAxRWJ5MXp5aW1Zb3dHejQrbmVON2pVdjNXQjFJVUls?=
 =?utf-8?B?S3RsLzEwTG5HK2xmNCtxeXN4dHFwbnkyNHR4T1FrMFBobEZlWkllbHFuTytP?=
 =?utf-8?B?eU8ydE5uVlllaW5NRkVvdWN0R25BWFBGa1VzNVFiK3YraDhxK3ZrVVQ0bGFT?=
 =?utf-8?B?MzJpb3AvNU5kN3d2SjVpb2FJMnhKU0M0N3haTkNaQjROSGJhdytiMTVzbml3?=
 =?utf-8?B?MEdCQjU3TzRUZ2dGRlVsWXRRT2NFWkN0a1ZBVm13cmtrMERVS1Nod2pXVjdL?=
 =?utf-8?B?Y3hhb1VFQ2tmMDZnaUtENVMvVDE3TWIvSzB2blZMOEt4eUZySlVKUEZSWmtj?=
 =?utf-8?B?b1p0dHVmTXBkcWRhc0ZpTUREeWFzTWhSRTlJRmdTUU1WUWs4dTVoaitZZWxG?=
 =?utf-8?B?NTFVb3R1VUNUeU5zeW9FdHZqMkp2UjBVNlRhWExTQWVlTEoyTlVlZWFBdU9E?=
 =?utf-8?B?QTlSMC9UTDk0M3NvRG5Zdk4zRUVZNkJDRXZiYU8yM0RyUmdWWUkyZ0wwa0Jn?=
 =?utf-8?B?LzVWcExBNEFpeE9VMCtadWZwaHhhOWJTUVJPRGVocEp1ZHBWS29Id21hZDZy?=
 =?utf-8?B?L1dRM0huUTlPUU5UcS9zSldVdWk4ZGVhZXVPMkpYNkM1OXRQc3VYRC9OQkRh?=
 =?utf-8?B?dGJxMFVFY29XZkh2bjBHVnV0T0g4N1ExbTVHRWh0VHNZM1pZNXJaVVFKbXpK?=
 =?utf-8?B?UUFhUHphY20xRFpTZEt6Vjl0bG14M0JYODFOY0t1aTA5Mm5Id0x4bkFEbU0y?=
 =?utf-8?B?Y3I3UklwMGVhRUY0dDVIQkhzM3V0RDVCSVF4blZiblJZOFZxRUh3KzBlQTBm?=
 =?utf-8?B?Q3BBaHFJc0RLWEhWY3pwR2cxNlNsYjZYSE85OUxxTnB4Y3FOMDZOV3k1UFpo?=
 =?utf-8?B?dmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 456cb975-e8b8-45ed-a922-08db99955bd7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 11:31:37.4731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xwAo7s0RKTZnlKpS5vHnf039D1dNasUbVByScssZ6FjFuLZs7r/n0E73QA8L9AVGYFOzaE8flWVgDBCVftc/5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6117
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 10 Aug 2023 11:31:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12600

On 17.07.23 12:54, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> With this change SWUpdate requires signed binaries to update
> the system. An update without the correct signature will lead to the
> following error message:
> ```
> Error: SWUpdate is built for signed images, provide a public key file.
> ```
> 
> If unsigned binaries are wanted readd the Build option
> ```
> DEB_BUILD_PROFILES += "pkg.swupdate.nosigning"
> ```
> to a swupdate_%.bbappend recipe
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  kas/opt/swupdate.yml                                   | 2 ++
>  recipes-core/customizations/files/swupdate.cfg         | 1 +
>  recipes-core/images/swupdate.inc                       | 2 +-
>  recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb | 9 ++++++---
>  recipes-core/swupdate/swupdate_2023.05.bb              | 8 ++++++--
>  5 files changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
> index b0293ce..0e30e89 100644
> --- a/kas/opt/swupdate.yml
> +++ b/kas/opt/swupdate.yml
> @@ -28,3 +28,5 @@ local_conf_header:
>      INITRAMFS_INSTALL:append = " initramfs-squashfs-hook"
>      ABROOTFS_PART_UUID_A ?= "fedcba98-7654-3210-cafe-5e0710000001"
>      ABROOTFS_PART_UUID_B ?= "fedcba98-7654-3210-cafe-5e0710000002"
> +    PREFERRED_PROVIDER_swupdate-certificates-key ??= "swupdate-certificates-key-snakeoil"
> +    PREFERRED_PROVIDER_swupdate-certificates ??= "swupdate-certificates-snakeoil"

This needs to go into patch 2, right?

Jan

> diff --git a/recipes-core/customizations/files/swupdate.cfg b/recipes-core/customizations/files/swupdate.cfg
> index 9ee47c7..3e2b45c 100644
> --- a/recipes-core/customizations/files/swupdate.cfg
> +++ b/recipes-core/customizations/files/swupdate.cfg
> @@ -1,4 +1,5 @@
>  globals :
>  {
>      bootloader = "ebg";
> +    public-key-file = "/usr/share/swupdate-signing/swupdate-sign.crt"
>  };
> diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
> index 5d9cd58..4983f7c 100644
> --- a/recipes-core/images/swupdate.inc
> +++ b/recipes-core/images/swupdate.inc
> @@ -1,7 +1,7 @@
>  #
>  # CIP Core, generic profile
>  #
> -# Copyright (c) Siemens AG, 2020
> +# Copyright (c) Siemens AG, 2023
>  #
>  # Authors:
>  #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> diff --git a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
> index 2384f41..8f7a97d 100644
> --- a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
> +++ b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
> @@ -1,7 +1,7 @@
>  #
>  # CIP Core, generic profile
>  #
> -# Copyright (c) Siemens AG, 2021
> +# Copyright (c) Siemens AG, 2021-2023
>  #
>  # Authors:
>  #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> @@ -29,8 +29,11 @@ SRC_URI += "file://0001-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch
>  
>  # end patching for dm-verity based images
>  
> -# deactivate signing and hardware compability for simple a/b rootfs update
> -DEB_BUILD_PROFILES += "pkg.swupdate.nosigning"
> +# The option: "pkg.swupdate.nosigning" disables the required signing
> +# of update binaries
> +# DEB_BUILD_PROFILES += "pkg.swupdate.nosigning"
> +
> +# deactivate hardware compability for simple a/b rootfs update
>  DEB_BUILD_PROFILES += "pkg.swupdate.nohwcompat"
>  
>  # add cross build and deactivate testing for arm based builds
> diff --git a/recipes-core/swupdate/swupdate_2023.05.bb b/recipes-core/swupdate/swupdate_2023.05.bb
> index 26c0e67..762fac2 100644
> --- a/recipes-core/swupdate/swupdate_2023.05.bb
> +++ b/recipes-core/swupdate/swupdate_2023.05.bb
> @@ -31,8 +31,12 @@ SRC_URI += "file://0001-d-rules-Add-option-for-suricatta_lua.patch \
>              file://0003-d-patches-Add-patch-to-add-the-build-version-to-swup.patch \
>              file://0004-d-rules-Add-option-to-enable-suricatta_wfx.patch"
>  
> -# deactivate signing and hardware compability for simple a/b rootfs update
> -DEB_BUILD_PROFILES += "pkg.swupdate.nosigning"
> +
> +# The option: "pkg.swupdate.nosigning" disables the required signing
> +# of update binaries
> +# DEB_BUILD_PROFILES += "pkg.swupdate.nosigning"
> +
> +# deactivate hardware compability for simple a/b rootfs update
>  DEB_BUILD_PROFILES += "pkg.swupdate.nohwcompat"
>  
>  # suricatta wfx requires suricatta lua and the dependency

-- 
Siemens AG, Technology
Linux Expert Center


