Return-Path: <hirotaka.motai@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD3FCA0FED
	for <webhook@archiver.kernel.org>; Tue,  9 Sep 2025 08:16:52 +0000 (UTC)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
 by mx.groups.io with SMTP id smtpd.web10.7348.1757405802478126139
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Sep 2025 01:16:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=qXl64AKc;
 spf=pass (domain: miraclelinux.com, ip: 209.85.219.179, mailfrom: hirotaka.motai@miraclelinux.com)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e96dc26dfa2so4468978276.1
        for <cip-dev@lists.cip-project.org>; Tue, 09 Sep 2025 01:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1757405801; x=1758010601; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ml412fzF8HqC28wXjE59cXRQn9YKgLMQXIReVwR/mIM=;
        b=qXl64AKcemaKuR6J0cptlNe+eiRfzlIaMjjBu/yhPIOwwWYR6hP+rvHGvQO1lzH6+Y
         1Tbk8W79ASu4EA6PaxBbSStrhurhgVL+k+iHIS/AHgIPVSFSAdHo1g5GsqtKo0volgDk
         BPW0WhC5TIwx0WAmkf/zH03fiDCCi19mUpCDFP93YOJMDtZcgu83UP4Ffd5EBG8BCMco
         uyAYLgUwwtimye+yfPrWLnCP8iflHMp415OkO831aK+MSLFY1jDleGe36bWpEfv+AjIn
         NlwrOy0zmtU6Ek1sSVimTP3C+i0C63QToIjsu+m5gcO6Gh0bMtw6Yy1mBBm+cvQaS2rC
         7J2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757405801; x=1758010601;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ml412fzF8HqC28wXjE59cXRQn9YKgLMQXIReVwR/mIM=;
        b=PM4bn7WlrvLJtngecBhZGWibwN7Y38xg6vqKz6otrt9jqXv5Is0piwluIQpMEp1eQM
         231eYYGbosKIrwIsiT1sT6EL7MbKQdCWlDFhG8Cz6O6Z0ZywKUEtraULwkbPgbOru/aA
         kAe3Jnd3NsAhgjnKAyUuQQj9UtcaTJjoGq5fI70QEeAngcaL9g3nhAVe6k8LJTpBACCn
         CAI3MJHT+JeSsD4FwAlu2qrHe3GU3dzThlghWdymVteWQ9Sao599mBOiIK1m1fi+dxOp
         9EQw780vOqqR5zW5XzOuPhAEa5Nlw42tE8qgxpM1ksi8+DZLi6ZmXIj/2+zE6DmpewM6
         mtqg==
X-Forwarded-Encrypted: i=1; AJvYcCVhgb8AcNuYXK6Bc28dtv9QZW+EaTgmzTYcxviYpWsmeDEC3JiEAKfkuZ+iW5WSrWyWBWoCH+A5@lists.cip-project.org
X-Gm-Message-State: AOJu0YxBne99eU/N7/G7VV4b6sERFcImRNwmRwxj+QNL30tWHtG3lLKO
	5Nl+afkvfOgsjYKZA8ycVHMk/iDwCSBywBSR7Bb/khTErmLNZLtkCfgWvFwSJtUvCa2fg8ZSHM2
	04o6ZypxKHVwIzhdRpRQiqSTu2q2znoTeqMtjlZKzPg==
X-Gm-Gg: ASbGncteqw9TT1PfNedZ7jkC+G+vBgJanssK6pEaxXD/WAaYYlMKCpmXIzPQ4qcjUMV
	quTcgbt0iHYXL24m72nuWphhMcFJVlpucHNemh9vLw4IH23b1dR7lgm+9NqMUlXBj+WDjDknim3
	KQRkIBN+NzhAlPIP2R/OjSCIZZN1WNWe1p/ArbvYtNkA9xZ7TsHbfhS2Xc8xGR2q1KHxKYjkhh/
	gax4Zn80u8SnzOHU5+nc+QlUGB+XA==
X-Google-Smtp-Source: AGHT+IF7AZJhC0eqpQoW4zfzzUZEiO74m5QUxuWO1juylAehuVrK+edM3Ei8qBLQgHJ4krkn8UN5wUWBbTUqHLEqBKg=
X-Received: by 2002:a53:c643:0:b0:5fd:934e:9208 with SMTP id
 956f58d0204a3-61029a5065bmr7544063d50.30.1757405801593; Tue, 09 Sep 2025
 01:16:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250718100926.3151777-1-hirotaka.motai@miraclelinux.com>
 <20250718100926.3151777-5-hirotaka.motai@miraclelinux.com> <d48a61b1-347e-483d-b9a4-72c327aaf7cf@siemens.com>
In-Reply-To: <d48a61b1-347e-483d-b9a4-72c327aaf7cf@siemens.com>
From: Hirotaka Motai <hirotaka.motai@miraclelinux.com>
Date: Tue, 9 Sep 2025 17:16:05 +0900
X-Gm-Features: Ac12FXxBeSuyIx-Ar0faB8p6PGaQrMTFd6Fgz-CpJTPR_ssGW6RYg1qD4Z7PfjE
Message-ID: <CANqL_V+HGoa_E_3tOz0WaW19dfW4DV9X0QXQ_=tL+vaoMXObHw@mail.gmail.com>
Subject: Re: [cip-dev][isar-cip-core][PATCH 4/5] zynqmp-zcu102: add kas yml
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 09 Sep 2025 08:16:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20025

Hello Jan,

Sorry for the late reply and thank you for your comments.

>
> On 18.07.25 12:09, Hirotaka Motai wrote:
> > Signed-off-by: Hirotaka Motai <hirotaka.motai@miraclelinux.com>
> > ---
> >  Kconfig                     |  5 +++++
> >  kas/board/zynqmp-zcu102.yml | 16 ++++++++++++++++
> >  2 files changed, 21 insertions(+)
> >  create mode 100644 kas/board/zynqmp-zcu102.yml
> >
> > diff --git a/Kconfig b/Kconfig
> > index e0788926cf12..5c9ded15136e 100644
> > --- a/Kconfig
> > +++ b/Kconfig
> > @@ -57,8 +57,12 @@ config TARGET_HIHOPE_RZG2M
> >       bool "HopeRun HiHope-RZ/G2M"
> >       select ARCH_ARM64
> >       select HAS_SWUPDATE
> >
> > +config TARGET_ZYNQMP_ZCU102
> > +     bool "Zynq UltraScale+ MPSoC ZCU102"
> > +     select ARCH_ARM64
>
> Do we support that board even with kernel 4.19 and 5.10? If not, make to
> exclude those kernels when the board is selected.

I would like to support 6.1 or later for zcu102 in isar-cip-core.
kernel 4.19 and 5.10 are supported, but not needed in isar-cip-core.
I will update that only 6.1+bookwarm and 6.12+trixie can be selected.

> > +
> >  config TARGET_QEMU_ARM
> >       bool "QEMU ARM (armhf)"
> >       select ARCH_ARM
> >       select HAS_SWUPDATE
> > @@ -84,8 +88,9 @@ config KAS_INCLUDE_BOARD
> >       default "kas/board/qemu-amd64.yml" if TARGET_QEMU_AMD64
> >       default "kas/board/x86-uefi.yml" if TARGET_X86_UEFI
> >       default "kas/board/qemu-arm64.yml" if TARGET_QEMU_ARM64
> >       default "kas/board/hihope-rzg2m.yml" if TARGET_HIHOPE_RZG2M
> > +     default "kas/board/zynqmp-zcu102.yml" if TARGET_ZYNQMP_ZCU102
> >       default "kas/board/qemu-arm.yml" if TARGET_QEMU_ARM
> >       default "kas/board/bbb.yml" if TARGET_BBB
> >       default "kas/board/iwg20m.yml" if TARGET_IWG20D
> >       default "kas/board/qemu-riscv64.yml" if TARGET_QEMU_RISCV64
> > diff --git a/kas/board/zynqmp-zcu102.yml b/kas/board/zynqmp-zcu102.yml
> > new file mode 100644
> > index 000000000000..4663d8858a88
> > --- /dev/null
> > +++ b/kas/board/zynqmp-zcu102.yml
> > @@ -0,0 +1,16 @@
> > +#
> > +# CIP Core, generic profile
> > +#
> > +# Copyright (c) Cybertrust Japan Co., Ltd., 2025
> > +#
> > +# Authors:
> > +#   Hirotaka Motai <hirotaka.motai@miraclelinux.com>
> > +#
> > +# SPDX-License-Identifier: MIT
> > +#
> > +
> > +header:
> > +  version: 14
> > +
> > +machine: zynqmp-zcu102
> > +
>
> Extra newline at EOF.

Yes, I will remove it in version 2.

regards,

--
  Hirotaka Motai <hirotaka.motai@cybertrust.co.jp>
  Cybertrust Japan Co., Ltd.

