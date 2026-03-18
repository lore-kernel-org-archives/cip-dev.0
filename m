Return-Path: <iwamatsu@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39A51088E42
	for <webhook@archiver.kernel.org>; Wed, 18 Mar 2026 22:00:02 +0000 (UTC)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.26470.1773871193837730847
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Mar 2026 14:59:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=G9ByX1KX;
 spf=pass (domain: gmail.com, ip: 209.85.219.42, mailfrom: iwamatsu@gmail.com)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-899fc265126so6149526d6.1
        for <cip-dev@lists.cip-project.org>; Wed, 18 Mar 2026 14:59:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773871193; cv=none;
        d=google.com; s=arc-20240605;
        b=kg12rGzGK74ttMbjarY0qK8HRCiYhWRkUlwzQWJioqWn6QgvoWdH9d0RNDS3dBgtnY
         rolDJtTNpr/r9aYt0Zxy/GQ/7bhiFtABLDlq8T8pa2UUt4MZIHiBy/KwRrYOT8HHCcYx
         WH8aelHysazKoYtBpUFuPeBAA4SeCztMkDfgT+/aHHWLjyfdtl43jPdIN6GnmEAvIkm0
         jZudbF9vA1ZYAWKzv8DsyAMGbcJIyyjwBxzg6v6ZUUlySxFRMfc1YtawpIW2yWrDqtyY
         T0DdIax97L+i1UzzOdO7r86nzHk7cmgK4CEgtH1ZdkiHzX932v/B7Mb3qstX782G/eR3
         7xvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dJ/hfi4UQWI7WQAZr026WXAWMdxdrO9fep/6z1EFz6s=;
        fh=m+qa2aEGOdm3Og990qtqInV7DgsFjXiBEq62CoMEmgI=;
        b=IbJNMZ1MDkRDfZk6PcrqqYmvhD16RKFeIuGzvmxGQJqoN/ZFOB93vttaUFMLmUjPEA
         Kcv/N/aLo4wWtWzMTsepH+5Ae6yNM4z8dDKMkKfEQksiSFUFbUJ5DW6WyzN0CFvOoAlR
         o3s3NxwDki+fXA+64sQL7L3ul2QfwChVuHd2bxu3x/5Y9SeXgY4WeXs/iCa+DDLIaJH8
         KCpHdw7m8Fo/990A8VkaeqwrtZVlztY+i2QCMAtAvhl+9icLbeMr9RrUOoG0cGPoDg/W
         FjRmPryVrvepTzeYT8aLZusmeJYRgY8eF4tkdQiQ9ejtyX3mX585GHvfmiiChxOptM3l
         o46w==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773871193; x=1774475993; darn=lists.cip-project.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dJ/hfi4UQWI7WQAZr026WXAWMdxdrO9fep/6z1EFz6s=;
        b=G9ByX1KXyCh6NuhN4K2rzTknSlLxUQruJDkmLKeGdTQjr9lOfFtPYETiK4GNTB1ddI
         NMu3b5WqOvlC9UmDi6DoB/umzUqWK3dpIGShQowJ/JwHNJ4tG0rgd6jx0+Td3I2dg18Z
         Q/zciuuD6jnls/iJGAzjWogxhO4ReM+mhvw/jYHtI1GLT6IaHac+nbqb4pfX1CFDVeQT
         xGpNSp1tBPI97Lm7nVe/CjRvYB87Z4680NnTZ7ThZkfVaE9EvrWnEa1fjiURsGDjUXqk
         7Z+bpE20zSOsjV4vEsJb2d6/jusChjnvYWiUDR/fsPp2LX8vTSAnnRjyufucc60v77c9
         QauA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773871193; x=1774475993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dJ/hfi4UQWI7WQAZr026WXAWMdxdrO9fep/6z1EFz6s=;
        b=VvMY+2STjdHT4Orlnu/qVEWojEDdAG15x+sQ+9swGGOpEpKkKC/vzd83THiHHzOQEG
         7tcb/HdCeG+LX5R/T4GNikVZzI1cjfzihM29QaT0NFF1vCAaUjNumAqfJHxsxC5/Wc53
         LX7sJun22Vik6Uex+f5cioJKMLrMNDKtaMcpAVqXezN5GOi0uYkKswbVBGdN0/om+COI
         vk2aFLUxrHyBeV2zGOJTVr2nkaQp87WKK/Q0TiSKBOc+LbHrpPp9CzlJOQqP1llw/wzt
         QEHx+rZ5XyxHonIuaDy8K8OiFnSH6DVgA8YPATvns/Uem1gxD6QS2oBPltB+CrnQEOwr
         wKJw==
X-Forwarded-Encrypted: i=1; AJvYcCVxeLZB6zE0S02am5lBuzf8DmWwntpHbOdiu8BTScUR1DrX0f5Wxn+wfTdHR9WmQE4RIho8CTEV@lists.cip-project.org
X-Gm-Message-State: AOJu0YwR256hYYqNTpmlLMe5NyqDVZj6+h+ltkAMzJyWMq3EnVy4XjtE
	SJsvwhKlhNA73PueAicV/P+bOis3/B2hT2MDCLFfml0TRE2IVs0gj2FzMHrmNfe87SZnj7Lg0CM
	H/xSnXM1GzWOCDjjIjncmR2i9PNFCbtg=
X-Gm-Gg: ATEYQzxumD6RYdDOJZZ0jOfqEcRCs3fhbnw6p8FXa2g05vHuMl6atQgNG5yDAliC+3w
	7b7GvBiVntvaPBQBFdfP9qTTCLNW+U+7n64InprevhgbSyZqkwPjTfPVsoEwjfaV9FCkWdGhCr4
	+kSQOKxBRd6tXYluZ2DB+ZmQwA2h37+O12Iao/x/tvRam6p00L2hcc0JJEwGH5ss2xvfQ6vzDOm
	cRG2SUnHKM1Hczyzg5bM2mx1x8UstG4fG3NGUOWNI3OLVAgKpR9UKcc0jeLDjnjYtNgqJn5P1zM
	n4aHhKyN6/reMw==
X-Received: by 2002:a05:6214:f05:b0:899:e8b8:8741 with SMTP id
 6a1803df08f44-89c6b50cdb7mr74292696d6.2.1773871192732; Wed, 18 Mar 2026
 14:59:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260312153522.1131675-1-biju.das.jz@bp.renesas.com> <abp4Y2FVspUgEpCT@duo.ucw.cz>
In-Reply-To: <abp4Y2FVspUgEpCT@duo.ucw.cz>
From: "Nobuhiro Iwamatsu (Toshiba)" <iwamatsu@gmail.com>
Date: Thu, 19 Mar 2026 06:59:41 +0900
X-Gm-Features: AaiRm52KZmhIcBgkZaCnyOkwhlMbPXwLookZ1emlTa5z3C474FMnnCXR3DRqbBs
Message-ID: <CACe6DC4UgnnvZkv8F23jMa5ih4Oxo1=Vs=_ZR2nDo8iufD3JiQ@mail.gmail.com>
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 00/11] Add RZ/G3E USB3.2 Gen1 Host
 Controller support
To: pavel@nabladev.com
Cc: Biju <biju.das.au@gmail.com>, cip-dev@lists.cip-project.org, 
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Mar 2026 22:00:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22504

Hi all,

2026=E5=B9=B43=E6=9C=8818=E6=97=A5(=E6=B0=B4) 19:03 Pavel Machek via lists.=
cip-project.org
<pavel=3Dnabladev.com@lists.cip-project.org>:
>
> Hi!
>
> > Add RZ/G3E USB3.2 Gen1 Host Controller and PHY support. The USB3HOST
> > is compliant with the Universal Serial Bus 3.2 Specification Revision 1=
.0.
>
> I had some minor comments here, but those should be fixed in mainline,
> first, so they should not block the merge.
>
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>
> I can apply the series if it passes testing and there are no other
> comments.
>

I reviewed this series, looks good to me too.
I applied with Pavel's reviewed-by tag, thanks.

> Best regards,
>                                                                 Pavel
>

Best regards,
 Nobuhiro

