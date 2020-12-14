Return-Path: <SRS0=uUu2=FS=lists.cip-project.org=bounce+64572+5963+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05011C4361B
	for <cip-dev@archiver.kernel.org>; Mon, 14 Dec 2020 09:25:06 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B916207B0
	for <cip-dev@archiver.kernel.org>; Mon, 14 Dec 2020 09:25:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B916207B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5963+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id xSuLYY4521723xVWTDZWuztH; Mon, 14 Dec 2020 01:25:04 -0800
X-Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web12.32325.1607937903653629727
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Dec 2020 01:25:04 -0800
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 0BE9P1su027596
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Mon, 14 Dec 2020 10:25:01 +0100
X-Received: from [167.87.38.225] ([167.87.38.225])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 0BE9P1Tf027685;
	Mon, 14 Dec 2020 10:25:01 +0100
Subject: Re: [cip-dev][isar-cip-core][PATCH] Update version of cip-kernel-config
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>,
        cip-dev@lists.cip-project.org
References: <20201214092401.537-1-Quirin.Gylstorff@siemens.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <adb02fc8-2623-81a4-154c-db92951c787c@siemens.com>
Date: Mon, 14 Dec 2020 10:25:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201214092401.537-1-Quirin.Gylstorff@siemens.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 9DTmH2SDGKhC4TDAmCnO9hr3x4520388AA=
Content-Type: multipart/mixed; boundary="LJq9E3kVOLMNwKZziosE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1607937904;
 bh=pxWO9lLyKphmtTbCAVqYsRRl5xH94ZVxUvPzbe731S4=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=Kd+6D2wPxrlE15fll9lVzde9h4Ci132IsvcKoMYBslRsdNyI8bYlL9dtH1hPqr3pTSJ
 sCNwKfZsElZc5c7WY7WbEyoaeEazkzHtxvpumx6PXPjLIuLDeoRFyODWehF4sYD2GqDSS
 jeyDLFnbSEbuDbogX9Glcyk6Lqh11BU63bs=

--LJq9E3kVOLMNwKZziosE
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 14.12.20 10:24, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  recipes-kernel/linux/linux-cip-common.inc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/recipes-kernel/linux/linux-cip-common.inc b/recipes-kernel/linux/linux-cip-common.inc
> index 7e09090..6db1d1d 100644
> --- a/recipes-kernel/linux/linux-cip-common.inc
> +++ b/recipes-kernel/linux/linux-cip-common.inc
> @@ -26,6 +26,6 @@ SRC_URI += " \
>  SRC_URI_append = " ${@conditional("USE_CIP_KERNEL_CONFIG", "1", \
>      "git://gitlab.com/cip-project/cip-kernel/cip-kernel-config.git;protocol=https;destsuffix=cip-kernel-config;name=cip-kernel-config", \
>      "file://${KERNEL_DEFCONFIG}",d)}"
> -SRCREV_cip-kernel-config ?= "ca24d965adf77730caf1cd32bdfcffd69e369502"
> +SRCREV_cip-kernel-config ?= "7f2930b9667372f94f2edb42ca9cf6fc6c0aed50"
>  
>  S = "${WORKDIR}/linux-cip-v${PV}"
> 

Thanks, applied.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--LJq9E3kVOLMNwKZziosE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5963): https://lists.cip-project.org/g/cip-dev/message=
/5963
Mute This Topic: https://lists.cip-project.org/mt/78947115/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--LJq9E3kVOLMNwKZziosE--
