Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9362AC433EF
	for <webhook@archiver.kernel.org>; Fri, 12 Nov 2021 12:41:51 +0000 (UTC)
Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web10.15208.1636720909959408024
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Nov 2021 04:41:50 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 194.138.37.40, mailfrom: jan.kiszka@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 1ACCfiYf014151
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Fri, 12 Nov 2021 13:41:44 +0100
Received: from [167.87.32.54] ([167.87.32.54])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1ACCfix1027251;
	Fri, 12 Nov 2021 13:41:44 +0100
Subject: Re: [cip-dev][isar-cip-core][RFC 1/8] Add new class to create a
 squashfs based root file system
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>,
        cip-dev@lists.cip-project.org
References: <20211112115017.401779-1-Quirin.Gylstorff@siemens.com>
 <20211112115017.401779-2-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <84cdc4e8-b077-ec4a-ef97-eab061bab14f@siemens.com>
Date: Fri, 12 Nov 2021 13:41:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211112115017.401779-2-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Nov 2021 12:41:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6891

On 12.11.21 12:50, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This file system is read only and use a reduced image size.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  classes/squashfs-img.bbclass | 42 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 classes/squashfs-img.bbclass
> 
> diff --git a/classes/squashfs-img.bbclass b/classes/squashfs-img.bbclass
> new file mode 100644
> index 0000000..f827e8c
> --- /dev/null
> +++ b/classes/squashfs-img.bbclass
> @@ -0,0 +1,42 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2021
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +SQUASHFS_IMAGE_FILE = "${IMAGE_FULLNAME}.squashfs.img"
> +
> +IMAGER_INSTALL += "squashfs-tools"
> +
> +SQUASHFS_EXCLUDE_DIRS ?= ""
> +SQUASHFS_CONTENT ?= "${PP_ROOTFS}"
> +SQUASHFS_CREATION_ARGS ?= " "

Blank line after this.

> +# Generate squashfs filesystem image

I don't think the anonymous function does that...

> +python __anonymous() {
> +    exclude_directories = (d.getVar('SQUASHFS_EXCLUDE_DIRS') or "").split()
> +    if len(exclude_directories) == 0:
> +        return
> +    args=d.getVar('SQUASHFS_CREATION_ARGS')
> +    args+=" -wildcards"
> +    # use wildcard to exclude only content of the the directory
> +    # this allows to use the directory as a mount point
> +    for dir in exclude_directories:
> +        args+=" -e {dir}/* ".format(dir=dir)
> +    d.setVar('SQUASHFS_CREATION_ARGS', args)

How about d.appendVar?

And Python style for python functions, please.

> +}
> +
> +do_squashfs_image() {
> +    rm -f '${DEPLOY_DIR_IMAGE}/${SQUASHFS_IMAGE_FILE}'
> +
> +    image_do_mounts
> +
> +    sudo chroot "${BUILDCHROOT_DIR}" /bin/mksquashfs  \
> +        "${SQUASHFS_CONTENT}" "${PP_DEPLOY}/${SQUASHFS_IMAGE_FILE}" \
> +        ${SQUASHFS_CREATION_ARGS}
> +}
> +addtask do_squashfs_image before do_image after do_image_tools do_excl_directories
> 

This should also qualify as generic Isar class. It can start here, though.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

