Return-Path: <SRS0=7/vC=CJ=lists.cip-project.org=bounce+64572+5332+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E3FC433E2
	for <cip-dev@archiver.kernel.org>; Mon, 31 Aug 2020 06:01:45 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3F5720707
	for <cip-dev@archiver.kernel.org>; Mon, 31 Aug 2020 06:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="BiH+skaV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3F5720707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5332+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id xC3IYY4521723xMFUMxyASox; Sun, 30 Aug 2020 23:01:44 -0700
X-Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web11.47570.1598853702338830322
 for <cip-dev@lists.cip-project.org>;
 Sun, 30 Aug 2020 23:01:43 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 07V61dqX024887
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2020 08:01:40 +0200
X-Received: from [167.87.39.104] ([167.87.39.104])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 07V61cgg002901;
	Mon, 31 Aug 2020 08:01:38 +0200
Subject: Re: [cip-dev] [isar-cip-core][PATCH] ci: Change to single job
To: cip-dev@lists.cip-project.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
References: <20200831010244.2629769-1-nobuhiro1.iwamatsu@toshiba.co.jp>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <08d5685b-5e0a-7ac0-7564-df8df859588b@siemens.com>
Date: Mon, 31 Aug 2020 08:01:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200831010244.2629769-1-nobuhiro1.iwamatsu@toshiba.co.jp>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: sqLgU2cUiFeukgZ4U2IuKSbjx4520388AA=
Content-Type: multipart/mixed; boundary="BdwwyaaXdMm8crZOZCjT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598853704;
 bh=wNCay7NKDmLNRh2NQGXaU5BGWqOnCf/l+bfllBMNqjk=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=BiH+skaVyQeNZq5IGqGpBNH6Jp9fMwt61XxG/3fxyvPU/VBi/gJybnkGawnjpwhOyYp
 usqawRYci27Uz5/4wPQiLqbVlPhUO8JawZVdb5DbnZtOCBOGRDRMoHD0kwhmqF59sY+Ok
 kJgHqQ1z5UcnkzhrQODgaeYz1hc1S008xLA=

--BdwwyaaXdMm8crZOZCjT
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 31.08.20 03:02, Nobuhiro Iwamatsu wrote:
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---

The reason should be documented in the commit log. How about

"Parallel fetching of git snapshots from kernel.org often failed, either
due to throttling or some problem of the server. We need to avoid this
for now."

?

Also, this does not address the breakage of the hihope-rzg2m deployment.
I'll send a patch, please double check it

Jan

>  .gitlab-ci.yml | 122 +++++++++++++------------------------------------
>  1 file changed, 32 insertions(+), 90 deletions(-)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 802dbcd..5bd4774 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -2,17 +2,10 @@ image: kasproject/kas-isar:1.1
>  
>  variables:
>    GIT_STRATEGY: clone
> -  release: buster
> -  extention: base
> -  use_rt: enable
> -  targz: enable
> -  dtb: none
>  
> -stages:
> -  - build
> -
> -default:
> -  before_script:
> +all:
> +  stage: build
> +  script:
>      - export http_proxy=$HTTP_PROXY
>      - export https_proxy=$HTTPS_PROXY
>      - export ftp_proxy=$FTP_PROXY
> @@ -20,83 +13,32 @@ default:
>      - export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
>      - export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
>  
> -.build_base:
> -  stage: build
> -  variables:
> -    base_yaml: "kas-cip.yml:kas/board/${target}.yml"
> -  script:
> -    - sudo rm -rf build/tmp
> -    - if [ "${use_rt}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/rt.yml"; fi;
> -    - if [ "${extention}" != "base" ]; then base_yaml="${base_yaml}:kas/opt/${extention}.yml"; fi;
> -    - if [ "${targz}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/targz-img.yml"; fi;
> -    - kas build ${base_yaml}
> -    - scripts/deploy-cip-core.sh ${release} ${target} ${extention} ${dtb}
> -
> -# base image
> -build:simatic-ipc227e-base:
> -  extends:
> -    - .build_base
> -  variables:
> -    target: simatic-ipc227e
> -
> -build:bbb-base:
> -  extends:
> -    - .build_base
> -  variables:
> -    target: bbb
> -    dtb: am335x-boneblack.dtb
> -
> -build:iwg20m-base:
> -  extends:
> -    - .build_base
> -  variables:
> -    target: iwg20m
> -    dtb: r8a7743-iwg20d-q7-dbcm-ca.dtb
> -
> -build:hihope-rzg2m-base:
> -  extends:
> -    - .build_base
> -  variables:
> -    target: rzg2m
> -    dtb: renesas/r8a774a1-hihope-rzg2m-ex.dtb
> -
> -build:qemu-amd64-base:
> -  extends:
> -    - .build_base
> -  variables:
> -    target: qemu-amd64
> -    extention: security
> -    use_rt: disable
> -    targz: disable
> -
> -# test
> -build:simatic-ipc227e-test:
> -  extends:
> -    - .build_base
> -  variables:
> -    target: simatic-ipc227e
> -    extention: test
> -
> -build:bbb-test:
> -  extends:
> -    - .build_base
> -  variables:
> -    target: bbb
> -    extention: test
> -    dtb: am335x-boneblack.dtb
> -
> -build:iwg20m-test:
> -  extends:
> -    - .build_base
> -  variables:
> -    target: iwg20m
> -    extention: test
> -    dtb: r8a7743-iwg20d-q7-dbcm-ca.dtb
> -
> -build:hihope-rzg2m-test:
> -  extends:
> -    - .build_base
> -  variables:
> -    target: rzg2m
> -    extention: test
> -    dtb: renesas/r8a774a1-hihope-rzg2m-ex.dtb
> +    # simatic-ipc227e
> +    - kas build kas-cip.yml:kas/board/simatic-ipc227e.yml:kas/opt/rt.yml:kas/opt/targz-img.yml
> +    - scripts/deploy-cip-core.sh buster simatic-ipc227e base none
> +    # bbb
> +    - kas build kas-cip.yml:kas/board/bbb.yml:kas/opt/rt.yml:kas/opt/targz-img.yml
> +    - scripts/deploy-cip-core.sh buster bbb base am335x-boneblack.dtb
> +    # iwg20m
> +    - kas build kas-cip.yml:kas/board/iwg20m.yml:kas/opt/rt.yml:kas/opt/targz-img.yml
> +    - scripts/deploy-cip-core.sh buster iwg20m base r8a7743-iwg20d-q7-dbcm-ca.dtb
> +    # rzg2m
> +    - kas build kas-cip.yml:kas/board/rzg2m.yml:kas/opt/rt.yml:kas/opt/targz-img.yml
> +    - scripts/deploy-cip-core.sh buster rzg2m base renesas/r8a774a1-hihope-rzg2m-ex.dtb
> +
> +    # qemu-amd64 / security
> +    - kas build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/security.yml
> +    - scripts/deploy-cip-core.sh buster qemu-amd64 security base
> +
> +    # simatic-ipc227e / test
> +    - kas build kas-cip.yml:kas/board/simatic-ipc227e.yml:kas/opt/rt.yml:kas/opt/test.yml:kas/opt/targz-img.yml
> +    - scripts/deploy-cip-core.sh buster simatic-ipc227e test none
> +    # bbb / test
> +    - kas build kas-cip.yml:kas/board/bbb.yml:kas/opt/rt.yml:kas/opt/test.yml:kas/opt/targz-img.yml
> +    - scripts/deploy-cip-core.sh buster bbb test am335x-boneblack.dtb
> +    # iwg20m / test
> +    - kas build kas-cip.yml:kas/board/iwg20m.yml:kas/opt/rt.yml:kas/opt/test.yml:kas/opt/targz-img.yml
> +    - scripts/deploy-cip-core.sh buster iwg20m test r8a7743-iwg20d-q7-dbcm-ca.dtb
> +    # rzg2m / test
> +    - kas build kas-cip.yml:kas/board/rzg2m.yml:kas/opt/rt.yml:kas/opt/test.yml:kas/opt/targz-img.yml
> +    - scripts/deploy-cip-core.sh buster rzg2m test renesas/r8a774a1-hihope-rzg2m-ex.dtb
> 
> 
> 
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

--BdwwyaaXdMm8crZOZCjT
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5332): https://lists.cip-project.org/g/cip-dev/message=
/5332
Mute This Topic: https://lists.cip-project.org/mt/76525805/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--BdwwyaaXdMm8crZOZCjT--
