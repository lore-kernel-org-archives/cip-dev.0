Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FDDC02198
	for <webhook@archiver.kernel.org>; Sat,  8 Feb 2025 18:37:04 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.15090.1739039817058383953
 for <cip-dev@lists.cip-project.org>;
 Sat, 08 Feb 2025 10:36:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=UZHHOay9;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 632121047DC14;
	Sat,  8 Feb 2025 19:36:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1739039814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rrkQ3D0e648sAU/0AdmuSKPGqqmuyhGVZ+VVoGxNZvc=;
	b=UZHHOay92kVfoYyUTvFkKRefyl0wKaq2bims/A+Ah2lhCxoho03CN7/JheQxkTvxxY4Iyt
	y3EqxwLRAfbEF2JaZ2ynRqjUeR5mUzpubsdQcamyoo2RqlNl/JQfKQC8iZz2RUgOugwZH/
	m6viMzyelDjqYnsoe+cC0kVKOL+YZF/ITFx55e1Biqrdl9DoQ477UJC9AOzbYRYkwJ9Hkl
	mG4ODnS5NG2vZZ96QNELerKCmungkWdVps8oroSopmkYrcL6k9yuJ6IR1SLXdFohBJyjJh
	BUs0C+FBXBMlJAAR+bAHIJ6OflKP37RmOohXepfW14jzdfKwT5f78JEGsEM3EQ==
Date: Sat, 8 Feb 2025 19:36:49 +0100
From: Pavel Machek <pavel@denx.de>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: Request for reviews for 4.19-st1, 4.19-cip117
Message-ID: <Z6ekQYeCM1sVg3Zu@duo.ucw.cz>
References: <1939235882.106210.1738897032804@webmail.strato.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="POye8yMdTW/Eo+4h"
Content-Disposition: inline
In-Reply-To: <1939235882.106210.1738897032804@webmail.strato.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 08 Feb 2025 18:37:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17777


--POye8yMdTW/Eo+4h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Here's the manual backports for the first self-maintained 4.19 kernel rel=
ease. They can be found in https://git.kernel.org/pub/scm/linux/kernel/git/=
cip/linux-cip.git/log/?h=3Dlinux-4.19.y-st-rc
>=20

a > 17758948061a2 RDMA/bnxt_re: Fix max_qp_wrs reported
a > 60f86dfde2f27 net/sched: netem: account for backlog updates from child =
qdisc
a > e3f9d1479533a net/sched: cbs: Fix integer overflow in cbs_set_port_rate=
()
a > 60a6e1e938430 netfilter: nft_set_hash: skip duplicated elements pending=
 gc run
a > db3db8b23fc26 drm/etnaviv: flush shader L1 cache after user commandstre=
am
a not a minimum fix, that driver is ....  > a31241e036c2e usb: yurex:
make waiting on yurex_write interruptible

The yurex patch is two changes in one and that driver is not up to
usual standards, but the patch should be okay.

a > b1463eec3417a perf trace: Avoid garbage when not printing a syscall's a=
rguments
a > 49d9f78101f9b scsi: qedf: Fix a possible memory leak in qedf_alloc_and_=
init_sb()
a > 86a1a175bdd56 mfd: intel_soc_pmic_bxtwc: Use IRQ domain for TMU device
a > 65f2a31dfeec1 ALSA: hda/realtek: Set PCBeep to default value for ALC274

Ok, so this solves pop in speakers. Well, I guess we can take it,
but... one day I'd really like to see stable kernel rules to be
updated to match the reality.

Thanks for patches. They look good to me.

Best regards,
									Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--POye8yMdTW/Eo+4h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ6ekQQAKCRAw5/Bqldv6
8tEiAJ935tqUQ58b1b9khbd+SytYzZm9NwCeNP3wM5gde2EWorogB63NqRqdFw0=
=0SYe
-----END PGP SIGNATURE-----

--POye8yMdTW/Eo+4h--

