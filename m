Return-Path: <iwamatsu@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B450FC369C2
	for <webhook@archiver.kernel.org>; Fri, 25 Apr 2025 22:07:11 +0000 (UTC)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
 by mx.groups.io with SMTP id smtpd.web10.411.1745618826511302505
 for <cip-dev@lists.cip-project.org>;
 Fri, 25 Apr 2025 15:07:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=LMe2frBm;
 spf=pass (domain: gmail.com, ip: 209.85.160.171, mailfrom: iwamatsu@gmail.com)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-476ab588f32so44959191cf.2
        for <cip-dev@lists.cip-project.org>; Fri, 25 Apr 2025 15:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745618825; x=1746223625; darn=lists.cip-project.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jV4yUaJ2ZD3iHJ+W5mtF6at7VGr2HokiFC6/PEjFfHA=;
        b=LMe2frBmwZ3YWFWrb/nbd9hxpubd8jFLhKBWPhzzFY8zUQq1oJp7S/VGXHNbY4OzxR
         vkBTP/Y6xxvqti7REVtIVHobQlqPUZKNZ3hNOkk2dh5KjpKbaurgVBBuql3m85afoaxE
         7nZMRdYEXUNgyAhKzs0bYZnUayvhMTji7wIdyLxwx65yb9WaE8ws79L+czliRLiVlgpC
         9G4L39x+YvNUf7D4F6cpHD9auHqwOidgwccPDBKkzOKnJTlrsbZ6XRYhoIdCBMLV7jy2
         rc/PmkOgUbtmLpYwNdFVwk2yskInth1BF1zx6/nldtlMfO3O4LI2TO9o0kSHPRFYleqM
         CAKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745618825; x=1746223625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jV4yUaJ2ZD3iHJ+W5mtF6at7VGr2HokiFC6/PEjFfHA=;
        b=uRBJot3XOaSPvFnYIpbYGUUMu7/05C2zjKsfqp1RCziRIuFWEK2lTUSvL9ZWKjRyWT
         n1HNjtn1mNypIi6Zx/dhdJBSUAJ2ZHEw7VoULTYsKL/XpiQzmXjEOKeUevtmaRuFj4hW
         Gvq/oUGbzgGhM1aurR5kyzw5Lb7doAkRlIs14J/miKzNwZ+IznTzBIn0xaNsG7LYFEq0
         6X3BBjwIPa8c1J5PePMI//HSdREYow5d1+hAd4PEWQn54HPeSG1HK7UvgHRsRzXlLTIq
         pr1UP9aXhd0NsfCLNKX1jmQlGLtHGskCH3pi0mUjppd3eQbzhkBaei0xPbPyjq61dVBa
         BFPA==
X-Forwarded-Encrypted: i=1; AJvYcCWe4kMdDSt1pbNEhvm8BmLvsTwpPyhg91TdLqcLBrwNslktwovjj6Dh4OcQ38Bp5sgKnvvRR/w/@lists.cip-project.org
X-Gm-Message-State: AOJu0YzlfMy16jXU72IQv6bsQARjyRuggYKWaEr1A17gsykdhYhRgw+b
	Eiu2Mf+DVIR2GvinylwVMvV4k2gSc67urGz+Xf5RNb9AdlmWwdeAnoI/viUxGsi5wdUhQK1lyKF
	0gwJxLZtrYtrfmbuH0BzZ2Sarl54=
X-Gm-Gg: ASbGncuIr+8OdNJm3kurGtbSplyvVU06GyM9iN9th0pACJGLqVsbBte/Zu3pV2LH0m4
	Wx4spZjKxW6q/T5n3SK/EZMdrR669AvuqXmQ7HhiNQINdRLjaLf0vSoRywINE7j8Sn6Lc5/tXsv
	e6lxF6t7eJA8u+KpB+CPw=
X-Google-Smtp-Source: AGHT+IFCbTBauLxeMbC3uY8asrX7Bg2vH3LtOIvV+Qb8l69RKJfby0D3RDJJx3j550gtU6UF/A1igjBNnz6m5llzEn4=
X-Received: by 2002:ac8:5e11:0:b0:476:b7cf:4d42 with SMTP id
 d75a77b69052e-48131de3bccmr19324981cf.27.1745618825477; Fri, 25 Apr 2025
 15:07:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250425091057.33752-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <aAti7FKVCHFN4Tdu@duo.ucw.cz>
In-Reply-To: <aAti7FKVCHFN4Tdu@duo.ucw.cz>
From: Nobuhiro Iwamatsu <iwamatsu@gmail.com>
Date: Sat, 26 Apr 2025 07:06:54 +0900
X-Gm-Features: ATxdqUHtwvTSV212D3BpW2xIaqDGiIXF1cDRh4SWzN2R9RUujbY8ClfCE_twW0Y
Message-ID: <CACe6DC64Hpc1870ucfH4P401M8YuVNgq5+RktY+ePT+RMArrgQ@mail.gmail.com>
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 00/15] i2c: riic: miscellaneous code
 cleanup and improvements
To: pavel@denx.de
Cc: prabhakar.mahadev-lad.rj@bp.renesas.com, cip-dev@lists.cip-project.org, 
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 25 Apr 2025 22:07:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18644

Hi all,

2025=E5=B9=B44=E6=9C=8825=E6=97=A5(=E9=87=91) 19:24 Pavel Machek via lists.=
cip-project.org
<pavel=3Ddenx.de@lists.cip-project.org>:
>
> Hi!
>
> > This patch series includes miscellaneous code cleanup and improvements
> > to RIIC driver used by Renesas RZ SoCs. Below are the features which
> > are backported:
> > - Runtime PM support
> > - Suspend/Resume support
> > - Fast Mode Plus
> >
> > Note,
> > - Patches 9-15 have been recently posted to 6.12-cip
> > - All the patches have been cherry-picked from v6.15-rc3.
>
> Thank you, these look good. I can apply them if they pass testing and
> there are no other comments.

I reviewed this series, looks good to me, too.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro


--=20
Nobuhiro Iwamatsu

