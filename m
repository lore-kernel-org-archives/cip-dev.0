Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB896C43217
	for <webhook@archiver.kernel.org>; Fri, 12 Nov 2021 12:46:06 +0000 (UTC)
Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web10.15266.1636721165192475883
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Nov 2021 04:46:05 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.14, mailfrom: jan.kiszka@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 1ACCk2SL013488
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Fri, 12 Nov 2021 13:46:03 +0100
Received: from [167.87.32.54] ([167.87.32.54])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1ACCk2M6030196;
	Fri, 12 Nov 2021 13:46:02 +0100
Subject: Re: [cip-dev][isar-cip-core][RFC 3/8] linux-cip-common: Add options
 necessary for dm-verity
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>,
        cip-dev@lists.cip-project.org
References: <20211112115017.401779-1-Quirin.Gylstorff@siemens.com>
 <20211112115017.401779-5-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <3d36e221-8750-39da-0774-e5bf3bbcc17d@siemens.com>
Date: Fri, 12 Nov 2021 13:46:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211112115017.401779-5-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Nov 2021 12:46:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6892

On 12.11.21 12:50, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> CIP Kernel Config does not contain support for dm-verity
> squashfs. Overlay_FS support is added for etc-overlay.
> 

This should be quickly addressed by expanding the configs of all boards
we want to enable this way. Start with QEMU and the IPCs. Otherwise, we
risk to ignore this subsystem /wrt CVEs.

> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  recipes-kernel/linux/files/verity.cfg     | 5 +++++
>  recipes-kernel/linux/linux-cip-common.inc | 6 ++++++
>  2 files changed, 11 insertions(+)
>  create mode 100644 recipes-kernel/linux/files/verity.cfg
> 
> diff --git a/recipes-kernel/linux/files/verity.cfg b/recipes-kernel/linux/files/verity.cfg
> new file mode 100644
> index 0000000..35d8208
> --- /dev/null
> +++ b/recipes-kernel/linux/files/verity.cfg
> @@ -0,0 +1,5 @@
> +CONFIG_BLK_DEV_DM=y
> +CONFIG_DM_VERITY=y
> +CONFIG_DM_CRYPT=y
> +CONFIG_SQUASHFS=y
> +CONFIG_OVERLAY_FS=y
> diff --git a/recipes-kernel/linux/linux-cip-common.inc b/recipes-kernel/linux/linux-cip-common.inc
> index 1afec88..0792371 100644
> --- a/recipes-kernel/linux/linux-cip-common.inc
> +++ b/recipes-kernel/linux/linux-cip-common.inc
> @@ -28,3 +28,9 @@ SRC_URI_append_bbb = "file://${KERNEL_DEFCONFIG}"
>  SRCREV_cip-kernel-config ?= "cd5d43e99f4d5f20707d7ac1e721bb22d4c9e16e"
>  
>  S = "${WORKDIR}/linux-cip-v${PV}"
> +
> +SRC_URI += "file://verity.cfg"
> +
> +do_prepare_build_prepend() {
> +    cat ${WORKDIR}/verity.cfg >> ${WORKDIR}/${KERNEL_DEFCONFIG}
> +}
> 

This should be appended conditionally, when building a secure image, I
would say.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

