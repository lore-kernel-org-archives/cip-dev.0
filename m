Return-Path: <SRS0=Gr28=J2=lists.cip-project.org=bounce+64572+6401+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A1EC433B4
	for <cip-dev@archiver.kernel.org>; Thu, 29 Apr 2021 07:35:38 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 311DA61440
	for <cip-dev@archiver.kernel.org>; Thu, 29 Apr 2021 07:35:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 311DA61440
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6401+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id IWqkYY4521723xyXNHFQMz7k; Thu, 29 Apr 2021 00:35:37 -0700
X-Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web12.3438.1619681736259473107
 for <cip-dev@lists.cip-project.org>;
 Thu, 29 Apr 2021 00:35:37 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 13T7ZXJN011254
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Apr 2021 09:35:34 +0200
X-Received: from [167.87.241.34] ([167.87.241.34])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 13T7OYki026002;
	Thu, 29 Apr 2021 09:24:35 +0200
Subject: Re: [cip-dev] [PATCH 2/2] [isar-cip-core] Add support qemu-arm
To: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: cip-dev@lists.cip-project.org
References: <20210408023230.388313-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20210408023230.388313-2-nobuhiro1.iwamatsu@toshiba.co.jp>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <80a1ebd0-9938-7bd5-2bee-90d0b3b67349@siemens.com>
Date: Thu, 29 Apr 2021 09:24:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210408023230.388313-2-nobuhiro1.iwamatsu@toshiba.co.jp>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: LuxWtZYw2svy85hBZUwuanBzx4520388AA=
Content-Type: multipart/mixed; boundary="IZqHaOGZ49h1RwSZMBIC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1619681737;
 bh=MPWElpzVaEae1ihNm55cQ5Jd7fWIqR/wBjLEE/DDRiw=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=T8F6GTCqKfGB7Hzkhvv3JDjwxB0aQw2pLS/e5ujJxSvnW580B0VRBj/H1dj93m+llqF
 QevNzw+svSHuDmb4Sbcu+TRLN1LJHsK0LiMhVr6jcZu8ZvL96lSagyuwI5RhDAaXU/xz2
 PQDUqG3bcGbeOgqLElN2Oo6sSDkX244Zf5U=

--IZqHaOGZ49h1RwSZMBIC
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 08.04.21 04:32, Nobuhiro Iwamatsu wrote:
> This adds configuration files to support QEMU/arm.
> This is intended to be used for a test image of LAVA of CIP.
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---
>  .gitlab-ci.yml             | 19 +++++++++++++++++++
>  conf/machine/qemu-arm.conf | 14 ++++++++++++++
>  kas/board/qemu-arm.yml     | 16 ++++++++++++++++
>  3 files changed, 49 insertions(+)
>  create mode 100644 conf/machine/qemu-arm.conf
>  create mode 100644 kas/board/qemu-arm.yml
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 01d9609..b53d9cc 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -84,6 +84,16 @@ build:qemu-arm64-base:
>      wic_targz: disable
>      targz: enable
>  
> +build:qemu-arm-base:
> +  extends:
> +    - .build_base
> +  variables:
> +    target: qemu-arm
> +    extention: security
> +    use_rt: disable
> +    wic_targz: disable
> +    targz: enable
> +
>  # test
>  build:simatic-ipc227e-test:
>    extends:
> @@ -124,3 +134,12 @@ build:qemu-arm64-test:
>      extention: test
>      wic_targz: disable
>      targz: enable
> +
> +build:qemu-arm-test:
> +  extends:
> +    - .build_base
> +  variables:
> +    target:  qemu-arm
> +    extention: test
> +    wic_targz: disable
> +    targz: enable
> diff --git a/conf/machine/qemu-arm.conf b/conf/machine/qemu-arm.conf
> new file mode 100644
> index 0000000..81a22c1
> --- /dev/null
> +++ b/conf/machine/qemu-arm.conf
> @@ -0,0 +1,14 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2019
> +# Copyright (c) TOSHIBA CORPORATION, 2021
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +DISTRO_ARCH = "armhf"
> +
> +IMAGE_TYPE ?= "ext4-img"
> +USE_CIP_KERNEL_CONFIG = "1"
> +KERNEL_DEFCONFIG ?= "cip-kernel-config/4.19.y-cip/arm/qemu_arm_defconfig"
> diff --git a/kas/board/qemu-arm.yml b/kas/board/qemu-arm.yml
> new file mode 100644
> index 0000000..9bf9728
> --- /dev/null
> +++ b/kas/board/qemu-arm.yml
> @@ -0,0 +1,16 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2019
> +# Copyright (c) TOSHIBA CORPORATION, 2021
> +#
> +# Authors:
> +#  Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +header:
> +  version: 10
> +
> +machine: qemu-arm
> 

It looks to me we have some regressions in master (which does
deployment), caused by these commits. Could you have a look at

https://gitlab.com/cip-project/cip-core/isar-cip-core/-/pipelines/294203272

TIA,
Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--IZqHaOGZ49h1RwSZMBIC
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6401): https://lists.cip-project.org/g/cip-dev/message=
/6401
Mute This Topic: https://lists.cip-project.org/mt/81933310/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--IZqHaOGZ49h1RwSZMBIC--
