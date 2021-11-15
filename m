Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4FEC433EF
	for <webhook@archiver.kernel.org>; Mon, 15 Nov 2021 18:36:17 +0000 (UTC)
Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web10.605.1637001375853371975
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Nov 2021 10:36:16 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.28, mailfrom: jan.kiszka@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 1AFIaCSM024285
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Nov 2021 19:36:13 +0100
Received: from [167.87.32.59] ([167.87.32.59])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1AFIaCJF026600;
	Mon, 15 Nov 2021 19:36:12 +0100
Subject: Re: [isar-cip-core][PATCH 05/11] Ignore extension argument when not
 set
To: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>,
        cip-dev@lists.cip-project.org
References: <20211115161724.19516-1-alice.ferrazzi@miraclelinux.com>
 <20211115161724.19516-6-alice.ferrazzi@miraclelinux.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <799d2776-4bcf-d342-b72b-ffff96d16e96@siemens.com>
Date: Mon, 15 Nov 2021 19:36:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211115161724.19516-6-alice.ferrazzi@miraclelinux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Nov 2021 18:36:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6917

Reasoning missing.

Therefore it is tricky for me to judge if this separate patch makes
sense or is better folded into an earlier one.

On 15.11.21 17:17, Alice Ferrazzi wrote:
> Signed-off-by: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
> ---
>  scripts/deploy-kernelci.py | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/deploy-kernelci.py b/scripts/deploy-kernelci.py
> index 88c09d7..c234113 100755
> --- a/scripts/deploy-kernelci.py
> +++ b/scripts/deploy-kernelci.py
> @@ -16,11 +16,18 @@ release=sys.argv[1]
>  target=sys.argv[2]
>  extension=sys.argv[3]
>  
> -rootfs_filename="cip-core-image-"+extension+"-cip-core-"+release+"-"+target+".tar.gz"
> -initrd_filename="cip-core-image-"+extension+"-cip-core-"+release+"-"+target+"-initrd.img"
> +if extension == "security":
> +    rootfs_filename="cip-core-image-"+extension+"-cip-core-"+release+"-"+target+".tar.gz"
> +    initrd_filename="cip-core-image-"+extension+"-cip-core-"+release+"-"+target+"-initrd.img"
> +elif extension == "base":
> +    rootfs_filename="cip-core-image-cip-core-"+release+"-"+target+".tar.gz"
> +    initrd_filename="cip-core-image-cip-core-"+release+"-"+target+"-initrd.img"
>  
>  # initrd is actually gz compressed
> -initrd_gz_filename="cip-core-image-"+extension+"-cip-core-"+release+"-"+target+"-initrd.img.gz"
> +if extension == "security":
> +    initrd_gz_filename="cip-core-image-"+extension+"-cip-core-"+release+"-"+target+"-initrd.img.gz"
> +elif extension == "base":
> +    initrd_gz_filename="cip-core-image-cip-core-"+release+"-"+target+"-initrd.img.gz"
>  
>  input_dir="build/tmp/deploy/images/"+target
>  upload_path="/images/rootfs/cip/"+cdate+"/"+target+"/"
> @@ -28,6 +35,14 @@ upload_path_latest="/images/rootfs/cip/latest/"+target+"/"
>  rootfs=input_dir+"/"+rootfs_filename
>  initrd=input_dir+"/"+initrd_filename
>  
> +print("arguments:")
> +print(release)
> +print(target)
> +print(extension)
> +print("filenames:")
> +print(rootfs_filename)
> +print(initrd_filename)
> +print(initrd_gz_filename)
>  print("build directory contents:")
>  print(os.listdir(input_dir))
>  
> 
Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

