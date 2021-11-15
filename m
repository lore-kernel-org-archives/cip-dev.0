Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5594CC433EF
	for <webhook@archiver.kernel.org>; Mon, 15 Nov 2021 18:32:25 +0000 (UTC)
Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web10.549.1637001144315642366
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Nov 2021 10:32:24 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 194.138.37.39, mailfrom: jan.kiszka@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 1AFIWLTE016412
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Nov 2021 19:32:21 +0100
Received: from [167.87.32.59] ([167.87.32.59])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1AFIWLWX023411;
	Mon, 15 Nov 2021 19:32:21 +0100
Subject: Re: [isar-cip-core][PATCH 04/11] Create kernelci build step
To: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>,
        cip-dev@lists.cip-project.org
References: <20211115161724.19516-1-alice.ferrazzi@miraclelinux.com>
 <20211115161724.19516-5-alice.ferrazzi@miraclelinux.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <981af37b-44ec-84b0-2122-761c199d8e09@siemens.com>
Date: Mon, 15 Nov 2021 19:32:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211115161724.19516-5-alice.ferrazzi@miraclelinux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Nov 2021 18:32:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6916

On 15.11.21 17:17, Alice Ferrazzi wrote:
> By default disable KernelCI upload and enable it only when 
> needed for KernelCI image build.
> 
> Signed-off-by: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
> ---
>  .gitlab-ci.yml | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index dd7d9cc..5f0463e 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -9,7 +9,7 @@ variables:
>    targz: disable
>    dtb: none
>    deploy: enable
> -  deploy_kernelci: enable
> +  kernelci: disable

Why that renaming? Is it no longer about deploying for kernelci?

>  
>  stages:
>    - build
> @@ -39,7 +39,7 @@ default:
>      - echo "Building ${base_yaml}"
>      - kas build ${base_yaml}
>      - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extention} ${dtb}; fi;
> -    - if [ "${deploy_kernelci}" = "enable" ]; then scripts/deploy-kernelci.py ${release} ${target} ${extention} ${dtb}; fi
> +    - if [ "${kernelci}" = "enable" ]; then scripts/deploy-kernelci.py ${release} ${target} ${extention} ${dtb}; fi
>  
>  # base image
>  build:simatic-ipc227e-base:
> @@ -79,6 +79,17 @@ build:qemu-amd64-base:
>      wic_targz: disable
>      targz: enable
>  
> +build:qemu-amd64-base-kernelci:
> +  extends:
> +    - .build_base
> +  variables:
> +    target: qemu-amd64
> +    use_rt: disable
> +    wic_targz: disable
> +    targz: enable
> +    deploy: disable
> +    kernelci: enable
> +
>  build:qemu-arm64-base:
>    extends:
>      - .build_base
> 

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

