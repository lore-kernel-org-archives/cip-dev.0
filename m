Return-Path: <SRS0=681t=K2=lists.cip-project.org=bounce+64572+6483+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03ECC47082
	for <cip-dev@archiver.kernel.org>; Mon, 31 May 2021 12:46:02 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71AC161279
	for <cip-dev@archiver.kernel.org>; Mon, 31 May 2021 12:46:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71AC161279
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6483+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id wRADYY4521723xcBNPIB7RAj; Mon, 31 May 2021 05:46:02 -0700
X-Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web08.43718.1622465160169972466
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 May 2021 05:46:01 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 14VCjvH3011071
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Mon, 31 May 2021 14:45:57 +0200
X-Received: from [167.87.247.112] ([167.87.247.112])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 14VCgFjK031159;
	Mon, 31 May 2021 14:42:15 +0200
Subject: Re: [cip-dev][isar-cip-core][PATCH 2/5] kas/opt: Allow override of WKS_FILE in swupdate option
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>,
        cip-dev@lists.cip-project.org
References: <20210527131741.8828-1-Quirin.Gylstorff@siemens.com>
 <20210527131741.8828-3-Quirin.Gylstorff@siemens.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <d64d7710-d65f-d68b-1e9f-94c7e07bcaf4@siemens.com>
Date: Mon, 31 May 2021 14:42:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210527131741.8828-3-Quirin.Gylstorff@siemens.com>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 1xXeFP6fpYqphIfheJHZvcegx4520388AA=
Content-Type: multipart/mixed; boundary="wkwW88TRRpLdEABZ9JMp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1622465162;
 bh=6hr4VGIQlQLQndWKb93BkQQR33GFxnsQSmSAV/R7dRg=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=s5kFfAexMGmyyo/mvtopfAF7WW3MMxjsMz1tVN+UXz6s40YtDBtNA+89gRZW7WAZOmd
 2n9Jjb5gx2K27nMd2pt9+uOAbIrQVbDSUOnO+JalgH7tWribDzTGzAks+SyFuL8Rv3Vvd
 liiilDNycP7JFAvgG42LyIggxuldrwFsSa4=

--wkwW88TRRpLdEABZ9JMp
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 27.05.21 15:17, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This fixes an error if swupdate.yml is used together with
> the secureboot options.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  kas/opt/efibootguard.yml | 2 ++
>  kas/opt/swupdate.yml     | 4 ++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kas/opt/efibootguard.yml b/kas/opt/efibootguard.yml
> index 544c740..d5a0e39 100644
> --- a/kas/opt/efibootguard.yml
> +++ b/kas/opt/efibootguard.yml
> @@ -23,4 +23,6 @@ local_conf_header:
>    efibootguard-wic: |
>      WDOG_TIMEOUT = "0"
>      WICVARS += "WDOG_TIMEOUT"
> +    IMAGE_TYPE ?= "wic-img"
> +    WKS_FILE ?= "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks"
>  
> diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
> index e622972..bd0f6e4 100644
> --- a/kas/opt/swupdate.yml
> +++ b/kas/opt/swupdate.yml
> @@ -19,5 +19,5 @@ local_conf_header:
>      IMAGE_INSTALL_append = " swupdate"
>  
>    wic-swu: |
> -    IMAGE_TYPE ?= "wic-swu-img"
> -    WKS_FILE = "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks"
> +    IMAGE_TYPE = "wic-swu-img"

Why no weak assignment here but above?

Jan

> +    WKS_FILE ?= "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks"
> 


-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--wkwW88TRRpLdEABZ9JMp
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6483): https://lists.cip-project.org/g/cip-dev/message=
/6483
Mute This Topic: https://lists.cip-project.org/mt/83123996/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--wkwW88TRRpLdEABZ9JMp--
