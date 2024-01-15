Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB554C3DA79
	for <webhook@archiver.kernel.org>; Mon, 15 Jan 2024 08:23:34 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.52])
 by mx.groups.io with SMTP id smtpd.web10.73141.1705307008034912594
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Jan 2024 00:23:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=pCssBk8O;
 spf=pass (domain: siemens.com, ip: 40.107.21.52, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LfFwhqNHIUvZuA9aHIDpycnFaqFmPfjMATIQEezLGUSRWWulxW12tauVEefGfV2i7DkCh76/lM75fWmh2Ey8UwP360qrKuQIAIfDv2civZ+7h0u9uSlKuj+2l+wfZRMIsQR2VSHyy1KSoEGQi4p9v9KJRJJqwCjcEnBZ42brgov+z3M5APBrcSftm8+8VAGf3yKh7oPlKnquobNg4lea7P7jk2VD2cWIYh1fU1O6nRpQQD/1GYUaMlbfdXGXasO4NIcIzJ2TfQbgC8mdSmZTXNi6UT2ohNSluoR2UfQKnJGcT6msX5UZCm+7RKV4TAnWPZpLflNIP9dMgZbNWMu8bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KjEljcVcG2NtnWo7fV0y5q7meau6+3hBUBAdL2kZkrY=;
 b=aPbOBRXUBgKVDU/YR+QVjyGf6vwz7dgMPrlRZJpgPWSKxqkJWr2kI43//h0HDxTHsjHMTb1pYHQiRddLt/CpNumI2vZWVyzcYfNsWoMEFFbh2O1yj6N4LIlk18O2h6VPSVu5aPOrUo/6yxRpjAxsDPtEPwwvdYEooxRhdfS1kGiRQTUljMLkCfNIggqJlHxy3ypeA9XHZuHCY8Cb6/bruujx85q3KlAmlXnmw3JK1KHICa7JUmrTP74G7ci5y7rn0pcPZT2uxe3J/C2M7uJGUsxwZg8P6QHLq0oI8sRN8epgJ3Kl7dMQqazgmJm+uC4cUUAt+Jd8R/suh8ScarEs9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KjEljcVcG2NtnWo7fV0y5q7meau6+3hBUBAdL2kZkrY=;
 b=pCssBk8Odzg5Cj4KBQighFToPULerPQOd/oVvkwpoxPeEeZIshnaYjLiKYF/saH6zl8KiHlO0XBahWmGyGDEf4Ij3hztQpibblFp2DsVemqhurG4b6tRHE3pTL8GTwtfF6Tl3KR8lV3rv4RF/UQZ61kdpLpQo5e7Uw6xu6Ww9pYMd0NLbsFQKYlxvba/Uej+ynSwdT/y3R+ivksKF/sXap0ipBLQa+U+A2wzdkQgCecEfezEirAleJ7ke5kFdLrrv3TCtuwGSX6BVq9meoy/IuMIS1YRnLFs2PvyZms0dPZFO0+bMU5D2WJr6OVXKQzemEKn3MkdOTFClMlV95EDxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3502.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:13c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Mon, 15 Jan
 2024 08:23:24 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7181.026; Mon, 15 Jan 2024
 08:23:24 +0000
Message-ID: <7fcc6849-ed46-4f45-b0b1-c1953c125bb2@siemens.com>
Date: Mon, 15 Jan 2024 09:23:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2] recipes-core/swupdate: Cleanup
 swupdate.inc
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com
References: <20231219100858.1853427-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231219100858.1853427-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0249.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3502:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b99c406-75ed-4aea-3ec4-08dc15a33dbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	QWkWJuUy8SvBDR4A961BB4DhXBQD3y8eZKnYptU+STlmsKqjzu8rrodCwNewebaE9i7i441/b2mLTZHLt22cs19VvKqZZUe1feDUQK99ik7jbt8TErILNUGAZL3tJAcoZhGSb6rcJSDjg0USWQEzYs0U5GYZBMcnz/ob8b7rffJurYQkFLJfzI43+f2IxIpCKM5TYNsV8pFgkvZ4Pk65YNhgNbKNQg1sD5gq51cKVz2Bq9ZbT/pLUYBYhzrowWxfFpDbOGbIJruOLk8pLgRnZmv0k6ExbYhSu3+Gar7U12J4bruiJMGudCFVeCRWaAehHGI8CuioRYsHXU35o4Yabka5wgBDIpr1eMvUUSIAwOWpKEvjgUckmKCA7PpOChQQz4vlNMH2brGD2MXfR1jtwHzfeyh/CSkd5/kOUNYPh/fqHv5U8cQjSpxn/tlwW+dThJjkHsiIFY8oPMepICUz+EjSA27KnzpRU47k7OCAKkvYypxgzB5zGwi+dAV7F8asFAc7oT2s8OmfeBWNq3fUAR4w7wTTUxu6FMlN3towEdNrXMVTcFPBX7IOpAPT6+SGTOMuHiAu+Osc1neV1TTu4aE4BybURjVp2zQzioM+4MFfhh+ZNhMam74QCoeNKIp4qDaT3yEMJRHBgD/bLLCzog==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(39860400002)(136003)(366004)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(31686004)(2616005)(26005)(53546011)(6666004)(6512007)(478600001)(38100700002)(36756003)(31696002)(82960400001)(86362001)(5660300002)(2906002)(41300700001)(6506007)(83380400001)(66556008)(66946007)(316002)(66476007)(44832011)(6486002)(6636002)(8936002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ODRZN3ZNZkxubVBWVXdHSENZanE1cTdieTNaK2tLc0ZibjhtckFTNE9DSDdZ?=
 =?utf-8?B?N0FrSTl1WGQ5NmtSV3lvZHJPQ3dJWCt6NGMxQ2xTcFBxUXdNYXRzdXh5QVl1?=
 =?utf-8?B?TFRiUVVVOVVqU1Q1ZSt4eU4zdFR3VE4vQ2IweVJTVlRhS2YxWDF5ekJiQjdW?=
 =?utf-8?B?Y1VLOGJjY3VGUGFCanAwYURETElaNnEweVBiUXh5RXdEczRwRWxBSFZJSENm?=
 =?utf-8?B?bGl5ZjR5NlZLOXIwdkt3OVBwMlM5Mmp5OXpJOVhzNWJvTTh2bzVZUUozaUdY?=
 =?utf-8?B?R3VzUkozRHNZYktidnJOUEx3Z2pMRG5iVC80c2ZIY2VwNUN2TEJ4ZCsyTXNC?=
 =?utf-8?B?cks0M0F3MlR2Q0FaellMN3I0QVJqdzcrMVRMaHhYMmNicDltNzRHNE83THQw?=
 =?utf-8?B?T21sR1o5K2RHaGxQL2NuYmVTNGJlV2JSMXlZQ0V6U1N3TkJUOVY3NzlVOU02?=
 =?utf-8?B?NEovdytDSkRhNno0V1hUcnRtdythM2MvZCtuY3pPSXQ4NjNORWFVYVZJTEJo?=
 =?utf-8?B?WmFiTE5wYzNNRWJwVEFpUTVvV3I5WkJ4K2lEZHorMjdRbmpHcmpGKzE4cjJu?=
 =?utf-8?B?bnJ6bjYxTVZwR1ZTdzI5eTNUMFFhTElJK3NLWDBLOUFBa3dpMDhIanJlM3R4?=
 =?utf-8?B?UDNqdWZ1MHFTcUNBY1diU0hIOFVmQWJnZG5wMXM4RWJ1NFY5dzJyb1J1cmg2?=
 =?utf-8?B?YUV2TDZhYjJ0UWY5ZVppNjNBRWhyRGd5RC94M1FVL0xIeXVxZFN0a3plRWdk?=
 =?utf-8?B?bGwxMzcwbWhrRWY2L2dWZWlGbXBhM2p2cmVGRmhLUWwyb3RNWDBNWStVV3lQ?=
 =?utf-8?B?SW1QcmJTVGJpTlRZdHFUUDBQRW0zOWFGSitkbnU3WjYzUy9VNGhrL3g3Y29x?=
 =?utf-8?B?ZUVpOGxoUlNiOS8wcXhUcUZYTU02ZEFLc0FLSlNEaFpzK1hvbVNQZ0pjQUhm?=
 =?utf-8?B?RytUN2Vwd2FVRVNOeXU3VGtDT2ZMRExHQngrZGZXS0JtYi9XUzFrNmdyZWsz?=
 =?utf-8?B?V0VIWTI1Umpjam5nL2xOQnpzbkVoTitsTWlQYzZBUlF4SzVEeE9QM1FOQWwv?=
 =?utf-8?B?UXMrTFJQcWpSejdPb0lYOVdyejQwNEpiTnJCbGEyeXJPUm5vb3pjNFkzT1lW?=
 =?utf-8?B?OUJPWGdjZk5CNXN4ZjBzbmptd3QySktDUlVmNDFNTnUyZUFJak1zdXpwNXBs?=
 =?utf-8?B?NHNFd2xsZUc2S2RZVmUxUHdVdHB0TGc3bTZ4QmZDb1RDZkJ3OHdvT2lyeUZY?=
 =?utf-8?B?NEVEd3RCbE0yMisvM0ZWeS9WVFRpNmM5K0hrZ05VSzJQQ0hpUDBmSkRVdGxW?=
 =?utf-8?B?OTdWSkVkUlIxSlN2WjZDL3BpVFZ0aXd3M1l0RVJ6WElETjJGMEtQQmxNWHpK?=
 =?utf-8?B?dkJUL3paZTBFR0VZNUZjSVgzT3huajZnWS9YYTNWc293cGp3enUxcDhpQ2JH?=
 =?utf-8?B?WnVjVXRlaTExUkdVcnhCTE1iUTBLYkxacGlGR2JxSGFEbWwvRXdHdjRlSlUv?=
 =?utf-8?B?ODZkU2YxcDI0V1RqVkYvOUs5UmJta2t6eHluWm9JUFBVREpPRkd1L0lRWkp6?=
 =?utf-8?B?ZzNHSWlZWXMxSnZ3aTVmK2hENDh0K3YybTQzMHJTcVZybytYODFXOWNwaU9M?=
 =?utf-8?B?eEM0eTVXaWovSmYycDJBRVMwOSt3aDZVemtSYngxNG9FN3RiVUhxam5MdkRE?=
 =?utf-8?B?RDg3ZFlSVjA1WWhXSDJONjNWNjVuM1JqSTdXQ1JBdzlzRHZoTVh1eEt6MlNy?=
 =?utf-8?B?OXNLSFI5cS9Id3A0Z09zNXlLMnJlKzZKWXhFWUo0elNTa1pSM1QvTWprR2J0?=
 =?utf-8?B?anpVUnY1TUZPUGdOeWpZcGtWRGhOMGlNaHlXb1AxU0xDTzh6NERpYnJpWnVV?=
 =?utf-8?B?T0gxTUhSYys4dHRnNmdjaWlZMmR2cjlvQS9LTWRrYnR5YkdKUXJsNXk5WjZX?=
 =?utf-8?B?Y3dkbjNGUFJjSGE4ZnZldllZaGxQZkk3Qm1LdllkNjhCR0lOSHNRYksrc3NM?=
 =?utf-8?B?SWx0Z203bmRRS0xja1lrLzhCUk5jRTM0Vjc3OWlVcExsZVFGYWFORFR2SlU4?=
 =?utf-8?B?MlFRb0ZMU3h4RXlaYUpIZWRRZjAyTUpxWlRDdzU3NnEzOERJQ2Z5cDFYdVgy?=
 =?utf-8?Q?gxqlndkHDiL4+vs/KQZujcMIE?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b99c406-75ed-4aea-3ec4-08dc15a33dbd
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 08:23:24.0597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L0sVX6iZLlbWmon52FTNy4eQzJ5+EG7QAZLP05L6N82RTJp87nI6JpmdWEJUv2PFe6TZpMJSfNkXQhZIQHGhUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3502
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Jan 2024 08:23:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14379

On 19.12.23 11:08, Quirin Gylstorff wrote:
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
>  - cleanup 2021.12 for debian buster
>  - move cross and nocheck to swupdate.inc
>  - move DEB_BUILD_PROFILES pkg.swupdate.suricatta* back to swupdate_2023.05
>    as the apply only to this version
> 
>  recipes-core/swupdate/swupdate.inc            | 21 +++++++++++--------
>  .../swupdate/swupdate_2021.11-1+debian-gbp.bb | 11 ----------
>  recipes-core/swupdate/swupdate_2023.05.bb     | 10 ---------
>  3 files changed, 12 insertions(+), 30 deletions(-)
> 
> diff --git a/recipes-core/swupdate/swupdate.inc b/recipes-core/swupdate/swupdate.inc
> index e5e7282..cb1716b 100644
> --- a/recipes-core/swupdate/swupdate.inc
> +++ b/recipes-core/swupdate/swupdate.inc
> @@ -1,7 +1,7 @@
>  #
>  # CIP Core, generic profile
>  #
> -# Copyright (c) Siemens AG, 2021-2022
> +# Copyright (c) Siemens AG, 2021-2023
>  #
>  # Authors:
>  #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> @@ -13,15 +13,10 @@ HOMEPAGE= "https://github.com/sbabic/swupdate"
>  LICENSE = "GPL-2.0"
>  LIC_FILES_CHKSUM = "file://${LAYERDIR_isar}/licenses/COPYING.GPLv2;md5=751419260aa954499f7abaabaa882bbe"
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
>  def get_bootloader_dependencies(d):
>      bootloader = d.getVar("SWUPDATE_BOOTLOADER") or ""
> @@ -37,6 +32,14 @@ def get_bootloader_dependencies(d):
>  DEPENDS += "${@get_bootloader_dependencies(d)}"
>  DEPENDS += "${@bb.utils.contains('DEB_BUILD_PROFILES', 'mtd', 'mtd-utils', '', d)}"
>  
> +DEB_BUILD_PROFILES += "${@'pkg.swupdate.nosigning' if not d.getVar('SWU_SIGNED') == '1' else ''}"
> +
> +# deactivate hardware compability for simple a/b rootfs update
> +DEB_BUILD_PROFILES += "pkg.swupdate.nohwcompat"
> +
> +# add cross build and deactivate testing for arm based builds
> +DEB_BUILD_PROFILES += "cross nocheck"
> +
>  python do_check_bootloader () {
>      bootloader = d.getVar("SWUPDATE_BOOTLOADER") or "None"
>      if not bootloader in ["efibootguard", "u-boot"]:
> diff --git a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
> index 8f7a97d..0f91d5e 100644
> --- a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
> +++ b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
> @@ -27,17 +27,6 @@ SRC_URI += "file://0001-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch
>              file://0004-debian-rules-Add-option-to-disable-webserver.patch \
>              file://0005-debian-Add-patch-to-fix-bootloader_env_get-for-EBG.patch"
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
>  # If the luahandler shall be embedded into the swupdate binary
>  # include the following lines.
>  # DEPENDS += "swupdate-handlers"
> diff --git a/recipes-core/swupdate/swupdate_2023.05.bb b/recipes-core/swupdate/swupdate_2023.05.bb
> index 77b7431..d1fe1fa 100644
> --- a/recipes-core/swupdate/swupdate_2023.05.bb
> +++ b/recipes-core/swupdate/swupdate_2023.05.bb
> @@ -31,13 +31,6 @@ SRC_URI += "file://0001-d-rules-Add-seperate-build_profile-option-for-delta-.pat
>              file://0003-d-rules-Add-option-to-enable-suricatta_wfx.patch"
>  SRC_URI:append:bullseye = " file://0004-d-swupdate-www.install-Fix-path-for-debian-bullseye.patch"
>  
> -# The option: "pkg.swupdate.nosigning" disables the required signing
> -# of update binaries
> -# DEB_BUILD_PROFILES += "pkg.swupdate.nosigning"
> -
> -# deactivate hardware compability for simple a/b rootfs update
> -DEB_BUILD_PROFILES += "pkg.swupdate.nohwcompat"
> -
>  # suricatta wfx requires suricatta lua and the dependency
>  # is not set automatically
>  DEB_BUILD_PROFILES += "pkg.swupdate.suricattalua"
> @@ -48,9 +41,6 @@ DEB_BUILD_PROFILES += "pkg.swupdate.suricattawfx"
>  # with cross compile we have a unsat-dependency to dh-nodejs on arm/arm64
>  ISAR_CROSS_COMPILE:bullseye = "0"
>  
> -# add cross build and deactivate testing for arm based builds
> -DEB_BUILD_PROFILES += "cross nocheck"
> -
>  # use backport build profile for bullseye
>  DEB_BUILD_PROFILES:append:bullseye = " pkg.swupdate.bpo"
>  

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


