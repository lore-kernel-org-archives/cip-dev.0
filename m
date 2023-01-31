Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720D4C38142
	for <webhook@archiver.kernel.org>; Tue, 31 Jan 2023 10:55:03 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.85])
 by mx.groups.io with SMTP id smtpd.web10.9190.1675162495238021323
 for <cip-dev@lists.cip-project.org>;
 Tue, 31 Jan 2023 02:54:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=MKDxp9kp;
 spf=pass (domain: siemens.com, ip: 40.107.21.85, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=APY5O0aGBLN+wo/zr2TFoiodrXLfsvQxf/LWU7Pe4Rw+HtTvOuW6bUMOwlPCPTZ6B6QFUGh79Ovu+twkfu/1dgMX2IrAyP2yMfvj04WcryrvlH1soVuOZ/PtXbSTd1Q2xSi+NX0ViBsjt3Wij4TdYGi0uKwLYbmp1dQMg4Un+57Rz/R6U5SvBYFjLWPKGSDm5ItyU5E2cJjHOLA4PWN/SqnrbJN1k5WL5co6C3ExZCRLh0WZH52or/MqFa+YoblDlmwGbm9tzOuVb25oznsFEPl/xaConhjGiGwt2zCbTNtZpi2iv4SDxg5JHRP+VWw7sOF9T0MGZSnB6YQqP6+TNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kidh6S7CT+4mdS7Oac4dVc/0tDRa4MqnJFU2jY+IeRg=;
 b=l9c1X3oDl5hPLqhkz51Zk4BsKhlHopy5TrlwOD3FgXS/1OTad+2wL1/g7w9O+Z7ZrSjZNF7iAGXbgRFuGup7Q7ENY8dCFutWY2lvmifX6VI0aLVgUCHv9ObgGmsOvPZduTG5NzWPiUA7kGyhx27GXaDI5uo/wzZtFycdlxwpDrccs/8nQUQFna3UVs+CoupEuHsCalG8meiiNi+4qRT4jQpqYOpJpWJY2rUfyzT21+vjHmWroFTJZ90/q50/8mtKnDV6E4yKxJDfeoOGVdNIq3/Em8zGfX5y/WuX5mm6ifhQ4fT8AAB6eSLxqIywDKw7z497FffBHrQrqR3dU4dJuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kidh6S7CT+4mdS7Oac4dVc/0tDRa4MqnJFU2jY+IeRg=;
 b=MKDxp9kpZ2Cmwqa7m6gGQCslmXI97Im6JnCi7/vqbwt6xbimVKT+ZwaCQ1WrpTHTY8ctP3kwcCCkibUMVcR8Ky7r9/aLesg+gh6DX9SKPwUPxpvaJa0RF95bYi6RG65vkeVxsbUL2ssj3+qWnlFTN0Pv3EZrD/qghuTmTpbnkm7Ynuq/bwYXYPL55KsAv0Zl7jVXXR+/umNfV3uJqtqKLNG1KGHo7F9YIwMwkZWcm4pNmICr3hKUowZcQ8eDzP2M0Jv2/CnSQ+bJfL0DcYMhOlrtoM4ylllwGjQjnHljcqGObQPLzJwjvcylfhQVGovRjq+ytUTg8ytvNig3DA0FWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6336.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:522::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 10:54:52 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%8]) with mapi id 15.20.6043.030; Tue, 31 Jan 2023
 10:54:52 +0000
Message-ID: <6fc061ea-a0b6-13f8-e1e8-50840d4c8622@siemens.com>
Date: Tue, 31 Jan 2023 11:54:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [cip-dev][isar-cip-core][PATCH] Add bookworm
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20230130113412.628646-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230130113412.628646-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR02CA0003.namprd02.prod.outlook.com
 (2603:10b6:610:4e::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6336:EE_
X-MS-Office365-Filtering-Correlation-Id: bebbb983-a592-4a95-7dfb-08db0379943e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	VM8905m1kWkjM0LROHpVTd9zcV7ZKO8wfSIaSX1wf6gpfrMRMOMk3UicxK8BYuohS7YZ+f/AP+iSkd4mz8jDIl5DZHK7vxq3NoHrK5xSg0cg81tK0Y7wBYqs6iU5e8Of12n5b0CRDY1wuuj4g/iAGmFGw4hvNNMYzBdefA21CELvgdlKYRMKmPW8wcWRYkCxY2I+18yVNiujdvClnQaa70K8hFvbF/VUJhowDkIr0AeFxka5H/Ie0SB5Xiua+LasTnlI70Cla+j0tr8W9HOKt6/lGcUDPiNUmEMvEn7Z9H/nTL8wiTcKMH5eCJiAjBUFha1TwMSNNmB5vQSt/qoaBsbl9wQCHWym3zqV76gyyMcxLiq/sGf1a+OAl9OYS6q0D2J9Ux0GXnfEEMGxd7YqIrKbE3VnSPmUllBjKtb/SWlw9qa2tBN9TDaOxs11kGXg4rZnHKDQDyEEKFTVJzEZhSTYAb9elEZRKZI0hy3v/IdyM8toCwid9L/8Px0wv2DO1FKLrqF1hvJ7kaP9FCJnXI/YrwedybhewhBTlEiNX4jpYcDlU3NxHhGQFPhxmhIGWE5ibRZTrCRo04hLJVyxxWIvC0akBxjk7oLe61p2hqhSis3VQkChAwZWJ+gxnqLhynkukM6lww4cOpIaGKZ+0vM1ZbR3Z3o7X51kJ+IePdc0NoFHvT/JGBYspHUjyzNroHrkA95N2QwRYmR7o8QJgYkA2Uaq7dkh+UepLaci8py5O7mbgTZrsoAKlwvtes6ppuQ+xtrCA8zOGfvDOWUx1A==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(451199018)(31696002)(86362001)(66556008)(38100700002)(82960400001)(36756003)(5660300002)(316002)(8676002)(66476007)(8936002)(66946007)(2906002)(44832011)(41300700001)(83380400001)(2616005)(6486002)(478600001)(26005)(6506007)(6666004)(186003)(6512007)(53546011)(66899018)(31686004)(403724002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VTEyWG1OVWtjREU5cEtzeGsyNktIRVo0bGcvZ0VGS05jTVpSSnhCZEN1YmlJ?=
 =?utf-8?B?aFJwS3pxRzhPczhGYmdpYUx1ZExEQVNEblBqMDRHUjdVWTlpU0lBZHYySVJo?=
 =?utf-8?B?SFBTSWJzdHpocFJGU2RzbjkwT2hqQmJndUlxZWpYZm8rYW1WK05DUmtaKzZB?=
 =?utf-8?B?Z082VDhVaXdOTDFPSXVlVVlhc1BWZlNBU0ZJUlhtV3pERUw1eERhOWRoTk1D?=
 =?utf-8?B?OHBGcVBETERTbTR5K29yR25udzUwNWhsY0U1eXdudjFIOVd3eDlaNFlzTHE4?=
 =?utf-8?B?b09kaWNBL2NOMVV2QlBMTDNqc1dlc3dsb0lwRTZLMkVtN1FkZkRaUjBGNlJ0?=
 =?utf-8?B?MU02V3FXd0NFM2RUOVFQb01tWHlXbE1TN2E5T00reVhvYXphUVRMc1JUWkpl?=
 =?utf-8?B?RjZZSjh2b21NUUh3NmN5WUZUais1UDVIN3ZZWHJJQmRNaTY1c2c3RFQwZ3cr?=
 =?utf-8?B?QXI0OTkvMjlrNEJ3bElPR1FQdGFhMEVkRWMyelBhVmpTRW00NllhOUtiTmhI?=
 =?utf-8?B?UFZiNVkxZVFzYVlWQjk4bVYxYXBHK0J3MC9XT0JvRzdTUGZ1TGhHWWpYWVY3?=
 =?utf-8?B?OVdpY3Q2aXpFQ3hHTjFTY2ZHdVY1OFF0OTZPcEtScXk5bUFXOS91VndOcWxP?=
 =?utf-8?B?SjljSFNKOFF1aWRIUVRHWFJyTEhienBLVU1ZSmdlRXQrazlCdWZDTkJWWktH?=
 =?utf-8?B?a0UzcUovRlhmNXlGeDg3NnNNdzRqUFQrUEsrd2lzNGJGWVh5YzJNTXhoWFda?=
 =?utf-8?B?QW03Y0NIOTJUWjhaMGM0cFRFdVc2SW5LU2loUG81aHJsTGpnaE5YSmlQRXRI?=
 =?utf-8?B?cDBFNk9ycHpIVmREUDVKWmlYVkVQS2FZcTd2eVczUGlFWStOQlpZMU8xNnpL?=
 =?utf-8?B?WlhwUHpFdk5JVXFVOVhmQW53cy85aUczWE5QczVWRjZXVTQ5OEdoNTRaL3gz?=
 =?utf-8?B?bXh5VTBCb1ZLY1VlMk1Sa0xmZGJpRFpYNm03aUJwWkYyOWZhRmhEU0xWYS96?=
 =?utf-8?B?SXlMRkdQRHBjc09sbUk1cmE5K2Jkd0x5cDBqcXlQWjFKVXd3L2x6a0lTWUY5?=
 =?utf-8?B?RXpLb2lPL3NndDZBS2RsT2lHK1lTQlEzemE3S2pqaXBQSjcrMWFVcmVZQXFE?=
 =?utf-8?B?V3NNc2Joc3ZMUHBDQ3M4bXF4bHV4THZoZFc5cHFHV1JnZFNBeEx1M1BkUWhS?=
 =?utf-8?B?bWVNZzhubFNIRzJna0kxMnJYWmdhcDdSeElRTTg0eXVSZktFRmd4K0JGQjg2?=
 =?utf-8?B?aFVhcTRwYm5USkpGSkRVMDQ3dVo5RWJQME1qb1dROWxVckwyODZQb3RzRm9Z?=
 =?utf-8?B?OTF6MGIxcW5Ta3FYaHFTTEF6amJOYTZueE9WY3hBSURrZUtQaVVtSXN3KzJo?=
 =?utf-8?B?dFM2cmNaVjJwendLQkh1ZXA2ZlZOVnRGbEFKZVU2Y1I5NW9Hc1NoZDlYTGVO?=
 =?utf-8?B?dTB3SGRHNzVvT1BVT2FKbEpqTUJraW9jSW5TVnNsblE2eGROVUJIOGR1RERa?=
 =?utf-8?B?b1RqYWJFZFNuTUN1WHg1OURxcit1dE0vOVpGUEFmR20wYWNBeUdwa1VBRFRs?=
 =?utf-8?B?M1RpbGdQcFlqUWpRZmZLaTlTQTlvTVhyMXh5RHAyalBheitwUnA1TjVMT0Ru?=
 =?utf-8?B?TmNuRHA3cURza1lMY3lldXhsOG9URXBQd1Y5VFkvVmg4TWc3aklrSmdLOTZX?=
 =?utf-8?B?WUw3Z0R6UStwbTdMd3pWbG5tMlA0ZGFSZzEzM0QzNlk2MnhlT0lRcUxmRTht?=
 =?utf-8?B?MHhzaG8yUXNFcnpRVVhsZmhJQlFHZFZQVVlkWDJGT2xRMUpNWXZKYkNBNjhh?=
 =?utf-8?B?V2N6bWF6UUlUMS94N0NpdkhQb2FRSHdoS0o1VTJtQllMMW52M0w4Q0x0VEZ2?=
 =?utf-8?B?ZVR2VEZidjJjZmtWRFJLblJBK3RDZHRyUVYwazlqVmNTekFDQ2kzaVpFeE5i?=
 =?utf-8?B?VXVkQnIzYW5NTExHbjM3dnk4a2xKeUlMQTJqSnJ3OUxjdkUvU25IR2kvTHZV?=
 =?utf-8?B?ZzdPR0pLcWdFS1czbDFTdUZDUkYyMUY5VndVMXczdHdBN3hKUlh4OFlpTUx3?=
 =?utf-8?B?d3d5OWhPYWQ2ZnpwV1hyWFhsRHNCeDRtZUZNUUpxZUlsQ2JKdTc1djBnclFq?=
 =?utf-8?B?M1JWVmhQallyRnJTY0JZak9YV2ZHbTRqb2VkM1NZUnJtSGJiUGo5WElwQmJ3?=
 =?utf-8?B?S2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bebbb983-a592-4a95-7dfb-08db0379943e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 10:54:51.9387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W6fRkR34sjKnLESujYcATwMcDmYMBQS7R/l48wMM1akaOaZhbm2wqlOVikZq00lk3fdGh5oRDlrF8KbzhggfaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6336
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 31 Jan 2023 10:55:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10520

On 30.01.23 12:34, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This will add prelimitary support for the debian 12 aka bookworm.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .gitlab-ci.yml                       | 45 ++++++++++++++++++++++++++++
>  Kconfig                              |  5 ++++
>  conf/distro/cip-core-bookworm.conf   | 17 +++++++++++
>  kas/opt/bookworm.yml                 | 15 ++++++++++
>  recipes-core/images/efibootguard.inc |  6 ++--
>  recipes-core/images/swupdate.inc     |  6 +++-
>  6 files changed, 91 insertions(+), 3 deletions(-)
>  create mode 100644 conf/distro/cip-core-bookworm.conf
>  create mode 100644 kas/opt/bookworm.yml
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index f7c8c88..2b9505d 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -37,6 +37,7 @@ default:
>      - if [ "${targz}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/targz-img.yml"; fi
>      - if [ "${release}" = "buster" ]; then base_yaml="${base_yaml}:kas/opt/buster.yml"; fi
>      - if [ "${release}" = "bullseye" ]; then base_yaml="${base_yaml}:kas/opt/bullseye.yml"; fi
> +    - if [ "${release}" = "bookworm" ]; then base_yaml="${base_yaml}:kas/opt/bookworm.yml"; fi
>      - echo "Building ${base_yaml}"
>      - kas build ${base_yaml}
>      - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG}; fi
> @@ -281,3 +282,47 @@ build:qemu-amd64-secure-boot-buster:
>      use_rt: disable
>      wic_targz: disable
>      deploy: disable
> +
> +# bookworm images
> +build:simatic-ipc227e-bookworm:
> +  extends:
> +    - .build_base
> +  variables:
> +    target: simatic-ipc227e
> +    release: bookworm
> +
> +build:bbb-bookworm:
> +  extends:
> +    - .build_base
> +  variables:
> +    target: bbb
> +    dtb: am335x-boneblack.dtb
> +    release: bookworm
> +
> +build:iwg20m-bookworm:
> +  extends:
> +    - .build_base
> +  variables:
> +    target: iwg20m
> +    dtb: r8a7743-iwg20d-q7-dbcm-ca.dtb
> +    release: bookworm
> +
> +build:hihope-rzg2m-bookworm:
> +  extends:
> +    - .build_base
> +  variables:
> +    target: hihope-rzg2m
> +    dtb: r8a774a1-hihope-rzg2m-ex.dtb
> +    release: bookworm
> +
> +build:qemu-amd64-secure-boot-bookworm:
> +  extends:
> +    - .build_base
> +  variables:
> +    base_yaml: "kas-cip.yml:kas/board/${target}.yml:kas/opt/5.10.yml"

I don't think we need pin to 5.10 here. Once there is a 6.1 option, it
will be preferred for bookworm, and this may just be forgotten to be
dropped.

> +    release: bookworm
> +    target: qemu-amd64
> +    extension: ebg-secure-boot-snakeoil
> +    use_rt: disable
> +    wic_targz: disable
> +    deploy: disable
> diff --git a/Kconfig b/Kconfig
> index cd24ce2..87056b9 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -128,6 +128,10 @@ config DEBIAN_BULLSEYE
>  	bool "bullseye (11)"
>  	depends on !ARCH_RISCV64
>  
> +config DEBIAN_BOOKWORM
> +	bool "bookworm (12)"
> +	depends on !ARCH_RISCV64
> +
>  config DEBIAN_SID_PORTS
>  	bool "sid (unstable) with unofficial ports"
>  	depends on ARCH_RISCV64
> @@ -138,6 +142,7 @@ config KAS_INCLUDE_DEBIAN
>  	string
>  	default "kas/opt/buster.yml" if DEBIAN_BUSTER
>  	default "kas/opt/bullseye.yml" if DEBIAN_BULLSEYE
> +	default "kas/opt/bookworm.yml" if DEBIAN_BOOKWORM
>  	default "kas/opt/sid-ports.yml" if DEBIAN_SID_PORTS
>  
>  comment "Image features"
> diff --git a/conf/distro/cip-core-bookworm.conf b/conf/distro/cip-core-bookworm.conf
> new file mode 100644
> index 0000000..86c97a1
> --- /dev/null
> +++ b/conf/distro/cip-core-bookworm.conf
> @@ -0,0 +1,17 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2023
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +require conf/distro/debian-bookworm.conf
> +require cip-core-common.inc
> +
> +PREFERRED_VERSION_efibootguard ?= "0.13.%"
> +PREFERRED_VERSION_linux-cip ?= "5.10.%"
> +PREFERRED_VERSION_linux-cip-rt ?= "5.10.%"
> diff --git a/kas/opt/bookworm.yml b/kas/opt/bookworm.yml
> new file mode 100644
> index 0000000..8b4431b
> --- /dev/null
> +++ b/kas/opt/bookworm.yml
> @@ -0,0 +1,15 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2023
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +header:
> +  version: 12
> +
> +distro: cip-core-bookworm
> diff --git a/recipes-core/images/efibootguard.inc b/recipes-core/images/efibootguard.inc
> index eace4fd..d8d3a06 100644
> --- a/recipes-core/images/efibootguard.inc
> +++ b/recipes-core/images/efibootguard.inc
> @@ -8,8 +8,10 @@
>  #
>  # SPDX-License-Identifier: MIT
>  #
> -

Please keep.

> -IMAGE_INSTALL_append = " efibootguard"
> +OVERRIDES_append = ":${BASE_DISTRO_CODENAME}"

Blank line here, also to be consistent.

> +IMAGE_PREINSTALL_append_bookworm += " efibootguard"
> +IMAGE_INSTALL_append_bullseye += " efibootguard"
> +IMAGE_INSTALL_append_buster += " efibootguard"

+= does not make sense together with "_append".

>  
>  WIC_IMAGER_INSTALL_append = " efibootguard"
>  WDOG_TIMEOUT ?= "60"
> diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
> index 9b2aedc..a47928a 100644
> --- a/recipes-core/images/swupdate.inc
> +++ b/recipes-core/images/swupdate.inc
> @@ -13,7 +13,11 @@ inherit image_uuid
>  inherit swupdate
>  inherit read-only-rootfs
>  
> -IMAGE_INSTALL += " swupdate"
> +OVERRIDES_append = ":${BASE_DISTRO_CODENAME}"
> +
> +IMAGE_PREINSTALL_append_bookworm += " swupdate"
> +IMAGE_INSTALL_append_bullseye += " swupdate"
> +IMAGE_INSTALL_append_buster += " swupdate"

Same here.

>  IMAGE_INSTALL += " swupdate-handler-roundrobin"
>  
>  ROOTFS_PARTITION_NAME = "${IMAGE_FULLNAME}.wic.p4.gz"

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


