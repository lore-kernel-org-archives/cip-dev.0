Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FD6C35274
	for <webhook@archiver.kernel.org>; Mon, 18 Dec 2023 17:22:46 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.85])
 by mx.groups.io with SMTP id smtpd.web10.49156.1702920157407473795
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 Dec 2023 09:22:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=UPIkolOp;
 spf=pass (domain: siemens.com, ip: 40.107.104.85, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XDf9Kbej7W0kJO7QxjxFk7anj9NqvUbvL9VUwQXSwpaHnaPQGKO33slZEamioQ+tqrUUKn9qWl20XCgaPU9aR6cpV0amHgaiphKYXjFt8FbomBdYdQeqKoboBvHFwD7T5TKVeknwayWtHNY1VjEm4EXuhYDfrUdAQe1kBKs3GAqPmqn1ZiWKahyugf8wYVNnVkcx8whjUfNfSAzkMhwhWt7XtDuL6tS+LVUZWa6IfKLNAdt6cLUvMMvn3zX7Mag7UeuxWJAh/EN0+ZbsYdxqm3ngTl/1GWrGesMKEL414uq3TNxFeNS/wEsDJPsSu8acMUYRf73ZD5J/lqSYLIZUQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P0GCoX6oKRRAYgRdTz1zqWShpa3ifbJhodkkakfIodg=;
 b=LsEc7JIyfZSAHc1uRmLTXXw0i6gWJxVpjWqkAP2p2PdnHw/UaXhhOWyRztp8LEOECKXlOKDYZLqdZX/GqpreeiCKENmhS16AgGAYy/ZuFLog7u8D8dWsT0iewnCSea50+K7Ej7CGodO7yb1A73xaL7DQ5FZn/QTYHveuy0BXIceT1Ppu/q3GE2zo0KI0DOUxhNH3LNVJTWvLz+HUgSDhPSI7fj9tE79K/PenDZjbj5RhJRZaq8DqyUZzbDkOclenw8CWHYYMrRFJeWw5gzTfNT/HXw7z8P7e8I0hnmhQccyIb/vAXXLf2IV2BIK0UUSpkU/nEXM0+Lf9nAVegzOUpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0GCoX6oKRRAYgRdTz1zqWShpa3ifbJhodkkakfIodg=;
 b=UPIkolOpUhqXhZ3o7KTAY/z+5//9TtqEPycXS/DKHYeTPCN7AW7bSFkNh15gPC2zCK+CWT5TAwjZFwIqNibehPpNDHCy5Z+4Fzun/2IQCRbIfDpAIYU1rdB3ehMLzhC7SM8dr8sGeJn55K0YP8SijgfkkWOdUVLe0Ji/MUs7HYqrF2IPgeJpYpjFOlGNGK+JJolXlvTftPqVaDXGfb1bjk88u5Hz3Q3C2ZkpJPmlHg4m8EQLqkWRsP5v20iLa7vKFnlDPSt1Pm1a+CwSHDx16y2SpLknOaoN8rwif7fwkwqfybDYqnA36C0B7CZkzZJeShh3VbRXzN94FUU6c26Dyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7242.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:454::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 17:22:34 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 17:22:34 +0000
Message-ID: <84de8119-bd3d-4216-ace8-ba00d8e7f84b@siemens.com>
Date: Mon, 18 Dec 2023 18:22:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] recipes-core/swupdate: Cleanup
 swupdate.inc
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com
References: <20231218143023.1507226-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231218143023.1507226-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0002.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7242:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f68ba0e-665e-403b-c054-08dbffedec6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	x1gRj2yN/IIiB6vOz7HbNkCCjyEe8C2YELgKqpcHSJCMeFP8AzBqb/1iqzqNliil/BGy0XtOmKpSoY4jnHz8UhMJLTe7gTRr2Vz0hskcCpL/8WWSzHHZsSrsgI+PgRt/ywyNONEI2oYOlrRJWoDwLcUsZ6VhP1f2yIMU9NRa9ZP0dqd2xXqnLz7w1HP7tuQIr4aEUWu5E2iraeoq9PUsLCLdU8cI7jOpoucrG0tXjcaW0oOBwkr1jf/UtrFRhtvOJwMUjWmHFwOoQ9CMqIguHj1zhcENpwgWYprSHDvrpXlVR9/Z5pVVKBteM5f/O1oTC207x2Pb9qNNQ/gza7x98P2wWS6cPdBvGc3KPVyjUqtWA0RXtQUstiUbbtZPf/TRHsXDA6T478xwXqAAy8EgJSveftkAfobqOpSHGluwpfcSICgXAVa+uugYFly7nDjnp9lvz3S+2n0qtgnV3vYeusVKi0GUXyeF3N03FMpvmHjsUTTKlJdi/39XQ4hQcgF87rj3E5htMXzwwMAbMVfBXAJ6/5QAfSNDN1x5MN30l4Q5X4EScwFyUP6aZlZWkDqru0gRT9BEzyvzXJ9n+CVmk6La1edL6RCqRmpQtQPR+Pne9qqxiScDy128B/fgCMQ7onDNLTH1e/sIkUlbEIILLA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(396003)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(26005)(2616005)(83380400001)(6486002)(478600001)(6512007)(6506007)(53546011)(44832011)(5660300002)(41300700001)(82960400001)(8936002)(8676002)(31696002)(86362001)(36756003)(2906002)(38100700002)(31686004)(6636002)(66556008)(66476007)(66946007)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?V3BHaU1QNXd6SlRjd1VseUhWbWxRMEhIYXNSSlkxU0pNeFA2MFZQK2RPTXJY?=
 =?utf-8?B?a0tDaUZGbzBxeEV2QXRqR2N6a0JJQ1hZOEx1d21EK2poNjJBcEFSL1ZpeVE2?=
 =?utf-8?B?QVJTY2JjWlJlUUk5dnQvcG9KMC9xbjBORXlBd2dSbEZDbmMwWCtNck9waHpQ?=
 =?utf-8?B?VjN6ZWUrZVFHOFBOZnMySVVzK0pQNVVnZGVnVGdxUDFMNlc1ckxrVURCek0z?=
 =?utf-8?B?cytSUHJXaWdtR1lub0dTditadlBZckNRZHZWUkpMdzBzT0VCblg3blNkWnBw?=
 =?utf-8?B?S0RPb3JhdHpyUWh1TFV2OVJTam1FYXFVeFJMdEdkZGJuelIvSEMyVm1QeGl3?=
 =?utf-8?B?aG5GR3F5UkhZZVU2YU5VRmFRZ2pCblhXaWMxR3I2dnJoRkRkdGE4bVp2MVhD?=
 =?utf-8?B?YUIxZVBVT0xIVmg1ekEvdjNrVzlDUm5mK0RDbWQ2UmxMSWVqSGMvY0ZKbWtJ?=
 =?utf-8?B?NyttalVxWFVvNTlJYnBKVDhtQ1dYUmR3ZlJUSHF5aTBpRFloL252VGlZVG03?=
 =?utf-8?B?cTVGMjhIdENsVjl1WjVhM0cvTXVjQVh4d21wbHVWYmovUGYycFhwNFFCbGhF?=
 =?utf-8?B?QUhteDg1S1hEMDBWMDF4bW5YYUYrWXVwYXRYc1lFMnFOR3VSQy9ya2xSZnZH?=
 =?utf-8?B?emc2Zk5zY3VoeXFXR3NYNFh0S21zbVFxR3gwZWZCWTZ1V2dsMmlvZUo0Z2Z4?=
 =?utf-8?B?Rkw4TmlXeDEyS1dyWUc0MlFiQVVVRFVQaTdLbUFxVVZIcS9VeUtqem4xVWVU?=
 =?utf-8?B?bENBT0hxZEFQaDlvTUJ4bUw5YmMyMFUzWXFRbzZISXhuN1VNNUtPMVA2clh4?=
 =?utf-8?B?R2MvU0pSNlJqS1ptN2ptNkRFNi8zdTlpWWlTMEkxakVkcytVTnBLSmdud0pI?=
 =?utf-8?B?WjVhRkV1SGFpMGljTTIwNUFmMjNsZi9yOWdFeTJ3WHQrZGtQQ0VaUlJKaDEr?=
 =?utf-8?B?WWg5R1dTOGNJRFNYR0FHeENDaXQ3OEpSVlBKem9sR3p1UUoydDk0TFRMcEZy?=
 =?utf-8?B?cThBdnNTc2thcE9FN0FHV3MvWEE3MjB3WWo1KzFYU2VZczdBWGEzc2d3RXA2?=
 =?utf-8?B?Rno0bmVYVkF5N1dHM1orbjgwQ3V1amZZcHZEVFJRL0NaNnBEaXpwRUF2K0NL?=
 =?utf-8?B?OWV5YjhuY3hDc0JHcnEwcDh6ajJTaHhmNmZ4Qnkra0kxN1cvV2VSOUk4d3ds?=
 =?utf-8?B?NUxQYkRCSXhtN1hzNVNRcm5wbm1nMm43eERuN3FRRDZscXlVWnBYdE1lNVV3?=
 =?utf-8?B?bHVLclp1dVNYeFdKMkZmZ21nR0ZhWjk0WC91dHhldTJIMjZqNDRNZjBpek0z?=
 =?utf-8?B?SVlPSGpGbUxvdEZ5MlViaFBJT0RPY3JPU0ZNdkJtVVBDVDdNQ0RDb2IwTXRH?=
 =?utf-8?B?RHM3ZHBYcmd5QjJVNzJrNmYrMXYzNW5wb082NFV4YzVLUmF2a25Ja1p6V2E4?=
 =?utf-8?B?UFZKTXUzbGlsZzBqV2VScW0wUTFaQXlYMHpKRjRZUGhMQ25UM2ZDdDZmTkZO?=
 =?utf-8?B?QlJ4V01BSnRTN1lmTFQzWHRRcmtNVGxVaHZjL05SdXFUSnVSdkhlNERRZnlP?=
 =?utf-8?B?OXl6SENRU3ROYWRwWlluN0E2ZmhXS2xSUVNaalpWUUpVYW4wWGc1eml1eXlz?=
 =?utf-8?B?NndPOGdWcnVyeUJXS1hjN0ppeUhsL0F1TUFsN0Y4OVJYZHBsUk5Tczk5NWhh?=
 =?utf-8?B?cXFHL2t3Z01FUnZZbGIvOU5PT1ByQVZOeVJIU2g4dWtLT1RLenNqWmN2WFFi?=
 =?utf-8?B?SjluN0dGL0NqTk9EenZ1WE5VQW45U1ZnMi9PeFd6QTNtRDVYWWZTeDMzSkRS?=
 =?utf-8?B?d2dudDEwUVNWRXBLODB5amxKbWdCZkxVKzVTRWMwamRBOHBBaC94bHBidW0z?=
 =?utf-8?B?RGpQUjE0MUFqUkwzdG9sR3FoRXZGc25YSWlZM2ZVdzE4ZTQ4S3BndzRkOTdr?=
 =?utf-8?B?UWxzbEQwTys3QmFPSzZKb29aK2hWV2RhVHB6SEYyRDd4SW81QXkvWWIwT1dB?=
 =?utf-8?B?N1pKRGQrYUNMN1owb25DRDM4Q1Z4Umx5SjVCNDRpK0dVcnlwUWNKR293RUpo?=
 =?utf-8?B?QllldUpqVWpPeHMvWXNhVUtZaHlZYlVGUVNxZmJ6Qyt4QzF0TCtxeFNTaENT?=
 =?utf-8?Q?upMF7DwPxBmaS7x50BQlJEN7R?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f68ba0e-665e-403b-c054-08dbffedec6f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 17:22:34.5891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O603D80zmkg0PJkEvhr+rUAehvbBowG8h0JNgwyJQ7I/O3MqcfHeg9hYfvxufhH1EFFoj8RPuT6YhDY0ZjlxHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7242
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 18 Dec 2023 17:22:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14134

On 18.12.23 15:30, Quirin Gylstorff wrote:
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
>  recipes-core/swupdate/swupdate.inc        | 25 ++++++++++++++---------
>  recipes-core/swupdate/swupdate_2023.05.bb |  9 --------
>  2 files changed, 15 insertions(+), 19 deletions(-)
> 
> diff --git a/recipes-core/swupdate/swupdate.inc b/recipes-core/swupdate/swupdate.inc
> index e5e7282..4442ca5 100644
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
> @@ -13,15 +13,11 @@ HOMEPAGE= "https://github.com/sbabic/swupdate"
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
> +DEB_BUILD_PROFILES += "${@'pkg.swupdate.nosigning' if not d.getVar('SWU_SIGNED') == '1' else ''}"
>  
>  def get_bootloader_dependencies(d):
>      bootloader = d.getVar("SWUPDATE_BOOTLOADER") or ""
> @@ -33,13 +29,22 @@ def get_bootloader_dependencies(d):
>          else:
>              return "libubootenv"
>      return ""
> -

Stray newline removal.

>  DEPENDS += "${@get_bootloader_dependencies(d)}"
>  DEPENDS += "${@bb.utils.contains('DEB_BUILD_PROFILES', 'mtd', 'mtd-utils', '', d)}"
>  
> +# deactivate hardware compability for simple a/b rootfs update
> +DEB_BUILD_PROFILES += "pkg.swupdate.nohwcompat"
> +
> +# suricatta wfx requires suricatta lua and the dependency
> +# is not set automatically
> +DEB_BUILD_PROFILES += "pkg.swupdate.suricattalua"
> +# add suricatta wfx
> +DEB_BUILD_PROFILES += "pkg.swupdate.suricattawfx"
> +
>  python do_check_bootloader () {
>      bootloader = d.getVar("SWUPDATE_BOOTLOADER") or "None"
>      if not bootloader in ["efibootguard", "u-boot"]:
>          bb.warn("swupdate: SWUPDATE_BOOTLOADER set to incompatible value: " + bootloader)
>  }
>  addtask check_bootloader before do_fetch
> +

Stray newline.

> diff --git a/recipes-core/swupdate/swupdate_2023.05.bb b/recipes-core/swupdate/swupdate_2023.05.bb
> index 77b7431..e52a329 100644
> --- a/recipes-core/swupdate/swupdate_2023.05.bb
> +++ b/recipes-core/swupdate/swupdate_2023.05.bb
> @@ -35,15 +35,6 @@ SRC_URI:append:bullseye = " file://0004-d-swupdate-www.install-Fix-path-for-debi
>  # of update binaries
>  # DEB_BUILD_PROFILES += "pkg.swupdate.nosigning"

I suppose this comment is now obsolete with the automatic selection, no?

>  
> -# deactivate hardware compability for simple a/b rootfs update
> -DEB_BUILD_PROFILES += "pkg.swupdate.nohwcompat"
> -
> -# suricatta wfx requires suricatta lua and the dependency
> -# is not set automatically
> -DEB_BUILD_PROFILES += "pkg.swupdate.suricattalua"
> -# add suricatta wfx
> -DEB_BUILD_PROFILES += "pkg.swupdate.suricattawfx"
> -
>  # Disable cross for arm and arm64 on bullseye
>  # with cross compile we have a unsat-dependency to dh-nodejs on arm/arm64
>  ISAR_CROSS_COMPILE:bullseye = "0"

You are moving many DEB_BUILD_PROFILES into the include but you are not
updating swupdate_2021.11-1+debian-gbp.bb accordingly.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


