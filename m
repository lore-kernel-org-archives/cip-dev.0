Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.68])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11808.1793280068219113772
 for <cip-dev@lists.cip-project.org>;
 Thu, 29 Oct 2026 06:21:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=EjyRMRAD;
 spf=pass (domain: siemens.com, ip: 52.101.70.68, mailfrom: alexander.heinisch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EeLLS8Pa9aGY6m7NS/E6eoPc8oQWZMaRHoRacMwK7zDCyKhvypO5Xk948PN1vtAoRSlJjTyPFV+NoOZXgCLvCO0dmGE1sdAlloiXf+iqvSS0gMK2PdNEzgls185s6pWBP7aPSjsx9BeK1Y7R1yzUyQsEv4L2s4Mr+WFMV0u0Qb5gKcDV/2L9Pqxs9X8d+FDdGp9++dAHSIHfNzKa0bFj74YAi6ftFyjLNusWrXwDG9ypzAebaE9qBWlIo6XMD+n2uU8d7fsxeZ12PblsmNaOjpGiY4vzYKNB0r8/iI72awJ5aNJBbOz6WHLeRkb8Y2BkdRnPey+NhxYwZPAkRBjoXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qcCyrP4yY7LIDuUn/lStjP8Hcu9n6prxChAcaqEpxlE=;
 b=J+pG1HS28MIuwwcxK16AmJYuIq2oamhCCDcdIGUt0Md7FIm1ahjZSeemkxhwUiCSC8dlJsj4G4akiU41kRtyx/Wmo9fgJdT3e5aHivBa22muk9Fty6lorKA0+vSXhAPwcQ93KRT+dZ5eyXJpcSzOfYmOV42gATg5FNkb7TkituYSO5mrF6dk/bva+IDNwYzOdpO3ZZ012TKEQGM0SDDGtt+ASGqTe4mexJSfz48VBDtbXF1sDqrCn6ekFcf5mhX3iWzBxkId+OIT0creWIm6liNBxaGfw3BmtgT3TLHoX3liVESD+OhQ3AJCdMW78NFC75qXjl9y7+e3YOhtggHnFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qcCyrP4yY7LIDuUn/lStjP8Hcu9n6prxChAcaqEpxlE=;
 b=EjyRMRAD3HSXlQAODpLsiZGSLoPuZbX5Vwg/pQvRLoe9nCDtcO22nwnG6+9++ivq9WYhFfIacADAJ/ME+SldGtvv1T8SS8rLaUpO+H2soCYzrRY2Rt4M0K87aEGRSqtvla6a/zm/i56Dm5D0C3fhL6bdn3bshFKKE0TrNNWtqEh4bRAkT6e03PWvhP97mDu4NlmBtIr12ZfQMOCz/1KkqN3XLdyVgzgGFXS7cZ4ZCOz5h8MU0lP0WYN81+rUUCzpkYDqMjnpA10eZHECXF3lAQFlxfgmlMKegydegjkrr5g4xrlcZa52oy4z8wh3aWsSEa85UR7ewSR6qYaBIROCjA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ed::14)
 by PR3PR10MB4125.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 13:21:03 +0000
Received: from DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2339:186:874d:c405]) by DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2339:186:874d:c405%6]) with mapi id 15.21.0569.008; Thu, 29 Oct 2026
 13:21:03 +0000
Message-ID: <0ed181fc-d81d-4fd0-ab00-94d96bd80f9c@siemens.com>
Date: Thu, 29 Oct 2026 14:21:01 +0100
User-Agent: Mozilla Thunderbird
From: "Heinisch, Alexander (FT RPD CED SES-AT)"
 <alexander.heinisch@siemens.com>
Subject: Re: [cip-dev][isar-cip-core][PATCH] customiziations: use Isar
 hostname-costomization for HOSTNAME
To: cip-dev@lists.cip-project.org,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
References: <20261029111638.101749-1-quirin.gylstorff@siemens.com>
Cc: Lukas Rabener <lukas.rabener@innomotics.com>
In-Reply-To: <20261029111638.101749-1-quirin.gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0081.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::7) To DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:4ed::14)
Return-Path: alexander.heinisch@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB8045:EE_|PR3PR10MB4125:EE_
X-MS-Office365-Filtering-Correlation-Id: 01088a7c-77d8-4f36-954d-08df35bf7b5a
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|4022899009|376014|261028144727099003|261026121527099003|11063799006|56012099006|261009223027099003|261026140227099003|261021121427099003|261022075727099003|261022115727099003|261021123027099003|261022105027099003|261022113327099003|10067099003|18002099003|55112099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: 7IhaGFUB8d445hEPuqfPBj0RLOrE+VxoYKu0mvTlSU10bcg+BVG4ssyT/3tEH44cEV2rL3nKZE8QoMJS6h/dBdRADC4E+Bcyw+Va8K1Hc/XtxGIWLJX7kJFZosBmsiQS7I1wV7dKvwpwpQN244ZycXmQqPglPWjhZOOm7SSxcXElA5+cF/XDwTjWeH0L0jqYRd7p++aMyLWOIgDA9dLu+BVnSckWmck9NRxwvUT4fFLtQXzVw3VhK9E7j+qjGfFh+MWOziwKBM54ETg+rrqXPg9UzAACiJyRidhHKZXCALY0BHQ76rYOWSbLQvByeZuH9equbk1Ufsn0TN1Eu78gbfQ0WZPfOdVibYilf6snwehceL4f1i8ch0mWNrvkUeqgZZatkgdLAtHXJU9Nya+ENpkxAb+kDAy1A90aigSRFlJPnDvRNtz1pIVChEjhPxQ2cxPyNQjKHQgqt9PUqrf7L/K9mY5HoNe+oRVN/otfwl9s63I7+NwzAY0eey7Q3deobs9AabPmh2Sxe5VDUkrRUd2+AbN5uoI7DxVTLODFf8Y52geAQVAO8cPgOF9r14Wb5+LnI60qIFHVCDD8bCPeJqg18FSWOPHnyXSU9ylfnDA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(4022899009)(376014)(261028144727099003)(261026121527099003)(11063799006)(56012099006)(261009223027099003)(261026140227099003)(261021121427099003)(261022075727099003)(261022115727099003)(261021123027099003)(261022105027099003)(261022113327099003)(10067099003)(18002099003)(55112099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0lEeWZOaFVvd0RrT202amZuY0F3VFl5NFZrbmREQ3QxU1huekJIYUs4SHZr?=
 =?utf-8?B?cC8zNWRtWlRzUEVYOHZnZGJxMk1zMVF5VlFkOFMrZG9WaXNYZTc1RUhISUVs?=
 =?utf-8?B?bVR6enl2N0x2akhzdXVjbW9rKzhSa3czK3pkeVVYejRRZC9BZXhFaE5TZURK?=
 =?utf-8?B?bzFwN2FSKzVKMkVySmxEYmNSdGk3bFBYQjMvck1kSUM3dG0zQkVlU0o5a0pP?=
 =?utf-8?B?aDNISFZvTVpGSDJzZ3pkNGR4L21uRHp6VGJ2dXYzQmJnOG0zSHJKdUJNbXJu?=
 =?utf-8?B?b1dtZ3VZMzNLRm5SODA1RVNpcjFzaTFmK3ZLTHhVeURIbTlhSmluOFdpbmg1?=
 =?utf-8?B?M3RySmNSdmxxRHFNcjFodkpZQ3cxV0VId2FMTjRjRVltdHFjc0xGTDM1TWlF?=
 =?utf-8?B?NU1KRElTL3F4c1Q2Q2d4WXhza3FlbTZ0N290SURJUms1NFZKYzBXMGN2c1B4?=
 =?utf-8?B?RGQ0elFKVjhJbmNUY1dyUVlic1NpWXV3SlNFUHB1c3VhQTNYMVZQT01FSnJ1?=
 =?utf-8?B?YUIvOVAvc3EybTMrZUZGM3NBSE1PWmdRem5EYzJobmxiMml1NmVzSzRMTEww?=
 =?utf-8?B?dHRaM0xLV0RGNUIwWXU1MDYwWlFQMDFyTnp4d0JEYXEvWW1hT0JxWGNGaFc4?=
 =?utf-8?B?QXl0czNybk5KYnZ0WGEvRTlLelhBdmRlSnlubWg1WTdlbG9pdGN5YW9kcTBq?=
 =?utf-8?B?NVIyUWdwTk4vazAwUGxoeVZKcnd6ZnZ5aTNweENHc3NJQUFhOGlwcnFRNWt3?=
 =?utf-8?B?TjlwS3J3N0E0eWcydEMwcFNuUnl4QVhqY3BLUEV5aG5OKy9vclhBSk8wNnRk?=
 =?utf-8?B?N3NoLytiUnNlMUxhUlVVcVNKclZMTC9jajNlY256RW9nWkJmN2thSUVVaW81?=
 =?utf-8?B?NXVLcTVKdHdwTEh3UElrV1JyTDZNai8yRzZjK3AxbmxOYzBqaUMwNXBETXJz?=
 =?utf-8?B?ZFNWbjhJQlpPR2N1NzgxbS9SZWNCQWR6UDdUN2wzb0EwZ3FWWW5yNVhwcktR?=
 =?utf-8?B?NGp3elk1eUYvWk9JNFE2aHdjbkpVREM5aUs3VjA4TStxaS9aRXNheFZlZU1J?=
 =?utf-8?B?ZGNxYlJjcTV0aTA5cHpac3Z4emxIY2U0RFpLTFhvOTdEUGEyODVvSkVZaU9y?=
 =?utf-8?B?a2FRbW1ObkFYMXlwTk5wWVl0c1VsOVFIQ0k0RVd2ZU91djluUEJhOW1qY3pQ?=
 =?utf-8?B?all3OUlkTmc5NkZYM1ByUkRDTm40YUJGUUlzRmVaOVJ5Vm9FVG1YNmo3NXVE?=
 =?utf-8?B?N3J2N1hEUWs2c3R3Ym9jb3FOY1I5UWU3V2ovVjN3ekR0NElSTm5ZeHdnZGdS?=
 =?utf-8?B?YTBscDRHbFFuS1dNQS9vN0lCYXF6SXFOOWd4aDFQU2hxWnhIL0xQUlc5SzZ2?=
 =?utf-8?B?YjQvTE9iMktPVjJpdEVQNmVaeERQaEpmMHNYMU1vV29iTVFtYWdrWDRhcWxP?=
 =?utf-8?B?a0RlZzBSRWtDU3hUdmxNa3N4SHFIdElXYU1NenFqeDh6SU5YU3p1cHdxZDJx?=
 =?utf-8?B?TU9UaUtSSGFHQityVHdXeHRjSUVDc3VxZ2pEM2VWVXIrajJBeEZpOUtXNUp3?=
 =?utf-8?B?OXFwSy82RmU2SHdydVFuM0VKaXl1WllxUEFXbWRGeURqVHZJUG02MXJvY2N5?=
 =?utf-8?B?QWN2eDVIQ3Z1a0pjemdnYzI0Wm5NNEdnTTdIV1BnaTRiOVRDckxvWmFXdkt1?=
 =?utf-8?B?d2ZoTDQ3MnNCRUNLUzlUbHpFMUhsK0phYlZYM0I5RCtybXNRRVNaNnF6VFVT?=
 =?utf-8?B?UGVDY0xIaDhGUDZ0SUFYK2NJVVp4dGQvdlBqMkZUN0Qvbm5xdzU3NXdzY200?=
 =?utf-8?B?WEZhNFBHT2gvMDBKemErdE9VZ1RYZGh1MkZ4ZEpKK0FEWE5YcVZ2d3VQdVQy?=
 =?utf-8?B?R3BtWnVURHlYa09pcmNKcHNTZnZDV09UVTE2QldoNWRBMXpzSHNQMFgyMFhr?=
 =?utf-8?B?QjYxa1U2TDBZSFhDS2Z6cDVBNEJSUUVHemZEbmxhejVJRkg4L1gwZTk3VEo0?=
 =?utf-8?B?V0ZLc3J4NzRzSk9YalMxUGl1T3RmOVRjS25iNWpQQnREbUNkaU81bElZa042?=
 =?utf-8?B?N0VJci9aZEQrSzg5QzMwU0JxZENTSE1XZXMvcno1dm5YNDNlZFRKeWljeWdM?=
 =?utf-8?B?dDRLbGw5T0N0dlFhTE15NTRMZnp4OGpvd3lydVFWSStVNUpxeGszb2p6ak84?=
 =?utf-8?B?QXRscFF5bGhwSENXUkFBZU55V0lZNUNyalYreHZaM2RqeCtxTGFoelM1czRH?=
 =?utf-8?B?OTZRLzdlQkYxTEVqTUpOSjBKaW1vUkJUWlBueXF2MDExdDBVem9lY09FRWEw?=
 =?utf-8?B?L0g2ckdkT3NxS1JLYnZFcElWcm1CU3IySGZHRTUxMVo1Q0ZNWXFPWHVzVFY4?=
 =?utf-8?Q?GOoszjbojHqA/QKM=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01088a7c-77d8-4f36-954d-08df35bf7b5a
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 13:21:03.5497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MICZ01b97QdaJELDx8APwU8yQpJTsyE4LWMQhdo4Od50Y9NwejcS/xus9P7njhyDiH67HW6MfiPufeY4aTXVjZxBMWyFgDXtfEtRQi4qhHg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4125
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 29 Oct 2026 13:21:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24570



Am 29.10.2026 um 12:16 schrieb Quirin Gylstorff via lists.cip-project.org:
> This removes the postinst template of the cip-core customizations
> and also allows to reuse the `recipe-core/customization/common.inc`.

Is CUSTOMIZATIONS now the way to go? We discussed at the ISAR Meetup in 
Prague but the decision was not clear to me. If so, we need to discuss 
how to handle more "complex" customizations e.g. sysctl settings wrt. 
scalability (nr. packages) vs composability (granularity of those packages).
> 
> Also add `#DEBHELPER#` to postinst to add the by debhelper generated
> code.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>   recipes-core/customizations/common.inc                |  8 ++------
>   recipes-core/customizations/customizations.bb         |  1 +
>   .../customizations/files/{postinst.tmpl => postinst}  |  4 +---
>   .../customizations/hostname-customization.bbappend    | 11 +++++++++++
>   4 files changed, 15 insertions(+), 9 deletions(-)
>   rename recipes-core/customizations/files/{postinst.tmpl => postinst} (70%)
>   create mode 100644 recipes-core/customizations/hostname-customization.bbappend
> 
> diff --git a/recipes-core/customizations/common.inc b/recipes-core/customizations/common.inc
> index 0fd3d4f8..888f12f5 100644
> --- a/recipes-core/customizations/common.inc
> +++ b/recipes-core/customizations/common.inc
> @@ -16,23 +16,19 @@ MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
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
> -DEPENDS += "sshd-regen-keys change-root-homedir"
> +DEPENDS += "sshd-regen-keys change-root-homedir hostname-customization"

CUSTOMIZATIONS += "hostname" adds to DEPENDS and DEBIAN_DEPENDS already 
internally in image-customizations.bbclass

>   
>   DEBIAN_DEPENDS = " \
>       ifupdown, dhcpcd-base | dhcpcd5, net-tools, iputils-ping, ssh, sshd-regen-keys, \
> -    change-root-homedir \
> +    change-root-homedir, ${DISTRO}-hostname-customization-${MACHINE} \

Same.

>       ${@(', iw, wireless-regdb, ' + d.getVar('WIRELESS_FIRMWARE_PACKAGE')) \
>   	if d.getVar('INSTALL_WIRELESS_TOOLS') == '1' else ''}"
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
> diff --git a/recipes-core/customizations/hostname-customization.bbappend b/recipes-core/customizations/hostname-customization.bbappend
> new file mode 100644
> index 00000000..2fb4dad5
> --- /dev/null
> +++ b/recipes-core/customizations/hostname-customization.bbappend
> @@ -0,0 +1,11 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2026
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +HOSTNAME ??= "demo"

The value of this bbappend is quite limited. To specify the hostname for 
a particular image build accordingly one needs to set HOSTNAME in the 
respective config (machine, distro or local_conf) or multiconfig 
anyways. Else every downstream ends up bbappending those recipes.

I'd prefer having HOSTNAME for demo purposes included via a 
kas-customization.yaml (or similar)


BR Alexander

> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
-> View/Reply Online (#24567): 
https://lists.cip-project.org/g/cip-dev/message/24567
> Mute This Topic: https://lists.cip-project.org/mt/121992122/8886423
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/unsub [alexander.heinisch@siemens.com]
> -=-=-=-=-=-=-=-=-=-=-=-

