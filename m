Return-Path: <s-adivi@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B21C5AD49
	for <webhook@archiver.kernel.org>; Wed, 28 May 2025 14:03:48 +0000 (UTC)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 by mx.groups.io with SMTP id smtpd.web11.16533.1748441022525797917
 for <cip-dev@lists.cip-project.org>;
 Wed, 28 May 2025 07:03:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=e3SoCl8n;
 spf=pass (domain: ti.com, ip: 198.47.19.245, mailfrom: s-adivi@ti.com)
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 54SE3fYA3284730;
	Wed, 28 May 2025 09:03:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1748441021;
	bh=D2r20Xlb2XlQYhKDpQLIlcII8KKx4AQSLPfqGbHK0lI=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=e3SoCl8nOLpqVx9uDRiZXO83lPZ/1+GwdOVfgmcSeP46Y0Y1bFV4z8PMkP3l0ASa/
	 M51Ew9Rjz9Ct2fElCxGiwItkAB5TiQCxtQAStd3Ysw6p9t3BQZkLlA2T+5TBG0pVPf
	 VgmOc6oLSKhLfvklM2w2QZD00bqvKGiOPmcyblzA=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 54SE3fCb3612106
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 28 May 2025 09:03:41 -0500
Received: from flwvowa01.ent.ti.com (10.64.41.90) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 May 2025 09:03:41 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by flwvowa01.ent.ti.com
 (10.64.41.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2507.34; Wed, 28 May
 2025 09:03:41 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 May 2025 09:03:41 -0500
Received: from [10.249.138.8] ([10.249.138.8])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 54SE3dI3214629;
	Wed, 28 May 2025 09:03:40 -0500
Message-ID: <b37a0484-2775-4bf2-a5d1-739cc3c251d2@ti.com>
Date: Wed, 28 May 2025 19:33:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2 3/5] Expose kernel branch head recipes
 via kas option and Kconfig
To: Jan Kiszka <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
References: <cover.1748011667.git.jan.kiszka@siemens.com>
 <5f42c016426fb5ce955c4eae42a9fbc0c041c8c5.1748011667.git.jan.kiszka@siemens.com>
Content-Language: en-US
From: "Adivi, Sai Sree Kartheek" <s-adivi@ti.com>
In-Reply-To: <5f42c016426fb5ce955c4eae42a9fbc0c041c8c5.1748011667.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 28 May 2025 14:03:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18955



On 5/23/2025 8:17 PM, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> The kas option file adjusts the PREFERRED_VERSION for the CIP kernel so
> that the corresponding head recipe is selected. This avoids having to
> define an option for each kernel version series.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Acked-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>

> ---
>   Kconfig                 | 11 +++++++++++
>   kas/opt/kernel-head.yml | 18 ++++++++++++++++++
>   2 files changed, 29 insertions(+)
>   create mode 100644 kas/opt/kernel-head.yml
> 
> diff --git a/Kconfig b/Kconfig
> index 0887125a..18560292 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -113,6 +113,17 @@ config KAS_INCLUDE_KERNEL
>   	default "kas/opt/6.1.yml" if KERNEL_6_1
>   	default "kas/opt/6.12.yml" if KERNEL_6_12
>   
> +config KERNEL_HEAD
> +	bool "Head of selected CIP kernel branch"
> +	help
> +	  Build head of the git branch that corresponds to the selected CIP
> +	  kernel. May point to an unreleased state.
> +
> +config KAS_INCLUDE_KERNEL_HEAD
> +	string
> +	default "kas/opt/kernel-head.yml"
> +	depends on KERNEL_HEAD
> +
>   config KERNEL_RT
>   	bool "Real-time CIP kernel"
>   	depends on !ARCH_RISCV64 || KERNEL_6_12
> diff --git a/kas/opt/kernel-head.yml b/kas/opt/kernel-head.yml
> new file mode 100644
> index 00000000..abb4d624
> --- /dev/null
> +++ b/kas/opt/kernel-head.yml
> @@ -0,0 +1,18 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens, 2025
> +#
> +# Authors:
> +#  Jan Kiszka <jan.kiszka@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +header:
> +  version: 14
> +
> +local_conf_header:
> +  kernel-version-head: |
> +    PREFERRED_VERSION_linux-cip := "${@d.getVar('PREFERRED_VERSION_linux-cip').rsplit('.', 1)[0] + '-cip-head%'}"
> +    PREFERRED_VERSION_linux-cip-rt := "${@d.getVar('PREFERRED_VERSION_linux-cip-rt').rsplit('.', 1)[0] + '-cip-head%'}"


