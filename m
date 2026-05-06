Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850A5CD342C
	for <webhook@archiver.kernel.org>; Wed,  6 May 2026 19:25:07 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.27125.1778095497281397021
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 May 2026 12:24:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=NXHW4a4b;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C603E10C21F;
	Wed,  6 May 2026 21:24:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1778095494;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=eUlcEvePljHwJaC05/4fa3Pkpp6rA5FqSaf6LvqxAUs=;
	b=NXHW4a4bxiTA/DvqjFv0vWjm16DU2vIbxl1pBZ60pj5FlxWIqB2Ofhy1YpZOn527B6QSrw
	vP2QQ4F2or/77BKYuklwsH3EWiqb3kDLIuC0/G/gCpQagFNtGethvIkMmW22ptqWle27wf
	y/Z7LznDz5tQYkLRn9vBYCvxwiYI8NcA+TttAv/DrjJjD2IjvUpyzYVm9T10KtV7s/J9FP
	bzOfv0R9jODqdTJEQ3gLZvYu7zahAPfvojEX1UB/yoaZV6v2Rsw/dH2pB1N6cjXzqT8gQh
	P7RCZrmD8RYgXj1lNpIrCFg0GsGlVDJM4AQIpWg18QM/poyedb/VAMSuuKPvkg==
Date: Wed, 6 May 2026 21:24:50 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: Re: Request for review for 4.19-st16, 4.19-cip132
Message-ID: <afuVgh5KX9J4UrcZ@duo.ucw.cz>
References: <483138290.348854.1777919283323@webmail.strato.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IuR8Jb9B3FhKDNx2"
Content-Disposition: inline
In-Reply-To: <483138290.348854.1777919283323@webmail.strato.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 May 2026 19:25:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22894


--IuR8Jb9B3FhKDNx2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Here are the manual backports for the upcoming 4.19 kernel release. As al=
ways they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/c=
ip/linux-cip.git/log/?h=3Dlinux-4.19.y-st-rc
>=20
!a just a hw bug workaround. sure? > c2d401e101f6f x86/CPU: Fix FPDSS on Ze=
n1

AFAICT mainline triggers on zen1, while this triggers on family =3D=3D
0x17, which may be different. Hmm. Your backport is same as -stable,
so maybe that's ok?

a > f6b624b78e703 seg6: separate dst_cache for input and output paths in se=
g6 lwtunnel
a > 5e61028ae2137 netfilter: nft_ct: fix use-after-free in timeout object d=
estroy
a > f7c9c8b6a3c7e apparmor: fix differential encoding verification
a > 48287285f14b5 apparmor: fix missing bounds check on DEFAULT table in ve=
rify_dfa()
a > 91c9727179f31 ext4: convert inline data to extents when truncate exceed=
s inline size
a > ffa20b32fd35c virtio_net: Fix UAF on dst_ops when IFF_XMIT_DST_RELEASE =
is cleared and napi_tx is false
a > 2ae9ce04a67ad ipv6: fix NULL pointer deref in ip6_rt_get_dev_rcu()
a > 29acc58f3339c crypto: authenc - use memcpy_sglist() instead of null skc=
ipher
a > 65888314e8d59 crypto: algif_aead - use memcpy_sglist() instead of null =
skcipher
a > 1ace4d448870d crypto: doc - fix kernel-doc notation in chacha.c and af_=
alg.c
a > 5b3a91c42591d xen/privcmd: fix double free via VMA splitting

You normally put [uli: backport to 4.19], Signed-off-by: Ulrich Hecht
<uli@kernel.org> headers, but I don't see one here.

> Most copy-fail-related patches did not require a manual backport from 5.1=
0, but in case somebody wants to give them a quick look anyway:
>=20
> ebdc118c0b26e crypto: af_alg - Fix page reassignment overflow in af_alg_p=
ull_tsgl
> c179b717b58fe crypto: authencesn - Fix src offset when decrypting in-place
> 7b115c6573f4d crypto: authencesn - Do not place hiseq at end of dst for o=
ut-of-place decryption
> 3a3b130398dee crypto: algif_aead - snapshot IV for async AEAD requests
> 0bf0afd65c4bd crypto: algif_aead - Revert to operating out-of-place
> 02b8603f1d1c9 crypto: algif_aead - Fix minimum RX size check for decrypti=
on
> ab59e176f0f35 crypto: scatterwalk - Backport memcpy_sglist()

I did not check these in great detail; this would really need crypto
expert. I wonder how much testing of crypto we do, but we don't have
much choice here, anyway.

Best regards,
								Pavel

--IuR8Jb9B3FhKDNx2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCafuVggAKCRAw5/Bqldv6
8txYAJ9AEwUoEDaQwF1Y2mmTIa9sVVBc4gCfRd/SqUoJ8T3HxhDJFIGHiXsDRc4=
=4lpu
-----END PGP SIGNATURE-----

--IuR8Jb9B3FhKDNx2--

