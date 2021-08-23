Return-Path: <SRS0=x509=NO=lists.cip-project.org=bounce+64572+6703+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3886CC4338F
	for <cip-dev@archiver.kernel.org>; Mon, 23 Aug 2021 14:09:45 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9245761206
	for <cip-dev@archiver.kernel.org>; Mon, 23 Aug 2021 14:09:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9245761206
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id dXA2YY4521723x6RycbfweKK; Mon, 23 Aug 2021 07:09:44 -0700
X-Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web08.24191.1629727783052514386
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Aug 2021 07:09:43 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 17NE9eoW025337
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Aug 2021 16:09:41 +0200
X-Received: from [167.87.1.146] ([167.87.1.146])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 17NE9dSE007554;
	Mon, 23 Aug 2021 16:09:39 +0200
Subject: Re: [cip-dev] [isar-cip-dev][PATCH] Uprevision the cip-kernel-config to latest one
To: cip-dev@lists.cip-project.org, Srinuvasan A <srinuvasan_a@mentor.com>
References: <20210810072040.716025-1-Srinuvasan_A@mentor.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <dc37cf3a-5aa4-0580-b0c7-3bf3cce1d0c1@siemens.com>
Date: Mon, 23 Aug 2021 16:09:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210810072040.716025-1-Srinuvasan_A@mentor.com>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 2H0PIXtVvt6kAqacZKazTbLlx4520388AA=
Content-Type: multipart/mixed; boundary="A8FeCP7mDoLXOlLzDi86"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1629727784;
 bh=QxFeiPfHODVarSj28oRRdXCvFlg0m9RCDU+NuY28gY4=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=Pnks4/OYIU3jtsyRWYnSBIP4584nKsiVUabFnqVVVsGYCNy4gOI05k5y21TsfayofqB
 pAgeNoHwbrSZn7VexQyurjSlznnMh6aVTpcCMXoH0c6OXfephEGJVH77xnbaGNJbUaMKy
 s+5yMTLkL0dcgQFmDOJynHxWrh1NCRubQ50=

--A8FeCP7mDoLXOlLzDi86
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 10.08.21 09:20, Srinuvasan A wrote:
> From: Srinuvasan A <srinuvasan_a@mentor.com>
> 
> Uprevision the cip-kernel-config to latest one.
> 
> Signed-off-by: Srinuvasan A <srinuvasan_a@mentor.com>
> ---
>  recipes-kernel/linux/linux-cip-common.inc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/recipes-kernel/linux/linux-cip-common.inc b/recipes-kernel/linux/linux-cip-common.inc
> index 6362408..1afec88 100644
> --- a/recipes-kernel/linux/linux-cip-common.inc
> +++ b/recipes-kernel/linux/linux-cip-common.inc
> @@ -25,6 +25,6 @@ SRC_URI_append = " ${@ "git://gitlab.com/cip-project/cip-kernel/cip-kernel-confi
>  
>  SRC_URI_append_bbb = "file://${KERNEL_DEFCONFIG}"
>  
> -SRCREV_cip-kernel-config ?= "b72318b9346f7262f6dd7511384ca61bd8b545c8"
> +SRCREV_cip-kernel-config ?= "cd5d43e99f4d5f20707d7ac1e721bb22d4c9e16e"
>  
>  S = "${WORKDIR}/linux-cip-v${PV}"
> 

Thanks, applied.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--A8FeCP7mDoLXOlLzDi86
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6703): https://lists.cip-project.org/g/cip-dev/message/=
6703
Mute This Topic: https://lists.cip-project.org/mt/84788389/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--A8FeCP7mDoLXOlLzDi86--
