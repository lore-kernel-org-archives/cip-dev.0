Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB14C64EC4
	for <webhook@archiver.kernel.org>; Fri,  3 Mar 2023 07:19:14 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.76])
 by mx.groups.io with SMTP id smtpd.web11.18144.1677827950166758263
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Mar 2023 23:19:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Y7Oufrqr;
 spf=pass (domain: siemens.com, ip: 40.107.20.76, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aq2+v25HOfcIatTmvQ/jsPaDV+drme1x8m5GG0V2HPEKMr9QYNIIsIr+kCInTUKOad7zwwtK0TmiX7+SMHI+1S41DdDe9ADhUlrz7pgs7CNPkM9svbp/mjX+fKFLZ8+ej3C/TNyABWcbu+bkdJIUH4jbvaPizoPwac7RXZstbTDTDIWb88Z7yB15LSY7RQV4lBJoTXzfU9jDfpt6QuQwQoWVyYDzdRtUvxEQzE3SDyUuRPeLpPx+xcQ7QC8FzZ6GfzZWXVKIt1eaZY37+cywLCkcjdLENFbCnGC4E6GtCO0qK/jglT976nRcf2bntnj6m6RgFwCEIRJTqH0X1y7bTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M0aTcMKRsTfDDKWDGj85SbKCwJnpazBYr1bN1qpJySM=;
 b=CGYlCyghZ7thUtH70ouN7+jOR/DUdQDexK+bVMFVfLaT7Gtn/WwtM5I2gRD1sInW6Te+qVuAE8PrqZ4A+g90JBYnD9OQOq5ngMUx0k6fExTAq8GmNVmh6DQpjBsKcAALgM4buObORZIHcRTns4YT+/FkxSqOw2ac47X0rOO502Bqqk77B38nm2nzCOuO+XWQjeZ/ZYHrbuZE+qV5fOnNWi3i0Ml0mKXVgfzjSHSstOgGVjzEj1TZMkh00XwSRgLdgTsNC64WCqlBVnvtTE7ZDVB29OLPnOY+qaihPBePWmDFe0rErIgwis88coPsASuXbWPOPWwT/M0JeD9O/pL26w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0aTcMKRsTfDDKWDGj85SbKCwJnpazBYr1bN1qpJySM=;
 b=Y7Oufrqrv7sLMD3Ej7uLLol8qXR2t59BcAQoM+uD0yIa1kpQNfQgR3BihycHGzRMH71WzBUhHKYcKYMOfoWUigHqn0V6Dj6VTKobhFmN7QcNqIy/im2HRvsHhpVorC4bTpbJpAp6C+ogsi/8+qRJDKztbA0zrzC5sG60Kiv9mXkC1SgCLe/HN7LBaivEuwNDyNqDzzqntEkx4IomVBrOCtG5STV7OI818k+J/uGXlfrW+0ASoxL9rTQeZ95CQVsVEIz0Uzee+kx77IvqE9ul0ofh1dww/yHWcNm7ZJuctCypykmfODtABH6o5cmiUaY9GK1M65OvW0yq/3qrtgWtUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU2PR10MB7833.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:46c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.8; Fri, 3 Mar
 2023 07:19:07 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2%6]) with mapi id 15.20.6178.007; Fri, 3 Mar 2023
 07:19:07 +0000
Message-ID: <d75f99a2-c08a-c309-e2f9-b013c2a25af2@siemens.com>
Date: Fri, 3 Mar 2023 08:19:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [isar-cip-core][PATCH v3 7/9] add linux 6.1 mainline kernel
Content-Language: en-US
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: daniel.bovensiepen@siemens.com, quirin.gylstorff@siemens.com
References: <20230302152659.2096307-1-felix.moessbauer@siemens.com>
 <20230302152659.2096307-8-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230302152659.2096307-8-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0010.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU2PR10MB7833:EE_
X-MS-Office365-Filtering-Correlation-Id: 1881af0e-8557-40f5-8a00-08db1bb7937d
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	wamb3+Dw7QS1QfUPWsBWrbLu2bnXqR1IFj6d+u5PMs21aQNUHfRKMxHKZ7Z8xxrn/6lfKucOVMM2aMY/GXc1TDW4NodAAzk7WZ4ZV509+1SeYN46emA6hHdD0zcRqS/ibBLONEtO1sdJJFoum06vpZgU1U0IGY7c37xDuSwqPhZuJhW4qReFoqFwNFzr21gmzPfxAyX1SzwxUcx2KtshmGqLbIs1rEn5b9a3flYPRKvIe08cG5bmVE2iwztuSBm3hcoXi3CXsp/VRLjJ4KFfq/vW/xB1r+7UzEWmQKP4QXuUbXQGEU2F7bRx7nSokaRB1LvSYvZ/+OqZn7/uk3xP+HUBUvSRQW4vP+6tx0QR6IN4yGjJS0n4iNEemWmkupwIXRHEumI33R+0tLQDQ0w5yPHvw94EyNSiH8Q/oCdvVbGmGIWRF20C8px8QR+0vomNN6UvELWHpdRa4ysnLI0sqnqzpOUD53c2NiuM9Po39DKMZtnCjC+BT37MUapt15VExAVA1grE1ghrG6ilfnWFyuIVQ7JS87/kok1oW3BdOpF7clxZNi3zz/hbrYINFodPw9UxnVofVfLDxfwfKLLuNnsH7FegSpuopOgUZUnOsvdmkLfrVHIaMZumWGm4qwr2Ul7A9CTb6FzssAFfCCJ1wY9qhT0dopaO8T9IaPA9hmKmvArwH8B4wqEfKpvhamOBg28Tw/OlWGH7oBqAY75weaKgbPxbs6IoM31n24nnF/8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(451199018)(31686004)(66899018)(83380400001)(6666004)(107886003)(478600001)(36756003)(316002)(82960400001)(2616005)(6512007)(6506007)(41300700001)(5660300002)(186003)(38100700002)(53546011)(6486002)(26005)(966005)(86362001)(66946007)(44832011)(66476007)(66556008)(8936002)(8676002)(31696002)(2906002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?R3RHZmxXSGk3OXlZRjlOZVA3ZUVuQzZVaE0ydFI1aW5SME5QZllKVWludkgz?=
 =?utf-8?B?a3M5dzBYV3hVY1JCbHF3bUhCOVZqVnNONzJnNzZzL3ZDczlaRE9XeHFja2dT?=
 =?utf-8?B?Njg0Q0cwOHRucXZHaDJtTDlGK2lsNEZFVXFyQW52NG02VDdqRDZrTTlxeU9w?=
 =?utf-8?B?MjF3aXhIR0VoQlQwcW1rTHJ6RkVHZlBScDk3NnY2ejFXTmRiMnU2eDQ2SVVW?=
 =?utf-8?B?eWhQL3BCSzc2amFCczNNRTVZaythaDFHSlJlUm1pa1hFR0x5TlJ4c1pESVV5?=
 =?utf-8?B?Z1pIeGgxNTlqSnpNbEpwVUNwTldjdjFBQXNuNkNqYVVYcWJtS1pIU1VpR0NI?=
 =?utf-8?B?Z2hPdFBhZ2srWXJtUktKUTl5RnJMcTlsRjFSYXI2V01VNEkxeHVYd1E4Qm1Q?=
 =?utf-8?B?VXRFR2tOb2hYcitjcW5kQkhLaTFmVXpZTElsTXN3OGhJSDhWdFpyZFM3RGVU?=
 =?utf-8?B?QWxPYkhtdDRoZnVyNDlwMEZ5MW5sbWhRbE54UmZ2VG9GcCtqdUF1b3JLR3FR?=
 =?utf-8?B?TzFUTDYzd2xuQnJsN05wTXRnT0cydlBKanBVcms1clpmSkgxdG00WnZVOEti?=
 =?utf-8?B?cThyampaSW5SSjFHdFM0ZHRIZUhBaDNodW1wQTRBK2xBUWJ0MFEweEFOM2tC?=
 =?utf-8?B?dWlWYmE0L1g3dGpQYzYrOGpmUEp4U2ZmZ1dNUVQ0NTFZYll5UkRtdGVXdlY2?=
 =?utf-8?B?MkJQMVFROUhDTzRja0MxRWhOeUo0V2hnTjRNRWp1T3IvdFZMZFRTQk8ybm5M?=
 =?utf-8?B?amhVUEV3VExaWFNoOVFQOXBkOHM2TmhQa21sQ2V1N3ozd1owaXJWOURiY2lU?=
 =?utf-8?B?N1dsQkNKTDdqNE9EcFBic0VvYkdkbE5lWThTK2h3YXVNT2xPMlk5QnhNa3BJ?=
 =?utf-8?B?a1VWSFc1TTJncW1nUUJHTDV5QWplVzN4Zm1Rbnd5TlVhYlEzbCtEcSt1WkUz?=
 =?utf-8?B?R0NodU8wdjRxa213bmhWcWpLZzVVK3RtWDVUOU1Nd2RyT2hNek10UEY5SjQ1?=
 =?utf-8?B?U3k0bm80RXZoRXhHUC9qcGJSRitlbGxpY2hpdmIwYjNRSmhWVXI4TEtaTysy?=
 =?utf-8?B?dDNJdnlHMmFEM2xNTWpkcXY3ei9IcUZJaVBCY1U4bHdzbHZnN1JKWHZFNFdC?=
 =?utf-8?B?RHEvNnJwREF0bk9VSjlON2FMblhNOW5ZY2lGaDc4bmM0US9UaS93S09maW5j?=
 =?utf-8?B?NFRUSy8xd0RQZmJ0a0xQYXIvdlNmU0V0c1VxQk5VMUZ6SWVWanh1UTk2eE9h?=
 =?utf-8?B?SnM5ejIwK0tMMDdHSmZTRWZyUDYvT2ZabHlHZTQ0UU45N04wTy9KTGRybWk4?=
 =?utf-8?B?Z1pUOFd5ZGdoQVptUEJKdmZFa2tnVzU2S1IzMTJzVVJpc1ZoeWUwVnVVazNE?=
 =?utf-8?B?QW15Mm54TW11Z1QwQzgzcGtIU3AzdFJMazU2eWgvMTNTeEg2MGdHbjVIRGpy?=
 =?utf-8?B?bWlEQWMvUXN6NWYrVXZtanRQb2lzUkNTdzB2ZFJBY0hzUW12blkyWEx1VWc3?=
 =?utf-8?B?UkdEdjBPdEVTMWhTa1Y5S2dCNHdSZmpVRFRFU0x1ajIyNk83UkN5NUYrRmMz?=
 =?utf-8?B?WHVxYmp1Myt0Rk5pR0J1ZnhpdFRydDFyY1FYbGNqMmpEN3RneWlZVit4Mmp4?=
 =?utf-8?B?YkZ0eTkrd2VQVk9xYVdvenpSSWNlTXk2VU9SbndjRzI1T29hVDZNT0lZYXRE?=
 =?utf-8?B?Rm1vd3ZaMGZub2laUXA5djZmSmZsY21MdDJWaEN4aW5DN1I4eWU1M2RRbFdp?=
 =?utf-8?B?K3UzbHVWdnVvZG9BL1NvVVB1a2NDSTRpM0o3Wmoxc2dBNWgvaVBzSXBycUY3?=
 =?utf-8?B?aElXdjA2aGd3ZG1zUEtsdWZNalh0WCt1MnE1MkJsNVVtSnM3Y25YemdoTVdQ?=
 =?utf-8?B?TzBrVGxWS3NSYVRyRThZTklTUU5QMmpjNlA2TFhXZytqQVpyNURjb0gxcTJj?=
 =?utf-8?B?dUtqTjlOVnZDS2JwY0VCY3hiTVplMGRvbjNGa2xOSTVRVUFGVUduTFptT01y?=
 =?utf-8?B?YjQxOVJSemR4bjllaS8yMnc0cHRzRGdrcHVHT04wL2pxVW5YVmEyVUlHdFpW?=
 =?utf-8?B?S1hsUHEzQ2FxWlhsN0RScEtLemk3NGFpOTlJZmpyWm1FM29FVFlvZGRPeldQ?=
 =?utf-8?B?YmRnWm54UUxwRXRpTm5rYlBvNVFpdVd1aDZ2WEVsTzRWQ0ZYSVMyWjJCVFBr?=
 =?utf-8?B?b2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1881af0e-8557-40f5-8a00-08db1bb7937d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 07:19:07.1762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +DfztcCKNu2Lw9ZD85cvGJ/YOD2xbImz12yWCmztJ6SyctRj06sN8+nd3a6hCVD/rywaZdIzTCfW574euArlHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7833
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Mar 2023 07:19:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10893

On 02.03.23 16:26, Felix Moessbauer wrote:
> This patch adds the vanilla 6.1 linux kernel for testing and for boards
> which need a more recent kernel than what CIP can offer.
> The kernel can be selected from the menu, similar to the other kernels.
> As defconfig, we always use the kernels internal configuration, because
> there is no cip-kernel-config for that version yet. In addition, the
> squashfs knob is selected to support the swupdate pattern without any
> modifications.

We just decided in CIP to start 6.1-cip development, so we could also
start filling cip-kernel-config with related 6.1 entries, already
including additional knobs we need. Actually, I suspect you could add
squashfs to the 5.10 riscv defconfig and use that for now, avoiding the
snippet here.

And once a 6.1-cip kernel branch exist, we should switch this recipe over.

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

Please use at least an up-to-date version, ie. 6.1.14.

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

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


