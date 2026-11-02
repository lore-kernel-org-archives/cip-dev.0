Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10731.1793619388044583055
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Nov 2026 03:36:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=iTyplz+X;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7DAFC105C9B;
	Mon, 02 Nov 2026 12:36:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1793619381;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=AvJ8Qse3MwICuxagsv3z9G9u1Be3Oi+6oefMoBNpht8=;
	b=iTyplz+XYwipJWEfbTo6ftLyTtKHEaVujzeT53X2w+c+CrninUM3kBHSs3U9+ezVDTNHql
	ZmXN9Zk55A7FzlHWzkJd/EGMMp5JENviQ+ymKD+W4Jr148pCCvPcreNvxYkEyVJy4MojOF
	69j1ZWayypB0lYUCHBwYEGPuL+/v7U7w9x8+pfG78RMNWrLdFsQHO8A/hNGzLwoe5wKhTA
	t0nBfcl6e5HI+d5cKu17BEYiYnxwHaWcuOznQVaTNHws6iWGDGTJYd/yzULM7lcm08KcQA
	YLw4sPc9pZxU7ioq1oB/Svzy1ZfSWjrHOa2gk1MkU0+Qr7Zd4iofpZWWRonUzQ==
Date: Mon, 2 Nov 2026 12:36:17 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: Re: Request for review for 4.19-st21, 4.19-cip137
Message-ID: <auh1sRkdmg3AWRbt@duo.ucw.cz>
References: <1931298540.80350.1793132613065@webmail.strato.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rXpsXlEtOX4PakcE"
Content-Disposition: inline
In-Reply-To: <1931298540.80350.1793132613065@webmail.strato.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 02 Nov 2026 11:36:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24601


--rXpsXlEtOX4PakcE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

>=20
> Here are the adapted backports for the upcoming 4.19 kernel release. Ther=
e's a total of 95; 1 written by me, 2 by Qwen-3.8-27B and 92 by Qwen-3.8-Fl=
ash-Next. (The latter are labeled with "Assisted-by: SLTR:qwen-3.8" and "As=
sisted-by: SLTR:qwen-3.8-flash-next", respectively.)
>=20
> As always they can be found in https://git.kernel.org/pub/scm/linux/kerne=
l/git/cip/linux-cip.git/log/?h=3Dlinux-4.19.y-st-rc
>

These look ok to me:

Reviewed-by: Pavel Machek <pavel@nabladev.com>

a this is not easy to validate > 0f9dd2fd36dc88 ipv4: validate checksum_sta=
rt before completing checksum
a > 1aef1ed67bf592 netfilter: ip6t_rt: fix zero-address non-strict match ou=
t-of-bounds read
a > 1772d2f27fe10f net: openvswitch: conntrack: avoid modifying shared unco=
nfirmed ct entry
a > 994be280b21cd2 net/sched: reject IDR error pointers when deleting actio=
ns
a > 2548133fd1bde9 drm/nouveau: Fix gem reference leak in validate_init()
a > 893066ca3560ef drm/nouveau: fix double-free in nvif_vmm_dtor
> a91fd56ecf47a4 gpio: zynq: fix runtime PM leak on request error path

So this is common pattern and quite a common mistake. As it only
happens in error paths, we may want to simply ignore this one.

If we wanted this fixed, we should probably introduce
pm_runtime_resume_and_get(). We already have two users of the
non-existing function in the tree, so two compile errors waiting to happen.

drivers/irqchip/irq-gic-pm.c:   ret =3D pm_runtime_resume_and_get(dev);
sound/ac97/bus.c:       ret =3D pm_runtime_resume_and_get(dev);

Best regards,
								Pavel
--rXpsXlEtOX4PakcE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCauh1sQAKCRAw5/Bqldv6
8oafAKCDnIQJ81vV5vB5P0SWTScQfEffewCgguqOJX/zUkgnnne9OmXPsLKUME4=
=cto6
-----END PGP SIGNATURE-----

--rXpsXlEtOX4PakcE--
