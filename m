Return-Path: <iwamatsu@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E240FD59F51
	for <webhook@archiver.kernel.org>; Fri, 12 Dec 2025 23:03:47 +0000 (UTC)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.830.1765580619441878171
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Dec 2025 15:03:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=FpGyEuvT;
 spf=pass (domain: gmail.com, ip: 209.85.160.169, mailfrom: iwamatsu@gmail.com)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ee14ba3d9cso15690491cf.1
        for <cip-dev@lists.cip-project.org>; Fri, 12 Dec 2025 15:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765580618; x=1766185418; darn=lists.cip-project.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zkAi9K8iCgZmUpx9wQ7cvGr8t3yiXmBdIEW39IcnOIA=;
        b=FpGyEuvTBa2UExG8V9td6LIEW0kzfJ+dyhNXwAJXdqy9M8jGiq53qSvy94BE1KKQxl
         kJ3fAtkE+f1uNnc6QKeYKJO91iZPWBwaiKuZjWInz5b+myyA8vudplJDpmuzbfzA2hUV
         pM+6yJq91itkMV78AXMQJNSg8Dn6aTUtztfKauk7lhBBY6B9LRBcWpXtKgWCpFmN8p73
         gagkJaBBoOaOB41YtYfqq0L1nyMMSZECQ71GXJI+LvTi7+6PsNfd9veqnnwrMzxhbXRF
         YuMuN2kXn/eoZK4bdmUxf15vuihk6TnxwkZi2FUO+1ZLoysQ2OnWCans+4zYxN+Oea3q
         F+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765580618; x=1766185418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zkAi9K8iCgZmUpx9wQ7cvGr8t3yiXmBdIEW39IcnOIA=;
        b=Axgdb4iRtGfrKeOoh9I3ZyQEua9zYP7CZQaSFryEU2YKK6yrzVKtm7wcw7XY/eQdE/
         7u+VCWGjYqJ++hbX+useNh3SPYo2o0KDQR6v9kJ8NAw3W1JhsncSRPE0KNe8kjjTFmoz
         b4K/Jy04EfNEwoFW8DTmd9akJLWRK+/QxNvZ/2vBwXZ2H6m9QOFs2TLVJJocOJeGgWYt
         5aoMdZuNrf74yM8u13LML+fV8w0jdUIKqk+SKUY8xIZG/ti2arklT00LBdFoWZCSB0sG
         eAMAH2mbduGgD+aRwxvRnxIVKmvj2oBU1QsACfGHe/5RNJkbsM+EbeXd7FDyLg8thvQ7
         /UtA==
X-Forwarded-Encrypted: i=1; AJvYcCV9iPe/0n+k8ZPfW8bVsZKo3pFgDx9ZyEn7Aih6zOfJOxy4h7hEaAE6saH9o4MoGrEPoId7fYSk@lists.cip-project.org
X-Gm-Message-State: AOJu0YyLq3zJUs7o1H9yKX+vKovTRdzoKt5NiY5OBr5M1aV8utV7BrQO
	GYDs+xxkGycBv9ZEkdudFLFoZ6bNGF2spaMagiiztY7Myz53hlaV8Y9miA95neNLP9Eje9D9kV1
	2H9qEKV3MJyrl4tq/tItbaFclQGwGlzfJABRM2ug=
X-Gm-Gg: AY/fxX5Spu57IBUvi4iYzk6G4R5oFCNxfT5Rv2Hln24wesmg1YN6+/QgGay31z0W4+w
	DElfCa8u54kMDc4QC7bpi3MNkhr74H+DzDXoB8JP+6TFplaUi1IoPeFJ8jTQJAL0KrUmawoOtRh
	4bbgNHUpbVN19DeB1vCoh9dsfQdB8NDtp+WcuS8Bikn/wYeSbs5aIiyCUkj8/iXRLDwy2vYb931
	SZjJPCYEPemN0B7vGpKviGm7kK06kgQOUvI6VijELCNvLhANGC+NWZ//o+FXi6MGai7
X-Google-Smtp-Source: AGHT+IFCM6123t+/IFdSafVT56qnxbyhbXwjA6dBh9205jfp2speDaDz+MMegn6Bhm4cbdZaw9qU17X7lX1ImdTwfzA=
X-Received: by 2002:a05:622a:1dc9:b0:4ee:15b8:e9b with SMTP id
 d75a77b69052e-4f1d059d447mr46777761cf.42.1765580618427; Fri, 12 Dec 2025
 15:03:38 -0800 (PST)
MIME-Version: 1.0
References: <20251205143258.13748-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <aTwSUpVdQYXyTzTQ@duo.ucw.cz>
In-Reply-To: <aTwSUpVdQYXyTzTQ@duo.ucw.cz>
From: "Nobuhiro Iwamatsu (Toshiba)" <iwamatsu@gmail.com>
Date: Sat, 13 Dec 2025 08:03:27 +0900
X-Gm-Features: AQt7F2qM04rGFGE9FoTkayKCa7JNTrWitSce-rIY5B88bDnAphmAzKhMUi5mjco
Message-ID: <CACe6DC7hm8EjQvn0KC2saK0S9bZgHffsnNhFd7v0OcdKBTKAPg@mail.gmail.com>
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 00/38] Add support for Renesas RZ/T2H
 and RZ/N2H SoCs
To: pavel@denx.de
Cc: prabhakar.mahadev-lad.rj@bp.renesas.com, cip-dev@lists.cip-project.org, 
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Dec 2025 23:03:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21005

Hi all,

2025=E5=B9=B412=E6=9C=8812=E6=97=A5(=E9=87=91) 22:02 Pavel Machek via lists=
.cip-project.org
<pavel=3Ddenx.de@lists.cip-project.org>:
>
> Hi!
>
> > This series adds baseline support for Renesas RZ/T2H [0] and RZ/N2H [1]
> > SoCs, covering DT bindings, SoC configuration entries, CPG/MSSR clocks,
> > pinctrl support, and the necessary updates to the sh-sci driver to hand=
le
> > the new SCI/RSCI instances. It introduces initial SoC and EVK DTSI/DTS
> > files, refactors the existing RZ/T2H EVK description, and adds variant
> > specific data and common EVK features such as pinctrl nodes and user LE=
Ds.
> > These changes form the core groundwork for further enablement in
> > CIP.
>
> I had some minor comments, but overall this looks good to me, an I can
> apply it if it passes testing and there are no other comments.

Thanks for your review.
I also reivewed this series, LGTM.

I don't think Pavel's point will be an issue to apply.
So I applied with Pavel's reviewed-by tag.

>
> Best regards,
>                                                                 Pavel

Best regards,
  Nobuhiro


--=20
Nobuhiro Iwamatsu

