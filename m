Return-Path: <iwamatsu@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CF4D59F5C
	for <webhook@archiver.kernel.org>; Fri, 12 Dec 2025 23:37:57 +0000 (UTC)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1414.1765582669965250249
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Dec 2025 15:37:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=muPoyBIF;
 spf=pass (domain: gmail.com, ip: 209.85.160.179, mailfrom: iwamatsu@gmail.com)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4eda26a04bfso18548811cf.2
        for <cip-dev@lists.cip-project.org>; Fri, 12 Dec 2025 15:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765582669; x=1766187469; darn=lists.cip-project.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s2Pds/IhrSvPSgrWq8eB/HfQGOO8MbY8B9SfvKvmy+c=;
        b=muPoyBIFZvNCGMa13Mog2LaHpPFE2w3ADdHdzR8tDws+YxccRN0R6/CQqp6ugBBzmF
         eeQmWeqapJYfVe8ObHeZzAfMb3haTvcyrrSxiXA3yErwUI9c0+9czQf0VyqTKX5AHCle
         RyaWbvSynIEqEsb0bOBntivdWI4mzZgJgyCWnUNGykDZYq8Cv4poru8lbWNG+QJ2hNxt
         wJQtEz9pTUV+MrLSXc13Rieew4taIUupk92e5rqyhdXVBLba3zpRDpz8h58TMDn7Msqj
         BePhXavcBhMzxOXWflJjM3ya7ymNJYVkhIvK26PVopnYFQAe4iI+clmdVlUseuiADVeI
         YIRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765582669; x=1766187469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s2Pds/IhrSvPSgrWq8eB/HfQGOO8MbY8B9SfvKvmy+c=;
        b=AE5YzTiHsANuu2Z3toSoLuxq1eUvcBKGfigiW/Xr4KAOofif5mcOL5Xe+xweFVK3EW
         T94/hXmOzpBCSzZGhNPOd9ffreoXyvrm4n8hZkjtmHoDsPj0bv2GDO26rAS5DJz5j5De
         XTpxKF4xfj5qCyqJLJQmkxd9XDl1a1RBKc+1dXIMvqZi5dR5i7ODj5fh25bRzB8FLvuJ
         AXEaW2Ak+SGQPM0nh/EitMrS5ldG0m6Z6mjSdxkdU3L6JrroFxUjEhVw3iFAw6b33uoP
         HoZwKsUZLY/Eosp8oJPfRUsNo4Z5KipMN4EPR7QszSn4wYFuXsPlu5xkCjMuXAHCOmN2
         wobg==
X-Gm-Message-State: AOJu0YzPu9NrEPegdA6t1PEH3VInQC9tqVZV0aO7tLqmqp3Z6cxO6EUG
	lYhjghUi09eNuMwmXWoAUYRIqLnN/AeDz7QuLRsdcxOeaudpuVlPJQzXmu3I3tDP36oFgE/2QsR
	9tjI4xLVseJJ9g6O8fNSb4LFdNsRgXBE=
X-Gm-Gg: AY/fxX7f/RRer2GIhKeDCot/YQuu/PcuLqrz8q7qBgTZ8ZsZjWQUOWEQ6tvtZ9U2Ml8
	e2BISng1H3P6g9SelFXcj0w5lQVP1uGmR57NgKhbLhB5faKm1G0EoBsPGHzfA0YkVjyR19oGlOY
	Pb+kOd/gIjGLJrPub/ryGx2lQQdN7zSwd9Zq5vfTCVsVaTxppoyx7r4kR7RstnAwt7spWtF3EUR
	lA7IR1QBqBZOZa+hJw8iHT8J78XdXXaGQygeNfRqsNeqMSf0jMAxsEoIrxKczcW7lSH
X-Google-Smtp-Source: AGHT+IEVh9q58UhdfpN7w1MBXrWSbq5Pw6gOhWPJIPDCPQyYXjNMB/oYxyrFy/Vl7N+GEFEMotM0M6u5yg9HCfOErAQ=
X-Received: by 2002:a05:622a:5911:b0:4ee:1b0e:861d with SMTP id
 d75a77b69052e-4f1d04f8db9mr51964601cf.26.1765582668967; Fri, 12 Dec 2025
 15:37:48 -0800 (PST)
MIME-Version: 1.0
References: <20251212213843.24018-1-ovidiu.panait.rb@renesas.com>
In-Reply-To: <20251212213843.24018-1-ovidiu.panait.rb@renesas.com>
From: "Nobuhiro Iwamatsu (Toshiba)" <iwamatsu@gmail.com>
Date: Sat, 13 Dec 2025 08:37:37 +0900
X-Gm-Features: AQt7F2ojXidwVKMBfuL6UhIijsmw10ox8sD4nNCI42TM2Y5t-COo-5e55UuaSlg
Message-ID: <CACe6DC60jwpi9ec46qn-iBsyjM4Mf-bf6=_x70=JXRzYZvAmXg@mail.gmail.com>
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 0/4] Add RZ/V2N WDT support
To: ovidiu.panait.rb@renesas.com
Cc: cip-dev@lists.cip-project.org, pavel@denx.de, 
	nobuhiro.iwamatsu.x90@mail.toshiba
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Dec 2025 23:37:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21008

H all,

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
>   dt-bindings: watchdog: renesas,wdt: Document RZ/V2N (R9A09G056)
>     support
>   clk: renesas: r9a09g056: Add clock and reset entries for WDT
>     controllers
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

