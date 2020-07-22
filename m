Return-Path: <SRS0=rrF6=BB=lists.cip-project.org=bounce+64572+4955+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7A8C433E1
	for <cip-dev@archiver.kernel.org>; Wed, 22 Jul 2020 06:44:43 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4437207BB
	for <cip-dev@archiver.kernel.org>; Wed, 22 Jul 2020 06:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="QcS4VeaU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4437207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4955+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id MizBYY4521723xqx3UOSiH5i; Tue, 21 Jul 2020 23:44:42 -0700
X-Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web10.13399.1595400280988924967
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Jul 2020 23:44:41 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 06M6ibsf014378
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jul 2020 08:44:38 +0200
X-Received: from [167.87.24.251] ([167.87.24.251])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 06M6iaZq019269;
	Wed, 22 Jul 2020 08:44:37 +0200
Subject: Re: [cip-dev] [isar-cip-core] tests: put all tests into a opt layer
To: cip-dev@lists.cip-project.org,
        Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
References: <20200721124242.1479495-1-daniel.sangorrin@toshiba.co.jp>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <5cf9c07a-76a3-ab41-8d39-786876aa0c0d@siemens.com>
Date: Wed, 22 Jul 2020 08:44:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200721124242.1479495-1-daniel.sangorrin@toshiba.co.jp>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: lFG9JaSATKWrEXIi1dZuicaMx4520388AA=
Content-Type: multipart/mixed; boundary="VAwsVEtpP7jgilr64Iw2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595400282;
 bh=h/b+O+ireQx7aoR+zdO78/TaSGlg4nXwTFAwo4+9bsI=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=QcS4VeaUMcSAA1ACV9qFfjepkgBivx8sRKNib72Reoxf0iOLU0dk56jAr1XuDMVnSx0
 f4f47VzyJaX+17yQgcIXbMvbwfUjfG4AYCkgAb57e0wZ4Ej/h3/5S2dLck96tpnGkJP0f
 7+u/8U0IK1grsUXU4jjuUuHY96+WXo3Z4Xo=

--VAwsVEtpP7jgilr64Iw2
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 21.07.20 14:42, Daniel Sangorrin wrote:
> having an opt-tests layer makes it easier to see what
> tests are installed, and allows creating images without
> them as well

"Having ... as well."

Does this obsolete 
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/merge_requests/7, 
where I just commented on?

> 
> Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
> ---
>   .gitlab-ci.yml                                |  8 ++++----
>   README.md                                     |  4 ++++
>   opt-tests.yml                                 | 19 +++++++++++++++++++
>   recipes-core/customizations/customizations.bb |  5 ++---
>   recipes-core/images/cip-core-image.bb         |  3 +--
>   5 files changed, 30 insertions(+), 9 deletions(-)
>   create mode 100644 opt-tests.yml
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 6f1dc91..90eec1f 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -13,17 +13,17 @@ all:
>       - export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
>       - export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
>   
> -    - kas build kas.yml:board-simatic-ipc227e.yml:opt-rt.yml:opt-targz-img.yml
> +    - kas build kas.yml:board-simatic-ipc227e.yml:opt-tests.yml:opt-rt.yml:opt-targz-img.yml
>       - scripts/deploy-cip-core.sh buster simatic-ipc227e
>   
>       - sudo rm -rf build/tmp
> -    - kas build kas.yml:board-bbb.yml:opt-rt.yml:opt-targz-img.yml
> +    - kas build kas.yml:board-bbb.yml:opt-tests.yml:opt-rt.yml:opt-targz-img.yml
>       - scripts/deploy-cip-core.sh buster bbb am335x-boneblack.dtb
>   
>       - sudo rm -rf build/tmp
> -    - kas build kas.yml:board-iwg20m.yml:opt-rt.yml:opt-targz-img.yml
> +    - kas build kas.yml:board-iwg20m.yml:opt-tests.yml:opt-rt.yml:opt-targz-img.yml
>       - scripts/deploy-cip-core.sh buster iwg20m r8a7743-iwg20d-q7-dbcm-ca.dtb
>   
>       - sudo rm -rf build/tmp
> -    - kas build kas.yml:board-rzg2m.yml:opt-rt.yml:opt-targz-img.yml
> +    - kas build kas.yml:board-rzg2m.yml:opt-tests.yml:opt-rt.yml:opt-targz-img.yml
>       - scripts/deploy-cip-core.sh buster hihope-rzg2m renesas/r8a774a1-hihope-rzg2m-ex.dtb
> diff --git a/README.md b/README.md
> index bbad1a0..7339396 100644
> --- a/README.md
> +++ b/README.md
> @@ -25,6 +25,10 @@ this:
>   
>   This image can be run using `start-qemu.sh x86`.
>   
> +If you want to include the testing layer add ':opt-tests.yml' like this

Wording: It's not a testing layer, it's "test packages", no?

> +
> +    ./kas-docker --isar build kas.yml:board-qemu-amd64.yml:opt-tests.yml
> +
>   The BeagleBone Black target is selected by `... kas.yml:board-bbb.yml`. In
>   order to build the image with the PREEMPT-RT kernel, append `:opt-rt.yml` to
>   the above. Append ':opt-4.4.yml' to use the kernel version 4.4 instead of 4.19.
> diff --git a/opt-tests.yml b/opt-tests.yml
> new file mode 100644
> index 0000000..a1f431d
> --- /dev/null
> +++ b/opt-tests.yml
> @@ -0,0 +1,19 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Toshiba corp., 2020
> +#
> +# Authors:
> +#  Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +header:
> +  version: 8
> +
> +local_conf_header:
> +  tests: |
> +    IMAGE_INSTALL += "ltp-full"
> +    IMAGE_PREINSTALL += "rt-tests stress-ng"

This, in fact, has some benefit over a separate image in that it would 
also allow to make the security image testable by appending the snippet

> +

No extra line at EOF, please.

> diff --git a/recipes-core/customizations/customizations.bb b/recipes-core/customizations/customizations.bb
> index 38881fb..cbd6daf 100644
> --- a/recipes-core/customizations/customizations.bb
> +++ b/recipes-core/customizations/customizations.bb
> @@ -11,7 +11,7 @@
>   
>   inherit dpkg-raw
>   
> -DESCRIPTION = "CIP Core image demo & test customizations"
> +DESCRIPTION = "CIP Core image demo customizations"

Maybe "reference customizations" - typically, you will replace this 
package for a real product with a, well, product specific customization.

>   
>   SRC_URI = " \
>       file://postinst \
> @@ -21,8 +21,7 @@ SRC_URI = " \
>   DEPENDS += "sshd-regen-keys"
>   
>   DEBIAN_DEPENDS = " \
> -    ifupdown, isc-dhcp-client, net-tools, iputils-ping, ssh, sshd-regen-keys, \
> -    rt-tests, stress-ng"
> +    ifupdown, isc-dhcp-client, net-tools, iputils-ping, ssh, sshd-regen-keys"
>   
>   do_install() {
>   	install -v -d ${D}/etc/network/interfaces.d
> diff --git a/recipes-core/images/cip-core-image.bb b/recipes-core/images/cip-core-image.bb
> index 9ee4b25..188c714 100644
> --- a/recipes-core/images/cip-core-image.bb
> +++ b/recipes-core/images/cip-core-image.bb
> @@ -15,5 +15,4 @@ ISAR_RELEASE_CMD = "git -C ${LAYERDIR_cip-core} describe --tags --dirty --always
>   DESCRIPTION = "CIP Core image"
>   
>   IMAGE_INSTALL += "customizations"
> -# for cip-testing
> -IMAGE_INSTALL += "ltp-full"
> +

No extra line at EOF, please.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

--VAwsVEtpP7jgilr64Iw2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4955): https://lists.cip-project.org/g/cip-dev/message=
/4955
Mute This Topic: https://lists.cip-project.org/mt/75702560/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--VAwsVEtpP7jgilr64Iw2--
