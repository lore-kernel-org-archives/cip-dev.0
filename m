Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.220])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1577.1794242960059766296
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Nov 2026 08:49:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=HYF8xj8+;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=VT/cicDv;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.220, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1794242951; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=aNeIYUyMxZv9nIr7wjiyxdyjOun9FXJ97KXIjSYU/kDwmSGhRk7l9w5irvjlTYfqE5
    fdkWh6Qz+UO+Jozi+79/pFLAXgKFNMaHSBP56i+kSAcKE22+xx7+ZLl9VoIV4x5zWaoC
    OJbLFawKqXr6+zqc4SIMU/bVxtuELG2xtWyJusgf3m9GAPvQYS5ixWl9ZcOL4KnClpCT
    sXmG0ROEqTu6hOpcwFTtJsUs+XHE8bv0SmqRYn4Oh6d4S2TARCoFIJBSAYG9tMqPzKB9
    6Wi0ywpWLWaaKX8O0hj3WQA6xMy+W+aCnMcoM9yLsVQpXI1ldBYAgQDhfduXjiKsCmH0
    Cb/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794242951;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=Nzbz1Q1yjp6soUSG3/hVfgRo77bio1VGQxL5Nj9Oc9M=;
    b=VMUl7CFi6nAlWn57dDmGCs5YQv4MrIuiTulFAZirEvqPN/ERwIuqdnoIyiYcW5tEBx
    fA7WMhzViM1NaBKT2/juCK7E0kxPk/QeUkjPoAWAKT86IyL172a/RRmDILXdDHq4t5uH
    ubq6qz7F1Yu3miiquRtffD85AeXJNhPuKPWRJpmVFazrcK01xv4EQuKGtYcO3qy7diru
    3Rf1igmFhJRWmSwzs0Av8acXxK7sAj8/qEIoUEyLop5fg+oiidl8c/kQjHHlRuAhbHIg
    rbeiUcbWXjSrseYXQuGqJliTpqIRGc0ISKyv7fgVElXVEYNKiN2blDWU58YzFJQTiFTt
    o/qA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794242951;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=Nzbz1Q1yjp6soUSG3/hVfgRo77bio1VGQxL5Nj9Oc9M=;
    b=HYF8xj8+Nb1CZIpov0DnRd0LWhAvbbSKIyRWiL+vQ2Dgcs9zMHTJrb/i5qX3LUoY6t
    iiqdkhm3J3KOzhSp+vsz7pA/5RXjPGxHWMCBCrdmDOF0rsH5U1BLFzV2ZH/xlcs2MEh6
    NACOLhXRyR3Ip0BzLWH/B12sP9CDIw4NKcRskQrVWn6Q9jfRag/aE8qhLAEpIxgNxBYI
    nbop7l8+KDmxMJjuLlH0azbbE3G7ogYCl3IEtlcZrL6Xyi2YhhDfe8HLuF8ZaYN23lEZ
    YpoQoFgx5g+8ImYyRMEjp9AG5Ba5JUfOtxJAjTKzZHuDn7H1mKyfuI9wyqOnI97VHn34
    9uLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794242951;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=Nzbz1Q1yjp6soUSG3/hVfgRo77bio1VGQxL5Nj9Oc9M=;
    b=VT/cicDvczIQKXDnV/JU4GrxNnxtvbGlV+vz6tJstPGWpNpwPlVY3gXEHosoL8QBJf
    JgDrQ4M00fVyEexT78DA==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzotGZvghOuyX/LuaP4"
Received: from open-xchange-core-mw-gw-7.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 55.6.3 AUTH)
    with ESMTPSA id z81ed22A9GnAuCK
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 9 Nov 2026 17:49:10 +0100 (CET)
Date: Mon, 9 Nov 2026 17:49:10 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: pavel@nabladev.com, nobuhiro.iwamatsu.x90@mail.toshiba
Cc: prabhakar.mahadev-lad.rj@bp.renesas.com, cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com
Message-ID: <162120570.429393.1794242950306@webmail.strato.de>
In-Reply-To: <avGXuLpdFa9CzeeK@duo.ucw.cz>
References: <20261029121432.4909-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <TY7PR01MB148182531E8307BD3B1211C01CD732@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <avGXuLpdFa9CzeeK@duo.ucw.cz>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip] mmc: renesas_sdhi: abort tuning
 when timeout detected
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.46.154
X-Originating-Port: 39942
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 09 Nov 2026 16:49:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24729

Hi!

> On 11/09/2026 10:51 AM CET Pavel Machek via cip-dev <pavel=3Dnabladev.com=
@lists.cip-project.org> wrote:
> > > From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > >=20
> > > commit 2c9017d0b5d3fbf17e69577a42d9e610ca122810 upstream.
> > >=20
> > > We have to bring the eMMC from sending-data state back to transfer st=
ate once
> > > we detected a CRC error (timeout) during tuning. So, send a stop comm=
and via
> > > mmc_abort_tuning().
> > >=20
> > > Fixes: 4f11997773b6 ("mmc: tmio: Add tuning support") Reported-by Yos=
hihiro
> > > Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > > Reviewed-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatec=
h.se>
> > > Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > Link:
> > > https://lore.kernel.org/r/20210602073435.5955-1-wsa+renesas@sang-engi=
ne
> > > ering.com
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > [PL: manually applied the changes]
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com=
>
> >=20
> > I reviewed this series, looks good to me.
> >=20
> > Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
>=20
> Patch looks okay to me, too. Adding Ulrich to the cc.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>

Applied, thanks.

CU
Uli
