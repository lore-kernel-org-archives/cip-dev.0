Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DBAC43458
	for <webhook@archiver.kernel.org>; Tue, 14 Jul 2026 06:30:43 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4237.1784010641237983355
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Jul 2026 23:30:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=tAY4hTXw;
 spf=pass (domain: gmail.com, ip: 209.85.208.52, mailfrom: biju.das.au@gmail.com)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-698acd36d67so7109626a12.0
        for <cip-dev@lists.cip-project.org>; Mon, 13 Jul 2026 23:30:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784010639; cv=none;
        d=google.com; s=arc-20260327;
        b=lJN95emh/KV5qNrsN1SPqG194ospamiUcCvxLNcgyT3HgyfxTyMrgk3GN4NxUf8ut/
         g9zz5nLYa91xe0QZDj0dHP+HLzG+jRcLFWwbeyScKzjmeE8Zs7qE235YSvPGs4ErG9CL
         CCdbGBn2BS0h2C3wTJF0T0a0K/wtOgotWItg/KirG5oDHjEJZHwY4fABwt+V9dCXEmop
         Sl1pHoVXrGSh8kpjyfjv8sav+/mrZIKE+yyJgIY/ZEEhoKVktn3dZoAUPcUdnQeeVtIf
         X41bj2LysmN3ZmGA8ci7x2upUTN9QAdiJJ5IaTvm4Dslo5x71RZEfgese0KjmS+vu2VD
         fjkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jtOcnDixN/J2/eXjfZKRsObERL1H0U3NZyBz62o7EsU=;
        fh=lnPOspbD5jMQpDU5y2w0bkUVx0WTJwuLRX5O9+gXx1Y=;
        b=Y70UrAzFlXafmI3bHac1d+mtn1QAfizwDbYMVt4P92lNumr0tv4p/+DXHKEUY8mh3D
         Ng8a3nG/OQaJb2NpeTF3nI70YeF0+aLbhz5mFjZ7x2fufBemymZUjLMgufRkkPMgPEdQ
         j1/Yhdq0q7dF8HCy60cKrSCi7QrF1PuG4c1P9g3TxoiMmoi71zLMZ7FHFrWCNiKMpasm
         dFV6z/LLmLjz8H5fWQGpvDncr6EmKFriN4/c5BFv/LvtGaT+L7Prwfyh8TXkh9K9bDqT
         98r20FinUQ/sO0E0OZpT2+svVT93sssF4+cDD2FydFwsMwh7k5QQj2B56hsmUs3+B+nN
         cqOw==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784010639; x=1784615439; darn=lists.cip-project.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jtOcnDixN/J2/eXjfZKRsObERL1H0U3NZyBz62o7EsU=;
        b=tAY4hTXwL+ngWCUVWAHiMZs6MH10sEFDC/1DpC67jrvABXYh8s6GqJJoW4FtivWq6h
         O54obniToaNT0crwX+9dphFPkIdrgTlQP/n16gplLQOj9Qe65WHF6IvXm4zvCwOj3IhC
         wo6Z6JOsTGcl4ZkQSWRWa8OqPILEjsej8FNLrP7StUOrLrOKEoxDxDRaC3GNK3sbgffg
         SIe/PSbIDvo0ffqiaiY/5xnbViThoO9z6p3eiIXs+lHiIqZbICuBHyuqN/8cE8C7JssB
         CSFjnyPLQef1URZg0EYUibbS5Cp1e8bHxSQfIqvV52uVej8GsJoOK84UE7kZxmLFBJ3Y
         B2XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784010639; x=1784615439;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jtOcnDixN/J2/eXjfZKRsObERL1H0U3NZyBz62o7EsU=;
        b=LPwh3INGYfgKivXIA/nVBYsVkDbf00u/aCGgumZQYW5K9EpC6H21XVh+lEmOR2cgGg
         G6q3NjKr2yXgfo0sT81KeTDpOEC3HfoxQd3VkfRg87MKZCek7x9POytkwXhFHRvggwzW
         vRb3vxGlB6wYTayGfGBEBymRi5pEagMcNyct5oC6UqAcO1O+KnFrcEzVleYw6d59WIvI
         M5l/M7P/DTT15Lr/wXr5Xtj9ZIkJPtq1+eEc+9H6ld19XPvzJTOQvup5vPamJMOu6s+7
         XUutXQzRiqHyzsN92wPaUWLHk25vTpumkAaMMfq9ju5jsZz3RY+6rMNx35nVhRFllFNA
         +D/w==
X-Gm-Message-State: AOJu0YzlnTTNTwm9tWwE5tU4axJ+h8jdw3obEEtywzRx/WS3hib/JPZk
	7hrJLOrUg+mqrx07CApW+xgy6F1gqHHoY/xeJnN/bq6mtrM8aJy7iLSAS/ldeKISUYyJAw78jwW
	fL7D3RlFn6VsakLSLQcZyo9DP1dpdrUg=
X-Gm-Gg: AfdE7cmzq7j0YBdPHzn3NCugPsFCdo8Pn8leVR0ujQAC0fXMjzPGZ0DyWJGoWPIGp83
	2BtmSM1Qpi3TYitz8QY5Klzyn58t1y4ek7oI57UdZ+cF6VM5c/y5lFXiFo+oJYefFa7Ez+xXz0l
	kW1QJQieQIZZDyoOsBO8iPuJhDHGwVpoCquOOOazagb4nrtKS25z+OilG/1nMMcRK9LjvBdwkK+
	ZfLvF2sI9Uu6BerEqhRuVpSo3sOD1JjRK06yn22mV9aqXSycQjRdF5ZEkr3O9C4jgefBJ+oSu6K
	4wvsI3aaHQ==
X-Received: by 2002:a05:6402:548b:b0:69a:a827:7477 with SMTP id
 4fb4d7f45d1cf-69cd2b81f07mr961348a12.39.1784010639249; Mon, 13 Jul 2026
 23:30:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260713120354.29288-1-biju.das.jz@bp.renesas.com> <alVT-m89Z6_dQcF4@duo.ucw.cz>
In-Reply-To: <alVT-m89Z6_dQcF4@duo.ucw.cz>
From: Biju Das <biju.das.au@gmail.com>
Date: Tue, 14 Jul 2026 07:30:27 +0100
X-Gm-Features: AUfX_mwqZ6lnUD2I8AzGBYVc-tyUZC4wJZYHhXWcRA-L51hxDxkTVF5AP974k90
Message-ID: <CADT+UeC0nu5trmwT7A-w6i99TRKV3q2+g702zCw0GOaZ5qA2hg@mail.gmail.com>
Subject: Re: [PATCH 5.10.y-cip 0/4] arm64: dts: renesas: Add max-frequency to
 SDHI nodes
To: Pavel Machek <pavel@nabladev.com>
Cc: cip-dev@lists.cip-project.org, 
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 14 Jul 2026 06:30:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23571

Hi Pavel,

Thanks for the  feedback.

On Mon, Jul 13, 2026 at 10:09=E2=80=AFPM Pavel Machek <pavel@nabladev.com> =
wrote:
>
> Hi!
>
> > This patch series aims to add the max-frequency property set to
> > 133333333 Hz (133.33 MHz) to both SDHI0 and SDHI1 MMC controller nodes =
in
> > the RZ/G2{L,LC,UL}/RZ/V2L device tree.
> >
> > This change results in approximately 33% performance improvement as
> > it sets the SD clk to 100 MHz instead of the max 133 MHz.
> >
> > All the patches in this series are cherry-picked from mainline.
>
> Ok, so as I understand it, we don't need this for 6.1-cip and others,
> because it is already in mainline 6.1, so no backport is needed.

We recently (7.2-rc1) upstreamed this patch.

Yesterday, a job in Lava setup showed the problem in 5.10-y cip. So,
just to fix that issue, I sent these patches
Soon I will be sending patches for  6.1 and 6.12-cip.

Cheers,
Biju

