Return-Path: <SRS0=UyQJ=B7=lists.cip-project.org=bounce+64572+5223+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAED5C433DF
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 15:05:05 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E9EA207C3
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 15:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="CVopOt1L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E9EA207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5223+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id YscJYY4521723xHJUttchTrH; Fri, 21 Aug 2020 08:05:04 -0700
X-Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web10.136324.1598022303371705064
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Aug 2020 08:05:04 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 07LF50uW015066
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2020 17:05:01 +0200
X-Received: from [139.22.122.86] ([139.22.122.86])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 07LF4xj1014745;
	Fri, 21 Aug 2020 17:04:59 +0200
Subject: Re: [cip-dev] [isar-cip-core][PATCH 1/2] ci: Rewrite using extends
To: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        cip-dev@lists.cip-project.org
References: <20200820082434.1302460-1-nobuhiro1.iwamatsu@toshiba.co.jp>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <4f1fd7b8-4fc0-714b-8205-e6a6b93929d8@siemens.com>
Date: Fri, 21 Aug 2020 17:04:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200820082434.1302460-1-nobuhiro1.iwamatsu@toshiba.co.jp>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: GYNYryR8IdJohsESk5tny2rDx4520388AA=
Content-Type: multipart/mixed; boundary="MgYjwLOsA5PhO56rfjFL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598022304;
 bh=LH4D8BNdC6rN+1RhoqQx6PzoS6rwYul6/w3QfD7enf8=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=CVopOt1LdLjyFtTlFSRnSoU1+aGmQ8b9Lhplw58oMdjBhMsyHO5AxQrbdWxl/8j//pB
 5O6QDXlSg0waVerqrTIYFdMplpKUtJ/tSrSxindqJIkFnIUaUXUyIrzzfSKRPlM/S6GrD
 rkmd16hEAjD6Nfmg05h9MvIkUNJkwzygHcA=

--MgYjwLOsA5PhO56rfjFL
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 20.08.20 10:24, Nobuhiro Iwamatsu wrote:
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---
>  .gitlab-ci.yml             | 70 +++++++++++++++++++++++++++++---------
>  scripts/deploy-cip-core.sh |  8 +++--
>  2 files changed, 60 insertions(+), 18 deletions(-)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 3fe7af2..e23345f 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -2,10 +2,17 @@ image: kasproject/kas-isar:1.1
>  
>  variables:
>    GIT_STRATEGY: clone
> +  release: buster
> +  extention: base
> +  use_rt: enable
> +  targz: enable
> +  dtb: none
>  
> -all:
> -  stage: build
> -  script:
> +stages:
> +  - build
> +
> +default:
> +  before_script:
>      - export http_proxy=$HTTP_PROXY
>      - export https_proxy=$HTTPS_PROXY
>      - export ftp_proxy=$FTP_PROXY
> @@ -13,20 +20,51 @@ all:
>      - export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
>      - export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
>  
> -    - kas build kas-cip.yml:kas/board/simatic-ipc227e.yml:kas/opt/rt.yml:kas/opt/targz-img.yml
> -    - scripts/deploy-cip-core.sh buster simatic-ipc227e
> -
> +.build_base:
> +  stage: build
> +  variables:
> +    base_yaml: "kas-cip.yml:kas/board/${target}.yml"
> +  script:
>      - sudo rm -rf build/tmp
> -    - kas build kas-cip.yml:kas/board/bbb.yml:kas/opt/rt.yml:kas/opt/targz-img.yml
> -    - scripts/deploy-cip-core.sh buster bbb am335x-boneblack.dtb
> +    - if [ "${use_rt}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/rt.yml"; fi;
> +    - if [ "${extention}" != "base" ]; then base_yaml="${base_yaml}:kas/opt/${extention}.yml"; fi;
> +    - if [ "${targz}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/targz-img.yml"; fi;
> +    - kas build ${base_yaml}
> +    - scripts/deploy-cip-core.sh ${release} ${target} ${extention} ${dtb}
>  
> -    - sudo rm -rf build/tmp
> -    - kas build kas-cip.yml:kas/board/iwg20m.yml:kas/opt/rt.yml:kas/opt/targz-img.yml
> -    - scripts/deploy-cip-core.sh buster iwg20m r8a7743-iwg20d-q7-dbcm-ca.dtb
> +# base image
> +build:simatic-ipc227e-base:
> +  extends:
> +    - .build_base
> +  variables:
> +    target: simatic-ipc227e
>  
> -    - sudo rm -rf build/tmp
> -    - kas build kas-cip.yml:kas/board/rzg2m.yml:kas/opt/rt.yml:kas/opt/targz-img.yml
> -    - scripts/deploy-cip-core.sh buster hihope-rzg2m renesas/r8a774a1-hihope-rzg2m-ex.dtb
> +build:bbb-base:
> +  extends:
> +    - .build_base
> +  variables:
> +    target: bbb
> +    dtb: am335x-boneblack.dtb
>  
> -    - sudo rm -rf build/tmp
> -    - kas build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/security.yml
> +build:iwg20m-base:
> +  extends:
> +    - .build_base
> +  variables:
> +    target: iwg20m
> +    dtb: r8a7743-iwg20d-q7-dbcm-ca.dtb
> +
> +build:hihope-rzg2m-base:
> +  extends:
> +    - .build_base
> +  variables:
> +    target: rzg2m
> +    dtb: renesas/r8a774a1-hihope-rzg2m-ex.dtb
> +
> +build:qemu-amd64-base:
> +  extends:
> +    - .build_base
> +  variables:
> +    target: qemu-amd64
> +    extention: security
> +    use_rt: disable
> +    targz: disable
> diff --git a/scripts/deploy-cip-core.sh b/scripts/deploy-cip-core.sh
> index 4c8d4c9..5b7eab9 100755
> --- a/scripts/deploy-cip-core.sh
> +++ b/scripts/deploy-cip-core.sh
> @@ -16,9 +16,13 @@ fi
>  
>  RELEASE=$1
>  TARGET=$2
> -DTB=$3
> +EXTENSION=$3
> +DTB=$4
>  
>  BASE_PATH=build/tmp/deploy/images/$TARGET/cip-core-image-cip-core-$RELEASE-$TARGET
> +if [ "${EXTENSION}" != "base" ] ; then
> +	BASE_PATH=build/tmp/deploy/images/$TARGET/cip-core-image-cip-core-$RELEASE-$TARGET-$EXTENSION
> +fi
>  
>  echo "Compressing cip-core-image-cip-core-$RELEASE-$TARGET.wic.img..."
>  xz -9 -k $BASE_PATH.wic.img
> @@ -38,6 +42,6 @@ fi
>  aws s3 cp --no-progress $KERNEL_IMAGE s3://download.cip-project.org/cip-core/$TARGET/
>  aws s3 cp --no-progress $BASE_PATH-initrd.img s3://download.cip-project.org/cip-core/$TARGET/
>  
> -if [ -n "$DTB" ]; then
> +if [ "$DTB" != "none" ]; then
>  	aws s3 cp --no-progress build/tmp/work/cip-core-*/linux-cip*/*/linux-cip-*/debian/linux-image-cip*/usr/lib/linux-image-*/$DTB s3://download.cip-project.org/cip-core/$TARGET/
>  fi
> 

Unfortunately, this scale out to multiple jobs seem to cause download
issues, see e.g.

- https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/697844276
- https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/696946649

First thought it was a sporadic hic-up, but it reoccurs, now with
master. Is kernel.org throttling us here?

Jan

--
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

--MgYjwLOsA5PhO56rfjFL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5223): https://lists.cip-project.org/g/cip-dev/message=
/5223
Mute This Topic: https://lists.cip-project.org/mt/76304024/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--MgYjwLOsA5PhO56rfjFL--
