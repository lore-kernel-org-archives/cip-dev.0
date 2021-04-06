Return-Path: <SRS0=kwV5=JD=lists.cip-project.org=bounce+64572+6344+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9400AC433B4
	for <cip-dev@archiver.kernel.org>; Tue,  6 Apr 2021 08:24:58 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA52E6128D
	for <cip-dev@archiver.kernel.org>; Tue,  6 Apr 2021 08:24:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA52E6128D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6344+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Qe50YY4521723xDqp1MdfZKr; Tue, 06 Apr 2021 01:24:57 -0700
X-Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web09.9246.1617697496407243239
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Apr 2021 01:24:56 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 1368OsRJ006247
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Apr 2021 10:24:54 +0200
X-Received: from [167.87.250.82] ([167.87.250.82])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1368Dm2S021204;
	Tue, 6 Apr 2021 10:13:49 +0200
Subject: Re: [cip-dev] [isar-cip-core][PATCH] kas: Rename opt/targz-img.yml to opt/wic-targz-img.yml
To: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: cip-dev@lists.cip-project.org
References: <20210402005101.372005-1-nobuhiro1.iwamatsu@toshiba.co.jp>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <87128431-1526-7e5e-6586-83c2b1a8fbff@siemens.com>
Date: Tue, 6 Apr 2021 10:13:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210402005101.372005-1-nobuhiro1.iwamatsu@toshiba.co.jp>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: twEnf5BlHOHvDnhwSrGTVy3nx4520388AA=
Content-Type: multipart/mixed; boundary="3kdMKRhqn1X1lmF3lRAM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1617697497;
 bh=O9JiCFwrda/Q1wwe+Tv5FjnPVbIm8zMKFZZ8G1ExWIU=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=lKRho3fqt7z8ixO68yUcbd5kdEQR919svd9s+FhcClsbuAg+qOizcXQm57b986V2DMW
 IhJaPaCJkXJTgMlk/PwOl1cnzhRmJqNEDYaJzHr7AeuX4pcLEeLysMmAOKuRNk+7sOgRI
 thNqJbbgg46McPDz/ZVN3iDE59/hDe9+kTg=

--3kdMKRhqn1X1lmF3lRAM
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 02.04.21 02:51, Nobuhiro Iwamatsu wrote:
> 'wic-targz-img' was specified to IMAGE_TYPE in the original file. And there is 'targz-img' as a
> similar function in ISAR.
> This renames the file to clarify the functionality it provides.
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---
>  .gitlab-ci.yml                               | 6 +++---
>  kas/opt/{targz-img.yml => wic-targz-img.yml} | 0
>  2 files changed, 3 insertions(+), 3 deletions(-)
>  rename kas/opt/{targz-img.yml => wic-targz-img.yml} (100%)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 77d361c..d14c72f 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -5,7 +5,7 @@ variables:
>    release: buster
>    extention: base
>    use_rt: enable
> -  targz: enable
> +  wic_targz: enable
>    dtb: none
>    deploy: enable
>  
> @@ -29,7 +29,7 @@ default:
>      - sudo rm -rf build/tmp
>      - if [ "${use_rt}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/rt.yml"; fi;
>      - if [ "${extention}" != "base" ]; then base_yaml="${base_yaml}:kas/opt/${extention}.yml"; fi;
> -    - if [ "${targz}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/targz-img.yml"; fi;
> +    - if [ "${wic_targz}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/wic-targz-img.yml"; fi;
>      - kas build ${base_yaml}
>      - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extention} ${dtb}; fi
>  
> @@ -68,7 +68,7 @@ build:qemu-amd64-base:
>      target: qemu-amd64
>      extention: security
>      use_rt: disable
> -    targz: disable
> +    wic_targz: disable
>      deploy: disable
>  
>  # test
> diff --git a/kas/opt/targz-img.yml b/kas/opt/wic-targz-img.yml
> similarity index 100%
> rename from kas/opt/targz-img.yml
> rename to kas/opt/wic-targz-img.yml
> 

Thanks, applied to next.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--3kdMKRhqn1X1lmF3lRAM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6344): https://lists.cip-project.org/g/cip-dev/message=
/6344
Mute This Topic: https://lists.cip-project.org/mt/81792908/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--3kdMKRhqn1X1lmF3lRAM--
