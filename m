Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962BDC55162
	for <webhook@archiver.kernel.org>; Thu, 30 Jul 2026 21:45:12 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.341.1785447904467568915
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Jul 2026 14:45:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=eYbafrTH;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C0BE111B91F;
	Thu, 30 Jul 2026 23:44:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1785447897;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Y7+4jdhcGYHvNePdCyfU46S6Zli+dETkUMos3yDcsJY=;
	b=eYbafrTHGulPwhPY7XSdheaKRKkrCAq+zkUpyRiu9GdlJujxrUOg9VFXxPJU0LD2LoOpWN
	m3Jo0EdJYXggPzi/WpX55Y/JD4JDALoSf3FQWp8KuOi5DAnCa7QyugG8EuIU/WCpRuFXTq
	taXGaAE1YQx3D2xitoFRnWdw42oM9QbsB565y3YaDQvLIXQXvP4AK+wMQ7wHcxrCWEuoUq
	XkD6165lITiYrRGYNFf6AHZT0U3Y2FazYSSdKNUL/ov2mausGut4ur4SLL6TBnLt+5qhiu
	3HX/ujDX2Mrl4aVrYOEnaiaDG3FkUmr/PGdq/5uKcq1iVb3lZT9vkZxch5+DdA==
Date: Thu, 30 Jul 2026 23:44:54 +0200
From: Pavel Machek <pavel@nabladev.com>
To: pavel@nabladev.com
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Ulrich Hecht <uli@fpond.eu>,
	Masami Ichikawa <masami.ichikawa@miraclelinux.com>,
	cip-dev <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] CVE-2026-64560
Message-ID: <amvF1nVER--og1Wz@duo.ucw.cz>
References: <4d61ec83-bb55-4c27-b370-0e2ed60bd800@siemens.com>
 <18C72D766E036C67.1779571@lists.cip-project.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vmWVJi+5d1RZ5heS"
Content-Disposition: inline
In-Reply-To: <18C72D766E036C67.1779571@lists.cip-project.org>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Jul 2026 21:45:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23822


--vmWVJi+5d1RZ5heS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > this looks like it does not need special drivers and is not that easy
> > to mitigate (CONFIG_POSIX_TIMERS=3Dn...):
> >=20
> > https://git.kernel.org/pub/scm/linux/security/vulns.git/commit/?id=3D08=
1d2ff9592751aa400828237f17c108e4e1f513
> >=20
> > Early releases?
>=20
> No cool name, no logo, and no website? Aint doing no release for that!
>=20
> So... this is crasher, and you need local access for it. In my eyes,
> it is below "Dirty Cow" in severity.

So .. apparently Sasha or his robots believe this may be exploitable:

I:H -`collect_timerqueue()` writes into freed memory
    (`ctmr->firing`, `ctmr->handling`, rbtree rebalancing, list
    insertion) and the `do_cpu_nanosleep()` variant does so into a
    live, attacker-groomed kernel stack frame, followed by
    `cpu_timer_fire()` dereferencing attacker-controlled
    `it_process`/`it_signal` =E2=80=94 a control-flow-hijack-capable write
    primitive.

So far, I don't see distributions acting the way they did on "Dirty
Cow":

https://security-tracker.debian.org/tracker/CVE-2026-64560

(Note the auto-generated, useless description).

So the other two one-patch releases are. Not good, but not "Dirty Cow"
level of dangerous, either, AFAICT.

    Linux 6.12.99
commit 41fb1f3c8a712eba4b1eae0a9023e80007a71413
Author: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date:   Tue Sep 24 21:10:23 2024 +0100

    mm: refactor mm_access() to not return NULL
   =20
    [ Upstream commit cd3f8467afd470ccab0de2fbc7c76664af4a0bac ]
   =20
    mm_access() can return NULL if the mm is not found, but this is handled
    the same as an error in all callers, with some translating this into an
    -ESRCH error.
=2E...
    Linux 6.12.98
commit 913e7b4459d6eef807bb8088b39b890ed6a74ee3
Author: Yun Zhou <yun.zhou@windriver.com>
Date:   Sat Jul 25 10:40:29 2026 +0800

    ext4: fix fd leak in EXT4_IOC_MOVE_EXT cross-sb validation
   =20
    The backport of upstream commit c143957520c6 ("ext4: validate donor
    file superblock early in EXT4_IOC_MOVE_EXT") uses a bare 'return -EXDEV'
    which is safe upstream because the fd is managed via CLASS(fd) with
    automatic cleanup (commit 8152f8201088 ("fdget(), more trivial
    conversions")).
   =20
    However, on 6.12.y the ioctl still uses the traditional fdget/fdput
    pattern, so the bare return bypasses fdput(donor) at the mext_out label,
    leaking the file reference.

Best regards,
									Pavel
--vmWVJi+5d1RZ5heS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCamvF1gAKCRAw5/Bqldv6
8rIrAKCjhyg+obrRK4oy3O0wGHG1mrMRvwCgw4olikTMmKxLp8qgALVDCNKzN20=
=hFjv
-----END PGP SIGNATURE-----

--vmWVJi+5d1RZ5heS--

