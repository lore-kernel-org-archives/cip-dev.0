Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93ADC04A6A
	for <webhook@archiver.kernel.org>; Thu, 10 Aug 2023 14:47:56 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.82])
 by mx.groups.io with SMTP id smtpd.web11.19057.1691678869951911591
 for <cip-dev@lists.cip-project.org>;
 Thu, 10 Aug 2023 07:47:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=JHOiWZ8F;
 spf=pass (domain: siemens.com, ip: 40.107.22.82, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bhum1+13owZ5w0wF1Qi9zpP0OfOqk/WS7EdK+bh/6IsvriJ+ySSAsXT9sMW1W0I9wOQpmG2BXil8NI/xifnYNgGMW0lxg6DGoFpCRWSuAe42DsCryn+DupMeJ1AQmSpjO6Al2FweEjm4F3CU8qgGHfoxiV3vXn3IdPFEouMEEQaVHTvg+3Zxk3IJ1jVGmeCSY9tZajENjaqQazf4zdV4r+XkPF9utY2gW+zT96WbkZ71UnXupRUvz5M/xow4EDAbwHoTEr3Jn6z+j2jxQTTzhxKgt8e3pMgMeMBCUlhUZR0ZFNxn86phu3EoiLy5O6UORjPlGyapie3vGmImV8jw1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uUTMasAQ679J7/5lbtPu33AAkincwr9rpWPw3bTnhPg=;
 b=T0yYz60wtVtecjbUv1lPp6ttKbfnTbprMi0xczMCpgp2XbMYDyxwKXRLyErPf+z0MX+M8ym815w9q0qduba7+Us+FIL1kvbn0B8AcTQvozlScbtFUBUKC8yshAAoqKc85+ydA0xAoaMstJps/xvSSYK3ZAytl+mAg0+fJ+i1WYDU4x55JjKeH1IfBFp0yltjhkTHHILssFp3HwC9Murb/Rnl8iiZ3+JXRN5Zz4tDksmX9qSfjw+9PZHx68x+jXj2qvJ3lyZUA6WpftT4puoezpR127BW2llIVdU1hMrQLQo68ulWilI+8fFYfVE70KuYWQw1Ju+9SWPLor2MsDRp0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUTMasAQ679J7/5lbtPu33AAkincwr9rpWPw3bTnhPg=;
 b=JHOiWZ8FeVjSikiR/UiLXjg2P0JIhmKpNcT5J2UL1TD5uZGL04sdbGtMxU1N05dqDnKfdz02adpWYLM9txDgdQlxVMAtNINezz0Q1hNCW+61sv4y4VZbXg4PyRzhHDblcPvD2AfLZtDJO0KkaTj7AGcKx1A/v4DTpWBTXh64HJOxzveGZK+lkpHjtcihgEgPgU2z4l56xJCpSQ2tx92bMJPRuArexRXgaMjgm1dTQZ135dWu331bSacEnteajBR6UIus3+gJGIbx0QhkV1go4ZXEj6Jz7w43coBOhJVf662F2feLAfLix7neroevze4mVLMS+1P77/+w+eyFLLHilQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB7063.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3f1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 14:47:46 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 14:47:46 +0000
Message-ID: <ed132a4b-7c2c-44f2-b1c6-8a7c8fdfcdda@siemens.com>
Date: Thu, 10 Aug 2023 16:47:44 +0200
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
X-ClientProxiedBy: FR3P281CA0181.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB7063:EE_
X-MS-Office365-Filtering-Correlation-Id: f96ae145-0b4d-4d2f-1759-08db99b0c2d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	hc4WXoqxmk5LuTSdNtTbJje+0MezOlqG91VfvMS6PNFc0fyTUeLb2LUunuaZZzOWbjnkgx6xggC0128oB31TZPcH3WMIY+1m5wMBG6imITW0dES4AXHt3yOIlKH4ytdsfoPwoVc4OJkc4SC7FC7bWq9ytx4zBJnpUdmow3h8pEKxaMiJUsLjGuigWwMg6gduzGKLC8D2RLlIAfkOEqRTf5OPifa1SXOG3bSU4tsIIgy42WNo+UsBvuBjaMnFv9VTnMfeB2suAtUCPiHFReZS8DK/bVGLPyVFhshj9n438m5s7DztVSfU5tB8W4G/J/+5wglL9/Hey101FlhVCIhghOU6RETq/N4YMTfLGwvosRYntqRvHmAw/yl51q1KlFBn8MgHgkcBxupGOI+j9gez9pB1deToR7l2Ow4g6QjXvbJjEkPJWzNx1TS8meQTVjkhorzG2y+vf8IHe0vd6mEQ11EusKHEt6kdAnwhRPWSELGihROrEe7pi+B9449sZSsfRgX3Hzi7CsT86eT88WLx9jRHMx9j2FQ6exzGKOSGJa5zw50WEtNcG0lCgh61hEf6mt+TYwrLnDAEQZuesTINBPnJRo15q0BReMdE9SukDVVPLDsjxQvOYFFP895ko+p7HvjjWpZjFRwlgAHDjEyEnA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(451199021)(1800799006)(186006)(26005)(6506007)(8676002)(8936002)(53546011)(41300700001)(36756003)(2906002)(83380400001)(15650500001)(38100700002)(82960400001)(2616005)(86362001)(31696002)(44832011)(66946007)(66476007)(66556008)(6512007)(478600001)(6486002)(5660300002)(316002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cng3VFUzbHk1YyswT2dSenUxOXpyd2pLVnAySDNZQTRxZHd5REkwUW9Zall6?=
 =?utf-8?B?YVNha3lKdG1ZSG0ySHRvQm9vSXhaa2oxWFAyTnhwY3BOdXFFa1VWM1hxODlK?=
 =?utf-8?B?RVdkcTMySjVXVC85YlRKaytYNWlSeXljQVM1WDViMU5nSEF4ZUJMdHJRN3l5?=
 =?utf-8?B?YjMrb01McENtWEdrclhWcHhpNWpuK1V2WnREeTI4dDl3MFVPczZLdEZrSXJr?=
 =?utf-8?B?SzdyZDdDMHFNTmxvUTF1NHkxZm0ra0dLNytwdlBpSEs1SW4rUVVlTlJsS1lr?=
 =?utf-8?B?bnowUzRoSUtVNjZPRnNBWk83dGpIWTlFL2x4MkNmOWV4VGxGTHJkLzN4Yk01?=
 =?utf-8?B?V1QwVVNyQjdEVjlZTzJkbFNrTVBPakVNbW9xOS9QREY2Kzh2bHNJUUVqclhC?=
 =?utf-8?B?YWFSTmZuRzc1dWVEUHNwT056emtQNkc5YURsTVFZUzFSNlRLYWdmc3ZTR2NZ?=
 =?utf-8?B?eU5scURKbitxdXVUbkhxUEd0cVZmOXFjcUhNUjNjRVUySDVVZlFtcU93L2RM?=
 =?utf-8?B?U1NHNHpvN0hGa05rSDJiL0lhZVJpN0FNZjlKRUp0S2QrWlBmSjF1bmtnZjJp?=
 =?utf-8?B?RExHMERvMEpwc3d1Ukw0UXVNVG80U3dYcVBibUVvLy95cHNtMTk0VzVyenp3?=
 =?utf-8?B?TzdqY1BXMUZKbWd4V2syZlEyaDl6aXY0MnJrbkRSeEk0SnpPdUZjYnpPa2hD?=
 =?utf-8?B?QTRSWmk0QXh1YnRUa1hoN1FzUGJ6MmdMbDZUN3RmanI3NHFIdStTL0U4MVNS?=
 =?utf-8?B?c3pyZkdENzJRTVZMMnhtNGExWk5yb0JjZ0RKanNwV01sNndiZ1ZRTzg3V1pI?=
 =?utf-8?B?R3J0djZOejJlam9wVGxwSVROVE1aSFV4NlFSSys0QjZ3VW93dFJCYjBWQUUr?=
 =?utf-8?B?ejZXTFduNU51RDlqOE12OHFKYmNZdVBPMjRPMVhQWEpsR1RqbHNWcUVuY1ky?=
 =?utf-8?B?THJOZ0pHNzFZalZia0VGWUdFVHh3Z3lGMnRxMTZxSTh0d1lPd1c0d0hIYlVy?=
 =?utf-8?B?V2h3RExKaHMvTEdBVlBvYWRjcU56R0s2dzlLc3o5dCtJT2NQQkxxUGlPYnFE?=
 =?utf-8?B?Sloxb3pQNVo3VFFDVklvOVd4bWhsVzU0cHRybXplL2tOVytPdVFONVZ0R3Bh?=
 =?utf-8?B?N1BoYnMzMFlaRVluRGZUVkFTeVdkQ21qWkFNTlpZQ2xQSG5NU1JsL2laWUo2?=
 =?utf-8?B?MVBPZHhwbDRINUtrN1QyN2J5ejZwZjgvUnpwcWpGMzlBK2V0cjR4Ui90TlR0?=
 =?utf-8?B?OG5tb04vQ3B3RGdHOGtreFhEcy85ZlkvUWhyZjN2SG0zeGttZnVxQ2VoUGpP?=
 =?utf-8?B?WHVlMmkyVksvM2hDeG50SVJxQWtQTng3WDBwbXdPV2F1YnZoOC9ZN1VET2lM?=
 =?utf-8?B?M1N6ci9VUnY5OGhZZ1RyRXlsU0tUWnNmTWFLZlJHbUNtRlg1dnpJcW9sQlBq?=
 =?utf-8?B?RUhqRVRMN1BUdUgzN3E4TTk1eXZXbjlxOVcvaFNSUWRKTmN3QVBYbXFSMlY4?=
 =?utf-8?B?QUpxREl4UjBMV3BSU09rOGFmZ3JCejRmbXkzR0Nqeis3YSt3K2xnV0JDN2hN?=
 =?utf-8?B?ZzRkak1JQzR2VWQ3NWR6djh2eWNTT3ZEWW5pTXE4TjVUMVpzVUxKNkNOcUcr?=
 =?utf-8?B?dk9Rci9zVVYwS3dZbFBkbjhBS1pCUXlKbVFQOXlKMTVXZHNxVFhWOUtZUHZ1?=
 =?utf-8?B?T1c3b0VYMGYzeXdnZStmbGNBS3VqNHRkWXJGb2pvNVEwU081eEpBOUhCOGFR?=
 =?utf-8?B?Wm5kdkFkSncwL2JDK2RpbmdRbnQ0T2MyMHdYY0ppN1pGV1c1ZDkwaFcrb2xE?=
 =?utf-8?B?aWVOdmY5WkdFWDhIeDYzNWVEcHl2TDN2WXk4Wmt3VDhjOFh4ZEZSbjVRRWIv?=
 =?utf-8?B?Q3YvbGRDTWNhTWdWM0ZqTHBHbk9KVjFCV254L2QyY2gwL1kvaGhGZXFLQWhy?=
 =?utf-8?B?a2ZDZlRMZG1DYThMKzhnbVdzN3dHQ0o0Rm5mQzNtVE93YUs0SjcyZzVIZExE?=
 =?utf-8?B?VFVKOTgvYW50NjdEblNiRmh1RzU5aXFTL2JQV2thNkt1aDZGTFRzK1llZS9x?=
 =?utf-8?B?bFgwbnBRSERRYldubXRtTk5MMnVZeGhrT0NWQUpxOG9ZbDUrRjZWeXY5cWtC?=
 =?utf-8?B?RUVNakpUcDQxLzVNckp1NkpYMCtORjVvem1ZbE8zRWllVzBIbmpPM0pRUWZr?=
 =?utf-8?B?YVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f96ae145-0b4d-4d2f-1759-08db99b0c2d8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 14:47:46.6585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BbALwANsBxUutwdyn1q21yX/zB01uHJjULUlh5EsquFP+1Dpr8f8pLymsquV3HAUOGYc2uhs+0lZGzT+Jo2LmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB7063
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 10 Aug 2023 14:47:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12605

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

I ran a build with SWU_SIGNED unset, and the result rather gives

[TRACE] : SWUPDATE running :  [network_initializer] : Software update started
[WARN ] : SWUPDATE running :  [scan_mtd_devices] : MTD is not present on the target
[WARN ] : SWUPDATE running :  [mtd_init] : MTD is not present in the system
[WARN ] : SWUPDATE running :  [mtd_init] : cannot open libmtd
[TRACE] : SWUPDATE running :  [extract_file_to_tmp] : Found file
[TRACE] : SWUPDATE running :  [extract_file_to_tmp] :   filename sw-description
[TRACE] : SWUPDATE running :  [extract_file_to_tmp] :   size 1219
[TRACE] : SWUPDATE running :  [extract_file_to_tmp] : description file name not the first of the list: linux.efi instead of sw-description.sig
...
[ERROR] : SWUPDATE failed [1] Image invalid or corrupted. Not installing ...

Jan

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


