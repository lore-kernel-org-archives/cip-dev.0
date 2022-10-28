Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA0FC38A02
	for <webhook@archiver.kernel.org>; Fri, 28 Oct 2022 05:50:44 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.68])
 by mx.groups.io with SMTP id smtpd.web10.3184.1666936238785651958
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Oct 2022 22:50:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=m/yP43UF;
 spf=pass (domain: siemens.com, ip: 40.107.249.68, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dqUGX4oewhZdUpY1+86r27cbVuzdPwy6W6hMEbk9+aFX62stcIjsyyZEzoCL6hmvg13g3rIMreT2maSQbgMZccO76Nx9LoGYMmuxPdfOk5C74DC5pFaK7RDZamH52MP3pwyyNLR1u348lhV6YqrTKk/LmhjJA4fUsI6F2sdNtBq3oRwHW/6S6JK8YML+GE213iuCwXHu8ZEjqI74hdOVtVzsDvi3D4cKyB3EnupKzqmDTgjNRODCjvl47Fxtaj1iOXPoehKQ/GouSwyRbd083zz4e2ZHhB9KMNyaqacG4cy+GuSgkWyiDhEMiqqoJtIc0Kh3ezLoNQbuVPDPFu18Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kll+vrrVtaeyGERtrAhqbHG6M8gEq61WZq9drQBtMlk=;
 b=gl3ppm28LMUhUcHJq+2zRadiZyIxEV8EIQm0CR2P3pva3GYb/vX41sV9PkamlcQnD+AyLe7GQZxsa7k9qAd8L1tqhCW/z01P5/7715dHiUMUhVaaSgIhPc9zpAUsJHLIZN9yVzdXicdK/yxTP2yvIX8RVH7A+smN0TsdHcx/9wHIMskW97k2XEuFFMb7owMmxcXj2okda6i3ZPGVYsSojAOV6aaROHpvb2KicMdUEElB0XDqyxotv8hz25FytiFX5y7AVD2vEfWyuC3Mu0eikcYLJx62v5BicZ4KNzonYuRlmKwSUFccuBJbreXP9ITri+c/onpZZ+y7kYn/RihvIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kll+vrrVtaeyGERtrAhqbHG6M8gEq61WZq9drQBtMlk=;
 b=m/yP43UFfQts9/lSLNaz8BCS3VZSvfTzLMDzgLDG9b0LM36hsvOlehw5nYN+FVv0JhJTl+y+9sxi4cM7YDQUJ0ewSQ9mQ8QgekcDqNIzpIXZcMl7DGLMLg2GVRwt9rriKIeiwDCLBI3FbdXLcQCOMAVtIRsh5mR6PA6GdSFYw5P6ob2BoyXNpikhruQB7VRXrrj3Txl5MnSDDtx4DDz1gFxnWhumhYv9d/I0VqVuOHBsfQBjhiT00cLZnbZ0bbW7l2Y4MeiF8M9iwPXohbZ5TE7ZoJN/X227IBryj0fumPZ7aR63qo/Wl6auwFg3vbsfDSab45wSgNzUGPtxKxlJag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3509.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:140::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.14; Fri, 28 Oct
 2022 05:50:35 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4f98:4e25:cba5:cf58]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4f98:4e25:cba5:cf58%7]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 05:50:35 +0000
Message-ID: <22a6890a-c594-77a6-13b8-a74abe668186@siemens.com>
Date: Fri, 28 Oct 2022 07:50:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [isar-cip-core][PATCH 5/8] add recipe for trusted firmware a qemu
 arm64
Content-Language: en-US
To: sven.schultschik@siemens.com, cip-dev@lists.cip-project.org
References: <20221024122725.383791-1-sven.schultschik@siemens.com>
 <20221024122725.383791-6-sven.schultschik@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20221024122725.383791-6-sven.schultschik@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0160.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3509:EE_
X-MS-Office365-Filtering-Correlation-Id: af464fa0-b07e-4890-3405-08dab8a85585
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	vfK/2syhHjztBMuZnixgcT0tW3M5QObM4G5CZg4nwBhgAXjS03FamQfr99yP+y5vMDSiAgkYSotntQ/ss0pIVTH4fkT1/v15e6zQqVmbZ3FOS9pJQeuis34Agb3xgBQ+W1872LEoGVCu/6LTt/VEahgapWDszHx/rDrm5HL/YG97W+anDwfHIkQAQItLyGpLGuRLP83E7LM/OXBOnFRKYR+HAFBNUVYo9PL7EilZi9+9/HqZvuG0uxqDwXGti2M1t8USNBe1OgZ5VTV9CXB1YaZWbOSNMN6Tmd5KAGFhY9xIoXnQdrUrR/edlwi1u2JXCr4VPS6n3EW/0830QoYxChZyXMUIiyAsLzLybji4jZ/Dwbl7blt51zDgEe4tK+VOKC4AJCFeyATWllk8JVP8N8uyCxcHLogkXcXO2JdjAFuVlY2kSep27FfxO+1LqEdo1kiT2bJzo/hfRprAZ5m2XxQirMGk6zHEaVAttEif6dgE+9qvGPpMg+aj696ii4KtyLlsNQftopJAoazlJRmj/EVQ9j71x0rp9dnnkSYgeTRlpExPBUyKwxnBd8Nfi16MJlMImpFkAvM9NbHNF3Xq85jrMFW2IsNsMa51ONLfgsG77joWQrhnraYj8wqixX2TZEperMuUquIyQ2zDrD7Q551eiolME3i6AdzFFYq+69lW5wuhIMTWGohpxSp/Bwsvq3weZbzN0UC/2t9+NQTUEVgJTxwjhQ5UgmhVNcoywD3dhs7aHjTqjxKJfNTAzee+tPcFgWk9yXrYWv8/1Bl+lia/vJBqI3hJqDMGNs47B0L0dSN6Z4DilQzZ4uDJNgq88CBVnIIyoGC6D7cu5vXqw9TKWKSRC8xStOXhra9lNaWl/wFyFpf+xizl3jxah4VH
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(396003)(376002)(136003)(346002)(451199015)(6486002)(38100700002)(5660300002)(478600001)(966005)(86362001)(66556008)(66946007)(31696002)(41300700001)(8676002)(66476007)(82960400001)(8936002)(36756003)(316002)(31686004)(2616005)(53546011)(2906002)(186003)(6506007)(44832011)(6512007)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bi83SWlyWGNCb0VOS0lGOWVpc3ZkdGVYMVp4RHoyL2JuVkFoOEhjdjMvRmhH?=
 =?utf-8?B?VWg1SmtYT3VKWHBuOVlpV2dyTm9BMW1nblpFRUNNd1BOMXdHQTcrWXdyRTBF?=
 =?utf-8?B?aDI3aklFRjFQN05aMWRKU1VqOFBOZkpSRitwUTJLL2FjSzlXbVorT21kMmZn?=
 =?utf-8?B?OFpCN3dkVjVnYVNuN21QZjlUdDBtS0lEMkhaMmJNNnBxdG5tZmd2eGNxY0RB?=
 =?utf-8?B?ZS84WDI2ZzdiN21ZWGtWRU8vSUIyVklqVjRuYTIvcXN2L3FIL2RmMzRLRVlr?=
 =?utf-8?B?YlExbktrWlZuaGxNQlcwa2c4TXprMVV4V2lGMGJHMmRrbUxsZzU4ODYyc1h2?=
 =?utf-8?B?K1dkWVFmTVltbFNQYzJxUVd2a0xoK1FuTUJTaCswaVJ5WEJnOEVJcnA2bldy?=
 =?utf-8?B?UENlOEJMbzBqMVZ4SkQ5VlFNMjhKNFRZazFWYU5hTGFmdkQ2VW1EQVJLR25M?=
 =?utf-8?B?Tm9ob0F3RGNPcVhsYmI3bVN3VkN4OXdiQ3BmSFp4MW02VEJmNUV6OXRrSi9t?=
 =?utf-8?B?UkJaUWtXbDljOFVpTVhMZTMwQXgvYnN4QjRHQWlHNXVoeVNPaUFacXp2QWk0?=
 =?utf-8?B?Q2FtQjdZZEIvblE2Z2lqaEJEUVJta3B2ZDYyQ21Qb08xclFlY09LZE41ZXox?=
 =?utf-8?B?dE56UHFEQ1J5ZnpIWkR2Z1NJVCtNSXorR25nN0JBYThad2g5cks2Z0g2aEJV?=
 =?utf-8?B?RmNwL2tjaU9uUzN3TzhIZ3Q1aEJ4SFAxdjg3cVRtaXNrTEpQcTY4dUZLK2x6?=
 =?utf-8?B?RExNQnA1b3FxNmxPaDFqdGNNelpmN0RHajByUjJhazlPRzFiTUdDVlhqK0la?=
 =?utf-8?B?TWQ3MHQyWWJ3bHNEWkY5VkNCUExXYWRYZ09zdTdTUHcrdVYwNUxCRWxxWDhS?=
 =?utf-8?B?TUFwWGV5WVd5UzRqSDIzT050V3NPMjNDL2xXT09Fb0VJK3dPUU41SVJteURX?=
 =?utf-8?B?UVFTM1d5OWVqT29tbDlnNjhmMkROTkhUZWFtT0x6VlNONTc1VUwxcHJUUWp3?=
 =?utf-8?B?cTlXcktibW51WWd0NVdOb0VuN0tIRWs4MUN4NGdwSmZTWTJDdjI0dGZDT1Rk?=
 =?utf-8?B?OGsxakFoR24xUFNLbUtZUE1EdzNyY0RGQWFlNmhZbkQwSlF3R0ZNbTVtT0dU?=
 =?utf-8?B?QWZMQUh2VmZhQW9Kd2tpYWdFemJGNkcyNnhrN2tqT0dLaDdXbTUxV1FMV1R6?=
 =?utf-8?B?WGM2STlLVU93YTZzcjZhYk9nck43SG5GL0dVcDF2NHdQWXhNam84RUZ0NjBK?=
 =?utf-8?B?cXlxM3IrUVVISHF0V2YxUzMxcytHbVYrQ2p2cmcxeC90c3UwYWQ3czlqclpM?=
 =?utf-8?B?NTRXa2pENXkxN2VqVFF3eURvNWhyY1B2cDhuQVFIR3V2QmJTRU55TXJUSE9J?=
 =?utf-8?B?MFM4T1p1S1JUV1AzQVZJOHJwUUE5ZmltY0psTTlwNURQeDNsSXVnb2lFWWhY?=
 =?utf-8?B?QXRkOEM0cjNXVitMMFBTU1NYRDBraW1Rc2RSR1kyWGo5WEJ4Z3dEYWgvUlJv?=
 =?utf-8?B?N0l0K0psdDdMbTc0eDUzQ1ZpRVJwTzRsWk5ROWtGd1BIc2laVGhQYXFGdGNx?=
 =?utf-8?B?eDVxYi9tZSt2TkJUTVF1WmFmYnB2Uy9PcGV5WGFBem9rbTdlRmZqMW13OVVY?=
 =?utf-8?B?VUtqTXZaczl0NzY4djdoWUp6d2VXbzVLNkZyb3FiUmk2c2lZL0VVQXFFSXg1?=
 =?utf-8?B?TnBvV1lIK3ZqTGUvSWpRUU5uV04zRHJMSzBTRHE3WnBrWG9yVHNPZHJRUVF6?=
 =?utf-8?B?VnNpWmpickVXWGhCbThnMzl5ZytuTDFTQXMrSkZZb3lMOGNCNC9zQTkvUjZa?=
 =?utf-8?B?VUQ0WDNHeHB4bm82TENqM2NyMEtJVEU3Rm8wTmowVFRuMkRMRFA1ZXJiK3k2?=
 =?utf-8?B?YzYrY0xCRFBHWWVibFdxcThKTTZHUTVVZlUxdXZZQjdNcU45dmcvdGpvMi8w?=
 =?utf-8?B?ajZGcmlucUsyKzBvVTV0WTgyTWZRYjVpbmt1WXNHVEpmdW1ZYnk2UVI3d3Iv?=
 =?utf-8?B?M1gxNUUwWXlWZHlucjV2bUx6eGNLTERLVmprM05mci9uRC9hZE1neTByTDBj?=
 =?utf-8?B?S2kxWGRkMERjc1lYbnBDaWdENWx4QkxYVElkYm02Qm1kc2xMZkRQMmw1QWJO?=
 =?utf-8?B?VUg1MldPempycGxmd0JFSVlmeUZzVHZGelByeGVWSjBZQk5SQS9DdHd2UGMz?=
 =?utf-8?B?ZXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af464fa0-b07e-4890-3405-08dab8a85585
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 05:50:35.6718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +1svW0AjGVSOJHsoMF167HqRapgHfZRPumx+gNAZJz9157tSiG4f57VKQeyg1kmkdPnyILBKcyXtecA+gh/sTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3509
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 28 Oct 2022 05:50:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9883

On 24.10.22 14:27, sven.schultschik@siemens.com wrote:
> From: Sven Schultschik <sven.schultschik@siemens.com>
> 
> provide a recipe to generate the needed binary to start a secure boot qemu with integrated optee and active RPMB replay protected memory emulation within u-boot
> 
> Signed-off-by: Sven Schultschik <sven.schultschik@siemens.com>
> ---
>  .../trusted-firmware-a-qemu-arm64_2.7.0.bb    | 61 +++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 recipes-bsp/trusted-firmware-a/trusted-firmware-a-qemu-arm64_2.7.0.bb
> 
> diff --git a/recipes-bsp/trusted-firmware-a/trusted-firmware-a-qemu-arm64_2.7.0.bb b/recipes-bsp/trusted-firmware-a/trusted-firmware-a-qemu-arm64_2.7.0.bb
> new file mode 100644
> index 000000000..791089a21
> --- /dev/null
> +++ b/recipes-bsp/trusted-firmware-a/trusted-firmware-a-qemu-arm64_2.7.0.bb
> @@ -0,0 +1,61 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2022
> +#
> +# Authors:
> +#  Sven Schultschik <sven.schultschik@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +HOMEPAGE = "https://www.trustedfirmware.org/projects/tf-a/"
> +MAINTAINER = "Sven Schultschik <sven.schultschik@siemens.com>"
> +LICENSE = "BSD-3-Clause"
> +
> +require recipes-bsp/trusted-firmware-a/trusted-firmware-a-custom.inc
> +
> +SRC_URI += " \
> +            git://review.trustedfirmware.org/TF-A/trusted-firmware-a;branch=master;protocol=https;destsuffix=git;rev=v${PV} "

Better pull the release tarball, see e.g.
https://github.com/siemens/meta-iot2050/blob/master/recipes-bsp/optee-os/optee-os-iot2050_3.19.0.bb

BTW, why 2.7.0? Latest is 3.19.

> +
> +S = "${WORKDIR}/git"
> +
> +DEPENDS = "optee-os-${MACHINE} u-boot-qemu-arm64"
> +DEBIAN_BUILD_DEPENDS   += " \
> +    debhelper(>= 11~), \
> +    optee-os-${MACHINE}, \
> +    u-boot-qemu-arm64, \
> +    libssl-dev, "
> +
> +TEEHEADER = "/usr/lib/optee-os/${MACHINE}/tee-header_v2.bin"
> +TEEPAGER = "/usr/lib/optee-os/${MACHINE}/tee-pager_v2.bin"
> +TEEPAGEABLE = "/usr/lib/optee-os/${MACHINE}/tee-pageable_v2.bin"
> +BL33 = "/usr/lib/u-boot/${MACHINE}/u-boot.bin"
> +
> +TF_A_EXTRA_BUILDARGS = "BL32=${TEEHEADER} \
> +        BL32_EXTRA1=${TEEPAGER} \
> +        BL32_EXTRA2=${TEEPAGEABLE} \
> +        BL33=${BL33} \
> +        BL32_RAM_LOCATION=tdram SPD=opteed ${DEBUG} all fip"
> +
> +TF_A_PLATFORM = "qemu"
> +
> +TF_A_BINARIES = "release/bl1.bin release/fip.bin"
> +
> +ISAR_CROSS_COMPILE = "0"

Huh? Wasn't this resolved?

> +
> +do_deploy[dirs] = "${DEPLOY_DIR_IMAGE}"
> +do_deploy() {
> +    dpkg --fsys-tarfile "${WORKDIR}/trusted-firmware-a-${MACHINE}_${PV}_${DISTRO_ARCH}.deb" | \
> +        tar xOf - "./usr/lib/trusted-firmware-a/${MACHINE}/bl1.bin" \
> +        > "${DEPLOY_DIR_IMAGE}/bl1.bin"
> +
> +    dpkg --fsys-tarfile "${WORKDIR}/trusted-firmware-a-${MACHINE}_${PV}_${DISTRO_ARCH}.deb" | \
> +        tar xOf - "./usr/lib/trusted-firmware-a/${MACHINE}/fip.bin" \
> +        > "${DEPLOY_DIR_IMAGE}/fip.bin"
> +
> +    dd if="${DEPLOY_DIR_IMAGE}/bl1.bin" of="${DEPLOY_DIR_IMAGE}/flash.bin" bs=4096 conv=notrunc
> +    dd if="${DEPLOY_DIR_IMAGE}/fip.bin" of="${DEPLOY_DIR_IMAGE}/flash.bin" seek=64 bs=4096 conv=notrunc

Conceptually, it would be nicer to do this construction as part of the
build (rules), package the result and only extract it here for
deployment. Would mean an own rules files, though, therefore not really
simpler.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


