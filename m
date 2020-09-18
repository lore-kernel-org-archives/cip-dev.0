Return-Path: <SRS0=rnWW=C3=lists.cip-project.org=bounce+64572+5463+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E748BC43463
	for <cip-dev@archiver.kernel.org>; Fri, 18 Sep 2020 12:22:06 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A61920874
	for <cip-dev@archiver.kernel.org>; Fri, 18 Sep 2020 12:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="c9atR5x8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A61920874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5463+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 1nDCYY4521723xxMPLF5C70q; Fri, 18 Sep 2020 05:22:05 -0700
X-Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web12.11514.1600431722929184261
 for <cip-dev@lists.cip-project.org>;
 Fri, 18 Sep 2020 05:22:04 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 08ICLxdJ030471
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Fri, 18 Sep 2020 14:22:00 +0200
X-Received: from [167.87.31.83] ([167.87.31.83])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 08ICLwbG016258;
	Fri, 18 Sep 2020 14:21:59 +0200
Subject: Re: [cip-dev] [isar-cip-core][PATCH] classes/image_uuid: Generate new uuid if a new package is added
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>,
        cip-dev@lists.cip-project.org
References: <20200918080435.24136-1-Quirin.Gylstorff@siemens.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <c02e7a38-5bc1-7e4a-61fe-77cce775acab@siemens.com>
Date: Fri, 18 Sep 2020 14:21:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200918080435.24136-1-Quirin.Gylstorff@siemens.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: uArOyLfg7P3rLCu0TRRB8Hs0x4520388AA=
Content-Type: multipart/mixed; boundary="zAuUumZnJGIjwpkxSDJz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1600431725;
 bh=mSmZK9/ESrqN3dRpfjh8L8uJdI+HiEjrnojQAN0oYjg=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=c9atR5x8NwyKdfTpIpvEED399c3umS4V/anBpmqAxiNwAr6sXQ9SetsBBwUAxKXvG3/
 yUBUUjnQrJcfzkBucjeJkUZN999seg6Qdyhe4dhGLe02ZnpUedvKT7TBVauhbwFznyaum
 jFKa/eull9pONTIRNRvaphWBEwQmFs/42UA=

--zAuUumZnJGIjwpkxSDJz
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 18.09.20 10:04, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> BB_BASEHASH only includes the task itself and its metadata.
> Dependencies are not taken into account when this hash is
> generated which means updating a package will not generate a new
> UUID.
> 
> BB_TASKHASH takes the changes into account.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>   classes/image_uuid.bbclass | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/classes/image_uuid.bbclass b/classes/image_uuid.bbclass
> index d5337b8..873abc5 100644
> --- a/classes/image_uuid.bbclass
> +++ b/classes/image_uuid.bbclass
> @@ -9,23 +9,23 @@
>   # SPDX-License-Identifier: MIT
>   #
>   
> -def generate_image_uuid(d):
> -    import uuid
> +IMAGE_UUID ?= "random"

Why not using an undefined or empty IMAGE_UUID as "generate me one" 
indication?

>   
> -    base_hash = d.getVar("BB_BASEHASH_task-do_rootfs_install", True)
> -    if base_hash is None:
> -        return None
> -    return str(uuid.UUID(base_hash[:32], version=4))
> -
> -IMAGE_UUID ?= "${@generate_image_uuid(d)}"
> +IMAGE_UUID_NAMESPACE = "6090f47e-b068-475c-b125-7be7c24cdd4e"

Is that namespace random, or does that have specific meaning?

>   
>   do_generate_image_uuid[vardeps] += "IMAGE_UUID"
>   do_generate_image_uuid[depends] = "buildchroot-target:do_build"
> +IMAGER_INSTALL += "uuid-runtime"

Please separate variable for job definitions be a blank line. Also the 
job specifications above should be visually separated from the code 
below that way. IOW:

IMAGER_INSTALL += "uuid-runtime"

do_generate_image_uuid[vardeps] += "IMAGE_UUID"
do_generate_image_uuid[depends] = "buildchroot-target:do_build"

do_generate_image_uuid() {

>   do_generate_image_uuid() {
> +    image_do_mounts
> +    if [ "${IMAGE_UUID}" != "random" ]; then
> +        IMAGE_UUID_FINAL="${IMAGE_UUID}"
> +    else
> +        IMAGE_UUID_FINAL="$(sudo -E chroot ${BUILDCHROOT_DIR} uuidgen -s -n "${IMAGE_UUID_NAMESPACE}" -N "${BB_TASKHASH}")"

Why do we need to switch to uuidgen from the buildchroot, rather than 
using python's uuid?

And what ensures that uuidgen is available there?

> +    fi
>       sudo sed -i '/^IMAGE_UUID=.*/d' '${IMAGE_ROOTFS}/etc/os-release'
> -    echo "IMAGE_UUID=\"${IMAGE_UUID}\"" | \
> +    echo "IMAGE_UUID=\"${IMAGE_UUID_FINAL}\"" | \
>           sudo tee -a '${IMAGE_ROOTFS}/etc/os-release'
> -    image_do_mounts
>   
>       # update initramfs to add uuid
>       sudo chroot '${IMAGE_ROOTFS}' update-initramfs -u
> 

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

--zAuUumZnJGIjwpkxSDJz
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5463): https://lists.cip-project.org/g/cip-dev/message=
/5463
Mute This Topic: https://lists.cip-project.org/mt/76926695/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--zAuUumZnJGIjwpkxSDJz--
