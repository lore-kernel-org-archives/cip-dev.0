Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156A1C6FA8E
	for <webhook@archiver.kernel.org>; Sat,  4 Mar 2023 08:12:34 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.54])
 by mx.groups.io with SMTP id smtpd.web10.5067.1677917551113674991
 for <cip-dev@lists.cip-project.org>;
 Sat, 04 Mar 2023 00:12:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=WjH3Ys4n;
 spf=pass (domain: siemens.com, ip: 40.107.8.54, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=md7WEwORXFs3lH4HAqSOS6CVOQ9ejfIGaQwWA8TjXsZvagT6nkT1j2dRZhctYJfC2qTmYC/uvNGqgv/0tDEbEuuM9u45fc+bJdSby7MHnwCenN0+vDxCwBcnFgnPKYC9Gn49PtdOIcXuwH8T6Cwlk/Fxvpl94PJq26vqVJBAsq9RNM+srXV3I1tLn/uWeJjT0PwYsCHsBEDvhN5+08S8q4gJqTSp92bEqTxAXMDc7W/FeDMkFYddMpbLk3SEd3OzK8foiy2vQecMCDJ4kNWGpiHNxzg3O7kC5F2fVKua+W4PN2/zMQfV11SAqQpqN/Z8SEJyE+XAX1ctJ5Y4bZd51A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wN5jRdnPk4tCcmCPKtjy+Q9J7zhdFabqacw4oxgWSys=;
 b=lB5iIfLdnbhunBHXQsDmK3Hf9S3Y2q+XuBnVFKk0t1E/Jc01aEDTQF9qTTnAvARjjLBsu65vDbn9Yag+53e2AvPJvHo9LQAd9xNxpKNMAJGoOVuWrp8aeSwcqgGxX5GhepA/EECvCBxpt3cB177oAKHJiGKf3vXuOz4ID9WqIUTTFHTowf5hDbOMsG4PrrvcoY5HlHB7EBK9mJ/KwEmLvQt1MZk6HGlTqnNvCb+11zPAwsCbgFUOiKcGKa4lrlQ8/GzelJn7ISTYZiv47FWgDjEcAU3cZ3kUjQG4XkUWwSmHA64nVQ08eILdvkx4NQ2HHWJbLdq+lslJPKYzCKK+hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wN5jRdnPk4tCcmCPKtjy+Q9J7zhdFabqacw4oxgWSys=;
 b=WjH3Ys4nxWgseNZj1qx9xhyCldo2s2lpuSguM3gVzNeDvM5+EdDfRPxAY0goCvtKv3qUbceVzWuc23m+abjsFTWB+u7VkGyx0k09FPkPvreXI+6SHfoTnzhI4+RnD79FULuGCkJ+dM4o0CStLGqyRhoakWUO/NmIfAjdhZ0tb/sy1cR58eqMpaAvJt8l8wHHSmGGdXfLlMVoSVSkTbXs9ur+XAHnMnrZBLInA8kqPo6QrJNHH/x/uQDbyZpb4GnfJXYG4l05eROpTX9u3ngUC+DSr8zhjX7Ok7enlCGx8pC0tadtwMcZ330iMvM4mA7rnENUUJSMfV5w8l+DcMrpGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA4PR10MB5562.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:273::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.6; Sat, 4 Mar
 2023 08:12:28 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2%6]) with mapi id 15.20.6178.007; Sat, 4 Mar 2023
 08:12:28 +0000
Message-ID: <5de62f28-0858-95e8-03f8-013c2ea44600@siemens.com>
Date: Sat, 4 Mar 2023 09:12:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [isar-cip-core][PATCH v4 6/8] add linux 6.1 mainline kernel
Content-Language: en-US
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: daniel.bovensiepen@siemens.com, quirin.gylstorff@siemens.com
References: <20230303124820.2209954-1-felix.moessbauer@siemens.com>
 <20230303124820.2209954-7-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230303124820.2209954-7-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA4PR10MB5562:EE_
X-MS-Office365-Filtering-Correlation-Id: d60a1492-aeb6-4c79-6449-08db1c88319b
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	XeyBi0clhylHqACl4Fz+Fh7lmtLKeZIgNLZfrkh1VuNbGPVorFsCLE3a8p/+AcKdEyVLybIYaG9ilBBfjSAJO41hms/Pd4Ga/8jT9jVji32FgLoP9jUMnjXc+GJbU9HMXNe8mwYYwiqYoDjOymnCdAOUp96mj5surQNMtZbdvfkDBrDovchWgk5sWmO96MY7L13fRw+pWWA9fbjj8J/aoSz8FQ3bzXlviAo29TNCk4SMI8X9VItfFH+BJRUDDWMe6HtQE1902fDHnYESZODG0NPoBBWTDJUpCJdfTiQrx7R5yidpSw2MbdbS+YtLoNg/lOvbcUmb95W4HgAxhQ3bL7XK0gWrPDfB6XY6kdBAP1KyArHhfrNVQcTyMXglXS/tHOg2G1NmjcVA2aQVZto7l9eXFtFWHtmvFkbdJu133TIYKZx5izoqS5iUUv2UgertSNKirAbdB0UBrfbx9kjlROK9M447P5WgkKBbUpPDeu9ziwvbkDxL0GoNzfhhVVZxZg2Rszt2Vr0AqqDXJt843sJZiSBo6eYdoJJChKEZG8HZvjp5B7SEx6v1+7Kzbz1gBG/NPk9X/UvO6/BEaKrExEI4rNxIL3xdh4WhUJO7W6Bh6gD4a4sWtMxabSvZtG5mZsxrHV5XziClk5GULky69ZvEeCxwiY+UomS53avAOll6HUuzyx93A9ZqFQoxxiI3uAfSen8eyGOf1MQ/kf5EKXcaQnFCG4pvIRygcjFl2mQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(451199018)(36756003)(6666004)(107886003)(6486002)(966005)(82960400001)(83380400001)(186003)(6512007)(53546011)(6506007)(26005)(41300700001)(66476007)(66946007)(8676002)(66556008)(4326008)(44832011)(8936002)(2906002)(5660300002)(38100700002)(316002)(86362001)(31696002)(478600001)(31686004)(66899018)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?d3l3V2tQMy9iRGZIcjZJS3NQRkNMYk5BY3kyR2N4VThxL2gvUkJaTEplZng0?=
 =?utf-8?B?YnFZQmJMNTFrbWphcldjMG9jdHdwWnBMKzkwb1UxK1UzblFxT2Vtd2NpL1lq?=
 =?utf-8?B?VnZmaUx4WUsyendGcUFkQkh5VHNVRFp6dS9KMEJHU0hoNWtOVE5acjdHSGhJ?=
 =?utf-8?B?ZzhTRmwvMUxJdnJtMStiZTFYOWJsZUNLYkh1MHZ0c1JhVGhHYXBVVTdDaFdC?=
 =?utf-8?B?d2xPOWhVUmtidlEvckQ0WWh0L3E0SFptMGp1UDhqRStUZVp0WlFOTE9OUTBG?=
 =?utf-8?B?RjBJWG1HT2owalQrUlhBOHZzUkVqVnlVejdGOENwdmU1YVFNbitoR1h3NWZu?=
 =?utf-8?B?bjZBNWJBblhJZUdUQzZmbzZPZUlaREg2VUhaUXB1NHFycng3M0hQT0RTT1Mz?=
 =?utf-8?B?SllGN0w4L1Y4em52cjhJR3ptdFgrRW9TbUtMVTZ5QzFwWVhoWHgzTjZlMHJO?=
 =?utf-8?B?ZDduZnRaK2hpWVM1b0JQbUUxWlQrYk5hcGpPZWVsOTcvb2dETUFRQnRvY2hW?=
 =?utf-8?B?TXBicEhNU3plVmVpaU9VRUFBK0o3eTFSZWN4RUN3QkE1L2s5NWh0VmdDd0sy?=
 =?utf-8?B?aDBBcnFPQzJZRWVJOHkyMUNBQmtZMzZqQVRWVmVHRWpzeVgvWEl4SjlJVUd5?=
 =?utf-8?B?Umd5dkpyNWlJUjRLcWRwQ3p0UFZreDVOaFZmSWN4eW5DWmtwYWs5QjlOakZI?=
 =?utf-8?B?Z1ltN3dxcTI4Z1VZV3I2ckNqNVFEQ2k3TDB3UmI4Z21KS3lRS3lNL3hOWG5M?=
 =?utf-8?B?QkpYYWhTaVIzajhkMEJXTEVGR2w0clpJbVBEUGJ5bGpQY0N5NDhHMm8rQ3h5?=
 =?utf-8?B?TCszNCszUVlRVFN1ZU5idnlIbnBMOXRjSm9FMjJsV0h6d1FySjdhK2pKSnFF?=
 =?utf-8?B?YnlYOEExL3RzVjFtTk9KTnRGaldnRXVJZjgxR2hUUDVSNXREMWNuaUQ0NEVv?=
 =?utf-8?B?amNEOFpHN2d4am1IWTBtZEtvc0daR1YzSE9scW55YVdSbHdya3NXQUdRdjFX?=
 =?utf-8?B?U05ycTJ2RGxMdlA5RWt0MEJnL05xellGVkEyZDI1VDFDY252blJRdFd5Ymwx?=
 =?utf-8?B?bVc0enN0b0wyUU1zV1NuY3VsNkh2enkxa1lqR2xSbHFORG4rOUx4bjcrRS9z?=
 =?utf-8?B?ZENzV3hYOWVxQk5lY3BPS0R4bEw1TzFNSmlLbjVwRHFYYk5GQ1d6ZFN3TmxC?=
 =?utf-8?B?OVZrSzFsaklONllkQnVqNGZ2Y3RRZXM5OVBNeHI5Q3c2cHdiWFgvblQ2TUpZ?=
 =?utf-8?B?K0NaWEczS3IrODJ2NW83Tk9YOHo5aXNRUTVnbktTTitLTEV0bDZ5YzVZeTRL?=
 =?utf-8?B?bDVEcDhyMjBFZ2lDMlB3Y2hsZDVzU1JDaWlIa1BhVGROb3Nta2pNdkxzUnlo?=
 =?utf-8?B?SnZqOHZiNXdDS2RWSENGQ1E2b2NTS0xVbXg2WjJDa2lkOVlMTDcvNk1vb2pR?=
 =?utf-8?B?WXp2SHU3dkdweG4wcnh3dHdEMEUvcm5xc0tud3hJSjh3NnNib2NPTzNiM0R2?=
 =?utf-8?B?NFgzUGlSWkVNdGFxVFIySzdYS25PL05ralFrQU9LSW45SjJtWUxURVRSbzZY?=
 =?utf-8?B?a0tTUk1LVythNE0wa3JIc09sRmNxSWlzV3BIdjdpRFY1Uk1BTGFTayt3KzBQ?=
 =?utf-8?B?Qy82eWQrZ3BFOHArK2ZFTmNZZnEvL01zQjdjbVRDZG9SeVJ0aWtjSUhtMk5C?=
 =?utf-8?B?MFVQWFUwZG5XTGRjSE56eWkvMklNdDQxajQ0UDQycUMyaHozem15M3Rlb083?=
 =?utf-8?B?MUpZd1BoYkw5c2ROblZJaXBtTFFKMmlvZSs1STFRYUh3SDRhLzZmOXB2cnky?=
 =?utf-8?B?TWVNeE5lakVUMnQ3MDgzS25tNzBDQ0srZXJId0FSaWp1RWZCQ29QNnpWcnFD?=
 =?utf-8?B?c3E3K1JoMVFLWVc3N25rZVRIWFl6ZWtoVTNFWmwxMW1vb3lteldreElqOUJE?=
 =?utf-8?B?L0d4b0NVYkRNZjlOaEJOZTBVazZpcjVGYW0zMkc0VTFkRWdHY3JCSHR3N0Z1?=
 =?utf-8?B?aEV3dnlUUU9ZeVFYQkpaaGxWZzRjSnRSMERyRkF1OGlPb3ZQdmZ1OGRiWTJZ?=
 =?utf-8?B?cGkvSHA2ZHowV2RNYVZLczNySVpXUDVobytCVmM2QUdyOFpsMjNNU1pzL2F0?=
 =?utf-8?B?RGt6eS96Q28xMFJoY1RVSVNxM2dZVWFvY1UzRVFMZWsvWkFhOVNWYkpRcGl1?=
 =?utf-8?B?TUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d60a1492-aeb6-4c79-6449-08db1c88319b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2023 08:12:27.8484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gmIEEEAJwYu6/euzID3B6jmpSG3N7EpxYTTUXpTrBGo23EnM/gaBqM6B0/5yp2UkOppyFK3FuDoOEuojY573Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5562
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 04 Mar 2023 08:12:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10928

On 03.03.23 13:48, Felix Moessbauer wrote:
> This patch adds the vanilla 6.1 linux kernel for testing and for boards
> which need a more recent kernel than what CIP can offer.
> The kernel can be selected from the menu, similar to the other kernels.
> As defconfig, we always use the kernels internal configuration, because
> there is no cip-kernel-config for that version yet. In addition, the
> squashfs knob is selected to support the swupdate pattern without any
> modifications.
> 
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
>  Kconfig                                    |  4 ++++
>  kas/opt/6.1-mainline.yml                   | 18 ++++++++++++++++++
>  recipes-kernel/linux/files/squashfs.cfg    |  1 +
>  recipes-kernel/linux/linux-mainline_6.1.bb | 18 ++++++++++++++++++
>  4 files changed, 41 insertions(+)
>  create mode 100644 kas/opt/6.1-mainline.yml
>  create mode 100644 recipes-kernel/linux/files/squashfs.cfg
>  create mode 100644 recipes-kernel/linux/linux-mainline_6.1.bb
> 
> diff --git a/Kconfig b/Kconfig
> index cd24ce2..a932bbe 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -97,6 +97,9 @@ config KERNEL_4_19
>  config KERNEL_5_10
>  	bool "Kernel 5.10.x-cip"
>  
> +config KERNEL_6_1_MAINLINE
> +	bool "Kernel 6.1.x-mainline"
> +
>  endchoice
>  
>  config KAS_INCLUDE_KERNEL
> @@ -104,6 +107,7 @@ config KAS_INCLUDE_KERNEL
>  	default "kas/opt/4.4.yml" if KERNEL_4_4
>  	default "kas/opt/4.19.yml" if KERNEL_4_19
>  	default "kas/opt/5.10.yml" if KERNEL_5_10
> +	default "kas/opt/6.1-mainline.yml" if KERNEL_6_1_MAINLINE
>  
>  config KERNEL_RT
>  	bool "Real-time CIP kernel"
> diff --git a/kas/opt/6.1-mainline.yml b/kas/opt/6.1-mainline.yml
> new file mode 100644
> index 0000000..84d12b0
> --- /dev/null
> +++ b/kas/opt/6.1-mainline.yml
> @@ -0,0 +1,18 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2023
> +#
> +# Authors:
> +#  Felix Moessbauer <felix.moessbauer@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +header:
> +  version: 12
> +
> +local_conf_header:
> +  kernel-version: |
> +    KERNEL_DEFCONFIG = ""
> +    KERNEL_NAME = "mainline"
> diff --git a/recipes-kernel/linux/files/squashfs.cfg b/recipes-kernel/linux/files/squashfs.cfg
> new file mode 100644
> index 0000000..7a89d00
> --- /dev/null
> +++ b/recipes-kernel/linux/files/squashfs.cfg
> @@ -0,0 +1 @@
> +CONFIG_SQUASHFS=y
> diff --git a/recipes-kernel/linux/linux-mainline_6.1.bb b/recipes-kernel/linux/linux-mainline_6.1.bb
> new file mode 100644
> index 0000000..8a879a0
> --- /dev/null
> +++ b/recipes-kernel/linux/linux-mainline_6.1.bb
> @@ -0,0 +1,18 @@
> +# Example recipe for building the mainline kernel
> +#
> +# This software is a part of ISAR.
> +# Copyright (c) Siemens AG, 2018-2020
> +#
> +# SPDX-License-Identifier: MIT
> +
> +require recipes-kernel/linux/linux-custom.inc
> +
> +ARCHIVE_VERSION = "${@ d.getVar('PV')[:-2] if d.getVar('PV').endswith('.0') else d.getVar('PV') }"
> +
> +SRC_URI += " \
> +    https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-${ARCHIVE_VERSION}.tar.xz \
> +    file://squashfs.cfg"
> +
> +SRC_URI[sha256sum] = "2ca1f17051a430f6fed1196e4952717507171acfd97d96577212502703b25deb"
> +
> +S = "${WORKDIR}/linux-${ARCHIVE_VERSION}"

This is still the outdated 6.1 base releasing. Fixing on merge.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


