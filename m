Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2AFBC48297
	for <webhook@archiver.kernel.org>; Mon, 12 Feb 2024 18:46:10 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.58])
 by mx.groups.io with SMTP id smtpd.web11.14731.1707763564431522944
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 Feb 2024 10:46:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=eyxNXDyH;
 spf=pass (domain: siemens.com, ip: 40.107.249.58, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABi4PkP4SJb1uJUAGZAlqfwPvZCTC0coUXxhsMjrScj4f8nlM1NhPqUtZgRDTufj7hXLU+HDo7PJePN0hOhtOOGP5oOvAMtjVTuos+Ox2dNBPA2g+WGrbdgED9FWH6xjudr91mxUpyOy+/jcbjFG/41mItPkrxc3ohj6XSaUEA6A9DMjSAFxvFunE7jgtCRTiBKcIXAyBawzoJcTgxwzkHo2YfaHFKjkgj5k10SVsiPXq4mhgsRuUEJf64NvnVC+cj7bdsyodBKHaJoq8THrli0FuK4B0Nr4Umw7V5TwBVCza/iI0VYLKRM6fMvqY+3QDa/TRcJMZBZi8Hmnyk8X0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b0I6iM6mga7OxsVQyJ5YEmPAdqOJeyqg4YlmSk2yJgs=;
 b=kzQN+YPHRz2/0RQwMYWWBOh3xKroifQgXxG9XFelEGHOtULnSFlwbUKR5wmunHIyRWMuDEcDwNsJ/lPUgvTMXSqBK76z7O8LrCbp0gV5DYIo/U4CEV3t6Oxof/cLkzFBqK/XaJd/Pa1D7H2TRfrHSHTC8XtYp3ksJTfx1FBKUCReyZbIGlHnrQjW8GdXrQujkJnS9Lwg6EY/A7yH7MrWWzwZjIwxOTdtq51R9XwMFYsLUNS3z/tZlae5cglD2NWKUerOecGyiGp6zE2+xBb3mNUFiFESsSFJsj81BVGENU70RwwMKOCy76FQzwIP1/sBXzqgiHJoaOypYRWJe9KZ9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0I6iM6mga7OxsVQyJ5YEmPAdqOJeyqg4YlmSk2yJgs=;
 b=eyxNXDyHrO6NppBceQHHiLkdE0ZdA6pMnj62XoyA2qVeQFUUAGC99zpw0kkBZkVVW9Hb8ttkBO+CbYTLmxrt+HRtQjN/EGNrQOQOViomqxk79DKmX+D0LYfBkEKBChYaAdfR+Cr1nXzSibySB6vA4giT7ppp34mQfXWX/qUrtkb3AE+DAzydQeujWotemvReH+CuxnpgvidwpDYrTjscwmYjyM1+w+kfW/RY8iVU0g6NzPMyMz7P5OPq8LVWIhuCJfSa2si5VsdTUGydPUZ+3Ez1eh/tMY9ThXQDvqya/X5XhgxCQQxTNpvhll47c4c/G3Of4/+Nc97iWkmDaIKgFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6196.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:93::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27; Mon, 12 Feb
 2024 18:46:01 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7270.028; Mon, 12 Feb 2024
 18:46:01 +0000
Message-ID: <8a1453fa-9290-472d-93ef-041d7b632fc4@siemens.com>
Date: Mon, 12 Feb 2024 19:46:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 1/3] swupdate-config: move
 swupdate.cfg from customizations to own recipe
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 felix.moessbauer@siemens.com, cip-dev@lists.cip-project.org
References: <20240207134505.3286003-1-Quirin.Gylstorff@siemens.com>
 <20240207134505.3286003-2-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240207134505.3286003-2-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0162.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6196:EE_
X-MS-Office365-Filtering-Correlation-Id: ac6955d2-3675-4fff-22c5-08dc2bfadc04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	KgjJFjRNbmRL/z9Ih/zZ/oRXxpdfhlHJ8q4H/rafWg4icFj9n3Lb7T3A2EMS1NyJ3xdzVopsCo+LKWrPFObed5mZZkKAXT4yLrRWIMeHD4wZHfdJhM8WGL91HG4da4mfCNzng47oJK3KfP1N0CRZQTiWuMMWAkEvxcsrdN3hl7HX27qrea+F9caBE4p6E5e5+/S05LifmPpdmxOWirRkj0EehyvHMk7Q9Ej4ec0uZz1hwRvu6TBeywHS6hxyQl21FkuyHORM+Q2vpOscJLAPn44dHAvFW33zW5GE925EY7VQ3FKBCt/IZGZi1e783iyEfEtS+Tie42J0ppliZXBVMCtFozWXxQfPaozzPeqUojyW2yWnefJvpSBChFroHf7N0tBg6VGbXfYtO4G1qf0T58XgC/yXg1zYBVBESLc+scjQ6ZV7ns6P9EocWPowHFxNAzRWKusR4o73ERDQXmuNP399BXhbtCbLliZPdfyWGS2vaVvDxlD44+n3Upwu9v/NENKmQMvUYnbVNabR855dUuZ/xVPFLfkUVOf8t1SEmtQS8PPD+VFQgxEXpnPYsihh
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(136003)(366004)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(86362001)(31696002)(38100700002)(31686004)(82960400001)(41300700001)(2906002)(316002)(6512007)(6486002)(478600001)(83380400001)(6506007)(53546011)(26005)(2616005)(36756003)(8676002)(8936002)(5660300002)(66946007)(66556008)(66476007)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?akpiTXNMYmNQSUtqMkNkZXIyRFJ2Qnpmc0t4VG8vSkx1NmpLM2Q2c2pZemla?=
 =?utf-8?B?dzMwbjQweTgyYVhmV05LVHgrSTV3U1MwSVY0SDZFOWNxMVo1NmFTeDUxNGxW?=
 =?utf-8?B?b2FWVHJhcGZUaTZRWWNNOGNvNk1vOUowd1JwYW94M2xkYzNESWdHOE1wYVlO?=
 =?utf-8?B?ZW9KdTM0YlZJU2ZIU1REZGNjbjhCZ1NiSkNrZmxxSnRRTDZDUmR6RmI0YjVU?=
 =?utf-8?B?RUxlclJEanVnOWQ2bjFmellacmRwUjJ4dFpPOStQUStxdllHM1pWR1VEZFp0?=
 =?utf-8?B?VXcrMjVLRGN5TjhaMFVzM3ZTM0orUlhHL3VqNVZQY3RNVjQxSEUzU0VMRks3?=
 =?utf-8?B?d2xJQkY3NXV4WkN0YThXdzR4NVZaOFc1WEY3QzV1bS9RVGhrR1dKbUVSQ1ZU?=
 =?utf-8?B?MmQrU0VJRXM2c2srdUlYVit6MEM4Mm91R2FySXFLR2luMWZ4N3F0Ym5WSklN?=
 =?utf-8?B?N0FNa3dTYW1NTUI3dmlEcGs2WlA1MkVwblRrY0NxazdOMXNENGlBZUlTRzMv?=
 =?utf-8?B?aHNuMWFCQUNCM3ptYXg5VUFGS09sRFlFbmp1QmFLMTAyK0FWbXZpSzVTUTUv?=
 =?utf-8?B?L3ZjT2dTSFJ2aVVIaVA5ckRwclkrajdYN2Q2UklWNW5JUld6Q3ZLbHJubXBU?=
 =?utf-8?B?aW44L3hPQUh2V3RUdXNYc2pPcUhLUEFPSHhjZWUvUDdFQTlLSEh3ZW9HbU81?=
 =?utf-8?B?RkEwY29GRHQvWkV4NGlnWTQ5N1NwV2tNb0Q3U2Z5RjBSckpVd0hRKzlBaHdq?=
 =?utf-8?B?eGVPUE9YQW9LdWVPbThsRHFOY0t4NWpKTUxCZ2tySmRQNlB5TFVhOVBkUEtz?=
 =?utf-8?B?OW1JRy91RnY4K2lsV2JFdk1PQUkydndBZ3BURWtNckxSUzlPR0hWdG9Ld2lZ?=
 =?utf-8?B?V0xKN216SGVTZFVIdFkvYTdDb3dPd0llY2ZqWUp4K0lTaDg2QVBFaGtEZ1RU?=
 =?utf-8?B?c28xek1QZGdkQk1YR0cyTzNvaEplYW9nWTJwaVY0RndHUTV4ZW0wR043VVJt?=
 =?utf-8?B?T295R2ViZDdIZ0lwQXRrMDJXeTlOcWNvQU56cFdjb1YrT1RNMEZWb3ZIMXpi?=
 =?utf-8?B?ckFHN2JOV1VjZUphWVVaaSt5eXp0UUMxNXJYVUpIaFNYbEtVMVcxNHVOeE9Q?=
 =?utf-8?B?aXpCWitDVUdEdmltbFkyZ3V0T1MzM0QvdFFxQWlueVpIUG1SZFRSbkJZMm10?=
 =?utf-8?B?LzR3emhsMkV4VTM3U014SUVYT0dRZTM5RHBPUFVHb1VCMlRYS0FZbHNFeWdZ?=
 =?utf-8?B?ckhjbldjNzJaQnRrL3FpQTFTL0xPNlo3cmo5YkpCMGdaS1F2ZlBBcDR2Mngy?=
 =?utf-8?B?MFdMZEU2QzBDanZxdHg2ZHFqTUZYdjdlRGs4VWdmRHRWTVRqWnphc2tGQmtI?=
 =?utf-8?B?K1VXcGt1K1RtRVQwNnVLZU9zYVlmV1hmZVRZSzVKdm5BSWxKbngzc1pSdHZP?=
 =?utf-8?B?ZHBtL1ZxQ0R3ZERxWnM5RmxBdHFhWjJGM0lXZlhNWFE0UkhIVWRPRE1Td0lZ?=
 =?utf-8?B?QmFWN05Yd2VTVE53MFNvNVltVW1HemV0TzIwSGR1VHcrZWNmT2k2ZGg4ak1k?=
 =?utf-8?B?NUlvR0tVcEJVVDl4aXFYWkJscTNrRWNpY1Q4L1FjSWI5N3lLNm1POHJWS1V4?=
 =?utf-8?B?MXFJbUphUlg5d0ljQnQrVXBaN2x2M2Y5eTFnOWFFZlVSdElxSFp2NUtMN2tr?=
 =?utf-8?B?ZXJRb3VuSTdKMktPSEVEZStSSG14V0dlOHo4aEdTQVlzODR3dDNqQXdEU1FB?=
 =?utf-8?B?cFZLTnNMd25RRUQ0NjRzQUZJOXVzU3c0b1JkaUNWNUhYMVV2WXBJcTNsUnpO?=
 =?utf-8?B?Q3lKSFZMSmJCNnpDRkJpd1I3bVRNdEpOaWxZVVc2NkI4N3dZamhLZjF4c1cy?=
 =?utf-8?B?bE95bzhsNXlzRFErV2NtUFNwVVBJeHJBckF0WG1aRVZTcmpPWkVidENvM01z?=
 =?utf-8?B?VEJEaU1KUlMxZkN1NEZ0N3ZHdE9MYXJ4SU00Nkd4ZEJSTVlrSXFJZlE1eTJL?=
 =?utf-8?B?ZXJpR3NJQjM1Rlp3NTZMMnpCTjF0NFhaUFowNTBBZ0hCNjQ1WkM1MjIwc0p3?=
 =?utf-8?B?VjlSOXVkNDJoREsrdzI0dThUSjVzdyt3RVozZ1FGVWpzZWpCQ0JSL00zT0pu?=
 =?utf-8?B?c0RxY2N6MzBxb1NvQ3JGSjRCNUlrTkc3OG9wZm5hT1RjdUFmNjh3WkFiankr?=
 =?utf-8?B?bGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac6955d2-3675-4fff-22c5-08dc2bfadc04
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 18:46:01.3797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kB2S+Fl0lFvBkkwU5Hz6JVxlSVMI1KTW1dEhaFpaDT3JOZaaXkl2lU4uziY6KrTOOS1KAKejkVasaz839Bgl5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6196
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 12 Feb 2024 18:46:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14929

On 07.02.24 14:44, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This allows downstream customizations without including unwanted
> packages.
> 
> It also adds the possibilty to set the SWU_HW_COMPAT

You likely mean MACHINE_HW_VERSION.

This "HW" in SWU_SW_COMPAT and MACHINE_HW_VERSION confuses me, and both
variables are not documented. What does the HW stand for, and can we
please fix the documentation?

Jan

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
> index 0000000..ec1d667
> --- /dev/null
> +++ b/recipes-core/swupdate-config/files/hwrevision.tmpl
> @@ -0,0 +1 @@
> +cip-${MACHINE} ${IMAGE_HW_VERSION}
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

-- 
Siemens AG, Technology
Linux Expert Center


