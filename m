Return-Path: <SRS0=VQhB=AG=lists.cip-project.org=bounce+64572+4830+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD2FC433E0
	for <cip-dev@archiver.kernel.org>; Thu, 25 Jun 2020 14:53:28 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 527FA20768
	for <cip-dev@archiver.kernel.org>; Thu, 25 Jun 2020 14:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="A3Rx6F4n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 527FA20768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4830+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id I4vbYY4521723xdS76v2wLT5; Thu, 25 Jun 2020 07:53:27 -0700
X-Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web12.12315.1593096806229161046
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Jun 2020 07:53:27 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 05PErNQe027795
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Thu, 25 Jun 2020 16:53:24 +0200
X-Received: from [167.87.31.95] ([167.87.31.95])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 05PErNQI011873;
	Thu, 25 Jun 2020 16:53:23 +0200
Subject: Re: [cip-dev] [isar-cip-core PATCH 2/2] kas: Restructure kas files.
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>,
        cip-dev@lists.cip-project.org
References: <20200625131248.15742-1-Quirin.Gylstorff@siemens.com>
 <20200625131248.15742-3-Quirin.Gylstorff@siemens.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <b7714d3d-256d-2ec7-441b-a04b3029205f@siemens.com>
Date: Thu, 25 Jun 2020 16:53:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200625131248.15742-3-Quirin.Gylstorff@siemens.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: g9IIfbjLpdVa4huTTl0zdmKrx4520388AA=
Content-Type: multipart/mixed; boundary="OutgNZVoV69j61T8aWpS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1593096807;
 bh=BhSgU6Jf7Sfb4BGQWqb1v8Mpo7tacPNvTdB0u9xWWI0=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=A3Rx6F4nz7DWK1P4YsLWhUVN8xzX37EK56Rm3F2CYmAFGKvp59/hGVxS78VzcZZtijH
 SQDpdJYpyxg2uQwUb0jEzS6ZLeOSG6nn7c2DkmaU5o9+yJS9HfbHQYQOxjihe69gN0gGz
 j1vwoNSvRU5Q856ZFlqomfiiLaHSSyq6qyQ=

--OutgNZVoV69j61T8aWpS
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 25.06.20 15:12, Q. Gylstorff wrote:
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
>   board-bbb.yml => kas/board/bbb.yml                        | 0
>   board-iwg20m.yml => kas/board/iwg20m.yml                  | 0
>   board-qemu-amd64.yml => kas/board/qemu-amd64.yml          | 0
>   board-rzg2m.yml => kas/board/rzg2m.yml                    | 0
>   .../board/simatic-ipc227e.yml                             | 0
>   kas.yml => kas/cip.yml                                    | 0
>   opt-4.4.yml => kas/opt/4.4.yml                            | 0
>   opt-rt.yml => kas/opt/rt.yml                              | 0
>   opt-stretch.yml => kas/opt/stretch.yml                    | 0
>   opt-targz-img.yml => kas/opt/targz-img.yml                | 0
>   12 files changed, 6 insertions(+), 6 deletions(-)
>   rename board-bbb.yml => kas/board/bbb.yml (100%)
>   rename board-iwg20m.yml => kas/board/iwg20m.yml (100%)
>   rename board-qemu-amd64.yml => kas/board/qemu-amd64.yml (100%)
>   rename board-rzg2m.yml => kas/board/rzg2m.yml (100%)
>   rename board-simatic-ipc227e.yml => kas/board/simatic-ipc227e.yml (100%)
>   rename kas.yml => kas/cip.yml (100%)
>   rename opt-4.4.yml => kas/opt/4.4.yml (100%)
>   rename opt-rt.yml => kas/opt/rt.yml (100%)
>   rename opt-stretch.yml => kas/opt/stretch.yml (100%)
>   rename opt-targz-img.yml => kas/opt/targz-img.yml (100%)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 6f1dc91..564398d 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -13,17 +13,17 @@ all:
>       - export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
>       - export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
>   
> -    - kas build kas.yml:board-simatic-ipc227e.yml:opt-rt.yml:opt-targz-img.yml
> +    - kas build kas/cip.yml:kas/board/simatic-ipc227e.yml:kas/opt/rt.yml:kas/opt/targz-img.yml
>       - scripts/deploy-cip-core.sh buster simatic-ipc227e
>   
>       - sudo rm -rf build/tmp
> -    - kas build kas.yml:board-bbb.yml:opt-rt.yml:opt-targz-img.yml
> +    - kas build kas/cip.yml:kas/board/bbb.yml:kas/opt/rt.yml:kas/opt/targz-img.yml
>       - scripts/deploy-cip-core.sh buster bbb am335x-boneblack.dtb
>   
>       - sudo rm -rf build/tmp
> -    - kas build kas.yml:board-iwg20m.yml:opt-rt.yml:opt-targz-img.yml
> +    - kas build kas/cip.yml:kas/board/iwg20m.yml:kas/opt/rt.yml:kas/opt/targz-img.yml
>       - scripts/deploy-cip-core.sh buster iwg20m r8a7743-iwg20d-q7-dbcm-ca.dtb
>   
>       - sudo rm -rf build/tmp
> -    - kas build kas.yml:board-rzg2m.yml:opt-rt.yml:opt-targz-img.yml
> +    - kas build kas/cip.yml:kas/board/rzg2m.yml:kas/opt/rt.yml:kas/opt/targz-img.yml
>       - scripts/deploy-cip-core.sh buster hihope-rzg2m renesas/r8a774a1-hihope-rzg2m-ex.dtb
> diff --git a/README.md b/README.md
> index bbad1a0..ebbdee4 100644
> --- a/README.md
> +++ b/README.md
> @@ -21,11 +21,11 @@ start containers.
>   To build, e.g., the QEMU AMD64 target inside Docker, invoke kas-docker like
>   this:
>   
> -    ./kas-docker --isar build kas.yml:board-qemu-amd64.yml
> +    ./kas-docker --isar build kas/cip.yml:kas/board/qemu-amd64.yml
>   
>   This image can be run using `start-qemu.sh x86`.
>   
> -The BeagleBone Black target is selected by `... kas.yml:board-bbb.yml`. In
> +The BeagleBone Black target is selected by `... kas/cip.yml:kas/board/bbb.yml`. In
>   order to build the image with the PREEMPT-RT kernel, append `:opt-rt.yml` to
>   the above. Append ':opt-4.4.yml' to use the kernel version 4.4 instead of 4.19.
>   
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
> diff --git a/kas.yml b/kas/cip.yml
> similarity index 100%
> rename from kas.yml
> rename to kas/cip.yml
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

There is one catch with moving everything into a subdirectory: If a user 
pulls a tarball of the layer, thus tries to use it with git, kas will 
not be able to identify the top-level directory, and various things can 
fail.

Therefore, we are now often using the pattern of keeping the kas-*.yml 
file at the top level while moving options or boards under kas/. See 
e.g. https://github.com/siemens/meta-iot2050/.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

--OutgNZVoV69j61T8aWpS
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4830): https://lists.cip-project.org/g/cip-dev/message=
/4830
Mute This Topic: https://lists.cip-project.org/mt/75102306/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--OutgNZVoV69j61T8aWpS--
