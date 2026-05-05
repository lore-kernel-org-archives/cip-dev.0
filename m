Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963A1FF8855
	for <webhook@archiver.kernel.org>; Tue,  5 May 2026 21:01:53 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4041.1778014910595557494
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 May 2026 14:01:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=iGcndbV/;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2892111529F;
	Tue,  5 May 2026 23:01:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1778014908;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=IaNVHnzozKkkkNMYuqFYKKJpRBnqgyfinIsogmC/S1A=;
	b=iGcndbV/sSrkZz7MiWGoUQjFxGKh+cSzncOfLhcoqW1XnzY8zKpnRacnpc3FdlCjOLC85b
	vSvJkeH/R9Z1aroqkgVUE20IOyJcCloTGP2TzwQllF2z5oYWJ2ZEMHutsUvHM4RUfAcSvx
	FzHZn0xG5JmGrvKh7eh8mncClo7KokT9g9JsFDOukFgTUVAAuVh37WPOubpcThBXztFK3l
	P1hWgoyAK5lhCBsJq/aMmU5QWt4f4Qx56eYxkG1oIN69dhRmYmBZnhoauBKP9Z0F3bpvgp
	xwqGkKBbesAlwAruf+Aj3OaShGxAXturQ2QKGa6MqwGwfOaILff7cDJjl0sT7A==
Date: Tue, 5 May 2026 23:01:43 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>, pavel@nabladev.com,
	Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, stable@vger.kernel.org,
	cip-dev@lists.cip-project.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [cip-dev] [PATCH for 5.10.y] phy: renesas: rcar-gen3-usb2: Fix
 the use of msleep during spinlock
Message-ID: <afpat8GZyp-AiD5W@duo.ucw.cz>
References: <20260501225859.504868-1-nobuhiro.iwamatsu.x90@mail.toshiba>
 <afhkX2Ys2BG1gnqy@duo.ucw.cz>
 <31002e6e-3983-4e30-aef6-bd2cd51aec40@tuxon.dev>
 <f81033c2-3432-4275-b5a7-78c61c31502a@tuxon.dev>
 <2026050519-stencil-sequester-187b@gregkh>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eIb4rNa8ZjposuqF"
Content-Disposition: inline
In-Reply-To: <2026050519-stencil-sequester-187b@gregkh>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 May 2026 21:01:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22890


--eIb4rNa8ZjposuqF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > > From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> > > > >=20
> > > > > This fixes an issue caused by the use of msleep during spinlock.
> > > > > In the original commit, msleep was changed to mdelay, but this fi=
x was not
> > > > > carried over during the backport to 5.10.y tree.
> > > >=20
> > > > Doing this as a quick fix is probably okay, but this should not be
> > > > final version.
> > > >=20
> > > > You are right that msleep inside spinlock will blow up immediately:
> > > >=20
> > > > > ```
> > > > > [=A0=A0 62.677594] BUG: scheduling while atomic: kworker/1:2/126/=
0x00000002
> > > > > [=A0=A0 62.683957] Modules linked in:
> > > >=20
> > > > But mdelay for 20 msec inside irqsave spinlock is borderline
> > > > unacceptable, too.
=2E..
> > > I'm going to investigate and come with a better approach for this.
> >=20
> > On a second thought, the proper fix would have to go to upstream first.=
 To
> > fix the problem currently seen, could we integrate this patch as is?
>=20
> No, please work upstream first.

Upstream has the mdelay:

drivers/phy/renesas/phy-rcar-gen3-usb2.c in rcar_gen3_init_otg() --
mdelay(20) and has the spinlock,

static int rcar_gen3_phy_usb2_init(struct phy *p)
{
	...
        guard(spinlock_irqsave)(&channel->lock);
	...
        /* Initialize otg part (only if we initialize a PHY with IRQs). */
        if (rphy->int_enable_bits)
                rcar_gen3_init_otg(channel);


So what Iwamatsu-san's patch matches upstream, and is good solution
for -stable for now. I have just pointed out, that, well, mdelay(20)
inside a spinlock is not great.

7.1-rc2: mdelay inside spinlock -- not great

5.10.250: msleep but no spinlock -- missing locking, bad!

5.10.254: msleep inside spinlock -- fails to boot, bad, bad, BAD! (and
also regression from 5.10.250).

Please allow Iwamatsu-san / Renesas to get this to 7.1 level of "not
great" situation; Claudiu will work with upstream to get 7.1 to "good"
situation, and then we can thing about backports.

Thanks and best regards,
								Pavel

--eIb4rNa8ZjposuqF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCafpatwAKCRAw5/Bqldv6
8jz8AKCSKiGPIsl8fY0EjwCocAs8f7Wi7ACgvr8PL6sfKxuitU1Ya834v1a5w6o=
=H3kf
-----END PGP SIGNATURE-----

--eIb4rNa8ZjposuqF--

