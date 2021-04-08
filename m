Return-Path: <SRS0=XJvD=JF=lists.cip-project.org=bounce+64572+6352+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DF6C433B4
	for <cip-dev@archiver.kernel.org>; Thu,  8 Apr 2021 06:07:53 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 170116113E
	for <cip-dev@archiver.kernel.org>; Thu,  8 Apr 2021 06:07:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 170116113E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6352+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Cv4RYY4521723xWKe2qBzRXY; Wed, 07 Apr 2021 23:07:52 -0700
X-Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web09.4247.1617862070812241834
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Apr 2021 23:07:52 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 13867mTO028830
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Apr 2021 08:07:48 +0200
X-Received: from [167.87.250.28] ([167.87.250.28])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 13864AF4014044;
	Thu, 8 Apr 2021 08:04:10 +0200
Subject: Re: [cip-dev] [PATCH v2] [isar-cip-core] kas: Add opt/targz-img.yml
To: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: cip-dev@lists.cip-project.org
References: <20210408022944.388235-1-nobuhiro1.iwamatsu@toshiba.co.jp>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <f00d2719-dcad-9975-776b-5b6165374219@siemens.com>
Date: Thu, 8 Apr 2021 08:04:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210408022944.388235-1-nobuhiro1.iwamatsu@toshiba.co.jp>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: O7zKykUVsZXPxtGLrBYEQcUWx4520388AA=
Content-Type: multipart/mixed; boundary="8rBzOOwEWbWpFLCOs0Ns"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1617862072;
 bh=hfrTWpNLQ6ayG0y0tAGT2iZ9ENtC6wqOOEXq8LXf4dw=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=qWjHHdvFpsoU23figtQsKGrzseDgxeMFsNQ3s3Zcjq9NFm9HXbvXunWGQAIsRWUuF7R
 Z84kgmcZ+e96EgtVDNXS17BG2AJaKvNyonWLjASWlzEYwwx+V+Uh3JL2zbifu4ef8eGqv
 NCR4uTmAayXCLBDD9iS75UXJdArtex4X9v8=

--8rBzOOwEWbWpFLCOs0Ns
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 08.04.21 04:29, Nobuhiro Iwamatsu wrote:
> This provides the function to specify 'targz-img' for IMAGE_TYPE. This is
> used when creating a tar.gz image that does not support wic. And this is intended
> to be used for NFS booting of LAVA of CIP.
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---
>  .gitlab-ci.yml        |  3 +++
>  kas/opt/targz-img.yml | 17 +++++++++++++++++
>  2 files changed, 20 insertions(+)
>  create mode 100644 kas/opt/targz-img.yml
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index d14c72f..8802af1 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -6,6 +6,7 @@ variables:
>    extention: base
>    use_rt: enable
>    wic_targz: enable
> +  targz: disable
>    dtb: none
>    deploy: enable
>  
> @@ -30,6 +31,7 @@ default:
>      - if [ "${use_rt}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/rt.yml"; fi;
>      - if [ "${extention}" != "base" ]; then base_yaml="${base_yaml}:kas/opt/${extention}.yml"; fi;
>      - if [ "${wic_targz}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/wic-targz-img.yml"; fi;
> +    - if [ "${targz}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/targz-img.yml"; fi;
>      - kas build ${base_yaml}
>      - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extention} ${dtb}; fi
>  
> @@ -69,6 +71,7 @@ build:qemu-amd64-base:
>      extention: security
>      use_rt: disable
>      wic_targz: disable
> +    targz: enable
>      deploy: disable
>  
>  # test
> diff --git a/kas/opt/targz-img.yml b/kas/opt/targz-img.yml
> new file mode 100644
> index 0000000..bdb5231
> --- /dev/null
> +++ b/kas/opt/targz-img.yml
> @@ -0,0 +1,17 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2019
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +header:
> +  version: 10
> +
> +local_conf_header:
> +  image-type: |
> +    IMAGE_TYPE = "targz-img"
> 

Thanks, applied.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--8rBzOOwEWbWpFLCOs0Ns
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6352): https://lists.cip-project.org/g/cip-dev/message=
/6352
Mute This Topic: https://lists.cip-project.org/mt/81933260/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--8rBzOOwEWbWpFLCOs0Ns--
