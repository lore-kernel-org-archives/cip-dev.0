Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2238CC433EF
	for <webhook@archiver.kernel.org>; Thu, 23 Dec 2021 17:11:42 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.35525.1640279500011940477
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Dec 2021 09:11:41 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 01AA21C0B7F; Thu, 23 Dec 2021 18:11:35 +0100 (CET)
Date: Thu, 23 Dec 2021 18:11:34 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] New CVE entries in this week
Message-ID: <20211223171134.GA22980@duo.ucw.cz>
References: 
 <CAODzB9o_D8pjO0Y5r=Nv1+TyHcfjjPAKM-Vsjuo8QKEVzDXT0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: 
 <CAODzB9o_D8pjO0Y5r=Nv1+TyHcfjjPAKM-Vsjuo8QKEVzDXT0A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Dec 2021 17:11:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7262


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> CVE-2021-45095: phonet: refcount leak in pep_sock_accep
>=20
> CVSS v3 score is not provided
>=20
> This issue is a refcount leak in pep_sock_accep(). It's been fixed in
> the mainline.
>=20
> Fixed status
>=20
> mainline: [bcd0f93353326954817a4f9fa55ec57fb38acbb0]

This is Nokia modem stuff. It is enabled in several of our configs,
but I don't think anyone is really using it.

> CVE-2021-4149: Improper lock operation in btrfs
>=20
> CVSS v3 score is not provided
>=20
> There is a deadlock problem in fs/btrfs/extent-tree.c. This problem
> causes a local attacker can do a DoS attack to the system.
> The patch specifies the vulnerable kernel version is 5.4 or later.
> stable/4.4, stable/4.9, and buf value is not locked in
> btrfs_init_new_buffer(). However, stable/4.19 takes a lock in
> btrfs_init_new_buffer()
> (https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/fs=
/btrfs/extent-tree.c?h=3Dlinux-4.19.y#n8145)
> so it seems 4.19 has same issue.

> Fixed status
>=20
> mainline: [19ea40dddf1833db868533958ca066f368862211]
> stable/5.10: [206868a5b6c14adc4098dd3210a2f7510d97a670]
> stable/5.4: [005a07c9acd6cf8a40555884f0650dfd4ec23fbe]

This may be worth looking into.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYcStxgAKCRAw5/Bqldv6
8r5QAJ4+7tQzm1Q/9dPrkGsJtlmJKxFjvwCeOQoM0/uvIAavQppRl9lDcdgOqLY=
=6TTC
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--

