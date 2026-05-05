Return-Path: <iwamatsu@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9685ECD343B
	for <webhook@archiver.kernel.org>; Tue,  5 May 2026 21:20:43 +0000 (UTC)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4408.1778016041284305656
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 May 2026 14:20:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=lKuEV6vM;
 spf=pass (domain: gmail.com, ip: 209.85.219.42, mailfrom: iwamatsu@gmail.com)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8b3d6b215cfso92208956d6.3
        for <cip-dev@lists.cip-project.org>; Tue, 05 May 2026 14:20:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778016040; cv=none;
        d=google.com; s=arc-20240605;
        b=e6Np0oRRdretJ1PpqFiEH5m4PN/FoS/gmmlMojwQjBeKpNM6peU0vHGaCBzTw1CcOb
         CsaJ7WDzeDV0tRDE4c5iPqEcYeZ+h2qKnDZ90NtIZDg7LU60jLgEctdv+6Z/DFkTkjqo
         DZk8a1BbIu6IXicfhdrpL/45kqnWbwBVLG1k0rgYaeVoIDLiZqrKA9AKLyVpqHiPhQdQ
         BmCpWg43PMbiBqy9SGjvIPvxwH0fszMSMeHbKTHVp3aD0cNfHwzf8Lz26OZeenQ/m1zb
         haYW3JjRMcrsNxnHQnOEpiNiZL2b238ETxmFUxUPuB+mwhbrB60soeROfOaKMUa6K7HI
         0g5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xAIhPMF8B2w2li6Ld3O54GiyGzFKHw+HyWR1rfYhe/I=;
        fh=vYeCzX6XZeHJbm4HCQpjYtm6nGvzL0gzOEGC5WdSbT4=;
        b=cpoGR4CVE2qXuLWuv1WGraWpqMgmAGVjDNb7gE161a1d0tem0iNOY5MQpxKRBL8yUM
         SEhRB3AGf/yX4VoB3UW8QRi2fwxOcQh8algLFvW34zp8g2yb4V5yFVEh3emV0nDs6OS+
         CpfNL9iuU6Xwsn7MnQelJggax+o38BdWN859qMkklbB2ri1JdGxeCRYpTF1sBMbb637w
         AK4dj91JjAgb+OV6aUYTgQorP1foSZwehl7Tqh8sy6rAHeYvx3xBqnzR46AezRg2rL2o
         d1P43dvZpsUk8l75S1WEt+ToPcrprwCuCb//mlA0nAJWB2HZDgaZOZqBcrVequevCzq7
         iiSQ==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778016040; x=1778620840; darn=lists.cip-project.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xAIhPMF8B2w2li6Ld3O54GiyGzFKHw+HyWR1rfYhe/I=;
        b=lKuEV6vMQsJ+7T2i9bAR1RxH/4AbVH6oO1m5FUtfZpi3aAFQzSwEin2r2/mIgo6+y2
         hNbCfhyFTbtsO6YcP2CBy5eM9n2UwsasOMqxsdnND85pVi/Y5ff0PCktEhqm6Fuaz4OC
         x1z2r3/8aCMFPa+4eiOOzySgiE47AY+3exdl34sXmAzN53Z9764VPompSDx6pF0rhAK4
         LyArokLgbQ4TITqR/uYmAP/mA9Qhrd0lbodTJoDmcxTbk5EMphdyNeeEayJfj9XPmCW3
         nhUJrsKL3QZZNLNxlome9CoRHtzINQbPL9JPKy4t3Mi0RpJh9t9CN4JJc11QGnxKm0pW
         tMpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778016040; x=1778620840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xAIhPMF8B2w2li6Ld3O54GiyGzFKHw+HyWR1rfYhe/I=;
        b=OD3QnC7QPUWSNKONwcPSxk92NjGIm4VP7uixIeJAn0axUPHChcdF3e4HqIYhr6+i4R
         KHa8gxN6nWN7eJe0PdBxXygqhx7TR+SxLzhiij5zz5MmB4SOdJiV1gCE+Uafg+yrKgzG
         WYBkLOEseY/03x59I5qbcLNq3izXqQn+/DQEMCtfxTvwCEcWseTMJrG8d9Z6IzAAto8X
         duhblvpB8BIqdz+9Wzbnys2bQRqeTUq889nWajhEXFVwIkfZTL0C/xkm4bxb+EH2Zjb5
         joFaXPKymfS0Hv1aDxWR5VjKAx2sPOm9hfn+zonFipEYCZHriBEgZfuq85Jn0chjyEor
         6n6g==
X-Forwarded-Encrypted: i=1; AFNElJ/aqXakUgr0K8Q+hy1zslMGDWYFBCdwQIWp0lzKs5muWihPnUb/8f3B4tMv42ytC8iCorEGHIeT@lists.cip-project.org
X-Gm-Message-State: AOJu0YzzJB0EghqczDo/hpQu2gVTvvrT4qRPulMmS3Sx1pBsn9QcI8iW
	M+4g9kpEWyVPhBfLvjg7s/9c+O8BMJ0RYglQhMQdhR2Q0Jc4HFGqHY5oNts3krB9mqWdD4eU26z
	xWH//etKKODxYrcHMcIk9w9wjJsz7QXE=
X-Gm-Gg: AeBDiesObhUtRZHUBqcmI58bel9rbS/O8PSnIKs38jNDi7hiuIVPwEVqE1eLh6y5Fmd
	SGN3eR04UjjByPjiSojscOlwPR8W7N/GCnaNDDPvIO6HIw1eeNN956qlnHTse7xFb6JbxMN45M/
	CCZQY8iZKe6Nnuhh4NPmXFKvR3yR84pi2OW+miGEsD5hWs32PkI3u856jxVjIpoP3UieoHM9dY+
	XLATkH8F5XJMyGpzOV9dLunf3EpkTzADF0k+R0+U+9FT0BC9vjwqf/uJAVLZR9BD3mXFF7sBcoo
	nhdajGvtBlXAj4c=
X-Received: by 2002:ac8:5952:0:b0:509:4198:5468 with SMTP id
 d75a77b69052e-51461c1e10dmr13227111cf.8.1778016039999; Tue, 05 May 2026
 14:20:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260504064943.7237-1-ovidiu.panait.rb@renesas.com> <afhpWFsB2NFh6K9m@duo.ucw.cz>
In-Reply-To: <afhpWFsB2NFh6K9m@duo.ucw.cz>
From: "Nobuhiro Iwamatsu (Toshiba)" <iwamatsu@gmail.com>
Date: Wed, 6 May 2026 06:20:28 +0900
X-Gm-Features: AVHnY4JwJFZ9jrs1gQPYkh0ibnEmNkcC7JyrCVCJESVVZqe3_C0qHAiC-aYmmK4
Message-ID: <CACe6DC4pgZ+RcAHWy4+Tm1PiZ51fWAT5RApZf5UP2uebwP2k6g@mail.gmail.com>
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 0/9] Add USB3 support for RZ/V2H and RZ/V2N
To: pavel@nabladev.com
Cc: Ovidiu Panait <ovidiu.panait.rb@renesas.com>, cip-dev@lists.cip-project.org, 
	nobuhiro.iwamatsu.x90@mail.toshiba
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 May 2026 21:20:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22893

Hi all,

2026=E5=B9=B45=E6=9C=884=E6=97=A5(=E6=9C=88) 18:39 Pavel Machek via lists.c=
ip-project.org
<pavel=3Dnabladev.com@lists.cip-project.org>:
>
> Hi!
>
> > This series adds USB3 support for the Renesas RZ/V2H and RZ/V2N SoCs.
> >
> > Patches were cherry-picked from mainline kernel.
>
> This looks okay to me.
>
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>
> I can apply the series if it passes testing and there are no other
> comments.

I reviewed this series, looks good to me too.
I will apply this with Pavel's reviewed-by tag.

>
> Best regards,
>                                                                 Pavel
>

Best regards,
  Nobuhiro

