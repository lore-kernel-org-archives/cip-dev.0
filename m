Return-Path: <SRS0=2/JG=LI=lists.cip-project.org=bounce+64572+6509+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA7AC2B9F4
	for <cip-dev@archiver.kernel.org>; Mon, 14 Jun 2021 10:30:41 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFE2D613D3
	for <cip-dev@archiver.kernel.org>; Mon, 14 Jun 2021 10:30:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFE2D613D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6509+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id vsitYY4521723x3M66C5BAPF; Mon, 14 Jun 2021 03:30:40 -0700
X-Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web10.27907.1623666639174720031
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jun 2021 03:30:39 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 15EAUafB026348
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jun 2021 12:30:36 +0200
X-Received: from [139.25.68.37] ([139.25.68.37])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 15EAUaeW019313;
	Mon, 14 Jun 2021 12:30:36 +0200
Subject: Re: [cip-dev] [isar-cip-dev][PATCH] efibootguard: Update to latest release 0.8
To: cip-dev@lists.cip-project.org, Srinuvasan A <srinuvasan_a@mentor.com>
References: <20210614071431.1192712-1-Srinuvasan_A@mentor.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <726b32ad-cb8b-41ba-ba12-d94fa74688b7@siemens.com>
Date: Mon, 14 Jun 2021 12:30:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210614071431.1192712-1-Srinuvasan_A@mentor.com>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: KNuolrDWDGw1smjT3xbJZPeAx4520388AA=
Content-Type: multipart/mixed; boundary="HxjgQbr6BgzP49OVHigR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1623666640;
 bh=nNYuqWH5iDsQ8hSGZgpx8lyaWaqhJwBvReRbPhxtFmY=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=cJQ4OjXMBN5JBWBRbb4DBebp6fmbsvnPHgqZpV5sX9ZGpCj4uu5UKk5HxfKxw9WGj+A
 U9JD0pSAb9TneDco2AuRLVyewAJoT1x6BTHT+iSafKJqFyeX0gRxO8C277p4w4Zjb2qz8
 2qAg4LjEEX4kG9N+Bfj1fimaUyRLynD14kk=

--HxjgQbr6BgzP49OVHigR
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 14.06.21 09:14, Srinuvasan A wrote:
> From: Srinuvasan A <srinuvasan_a@mentor.com>
> 
> Uprevision the latest revision and tag.
> 
> Signed-off-by: Srinuvasan A <srinuvasan_a@mentor.com>
> ---
>  ...fibootguard_0.7-git+isar.bb => efibootguard_0.8-git+isar.bb} | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>  rename recipes-bsp/efibootguard/{efibootguard_0.7-git+isar.bb => efibootguard_0.8-git+isar.bb} (95%)
> 
> diff --git a/recipes-bsp/efibootguard/efibootguard_0.7-git+isar.bb b/recipes-bsp/efibootguard/efibootguard_0.8-git+isar.bb
> similarity index 95%
> rename from recipes-bsp/efibootguard/efibootguard_0.7-git+isar.bb
> rename to recipes-bsp/efibootguard/efibootguard_0.8-git+isar.bb
> index 4bdf76a..ebd848d 100644
> --- a/recipes-bsp/efibootguard/efibootguard_0.7-git+isar.bb
> +++ b/recipes-bsp/efibootguard/efibootguard_0.8-git+isar.bb
> @@ -22,7 +22,7 @@ SRC_URI = "git://github.com/siemens/efibootguard.git;branch=master;protocol=http
>  
>  S = "${WORKDIR}/git"
>  
> -SRCREV = "442e87bafb480ada2b9074f02350a30408d4cf9c"
> +SRCREV = "ac1685aea75fb3e3d16c0c0e4f8261a2edb63536"
>  
>  PROVIDES = "${PN}"
>  PROVIDES += "${PN}-dev"
> 
> 

Thanks, applied.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--HxjgQbr6BgzP49OVHigR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6509): https://lists.cip-project.org/g/cip-dev/message=
/6509
Mute This Topic: https://lists.cip-project.org/mt/83525241/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--HxjgQbr6BgzP49OVHigR--
