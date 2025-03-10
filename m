Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E2BC28B30
	for <webhook@archiver.kernel.org>; Mon, 10 Mar 2025 21:07:29 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.49697.1741640839678913283
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Mar 2025 14:07:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=YpPF8kgD;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D92C7103BB5FA;
	Mon, 10 Mar 2025 22:07:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1741640837; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=5BUG4ktEEEk6DqlAFGR5dkrXbLLR+9EOfMYVZU1drBI=;
	b=YpPF8kgDKO5IR23XsL/Mkm74C1dapIKmMpnMNB5X2UO+0Ib8ouNptuxLr4FwfvsXPpA8eQ
	AntW98/4dHuLNkKnL5Xh9MyB2ttVEl8F9LOklaBo1RM6ytQn5RumQGVs22EqcD0Xfwc4Yg
	Mp3VyH9I1Y9ytuib1/2gReFJ1NYR6PcLcXsqHstY/Mr7JNBRoCvtBExmK8iIHYE3gB9nkR
	BlFm6GDQlgngITVNexVTe2Wh02REb5Vx6l0vJ+HI4/q2sRZ8hINiaCDkh0k2MtsP0hC8wn
	YgY5Onrse8WXiXb0gpoF55X0DD2PsH0QmUeb+K3BqxC8l11HRMkx8PtbkLMgBQ==
Date: Mon, 10 Mar 2025 22:07:12 +0100
From: Pavel Machek <pavel@denx.de>
To: uli@fpond.eu, cip-dev@lists.cip-project.org
Subject: Re: Request for reviews for 4.19-st2, 4.19-cip118
Message-ID: <Z89UgDQCP7ULJWjU@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wuQ0IGNxqx48laJF"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Mar 2025 21:07:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18079


--wuQ0IGNxqx48laJF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

(sorry for not having right in-reply-to header)

> Here's the manual backports for the upcoming 4.19 kernel release. They ca=
n be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip=
=2Egit/log/?h=3Dlinux-4.19.y-st-rc
>=20
> These are from 5.4.290:
>=20
a > 44f5f1d143972 net/xen-netback: prevent UAF in xenvif_flush_hash()
a > 798365a11b40a arm64: dts: rockchip: add hevc power domain clock to rk33=
28
a > 52b217274553c gtp: Use for_each_netdev_rcu() in gtp_genl_dump_pdp().
>

These look ok to me

> There is also a fixup for a mistake I introduced in one of the backports =
in the previous release:
>=20
a > d25f30bb83927 net/sched: netem: fix backport of "account for backlog up=
dates from child qdisc"

And this one is good, too. The ones from 5.4.291-rc1 look a bit
trickier, so I'll do that in separate email.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--wuQ0IGNxqx48laJF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ89UgAAKCRAw5/Bqldv6
8uEuAJ90Et8Uue1lq2K47sx+NH5puyWZngCfX+7OA6M1wnq9/BtfvJP19MnGMyE=
=/f5R
-----END PGP SIGNATURE-----

--wuQ0IGNxqx48laJF--

