Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE54E9370C
	for <webhook@archiver.kernel.org>; Thu,  5 Oct 2023 11:41:57 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.13100.1696506111067978472
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Oct 2023 04:41:52 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id A9E511C004C; Thu,  5 Oct 2023 13:41:47 +0200 (CEST)
Date: Thu, 5 Oct 2023 13:41:47 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] [kernel-cve-report] New CVE entries this week
Message-ID: <ZR6g+1Qpz/QyVY9R@duo.ucw.cz>
References: <CAODzB9qGjXFSyuKbeNNWKLarGQkWMsWj1q1bO0n53P9dwK4J+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d1kzEMH75XLeTxhz"
Content-Disposition: inline
In-Reply-To: <CAODzB9qGjXFSyuKbeNNWKLarGQkWMsWj1q1bO0n53P9dwK4J+g@mail.gmail.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 Oct 2023 11:41:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13295


--d1kzEMH75XLeTxhz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> CVE-2023-4732: mm/userfaultfd: fix uffd-wp special cases for fork()
>=20
> CVSS v3 score is not provided (NIST).
> CVSS v3 score is 4.7 MEDIUM (CNA).
>=20
> A flaw was found in the Linux Kernel's memory management subsystem. A
> task exits and releases a 2MB page in a vma (vm_area_struct) and hits
> the BUG statement in pfn_swap_entry_to_page() referencing pmd_t x.
>=20
> This bug was introduced by commit b569a17 ("userfaultfd: wp: drop
> _PAGE_UFFD_WP properly when fork") in 5.7-rc1.
> The commit b569a17 is not backported to older stable kernels.
>=20
> Fixed status
> mainline: [8f34f1eac3820fc2722e5159acceb22545b30b0d]
> stable/5.10: [9e1cf2d1ed37c934c9935f2c0b2f8b15d9355654]

So fix is

commit 8f34f1eac3820fc2722e5159acceb22545b30b0d -- mm/userfaultfd: fix
uffd-wp special cases for fork()

Aha, and 6.1 already contains mainline version of a fix, so we are
okay there.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--d1kzEMH75XLeTxhz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZR6g+wAKCRAw5/Bqldv6
8qFQAJ4saRP2qW/+J1wSj4ZnQvV3KphN6wCfXkYCT/jXoPiYNJbEYetCZfhB2YI=
=M4Pb
-----END PGP SIGNATURE-----

--d1kzEMH75XLeTxhz--

