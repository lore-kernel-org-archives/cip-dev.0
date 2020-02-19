Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 680C4C013E
 for <cip-dev@lists.cip-project.org>; Wed, 19 Feb 2020 09:14:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 645FF84BA9
 for <cip-dev@lists.cip-project.org>; Wed, 19 Feb 2020 09:14:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cgToo+xbT1O4 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Feb 2020 09:14:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by hemlock.osuosl.org (Postfix) with ESMTPS id CB132840EA
 for <cip-dev@lists.cip-project.org>; Wed, 19 Feb 2020 09:14:34 +0000 (UTC)
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
 by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 01J9EWJp030582
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cip-dev@lists.cip-project.org>; Wed, 19 Feb 2020 10:14:32 +0100
Received: from [139.22.123.32] ([139.22.123.32])
 by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 01J9EWrq007675;
 Wed, 19 Feb 2020 10:14:32 +0100
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20200219085823.21768-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <7170f818-2825-0fb2-2799-7e936609fac3@siemens.com>
Date: Wed, 19 Feb 2020 10:14:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200219085823.21768-1-Quirin.Gylstorff@siemens.com>
Subject: Re: [isar-cip-core PATCH] recipes-core: Add Linux Testing Projects Package
X-BeenThere: cip-dev@lists.cip-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: <cip-dev.lists.cip-project.org>
List-Unsubscribe: <https://lists.cip-project.org/mailman/options/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=unsubscribe>
List-Archive: <http://lists.cip-project.org/pipermail/cip-dev/>
List-Post: <mailto:cip-dev@lists.cip-project.org>
List-Help: <mailto:cip-dev-request@lists.cip-project.org?subject=help>
List-Subscribe: <https://lists.cip-project.org/mailman/listinfo/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=subscribe>
X-List-Received-Date: Wed, 19 Feb 2020 09:14:36 -0000
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; format="flowed"

On 19.02.20 09:58, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Add a package for the LTP(Linux Testing Porject) to execute
> the LTP testcases from cip-testing
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>   recipes-core/images/cip-core-image.bb |  2 ++
>   recipes-core/ltp/files/debian/control | 18 ++++++++++++++++++
>   recipes-core/ltp/files/debian/rules   |  5 +++++
>   recipes-core/ltp/ltp-full_20190930.bb | 27 +++++++++++++++++++++++++++
>   4 files changed, 52 insertions(+)
>   create mode 100644 recipes-core/ltp/files/debian/control
>   create mode 100755 recipes-core/ltp/files/debian/rules
>   create mode 100644 recipes-core/ltp/ltp-full_20190930.bb
> 
> diff --git a/recipes-core/images/cip-core-image.bb b/recipes-core/images/cip-core-image.bb
> index 179016c..9ee4b25 100644
> --- a/recipes-core/images/cip-core-image.bb
> +++ b/recipes-core/images/cip-core-image.bb
> @@ -15,3 +15,5 @@ ISAR_RELEASE_CMD = "git -C ${LAYERDIR_cip-core} describe --tags --dirty --always
>   DESCRIPTION = "CIP Core image"
>   
>   IMAGE_INSTALL += "customizations"
> +# for cip-testing
> +IMAGE_INSTALL += "ltp-full"
> diff --git a/recipes-core/ltp/files/debian/control b/recipes-core/ltp/files/debian/control
> new file mode 100644
> index 0000000..5ec4b9d
> --- /dev/null
> +++ b/recipes-core/ltp/files/debian/control
> @@ -0,0 +1,18 @@
> +Source: ltp-full
> +Section: embedded
> +Priority: optional
> +Maintainer: Gylstorff Quirin <quirin.gylstorff@siemens.com>
> +Build-Depends: debhelper (>= 11), autotools-dev
> +Standards-Version: 4.1.3
> +Homepage: https://linux-test-project.github.io/
> +
> +Package: ltp-full
> +Architecture: any
> +Depends: ${shlibs:Depends}, ${misc:Depends}
> +Description: A collection of tools for testing the Linux kernel
> + The Linux Test Project is a joint project started by SGI,
> + developed and maintained by IBM, Cisco, Fujitsu, SUSE,
> + Red Hat and others, that has a goal to deliver test suites to the
> + open source community that validate the reliability, robustness,
> + and stability of Linux. The LTP testsuite contains a collection
> + of tools for testing the Linux kernel and related features.
> diff --git a/recipes-core/ltp/files/debian/rules b/recipes-core/ltp/files/debian/rules
> new file mode 100755
> index 0000000..48d3b83
> --- /dev/null
> +++ b/recipes-core/ltp/files/debian/rules
> @@ -0,0 +1,5 @@
> +#!/usr/bin/make -f
> +export DEB_CFLAGS_MAINT_APPEND  = -Wall  -Wno-format-security
> +%:
> +	dh $@  --with autoreconf
> +
> diff --git a/recipes-core/ltp/ltp-full_20190930.bb b/recipes-core/ltp/ltp-full_20190930.bb
> new file mode 100644
> index 0000000..fc35f5e
> --- /dev/null
> +++ b/recipes-core/ltp/ltp-full_20190930.bb
> @@ -0,0 +1,27 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2020
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +inherit dpkg
> +
> +DESCRIPTION = "Linux Test project for CIP"
> +
> +SRC_URI = " \
> +   https://github.com/linux-test-project/ltp/releases/download/20190930/ltp-full-${PV}.tar.xz \
> +   file://debian \
> +   "
> +SRC_URI[sha256sum] = "c7049590df2da3135030db5ef4c0076b76c789724a752b1102b4a01db0189f9a"
> +
> +
> +do_prepare_build() {
> +        cp -R ${WORKDIR}/debian ${S}
> +        deb_create_compat
> +        deb_add_changelog
> +}
> 

Thanks, applied to next.

Jan

-- 
Sie	mens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux


