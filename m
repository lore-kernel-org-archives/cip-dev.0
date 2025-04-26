Return-Path: <iwamatsu@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E29EC369CB
	for <webhook@archiver.kernel.org>; Sat, 26 Apr 2025 23:15:54 +0000 (UTC)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
 by mx.groups.io with SMTP id smtpd.web10.17970.1745709345110901656
 for <cip-dev@lists.cip-project.org>;
 Sat, 26 Apr 2025 16:15:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=J/n9THtN;
 spf=pass (domain: gmail.com, ip: 209.85.160.169, mailfrom: iwamatsu@gmail.com)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-47698757053so50911031cf.0
        for <cip-dev@lists.cip-project.org>; Sat, 26 Apr 2025 16:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745709344; x=1746314144; darn=lists.cip-project.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zlYhZOheoY7WwK9zPStYia4LqManWP9ctgSA+lDyK2Q=;
        b=J/n9THtNI4dL3i2opQj18WWbxnEhV+lWvymxR8oeHVG93y4D6xWqYcJLxHd+NxlwT8
         Qocg07mfuFzjRtd7hheYoqfV5m1R5g2IpyDxuTql+30mvk8PMazqr30HclCtyLFKJvVJ
         /aL0ge/iyXw8mvf9LtbS2jOVCn7aFc8OPQjOs6fT6U3Qd7mPlIvbPnWb34uROYXWhw3/
         duravk1zhdv8oInCmQnqxf8dTbHKNpCF4e5P1vlX8oTvclAhOe/L1D41tyVuSi7DLZ76
         vx5OSlt3nlMz9zwqb8Yj0qWRzdSSa28e4rQwgy/HwKS6pI/R3Nlu8g+1gSHSgikEjMte
         TP7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745709344; x=1746314144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zlYhZOheoY7WwK9zPStYia4LqManWP9ctgSA+lDyK2Q=;
        b=ObMndF1wBmcg5XXRKXhztEYJeCdpwFNHKppyHQqTW16l7/f5czJbmtPW0JA1gVu+Lu
         Kt0Tg0rvzpWGVsGC2j+mFhqpn/fvYqqfOp6G12UCsTBM3T+ySlDXccgqTlg11/iSBNP1
         errTTVglMR08uv7DOGACHyPcerYU9kVW+WPkBxLRJvIrXgXrDF0PqgwVxNiTcNh8vaPy
         fKAR/xr3rEV5BbjSaXkmRfGE0HAn88GX5dHDnjpY/Lwrim/ecTUKmmy9pk+nt+t8nfwH
         qO6SX4hMkM4omsjM/bAiaQ4VIZRSY+n9ehKDJZLLLuWf7nbaO2ceFBZVpek4HUbeVuyD
         qoSA==
X-Forwarded-Encrypted: i=1; AJvYcCVpG8rFb713N3gAhG1C2LwR/CwAIDmAtB/dHxqvE6xIrPxBQzY/TBKJvaClVkEp69AfmuH8lB9g@lists.cip-project.org
X-Gm-Message-State: AOJu0YxCGCnNPLGPyfakOUUbrtiu3qlJHQoN760ObUWGMHUFj3sQzEin
	ZmIhV4cLEUil1QSxluoIgZQKBppuKueM1V94f8iDdCLtyjEciQvbUGKLAHbhqXqOnuTyUNUwuJ4
	kEyvT4w4YrtyGaago4HUG31U2Q+k=
X-Gm-Gg: ASbGncvhtJY5UQKeUMwBmbb7MLDjqaL6cNbW8gUeZD0jw8QnZFKpj87u9vPLzAnGAhb
	jR5qpDEbWvi+G+EdLMQ1FhbiTuwNAUjgW1v5IYLm03OFmQNGUMsJaL4Cnt203HcBxzlgxzeU55+
	baNgJ2+U8vp4iFOkC/v2U=
X-Google-Smtp-Source: AGHT+IHAFGWRduw4/wsG3OW06+HMhmwaZYbU8SMjWCE/ei4oEPR0lOfWlMZ91pGc7NaKMK7zexQJHnhXzYfTfKZQAI4=
X-Received: by 2002:a05:622a:1248:b0:476:aead:802c with SMTP id
 d75a77b69052e-4801e2fb91dmr120471531cf.36.1745709344007; Sat, 26 Apr 2025
 16:15:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250425121445.62818-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <aAyHwQABeRiZtiL0@duo.ucw.cz>
In-Reply-To: <aAyHwQABeRiZtiL0@duo.ucw.cz>
From: Nobuhiro Iwamatsu <iwamatsu@gmail.com>
Date: Sun, 27 Apr 2025 08:15:33 +0900
X-Gm-Features: ATxdqUFLDiuTBHtpIdMD2ZBPg34aZv_Pk_tnr82NBEqolPW6FJmHEgvz1sWg28U
Message-ID: <CACe6DC7aWeXCt0V1f07hu8ro7cjGfrmJ_vDxKxJzJtgugSumJA@mail.gmail.com>
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 00/21] Add SYSC/MMC/GTM driver support
 for Renesas RZ/V2H(P) SoC
To: pavel@denx.de
Cc: prabhakar.mahadev-lad.rj@bp.renesas.com, cip-dev@lists.cip-project.org, 
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 26 Apr 2025 23:15:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18647

HI all,

2025=E5=B9=B44=E6=9C=8826=E6=97=A5(=E5=9C=9F) 16:14 Pavel Machek via lists.=
cip-project.org
<pavel=3Ddenx.de@lists.cip-project.org>:
>
> Hi!
>
> > This patch series aims to add below driver support to
> > Renesas RZ/V2H(P) SoC:
> > - eMMC/SDHI
> > - GTM
> > - SYSC
> >
> > Note,
> > - All the patches have been cherry picked from upstream kernel
> >   v6.15-rc1
>
> And all patches seem to be in 6.12-cip, too. Good.
>
> Series looks okay to me, I can apply it provided it passes testing and
> there are no other comments.
>

I reviewed this series, looks good to me, too.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro

--=20
Nobuhiro Iwamatsu

