Return-Path: <SRS0=Dvws=GV=lists.cip-project.org=bounce+64572+6097+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE58C433E0
	for <cip-dev@archiver.kernel.org>; Mon, 18 Jan 2021 11:23:17 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48B4522226
	for <cip-dev@archiver.kernel.org>; Mon, 18 Jan 2021 11:23:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48B4522226
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6097+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id LIULYY4521723xdGa3elwKHi; Mon, 18 Jan 2021 03:23:16 -0800
X-Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web08.32316.1610968995501001244
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 Jan 2021 03:23:16 -0800
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 10IBNCs8009920
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Mon, 18 Jan 2021 12:23:13 +0100
X-Received: from [167.87.43.136] ([167.87.43.136])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 10IBNCJB016876;
	Mon, 18 Jan 2021 12:23:12 +0100
Subject: Re: [cip-dev][isar-cip-core][PATCH 2/4] swupdate: use libubootenv
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>,
        cip-dev@lists.cip-project.org
References: <20210118103558.18100-1-Quirin.Gylstorff@siemens.com>
 <20210118103558.18100-3-Quirin.Gylstorff@siemens.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <48e4b57c-fcc8-0020-8417-20639ead2537@siemens.com>
Date: Mon, 18 Jan 2021 12:23:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210118103558.18100-3-Quirin.Gylstorff@siemens.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: ib654CI8UT2J6iPtB0pFpjpGx4520388AA=
Content-Type: multipart/mixed; boundary="OrcL78lhWhmIesPhGj9J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1610968996;
 bh=MBJBdyqoj7mSdT9zBzQuZfWgDAH9x58EZ5WBXK6k2Xo=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=ZuO7wR9Z05ltLP8cDjIvTGwE1XzIbfcp7IqbO4fTNEvPKoK/nqAwbqDZtEBeqW5BL3m
 2XtxWh8FeF8XUyCNqBVnBeySHfh1b6PP0Dw9O6JkPztBKpvVBuLHhzuE0+BfsqaFrjWFX
 eyUx59bz9fIDs1K/uEDCYyBBnirrhzfnTPQ=

--OrcL78lhWhmIesPhGj9J
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 18.01.21 11:35, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> libubootenv provides hardware independent access to u-boot environments.
> This change conflicts with u-boot tools < 10.2019.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  classes/swupdate-config.bbclass | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/classes/swupdate-config.bbclass b/classes/swupdate-config.bbclass
> index 208d240..dd0317f 100644
> --- a/classes/swupdate-config.bbclass
> +++ b/classes/swupdate-config.bbclass
> @@ -46,8 +46,8 @@ KFEATURE_ubi[KCONFIG_SNIPPETS] = "file://swupdate_defconfig_ubi.snippet"
>  KFEATURE_DEPS[ubi] = "mtd"
>  
>  KFEATURE_u-boot = ""
> -KFEATURE_u-boot[BUILD_DEB_DEPENDS] = "u-boot-${MACHINE}-dev"
> -KFEATURE_u-boot[DEBIAN_DEPENDS] = "u-boot-tools"
> +KFEATURE_u-boot[BUILD_DEB_DEPENDS] = "libubootenv-dev"
> +KFEATURE_u-boot[DEBIAN_DEPENDS] = "libubootenv-tool, u-boot-tools"
>  KFEATURE_u-boot[DEPENDS] = "${U_BOOT}"
>  KFEATURE_u-boot[KCONFIG_SNIPPETS] = "file://swupdate_defconfig_u-boot.snippet"
>  
> 

The isar version we have at this point already supports that?

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--OrcL78lhWhmIesPhGj9J
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6097): https://lists.cip-project.org/g/cip-dev/message=
/6097
Mute This Topic: https://lists.cip-project.org/mt/79920019/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--OrcL78lhWhmIesPhGj9J--
