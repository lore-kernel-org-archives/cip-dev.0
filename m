Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F745C6FA8E
	for <webhook@archiver.kernel.org>; Sat,  4 Mar 2023 08:35:54 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.89])
 by mx.groups.io with SMTP id smtpd.web11.5311.1677918946791285385
 for <cip-dev@lists.cip-project.org>;
 Sat, 04 Mar 2023 00:35:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=LV2p23Wq;
 spf=pass (domain: siemens.com, ip: 40.107.7.89, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CGHZfiMoQ42c+cC5Lg6WQRx00P/CPoJGUNP91o1yTpyZ70WKsUsy6TM7vpCiBpX/0dubwonZAZf55AnjbqY0cq9wV7ikOLu573sdhG0wY6HtiNk5gv1y2gt/Jn0sWtmq+KnpivdrjuiHRF9uUUBbFzu0TcLoso86RmYl61fHXj/QF/KhxMdejFFKWbKrxEajoc65RZ8lNgWv3dTx695YFaR8VjdW0I1X0u+qfWl/3F8PEdKP0E2UdPJZcdFaG71JXpo+kv6dG4nhuXyVeFppih6U2y3mUKYrlGNUbHUeIYoow4RqlYe/iO6BLVKP3zI4hB7Hc9Tmfp6iuU+f6pDLdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJ4JmSKqETjBVZk1UY+qQ762B82sGyV1Sojrf8tGEp4=;
 b=k8hyolM9TYfZ60Q2BRfxXXkoYu/5rcHmOJrSsd0WwUO+egipMQsDjGGKdDfV9vjMIk5A0bWztU3xWIiJc5tJ6Tlu2PzCMnEnrKh4OiDoYuDAzczun8B4H8zh1w+vwmFqQOku3UPW0FelaZjy0hmxGxZcujwAd3ZTAnHNx0gB4KtpM1YqW90IyMVPQR2dSWMLenXNgj4zsXFqdDYMdXk/7/9+huKYEsX8S+3crjaabXj90yKwbI2ePftbwtsQRzot4G8jreuX3J3Y5pXS9tIZwRc/s54+zi+5t5cnNhsCYmg8HFkLkSTchlCrtiRpAPm12WTqwvYMqrCfRfpUxI16sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJ4JmSKqETjBVZk1UY+qQ762B82sGyV1Sojrf8tGEp4=;
 b=LV2p23WqCFuZkKQJ+7+pr3HHkjocE8upIzSChdx8YMtFoFvMh75nI/ws3OXviDX4viS1v9mpeb/vNI1WbbUySp57lZzx4l1x3dnOfaAhtBEcfnz1qxuBYKX7OCiBvur3ZPZmuwSh9Hw4TvE9MyQBzcLvFv7BHF3eh6nt0ZwsyDmXTWJwxN1yiCbBc/AJfSZT99TddOD+lXNepxWsa46OYfXDDNI9WS1a1/JpZreirggTSWSuf0H+/V5T9czakg+bivHtv7r/qdLLzalML33GQhr67hmFRrrcIwgBZOyyTgcwMq6Mz0F7g7msRd0BsnCJMpwPzIDGYSrHT3a4BxJ+9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB6919.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3fd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.8; Sat, 4 Mar
 2023 08:35:32 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2%6]) with mapi id 15.20.6178.007; Sat, 4 Mar 2023
 08:35:27 +0000
Message-ID: <fdf77d6f-a7b5-3c2e-1c74-e0e1264ca5a8@siemens.com>
Date: Sat, 4 Mar 2023 09:35:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [isar-cip-core][PATCH v4 4/8] add opensbi with u-boot payload for
 riscv64
Content-Language: en-US
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: daniel.bovensiepen@siemens.com, quirin.gylstorff@siemens.com
References: <20230303124820.2209954-1-felix.moessbauer@siemens.com>
 <20230303124820.2209954-5-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230303124820.2209954-5-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB6919:EE_
X-MS-Office365-Filtering-Correlation-Id: eb8ce4f9-b010-43cd-2838-08db1c8b6799
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	A/8W7DcBGgiHDDzAmVjRtdGXgNZdXpBcNAxeTiIQu/wZBxCiCIsXmDvwY7LnIibmiUDkGNUkYYImk9/WQ71sPn2bEbMiprPZ9+3Qn+m4r8YzBoEZlAUr/gijdTTC3hNMFQ/S7YykA7AJX97bKZF7p4CQdPXTgeC8k6mepfSOVTNPJbdBExsKrkBOFsLQibKApxmR07tzboibZOvQ1zSYwgWNfl805dYz2VFcKbVCpol9ANOzKQ+M3xxHFgfaRtCDeyQhRkU+QIFPSrDFPQkPSx224tGDFr0+aZqtRg9TO4/QLBD0As1F830tLC56zohMmYv1IuHrRBmMPtEFBPqaUR0CbLikVVzx5UhbjDZIj+gnzGDFYCUVPyEN2NQFMdo17W0Aviyt4aIs+qqEElhmO6/QZwTid9U2KF8dT0UmZuLA1ayUBq9aTwwBsKypdd2TscFMEKiwaZIU2bkKyOUafCFjxt0G+vra/m9d40DuEZB+Wk/jYEhEN4kbWeH3+6u42bEu+3sBgcBw9dM+IINk7j7zGpPGwnk16C4B8/LLjo+Z2hn12aoJ0atnKN60Y8VYwZrII0LjUoyiXh150Gh4Nc1ZBKf9QZsJ8acR+0owmK4Kvw0jzLDzAyC7/z9it90Oxa8i2hrwwJPps//59af8Ei0z/aF4eBmv6ttJDSQp4T9Lxh2+qtjS35TFIyh0Y26oMjLOLmV0lbDxCVq9c0Me3AMXk7g2k34csHatNbJHLog=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(366004)(346002)(396003)(376002)(451199018)(2616005)(107886003)(82960400001)(6486002)(966005)(6666004)(36756003)(478600001)(316002)(86362001)(31696002)(38100700002)(31686004)(26005)(41300700001)(83380400001)(186003)(53546011)(6506007)(6512007)(8936002)(2906002)(5660300002)(44832011)(66476007)(66946007)(8676002)(66556008)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?U3hsUW9TSE4xTGVySHBoekt1Nlc2RWEyaVFWME5WRkJSaUtycTRRRXltVzBR?=
 =?utf-8?B?bXYyVWFOQ2l6MCtzcjRsd3hIcC9WN0xJSkNLQlkzUVdyV2o5Y2FZalVPVFlW?=
 =?utf-8?B?VlNTSVloanhtKzdCRmR0QWhick5iSjVHdWZDQmlmOEl0NnhsT2RIZ0dTd2ZQ?=
 =?utf-8?B?YTZRWUo2cnYyMmFXQnh6aUlTdVdxa3hyZ0RFRm5Qb3IySG9QK21YSHVpREtn?=
 =?utf-8?B?NEM3ZmF2SkZiamZaMDllM3BtQXJWbkt1MXB1ajhXcmVEZldDUjJzOENkc01M?=
 =?utf-8?B?d2V6TzhMRGFZaWdzUWJNSzhjTlN1L0JYc1pyWXdnZzZXcGRyaWRhUFVWL2c1?=
 =?utf-8?B?ZThnUit0cjZ5V2E5QXVZWHpxUk5GZjNSYnBwTENnZ012RGp4Q1YrZ0JtOFJs?=
 =?utf-8?B?bEpUampjLzNIUUt4cHMwL2ZYaCtvREYzYUx6NlErK3dJTVJYRHJ3Z25LMkRz?=
 =?utf-8?B?WUwzQ0VWNStBUzBMT2laaWMyWW1mQitpOWk4M0hnbTdvdlRydmpEa0N2cC9w?=
 =?utf-8?B?VklqQTV6T1JDV01UUnB5Ty84NVY5NXVObjFvZ2RMc1lmTkk4eGdXSzNxSU0x?=
 =?utf-8?B?MlJBZlZxenNielc0NjNWam12THBtNEpDVHlzTlpzdERZUjdUNy9FYlRHRWhs?=
 =?utf-8?B?bkhvOTVLNnF3MVhOcmxXWXdWMW5telhwN3Q0dmQzeHRDbzFnVkJBMlV0WGVO?=
 =?utf-8?B?ZnNSUHNLa2FERUNWSkFwMTBqdlVybDh1NjJyNFB0RU1Nb3JyM0JNMHc4Zk9y?=
 =?utf-8?B?aEI5Q1FheFQ3VnpHS0I5TVZTT0dkUHY0ZTZLeStZRjRvS3o0Vlp0S0cyTTFo?=
 =?utf-8?B?NVN1SWRlcHRJblNWTUd2MXJsVFM2M2Izc1c1NThHUjJsMkVFZzEzaVlXTEZt?=
 =?utf-8?B?RkdtSzBvMXNFSWVQTHhLUHh2SEZhUTVNd2lpU1FhaGMyZFQzVVArR0Yzb3hN?=
 =?utf-8?B?RmUvWG9teUoxbk10WE5GaTVMK0dscUJyYUpwY3IxU2x2VDJjN3pFVkxHS0Zv?=
 =?utf-8?B?ZEJDVU1jT1JkNGhWU1ZEVUFwNTh4ZTR3NlltbEM0UlYvbitGSVhGenhSS1hW?=
 =?utf-8?B?TXQ3RDVCZUNLL2R5ZCszaHZEM2ExWUpLQWgxbUhocmY1U1RCaFcyejBGS1pP?=
 =?utf-8?B?T0U5Qi9wTFFINjYrZzNySFFMUHJCQ3NIMWxqTUpSL05wRE5kVVJjUWwvckN3?=
 =?utf-8?B?akhiOUE0anhXeHFOSkh2djJkR2dKVHBvK2J5MjV3cU1mTk5Bb3dzY1FBNnVm?=
 =?utf-8?B?YXZCdVNSUlN4am9YRzZBdXJsdEJEQU9PUkZQT2RRZS9zNlJSS1hvWDdUNnFR?=
 =?utf-8?B?azFqLzk4VmtZNCtrT0w5ZGF3UGE5R0lrQjdXVGp0Qmhwd01BajNSakMrQnFa?=
 =?utf-8?B?QkxXUUowWnB2OEVkaEhnUkQ5OEdkZkd2cFhtcGx6bzZmVGNNMDZXaXk5QmJC?=
 =?utf-8?B?d2gvcGpqM3pRR09Ob3VyYTFQbythaXBmd0dzOW00Q1NMTmRjTWpHZEFSQnJB?=
 =?utf-8?B?TGN3eXIyZzRHZDJQUXFXTHN6L1B5WFA5WjRkRGZZRkgzUnRkT3d5QjlJSzdG?=
 =?utf-8?B?SWd1WkpCVFU3cG1hNldERnVkc1hrU09iYXBiaGNMbTQrZWhyOXlUaWV1NWw4?=
 =?utf-8?B?cVN2M1FBeTVYTmEvUmp1eEw0L1pzeW5ObWdPYTNYeTJvbVRoUTV4ZitHSTNi?=
 =?utf-8?B?ZDZYb0RSNW95Zk8xSXVqSTJCUTFSNnVqY0I2d3l0Z3J4RWpxdjJoMSszTi8z?=
 =?utf-8?B?ZlpybkxoaXAvaGF5R0ZuOFVSc25FU0VJVHpUcTNxWHY2bHpOclNIYm9tRlJu?=
 =?utf-8?B?YTJTMEFXU2hmbFNDNHVKSEExMWZpTnRYMzIzN2tPUFR5dGVIbXBMZHZxQUR6?=
 =?utf-8?B?V1lYSXVKc3A1ZEZPaFFkZlhubGE0aHhRWHA2TllGZytrbDhPQzJ6SVZwclM2?=
 =?utf-8?B?d295Z1owLzdULzVBbTlVN0ZNQlIrblFkcWk0ZlJvRS9oOEJIS0xVWlBlZ2lQ?=
 =?utf-8?B?RnFXZGw3S1V6VHUzem1EbWhXelNCVm9RRnhUMHlQNU0veEhFdzZncE5oWmQy?=
 =?utf-8?B?K0F0N3lnQm5oR0xoTmZBaFA2MmhLM05ZaXY3U2dKVmJGU3B4dlZYdno0ZHBE?=
 =?utf-8?B?dCtTUXZKckMwbGZoeVZHMU9YajNKUVhoR2lVS3RibithSzhUZnkyUm4wdXFG?=
 =?utf-8?B?Q2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb8ce4f9-b010-43cd-2838-08db1c8b6799
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2023 08:35:26.8898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GIoeK3PyTI+QHNhoKkP1c1lQvXw/1wviRk4QaZw1NntGp4TKMHyArz8sENCjTLkJu8EiItKUrTAId7SoqZrSbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6919
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 04 Mar 2023 08:35:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10929

On 03.03.23 13:48, Felix Moessbauer wrote:
> This patch adds the opensbi firmware with u-boot payload (smode) for the
> qemu-riscv64 machine. Using that, the generated riscv64 images can be
> booted on qemu.
> 
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
>  recipes-bsp/opensbi/files/qemu-riscv64-rules  | 12 ++++
>  .../opensbi/opensbi-qemu-riscv64_1.2.bb       |  8 +++
>  recipes-bsp/opensbi/opensbi.inc               | 45 +++++++++++++++
>  ...iscv-Fix-build-against-binutils-2.38.patch | 55 +++++++++++++++++++
>  .../u-boot/u-boot-qemu-riscv64_2022.07.bb     | 22 ++++++++
>  5 files changed, 142 insertions(+)
>  create mode 100644 recipes-bsp/opensbi/files/qemu-riscv64-rules
>  create mode 100644 recipes-bsp/opensbi/opensbi-qemu-riscv64_1.2.bb
>  create mode 100644 recipes-bsp/opensbi/opensbi.inc
>  create mode 100644 recipes-bsp/u-boot/files/riscv64/0001-riscv-Fix-build-against-binutils-2.38.patch
>  create mode 100644 recipes-bsp/u-boot/u-boot-qemu-riscv64_2022.07.bb
> 
> diff --git a/recipes-bsp/opensbi/files/qemu-riscv64-rules b/recipes-bsp/opensbi/files/qemu-riscv64-rules
> new file mode 100644
> index 0000000..960e10c
> --- /dev/null
> +++ b/recipes-bsp/opensbi/files/qemu-riscv64-rules
> @@ -0,0 +1,12 @@
> +#!/usr/bin/make -f
> +
> +ifneq ($(DEB_BUILD_GNU_TYPE),$(DEB_HOST_GNU_TYPE))
> +export CROSS_COMPILE=$(DEB_HOST_GNU_TYPE)-
> +endif
> +
> +override_dh_auto_build:
> +	CFLAGS= LDFLAGS= $(MAKE) $(PARALLEL_MAKE) PLATFORM=generic \
> +		FW_PAYLOAD_PATH=/usr/lib/u-boot/qemu-riscv64/u-boot.bin
> +
> +%:
> +	dh $@
> diff --git a/recipes-bsp/opensbi/opensbi-qemu-riscv64_1.2.bb b/recipes-bsp/opensbi/opensbi-qemu-riscv64_1.2.bb
> new file mode 100644
> index 0000000..b503afc
> --- /dev/null
> +++ b/recipes-bsp/opensbi/opensbi-qemu-riscv64_1.2.bb
> @@ -0,0 +1,8 @@
> +#
> +# Copyright (c) Siemens AG, 2023
> +#
> +# SPDX-License-Identifier: MIT
> +
> +include opensbi.inc
> +
> +SRC_URI[opensbi.sha256sum] = "8fcbce598a73acc2c7f7d5607d46b9d5107d3ecbede8f68f42631dcfc25ef2b2"
> diff --git a/recipes-bsp/opensbi/opensbi.inc b/recipes-bsp/opensbi/opensbi.inc
> new file mode 100644
> index 0000000..b41a8bb
> --- /dev/null
> +++ b/recipes-bsp/opensbi/opensbi.inc
> @@ -0,0 +1,45 @@
> +#
> +# Copyright (c) Siemens AG, 2023
> +#
> +# SPDX-License-Identifier: MIT
> +
> +inherit dpkg
> +
> +U_BOOT_PACKAGE ?= "u-boot-${MACHINE}"
> +PLATFORM ?= "generic"
> +
> +DEPLOYDIR_FIRMWARE = "${WORKDIR}/deploy-fw"
> +SSTATETASKS += "do_deploy"
> +
> +SRC_URI = " \
> +    https://github.com/riscv/opensbi/archive/v${PV}.tar.gz;downloadfilename=opensbi-${PV}.tar.gz;name=opensbi \
> +    file://${MACHINE}-rules"

This triggers fetcher warnings for other machines. Moving to the
machine-specific recipe.

Jan

> +
> +S = "${WORKDIR}/opensbi-${PV}"
> +
> +DEPENDS += "${U_BOOT_PACKAGE}"
> +DEBIAN_BUILD_DEPENDS .= ",${U_BOOT_PACKAGE}"
> +
> +do_prepare_build[cleandirs] += "${S}/debian"
> +do_prepare_build() {
> +    cp ${WORKDIR}/${MACHINE}-rules ${WORKDIR}/rules
> +    deb_debianize
> +
> +    echo "build/platform/${PLATFORM}/firmware/fw_payload.bin /usr/lib/opensbi/${MACHINE}/" > ${S}/debian/install
> +}
> +
> +do_deploy[cleandirs] += "${DEPLOYDIR_FIRMWARE}"
> +do_deploy[sstate-inputdirs] = "${DEPLOYDIR_FIRMWARE}"
> +do_deploy[sstate-outputdirs] = "${DEPLOY_DIR_IMAGE}"
> +do_deploy() {
> +    dpkg --fsys-tarfile "${WORKDIR}/${PN}_${PV}_${DISTRO_ARCH}.deb" | \
> +        tar xOf - "./usr/lib/opensbi/${MACHINE}/fw_payload.bin" \
> +        > "${DEPLOYDIR_FIRMWARE}/fw_payload.bin"
> +}
> +
> +python do_deploy_setscene () {
> +    sstate_setscene(d)
> +}
> +addtask do_deploy_setscene
> +
> +addtask deploy after do_dpkg_build before do_deploy_deb
> diff --git a/recipes-bsp/u-boot/files/riscv64/0001-riscv-Fix-build-against-binutils-2.38.patch b/recipes-bsp/u-boot/files/riscv64/0001-riscv-Fix-build-against-binutils-2.38.patch
> new file mode 100644
> index 0000000..6f8a2ae
> --- /dev/null
> +++ b/recipes-bsp/u-boot/files/riscv64/0001-riscv-Fix-build-against-binutils-2.38.patch
> @@ -0,0 +1,55 @@
> +From 5df4b2299f86933fa79aa3bc6a3986fc7e55b7e0 Mon Sep 17 00:00:00 2001
> +From: Alexandre Ghiti <alexandre.ghiti@canonical.com>
> +Date: Mon, 3 Oct 2022 18:07:54 +0200
> +Subject: [PATCH 1/2] riscv: Fix build against binutils 2.38
> +
> +The following description is copied from the equivalent patch for the
> +Linux Kernel proposed by Aurelien Jarno:
> +
> +>From version 2.38, binutils default to ISA spec version 20191213. This
> +means that the csr read/write (csrr*/csrw*) instructions and fence.i
> +instruction has separated from the `I` extension, become two standalone
> +extensions: Zicsr and Zifencei. As the kernel uses those instruction,
> +this causes the following build failure:
> +
> +arch/riscv/cpu/mtrap.S: Assembler messages:
> +arch/riscv/cpu/mtrap.S:65: Error: unrecognized opcode `csrr a0,scause'
> +arch/riscv/cpu/mtrap.S:66: Error: unrecognized opcode `csrr a1,sepc'
> +arch/riscv/cpu/mtrap.S:67: Error: unrecognized opcode `csrr a2,stval'
> +arch/riscv/cpu/mtrap.S:70: Error: unrecognized opcode `csrw sepc,a0'
> +
> +Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
> +Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
> +Tested-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> +Tested-by: Heiko Stuebner <heiko@sntech.de>
> +Tested-by: Christian Stewart <christian@paral.in>
> +Reviewed-by: Rick Chen <rick@andestech.com>
> +---
> + arch/riscv/Makefile | 11 ++++++++++-
> + 1 file changed, 10 insertions(+), 1 deletion(-)
> +
> +diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> +index 0b80eb8d86..53d1194ffb 100644
> +--- a/arch/riscv/Makefile
> ++++ b/arch/riscv/Makefile
> +@@ -24,7 +24,16 @@ ifeq ($(CONFIG_CMODEL_MEDANY),y)
> + 	CMODEL = medany
> + endif
> + 
> +-ARCH_FLAGS = -march=$(ARCH_BASE)$(ARCH_A)$(ARCH_C) -mabi=$(ABI) \
> ++RISCV_MARCH = $(ARCH_BASE)$(ARCH_A)$(ARCH_C)
> ++
> ++# Newer binutils versions default to ISA spec version 20191213 which moves some
> ++# instructions from the I extension to the Zicsr and Zifencei extensions.
> ++toolchain-need-zicsr-zifencei := $(call cc-option-yn, -mabi=$(ABI) -march=$(RISCV_MARCH)_zicsr_zifencei)
> ++ifeq ($(toolchain-need-zicsr-zifencei),y)
> ++	RISCV_MARCH := $(RISCV_MARCH)_zicsr_zifencei
> ++endif
> ++
> ++ARCH_FLAGS = -march=$(RISCV_MARCH) -mabi=$(ABI) \
> + 	     -mcmodel=$(CMODEL)
> + 
> + PLATFORM_CPPFLAGS	+= $(ARCH_FLAGS)
> +-- 
> +2.30.2
> +
> diff --git a/recipes-bsp/u-boot/u-boot-qemu-riscv64_2022.07.bb b/recipes-bsp/u-boot/u-boot-qemu-riscv64_2022.07.bb
> new file mode 100644
> index 0000000..8dfac45
> --- /dev/null
> +++ b/recipes-bsp/u-boot/u-boot-qemu-riscv64_2022.07.bb
> @@ -0,0 +1,22 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2022
> +#
> +# Authors:
> +#  Jan Kiszka <jan.kiszka@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +require u-boot-qemu-common.inc
> +
> +# we run as OpenSBI payload, hence use smode
> +U_BOOT_CONFIG = "${MACHINE}_smode_defconfig"
> +
> +EFI_ARCH = "riscv64"
> +
> +SRC_URI += " \
> +    file://riscv64/0001-riscv-Fix-build-against-binutils-2.38.patch"
> +
> +U_BOOT_BIN = "u-boot.bin"

-- 
Siemens AG, Technology
Competence Center Embedded Linux


