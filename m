Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B88C433EF
	for <webhook@archiver.kernel.org>; Mon, 15 Nov 2021 18:32:09 +0000 (UTC)
Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web09.530.1637001127405216146
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Nov 2021 10:32:08 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.2, mailfrom: jan.kiszka@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 1AFIW43J004022
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Nov 2021 19:32:05 +0100
Received: from [167.87.32.59] ([167.87.32.59])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1AFIW4uM023327;
	Mon, 15 Nov 2021 19:32:04 +0100
Subject: Re: [isar-cip-core][PATCH 02/11] Rename initrd with the gz suffix
To: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>,
        cip-dev@lists.cip-project.org
References: <20211115161724.19516-1-alice.ferrazzi@miraclelinux.com>
 <20211115161724.19516-3-alice.ferrazzi@miraclelinux.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <fc1d7cc4-680f-3f8e-599b-38c1d5d6bbc3@siemens.com>
Date: Mon, 15 Nov 2021 19:32:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211115161724.19516-3-alice.ferrazzi@miraclelinux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Nov 2021 18:32:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6915

On 15.11.21 17:17, Alice Ferrazzi wrote:
> Generated initrd are actually gz compressed and KernelCI need
> the initrd image filename to contain the gz suffix for work.
> 
> Signed-off-by: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
> ---
>  scripts/deploy-kernelci.py | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/deploy-kernelci.py b/scripts/deploy-kernelci.py
> index 931504c..c2341a6 100755
> --- a/scripts/deploy-kernelci.py
> +++ b/scripts/deploy-kernelci.py
> @@ -18,6 +18,10 @@ extension=sys.argv[3]
>  
>  rootfs_filename="cip-core-image-"+extension+"-cip-core-"+release+"-"+target+".tar.gz"
>  initrd_filename="cip-core-image-"+extension+"-cip-core-"+release+"-"+target+"-initrd.img"
> +
> +# initrd is actually gz compressed
> +initrd_gz_filename="cip-core-image-"+extension+"-cip-core-"+release+"-"+target+"-initrd.img.gz"
> +
>  input_dir="build/tmp/deploy/images/"+target
>  upload_path="/images/rootfs/cip/"+cdate+"/"+target+"/"
>  rootfs=input_dir+"/"+rootfs_filename
> @@ -44,5 +48,5 @@ if os.path.exists(rootfs) and os.path.exists(initrd):
>      print("uploading rootfs to KernelCI")
>      upload_file(api, token, upload_path, rootfs, rootfs_filename)
>      print("uploading initrd to KernelCI")
> -    upload_file(api, token, upload_path, initrd, initrd_filename)
> +    upload_file(api, token, upload_path, initrd, initrd_gz_filename)
>      print("uploaded to: https://storage.staging.kernelci.org"+upload_path)
> 

Why not fold that into patch 1 directly? Fixing new files right after
introducing them is not an optimal pattern.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

