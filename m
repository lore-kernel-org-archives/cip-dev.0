Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.65])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13951.1793285990666315158
 for <cip-dev@lists.cip-project.org>;
 Thu, 29 Oct 2026 07:59:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=fxcP7t+T;
 spf=pass (domain: siemens.com, ip: 52.101.72.65, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SKzAFgg6B57qeIRs+4KWfrSkahESTef7A5ARmfTMgA+a2f2e1Us7hsosR9OQv+BjV+RhV5Ue5WuZP/UyZw3LZITcSGzcPqnqQE5kPB6XHc5WlfJWDfyLjVzQ8wsp9wMoU8Ox2hwc3ht/5gaR/Z08GRuWu/+Irfz0s3lXhDzpjW6vM4AyIB7KG/xoppd++2P7KCUUjp5ytYeUUCEL7RLZiJ0x5KHFeXgWQQ95SRoXNMXmOWrDUOFezpZdFpMqSbvJIFW5Xp1Uso4Ib8QUzdMAGqK0Zi+Ad+4CimJOSgpbnzTpbM8rmSI94dEgAJ5108qPLk3jIvnn6j2vh2lzDpLgcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yBx06OUOcoUm8zRN9NadaRNtANR1GTqtdaQSxMPgzHI=;
 b=Ky/LhBIA2rqNZ2MpNdU0ZKXuNQF3/E9CQawmxc9j/yGs6Ar4XF82cVGMKgv6XyzRLezQ9LjVT+Van9fXYhjy/J/s8yH0/YjeZ6PK/KeL18bsAGqtg/gTnVzHC12M4hYpRsLBsBTgsHv9sqqnFZiJxR4c1v+WC9L05B/1QYndyksvOxV2oaysLdIgejVddSE9o9/Y7o8pdWW+d2BVv8gF1R3E2lxwjWKHRxFXiuw0mOjz1eKJt3Ld719Wt6AL+JQ45mV+W8/N98UEjOGd0UcdqSJGIoquOn/POj/3ijucDeBDE10621nCUl/T0t+CBtIloLKw7SawulcdM7YoZQXyzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yBx06OUOcoUm8zRN9NadaRNtANR1GTqtdaQSxMPgzHI=;
 b=fxcP7t+TxCFtnB89e5KGs4c4SLgiKNYXqrDR/fptzm4t4/LZtj8Z1riDVbCaKgrqUO+Xdkz3uaFguAhhMoZliZMhdOMnANbwOl80Qw8q+q5j6a3HT/BaEFZu+ATOGFlYt6jFRNVh7SVmGmM/Hpxa/3Ip4M/B45mK3r6yibTZAwQ34wZSitWR0B9512mBydF7/EHjD5dWVMqnMUYW1pT+gy8boPeSpVOpFreTMDP8N6UiLteLBnLPpfPiKsPpjKd/2auJWrVOQLdGtIQh0TJZBguHeIvSIph+tBuyUSPndW18bZuo2zXQq6mmmoPPw/w9Pkgq6bcMb0MBP8fj/3Cq8g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by DB9PR10MB5786.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:37d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 14:59:46 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 14:59:46 +0000
Message-ID: <13222d26-e9e3-4d18-b542-97f5b04e85db@siemens.com>
Date: Thu, 29 Oct 2026 15:59:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2] customiziations: use Isar
 hostname-costomization for HOSTNAME
To: cip-dev@lists.cip-project.org
References: <20261029143637.404080-1-quirin.gylstorff@siemens.com>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
In-Reply-To: <20261029143637.404080-1-quirin.gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0347.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::15) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
Return-Path: quirin.gylstorff@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|DB9PR10MB5786:EE_
X-MS-Office365-Filtering-Correlation-Id: e04e9c36-65d1-4b51-193c-08df35cd4573
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|4022899009|366016|261028144727099003|11063799006|56012099006|261009223027099003|261026121527099003|261026140227099003|261022075727099003|261022115727099003|261021121427099003|261021123027099003|261022105027099003|10067099003|55112099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: NzWHegRcW9rMhwf90pOhi/uvVjlfxQATZFLkH2CTkg9+lob8Ie42bZj60m7O2B4O2pChoOIHhjXs09MeIiPx4OKlNZDvgydDuU8GRmtUHVD9M4kLl3sHltTaxVxfYk90GADSzBJw9u7bp4DLWkyhwrf4PpO7DCTQM/ZMA8WwecqSn8bbZxDXFiglbhmdFw2LHWSrOF+Vi1dg75Urlfa1zfe0NXd2TI8d1lc+6vbUk0XsdioPw2IU6upEhRqgoNzLKuGxKjhdWL4896J7jY1Bd4lWxJ4/s5KclhMJ9Qdnb7b/NYJL3erc/1ZOplSFKz1OkFZq/t0J2AqHlEptX/g1f46W5glwXZmSpclhBmqWoqH+GchxJhY57qdrIVM6ecmgor58qwUFIokCedJE4iRsdH7gq5VL1VzCHKunZ/c3Ad33bzMRnR6lH7qxW73lOTN212ywJb+FQmJrJ7XqX8xNTUEpjaJ/TkppNVQjmml4VOG/QlMQEcXWRlpeBUozPgME5KqTRrq3aCBS6Zue91I47unjhQsPtClX28uar6KBpc2BHsFkC0ITaDrTpudyAQloB58z8i4FgTy78x/neiePYOrsFyUzN0SB6XQ7UlK9FfI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(4022899009)(366016)(261028144727099003)(11063799006)(56012099006)(261009223027099003)(261026121527099003)(261026140227099003)(261022075727099003)(261022115727099003)(261021121427099003)(261021123027099003)(261022105027099003)(10067099003)(55112099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUEzU2l3OG1YV0o5c21TRHNnUks4U2JnK1lkS0RDVXdnb3ZvNHJWUDR3WFNy?=
 =?utf-8?B?L3l6RXRPeUFNeGVENU5vdHhzeENnMnkrdUlzOWZKKzA1TmowWXZXTFJuVG01?=
 =?utf-8?B?WXMyTWdQSnpkTFVVRlIwQkRqb2pONWJxaFpZNGEzaEdpcng2aXd0NkgyVi9C?=
 =?utf-8?B?THQrTUNNbHpDYzI0a0k0ZW9FMSt3b3BkV3g0OEsyYkltUUJaTTRha2crbmM5?=
 =?utf-8?B?TVdXSVVEYjBsVWpmWDZBRWlkQjJFNExyT25oc01Ec2k1RTVEcWRiRE9IWUcw?=
 =?utf-8?B?YmU2NitKa24vWEdLR2xUbVZxaml6S3BMemxaY2dzei9rZG0veUY1QzlleWxx?=
 =?utf-8?B?WjR0SFVPNU82czlEVVFVbGJ6WWQ1d3ZwZTBIUEg2aGZFcjV3NVFINUczZWRZ?=
 =?utf-8?B?bFRWeG0xNXZkcjMrSDhRYjRRSm1VU0FZRERpeW9KK2l5OWZhMGs2c1I5SlZD?=
 =?utf-8?B?VlE5Rmpnano0T0tWa3hoQ2M0a3MxNTFKMzdVTkIwanI1bnNSZkR1cEZ3QlZi?=
 =?utf-8?B?Y2ZWRDBua3YyWWxCK0VBZUtLSDZiNHVSQmF0MWg5R0R5azhkNGJzeENrWFRD?=
 =?utf-8?B?b242OVAxYTFEdUpQZDRMK2dPRTY0QU5BK096L0x0RFlCVFkwNmx1KzEwVjBG?=
 =?utf-8?B?eE9vRkx2REVkb3k3VTFDYVJPdVJFRDNSRkhzbzhBMmIybm90MW4vQjZoOXZ6?=
 =?utf-8?B?d3NEMG15ZVdhNzlTQmlwdVp1Zjgwc0p5S014NzVCNjE1enBldGZ2c1BSa0pM?=
 =?utf-8?B?ZlA3aStGWDNic1JsZytSVnpLOUN1VXBpTHIxMkpWTEl2bVJFSUx3SndMeVBQ?=
 =?utf-8?B?djVjVjdPUXA3YXRubHJZbWladGY0TkUvWVFSUm4rUVlidkc1elZIaUNUY2V0?=
 =?utf-8?B?dmM5RkZNOUdsOU1hcWVwVGJYSDVtb3VzT3Y4bFZKU1YzSW41RDkrY1JWb2VE?=
 =?utf-8?B?U2FJaHlud2lqeThKTWF0YktxZ0JqZjFYZ0tEdzZlMHBoWkFzUWtEcnRrTjF0?=
 =?utf-8?B?WVAxaFl1b21kdHR0d1NWOWZVcDNwSHhlN0tJdTUwckIzOVNyeUNHUTA1VHJE?=
 =?utf-8?B?MkZpa3F4eHAxcFlUUXRZTEZLMTMrNFhMd2EyVnZHWTlaNW1UWEwwU3Z5dzYy?=
 =?utf-8?B?V0JEZmVHQUNFK3FXMjFESWJYQ2d3WlJ1V3JlL0pyT1RVZ0RGSVFONEZINTM3?=
 =?utf-8?B?RzVpWXo5VFNOM054MW5oaGxoRUhFNFVIL0krVDVudE9jend4dEtYNGZFV1dT?=
 =?utf-8?B?RHdRY1JhYjVYSGw1aTM2WWFQYjErZ0cxWFl5YzJUQUhDd0VqUUV2M3ZSb1Rz?=
 =?utf-8?B?OHd6dGRVcHppbng4VlBYZFpMbkoyajNGbHRQNDJpcjFuT2lFS3Y1dDVqQzNO?=
 =?utf-8?B?MHRZM05lMjJTTXMwM295ZnpoL29rb2IvN1VhaWYwL1VSS1JLVEc4SllhUkdv?=
 =?utf-8?B?b280Y1Y1NEdHVTZ1R0tqcmFNalp4aXZSb1lDS2ZwbkNQV2RZemFnT1p5VlM3?=
 =?utf-8?B?eUFja0t0QjRoZjgyK3pCSnJDOVFkbUN2VHBMZWtTK3hLdm9pWmtsYU5RY0lx?=
 =?utf-8?B?MFpMV0l5cUR4M1M2c29OQVVRK1JWMTg5U3k3ajA2L082dEFzMHMzUmIxcWVS?=
 =?utf-8?B?aTdaeHJ4UTFCTHpRUlViUUFrRzhGZk9ISEtFU1ZKQ0RBV01NTWE4d0xTRmp0?=
 =?utf-8?B?dnZ1bitBRXNYWDV5UThENmtGZHp6RGVQZlhVOE0yUHdzRWZqMXpmeGlteHJ3?=
 =?utf-8?B?L3A2Vkppb2ZkUVI5U3BxM1JtbFloMjZlaitwaDN1RVhYczMza2VaTXpTczE4?=
 =?utf-8?B?UE4vSWQrU01MMkgvM2ZNSUpPdlgvdnNWUGxWMTVqYUhIWWwvNjYwQWUwdzBI?=
 =?utf-8?B?dzB1TzdBU01EYnoxT05CQ3BoRzNqQzVhS1M1QldCRkFUK2R0M1BuaFl0dHRz?=
 =?utf-8?B?SjlLT2FEYk96L0x1bGdJbjRZb3pWQXZ6R0FLcjJrekpaa2RZaUZ2a1hyTG5Z?=
 =?utf-8?B?S3M4UHZ4azlaTElveXNHeklRbE9tU1gwanNKUTl6THVWaDZZY3hqYUtKRk53?=
 =?utf-8?B?Y0E1M0JvcGJQSHQzUlN4STVxUWdrQVgxejlPRU56Y2JiRzlpa1FIb1RReUNj?=
 =?utf-8?B?dFcyVTJvMHdxSmRKOXpPZVdJZ1NLeklLZkJ4YzJSTzdaWjNwejgzYUxrc042?=
 =?utf-8?B?bmZTSTVIVUpXMjlaTE9qeHhxTmI1SlFua1dDVzFvWTJNVEhkRytZMDVSLzRP?=
 =?utf-8?B?bkJpSHJxa2lYeTcyc1FsRlBZZlpmenNZNFNzcyszZXlJK1poSFNGM3IxbkRj?=
 =?utf-8?B?NEl6V1NwdVM3NGptaU1rNENvNEZkek5SSmxMQlhJUE5ndzNWVUZQTEJnWHdp?=
 =?utf-8?Q?8FbePsiTLihSnnis=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e04e9c36-65d1-4b51-193c-08df35cd4573
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 14:59:46.0633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 76s8YOrQwP3d3unHZ4cbB9zk8DzIXQjLWwOuvVtq5mX3/o5jfhnSJfdnNjfKa9gcK4VmPDMVNY1RsjROUpQ++DCqmE9C+wXsklObdzYmvp0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5786
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 29 Oct 2026 14:59:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24575



On 10/29/26 3:36 PM, Quirin Gylstorff via lists.cip-project.org wrote:
> This removes the postinst template of the cip-core customizations
> and also allows to reuse the `recipe-core/customization/common.inc`.
> 
> Also add `#DEBHELPER#` to postinst to add the by debhelper generated
> code.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> Changes since v1:
>   - Use CUSTOMIZATIONS in image instead of Dependency in common.inc
>   - fix missing space in IMAGE_INSTALL:append:factory-reset

After play around with CUSTOMIZATIONS I would not apply that patch. In 
my opinion this feature should be removed from ISAR and replaced with 
debian packages or IMAGE_FEATURES and the HOSTNAME should be set in 
IMAGE_POSTPROCESSING.

Quirin>
>   recipes-core/customizations/common.inc                       | 4 ----
>   recipes-core/customizations/customizations.bb                | 1 +
>   .../customizations/files/{postinst.tmpl => postinst}         | 4 +---
>   recipes-core/images/cip-core-image.inc                       | 5 ++++-
>   4 files changed, 6 insertions(+), 8 deletions(-)
>   rename recipes-core/customizations/files/{postinst.tmpl => postinst} (70%)
> 
> diff --git a/recipes-core/customizations/common.inc b/recipes-core/customizations/common.inc
> index 0fd3d4f8..60bc5245 100644
> --- a/recipes-core/customizations/common.inc
> +++ b/recipes-core/customizations/common.inc
> @@ -16,17 +16,13 @@ MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>   FILESPATH:append := ":${FILE_DIRNAME}/files"
>   
>   SRC_URI = " \
> -    file://postinst.tmpl \
>       file://ethernet \
>       file://99-silent-printk.conf \
>       file://99-watchdog.conf"
>   
> -CUSTOM_HOSTNAME ??= "demo"
>   WIRELESS_FIRMWARE_PACKAGE ?= ""
>   INSTALL_WIRELESS_TOOLS ??= "0"
>   
> -TEMPLATE_FILES += "postinst.tmpl"
> -TEMPLATE_VARS += "CUSTOM_HOSTNAME"
>   
>   DEPENDS += "sshd-regen-keys change-root-homedir"
>   
> diff --git a/recipes-core/customizations/customizations.bb b/recipes-core/customizations/customizations.bb
> index bf6e7175..3f931b8c 100644
> --- a/recipes-core/customizations/customizations.bb
> +++ b/recipes-core/customizations/customizations.bb
> @@ -13,6 +13,7 @@ require common.inc
>   
>   SRC_URI += "file://ssh-permit-root.conf"
>   SRC_URI:remove:security = "file://ssh-permit-root.conf"
> +SRC_URI += "file://postinst"
>   
>   DEBIAN_DEPENDS:append:secureboot = ", efitools"
>   
> diff --git a/recipes-core/customizations/files/postinst.tmpl b/recipes-core/customizations/files/postinst
> similarity index 70%
> rename from recipes-core/customizations/files/postinst.tmpl
> rename to recipes-core/customizations/files/postinst
> index 62e9a1a2..c65e2d36 100644
> --- a/recipes-core/customizations/files/postinst.tmpl
> +++ b/recipes-core/customizations/files/postinst
> @@ -14,6 +14,4 @@ set -e
>   
>   echo "CIP Core Demo & Test Image (login: root/root)" > /etc/issue
>   
> -HOSTNAME="${CUSTOM_HOSTNAME}"
> -echo "$HOSTNAME" > /etc/hostname
> -echo "127.0.0.1 $HOSTNAME" >> /etc/hosts
> +#DEBHELPER#
> diff --git a/recipes-core/images/cip-core-image.inc b/recipes-core/images/cip-core-image.inc
> index f6162cd7..ba942a0b 100644
> --- a/recipes-core/images/cip-core-image.inc
> +++ b/recipes-core/images/cip-core-image.inc
> @@ -11,6 +11,9 @@
>   
>   inherit image
>   
> -IMAGE_INSTALL:append:factory-reset = "factory-reset-helper"
> +IMAGE_INSTALL:append:factory-reset = " factory-reset-helper"
>   
>   ISAR_RELEASE_CMD = "git -C ${LAYERDIR_cip-core} describe --tags --dirty --always --match 'v[0-9].[0-9]*'"
> +
> +CUSTOMIZATIONS += "hostname"
> +HOSTNAME ??= "demo"
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#24574): https://lists.cip-project.org/g/cip-dev/message/24574
> Mute This Topic: https://lists.cip-project.org/mt/121994979/1753640
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/unsub [quirin.gylstorff@siemens.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 

