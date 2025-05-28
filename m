Return-Path: <s-adivi@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0D8C5AD49
	for <webhook@archiver.kernel.org>; Wed, 28 May 2025 14:03:08 +0000 (UTC)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 by mx.groups.io with SMTP id smtpd.web11.16512.1748440979453680371
 for <cip-dev@lists.cip-project.org>;
 Wed, 28 May 2025 07:02:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=tNw0Q3Vh;
 spf=pass (domain: ti.com, ip: 198.47.19.246, mailfrom: s-adivi@ti.com)
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 54SE2xZF2080478;
	Wed, 28 May 2025 09:02:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1748440979;
	bh=mOjtLe18cyu70iljXoRO/fQUDPm+X4d8b72qODrhd4U=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=tNw0Q3VhtW197uw16rbcBD1donUT3o3h3H1HQBnZz54wFvjL5EP7xPWy2prcjzmKn
	 XwlrYbel0/edadVMI25xQ49CUE++d2qR8xF09YLZKdS7C1IwNoOjAd3PfagZlA5BZR
	 Lc9VQsvZRAXCP3Jzs77AvDT5Wojwa/prWd9C7f/o=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 54SE2wqn3654560
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 28 May 2025 09:02:59 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 May 2025 09:02:58 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 May 2025 09:02:58 -0500
Received: from [10.249.138.8] ([10.249.138.8])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 54SE2uas172461;
	Wed, 28 May 2025 09:02:57 -0500
Message-ID: <2e3fbdc6-7b1a-4560-9aee-2365c4218afe@ti.com>
Date: Wed, 28 May 2025 19:32:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2 2/5] linux-cip: Add support for building
 head of development branches
To: Jan Kiszka <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
References: <cover.1748011667.git.jan.kiszka@siemens.com>
 <b366bf734ebff44f67fd6e2632582c7172ac54ff.1748011667.git.jan.kiszka@siemens.com>
Content-Language: en-US
From: "Adivi, Sai Sree Kartheek" <s-adivi@ti.com>
In-Reply-To: <b366bf734ebff44f67fd6e2632582c7172ac54ff.1748011667.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 28 May 2025 14:03:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18954



On 5/23/2025 8:17 PM, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Add a recipe for each CIP kernel version series that selects via AUTOREV
> the head of the related git branch and builds the kernel from it. This
> enables earlier testing via isar-cip-core.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Acked-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>

> ---
>   recipes-kernel/linux/linux-cip-head.inc       | 34 +++++++++++++++++++
>   .../linux/linux-cip-rt_4.19-cip-head.bb       |  1 +
>   .../linux/linux-cip-rt_4.4-cip-head.bb        |  1 +
>   .../linux/linux-cip-rt_5.10-cip-head.bb       |  1 +
>   .../linux/linux-cip-rt_6.1-cip-head.bb        |  1 +
>   .../linux/linux-cip-rt_6.12-cip-head.bb       |  1 +
>   .../linux/linux-cip_4.19-cip-head.bb          |  1 +
>   .../linux/linux-cip_4.4-cip-head.bb           |  1 +
>   .../linux/linux-cip_5.10-cip-head.bb          |  1 +
>   .../linux/linux-cip_6.1-cip-head.bb           |  1 +
>   .../linux/linux-cip_6.12-cip-head.bb          |  1 +
>   scripts/update-linux-cip.sh                   |  6 ++--
>   12 files changed, 47 insertions(+), 3 deletions(-)
>   create mode 100644 recipes-kernel/linux/linux-cip-head.inc
>   create mode 120000 recipes-kernel/linux/linux-cip-rt_4.19-cip-head.bb
>   create mode 120000 recipes-kernel/linux/linux-cip-rt_4.4-cip-head.bb
>   create mode 120000 recipes-kernel/linux/linux-cip-rt_5.10-cip-head.bb
>   create mode 120000 recipes-kernel/linux/linux-cip-rt_6.1-cip-head.bb
>   create mode 120000 recipes-kernel/linux/linux-cip-rt_6.12-cip-head.bb
>   create mode 120000 recipes-kernel/linux/linux-cip_4.19-cip-head.bb
>   create mode 120000 recipes-kernel/linux/linux-cip_4.4-cip-head.bb
>   create mode 120000 recipes-kernel/linux/linux-cip_5.10-cip-head.bb
>   create mode 120000 recipes-kernel/linux/linux-cip_6.1-cip-head.bb
>   create mode 120000 recipes-kernel/linux/linux-cip_6.12-cip-head.bb
> 
> diff --git a/recipes-kernel/linux/linux-cip-head.inc b/recipes-kernel/linux/linux-cip-head.inc
> new file mode 100644
> index 00000000..df604db0
> --- /dev/null
> +++ b/recipes-kernel/linux/linux-cip-head.inc
> @@ -0,0 +1,34 @@
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
> +require linux-cip-common.inc
> +
> +def get_commit(d):
> +    try:
> +        return bb.fetch2.get_srcrev(d).replace('AUTOINC+', '')
> +    except bb.fetch2.FetchError:
> +        return ""
> +
> +KERNEL_MAJOR_MINOR := "${@d.getVar('PV').split('-')[0]}"
> +
> +BRANCH := "${@ \
> +    'linux-' + d.getVar('PV').split('-')[0] + '.y-cip' + \
> +    ('-rt' if d.getVar('KERNEL_NAME') == 'cip-rt' and \
> +              d.getVar('KERNEL_MAJOR_MINOR') in ['4.4', '4.19', '5.10', '6.1'] else '') \
> +    }"
> +
> +PV .= "${@'-g' + get_commit(d)}"
> +
> +SRC_URI += "git://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git;protocol=https;branch=${BRANCH};name=cip-kernel"
> +SRCREV_FORMAT = "cip-kernel"
> +SRCREV_cip-kernel = "${AUTOREV}"
> +
> +S = "${WORKDIR}/git"
> diff --git a/recipes-kernel/linux/linux-cip-rt_4.19-cip-head.bb b/recipes-kernel/linux/linux-cip-rt_4.19-cip-head.bb
> new file mode 120000
> index 00000000..8f99b54e
> --- /dev/null
> +++ b/recipes-kernel/linux/linux-cip-rt_4.19-cip-head.bb
> @@ -0,0 +1 @@
> +linux-cip-head.inc
> \ No newline at end of file
> diff --git a/recipes-kernel/linux/linux-cip-rt_4.4-cip-head.bb b/recipes-kernel/linux/linux-cip-rt_4.4-cip-head.bb
> new file mode 120000
> index 00000000..8f99b54e
> --- /dev/null
> +++ b/recipes-kernel/linux/linux-cip-rt_4.4-cip-head.bb
> @@ -0,0 +1 @@
> +linux-cip-head.inc
> \ No newline at end of file
> diff --git a/recipes-kernel/linux/linux-cip-rt_5.10-cip-head.bb b/recipes-kernel/linux/linux-cip-rt_5.10-cip-head.bb
> new file mode 120000
> index 00000000..8f99b54e
> --- /dev/null
> +++ b/recipes-kernel/linux/linux-cip-rt_5.10-cip-head.bb
> @@ -0,0 +1 @@
> +linux-cip-head.inc
> \ No newline at end of file
> diff --git a/recipes-kernel/linux/linux-cip-rt_6.1-cip-head.bb b/recipes-kernel/linux/linux-cip-rt_6.1-cip-head.bb
> new file mode 120000
> index 00000000..8f99b54e
> --- /dev/null
> +++ b/recipes-kernel/linux/linux-cip-rt_6.1-cip-head.bb
> @@ -0,0 +1 @@
> +linux-cip-head.inc
> \ No newline at end of file
> diff --git a/recipes-kernel/linux/linux-cip-rt_6.12-cip-head.bb b/recipes-kernel/linux/linux-cip-rt_6.12-cip-head.bb
> new file mode 120000
> index 00000000..8f99b54e
> --- /dev/null
> +++ b/recipes-kernel/linux/linux-cip-rt_6.12-cip-head.bb
> @@ -0,0 +1 @@
> +linux-cip-head.inc
> \ No newline at end of file
> diff --git a/recipes-kernel/linux/linux-cip_4.19-cip-head.bb b/recipes-kernel/linux/linux-cip_4.19-cip-head.bb
> new file mode 120000
> index 00000000..8f99b54e
> --- /dev/null
> +++ b/recipes-kernel/linux/linux-cip_4.19-cip-head.bb
> @@ -0,0 +1 @@
> +linux-cip-head.inc
> \ No newline at end of file
> diff --git a/recipes-kernel/linux/linux-cip_4.4-cip-head.bb b/recipes-kernel/linux/linux-cip_4.4-cip-head.bb
> new file mode 120000
> index 00000000..8f99b54e
> --- /dev/null
> +++ b/recipes-kernel/linux/linux-cip_4.4-cip-head.bb
> @@ -0,0 +1 @@
> +linux-cip-head.inc
> \ No newline at end of file
> diff --git a/recipes-kernel/linux/linux-cip_5.10-cip-head.bb b/recipes-kernel/linux/linux-cip_5.10-cip-head.bb
> new file mode 120000
> index 00000000..8f99b54e
> --- /dev/null
> +++ b/recipes-kernel/linux/linux-cip_5.10-cip-head.bb
> @@ -0,0 +1 @@
> +linux-cip-head.inc
> \ No newline at end of file
> diff --git a/recipes-kernel/linux/linux-cip_6.1-cip-head.bb b/recipes-kernel/linux/linux-cip_6.1-cip-head.bb
> new file mode 120000
> index 00000000..8f99b54e
> --- /dev/null
> +++ b/recipes-kernel/linux/linux-cip_6.1-cip-head.bb
> @@ -0,0 +1 @@
> +linux-cip-head.inc
> \ No newline at end of file
> diff --git a/recipes-kernel/linux/linux-cip_6.12-cip-head.bb b/recipes-kernel/linux/linux-cip_6.12-cip-head.bb
> new file mode 120000
> index 00000000..8f99b54e
> --- /dev/null
> +++ b/recipes-kernel/linux/linux-cip_6.12-cip-head.bb
> @@ -0,0 +1 @@
> +linux-cip-head.inc
> \ No newline at end of file
> diff --git a/scripts/update-linux-cip.sh b/scripts/update-linux-cip.sh
> index df70fe2c..8e3647e4 100755
> --- a/scripts/update-linux-cip.sh
> +++ b/scripts/update-linux-cip.sh
> @@ -16,12 +16,12 @@ for MAJOR_VERSION in 4.4 4.19 5.10 6.1 6.12; do
>   	RECIPE_FILE=linux-cip_${VERSION}.bb
>   	if [ ! -f ${RECIPE_FILE} ]; then
>   		echo "Updating recipe to ${VERSION}"
> -		git mv linux-cip_${MAJOR_VERSION}*.bb ${RECIPE_FILE}
> +		git mv linux-cip_${MAJOR_VERSION}.*.bb ${RECIPE_FILE}
>   		SHASUM=${LAST_ENTRY/ */}
>   		sed -i 's/\(SRC_URI\[sha256sum\] = "\).*/\1'${SHASUM}'"'/ ${RECIPE_FILE}
>   		git add ${RECIPE_FILE}
>   		if [ "${MAJOR_VERSION}" == "6.12" ]; then
> -			git rm linux-cip-rt_${MAJOR_VERSION}*.bb
> +			git rm linux-cip-rt_${MAJOR_VERSION}.*.bb
>   			ln -s ${RECIPE_FILE} linux-cip-rt_${VERSION}.bb
>   			git add linux-cip-rt_${VERSION}.bb
>   		fi
> @@ -34,7 +34,7 @@ for MAJOR_VERSION in 4.4 4.19 5.10 6.1 6.12; do
>   		RECIPE_FILE=linux-cip-rt_${VERSION}.bb
>   		if [ ! -f "${RECIPE_FILE}" ]; then
>   			echo "Updating recipe to ${VERSION}"
> -			git mv linux-cip-rt_${MAJOR_VERSION}*.bb ${RECIPE_FILE}
> +			git mv linux-cip-rt_${MAJOR_VERSION}.*.bb ${RECIPE_FILE}
>   			SHASUM=${LAST_ENTRY/ */}
>   			sed -i 's/\(SRC_URI\[sha256sum\] = "\).*/\1'${SHASUM}'"'/ ${RECIPE_FILE}
>   			git add ${RECIPE_FILE}


