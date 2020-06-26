Return-Path: <SRS0=NjMc=AH=lists.cip-project.org=bounce+64572+4844+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF15C433E0
	for <cip-dev@archiver.kernel.org>; Fri, 26 Jun 2020 18:51:24 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E1B6207E8
	for <cip-dev@archiver.kernel.org>; Fri, 26 Jun 2020 18:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="ju6FWBYj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E1B6207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4844+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id mh3cYY4521723xYkyW7gUppl; Fri, 26 Jun 2020 11:51:24 -0700
X-Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web12.1374.1593197482736638857
 for <cip-dev@lists.cip-project.org>;
 Fri, 26 Jun 2020 11:51:23 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 05QIpKGM027497
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Fri, 26 Jun 2020 20:51:20 +0200
X-Received: from [167.87.7.201] ([167.87.7.201])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 05QIpJUF007568;
	Fri, 26 Jun 2020 20:51:19 +0200
Subject: Re: [cip-dev] [isar-cip-core PATCH v2 1/1] kas: Restructure kas files.
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>,
        cip-dev@lists.cip-project.org
References: <b7714d3d-256d-2ec7-441b-a04b3029205f@siemens.com>
 <20200626165651.26960-1-Quirin.Gylstorff@siemens.com>
 <20200626165651.26960-2-Quirin.Gylstorff@siemens.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <47081476-b0ca-cbbe-fda6-1a361e9e4641@siemens.com>
Date: Fri, 26 Jun 2020 20:51:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200626165651.26960-2-Quirin.Gylstorff@siemens.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 3ZsWho85BzwqJ10JZhg6hSmRx4520388AA=
Content-Type: multipart/mixed; boundary="BjKql5Fq6iSxtyaYHrzU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1593197484;
 bh=ytzns+0R+m65ZiDFdDl/lacL83gVpADfeDI3hJhYvl8=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=ju6FWBYj7PvDoIz7YLKgQnimdXtrcOttWT3K62/7vc/9rgnJHpdkZt5thL+b6ERyteg
 Do4VEY5VsMI70Sq8jBpKlvDxwRcJDSVUs+GYkL+l0DCVqSVG/qa9ZVIfTpDMzA1Yc06OW
 ULQrfkA5mxPvQmbjpzbpNE/T/9FbWgeQS5k=

--BjKql5Fq6iSxtyaYHrzU
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 26.06.20 18:56, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Create folder structure
> kas -> general configuration
> kas/board -> all supported boards
> kas/opt -> all kas option files
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>   .gitlab-ci.yml                                            | 8 ++++----
>   README.md                                                 | 4 ++--
>   kas.yml => kas-cip.yml                                    | 0
>   board-bbb.yml => kas/board/bbb.yml                        | 0
>   board-iwg20m.yml => kas/board/iwg20m.yml                  | 0
>   board-qemu-amd64.yml => kas/board/qemu-amd64.yml          | 0
>   board-rzg2m.yml => kas/board/rzg2m.yml                    | 0
>   .../board/simatic-ipc227e.yml                             | 0
>   opt-4.4.yml => kas/opt/4.4.yml                            | 0
>   opt-rt.yml => kas/opt/rt.yml                              | 0
>   opt-stretch.yml => kas/opt/stretch.yml                    | 0
>   opt-targz-img.yml => kas/opt/targz-img.yml                | 0
>   12 files changed, 6 insertions(+), 6 deletions(-)
>   rename kas.yml => kas-cip.yml (100%)
>   rename board-bbb.yml => kas/board/bbb.yml (100%)
>   rename board-iwg20m.yml => kas/board/iwg20m.yml (100%)
>   rename board-qemu-amd64.yml => kas/board/qemu-amd64.yml (100%)
>   rename board-rzg2m.yml => kas/board/rzg2m.yml (100%)
>   rename board-simatic-ipc227e.yml => kas/board/simatic-ipc227e.yml (100%)
>   rename opt-4.4.yml => kas/opt/4.4.yml (100%)
>   rename opt-rt.yml => kas/opt/rt.yml (100%)
>   rename opt-stretch.yml => kas/opt/stretch.yml (100%)
>   rename opt-targz-img.yml => kas/opt/targz-img.yml (100%)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 6f1dc91..241b09e 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -13,17 +13,17 @@ all:
>       - export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
>       - export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
>   
> -    - kas build kas.yml:board-simatic-ipc227e.yml:opt-rt.yml:opt-targz-img.yml
> +    - kas build kas-cip.yml:kas/board/simatic-ipc227e.yml:kas/opt/rt.yml:kas/opt/targz-img.yml
>       - scripts/deploy-cip-core.sh buster simatic-ipc227e
>   
>       - sudo rm -rf build/tmp
> -    - kas build kas.yml:board-bbb.yml:opt-rt.yml:opt-targz-img.yml
> +    - kas build kas-cip.yml:kas/board/bbb.yml:kas/opt/rt.yml:kas/opt/targz-img.yml
>       - scripts/deploy-cip-core.sh buster bbb am335x-boneblack.dtb
>   
>       - sudo rm -rf build/tmp
> -    - kas build kas.yml:board-iwg20m.yml:opt-rt.yml:opt-targz-img.yml
> +    - kas build kas-cip.yml:kas/board/iwg20m.yml:kas/opt/rt.yml:kas/opt/targz-img.yml
>       - scripts/deploy-cip-core.sh buster iwg20m r8a7743-iwg20d-q7-dbcm-ca.dtb
>   
>       - sudo rm -rf build/tmp
> -    - kas build kas.yml:board-rzg2m.yml:opt-rt.yml:opt-targz-img.yml
> +    - kas build kas-cip.yml:kas/board/rzg2m.yml:kas/opt/rt.yml:kas/opt/targz-img.yml
>       - scripts/deploy-cip-core.sh buster hihope-rzg2m renesas/r8a774a1-hihope-rzg2m-ex.dtb
> diff --git a/README.md b/README.md
> index bbad1a0..1a7af21 100644
> --- a/README.md
> +++ b/README.md
> @@ -21,11 +21,11 @@ start containers.
>   To build, e.g., the QEMU AMD64 target inside Docker, invoke kas-docker like
>   this:
>   
> -    ./kas-docker --isar build kas.yml:board-qemu-amd64.yml
> +    ./kas-docker --isar build kas-cip.yml:kas/board/qemu-amd64.yml
>   
>   This image can be run using `start-qemu.sh x86`.
>   
> -The BeagleBone Black target is selected by `... kas.yml:board-bbb.yml`. In
> +The BeagleBone Black target is selected by `... kas-cip.yml:kas/board/bbb.yml`. In
>   order to build the image with the PREEMPT-RT kernel, append `:opt-rt.yml` to
>   the above. Append ':opt-4.4.yml' to use the kernel version 4.4 instead of 4.19.
>   
> diff --git a/kas.yml b/kas-cip.yml
> similarity index 100%
> rename from kas.yml
> rename to kas-cip.yml
> diff --git a/board-bbb.yml b/kas/board/bbb.yml
> similarity index 100%
> rename from board-bbb.yml
> rename to kas/board/bbb.yml
> diff --git a/board-iwg20m.yml b/kas/board/iwg20m.yml
> similarity index 100%
> rename from board-iwg20m.yml
> rename to kas/board/iwg20m.yml
> diff --git a/board-qemu-amd64.yml b/kas/board/qemu-amd64.yml
> similarity index 100%
> rename from board-qemu-amd64.yml
> rename to kas/board/qemu-amd64.yml
> diff --git a/board-rzg2m.yml b/kas/board/rzg2m.yml
> similarity index 100%
> rename from board-rzg2m.yml
> rename to kas/board/rzg2m.yml
> diff --git a/board-simatic-ipc227e.yml b/kas/board/simatic-ipc227e.yml
> similarity index 100%
> rename from board-simatic-ipc227e.yml
> rename to kas/board/simatic-ipc227e.yml
> diff --git a/opt-4.4.yml b/kas/opt/4.4.yml
> similarity index 100%
> rename from opt-4.4.yml
> rename to kas/opt/4.4.yml
> diff --git a/opt-rt.yml b/kas/opt/rt.yml
> similarity index 100%
> rename from opt-rt.yml
> rename to kas/opt/rt.yml
> diff --git a/opt-stretch.yml b/kas/opt/stretch.yml
> similarity index 100%
> rename from opt-stretch.yml
> rename to kas/opt/stretch.yml
> diff --git a/opt-targz-img.yml b/kas/opt/targz-img.yml
> similarity index 100%
> rename from opt-targz-img.yml
> rename to kas/opt/targz-img.yml
> 

Applied to next, also fixing up the remaining README spots.

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

--BjKql5Fq6iSxtyaYHrzU
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4844): https://lists.cip-project.org/g/cip-dev/message=
/4844
Mute This Topic: https://lists.cip-project.org/mt/75128487/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--BjKql5Fq6iSxtyaYHrzU--
