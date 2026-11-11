Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.21])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1100.1794414965630457581
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Nov 2026 08:36:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=YgVlHIQQ;
 spf=pass (domain: siemens.com, ip: 40.107.130.21, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xbGVPMBHAza2Q7HPLzm4ipO/XVaPsjH/4ADPmYwC5QGHkPwMBleqfmmg2xfzYCxNgiqOZhlEkegy47EcbknZp+7AkBZWpPQrZHtIoed4GO0N1i9fAi5hR9ddaBZoj0vYSYj1BqXKlxG3kr3SRIUBcjtKCJV5eyjRNrG4Ev3YCp0dtAMEf1AqIB8teOSQQfj4P3c1gbBVrM780PaxPLtpFpwp33miikKHvCyZTkDnkEuYgQsWrcKbSkAsq6tNuKPXchPeFEiu75h0l6iXgSINKLvt9SRQ2H5MM6bYeuAUw1OKSNYLoObUJgKs7iQN4bUNPTBWC+ed0tj6WlqGCKutLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kUcl1AXP5Xlt5F/JBU+5xQsdlMHE7ZM7bO6OfKf1FSI=;
 b=LW8BCNQdBRrne/Ep9lou8JnTnEHWNsHqPvYO8VJzqLUoin9E1m8HNx0aYkAgcQzU8WrTLbphfFQDuGlLF2M33EBwXHJrAq6+aV/FrbTeVlBVqxf19GXcdmtXQ7NJBeW2NmZCzXUQvtiLsnkY0vd3q+Iqyks+5eoORAjb7OQdLV5DW/c+tb1lsy834kM2HrcbL50TywZ8PgbIxt+fp4QEQVbB1Fs1eGg4M177YHvT5Ad6BXFAaUFhx6euJ5gzkuRT629dnCNnDnnHYdAtbSwjaqUsA+EzTVdpeZlTN/lOaPmXfKTbyIzaaOrttQoB1HYuGoP9/ru6G9ETpiRQZl+s0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kUcl1AXP5Xlt5F/JBU+5xQsdlMHE7ZM7bO6OfKf1FSI=;
 b=YgVlHIQQ+kioQuLW6yodhW5pVEckGhjd3oZBKG/i/rY/WoU8XkQPmUBiwIx0a9FPxTI9KvsZVwChBYvyldrZKBktuMqpJ2hIPGXx7o0UzYglAm0Tzr82pOTt+9KKQwVNVoSWYwyBENHw61r+BL79RrOizjopt711mFTIzecOgdtx1OnI25WY2MfgTNl9yjPBg9TQduK62mWLvcl6LaQIgcaMLgT2Fvs/uwkeeWq79yCJoL6k4rHGOvaXN9ScOjLgqJZMAtQpufCQQJBPqBhidX8OiVq9erC12dm5XqxFVb9qqOCno/5+Rv0RVOUiVXOAcP7uNIcaH8g0nnKzfL8IVg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by DB9PR10MB6569.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:3d6::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 16:36:01 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 16:36:01 +0000
Message-ID: <385b3826-556f-4d62-a867-c5da7cc75bd9@siemens.com>
Date: Wed, 11 Nov 2026 17:36:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][PATCH] Add missing whitespace around
 assignment operators
To: Clara Kowalsky <clara.kowalsky@siemens.com>, cip-dev@lists.cip-project.org
References: <20261109093109.224917-1-clara.kowalsky@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20261109093109.224917-1-clara.kowalsky@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR05CA0126.eurprd05.prod.outlook.com
 (2603:10a6:20b:497::26) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|DB9PR10MB6569:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cce89e9-6353-41a9-3a2b-08df4011df1d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|22082099003|6133799003|18002099003|10067099003|55112099003|3023799007|13003099007|261028144727099003|11063799006|261022075727099003|261026121527099003|261022115727099003|261021123027099003|261021121427099003|261009223027099003|261022105027099003|261026140227099003|56012099006|261102123227099003;
X-Microsoft-Antispam-Message-Info: jIdV8g4WEF5iYDk4ilG64o5eHjbbCL3XOVNkgjZJDSjNoGGMDBUZka9ZKO2UgDhEN+d+9fOkS5Umlm1Gq5Y479fMx6wspk12qCC4sr/zST7uJvXdl+sI3+39lfS9xN117ym7f/tQqGKrwDFGsar87qiIOPhD83bVTlRFZNPa50k6a1N7wHzzmib81G4xSCv/z4JTYlo8pCOvxNdMexAY7JKeXdQL2te71WATkWMwqsOqu5MJhHzP/jPIEg06CjLyC5XzcoB3SL0QoWFCqfH3MqDJtlawZP1PFUTFSaxCw9e7Et4RR+cbDx9OAm1vB9L3vlngt5Rd+S5dHJse1rHo9VXjO7Oal9MH5h88K08q1WPWi4FFrhY5LeBgb8NT0NlotpgXte3j2VKibxav+okUYUKd0nR+Wg8j3IfoA0Q+IP2Mp4royZIiRIiALqH5F0PVt8qBFYRsJW49ZBQ0sNO5/+ZUEyJ+UHB5aZpitttBgYh6j1Zq8Kkvwy1ktw40FgIEsa72p1CGXQIZcM2Kwcv188sCQv395nG/US6wZICDRasuivxpfaq0L/zmSfAwlbcTaS2Yy1Y+1oWFBqNqeMSbizESNEkC723A2R/CkIWNyJgb9CsdWytpQ6GsQfnm8Vd8wS+I95n1q3Nkn8Y1tDX08c/yTJC4jSvgUp5ga1Edwr8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(22082099003)(6133799003)(18002099003)(10067099003)(55112099003)(3023799007)(13003099007)(261028144727099003)(11063799006)(261022075727099003)(261026121527099003)(261022115727099003)(261021123027099003)(261021121427099003)(261009223027099003)(261022105027099003)(261026140227099003)(56012099006)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3pDKzFyNjFrdThWQW9LNUozanl5VEJ2UHd6cm1xelpuNTZ5Z0NXSGhUUmVq?=
 =?utf-8?B?TThkeDRUTWhZNFN3VGhhc3Fza3h4b0dGOEc4bm9adVZEWjdtVkptcXYxVHlG?=
 =?utf-8?B?RTJzTjJaTXQ4MXlYT3o5WE80UVpTUFM3TFRYVjJFc1QrSEN4ZnVFbEVFaU1r?=
 =?utf-8?B?a1NyR29FYWpMTy9hTlJPc2wxbXgvR1JrVXJvU1JoYW1BR2JTbm9FR0gyNkVJ?=
 =?utf-8?B?Z3BDY1NFM01CTFZXdVd4NzdGOWlYem1kRXJEdFJueUROUXFDRzlrVk44d0pu?=
 =?utf-8?B?NXIyNk00VWtJcTQwaGxQMzg0WFZtdVVMcTFDai9ERkk3V3pkalJFSHpoeEx2?=
 =?utf-8?B?RDlITExaS1ZYOXIxMWc4MU5xR2dadlA4cURIWmpzSDVNZG1rdGhja2o2bXIx?=
 =?utf-8?B?SExkdCtMdTN0VEJTR1ZxVkV1T3NTMytvZWhBWmdXbUFNODVmY0tzZFhGQmJm?=
 =?utf-8?B?RXpFbmdsa1Z1Q0xVODllcEhNQkZMR0U2R3grOHN3R0Y3MXU1SFp1WWRNYWdG?=
 =?utf-8?B?dEQ1eTdXUzFpVVJwbVlzWStydHBIcjVLOG95bXJjYjBlaWpDVElqYWw4SE9t?=
 =?utf-8?B?S3lOMDhzaGVTdjIwK2pLZUJZQkZKV0ZlcDgxbW1XMUlBRSt2dWpFN0haU09m?=
 =?utf-8?B?bk1ja0tGZ253Z2V6U2grVi9XelNyZGtGTlBaL2paUVVnTTU1dS9ORkdBZ3FV?=
 =?utf-8?B?WUwwaHZxYlFvdEt3Y3BycjNjSnpBUU8xcC9vSWtuRERLTjZIRnZUUFNrWnNP?=
 =?utf-8?B?VU9EaXAvWUIvVnl3TGl1YlBqKzFMTjhvMlQ3cjhKMFN6L0pSdWJIUkZwZ0pB?=
 =?utf-8?B?bi82U01kcmNjZWpmRTNJL2hVN2pwVGRoQ2VSbWRkcGZsZlJMSjBNcFN1dzdZ?=
 =?utf-8?B?ZHBlaHFlTmVTckcvdWY0aktCdGp2dmlhbHFrdkpTb0UwVFBYTDArMDk4dWdh?=
 =?utf-8?B?ZklETFhXNk1IZlpuSmIrSnduOWtleXRSbDNNZnF6ZS9kNnFxTi9ZemJrYXhV?=
 =?utf-8?B?cHdHcEhOWUtnMjd5a251cVFIa2pXdmFxR1pyZkxjcE5iRGxEMlZDN3B0Vncz?=
 =?utf-8?B?NnpTNGc0THpvckg3T1pGWTdMTkVFM05uR1BYd015cG1jRlltV2hrbUhUakts?=
 =?utf-8?B?K1pydmRCZ01PL0xoOTNheHBnWDZXUThKMldjWHdvWmxLYVE5SWlMMVh1Q2s3?=
 =?utf-8?B?TVFQODhMSDFsRVdZREw2WUxBRG5DRk0vSUp6NjJCT01YcDZ5Uzkxb2FIcHN0?=
 =?utf-8?B?bGdsc1hDSHpvYXpmeUtkOHU3Ni9nMHUrd0Q0b08rNGcwQkZYdHA0NXE3aHFR?=
 =?utf-8?B?V0Zxd0tkR1Z0ZFZPYXBpdW1keE5zOU5kUkc0d1pVemxkN3FKdnFYNGQrUVlj?=
 =?utf-8?B?bUNERkt4YUZGajZJaXZ2aEtBYUE0d0lwYXVYOXlaQys3ckVtUk1Mc0FDaHg0?=
 =?utf-8?B?azloNG5VNmFWbWROTTVENE0zaXhpNXo3YU9TSExYT2dGSEpYemVjT2ZRek12?=
 =?utf-8?B?UFNqT25FbXBFMnB1VVZvbUVWc0NsNFo5ejc1RmVmNzVZaGp3Uk8ySzFYUjUx?=
 =?utf-8?B?cm1OWnl6ak1HYmZ3a0k4ZkxtL1dKN25tMURHUFhzYjcxZXM1Ulk3Zmtsd3BH?=
 =?utf-8?B?RzZYUk5hYXV5VFNINHJUU0VDYTdnaG1aOWxEWVZNNjYrWS9sSWdTNDNQejND?=
 =?utf-8?B?R2thWklnc1ZNYVVOc29VbCtXbjk3dGg3RlFiNER6VFBTT1Q4bmMxV1dsVHhU?=
 =?utf-8?B?a2tVek1hQ0tDL0tCdit2QjZSZ1l3UzFBNjFabEJGWnZFZmFMQ2htNUx5SG1X?=
 =?utf-8?B?MmRReXB3dTBZL294Y3IrSUpvT1FsNnFNUndIWi9kaUxwWFhFR3ZQa2RtQkNu?=
 =?utf-8?B?clYxZUVCME1SM0Y3dnZnOTd0bFVTOC8zTGMwWVdJb0dyZTBaNU1VOWRMbThw?=
 =?utf-8?B?bWgxK3ZHVENwdE4xa2VmM0UzdWZWU3JVcWt4cWJhRG4wZjZsdi9oWCt1R3hD?=
 =?utf-8?B?M2plQ0hObjJ4c0FJZzM3QW4xY2NGcmlYNlZkZFlHNmx2czU5d054L1ZuQmdY?=
 =?utf-8?B?UlJkbjh3eXA0ai83V3RnMVdFRzhjYjdxeDlsa1lpYlljaEthL05mMzJIaU8z?=
 =?utf-8?B?Ky9YTTYyREFzUXNKa1piZHF4VGNiNzh6TWFQNDZCTHhZcmFEREFHNkpVR2xF?=
 =?utf-8?B?dmhsWVVMTkY1bHFuak5pMndKY0xob2J2Q2RZZ1Y4bVRtN001K3ZJSHk4VENj?=
 =?utf-8?B?STdSN25PcDQweHluYmQvZm5mM2JhTGFXYWJZaDcyb2FWaVFrbmFNb2w3R3hr?=
 =?utf-8?B?eGhndGw5TDFMeU8rMGxJajFEcVRqaDZsWlo4V0NMeDVlTENManYwdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cce89e9-6353-41a9-3a2b-08df4011df1d
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 16:36:01.3129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rweF3Wk/ZIcxPzMiGCFXcY3DwlyKZnrV4mZHhKmYumvTpwJl67ynT/YzMe6HPatUTtXXDnKNRlRJwx7Bzb+Ezg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6569
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 11 Nov 2026 16:36:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24764

On 09.11.26 10:31, Clara Kowalsky wrote:
> In preparation for an update of BitBake in Isar, add missing spaces
> around variable assignment operators. BitBake commit 24772dd2ae6c
> ("parse/ConfHandler: Add warning for deprecated whitespace usage"),
> included in v2.15, emits warnings if the spaces are missing.
> 
> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> ---
>  classes-recipe/read-only-rootfs.bbclass                     | 6 +++---
>  kas/opt/ebg-swu.yml                                         | 2 +-
>  recipes-core/home-fs/home-fs_0.1.bb                         | 2 +-
>  recipes-core/swupdate/swupdate.inc                          | 2 +-
>  recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb      | 2 +-
>  recipes-devtools/dosfstools/dosfstools_latest.bb            | 2 +-
>  .../initramfs-overlay-hook/initramfs-overlay-hook_0.4.bb    | 2 +-
>  recipes-python/shtab/python-shtab_1.5.5-4.bb                | 2 +-
>  8 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/classes-recipe/read-only-rootfs.bbclass b/classes-recipe/read-only-rootfs.bbclass
> index 1690ecb..1c35d8c 100644
> --- a/classes-recipe/read-only-rootfs.bbclass
> +++ b/classes-recipe/read-only-rootfs.bbclass
> @@ -36,9 +36,9 @@ IMAGE_INSTALL:remove:bullseye = " immutable-rootfs"
>  IMAGE_INSTALL:remove:buster = " journald-config"
>  IMAGE_INSTALL:remove:bullsye = " journald-config"
>  
> -ROOTFS_POSTPROCESS_COMMAND:append =" copy_dpkg_state"
> -ROOTFS_POSTPROCESS_COMMAND:remove:buster =" copy_dpkg_state"
> -ROOTFS_POSTPROCESS_COMMAND:remove:bullseye =" copy_dpkg_state"
> +ROOTFS_POSTPROCESS_COMMAND:append = " copy_dpkg_state"
> +ROOTFS_POSTPROCESS_COMMAND:remove:buster = " copy_dpkg_state"
> +ROOTFS_POSTPROCESS_COMMAND:remove:bullseye = " copy_dpkg_state"
>  
>  IMMUTABLE_DATA_DIR ??= "/usr/share/immutable-data"
>  
> diff --git a/kas/opt/ebg-swu.yml b/kas/opt/ebg-swu.yml
> index 486d30f..bf54079 100644
> --- a/kas/opt/ebg-swu.yml
> +++ b/kas/opt/ebg-swu.yml
> @@ -34,4 +34,4 @@ local_conf_header:
>      IMAGE_FSTYPES:remove:qemu-amd64 = "ext4"
>      IMAGE_FSTYPES:remove:qemu-arm64 = "ext4"
>      IMAGE_FSTYPES:remove:qemu-arm = "ext4"
> -    IMAGE_FSTYPES:remove:qemu-riscv64= "ext4"
> +    IMAGE_FSTYPES:remove:qemu-riscv64 = "ext4"
> diff --git a/recipes-core/home-fs/home-fs_0.1.bb b/recipes-core/home-fs/home-fs_0.1.bb
> index c99c32a..dd81716 100644
> --- a/recipes-core/home-fs/home-fs_0.1.bb
> +++ b/recipes-core/home-fs/home-fs_0.1.bb
> @@ -16,7 +16,7 @@ DESCRIPTION = "Systemd unit to mount a dedicated /home filesystem"
>  SRC_URI = "file://postinst \
>             file://home.mount"
>  
> -do_install[cleandirs]+="${D}/lib/systemd/system"
> +do_install[cleandirs] += "${D}/lib/systemd/system"
>  do_install() {
>      install -m 0644 ${WORKDIR}/home.mount ${D}/lib/systemd/system/home.mount
>  
> diff --git a/recipes-core/swupdate/swupdate.inc b/recipes-core/swupdate/swupdate.inc
> index e11f0d5..f04939a 100644
> --- a/recipes-core/swupdate/swupdate.inc
> +++ b/recipes-core/swupdate/swupdate.inc
> @@ -11,7 +11,7 @@
>  DESCRIPTION = "swupdate utility for software updates"
>  MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>  
> -HOMEPAGE= "https://github.com/sbabic/swupdate"
> +HOMEPAGE = "https://github.com/sbabic/swupdate"
>  LICENSE = "GPL-2.0"
>  LIC_FILES_CHKSUM = "file://${LAYERDIR_isar}/licenses/COPYING.GPLv2;md5=751419260aa954499f7abaabaa882bbe"
>  
> diff --git a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
> index 035887e..6405a42 100644
> --- a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
> +++ b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
> @@ -18,7 +18,7 @@ DEB_BUILD_OPTIONS += "nodoc"
>  FILESEXTRAPATHS:prepend := "${FILE_DIRNAME}/files/2021.11:"
>  
>  SRC_URI = "git://salsa.debian.org/debian/swupdate.git;protocol=https;branch=debian/master"
> -SRCREV ="344548c816b555c58ec199f31e45703897d23fb5"
> +SRCREV = "344548c816b555c58ec199f31e45703897d23fb5"
>  
>  # add options to DEB_BUILD_PROFILES
>  SRC_URI += "file://0001-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch \
> diff --git a/recipes-devtools/dosfstools/dosfstools_latest.bb b/recipes-devtools/dosfstools/dosfstools_latest.bb
> index d0ac128..3ec79f6 100644
> --- a/recipes-devtools/dosfstools/dosfstools_latest.bb
> +++ b/recipes-devtools/dosfstools/dosfstools_latest.bb
> @@ -13,7 +13,7 @@ inherit dpkg
>  
>  MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>  
> -CHANGELOG_V="<orig-version>+cip"
> +CHANGELOG_V = "<orig-version>+cip"
>  
>  SRC_URI = "apt://${BPN}"
>  SRC_URI += "file://0001-Honor-the-SOURCE_DATE_EPOCH-variable.patch;apply=no"
> diff --git a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.4.bb b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.4.bb
> index e201277..e47b483 100644
> --- a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.4.bb
> +++ b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.4.bb
> @@ -58,7 +58,7 @@ DEBIAN_DEPENDS .= ", awk, coreutils, util-linux, e2fsprogs"
>  HOOK_ADD_MODULES = "overlay"
>  HOOK_COPY_EXECS = "mountpoint awk e2fsck mke2fs"
>  
> -SCRIPT_PREREQ="crypt"
> +SCRIPT_PREREQ = "crypt"
>  
>  do_install:append() {
>      install -m 0755 "${WORKDIR}/${INITRAMFS_OVERLAY_RECOVERY_SCRIPT}" \
> diff --git a/recipes-python/shtab/python-shtab_1.5.5-4.bb b/recipes-python/shtab/python-shtab_1.5.5-4.bb
> index 03e0aed..8d096a4 100644
> --- a/recipes-python/shtab/python-shtab_1.5.5-4.bb
> +++ b/recipes-python/shtab/python-shtab_1.5.5-4.bb
> @@ -23,7 +23,7 @@ SRC_URI += " \
>  SRC_URI:append:buster = " \
>      file://0001-Lower-requirements-on-setuptools.patch"
>  
> -SRCREV ="8db4615b2c3ee0a9332b6030687e1179fcfc8670"
> +SRCREV = "8db4615b2c3ee0a9332b6030687e1179fcfc8670"
>  
>  # We don't have pristine-tar in this tree hence use this option
>  GBP_EXTRA_OPTIONS = "--git-no-pristine-tar"

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
