Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4534.1794431717416134344
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Nov 2026 13:15:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=fxz2TWZt;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3787B10E153;
	Wed, 11 Nov 2026 22:15:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1794431711;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=uILDpoWwUCOvxBFfpufR3Fw/8ZR6v/RqPjdo/7ZcHSw=;
	b=fxz2TWZts2MljdmsHp6KIJPalyNT+09hM/G+OUCPNyDVvSai3o67JUqUqaop5I+MDDR6gV
	lnIU1yaeHf94XjcRqZbFo+LWWacsmy8ayVjGTrvfJ+IuVh3kzX05Ma1JrBqzXadbR8WUnS
	e11hyKcOjMYDsqViCT+Owi8iHV/eRY6yW44ALpy6AUwfFl+ONm49ZWG+TlSMQxjxVQSGaq
	sb1fd0k2JTHNipN8wM2LbkjWceSq0tNvqCuXRvb1Yd0+tYjM1GFL3Y5S3fofmy4B1kCfYC
	N58UXl8jN2om0J16AyqlvE5tFTRZdCSw0OOngMigPmrlYUEMc4f8geFzsPGDvw==
Date: Wed, 11 Nov 2026 22:15:07 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: Re: Request for review for 4.19-st21, 4.19-cip137
Message-ID: <avTa2yGNm2t15IMc@duo.ucw.cz>
References: <1931298540.80350.1793132613065@webmail.strato.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5ZzBFcKrsgQPTeUs"
Content-Disposition: inline
In-Reply-To: <1931298540.80350.1793132613065@webmail.strato.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 11 Nov 2026 21:15:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24767


--5ZzBFcKrsgQPTeUs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Here are the adapted backports for the upcoming 4.19 kernel release. Ther=
e's a total of 95; 1 written by me, 2 by Qwen-3.8-27B and 92 by Qwen-3.8-Fl=
ash-Next. (The latter are labeled with "Assisted-by: SLTR:qwen-3.8" and "As=
sisted-by: SLTR:qwen-3.8-flash-next", respectively.)
>=20
> As always they can be found in https://git.kernel.org/pub/scm/linux/kerne=
l/git/cip/linux-cip.git/log/?h=3Dlinux-4.19.y-st-rc

I was able to review few more commits.

Reviewed-by: Pavel Machek <pavel@nabladev.com> .

Best regards,
								Pavel

a mostly theoretical, GFP_KERNEL allocations do not fail > d7b349ebdfdafc A=
SoC: meson: Keep link pointers valid on realloc failure
a just a config tweak > d38f463c73bccc tty: hvc: restrict HVC_DCC to ARMv6+=
 and ARM64
a > 1b1bd4efd7d8a1 iommu/amd: Prevent SB IOAPIC from overriding IVRS valida=
tion errors
a just a of refcount leak > 05c7c199894226 soc: samsung: exynos-pmu: fix of=
_node refcount leak in exynos_get_pmu_regmap()
a > 53a94e6cc49ffe mtd: rawnand: validate ONFI extended parameter page sect=
ions
a just a robustness > 303a77ac1be15b selinux: reject an unclaimed class val=
ue in security_get_classes()
a > 4fae216b4a1760 tcp: fix potential race in tcp_v6_syn_recv_sock()
a not quite trivial, just a interface fix > 393c2ca46a3b27 fsnotify: Fix st=
ale object mask after concurrent mark updates
a > aea3fa3f950c8c net: cap advertised IP tunnel headroom
a > ce12d5b2bdee84 net: openvswitch: fix flow mask use-after-free on flow d=
eletion
a > f139bc5bef5bc9 power: supply: max17040: synchronize work cancellation o=
n suspend
a > 7c74c8f9a71e98 sctp: fix stream->outcnt underflow on duplicate RECONF r=
esponses
a just a api change, may break someone's setup > 3a1fe75c4db943 mm/swap: re=
ject swapon() on filesystem-level encrypted files
a just a robustness > 4084800d553361 selinux: switch two allocations to use=
 kzalloc_objs()

--5ZzBFcKrsgQPTeUs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCavTa2wAKCRAw5/Bqldv6
8hnvAJ4hPdKBJECU0pSdEIwEJzhAPpGBgACdFZR6D6QnYDGRsxWEHj6oKfHpNIg=
=Eo47
-----END PGP SIGNATURE-----

--5ZzBFcKrsgQPTeUs--
