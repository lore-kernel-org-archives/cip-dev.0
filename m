Return-Path: <SRS0=bP/2=NA=lists.cip-project.org=bounce+64572+6664+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BF0C4338F
	for <cip-dev@archiver.kernel.org>; Mon,  9 Aug 2021 12:54:07 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC8EA60E78
	for <cip-dev@archiver.kernel.org>; Mon,  9 Aug 2021 12:54:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EC8EA60E78
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id PhNoYY4521723xpgBnzdi0nq; Mon, 09 Aug 2021 05:54:06 -0700
X-Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web10.22307.1628513645486969418
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Aug 2021 05:54:06 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 179Cs3Ku008364
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Mon, 9 Aug 2021 14:54:03 +0200
X-Received: from [167.87.241.87] ([167.87.241.87])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 179Cs2Xd019151;
	Mon, 9 Aug 2021 14:54:02 +0200
Subject: Re: [cip-dev][isar-cip-core][PATCH] swupdate-config: Remove runtime dependency efibootguard-dev
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>,
        cip-dev@lists.cip-project.org
References: <20210809102945.17824-1-Quirin.Gylstorff@siemens.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <6a7d4672-f517-f33a-a54d-e48776d1c6c4@siemens.com>
Date: Mon, 9 Aug 2021 14:54:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210809102945.17824-1-Quirin.Gylstorff@siemens.com>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: DElRLjZgvU9vNUKtmbCiOGKbx4520388AA=
Content-Type: multipart/mixed; boundary="zxzgc3pEwMh7hBvPxkg1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1628513646;
 bh=oyQy/InSCytyNz+na4Ois9+dCCTmmj1G9X69IUvOaWM=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=ZHqct/x4rF8aBY5gFVOT+HF7PSG+lOGnMcC+k1Br0d7yDrOjXBclkuwglP0QohFjkek
 yS45V9V8lANofUybhrpeReODArz+kTPKLRIYrvK0CimYgfNh/W1+0Pff1bTse9VVJVuyY
 UmFC0HNHMRqHAVz5eWEfa/hCEji3Pbn6GBg=

--zxzgc3pEwMh7hBvPxkg1
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 09.08.21 12:29, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> efibootguard-dev is only a build time dependency and
> not an runtime dependency.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  classes/swupdate-config.bbclass | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/classes/swupdate-config.bbclass b/classes/swupdate-config.bbclass
> index dfa3579..e4879c7 100644
> --- a/classes/swupdate-config.bbclass
> +++ b/classes/swupdate-config.bbclass
> @@ -38,7 +38,7 @@ KFEATURE_DEPS[luahandler] = "lua"
>  
>  KFEATURE_efibootguard = ""
>  KFEATURE_efibootguard[BUILD_DEB_DEPENDS] = "efibootguard-dev"
> -KFEATURE_efibootguard[DEBIAN_DEPENDS] = "efibootguard-dev"
> +KFEATURE_efibootguard[DEBIAN_DEPENDS] = ""
>  KFEATURE_efibootguard[DEPENDS] = "efibootguard-dev"
>  KFEATURE_efibootguard[KCONFIG_SNIPPETS] = "file://swupdate_defconfig_efibootguard.snippet"
>  
> 

-dev makes no sense, but don't we have any dep on libs? Or are they
statically linked?

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--zxzgc3pEwMh7hBvPxkg1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6664): https://lists.cip-project.org/g/cip-dev/message/=
6664
Mute This Topic: https://lists.cip-project.org/mt/84765287/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--zxzgc3pEwMh7hBvPxkg1--
