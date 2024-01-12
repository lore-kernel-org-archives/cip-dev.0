Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37810C4706C
	for <webhook@archiver.kernel.org>; Fri, 12 Jan 2024 10:34:53 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.49])
 by mx.groups.io with SMTP id smtpd.web10.4419.1705055687343760958
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Jan 2024 02:34:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=cprVxKK2;
 spf=pass (domain: siemens.com, ip: 40.107.249.49, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CKsointIDTxdGOk/XxDsUHlmREQ4E9W+eGhDh4yQVQ1LxOnZRiUrJxI78/pN5CRXC1Hu/J6OgfB9hCLsxFy8iOkAJ8sbhpHXdIvIKiMwWYpk24iKHZlRWgCSX1SHUppJrMVcYrCMIrBP61wDvMwe2BHGYPVxnbkGrN6Esc1MVrvW6eJO36dpXqqY1g+gpeGPCWR6ksSLsQ6AuoZ3C+qv6W7F+3Ck/IDS0e+XoTNhDg5fDVihOIq+7UefTRUftkaL60MxwwwSp+6QdKks44Qvl2gjtcXgxoF+qj5bipfvH/Og1VwAQVE+jS9ku53YtLKfsH1pHeUjl5PyDaUF8JY2KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oud22uNBMtNjTgfzXvMByqvxe6bJw8FLNvJORS0SYgc=;
 b=bJ9SMA87oMKTruv8Xe9uh3w7AFuIqgnOoY+33biwKj3qBSl3aLjHyyV6l9GwFVWQn30euOgoxR7cYXeBR8RO/ttARrgGYpUAu4Awou6gKpQoFHqa+x+uENhLMYYnEro0zbAb8Y+9XWcKQJm3Oa1LshLrOEpA7q9slP3Nnz2ujri6XeycXt7973bZGMTBBy39dbWqUVocdJbw1tpCbX3tvr++N8Nw93YIDthGIdJXKsgFemEQD/1tfY5tHeSbKuVeKTCAxj5p5DQOBHTJejqYq7WRNLuS8GkZdHTbIeLy29iH7TLAcOfmKUawOYz8vHQ4IGrfZKZ46n+SrCCrVKjGZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oud22uNBMtNjTgfzXvMByqvxe6bJw8FLNvJORS0SYgc=;
 b=cprVxKK2sc3lq07KvCnWpeH+6P9jvaF9+vv6+4xbdkbEkRd9BNEeBiwVlqexKMEWAeTVYRIo1QNPco0j4W7HOVi1VAH3qr7WfOSrlIxQoQAZmN1VFqD7zRZe8fgImVJXR59TpZjIR0TvkgZDqjezXi4Fw0M6jZpomg4P1SEdXGf00hUATnmY/q2xOhWbQBzyNGkTBoD27Qk+dH8/nSOT2a6DBGui8L6YNZfOueFQwR/dMFTnIsYIkg01HYy+/OmBDll7OgsDFXfpkhTIm6xQl7fptGFtDk+Hx1UQV8pSNw1AWOSnuwxhanpzfydXUbF9hkXz8T6SAA0BJhEG90F1vg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by AM7PR10MB3237.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:106::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Fri, 12 Jan
 2024 10:34:44 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5c76:8089:1f9b:63d9]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5c76:8089:1f9b:63d9%4]) with mapi id 15.20.7181.019; Fri, 12 Jan 2024
 10:34:43 +0000
Message-ID: <2dd54a71-9293-41ad-9be0-72b4b0a7b46a@siemens.com>
Date: Fri, 12 Jan 2024 11:34:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2] recipes-core/swupdate: Cleanup
 swupdate.inc
Content-Language: en-US, de-DE
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com,
 felix.moessbauer@siemens.com
References: <20231219100858.1853427-1-Quirin.Gylstorff@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <20231219100858.1853427-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0154.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::7) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|AM7PR10MB3237:EE_
X-MS-Office365-Filtering-Correlation-Id: b8c148e0-c2a4-424d-1d4a-08dc135a16b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	VCD8+oPdhepH8cgAxhY2N1SgKCKcfzj/rJ45SSoLeT3ObE1O7uDUO7z3R2REP80ifjLBoVX/jIsH3o/HkEMVQDc478xkUx4JXu/fleRFuJZ7WUh7iFqqLxzgQUajPGLqsQJelmx8BNUihEtgSszx89hf19aOi53GYn8L4ErjCLZ3+ZYu8NRoHakbGpa9lgfmWs7jehZHoWTSYFGoDeUhl/OOiNQrMMWfahDP6xbcRbpxFWIcyug4bZ9abtbP0a9lfR+/x+y6P/PwIE1E7+KFOTvyPHmejOOBu1o6jU0Iw6ircdZstMcYAfPAv2PsyWBfosnGtNl6HHuaMkQdvzdQP/ut40hMa/cDskUFpWftcoMzpf6UCuzQDxcF/9Ewyw2teWJlJQEq8qc0zV7Rr5pKQ21IB3KcAaws75wCly+rdQ9wrMWX0QRPpFe8pq0FGgIoX3k87+cxRepOjhoy+1IV1J14Fsg2B4SfnJRAkALjb/iTm7ebUW8V9BrlbHm9xl/CTfEeSPJvDlJepwqx63F3LKzv2wn6myrtSfw4sdByezmFszFGfMp1sOzgaGouuOlBJYx4oYLCE79NdD4F+nCK3KqyFhNy1wATqZgs7z6d+xCpflVqnYb/pCgQEPKsibXF29VmGLZ+DSqPKq510e34oQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(346002)(396003)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(6512007)(2906002)(36756003)(31686004)(82960400001)(38100700002)(478600001)(31696002)(53546011)(6506007)(2616005)(5660300002)(6486002)(6666004)(66476007)(966005)(316002)(66946007)(26005)(41300700001)(6636002)(66556008)(8936002)(8676002)(66899024)(83380400001)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?b3p6VEQrd0NvbjROSmF2TmtWYjg2R2VaSkI3c1pCajBXaXFMeS9jSHVkVHIw?=
 =?utf-8?B?SG1vc2xKejVYWHh1NHlwbmoxVk5aYVgxU1ZCbXN0RHFlRTJXRS8wRzJyd3hC?=
 =?utf-8?B?SXp1MnhvWXErTG9uMzhqaW1FSlJYTWJ2U0ZFb2cxODVnS2kzQ29hWjA3alIy?=
 =?utf-8?B?aVJ4NEQ1KzJqcmRIZlV2bkk0NVF0SnI3TUp5WHk3Y1B6L0RUSXZQUzNPajVD?=
 =?utf-8?B?UFl4U00zaHNCRU13QVZGRCtPTmtyUHdJdUc0amREQ0ZQT3VidmpvTVlvL0l4?=
 =?utf-8?B?cWgvS3lLMDk0NzkzUllqODlySXJlM2pxYXU4YngzcGcrVGN0YXM4WGxtNUpq?=
 =?utf-8?B?WHdsQXg1U2Zzd2RzVXFKaW5UdEVLSlB0WTFBMjdhNk82clk5L0xjNmY1dUVl?=
 =?utf-8?B?U3VBU2VQK0pSSUwweG1Eb1QwU1BxTVBJL0s2RW9iaDFyUGJ0TEttc1dveWNv?=
 =?utf-8?B?MjNKd043NzJ5L2FkVVQxRnNJYXVtS21lcnVSa1liYXJ1WWM2M0p3ajZYQVRR?=
 =?utf-8?B?eitqUWd5M1lsd1pnR0VWTXdNNnlqTU9ub0FjcmxUNTJlNFFURksvSFNiMENy?=
 =?utf-8?B?YXBvMlM3dUNqdjlQWCtzNlpTbVhNZW1NOTQ2NWtMdjQwQjVCRldjMDEyN2pZ?=
 =?utf-8?B?REFlQWZWMmM5SHM0a1BzaS9TT3NBbWgydUZHWWwxNUQxM1RValhaeHFUVml1?=
 =?utf-8?B?amJwNGFIWWx1ckpEOGdhVE5zL3d4M1hmWVYzWks4V1hzMVYxbFdoR0dSb0ZY?=
 =?utf-8?B?WVJjWVJnYlRZZGFlekNXN09zeXpSb0t3QzlrRlpRdU9vVGd3M25CQWpZd1Yw?=
 =?utf-8?B?SVRGNmJaRWNNZk1HSmpHYzBGcG10MThtaWFOZ0RaOUN6T0VpK3hBc2pMVXIz?=
 =?utf-8?B?eHRGOVRWZ0U1V20vajhHWXByTEJRTlcrZm9aN1Qzb1dmYUF3bXg3S3RJcUdL?=
 =?utf-8?B?VWZldWVnWThOUUwzU2FCeVo0d0FLdm1aMXlyQi82dXBCQ255azZMMlpVMk5v?=
 =?utf-8?B?WlVEZHN0WUgxTHVoYzlBT0swOTZQdld0TTJsZjFNTVMrcytnZ3AwVE1XdW9j?=
 =?utf-8?B?bldYR2luQ0V0YjlwZEU2MDFHdVh1SnNiZmVGQXVkU2I0eFZONjZDaTRIOTVX?=
 =?utf-8?B?Uk9wdXN6UkpoTS9BcGFiQU9zTkQ0TUtWTWQ1bVNWZnp2dW5nWSt6Q2gveUhh?=
 =?utf-8?B?b2pQNW8yWGtPT3c1Zk9nV1hJOXBHUVZYSnFNdktON21SWHhTc0hRRVlKd2o3?=
 =?utf-8?B?M2lIK2VoUTEvWkhwckNiUGJtaEZtd1BiZFhDUi95bWp3N2MvdWtISHpEcWs5?=
 =?utf-8?B?SHU0U2xPQ0ZjcGpRbkVZaUVVSC9NdGlxSzhJMUVuY3hTdUV2Q2J4QnBrYzlD?=
 =?utf-8?B?N00rVlRiOGQ5bldhZ0FnUUpGeWkzQWdtY2llNFE0YXR4Zys3cXlCV1pWeVVN?=
 =?utf-8?B?eDMzV0ZpQzV6SU1Ga3ZvM3UyelZXLzhIeE40ZjZuK2wraEpsMVlndzF0Uy9H?=
 =?utf-8?B?ak11NGo1UmVCVUdnMFE4Q3pJQU1rcWpDL1JwSVlMUEx1cWR3WVp3UmhnMFlG?=
 =?utf-8?B?bUcxcy95VDhHeit5ajJVcU9Zelpac3NLNGtXbVlxdWZJV095SGhRNTNkYUVx?=
 =?utf-8?B?aDZIQ0NESzE1SnIySEZmakxqQ1RaOFk3THllc0JZei90WkpVc2k3ZVpQTGRF?=
 =?utf-8?B?QmRsb1lJaUlNODVCS0tac0dWdjY5SnZuNWJ5MUJNZHJHMktuakFORE4wVnli?=
 =?utf-8?B?VUw0QzIwYUJyTE96aU5YNFN2UzczYy9RVjNpK0VKeXNRdlpLVyt6UDJQYlVv?=
 =?utf-8?B?d2Vvd1BiVTVOU0pkV1R3SlVFRVA5OVo3c09rdXNNaWt3UXhZWTFXQm1KN3hH?=
 =?utf-8?B?U0pUZTE4a2pxU2RKOXp0b0hzQ1RtN2VOTW8zSFBFK3JaUlJ4by9NMXltSHVk?=
 =?utf-8?B?d1ZKbGNpeFIxY2RDRlllbkpUWUZZSFJaTkdGQnZCTVlpaFBkR1V5N0hxelcy?=
 =?utf-8?B?TTNUR0l0bnYwa1ZMMFlacWdaenpLM0lsQ3ZDRjhmUURWVUFOTndGUm84N1Fh?=
 =?utf-8?B?K0xPWis1OG83R2l1bkhPUk90eHh4VmtMbnQ2SWNmdlJQekxPclRSMkdVNWdS?=
 =?utf-8?B?cEw2RGJQSXNDamwxOG1oQy9VcGxMaGN6WndIUWJGVzJVVjhiK3VuQkZydkFx?=
 =?utf-8?B?dlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8c148e0-c2a4-424d-1d4a-08dc135a16b0
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 10:34:43.0241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tQmwoD89Wu8OTY2wdryecZ3gyHHAPn9HKdyReymtrgavLKpky+wJj5UZYqIoqC+6HhSVcBOY3LqJruZ7bTUzqeUzmd+9If9drdC1qKKr2f0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3237
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Jan 2024 10:34:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14349

@jan, ping

On 12/19/23 11:08, Quirin Gylstorff via lists.cip-project.org wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> As software loads the bootloader libraries dynamically it is no longer
> necessary to set the build loader with BUILD_PROFILES.
> 
> Also add PROVIDES for the additional packages swupdate provides.
> 
> The profile 'pkg.swupdate.nosigning' is automatically set if signing is
> not set to `1`.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> Changes v2:
>   - cleanup 2021.12 for debian buster
>   - move cross and nocheck to swupdate.inc
>   - move DEB_BUILD_PROFILES pkg.swupdate.suricatta* back to swupdate_2023.05
>     as the apply only to this version
> 
>   recipes-core/swupdate/swupdate.inc            | 21 +++++++++++--------
>   .../swupdate/swupdate_2021.11-1+debian-gbp.bb | 11 ----------
>   recipes-core/swupdate/swupdate_2023.05.bb     | 10 ---------
>   3 files changed, 12 insertions(+), 30 deletions(-)
> 
> diff --git a/recipes-core/swupdate/swupdate.inc b/recipes-core/swupdate/swupdate.inc
> index e5e7282..cb1716b 100644
> --- a/recipes-core/swupdate/swupdate.inc
> +++ b/recipes-core/swupdate/swupdate.inc
> @@ -1,7 +1,7 @@
>   #
>   # CIP Core, generic profile
>   #
> -# Copyright (c) Siemens AG, 2021-2022
> +# Copyright (c) Siemens AG, 2021-2023
>   #
>   # Authors:
>   #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> @@ -13,15 +13,10 @@ HOMEPAGE= "https://github.com/sbabic/swupdate"
>   LICENSE = "GPL-2.0"
>   LIC_FILES_CHKSUM = "file://${LAYERDIR_isar}/licenses/COPYING.GPLv2;md5=751419260aa954499f7abaabaa882bbe"
>   
> -def get_bootloader_build_profile(d):
> -    bootloader = d.getVar("SWUPDATE_BOOTLOADER") or ""
> -    if bootloader == "efibootguard":
> -        return "pkg.swupdate.efibootguard"
> -    if bootloader == "u-boot":
> -        return "pkg.swupdate.uboot"
> -    return ""
> +PROVIDES += "libswupdate-dev"
> +PROVIDES += "libswupdate0.1"
> +PROVIDES += "lua-swupdate"
>   
> -DEB_BUILD_PROFILES += "${@get_bootloader_build_profile(d)}"
>   
>   def get_bootloader_dependencies(d):
>       bootloader = d.getVar("SWUPDATE_BOOTLOADER") or ""
> @@ -37,6 +32,14 @@ def get_bootloader_dependencies(d):
>   DEPENDS += "${@get_bootloader_dependencies(d)}"
>   DEPENDS += "${@bb.utils.contains('DEB_BUILD_PROFILES', 'mtd', 'mtd-utils', '', d)}"
>   
> +DEB_BUILD_PROFILES += "${@'pkg.swupdate.nosigning' if not d.getVar('SWU_SIGNED') == '1' else ''}"
> +
> +# deactivate hardware compability for simple a/b rootfs update
> +DEB_BUILD_PROFILES += "pkg.swupdate.nohwcompat"
> +
> +# add cross build and deactivate testing for arm based builds
> +DEB_BUILD_PROFILES += "cross nocheck"
> +
>   python do_check_bootloader () {
>       bootloader = d.getVar("SWUPDATE_BOOTLOADER") or "None"
>       if not bootloader in ["efibootguard", "u-boot"]:
> diff --git a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
> index 8f7a97d..0f91d5e 100644
> --- a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
> +++ b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
> @@ -27,17 +27,6 @@ SRC_URI += "file://0001-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch
>               file://0004-debian-rules-Add-option-to-disable-webserver.patch \
>               file://0005-debian-Add-patch-to-fix-bootloader_env_get-for-EBG.patch"
>   
> -# end patching for dm-verity based images
> -
> -# The option: "pkg.swupdate.nosigning" disables the required signing
> -# of update binaries
> -# DEB_BUILD_PROFILES += "pkg.swupdate.nosigning"
> -
> -# deactivate hardware compability for simple a/b rootfs update
> -DEB_BUILD_PROFILES += "pkg.swupdate.nohwcompat"
> -
> -# add cross build and deactivate testing for arm based builds
> -DEB_BUILD_PROFILES += "cross nocheck"
>   # If the luahandler shall be embedded into the swupdate binary
>   # include the following lines.
>   # DEPENDS += "swupdate-handlers"
> diff --git a/recipes-core/swupdate/swupdate_2023.05.bb b/recipes-core/swupdate/swupdate_2023.05.bb
> index 77b7431..d1fe1fa 100644
> --- a/recipes-core/swupdate/swupdate_2023.05.bb
> +++ b/recipes-core/swupdate/swupdate_2023.05.bb
> @@ -31,13 +31,6 @@ SRC_URI += "file://0001-d-rules-Add-seperate-build_profile-option-for-delta-.pat
>               file://0003-d-rules-Add-option-to-enable-suricatta_wfx.patch"
>   SRC_URI:append:bullseye = " file://0004-d-swupdate-www.install-Fix-path-for-debian-bullseye.patch"
>   
> -# The option: "pkg.swupdate.nosigning" disables the required signing
> -# of update binaries
> -# DEB_BUILD_PROFILES += "pkg.swupdate.nosigning"
> -
> -# deactivate hardware compability for simple a/b rootfs update
> -DEB_BUILD_PROFILES += "pkg.swupdate.nohwcompat"
> -
>   # suricatta wfx requires suricatta lua and the dependency
>   # is not set automatically
>   DEB_BUILD_PROFILES += "pkg.swupdate.suricattalua"
> @@ -48,9 +41,6 @@ DEB_BUILD_PROFILES += "pkg.swupdate.suricattawfx"
>   # with cross compile we have a unsat-dependency to dh-nodejs on arm/arm64
>   ISAR_CROSS_COMPILE:bullseye = "0"
>   
> -# add cross build and deactivate testing for arm based builds
> -DEB_BUILD_PROFILES += "cross nocheck"
> -
>   # use backport build profile for bullseye
>   DEB_BUILD_PROFILES:append:bullseye = " pkg.swupdate.bpo"
>   
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14135): https://lists.cip-project.org/g/cip-dev/message/14135
> Mute This Topic: https://lists.cip-project.org/mt/103260154/1753640
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129121/1753640/1405269326/xyzzy [quirin.gylstorff@siemens.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 

