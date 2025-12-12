Return-Path: <iwamatsu@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DBDD59F53
	for <webhook@archiver.kernel.org>; Fri, 12 Dec 2025 22:59:57 +0000 (UTC)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.706.1765580391696872463
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Dec 2025 14:59:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=bKp6PQMB;
 spf=pass (domain: gmail.com, ip: 209.85.222.175, mailfrom: iwamatsu@gmail.com)
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8b9d2e33e2dso248344785a.3
        for <cip-dev@lists.cip-project.org>; Fri, 12 Dec 2025 14:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765580391; x=1766185191; darn=lists.cip-project.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uNDcjEPevgS4r6SgZw2dp69UBhv6R8l0J9tbCqpykhk=;
        b=bKp6PQMBTqG42ygMwdddrL780kVTPKv7Dg5mRHHn5+Rmipwz/CJWTnxbeAJf64s7QW
         5gMXXcu/YBiihrmjPc4EHcSH483OMeKVnwf36DrLYmc63OMl+hT0bwf/xu0He1kIlUye
         vUcaHhmtf95j5Hp8qpGuE8MvMdfGz+WWsUsTqFlipMm0aI3HOVQGxYnjAn1NlBij/hmd
         lLeXFMuuxQ0qF4UpmmqYkEcQc85JC150+SICde4BLes/1qA+F/3eayTxnP6duv/5wU8X
         7ZoX0Dg2wqEVo8OpybbhM+vC3ezsHJRy8SkzsBZdRAudcEWQuzYo0sc67WJJ6L0rPdxX
         jNOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765580391; x=1766185191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uNDcjEPevgS4r6SgZw2dp69UBhv6R8l0J9tbCqpykhk=;
        b=T89ffUZdgzBhFik4r6Ivvlkr18YLLZN6R/0/OAoHcUepn9j5NKvhJL2t/wOS8CD1FI
         1ULcvRoBqZgo54BTRIVg+ckSMef6Nm9mBmbWHEav6yAlqhCgkJoE8qu/L88F8jT5B/bb
         Qplr5m9v3A2Wc9wxYRIuM/Y6RFOghn7hkR8eD1w2s2l/WzfhteDtrYwxGmZoETUv6JzS
         X2LqTSTOb2W4lllcIZF6QQW3C5vGR71krX0YCN7VSa425kf1ZBfJ7tpIR3rY5bmq+rJj
         wdZQe1aa9+J197K7m3A8GOisWUYOYuaZz+91O4BGWQmOZGfUg+xdWeW41LZPG7365cAw
         ykuw==
X-Gm-Message-State: AOJu0YxJNnwYpEDtdlK1/U4iACKw0Hp4fxBfEfDT75E8Rr9OMZgptYfz
	rPPYozcbtPNniu42fkVs9IvYiq3EJ3hpaRhBzq/2zR0IgsJRSSEEKr30dS+XtHjEigw5KU4pOpV
	Qh9OZDR0oXLrov4NVd8qlO6U1P7ln0LU=
X-Gm-Gg: AY/fxX4Q1mVLYOwB2mKYRZ6sG1j5h5X+Bkccn81xqtriZ8ODtwitod6uY9sNStpCRJ3
	PFEcU9Y8ziQCfygTrbEb8TceVZVp2Uz1N9BIOFsFC84ivlQc/xG7faIiN6YyOHDDKu6ivok7fs2
	Eq6+r3qmPp2/JUJqj7l9UbVU77QEZc9FohAj6UTZdsFamTOcfUDCESSCCeIhFL6aTLx40RIrhxZ
	BsdGmJ2Pb6+kYlwAopRpexYCxqAmQdrGXJBKzqvcXVzXdXlZ6ish9h8mCtHrs/DshEO
X-Google-Smtp-Source: AGHT+IGaSF9VzNzhu/V92KWiZvpj6tGBJzh9lW7rS7qudZAQqBvYDbvF9GSmrt36AMLjWwncLkI/+xwDNTyHssAG5q0=
X-Received: by 2002:a05:622a:5819:b0:4e8:93a1:7464 with SMTP id
 d75a77b69052e-4f1d0467e81mr46457551cf.15.1765580390647; Fri, 12 Dec 2025
 14:59:50 -0800 (PST)
MIME-Version: 1.0
References: <20251212091928.22009-1-ovidiu.panait.rb@renesas.com>
In-Reply-To: <20251212091928.22009-1-ovidiu.panait.rb@renesas.com>
From: "Nobuhiro Iwamatsu (Toshiba)" <iwamatsu@gmail.com>
Date: Sat, 13 Dec 2025 07:59:39 +0900
X-Gm-Features: AQt7F2pFAD2oamkaDtPHtfHirNaNKMCeUvr9gikNFc8CmMrOCMxRouIj1Bwu5G8
Message-ID: <CACe6DC6jXh96DxOZitzSNkWAS60Z2gLsKaPwxXT3ynbJw5GLPw@mail.gmail.com>
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 0/5] Add RZ/V2N General Timer (GTM) support
To: ovidiu.panait.rb@renesas.com
Cc: cip-dev@lists.cip-project.org, pavel@denx.de, 
	nobuhiro.iwamatsu.x90@mail.toshiba
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Dec 2025 22:59:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21004

Hi all,

2025=E5=B9=B412=E6=9C=8812=E6=97=A5(=E9=87=91) 18:19 Ovidiu Panait via list=
s.cip-project.org
<ovidiu.panait.rb=3Drenesas.com@lists.cip-project.org>:
>
> Hi,
>
> This series adds General Timer (GTM) support for the Renesas RZ/V2N SoC.
>
> Patches were cherry-picked from mainline kernel.
>
> Best regards,
> Ovidiu
>
> Lad Prabhakar (5):
>   clk: renesas: r9a09g056-cpg: Add clock and reset entries for OSTM
>     instances
>   dt-bindings: timer: renesas,ostm: Document RZ/V2N (R9A09G056) support
>   clocksource/drivers/renesas-ostm: Unconditionally enable reprobe
>     support
>   arm64: dts: renesas: r9a09g056: Add OSTM0-OSTM7 nodes
>   arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Enable OSTM timers on
>     RZ/V2N EVK
>
>  .../bindings/timer/renesas,ostm.yaml          | 12 +--
>  arch/arm64/boot/dts/renesas/r9a09g056.dtsi    | 80 +++++++++++++++++++
>  .../dts/renesas/r9a09g056n48-rzv2n-evk.dts    | 32 ++++++++
>  drivers/clk/renesas/r9a09g056-cpg.c           | 26 ++++++
>  drivers/clocksource/renesas-ostm.c            |  4 +-
>  5 files changed, 145 insertions(+), 9 deletions(-)
>

I reviewed this series, LGTM.
I applied with Pavel's  reviewed-by tag.

Best regards,
  Nobuhiro

--=20
Nobuhiro Iwamatsu

