Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E8EC5475B
	for <webhook@archiver.kernel.org>; Wed,  6 Mar 2024 06:58:17 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.59])
 by mx.groups.io with SMTP id smtpd.web11.6669.1709708291571396436
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Mar 2024 22:58:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=dph7ODtV;
 spf=pass (domain: siemens.com, ip: 40.107.8.59, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IFqIxjEsjLvLer/gJKjsDFcJQiVFC3+H/gY/hh2FGUc9w1z3HAQjqlpQsZlUQB5zkVVL4JQ0vsh6buJVXPX5FDYvxv7qEMVlH9Aod5vMBrimOTqohpMqrSf12usJhTKNNJcp+we7ZGOvT+VSU+uqbo67BRPwLCMZg4N953WsB5uM2pJjuBdUDGi+anLjvslTlOIamiJCOs3+Dpnl3BhoyJ1ADqHVk7Hg3XS1zM0RWllrWnYd4H82uLdbAIW0WlEYJjUkgFvbmsNZ4x6mhx9AbDoWPm3fpGK/NZZ7w+A9oJub2uUM3hWvtXc+GgUhnGZuwtIW4TJuvwfp+zhuJw9Bzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/3CjGN+FBx/dCYcoqEZ1EHrLgzvQ39rlz56qILKhZM=;
 b=kVZ/Wh39NXIHRFHlS4NZ1ZCORq//pNpoATinD9eMyFBNW20pASnI94UpSAnFd+0YpMJkzCUN78bV779+Aklf6rtbFyoKDZh0pyFT3cBjRgGZQFMOdO01F9r8S06w4y19lDXp5P20Bl2/colUnljvrkFMgIOqRbk2L0hs2HfCUYeZjNiEeDuk8S0a544hB2yX/JAcU2EePWN1x9RIk/w60WTdYEWW6HwyiFuXLYC72ZitokyO6x/guABLuZRPvie/hfhyt7JKOqw4Sz1mr/hrQhxapjxzKMM3ySHITT5wMvKcH71GjyARU+mHZOuHzYhNoBKQMPWfWEAUhI30cYElfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/3CjGN+FBx/dCYcoqEZ1EHrLgzvQ39rlz56qILKhZM=;
 b=dph7ODtVN19dBnvcQzP2gS5ESoS+443P3iau/BJIQXpMey1qQFAyJKynSejec50NFds4HKX+Waxaf9LtwDDBrpk/eDnSpCPseCNcJO+f1ZKFvORl4rE2RvNaw4dTmFI8MYGS5vNyW8joAaX2PVBlXaRt31arw/2wbOhoR8pWVSjHUzYFgZzikNfvH1tK+BjWpvi7i1EwnYWdRtj2z9BsfuXoTws29o+bI3q/H2tzdf5RMa4POY7JeUoRUe2NsXKJxl9lh8KugRTsDKcxnfiwxWcWiI8w2aEPdBZZpo16Qi+/6N1UkHFX/vpfZANzI1Etfzm2+1J9E3X0MxdCXMCzUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5560.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:320::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 06:58:07 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7339.035; Wed, 6 Mar 2024
 06:58:07 +0000
Message-ID: <30922b1e-8406-49f6-896a-3c4d1874625a@siemens.com>
Date: Wed, 6 Mar 2024 07:58:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v4 1/4] swupdate-config: move
 swupdate.cfg from customizations to own recipe
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20240304105453.984881-1-Quirin.Gylstorff@siemens.com>
 <20240304105453.984881-2-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240304105453.984881-2-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0018.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5560:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d3f79b5-aa93-4b5d-7586-08dc3daac736
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	X7R6PXUo6aa5gY0aBiQAh5mNQVMeCnoSdazN8/FaTwk0uVm7uZ4IU/xuMaXUD5tUPnZooYMQNB52PjWwu2IVR4aJkvaYvIudMsbaLP5n5Gh6n4r4yAJWsUF3YeUtIXjjmzjcu33h51xlbACg9FW+abqZQVXCMn1jCcmAEfQpYMjtQM5EBTVKHmr++vMqcIl7+44Ws52kXhOqCH3hk74RpEi9vdz5vjK7UgUR2jnBk8JyFiShjxteT0BuJVrE38ONX2YI5nT/5NBsaI7aST5iUdU90w0d0fcVfibs264dAnUvX5kdrvcn7FS/Uf8G1l4fNKBCnBX7RU4hI59jXGYLq7omExdO8AWmZBH783t7MY+8qWGUjcm0Nb7sMk5dG2DdHceZ++BkUnL6WxSFBU/i/V6FRYu6vmpbpDaPR+REjBnExE2oqSQz6Y876vjpuI/GYyf8BmKNxfmHiBE5TSBQhnCt2d+06SPqaTnxg7qh5jXXwnLCJAHKplvWUl4Vfni1qixo8/rtAsxvSSLlLZ+2eAQTJNGvBlKYDIs83Id0w6ZEgUiKvWyZV1khmDSumw2aM2AQUf2LRUsmj1uYW2QE1nO5GOX0Zu6IAh6/e12oS129/+DtFNY5Iy3VhycsY4ZssnsgboUD9J+Vqp9WXb+Xz569cZPXeewLQENCrh4B2y4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MWZaYndMOGhkbWR4dS9obSs3M00zY1ZJQXQ2dzV0WHV3ZW1pbml4Q3VLaVcw?=
 =?utf-8?B?YmNETS9GYzQ3RDcwMUdPRE94emdob2hNZG0wMnh0UWxUL3dkcDhDQVdoUldI?=
 =?utf-8?B?akdjLzJQcVNOYkhWQ1ErNzkxQTNCemlyUDhVdDNwTUR4SUVNN0hiSzJ1VGFh?=
 =?utf-8?B?cWEvT3BaMXZMOGtSZDRyWlRPd2VzOEk3YlZFL2tvMTJJQ09XTTdOQUs3MzUz?=
 =?utf-8?B?OXdoZDRyKytGd2loNGV0cXdzVXlWSEVrMGdCaWVVdjl3QzZhN3VTelBEOWxk?=
 =?utf-8?B?bXRybEdaZmRsRkI1K1FQZDdwWVJEdVpZYkxlRXFTR05saTRwc0dmbmlqKytF?=
 =?utf-8?B?dml6NGNscktsVUdFdkJwLzd0L21adlBjd1daYjUySmpRdndjdHRUMDlyc05M?=
 =?utf-8?B?blRRM1lmcCtCY1I0ZkIrZ3lweXZQWlAza3NEOHJLcGJNQ2ZJUXZJVFdtWlA1?=
 =?utf-8?B?VzZxZHJGTmY1UjJMQmh1T2JwSHRnU0llR1VhdVd6NUpVblRRWXVIanppQld0?=
 =?utf-8?B?R2VrUlJvTzRtc2JVS2lmZjFWQmZkMWlGR1VyQ2hyKy81UmpxSlZ3MFRMeGZH?=
 =?utf-8?B?WjZjaGI4TkcrRkRJd3AzTDJ4R0hzejhtb0Jwa0g3NmlvWkpMZHB2aFl3TFUr?=
 =?utf-8?B?ek1mSTU0TUdvTFlwODlqOGMxTTJUQ2YvVDYxaUlnVU9uM2h1MWpWelVpMjlu?=
 =?utf-8?B?UVFJMXNMdllCeUV6NmtMM0o0L0FCRTQ4aVFlazhCeVRCQlQ4QlBVZFBRK3Y3?=
 =?utf-8?B?MG53ckZHMHFCTVIyRGZqaVJGTTc0SXJwZG1sRGYyOUN3WlRmcUNJcDZiOVhX?=
 =?utf-8?B?a2Z5TXEwb0lVSXJNT0drWWg1NVdFc25obzQrcThxaGV0Y3JWVGNFL1d2Rk1F?=
 =?utf-8?B?dy9BV0hkNVgyV0hmSkoyRlNhV1pvNEIxZUp6aTFZcnQ1bStnNHJDMlF3MjNG?=
 =?utf-8?B?dGdJRzJLSFYzbDJMdGt6akhqZ3MwNHdWWHVLSmptajc1WTJGN0wxUEdZSW1a?=
 =?utf-8?B?dm5VcnFOeDhmcUJ5blRvakFYYUtaTFp6K3ZhNmhOL3oraDZMMk51WWUrMkM5?=
 =?utf-8?B?V3RIVmFIbG9BUG44Yk12b3JFUFRIU1VzTysvdVpYMmVTZnFPTlJLeE0wNmRD?=
 =?utf-8?B?UjBGZGl2OHUxbVpFMEVTcWlOM3kybFdnbnA4MjhFRDkvY3ExOUJYNFV1d1gr?=
 =?utf-8?B?cStoQnRUcEVOT1dJUmtoZ3docG5oYVlNNW1aL2xXTkJHejQyRk5URkJIaGFn?=
 =?utf-8?B?dmQxVnJFekhoOVpGZE55T21zTkxSYndFc3owa1JjendSaWdJSHVKYWh0TEJJ?=
 =?utf-8?B?N21XdFhqQkxCR1ZXNDFTSXRWYVRRc3JFY2k1NFVIVmpXNWJuRVJTaGY1L0F1?=
 =?utf-8?B?VENOcmtUR013UktCVUc2NHMzZWxueERSTklwVll4VEJTNnZ0QThMejJGVWF2?=
 =?utf-8?B?R1Z2aUU1U1dWNFcvcXhnMmU0eS9TZ1BlMDYrSUNmS2F3MlFRdnpuNEROTDg5?=
 =?utf-8?B?Nnl0WW5aREI4ZDVWMTBTMlVjTjRsaTA4eXh5TUVoNXpWaUs2emZ1NHQxc01s?=
 =?utf-8?B?YXh3UFhWejlpOUk3T3lpakJkSEZlSWt5emNCU2x4dnNabVdGSVZ2T0U0MVc1?=
 =?utf-8?B?TUs1TWlZb0E2S2gwTS9DOWJmc2VlTSt0dCtUV2NmYklETW9mQk5wL2xJc1Ur?=
 =?utf-8?B?aEhpdjZyZyt1Ui9CdXZzMDRKNGVXYXdrM2kxR1JSQlN5dzR2V1d4eXNWU0ZJ?=
 =?utf-8?B?bmo3dVdTakRqR3RWRWVCZUNqT003USt5MVBlcmNLNlZUNGNLWEJuYkxCeGdo?=
 =?utf-8?B?RXJ2L2xQNTdrZXJPRTJ0Ni9rVGtJYm9iaVpneGp1WG5Id2R3SjN3Z1ZmQ1ZE?=
 =?utf-8?B?blNmWTF3M3crTGVrY2hZditQSFh6RWFqajB2RmUyVXZVM2VsQURJSmZpdmdU?=
 =?utf-8?B?QXR3alNXbkFaU3pKR1Z1TkxDR0dLaVZjVHdZdEFlMTEyamxMODFNQ3pYOTc1?=
 =?utf-8?B?MFNPUVBYeUNOeFhYZDZ1V2lkaDk0cnVYMVpLb0xOanJwMHkrUHZtZTc1ZXYv?=
 =?utf-8?B?RS9KVkVCeVNlWEVwZFF5dmtjaVVMc05yZy9PSVJkeWlzUkZhcnUxSFRFL3RL?=
 =?utf-8?B?cDMralBwOWdNaUUrVFFaL2pMRnB0M1ptNmlHS0t4eHJyN2NnMG9EWnlpZUFW?=
 =?utf-8?B?Rmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d3f79b5-aa93-4b5d-7586-08dc3daac736
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 06:58:07.7642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j5K9qgHS/W8Ig96qTAembMEXoaVrbL1c8Y0ApxIxRRAOVub8jzn3NCRKUaqtjdJOcrPVJLRVq3G42R1F6nDIJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5560
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Mar 2024 06:58:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15237

On 04.03.24 11:54, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This allows downstream customizations without including unwanted
> packages.
> 
> It also adds the new variable `MACHINE_HW_VERSION` to check the
> compatibility between machine/image and the swupdate file.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  recipes-core/customizations/common.inc        |  8 ++----
>  .../swupdate-config/files/hwrevision.tmpl     |  1 +
>  .../files/swupdate.cfg                        |  0
>  .../swupdate-config/swupdate-config_0.1.bb    | 27 +++++++++++++++++++
>  4 files changed, 30 insertions(+), 6 deletions(-)
>  create mode 100644 recipes-core/swupdate-config/files/hwrevision.tmpl
>  rename recipes-core/{customizations => swupdate-config}/files/swupdate.cfg (100%)
>  create mode 100644 recipes-core/swupdate-config/swupdate-config_0.1.bb
> 
> diff --git a/recipes-core/customizations/common.inc b/recipes-core/customizations/common.inc
> index 79bf80d..37872c1 100644
> --- a/recipes-core/customizations/common.inc
> +++ b/recipes-core/customizations/common.inc
> @@ -19,8 +19,6 @@ SRC_URI = " \
>      file://99-silent-printk.conf \
>      file://99-watchdog.conf"
>  
> -SRC_URI:append:swupdate = " file://swupdate.cfg"
> -
>  CUSTOM_HOSTNAME ??= "demo"
>  WIRELESS_FIRMWARE_PACKAGE ?= ""
>  INSTALL_WIRELESS_TOOLS ??= "0"
> @@ -29,12 +27,14 @@ TEMPLATE_FILES += "postinst.tmpl"
>  TEMPLATE_VARS += "CUSTOM_HOSTNAME"
>  
>  DEPENDS += "sshd-regen-keys change-root-homedir"
> +RDEPENDS:append:swupdate = " swupdate-config"
>  
>  DEBIAN_DEPENDS = " \
>      ifupdown, isc-dhcp-client, net-tools, iputils-ping, ssh, sshd-regen-keys, \
>      change-root-homedir \
>      ${@(', iw, wireless-regdb, ' + d.getVar('WIRELESS_FIRMWARE_PACKAGE')) \
>  	if d.getVar('INSTALL_WIRELESS_TOOLS') == '1' else ''}"
> +DEBIAN_DEPENDS:append:swupdate = ", swupdate-config"
>  
>  do_install() {
>  	install -v -d ${D}/etc/network/interfaces.d
> @@ -46,7 +46,3 @@ do_install() {
>  	install -v -d ${D}/etc/systemd/system.conf.d
>  	install -v -m 644 ${WORKDIR}/99-watchdog.conf ${D}/etc/systemd/system.conf.d/
>  }
> -
> -do_install:append:swupdate() {
> -	install -v -m 644 ${WORKDIR}/swupdate.cfg ${D}/etc/
> -}
> diff --git a/recipes-core/swupdate-config/files/hwrevision.tmpl b/recipes-core/swupdate-config/files/hwrevision.tmpl
> new file mode 100644
> index 0000000..1eb0996
> --- /dev/null
> +++ b/recipes-core/swupdate-config/files/hwrevision.tmpl
> @@ -0,0 +1 @@
> +cip-${MACHINE} ${MACHINE_HW_VERSION}
> diff --git a/recipes-core/customizations/files/swupdate.cfg b/recipes-core/swupdate-config/files/swupdate.cfg
> similarity index 100%
> rename from recipes-core/customizations/files/swupdate.cfg
> rename to recipes-core/swupdate-config/files/swupdate.cfg
> diff --git a/recipes-core/swupdate-config/swupdate-config_0.1.bb b/recipes-core/swupdate-config/swupdate-config_0.1.bb
> new file mode 100644
> index 0000000..6991321
> --- /dev/null
> +++ b/recipes-core/swupdate-config/swupdate-config_0.1.bb
> @@ -0,0 +1,27 @@
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
> +inherit dpkg-raw
> +
> +SRC_URI = "file://swupdate.cfg \
> +           file://hwrevision.tmpl"
> +
> +MACHINE_HW_VERSION ??= ""
> +TEMPLATE_FILES += "hwrevision.tmpl"
> +TEMPLATE_VARS += "MACHINE MACHINE_HW_VERSION"
> +
> +do_install[cleandirs] = "${D}/etc/"
> +do_install() {
> +	install -v -m 644 "${WORKDIR}"/swupdate.cfg "${D}"/etc/
> +        if [ -n "${MACHINE_HW_VERSION}" ]; then
> +            install -v -m 644 "${WORKDIR}"/hwrevision "${D}"/etc/
> +        fi
> +}

If I'm understanding the docs correctly, the purpose of this recipe is
just to act as a placeholder when we want to use a static
/etc/hwrevision, nothing hardware derived, right? That leads to two
questions/suggestions:

 - How about a better name for this recipe? swupdate-static-hwrevision?
 - How about providing some references/examples for creating hwrevision
   dynamically?

BTW, error reporting of swupdate is by default useless when you have a
hwrevision mismatch:

[INFO ] : SWUPDATE started :  Software Update started !
[ERROR] : SWUPDATE failed [1] Image invalid or corrupted. Not installing ...

Jan

-- 
Siemens AG, Technology
Linux Expert Center


