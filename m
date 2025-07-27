Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1150C87FCE
	for <webhook@archiver.kernel.org>; Sun, 27 Jul 2025 18:23:01 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.65160.1753640576253831578
 for <cip-dev@lists.cip-project.org>;
 Sun, 27 Jul 2025 11:22:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=LUjpbsS/;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B35AB1038C126;
	Sun, 27 Jul 2025 20:22:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1753640574; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=x49n7VMFQfjs7vXKyW095GKTGeX9GjdiSRNwVXn2x0M=;
	b=LUjpbsS/2Z4Cv/n12gvfCQlCpF2XP9Wbflk+QXREQoy2o44Ri1hSOF0iimoZ7jgje2DH/q
	0wg6kiQdtqgBDklU7zsZldoJ9ABlNtFC5oQNyAiHyFLS3n/JdKRLTd5c7FJ3jj4UULSZtc
	KWBwBt8KfFWlJDNXCnzkc8IsM9AzBW670E1wfFKQEaGj5WL3hl6RlNnd1d68PMa8XDI9nM
	nFP9AhSeqoX/WsHWarSBnHkiA1WSMfr18B5sEV7QPxqtOXZIGP2+op5R6CXspRPMJaY5iB
	E5Z3PZgcXE92Tj1v+Hh2eCwB8nuFAZ517JBKDipkn2JatpKZapXUTC1ewgO95A==
Date: Sun, 27 Jul 2025 20:22:47 +0200
From: Pavel Machek <pavel@denx.de>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: Request for review for 4.4-st66, 4.4-cip101
Message-ID: <aIZud744QJhijzln@duo.ucw.cz>
References: <158891858.150095.1753458928281@webmail.strato.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QuDyjQqn3XIGY7S0"
Content-Disposition: inline
In-Reply-To: <158891858.150095.1753458928281@webmail.strato.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 27 Jul 2025 18:23:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19597


--QuDyjQqn3XIGY7S0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2025-07-25 17:55:28, Ulrich Hecht wrote:
> Hi!
>=20
> Here are the manual backports for the upcoming 4.4 kernel
release. As always they can be found in
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-4.4.y-st-rc

Most patches look ok to me.

a just a _ONCE annotation > a2f74f85cb66d vxlan: Annotate FDB data races
a > f158152d3d705 hwmon: (gpio-fan) Add missing mutex locks
a > 8c643c0ff20e7 platform/x86: dell_rbu: Stop overwriting data buffer
a > 495e3a4a467f4 net: dlink: add synchronization for stats update
a > 4ed3668110bcc wifi: p54: prevent buffer-overflow in p54_rx_eeprom_readb=
ack()
a > c6eb7a3b1735c net/mlx4_en: Prevent potential integer overflow calculati=
ng Hz
a > 9d5e1398442b0 nilfs2: do not propagate ENOENT error from nilfs_btree_pr=
opagate()
!! > 47ba411d24712 can: bcm: add locking for bcm_op runtime updates

Dunno. Code is quite different in 4.4, in particular it misses
"op->flags =3D msg_head->flags". As this is quite complex and not
tested, I'd be inclined to drop it.

a > 945b6360fe7eb x86/nmi: Add an emergency handler in nmi_desc & use it in=
 nmi_shootdown_cpus()
!! > 1e212aea72d77 rtc: ds1307: stop disabling alarms on probe

This is behaviour change. Someone could be relying on the old
one. OTOH, -stable is taking it...

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--QuDyjQqn3XIGY7S0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaIZudwAKCRAw5/Bqldv6
8h51AJ9Np+ok3yIF/yZUGwXqIUos9RChNgCgsjpcpA/ovBly+vheA9d/CsRBFos=
=R6GR
-----END PGP SIGNATURE-----

--QuDyjQqn3XIGY7S0--

