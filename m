Return-Path: <SRS0=e6s+=LI=lists.cip-project.org=bounce+64572+6511+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BF6C2B9F4
	for <cip-dev@archiver.kernel.org>; Mon, 14 Jun 2021 10:31:40 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8749613E9
	for <cip-dev@archiver.kernel.org>; Mon, 14 Jun 2021 10:31:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8749613E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6511+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id R3iiYY4521723xNUDZo1nfsr; Mon, 14 Jun 2021 03:31:39 -0700
X-Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web11.28156.1623666698547660456
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jun 2021 03:31:39 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 15EAVZ9O018359
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jun 2021 12:31:36 +0200
X-Received: from [139.25.68.37] ([139.25.68.37])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 15EAVYVn021153;
	Mon, 14 Jun 2021 12:31:34 +0200
Subject: Re: [cip-dev] [isar-cip-dev][PATCH] linux-cip-common.inc: Uprev the cip-kernel-config
To: cip-dev@lists.cip-project.org, Srinuvasan A <srinuvasan_a@mentor.com>
References: <20210614073609.1192915-1-Srinuvasan_A@mentor.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <84362ae1-e477-d46f-6fe8-7d47130d7b3b@siemens.com>
Date: Mon, 14 Jun 2021 12:31:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210614073609.1192915-1-Srinuvasan_A@mentor.com>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: LURMN7os8vKW9jVrd4HWY88Px4520388AA=
Content-Type: multipart/mixed; boundary="gzCk9q4yXs7Hb0hficIV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1623666699;
 bh=nuorU/jj5CaGyOfkuWyoycMIhm8E/8DKqVQ+qkIAiSw=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=lXnb4xvHW5mSGpKnzbHJZw0PN84eC88Z3TtDQ9RIbNgiubMP1Qm9ix82NPtdkiC/JYS
 21fZ2JOXeWLocxCiVmlo/Q0oXfKJIIvYZk41ORWz6Q/RSAsmbs6nwIyb+5em+H/0Ms11y
 PQUWfLzippFfoQUhFMiE8NzxI8l8BdUU0G0=

--gzCk9q4yXs7Hb0hficIV
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 14.06.21 09:36, Srinuvasan A wrote:
> From: Srinuvasan A <srinuvasan_a@mentor.com>
> 
> Bump the cip-kernel-config revision for brings the Message Queue
> support.
> 
> Signed-off-by: Srinuvasan A <srinuvasan_a@mentor.com>
> ---
>  recipes-kernel/linux/linux-cip-common.inc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/recipes-kernel/linux/linux-cip-common.inc b/recipes-kernel/linux/linux-cip-common.inc
> index 464144c..021efcd 100644
> --- a/recipes-kernel/linux/linux-cip-common.inc
> +++ b/recipes-kernel/linux/linux-cip-common.inc
> @@ -25,6 +25,6 @@ SRC_URI_append = " ${@ "git://gitlab.com/cip-project/cip-kernel/cip-kernel-confi
>  
>  SRC_URI_append_bbb = "file://${KERNEL_DEFCONFIG}"
>  
> -SRCREV_cip-kernel-config ?= "f6ca8092aeafe22463bcaca17f26c284b15038d0"
> +SRCREV_cip-kernel-config ?= "9fa9154c77ee8eeca534aa436c23582c0c59c39f"
>  
>  S = "${WORKDIR}/linux-cip-v${PV}"
> 
> 
> 

Thanks, applied.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--gzCk9q4yXs7Hb0hficIV
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6511): https://lists.cip-project.org/g/cip-dev/message=
/6511
Mute This Topic: https://lists.cip-project.org/mt/83525386/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--gzCk9q4yXs7Hb0hficIV--
