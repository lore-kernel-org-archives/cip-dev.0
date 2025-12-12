Return-Path: <iwamatsu@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A82BD59F5B
	for <webhook@archiver.kernel.org>; Fri, 12 Dec 2025 23:37:28 +0000 (UTC)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1409.1765582638134079792
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Dec 2025 15:37:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=LWdAjwYT;
 spf=pass (domain: gmail.com, ip: 209.85.160.178, mailfrom: iwamatsu@gmail.com)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ee1939e70bso15637601cf.3
        for <cip-dev@lists.cip-project.org>; Fri, 12 Dec 2025 15:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765582637; x=1766187437; darn=lists.cip-project.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=myRzdgVelP22NxLO+gpD4zalPQlAdW8HUpo3OMCBj3E=;
        b=LWdAjwYTIYcdEY8ES68Or3mfvCOO/XeuKG35ogp/9b3njEBu9gjteLX6mdlBjAnyOG
         kuXjTOwzhdlti60aTX/552eo1ZqwPPhLNQi0p0PZL5ohEwEqhdVPGbVVzSZD+gJHfmZ4
         c/1pGXK3wIHlVnT+vxKzX+jklnOK4a3s8ynuY77oNFJiecyB86koqlykuDuEhooJMeZk
         c83l+aOgoAYBFn62aj9+YLlUq1hybcO6smToVAqqoIVRBubcqS0hPnMiANp4tKN05n+L
         PYiwl+sYboAB1UucxcA7DqVI85qy/h4RbvuzAsWVleLnwgFSpcnwYLSFm2i23B4EzNmo
         cLYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765582637; x=1766187437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=myRzdgVelP22NxLO+gpD4zalPQlAdW8HUpo3OMCBj3E=;
        b=qQpAKzIz48wqk3DGVVK5VFg418JQegJBrfks/soX7f3dBWnL0/cZ6lFDZRSw/uNRSt
         /0rMGHPViE2HlSILHmmjV7A09Ia15xTsJbzoRgErzX1jYIMHrMX/YRTwNNXnL2W7Fxju
         2rPRQFS92HaptO1XkS4nBoUiG0MTZQOjhN6EEyoFoMgcluLCaYPlZcGA/+UlIrt+4VJK
         WiFrgih3Lr/4fCYWyKqKad3MzhoaILXNBUHK37BuYx2N4W+/T/CvX3Wb0gMRQWpq6OZ0
         RzXQg419Ztphmzmm+wHMHCdj8PmRqTUKaexYwtvKbAkiCN+VCns0yboCppVumcfWSgoY
         0N3Q==
X-Gm-Message-State: AOJu0Yyv+eTvoYeSKbEWJfLuKZZXt/WoWGjSxp3Nom8pAylcoDY8cDo4
	7vBle1FC5uDUcS3ss3+vcP2rzmhpxFzWYBZwKVKsd11BvbvaU62EoUnmwov2F+4g+3a7VkNJqgM
	CES3G5RSDim5ISC+ffJazIQ3MWRhHQMM=
X-Gm-Gg: AY/fxX7688hV2qRMwzR+/IDAyBLAMnC2de2KIULhgtReBPQApX+mtWECQ7l5rZqeTjn
	Of7cd3+QIJr+A2f5DLResQrHWrnkh7j6jVn6kxvZCmb462sd7DMJtCYzmIQsYoLivTwFYokLuVb
	FnOAgT7Jo31EQIXmAahIPElPHXYpj8AxopuSTxbXfNduiFvswWVsdOQRebSmzb7kc4FIYGTA24f
	OZKinpKGJCmTbHewcBNO4SEO2ww2cDP0AoF6z+z6EL1npUA+vGXVpqDjVVutyVWyRcp
X-Google-Smtp-Source: AGHT+IGFtH9b+RKQkC/XzMIaf44Zj+uxSZUyBbO1kWNdEBZT/nbJelFPTjpbCjDgCv3Le4r4lGRkL6Beub88LVM/U4w=
X-Received: by 2002:ac8:6f0b:0:b0:4ee:24c5:2d7e with SMTP id
 d75a77b69052e-4f1d0466d80mr52696441cf.7.1765582637058; Fri, 12 Dec 2025
 15:37:17 -0800 (PST)
MIME-Version: 1.0
References: <20251212213804.24005-1-ovidiu.panait.rb@renesas.com>
In-Reply-To: <20251212213804.24005-1-ovidiu.panait.rb@renesas.com>
From: "Nobuhiro Iwamatsu (Toshiba)" <iwamatsu@gmail.com>
Date: Sat, 13 Dec 2025 08:37:05 +0900
X-Gm-Features: AQt7F2pljIZ473Xd3hQYFTGEdhXG4Bpz2w7SELPFyhgH9cE7GGgxByk3H2QjEsc
Message-ID: <CACe6DC6-RyyEbor39QXftawrwR817hh=s6Bnz7CDed8Ty1tmfA@mail.gmail.com>
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 0/4] Add RZ/V2N WDT support
To: ovidiu.panait.rb@renesas.com
Cc: cip-dev@lists.cip-project.org, pavel@denx.de, 
	nobuhiro.iwamatsu.x90@mail.toshiba
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Dec 2025 23:37:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21007

Hi all,

2025=E5=B9=B412=E6=9C=8813=E6=97=A5(=E5=9C=9F) 6:38 Ovidiu Panait via lists=
.cip-project.org
<ovidiu.panait.rb=3Drenesas.com@lists.cip-project.org>:
>
> Hi,
>
> This series adds watchdog timer support for the Renesas RZ/V2N SoC.
>
> Patches were cherry-picked from mainline kernel.
>
> Best regards,
> Ovidiu
>
> Lad Prabhakar (4):
>   clk: renesas: r9a09g056: Add clock and reset entries for WDT
>     controllers
>   dt-bindings: watchdog: renesas,wdt: Document RZ/V2N (R9A09G056)
>     support
>   arm64: dts: renesas: r9a09g056: Add WDT0-WDT3 nodes
>   arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Enable WDT1
>
>  .../bindings/watchdog/renesas,wdt.yaml        |  4 +-
>  arch/arm64/boot/dts/renesas/r9a09g056.dtsi    | 40 +++++++++++++++++++
>  .../dts/renesas/r9a09g056n48-rzv2n-evk.dts    |  4 ++
>  drivers/clk/renesas/r9a09g056-cpg.c           | 20 ++++++++++
>  4 files changed, 67 insertions(+), 1 deletion(-)
>

I reviewed this series, and it looks good to me.
I can apply to this series if there are no other comments.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Best regards,
  Nobuhiro


--=20
Nobuhiro Iwamatsu

