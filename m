Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF914C636D4
	for <webhook@archiver.kernel.org>; Mon, 13 Feb 2023 15:28:08 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.82])
 by mx.groups.io with SMTP id smtpd.web11.17261.1676302086300217955
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Feb 2023 07:28:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=DuHY+EX6;
 spf=pass (domain: siemens.com, ip: 40.107.6.82, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=isKv3uYo+y9jZZQurcnDhdhUeQVqUwQNItl6QBauhiCMq7OU5m3ExDEYuYv0zw3iltkhIIfCz4ulTx1uOirKZ2Sb8xPtPXPaDkQ0P/i0ac2R5ez8ndPegAVTqmMyr8uk1poicP9eDqaygDHDdkOezI7XGtWfqdL9JS6vDJ0u8cGCqgEZcyR7OkYNknLlNWVDFgbXGI0QofvC9ymX1dHFA0BoDTdLUmlQFWXvgI3V6YCm/zoFH1yOmxafDVMo/lRJI0P4U8rS/7ohqLWbgmccZSGDFEcd2ixpO4RnQY16eo7LPQlkGKaMn127HHXOA5hqGRg9US/9oYRxQt71lRJWIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WXTQbSxJeodI2czBiE4+gz+RZAS9i38Arb448md/VMw=;
 b=FBgcC4kMBfVFE5S2Pu7JzFqO+qY5WUXjK8dAP91a+ItWi87NvCSqZ6pjjrLhpMZWk0YjUvqcXjKjomTbYPY2omh5N6JBiOCgyZFqsvwPiYTXix1rJAn8x7yKSQ60LEErwQfpZsaD1IngfYKCI0KslV4zNxI3xp7RSqinS9UWzslR4Vc04MsQn63dfBt0AyXFULzcDRokGed6TU0QDfa39uiaFVCcPdygzSQYDeFaZU8wZY0+cgTA4yHFsRGU0ZjTCu6x3X6E3fy22lDxIUSbuCPyb+FhZ3cTys5IeQsj6u3OEFqdkRydPAKC+Zhp3dwCCWFWfn/2KQz/CSlpcH448w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXTQbSxJeodI2czBiE4+gz+RZAS9i38Arb448md/VMw=;
 b=DuHY+EX6Je7gfsP0lEvxHTmUQsSjBrqV4KQoJ+GZh33V2clm40YsQD3PJ9ENpo074APVbvMSwdvbm1lkc4q/vrmK5n7JmoFXP1S/NM6KpqGwbd+O6wSbdCOKhm1Pj6pRfjCTwQ0v/gHIvwApCVKlpskjIadPJXVjYtYsAGXIR+te37rR4mXtDPpS0UzkvA8IlenTqT2e5nHpOz2su0SJz6BXmBPrpdUPnE7ndSH/KfqlfzyWioC4OvlCzLvwiZ2dj5/L1gFGiOx68Or8TLAmesk7PAcmgaW3RnbmvqJ172qd4F1R/TBYXWmj4DgledKlgFctx/COHY70qYQlLppOpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3612.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:13c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Mon, 13 Feb
 2023 15:28:03 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6086.023; Mon, 13 Feb 2023
 15:28:03 +0000
Message-ID: <3dbb9c71-f5bf-56e4-6f9c-66e6d42f9049@siemens.com>
Date: Mon, 13 Feb 2023 16:28:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [isar-cip-core][PATCH v4 2/8] refactor: use imagetypes for swu
 generation
Content-Language: en-US
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: adriaan.schmidt@siemens.com, quirin.gylstorff@siemens.com
References: <20230212082758.1166262-1-felix.moessbauer@siemens.com>
 <20230212082758.1166262-3-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230212082758.1166262-3-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0012.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3612:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ced973c-2c0b-4dd0-e99b-08db0dd6e5ae
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	pRS5Vl0MABqIDWpsddr2tWTEU7/DZZya9akv995PgPe3B8J8FVGA4Am2ehY972IaELTye/T0aDsljOmlYZiLbuH1FQPT2IJfX4XmJ6fYLatb7/SDExRIZn7LIYY2/sX35BbpKBHM85dRcS24pr7r5gaufjbB+qF2Uyv+zEHVROWd3uDTdd5QTZu24ecLPJLMnzLqJD5rtBXNoQMFuucbAEBCTpAEonOaPeQaY553ctMl4Xmd2jWajDV2ZLjqpXspsJuuIFFWlHlKX77oK49nO5nV/t8yVw9yLtcDrcI5K+gSDq8n33tIOSJTofeFSuLsor7GI2q8KAQ0Fbh4XsV5vPXKp3pfTdclJ/wKzdgQ9NUDmNHqsDi1Gj9drU220k3Trx6U+YwbmL86mHS+8eTpbL0AT2hUbQE3vbnSwTRaIG2hXZRZHYdys5IghjQqMYovq8roFoNsJpfwDhLJOmMArJTcYfKZ2xWlLPFDAb+zLXFggVbnAn1vHStc5dXNbB6LneplAl5sheRSHFrZTXYC5ViQNUT7kk0+wLQDIjApdstxfoCdT1KM2hC9cApqzRgvRqWttGu0mrCSs0YlzmLClv7hBGNklyjk4Fy1jS4EgnNZmc1S1g/zUXGCp6T5nQOcYuOArArYrVUq1udTej9SyKJzP+UUXFk4IiMlLGHzNIiiAe/IoRhH992pdoguU2YgcqGfD+bakTcj8RoAIQ+kDPVwxhS0OcWLqBt2pnBbdQgpBezMjwS+YtjXPUSiM2+kWNMkI8san/j8ArIA10tKKQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(376002)(396003)(136003)(346002)(39860400002)(451199018)(38100700002)(83380400001)(82960400001)(2906002)(31696002)(86362001)(36756003)(5660300002)(44832011)(41300700001)(8936002)(4326008)(6512007)(186003)(26005)(8676002)(107886003)(6506007)(2616005)(316002)(66476007)(53546011)(478600001)(6486002)(66946007)(66556008)(31686004)(403724002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YTAwMWJ0Nmk2VEtnYUZsTEVGYjBTUHJzWkxON3M2blBvT2xFUVk2WFNGdEJu?=
 =?utf-8?B?UzBsSERIWXUxTGlMblFiWGM4ME5CeXBHbDhFdEU4LzNvNGxSVkVtK25lUjI0?=
 =?utf-8?B?UDZzTW94MDdGYXBwSUwrWjZEVEJxTE9iMzZZYi8rKzNkSExDNVNXczJ3dEdr?=
 =?utf-8?B?eUptTm9kWlhwTC9UZEt2NVFLM3IzaUVPYitXNWxMb3JHNEpiM2FIMXVjQm5V?=
 =?utf-8?B?Y2EyYmRheG5Jd0FKU2pLdE1rOUpGVkZsQ0s4bFBqWC9GNlJLZzZUYWxPNXh5?=
 =?utf-8?B?ZWM4RnU4c1NTbFBsRHBMaENnMHA0SWQ0eWk0ZVZUNllUakxweWM3dCsrMUFS?=
 =?utf-8?B?U3Y2eUJiR3ltQWpGbWJBUDArMFRqL1NSQzJjRHJWY2FPdkIvSEZ1bzVxMXg5?=
 =?utf-8?B?dmNIbWhWYkNqYzV3L1ZvS3hFdTJyUjBaME8yT1hkcDlwQlV1R3pMcUpxaGRB?=
 =?utf-8?B?Y3FBaHc2WmJIVnYvcW9SM2hpVEdGTTltN1I5ZlBOa3lodHZpVUpKQ3V3OVhH?=
 =?utf-8?B?eGxFRzEycWxjeFlYT3U3VDEySy9RSkxtc0hGRzZDVjcrSzNFQVQ3Y2VJd2hE?=
 =?utf-8?B?SkMvWXFzbTNIN0NLT3FCeU5CaVdDTWtoWmdUUnRTVk1iQVJIbHgyeUtRUSs3?=
 =?utf-8?B?VWZuWjlqOEMyOXRwSnBMTzZUVEFod3V2Qkt0enpoVGFvZWcrMzZMVmN2cnRS?=
 =?utf-8?B?T3FWbmU0dncvUDE5RjAzWmVOWFBsekNncWo1OGFmQ2QwRHRWVmY3dzVMd1l3?=
 =?utf-8?B?YlVmYTY4bE1ncnhhck5qZjBoU09rM3ZDN1RNMGZ1OEpST0I3L3FBVjYwdE9J?=
 =?utf-8?B?a0cwbndWakpvQnArOEl5Wkd0M2YwZC9YS3NWOEQyRHdwZ2FsVU43S2QreWxI?=
 =?utf-8?B?TklvSjZ0WDlBM3k1Ym5TSi9Bb216R1VOVmdZdnZXRkhROUw1c3ZTeTU2OC80?=
 =?utf-8?B?SWVZMkR3QitkdE1WaGhNbFoxRmthTXl5TVBxbitBeDBISFVQMUhOdWM3bTla?=
 =?utf-8?B?VXhzRkNVYmNDd3o1RnJUWnFIWmQwaE9lTmZ6aDRwamdIYUd5bng5ZkdWWVA5?=
 =?utf-8?B?N0JaVWZHRUU0Q0lSUmVBakJ1Z0hPSEtRS0hqK0xJQTJacDB1WlF1TEpCdHNx?=
 =?utf-8?B?RHpudEdWZEFFNXhzWURKdHlqTEN5b0RXUHM1c1Znci85ZHNvQ28yMERqM0s0?=
 =?utf-8?B?MGtMU1h4NW9jcjd3RmU0NDBPUGFxYU9LN1l5L2h3L1M1N2VjckZyei9rSXB6?=
 =?utf-8?B?KzBlbG1GeTZ5YVcrOVJmR0t1cERjU0U2WjR0UkdhdGV5R2JySFRKckRhZWhz?=
 =?utf-8?B?Z2FjZDNjTEw0YndsOGFZUFJDME4xeE1IN1V2RHhkbzNDb0RibVJFVG9xTEJj?=
 =?utf-8?B?OHpxTkJ1b1RKWFRDSUtra2xrQkcvZjV3d09QL0cwbndXa0FOT2kycThVMUg0?=
 =?utf-8?B?aVZxUzVHbkViRW1hVWdKeGUzWko0ZlBPQ2FJMHNvMEZCYmdTVy9oNE0xY1gr?=
 =?utf-8?B?a3BITmRtWG40UjV2L2tkbldUbStYRm83VGZ1V2RxV0Zvc3MxUVZZczhCV1pP?=
 =?utf-8?B?YkM1azBjV25jMVl1cFRBOGlFOHBvQ1pSNzlxQ2draEkxRjdmbVdWcFk1Z3lF?=
 =?utf-8?B?SVZPV01QcnlqU1p4dWFrc1ZFODlDWXd4WlZNOHQrRnFvZzZwNXU5am43Yncv?=
 =?utf-8?B?aWpodmUyaVZWckhqVkE0Nkkyd0thYi9ubkZDRUtvN3k0eExTZFo5SklRWWVL?=
 =?utf-8?B?U2dCaHV5RVZHREJ3dWtqcll4Nk94L2pDb0dNZXduREtKZWNxd0VlR1lkeXZR?=
 =?utf-8?B?RkRrYW5SNTdqdEcyM3pxREZabEsvQXBlWTBBVFBSeHhKa243T3hCWHhjM2FI?=
 =?utf-8?B?bERWbG1VbU5iaVFPYnY3dnNsdXF2Tnp1M2pzaUQ3L2diRUR6OGVpSUxoc3JE?=
 =?utf-8?B?bUY0WWZ4MkYzTXlLaG1oNmxJNHlZcUxFeWtlbEY1dmFGQTMzbjVZbEQzQ2Fr?=
 =?utf-8?B?R3lTNGFNZmV6RFI0Ymx1RXdlYTNIL0NzcjVMZW9aMTBwZU9BQS9FdVd0Unlh?=
 =?utf-8?B?bDFINVJ5cUNGSFVzK0E3YlRqY0p0ZGJENzVvUEJmdTZOQnIzZmU3Mmg0d0oz?=
 =?utf-8?B?TEM3TUlKdVE4RFpacnplV083RWthUlNNNGFpd2svUWg4TnAvb2Jia2xhVHFT?=
 =?utf-8?B?WUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ced973c-2c0b-4dd0-e99b-08db0dd6e5ae
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 15:28:03.1914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: saJifZRBjJ804zxhyRu3ZMb2C/2BXhSrdifREffJ7OhC273JNdeMYVGaGOnXJCYzSI77sJE+ESg3H1eoQef9Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3612
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Feb 2023 15:28:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10684

On 12.02.23 09:27, Felix Moessbauer wrote:
> This patch reworks the implementation of the swupdate type.
> All generic aspects are moved from the swupdate.inc file into the
> swupdate class and made conditional on the swu type.
> The sw-description file is now referenced using the image-type
> infrastructure, which avoids manual additions to FILESEXTRAPATHS and
> accidental overwrites of SRC_URI. The templating logic is moved into the
> generic one provided by imagetypes.
> 
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
>  classes/swupdate.bbclass                      | 26 ++++++++++++-------
>  kas/opt/swupdate.yml                          |  5 +---
>  .../images/{files => swu}/sw-description.tmpl |  0
>  recipes-core/images/swupdate.inc              | 15 -----------
>  4 files changed, 18 insertions(+), 28 deletions(-)
>  rename recipes-core/images/{files => swu}/sw-description.tmpl (100%)
> 
> diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
> index 5eb4936..966f7c0 100644
> --- a/classes/swupdate.bbclass
> +++ b/classes/swupdate.bbclass
> @@ -8,23 +8,33 @@
>  #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
>  #
>  # SPDX-License-Identifier: MIT
> +ROOTFS_PARTITION_NAME ?= "${IMAGE_FULLNAME}.wic.p4.gz"
>  
>  SWU_IMAGE_FILE ?= "${DEPLOY_DIR_IMAGE}/${PN}-${DISTRO}-${MACHINE}.swu"
>  SWU_DESCRIPTION_FILE ?= "sw-description"
> -SWU_ADDITIONAL_FILES ?= ""
> +SWU_ADDITIONAL_FILES ?= "linux.efi ${ROOTFS_PARTITION_NAME}"
>  SWU_SIGNED ?= ""
>  SWU_SIGNATURE_EXT ?= "sig"
>  SWU_SIGNATURE_TYPE ?= "rsa"
>  
>  BUILDCHROOT_IMAGE_FILE ?= "${PP_DEPLOY}/${@os.path.basename(d.getVar('SWU_IMAGE_FILE'))}"
>  
> -IMAGER_INSTALL += "cpio"
> -IMAGER_INSTALL += "${@'openssl' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
> +IMAGE_TYPEDEP:wic += "squashfs"
> +IMAGE_TYPEDEP:swu = "wic"
> +IMAGER_INSTALL:swu += "cpio ${@'openssl' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
>  
> -do_swupdate_binary[stamp-extra-info] = "${DISTRO}-${MACHINE}"
> -do_swupdate_binary[cleandirs] += "${WORKDIR}/swu"
> -do_swupdate_binary[network] = "${TASK_USE_SUDO}"
> -do_swupdate_binary() {
> +IMAGE_SRC_URI:swu = "file://${SWU_DESCRIPTION_FILE}.tmpl"
> +IMAGE_TEMPLATE_FILES:swu = "${SWU_DESCRIPTION_FILE}.tmpl"
> +IMAGE_TEMPLATE_VARS:swu = "ROOTFS_PARTITION_NAME TARGET_IMAGE_UUID ABROOTFS_PART_UUID_A ABROOTFS_PART_UUID_B"
> +
> +# This imagetype is neither machine nor distro specific. Hence, we cannot
> +# use paths in FILESOVERRIDES. Manual modifications of this variable are
> +# discouradged and hard to implement. Instead, we register this path explicitly
> +FILESEXTRAPATHS:prepend = "${LAYERDIR_cip-core}/recipes-core/images/swu:"

This means downstream layers wanting to overload the sw-description.tmpl
now need to register their own FILESEXTRAPATHS? That at least requires
documentation. Or can we also drop LAYERDIR_cip-core here, and it would
still work?

> +
> +do_image_swu[stamp-extra-info] = "${DISTRO}-${MACHINE}"
> +do_image_swu[cleandirs] += "${WORKDIR}/swu"
> +IMAGE_CMD:swu() {
>      rm -f '${SWU_IMAGE_FILE}'
>      cp '${WORKDIR}/${SWU_DESCRIPTION_FILE}' '${WORKDIR}/swu/${SWU_DESCRIPTION_FILE}'
>  
> @@ -91,5 +101,3 @@ do_swupdate_binary() {
>             fi
>          done | cpio -ovL -H crc > "${BUILDCHROOT_IMAGE_FILE}"'
>  }
> -
> -addtask swupdate_binary before do_build after do_deploy do_copy_boot_files do_install_imager_deps do_transform_template
> diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
> index ae5e3a1..80cd86e 100644
> --- a/kas/opt/swupdate.yml
> +++ b/kas/opt/swupdate.yml
> @@ -19,11 +19,8 @@ local_conf_header:
>      CIP_IMAGE_OPTIONS:append = " swupdate.inc"
>  
>    wic-swu: |
> -    IMAGE_CLASSES += "squashfs"
> -    IMAGE_TYPEDEP:wic += "squashfs"
> -    IMAGE_FSTYPES = "wic"
> +    IMAGE_FSTYPES += "swu"
>      WKS_FILE ?= "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks.in"
>      INITRAMFS_INSTALL:append = " initramfs-squashfs-hook"
> -    WIC_DEPLOY_PARTITIONS = "1"

Why can we already drop this at this point?

>      ABROOTFS_PART_UUID_A ?= "fedcba98-7654-3210-cafe-5e0710000001"
>      ABROOTFS_PART_UUID_B ?= "fedcba98-7654-3210-cafe-5e0710000002"
> diff --git a/recipes-core/images/files/sw-description.tmpl b/recipes-core/images/swu/sw-description.tmpl
> similarity index 100%
> rename from recipes-core/images/files/sw-description.tmpl
> rename to recipes-core/images/swu/sw-description.tmpl
> diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
> index ee893dd..f4f5c42 100644
> --- a/recipes-core/images/swupdate.inc
> +++ b/recipes-core/images/swupdate.inc
> @@ -10,26 +10,11 @@
>  #
>  
>  inherit image_uuid
> -inherit swupdate
>  inherit read-only-rootfs
>  
>  IMAGE_INSTALL += " swupdate"
>  IMAGE_INSTALL += " swupdate-handler-roundrobin"
>  
> -ROOTFS_PARTITION_NAME = "${IMAGE_FULLNAME}.wic.p4.gz"
> -
> -FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
> -
> -SRC_URI += "file://sw-description.tmpl"
> -TEMPLATE_FILES += "sw-description.tmpl"
> -
> -do_transform_template[vardeps] += "TARGET_IMAGE_UUID"
> -addtask do_transform_template before do_swupdate_binary after do_generate_image_uuid
> -
> -TEMPLATE_VARS += "ROOTFS_PARTITION_NAME TARGET_IMAGE_UUID ABROOTFS_PART_UUID_A ABROOTFS_PART_UUID_B"
> -
> -SWU_ADDITIONAL_FILES += "linux.efi ${ROOTFS_PARTITION_NAME}"
> -
>  python() {
>      for u in ['A', 'B']:
>          if not d.getVar('ABROOTFS_PART_UUID_' + u):

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


