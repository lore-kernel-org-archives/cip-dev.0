Return-Path: <iwamatsu@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8709D1119B
	for <webhook@archiver.kernel.org>; Mon,  4 Nov 2024 01:47:39 +0000 (UTC)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
 by mx.groups.io with SMTP id smtpd.web10.48506.1730684857086846117
 for <cip-dev@lists.cip-project.org>;
 Sun, 03 Nov 2024 17:47:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=E+RZKJMl;
 spf=pass (domain: gmail.com, ip: 209.85.160.172, mailfrom: iwamatsu@gmail.com)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4608e389407so56797641cf.2
        for <cip-dev@lists.cip-project.org>; Sun, 03 Nov 2024 17:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730684856; x=1731289656; darn=lists.cip-project.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/aGYUsRwM/ABo5JA5oXToU2aNGBaZi+kn31G43UnGtc=;
        b=E+RZKJMlpRREEsW56HvNQTRGuRhGNAG/ogRNKxBaS8O9CJ4Pleqd71UVryDEzM5jUS
         YB2WgGACyFdHbSTx8iD9b+/5dOiNChIZ+A17DK3r+JjpnhaeoDO8fcHLVJ7FL4U7ckeq
         0dmYKROSAgAk+wXbzGKcU1/2XpXVIrS6IRNJehlbWsg+LLXICBl8aSjyUY8mp8/o+T+K
         V4umeeaaLYNKft3m9Mp8ojUt40X6KuUl923U6OLihrPJD1p7PDVISKfbW3zp8VTadwLh
         7tqhNoHpKhbD/2jJl99utT1OYyKY2cj1KWUvvFQphgHwCCOnPYymS36PUX22RK8LeNmz
         cqcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730684856; x=1731289656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/aGYUsRwM/ABo5JA5oXToU2aNGBaZi+kn31G43UnGtc=;
        b=jae8a5roypvbz0gSg3xKJE6cVtXHrZDSiHAu7DEW1GzRsv7ATAp3XMi1aqRHGFfBNq
         vzw05G3D6ud3+dISkLyuL8rbNrW52Ze7JUYI4OS5eGi1uDd17A/HmWQjN/8Wq6C7Tzkp
         3PvzEOJzFSPcfSKdHaNL7cVDn6TnO8eTDhz9L083Y6xZJ9o+XdAmFLK/IBvrJxQs2fM5
         myUO0qg32tGkcDvlgln7NVCyRn/33SPu7ubZYI6fbqvy8kO0IhZw7xghnX54zJm9Pder
         VtppYG+9FUyaJDc6JlvqU9hX8LF4/fbV2V6XQoHYZz5ub7LFXF8Z/2GRA5gc7FnqR2BT
         yOGQ==
X-Gm-Message-State: AOJu0YzAURYtE2nElo2nHxJcAorvylexnJ1E/qyljdQm5izBxOL/T0YD
	UGlSwf5mUeDQvDICP3DyP1Y52TwdAbd9hBib8E0Z7yXf2IPeHGdmLEbQf8YfKu6NjYbysMEylTs
	UJP93TZgyOQ3NljURSLx1E5dPY5bhPw==
X-Google-Smtp-Source: AGHT+IEJfuocM0RT4+NoYG9kfO0zw44d16cGsiliwK+D7j0VzoO8fRGitiY9ty+Mrxh2T3MY96DK/21jlytrIweFpAk=
X-Received: by 2002:a05:622a:1b88:b0:460:5527:63dc with SMTP id
 d75a77b69052e-4613c16aa09mr511064321cf.40.1730684855719; Sun, 03 Nov 2024
 17:47:35 -0800 (PST)
MIME-Version: 1.0
References: <20241101141538.34849-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20241101141538.34849-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Nobuhiro Iwamatsu <iwamatsu@gmail.com>
Date: Mon, 4 Nov 2024 10:47:24 +0900
Message-ID: <CACe6DC4g=YwAi9OK3Z0DMQ4HfYQ3+j7dB9BvQMzULmB19P3qtg@mail.gmail.com>
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 0/2] media: platform: rzg2l-cru:
 Trivial code cleanup
To: cip-dev@lists.cip-project.org
Cc: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Pavel Machek <pavel@denx.de>, 
	Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Nov 2024 01:47:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17167

Hi,

2024=E5=B9=B411=E6=9C=881=E6=97=A5(=E9=87=91) 23:15 Lad Prabhakar via lists=
.cip-project.org
<prabhakar.mahadev-lad.rj=3Dbp.renesas.com@lists.cip-project.org>:
>
> Hi All,
>
> This patch series aims to fix trivial code changes to RZ/G2L CRU driver.
>
> Cheers,
> Prabhakar
>
> Lad Prabhakar (1):
>   media: platform: rzg2l-cru: rzg2l-csi2: Enclose the macro in
>     parentheses
>
> Yang Li (1):
>   media: rzg2l-cru: Remove unneeded semicolon
>
>  drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c  | 10 +++++-----
>  drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c |  2 +-
>  2 files changed, 6 insertions(+), 6 deletions(-)
>

I revewed this series,  looks good to me.
Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>


--
Nobuhiro Iwamatsu

