Return-Path: <SRS0=uSvz=AK=lists.cip-project.org=bounce+64572+4864+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64355C433DF
	for <cip-dev@archiver.kernel.org>; Mon, 29 Jun 2020 13:54:42 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1CE52333F
	for <cip-dev@archiver.kernel.org>; Mon, 29 Jun 2020 13:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="BJjW7PEc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1CE52333F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4864+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id qlYYYY4521723xDNvYF0m45Y; Mon, 29 Jun 2020 06:54:41 -0700
X-Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web12.19003.1593438880325780057
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Jun 2020 06:54:41 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 05TDsbDE007038
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Mon, 29 Jun 2020 15:54:38 +0200
X-Received: from [167.87.50.192] ([167.87.50.192])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 05TDsbOl010947;
	Mon, 29 Jun 2020 15:54:37 +0200
Subject: Re: [cip-dev] [isar-cip-core PATCH v2 6/6] doc: Add README for secureboot
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>,
        cip-dev@lists.cip-project.org
References: <20200625141015.31719-1-Quirin.Gylstorff@siemens.com>
 <20200629125400.13968-1-Quirin.Gylstorff@siemens.com>
 <20200629125400.13968-7-Quirin.Gylstorff@siemens.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <b7a2bdf5-edff-b3b0-a64f-9f0556c3853c@siemens.com>
Date: Mon, 29 Jun 2020 15:54:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200629125400.13968-7-Quirin.Gylstorff@siemens.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: H516Tv75aOjak1FMiPYAfDgqx4520388AA=
Content-Type: multipart/mixed; boundary="VEKJBhYgaI3jJe5JctHi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1593438881;
 bh=oc9l8o6xQfXaxyimzSWcLSCMtTQdZnMcscIXoLl9S30=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=BJjW7PEcNPWeb+j79xUwi5Fw4425cMtMiNbgD5ijLiEKrygbA5HHxklLyNvxALnCuHA
 jAj7KKt9caSfXNBjYXwkwAFkPFg7ii6hwPAL8hjlNHh8iDG+IEuaoXa6ZannJWO7dkoly
 kW5/Yz43ZMaJP+aOIHEoQNot1CNZrkan17M=

--VEKJBhYgaI3jJe5JctHi
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 29.06.20 14:54, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>   doc/README.secureboot.md | 188 +++++++++++++++++++++++++++++++++++++++
>   kas/opt/ebg-swu.yml      |   2 +-

...

> diff --git a/kas/opt/ebg-swu.yml b/kas/opt/ebg-swu.yml
> index 5b39730..81d90ad 100644
> --- a/kas/opt/ebg-swu.yml
> +++ b/kas/opt/ebg-swu.yml
> @@ -22,5 +22,5 @@ local_conf_header:
>       WICVARS += "WDOG_TIMEOUT"
>   
>     wic: |
> -    IMAGE_TYPE = "wic-img"
> +    IMAGE_TYPE = "wic-swu-img"
>       WKS_FILE = "${MACHINE}-${BOOTLOADER}.wks"
> 

You are trying to sneak in more than a README ;)

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

--VEKJBhYgaI3jJe5JctHi
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4864): https://lists.cip-project.org/g/cip-dev/message=
/4864
Mute This Topic: https://lists.cip-project.org/mt/75190456/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--VEKJBhYgaI3jJe5JctHi--
