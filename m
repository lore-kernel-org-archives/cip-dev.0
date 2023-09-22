Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4427E6FE39
	for <webhook@archiver.kernel.org>; Fri, 22 Sep 2023 14:26:37 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.48])
 by mx.groups.io with SMTP id smtpd.web11.23072.1695392794481371518
 for <cip-dev@lists.cip-project.org>;
 Fri, 22 Sep 2023 07:26:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=OFDPhCyz;
 spf=pass (domain: siemens.com, ip: 40.107.247.48, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TLr14LGEKHikBMj0qUfkl7xQVhdhbS8sEG6zm52072Wuoaqy3HH6YQYL8+ygWMfZ53CcGZnGPc6YewbQ6gkx7GzuJpINx3WyvVuzEq7wgFgmVaroWZ/yC44B4KiWs8QXjqq38b5MDQWpUtccltoXrSBSWzeVZ+qLEK4p8baUNvIRRtM9X8o9JPyulVyaUEKVjPmhaGHvSwr8IlGZNZPAcby5QU9jI55WeoUwDGmkuZLm/Uh0BGHgo2ryzFITGCg6kSeh9dxdQnxGc/JXPoQMzD+v9cdqH4yLe33XQFAvSpadBeG14HEXKSzfelTlzkZIRYMAVTsp7Ena78k6CSOmyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNvMlq5uWFiTZmJ9rOa7k4Yq6yuOTSKGDOfOM6QgK9M=;
 b=NVNLRpANOActeMBxatjDi5B1miViASQFh8CN0frUiXv+zbVImXdryGm37jr08fEpa/jZTuUgUnKGh8P8hj34O/dAFaitjjyMhDxUQYeCC7ZxUq0DSvmQSCCU8hsdhChfzbVIh461OkmOXmXIhE2i73L3JqEuTbq5LGDSg0lBL3o4lM369fCU0/cw4vqBTGuzWUb1rGBwF6lmr21abJGMGByxQDYykWj5yjPVaiLEngHWmTzKL78vz8qgYY5jyo5IplpQRrMU+MGrd2HU7jNNb1zHBevUHlbTbWw36Is7RxZvkapYxlNGsJtyzYG9bDkyOW1BWoeARM6NrAaK1fzIsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNvMlq5uWFiTZmJ9rOa7k4Yq6yuOTSKGDOfOM6QgK9M=;
 b=OFDPhCyz4R4PP71KLL+RKnmjDtzly1pkPvt2UUMs931kU/HAa7F+YtQQs70xrkBf6t71cteUS9ZGsGzFUrvDD8TixBRlGu53K3PlTQodL7olrr9k7zL3GAlwlNbi7DAg8XFgBBwvhZaLskP6PJdiQk+oettr25cFhR+uFdOEbr9hhOtJuGIo/H6/Mi71E6NQ5u/Cwt+Qst3FbKx1+O3/1QrJNXPzPMfCPQBFXEHaNNqHFltHo1djUNN2p2pPGCbq65DX8Dm5KE96b9msosJJk4WdH9rhIri+TN8afvFgalc40HFgQQROGGCKzeUPEHBmNnB8bVKDmB4kEszfM9qwwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6179.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3ea::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Fri, 22 Sep
 2023 14:26:31 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 14:26:31 +0000
Message-ID: <5a7868c2-edd4-488f-81c2-3bd94944c7ab@siemens.com>
Date: Fri, 22 Sep 2023 16:26:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core] dosfstools: Add recipe to build it locally
Content-Language: en-US
To: venkata.pyla@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20230922101245.3219-1-venkata.pyla@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230922101245.3219-1-venkata.pyla@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0018.namprd18.prod.outlook.com
 (2603:10b6:610:4f::28) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6179:EE_
X-MS-Office365-Filtering-Correlation-Id: 19e5a088-c764-4cd6-8a6a-08dbbb77e955
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Y1IAJujEtaCWMSAfiqEGKBfejzATQxKy4MQOa7zDOuLE/m7aAwgOhX0eygcsYzTt9Figc4C7GbT+ZTrZ4ituVEBdKKJKFlpzA1ZXqEYZg/9mhxnGpBKA+5j567Iy9lvhMUUAQ3txh4CcXCffuHO1szf0qOKRs3t6crWAIhF27LsjSe150e5QjuAOlobFhq4FjAAt2+9SxsycN4xc0uq6mDs362beeCHwN3x7a2UwyCbzqn9Yjt5JfjFGqVr0LyCPeYuX/m1XAkHzz6whXiGOY0wGZ9jehJrY1jbc4KFnUfv3pUGHZo07rcFenHGhvcma+dAPQ9ES1pQbQPZzIuuXZ54DNz/y0HE7P4fGBLtWot0qt+XqjxV9190CtCIPpwW7O9Ogq0xL2JPFSDj6s9/BxVB0ljrT/E0NcasL1iLnDUxGmNt9BtA75VbSTGU8dS5u/02vJxmOQIkQYLVL2bb7fZ7Bxuc3WKB79NnZLOZ2sMOws9B+ZKjaAaotwvVNqIgXFNEwRC+dn4T1vK/uT07c89XAJS/c0HMTrxpmrlZscCoEMUN7CWWh3xaWHtyemMB8p7ELJbSI0LOXsaedmVAHTrvpuvkPc+aFiODZjblMDGC/RiDjTrF5LoSR6ZEkl68w7vzycRh9g897w8OKSD3niJnSLYdgDOOMIbgtyvjgt76+OCHclWPgiIdBxYaQ9O1y/z8Pk0V951+ZBmAKpB5XpnEnFj84zT/4YO3+kRAQriA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(396003)(376002)(346002)(451199024)(186009)(1800799009)(31686004)(6506007)(6486002)(53546011)(38100700002)(36756003)(86362001)(31696002)(82960400001)(26005)(2906002)(8676002)(478600001)(6512007)(6666004)(966005)(83380400001)(2616005)(8936002)(5660300002)(41300700001)(44832011)(66556008)(4326008)(66476007)(66946007)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZEt3dUpYcC9kb2hMeFB3VXZPVnFaQlhWQUJmZm5OemdqU3ArUzRKQkxLdmdN?=
 =?utf-8?B?bzIxUXJUMXB4R0cyUFk0V2pBSjJSSjB5K1FsZ1FlempYdnk0L0hUOWpCZXJM?=
 =?utf-8?B?UitJV21HdU0vR2hNcHVmM1ZwRFFhQVgrZ1ZSd3ZVaUtpdzFndzJQRUE4YVRh?=
 =?utf-8?B?OHhIbWZjeDlLYUpRaEd1V0ZZQmgrQzJVNndsSWg5UEF4R3prREh1M1A5ZTRw?=
 =?utf-8?B?eVJ4NnFtb3VMRm9XVlVRMkFTY1pjTjVNemFucXdtcml4RGV1WmZJdFB3cGJJ?=
 =?utf-8?B?c08xaWFZZjI5Rkg5emllaEVIcXk0aG1kYzh1Q20rSEEzZGdYWi9PSUxrUXhz?=
 =?utf-8?B?SXlOMlBpVENpVTNuMFc1cHR1YjRGeDRjQ3MvMFdJODRuQ00xeUtvaEs5eEN2?=
 =?utf-8?B?alltSENnRXgyR0NhMTVxZVhjSXpOSFVxK25FRmZxOVlBbTdLZ05PYUQzTUxX?=
 =?utf-8?B?V1UrZWwrMEYwUkh2MW9CUytmK1JhYnVJRUdvUGNYdzJyWnlUS2F4cFl2SWtI?=
 =?utf-8?B?UWQzSyt3TEhvenhsRWswdHZDY3lCeVlSMkxJNlArOWM5eXpJbC9JWGpUS2VR?=
 =?utf-8?B?WUdRODBsbm1vOWhoME1Db0oxVDFLRlRTWTNyZjVOZ0NWaCsrR016NkNKK2VE?=
 =?utf-8?B?YmduTE9PNTg2S2EyeURVUHdGS2YzOTBOWis2MU9NSnpPLzQ1em5YYzkxRmV4?=
 =?utf-8?B?aFVCQ0l3a1kzVC9CMzRqbFVQb29hc3pJUGNRQmc5VW9JeC80NEZXL2FQcDhv?=
 =?utf-8?B?aEZFVVR2OVJxVU1aRUs3NWJLVzQ2VWhvb0dCQURBTUsxR1pWbEZKbktzb3VZ?=
 =?utf-8?B?RVdIRlExR2xMbGxOVTc1V2liMHNBeHVJQmhpSmE2M3pvS0tXRUZDWmJJUTJN?=
 =?utf-8?B?SXFISG14Q0JaR2wrSW9OeGpmazl0c2kxbzVpVEJKY1ZTU016bEpQb3d1TEJO?=
 =?utf-8?B?Vkd0VW91QWJ0RVB6NmFmcmRpL3NCY0VpNmxMMm1hTkk2S2d0eERtWkp4S0lB?=
 =?utf-8?B?N29IWWJnWnZqa0V5ZzJBSVpEcXdUaGQ5dWwydmhCU2xsRDFaQVhnbHlkdUJD?=
 =?utf-8?B?dHNDbmNHRjM4SjlzQ1pyS2FpRmVhdW0ydmFaV0pmOHoybld4M1V3Z1g1ZG1G?=
 =?utf-8?B?aWxDcnAvODBEWVVkaFNDNHNCV1pseDBjYnV3dTlnemhSUDJ5Y1JUTzdyMGxD?=
 =?utf-8?B?WHg3R0I3dExkWGpHTkxKNDRNSUo1SmtsRmlHTEhDTWE4R25aa2JiUnRHQlFD?=
 =?utf-8?B?eDJaM2U5NmdnY0tEZ1pVQ3ZYazB4dFNjU1J4SlJvajc4WTZEMnBOcytyVUJX?=
 =?utf-8?B?L09qRTVNWm9oOUJZVDBNODFQT0dTcjU5eXJzS3d3WGx1a3AzdldrT25NZlh6?=
 =?utf-8?B?NEt2VHJnVE55Q3ZhS0I0TDlhcllpL0lLbm1NQ2JBL3dMNzhhak1OdFk0ZEF5?=
 =?utf-8?B?eEJld2ZVdGhtYU1aRG4rUWcrRW9vM01YR0VkRWNQVXJkOGxFYnh1VGY3elN1?=
 =?utf-8?B?OW1oUGhpTU9DNmh6Rk9GMVFvSFhNMnE3UlVqOHoxRVo4SXBmQloyc3NRbVVP?=
 =?utf-8?B?R3dNZkVIejZwbHFlaCtqL3dqMDdsRWFmaTZUcjBOcEJrdUpXVFlFSmpIcnVw?=
 =?utf-8?B?R3hVMDlYVFNXMDU2SHBFWU4zdWVkb09DcHJrM3pvdDNNRkp0VmV1aTA1Y2g1?=
 =?utf-8?B?QkIybkRIdFVKd3dta3pxWURSRzN2S3NUaldmRjNBLzNTWm1XaGtHM1FBc1FH?=
 =?utf-8?B?clF1LzQvaWhjazVVZDRTQ2lDWlpVVUc0MmhHVTY0QWZDV3BueXlkTlRWUUNG?=
 =?utf-8?B?TkZjckl5TjJ2bWhZUjRYU2tQTVdRRlJhZEM2T0JUME1vVFI1L2NyUmFrb0Nu?=
 =?utf-8?B?UWRibWpZajVTTjZoL0pRSyt3MkJacktyNEhpVjNBUXVtUXZ3aFBaSTMzU0l4?=
 =?utf-8?B?Rm0yWElNSHllbTEvVm40VTBkSWs1SEVPNEJPbkdiYnh5UzY5R0g3bWVuMEg0?=
 =?utf-8?B?dDBUQm5rT2pyUGQrZ3J4d0JpVHNOaFd2c3dWTmVqSGJoTU5hRkl2eEJpcUpk?=
 =?utf-8?B?SGhCTmxMMWxRb1FpR3BmYmxlS00zOWlUUjJnUDRWelFnY3JKeXFiMU5kcTdE?=
 =?utf-8?B?U0UvYW90dlYzeUJXRjdVUEpDd2NSM3JweWlPZTJPeHdSQmtsR2tSSUZSdHFw?=
 =?utf-8?B?RlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19e5a088-c764-4cd6-8a6a-08dbbb77e955
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 14:26:29.4737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: niRGRK10Sg37iN3yKpYFEIB6KaUpBESHeIy74IIPzde1VMraht6tH3v/tjjoCrdLtbzDXxByMRS3lRGg/4BxMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6179
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 22 Sep 2023 14:26:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13210

On 22.09.23 12:12, venkata.pyla@toshiba-tsip.com wrote:
> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
> 
> mkdosfs doesn't generate fat file-systems reproducibly, due to the
> reason that the utility mkfs.fat is not honoring the variable
> SOURCE_DATE_EPOCH and including build time stamps in the file system
> headers, this issue has been fixed in upstream master branch but not
> release yet, so building it locally with the patch.
> 
> This local build can be dropped when this patch[1] is available in
> Debian releases, this ticket [2] monitors for creating release with
> this patch.
> 
> [1] https://github.com/dosfstools/dosfstools/commit/8da7bc93315cb0c32ad868f17808468b81fa76ec
> [2] https://github.com/dosfstools/dosfstools/issues/179
> 
> Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
> ---
>  kas/opt/reproducible.yml                      |   1 +
>  .../dosfstools/dosfstools_4.2-1.bb            |  17 ++
>  ...ream-fix-for-honoring-SOURCE_DATE_EP.patch | 189 ++++++++++++++++++
>  3 files changed, 207 insertions(+)
>  create mode 100644 recipes-devtools/dosfstools/dosfstools_4.2-1.bb
>  create mode 100644 recipes-devtools/dosfstools/files/0001-patches-Add-upstream-fix-for-honoring-SOURCE_DATE_EP.patch
> 
> diff --git a/kas/opt/reproducible.yml b/kas/opt/reproducible.yml
> index 9b56b28..fada232 100644
> --- a/kas/opt/reproducible.yml
> +++ b/kas/opt/reproducible.yml
> @@ -15,3 +15,4 @@ local_conf_header:
>    reproducible-builds: |
>      SOURCE_DATE_EPOCH := "${@bb.process.run("git -C ${LAYERDIR_cip-core} log -1 --pretty=%ct | tr -d '\n'")[0]}"
>      WIC_DEPLOY_PARTITIONS = "1"
> +    IMAGER_BUILD_DEPS += "dosfstools"

This will lead to funny effects when also the image requests dosfstools
and HOST_ARCH, thus PACKAGE_ARCH == DISTRO_ARCH: If the package is built
early enough, the target image will get our custom version. If it is
built "too late", the distro version is used. All that would be
non-reproducible.

I would recommend to declare dosfstools also as dependency of our images 
(DEPENDS, not IMAGE_INSTALL).

> diff --git a/recipes-devtools/dosfstools/dosfstools_4.2-1.bb b/recipes-devtools/dosfstools/dosfstools_4.2-1.bb
> new file mode 100644
> index 0000000..009d99d
> --- /dev/null
> +++ b/recipes-devtools/dosfstools/dosfstools_4.2-1.bb
> @@ -0,0 +1,17 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Toshiba Corporation 2023
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +inherit dpkg-gbp
> +
> +SRC_URI = "git://salsa.debian.org/debian/dosfstools.git;protocol=https;branch=master"
> +SRC_URI += "file://0001-patches-Add-upstream-fix-for-honoring-SOURCE_DATE_EP.patch"
> +SRCREV = "f59f4850586e88c945a922f5f9cc48b5da6c54fa"
> +
> +# this is a host tool
> +PACKAGE_ARCH = "${HOST_ARCH}"
> +

Let's try to ride Debian updates:

[recipes-devtools/dosfstools/dosfstools_latest.bb]
...

inherit dpkg

CHANGELOG_V="<orig-version>+siemens"

SRC_URI = "apt://${PN}"
SRC_URI += "file://0001-Honor-the-SOURCE_DATE_EPOCH-variable.patch;apply=no"

# this is a host tool
PACKAGE_ARCH = "${HOST_ARCH}"

do_prepare_build() {
	deb_add_changelog

	cd ${S}
	quilt import ${WORKDIR}/*.patch
	quilt push -a
}


That patch file is now the upstream patch, not the patch-adding patch.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


