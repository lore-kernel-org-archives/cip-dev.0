Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A07C77B61
	for <webhook@archiver.kernel.org>; Mon,  1 May 2023 11:29:58 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.60])
 by mx.groups.io with SMTP id smtpd.web10.91218.1682940591399215152
 for <cip-dev@lists.cip-project.org>;
 Mon, 01 May 2023 04:29:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=JtJ++1zu;
 spf=pass (domain: siemens.com, ip: 40.107.20.60, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=km9w7Id3dlnZnP235H56BrSL/mw9Rqgj+WevGTU+7KJyqyjRqFx/AH+jRoohs3Oy4YJUV6azHr5f9u9ZfuZZXGm5OlutLqD/1xSEgr6m837ebLrrmqPss1zE23IxdgWwVaVYGiHbbxrxIbAcNPCQhcqIkG9L7cY6OlriiGIQZhrdC0Q9A7HOopfW+fHgYmmqd4EPdzPuERVU++No0HNejZClkQqRXTjPsu9RL/Z1wIalzwAy6toD+ydBGdS2Pow9oGH4baBFHsOZ5Nb6ZwaLGMB9Y3ZS1yVAmBwobTfDoobMcRhTWVYzru3dWBA6N5CtxNLrPinJcEnZhVUqVH1dFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ghyioxrt03zBpNrZXn/nLCXgDojN48YyLJHu9SRwyjw=;
 b=aVAr7YFpr7OKW60KwjD3o1c6eNFn35iFT7kgo2I6RCUdW8daPN3aCcqoTEU0xGx5BoBJJ5tbLu9Nqdqz6ze5FAhi09qkYNqjleUmZNN5oEvslyKIGZa3RTJQdKf7HBqU3egw6BRMFO6h9gT3L2UEp00SFAKs1/Rx3XNlOTVlvq3uwj5YpTxFmFcSnoYVbk5WOydlGQaOadLO1D6u4wD3QZ0kT58GnN8cCpq7NvfoV3C/vi5ceosomGlpXJtzoDfuX6s/VLl0mxbo+j2vsWItIVpDMTkZLdBopeyS3O8o4Hb5unxa4EDCkMSfdVCgMAU8JWofqZ/H6p5A4xk5UA0hKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ghyioxrt03zBpNrZXn/nLCXgDojN48YyLJHu9SRwyjw=;
 b=JtJ++1zuDvVPM0BlDjOeSpOSQnnIpDYhbU2yMntmUkhLZy28zvL6BT8M7eZ/GFIjFKXXgDGHVB4uFMSjqPkubGMGuX0FgyRAyg0vGXsJbwMf6PbZPXP2QdPIDIc5Q6zVmDPkQ4lUqC2MgLoWschgWDmR5JXtIk/r0/sK3JzMbg8c7FOXK2IQE8ka1RmRy5oBjtQk6KcJvsW+TsK6s4QYsBdV6YA69PrrLJXo8aVPIxBx52xdYJkzllIhVXoog6JuFnSZt5NzGoStLNRKbdJO9XH2BMK7lDV2F/WKwTOWblNVX7y2SKxNbqmiKYqBNBIorcNOO9BGZJHQEbVRzcpIYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5872.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:517::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Mon, 1 May
 2023 11:29:48 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e%4]) with mapi id 15.20.6340.029; Mon, 1 May 2023
 11:29:48 +0000
Message-ID: <2335eb1c-3ea0-005c-e7fd-1ec98626b31f@siemens.com>
Date: Mon, 1 May 2023 13:29:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [isar-cip-core][PATCH 2/2] generalize deployment of self compiled
 firmware
Content-Language: en-US
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com
References: <20230425033246.1199444-1-felix.moessbauer@siemens.com>
 <20230425033246.1199444-2-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230425033246.1199444-2-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0220.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5872:EE_
X-MS-Office365-Filtering-Correlation-Id: c5df2bbe-9253-49a9-d8c9-08db4a375ecf
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	KaVyLLfFwuy4VGAR16ZngaEX+7i/eagCAUQJMDaD0PwjRCeMP6qqeBoX3xMJbuVuzo6ybyvR/ZsJ/Csd1CNf/7bHRoQ/UFzPv2NTskB5tmbLiMzrWsSjyPGjqpP6QHav3GKLw4u5aRj2n9sgwhA4Ji5r2e4fC0jneSyIQn5MmOSCkhrOGoqr1wTh4y8B4hlt6cjRGXgfSc3/RCSOH95apIUKwY/gtGgp+2hrX067yhigIJbt2lSXANxjXYh8/SZpGccEJ/hZXQVNzltko4nlfS61IMqzrbZT/sy2/VzItxmL7V7lFxx+P9hTOkYVW1rh5Og4lCJbZaCz3+SKyqhjFmpR+jCZAjuP0OEExIQQFUeyl/PS3dLzvbXlULHb7E4hOejh4/zmovPELrYIkjk0Br805N+yp1UNcxwbI69jK4BSZ0xT3AH5uAnd2SBTui1MgOvoon+O7o+DGpdVXzQ2Omggq4pwCZAOiQTMaMaDaqPkdEyN9YT+n1I8piHu4fsDMDw05YdYR9Jwv0wpUEQw/rS0NFveZTIjO5f7jHDP0/eayojWyxNFM9/3YQmOjukr477hIb9URJVpal5Q+nqA2qTe3saEeOaajOJ59A81BaYC4vobx59AVIcQOzY5OAVzQfaJBYYTZS29GMGIkjFjLP07+lYpnkE+D3+dn1FmPWK7MyFbJKdsX32KxFiQ3aoV
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(366004)(396003)(39860400002)(451199021)(26005)(6512007)(31696002)(6506007)(478600001)(2616005)(31686004)(186003)(83380400001)(53546011)(107886003)(86362001)(966005)(6666004)(6486002)(2906002)(38100700002)(82960400001)(316002)(8936002)(44832011)(4326008)(66556008)(66946007)(36756003)(8676002)(41300700001)(66476007)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VTdRWjArSEYxUStsRDF3djhxKzg1bXNOY21kekM2aEJQTmQ1TTN2SmJiK1A5?=
 =?utf-8?B?RVhLeDRaTE9MSmhkZlZqNDVlZ0RkWE12VzNKRHhNd2hTOG1TdWRmbFZyUjNG?=
 =?utf-8?B?WEQ4elE2bFVKKy9rTWFDRFZFWWx0RG04aThFa3pIY1JjblBpZ1ppZEdTT0I5?=
 =?utf-8?B?UmQ1MzhkYzRqSHFRM0s4OFBsOWhnbm05QkcyTCsvc1ZKczFVa2g5akJsVDh5?=
 =?utf-8?B?Ui81ZjA0UTlqbGszRGRBdjQyTS9TY2NGdjhZb3FyQklwWVk4TDVBZitPTERs?=
 =?utf-8?B?S0hoTFJQWnMwVEp6OHR2ZTcxWTQzRGlSNWJQU21OWHF5TS90c1dFWUlaQkVY?=
 =?utf-8?B?L0htTkgyY0E3OG9ZRWZMZzRXQ3BQclVZQXNWcWZ3THdwRUpDay9wbDJCSngr?=
 =?utf-8?B?L2tocjZHRm1YcXlFVkh5YzNWd2pVQ1FZNHg1Y2hCMHNzbUQ3Ni9wdHZzRTFQ?=
 =?utf-8?B?dzZ3YkhGUlJiWjh5QXQ0Rm15dDhid3BYMmx2ZUw3eVRXMUpJYjZDUHhHWlVP?=
 =?utf-8?B?Q1l6M1VVbGtZb3g5R2hzUUJJblgyOEpidjhhNytBd1l5YnpGQjJaTzV2dWxY?=
 =?utf-8?B?TFZmUkwxalZ3VlpQM3JKaFE3VklvckYyUUw5RU9aaHNHcm9ZeSszQVlLcDNG?=
 =?utf-8?B?QnBHczJxWUpFdmQxUGxXVGlnZElHbVA4UjJCU01US2liZmZUTkpQS29jV3Qw?=
 =?utf-8?B?VUtvczg4YTRPWGc1RDhPenRuR2tjN3pXNUVzTmVFVVJhei9WWHBIUUhTRmZC?=
 =?utf-8?B?RStORmk2dWl3NlNxNG1RcWVCRGp1ZjFvY2E5SE1pc3k3bk1rWHhYdnNTZVlz?=
 =?utf-8?B?REJIUEdwbFc3ZU40MWRnOFkyWlg5dWUzNEJ0YjNPMDJwVFVLTmhUVzNNT0xY?=
 =?utf-8?B?M0NEVjBXOVViMXdvMGFjTlcrS3pWM2lVUUhEazllS1BQNEZCc0xCZi9iQ1Ar?=
 =?utf-8?B?b2hjTFUzaVFVS2lDRGpoRDJ1R1d0UDZWNnlrNlZ3NXpXaVhHMGI4Unk1RW1N?=
 =?utf-8?B?U3Q4dzdiQXZhaTBoRGF2MVhBRDZkd0JxYWllSHg3MEJBSVpMb21JVTU5N0NE?=
 =?utf-8?B?KzZPWWdWR0FiN05oYjBseEh1STViM1ZNcHkza2hWUUgvbkJCUlVEMFZxZUhj?=
 =?utf-8?B?YUtMYmYzNVlUbkFJLzNoN25NQzI0VGJtWmx0a29vMWZOdHhxUzdnYy9Gbko5?=
 =?utf-8?B?eG81R0pvdURiL1JBUitOWUVMTFZmei9tejVxdGJtcmxHcmQwM1N1MzVhdHcv?=
 =?utf-8?B?L0xHK2ZnZVRvRU9FQktHLy9MckNBeTFOZHFQbng0MEd4YlArYjQ5ZGkwQlZD?=
 =?utf-8?B?bnBpNFJsT2ZBTkwwRjB1L2ZPMTkvanRtRVIxaGJxMytBK3daWXA3b3cxZUd0?=
 =?utf-8?B?YkEvT2tZc25EeTJYK0VvNmhxYU1oZ3BrTE9kakpuR0ZPSDIrTUU5VmpsL1Uw?=
 =?utf-8?B?OTI0YkV6cklpOEhXdm5XM2NIMWhsc3ZoTUFBc2J6UUFFd1ZsejZ0L1ZXd2d5?=
 =?utf-8?B?VkxpckN4VXNlSjJ0ZlZQd2N6Wm1UVEpvam1ETXMyWGs2V0JnaHhTYzcvVUMr?=
 =?utf-8?B?eVBZdEs2WVpPYjFmdFZRVW9OczBlQm9EOWVLQnZBNU9pajR1VWc0NlZsWitL?=
 =?utf-8?B?MUEvcnZtcFh6cS9DZ3JZVm1wdGsva3haUExSU2ZCYzZWV3JRdks5NEdZM3E0?=
 =?utf-8?B?M25FV015cFovaWs4bWQyVjJzcGVYN0RlREZKVVFLelFVenF2YVl6Tlhtdnpt?=
 =?utf-8?B?blFNbXBPOFRTYXNYN1JmUExER0d4TXVIcVMrWlB6KzF2SHVEdGFENnJIZ2lY?=
 =?utf-8?B?S3NEVnErYzBxTDc5V0dTRkU3ZzRGMDdvVnRUVGRWTFNxNWp6aEQ0b2N0bXlN?=
 =?utf-8?B?YlY3UEtvVU01ZktLY2FOeTY4UmFXazk0S1BtOURLcGZBOGFFSzFtMlAvZkNG?=
 =?utf-8?B?QWpHbFN1bk81aDA1UXFNL1NKL1h0cU1keGFHdEtjVzZ6ZytxNTA1Mm9lbEtv?=
 =?utf-8?B?c0c2N3dPakVTY00zK3c4alJOVlZLeHRQZ0FvUXZxbUN6Uk53WHo1aDNoSW85?=
 =?utf-8?B?SUNuWnZkM2c5U3JnaVVHakdrdDduNXh0R2VFMktXTFFiM29XMzNIWm45a1RP?=
 =?utf-8?Q?bZ2pddpRm/JUPFa5vch3XLc+N?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5df2bbe-9253-49a9-d8c9-08db4a375ecf
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2023 11:29:48.4383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h4d96WKI6+2iasKBkCW13hSRHjdrPy1PiMKeD4PzFg5W/ObQU/hbRsfgmd4QI+yeo29Q7yBqHatxvIqiHk8L7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5872
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 01 May 2023 11:29:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11372

On 25.04.23 05:32, Felix Moessbauer wrote:
> For some targets, dedicated firmware is compiled and copied into the
> DEPLOY_DIR_IMAGE. Instead of implementing this logic for each firmware
> individually, we move the common logic into a class and inherit.
> 
> This reduces the amount of code duplication and simplifies the maintenance.
> 
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
>  classes/deploy-firmware.bbclass           | 32 +++++++++++++++++++++++
>  recipes-bsp/opensbi/opensbi.inc           | 16 ++----------
>  recipes-bsp/u-boot/u-boot-qemu-common.inc | 18 +++----------
>  3 files changed, 37 insertions(+), 29 deletions(-)
>  create mode 100644 classes/deploy-firmware.bbclass
> 
> diff --git a/classes/deploy-firmware.bbclass b/classes/deploy-firmware.bbclass
> new file mode 100644
> index 0000000..a4b754a
> --- /dev/null
> +++ b/classes/deploy-firmware.bbclass
> @@ -0,0 +1,32 @@
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
> +# This class adds a mechanism to deploy files to the DEPLOY_DIR_IMAGE
> +# directory. Simply overwrite the deploy_firmware task and copy the
> +# to-be-deployed files into DEPLOYDIR_FIRMWARE.
> +
> +inherit dpkg-base
> +
> +DEPLOYDIR_FIRMWARE = "${WORKDIR}/deploy-fw"
> +SSTATETASKS += "do_deploy_firmware"
> +
> +do_deploy_firmware[cleandirs] += "${DEPLOYDIR_FIRMWARE}"
> +do_deploy_firmware[sstate-inputdirs] = "${DEPLOYDIR_FIRMWARE}"
> +do_deploy_firmware[sstate-outputdirs] = "${DEPLOY_DIR_IMAGE}"
> +do_deploy_firmware() {
> +    die "This should never be called, overwrite it in your derived class"
> +}
> +
> +python do_deploy_firmware_setscene () {
> +    sstate_setscene(d)
> +}
> +addtask do_deploy_firmware_setscene
> +
> +addtask deploy_firmware after do_dpkg_build before do_deploy_deb
> diff --git a/recipes-bsp/opensbi/opensbi.inc b/recipes-bsp/opensbi/opensbi.inc
> index 0108231..6d84026 100644
> --- a/recipes-bsp/opensbi/opensbi.inc
> +++ b/recipes-bsp/opensbi/opensbi.inc
> @@ -4,13 +4,11 @@
>  # SPDX-License-Identifier: MIT
>  
>  inherit dpkg
> +inherit deploy-firmware
>  
>  U_BOOT_PACKAGE ?= "u-boot-${MACHINE}"
>  PLATFORM ?= "generic"
>  
> -DEPLOYDIR_FIRMWARE = "${WORKDIR}/deploy-fw"
> -SSTATETASKS += "do_deploy"
> -
>  SRC_URI = " \
>      https://github.com/riscv/opensbi/archive/v${PV}.tar.gz;downloadfilename=opensbi-${PV}.tar.gz;name=opensbi"
>  
> @@ -27,18 +25,8 @@ do_prepare_build() {
>      echo "build/platform/${PLATFORM}/firmware/fw_payload.bin /usr/lib/opensbi/${MACHINE}/" > ${S}/debian/install
>  }
>  
> -do_deploy[cleandirs] += "${DEPLOYDIR_FIRMWARE}"
> -do_deploy[sstate-inputdirs] = "${DEPLOYDIR_FIRMWARE}"
> -do_deploy[sstate-outputdirs] = "${DEPLOY_DIR_IMAGE}"
> -do_deploy() {
> +do_deploy_firmware() {
>      dpkg --fsys-tarfile "${WORKDIR}/${PN}_${PV}_${DISTRO_ARCH}.deb" | \
>          tar xOf - "./usr/lib/opensbi/${MACHINE}/fw_payload.bin" \
>          > "${DEPLOYDIR_FIRMWARE}/fw_payload.bin"
>  }
> -
> -python do_deploy_setscene () {
> -    sstate_setscene(d)
> -}
> -addtask do_deploy_setscene
> -
> -addtask deploy after do_dpkg_build before do_deploy_deb
> diff --git a/recipes-bsp/u-boot/u-boot-qemu-common.inc b/recipes-bsp/u-boot/u-boot-qemu-common.inc
> index 4d8b240..b222155 100644
> --- a/recipes-bsp/u-boot/u-boot-qemu-common.inc
> +++ b/recipes-bsp/u-boot/u-boot-qemu-common.inc
> @@ -9,25 +9,13 @@
>  # SPDX-License-Identifier: MIT
>  #
>  
> +inherit deploy-firmware
>  require recipes-bsp/u-boot/u-boot-common.inc
>  
>  U_BOOT_BIN = "u-boot.bin"
>  
> -DEPLOYDIR_U_BOOT = "${WORKDIR}/deploy-u-boot"
> -SSTATETASKS += "do_deploy"
> -
> -do_deploy[cleandirs] += "${DEPLOYDIR_U_BOOT}"
> -do_deploy[sstate-inputdirs] = "${DEPLOYDIR_U_BOOT}"
> -do_deploy[sstate-outputdirs] = "${DEPLOY_DIR_IMAGE}"
> -do_deploy() {
> +do_deploy_firmware() {
>      dpkg --fsys-tarfile "${WORKDIR}/u-boot-${MACHINE}_${PV}_${DISTRO_ARCH}.deb" | \
>          tar xOf - "./usr/lib/u-boot/${MACHINE}/${U_BOOT_BIN}" \
> -        > "${DEPLOYDIR_U_BOOT}/firmware.bin"
> -}
> -
> -python do_deploy_setscene () {
> -    sstate_setscene(d)
> +        > "${DEPLOYDIR_FIRMWARE}/firmware.bin"
>  }
> -addtask do_deploy_setscene
> -
> -addtask deploy after do_dpkg_build before do_deploy_deb

Thanks, both applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


