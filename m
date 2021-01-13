Return-Path: <SRS0=yB5j=GQ=lists.cip-project.org=bounce+64572+6062+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2CCC433DB
	for <cip-dev@archiver.kernel.org>; Wed, 13 Jan 2021 10:45:49 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94C0B23102
	for <cip-dev@archiver.kernel.org>; Wed, 13 Jan 2021 10:45:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94C0B23102
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6062+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id mpZZYY4521723xgpjO9IFGIy; Wed, 13 Jan 2021 02:45:47 -0800
X-Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web08.6357.1610534745625913309
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Jan 2021 02:45:47 -0800
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 10DAjh5p006412
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Wed, 13 Jan 2021 11:45:43 +0100
X-Received: from [167.87.43.185] ([167.87.43.185])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 10DAjgRY017616;
	Wed, 13 Jan 2021 11:45:42 +0100
Subject: Re: [cip-dev] [isar-cip-core] [PATCH] classes: make swu image file variable absolute like the others
To: cip-dev@lists.cip-project.org, Henning Schild <henning.schild@siemens.com>
References: <20210111124104.31067-1-henning.schild@siemens.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <f76be6f7-fca8-8514-bfe2-789fde69ab2b@siemens.com>
Date: Wed, 13 Jan 2021 11:45:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210111124104.31067-1-henning.schild@siemens.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 76Rx07Jeui64YmhbDEjYSYwsx4520388AA=
Content-Type: multipart/mixed; boundary="q8CmZ3Ss8GLpTP2xDLsd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1610534747;
 bh=bIGoqzkJXhQwwRzzltrV+P567219vHwyUK6Gh45BlKU=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=cpSqiQR0/NsGgIHlW5gIFHvZkLd4jEp+OapV/NWH0taWHhEVdqcCU0bR2fnSQj1GBWl
 YPVGn2q1Zk1IqlJj1QeFOgTDP++ssuBw1wRhSS2nN2mlq1B1nYLnUUTP8eBst7xeg3OOP
 lwQ1fqxN/lgKB7ryc/06NTtlHiDnh3XL3Ys=

--q8CmZ3Ss8GLpTP2xDLsd
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 11.01.21 13:41, Henning Schild wrote:
> From: Henning Schild <henning.schild@siemens.com>
> 
> All the other variables for images already contain the deploydir
> in their absolute names. Only the one for swupdate was relative.
> 
> Found this in another layer where we have a task copying deploy
> files to a deploy location with bitbake.
> 
> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>  classes/swupdate-img.bbclass | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/classes/swupdate-img.bbclass b/classes/swupdate-img.bbclass
> index a21d6ec..09e92cc 100644
> --- a/classes/swupdate-img.bbclass
> +++ b/classes/swupdate-img.bbclass
> @@ -9,7 +9,7 @@
>  #
>  # SPDX-License-Identifier: MIT
>  
> -SWU_IMAGE_FILE ?= "${PN}-${DISTRO}-${MACHINE}.swu"
> +SWU_IMAGE_FILE ?= "${DEPLOY_DIR_IMAGE}/${PN}-${DISTRO}-${MACHINE}.swu"
>  SWU_DESCRIPTION_FILE ?= "sw-description"
>  SWU_ADDITIONAL_FILES ?= ""
>  SWU_SIGNED ?= ""
> @@ -21,7 +21,7 @@ IMAGER_INSTALL += "${@'openssl' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) e
>  do_swupdate_image[stamp-extra-info] = "${DISTRO}-${MACHINE}"
>  do_swupdate_image[cleandirs] += "${WORKDIR}/swu"
>  do_swupdate_image() {
> -    rm -f '${DEPLOY_DIR_IMAGE}/${SWU_IMAGE_FILE}'
> +    rm -f '${SWU_IMAGE_FILE}'
>      cp '${WORKDIR}/${SWU_DESCRIPTION_FILE}' '${WORKDIR}/swu/${SWU_DESCRIPTION_FILE}'
>  
>      # Create symlinks for files used in the update image
> @@ -68,7 +68,7 @@ do_swupdate_image() {
>              echo "$file".'${SWU_SIGNATURE_EXT}'
>          fi
>      done | cpio -ovL -H crc \
> -        > '${DEPLOY_DIR_IMAGE}/${SWU_IMAGE_FILE}'
> +        > '${SWU_IMAGE_FILE}'
>      cd -
>  }
>  
> 

Thanks, applied.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--q8CmZ3Ss8GLpTP2xDLsd
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6062): https://lists.cip-project.org/g/cip-dev/message=
/6062
Mute This Topic: https://lists.cip-project.org/mt/79594351/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--q8CmZ3Ss8GLpTP2xDLsd--
