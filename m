Return-Path: <SRS0=50qq=LM=lists.cip-project.org=bounce+64572+6537+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584D5C48BE8
	for <cip-dev@archiver.kernel.org>; Fri, 18 Jun 2021 13:34:44 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0007960FE5
	for <cip-dev@archiver.kernel.org>; Fri, 18 Jun 2021 13:34:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0007960FE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6537+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id teLtYY4521723xzRwQSznF10; Fri, 18 Jun 2021 06:34:43 -0700
X-Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web12.7976.1624023282069626727
 for <cip-dev@lists.cip-project.org>;
 Fri, 18 Jun 2021 06:34:42 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 15IDYdx4018623
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jun 2021 15:34:39 +0200
X-Received: from [167.87.73.171] ([167.87.73.171])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 15IDYcg0022825;
	Fri, 18 Jun 2021 15:34:39 +0200
Subject: Re: [cip-dev] [isar-cip-dev][PATCH] linux-cip-common.inc: Uprev the cip-kernel-config
To: cip-dev@lists.cip-project.org, Srinuvasan A <srinuvasan_a@mentor.com>
References: <20210615052006.1198664-1-Srinuvasan_A@mentor.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <ea153061-02bb-813c-7e01-7f29b7cfefa3@siemens.com>
Date: Fri, 18 Jun 2021 15:34:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210615052006.1198664-1-Srinuvasan_A@mentor.com>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: wuAxfepk3ET8v6tcMO09a2Ayx4520388AA=
Content-Type: multipart/mixed; boundary="wTPorKuWoaF6N2YupgIM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1624023283;
 bh=PFxAZ+oWwmS2Uki8xeJaZ4RYwB4/juDUMu7UETYcH4o=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=c9vvLl6gCrGEwgzOZJzgLIYkdDbT8d3ZdLSXgG/+ePmPeLLnxDs0H08ZFrokH3SCWlI
 do4Wod5tgjVXuzdFUptkNJvowPa9hnQL5IK44Ya6VWgJecwJMo3voQEuaeDOWgnUlvgnA
 UE9dRWryc5oPJ77NPjgN0HCB3h0/00IoYu0=

--wTPorKuWoaF6N2YupgIM
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 15.06.21 07:20, Srinuvasan A wrote:
> Bump the cip-kernel-config revision for brings the User and Sync
> kselftest.
> 
> Signed-off-by: Srinuvasan A <Srinuvasan_A@mentor.com>
> ---
>  recipes-kernel/linux/linux-cip-common.inc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/recipes-kernel/linux/linux-cip-common.inc b/recipes-kernel/linux/linux-cip-common.inc
> index 021efcd..6362408 100644
> --- a/recipes-kernel/linux/linux-cip-common.inc
> +++ b/recipes-kernel/linux/linux-cip-common.inc
> @@ -25,6 +25,6 @@ SRC_URI_append = " ${@ "git://gitlab.com/cip-project/cip-kernel/cip-kernel-confi
>  
>  SRC_URI_append_bbb = "file://${KERNEL_DEFCONFIG}"
>  
> -SRCREV_cip-kernel-config ?= "9fa9154c77ee8eeca534aa436c23582c0c59c39f"
> +SRCREV_cip-kernel-config ?= "b72318b9346f7262f6dd7511384ca61bd8b545c8"
>  
>  S = "${WORKDIR}/linux-cip-v${PV}"
> 

Thanks, applied.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--wTPorKuWoaF6N2YupgIM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6537): https://lists.cip-project.org/g/cip-dev/message=
/6537
Mute This Topic: https://lists.cip-project.org/mt/83525386/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--wTPorKuWoaF6N2YupgIM--
