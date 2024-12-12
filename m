Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E82E7717F
	for <webhook@archiver.kernel.org>; Thu, 12 Dec 2024 11:53:40 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.17970.1734004416250721749
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Dec 2024 03:53:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=QNHuICPM;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 407481047DC21;
	Thu, 12 Dec 2024 12:53:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1734004414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xmm0Nae7RK4ArzDezAZum+SklhReGzp+RgN6uYZcoDg=;
	b=QNHuICPMGJt+Q9D8THMpIx/FyBblPzla09tLma9OnRhMseLN5R7OF6nR6oNI6KNeNXnjHH
	I5BhWskm0mMIvP4ObD7vV9lwwF1M+0jzEmkCXQ5sWvTGy1ypB/4haafG8vQyS/szptZy8N
	9CbUBwu5tgDeKpDPhyUMhggyIRNw30PN9nUdCjMfJUV6MyFxF9TWb9vs8JE5OQwrxnLEUx
	Jr1TDUCXSI3ndI7o3EL/vRZq2rSGGaZVi6dSWMNc9dn0Q9LbjAuO8B6RgHE/RITAoYhjFu
	qoNBJO67MlXwGHETRSoXKhiY2/tIuf0UVN0pgdfOrXNtn6NcxwihumgJS8aMcw==
Date: Thu, 12 Dec 2024 12:53:31 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Cc: Pavel Machek <pavel@denx.de>
Subject: Re: [cip-dev] 4.4-rt nilfs problem
Message-ID: <Z1rOuzC6zMyj+DOd@duo.ucw.cz>
References: <Z1oKlyKZkSw0Bhq0@duo.ucw.cz>
 <83580734.2136174.1733972768709@webmail.strato.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v5kQwqKIiidlGarC"
Content-Disposition: inline
In-Reply-To: <83580734.2136174.1733972768709@webmail.strato.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 12 Dec 2024 11:53:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17415


--v5kQwqKIiidlGarC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Compiler does not like page * assigned into char *, and I don't blame
> > him.
>=20
> It seems this is missing a dependency, namely ea2ac9238d4919bdc6963a2b487=
a65ccdaa11c78 ("nilfs2: return the mapped address from nilfs_get_page()"), =
which in turn has more dependencies...
>=20
> > I could probably hack something up -- like below -- but it raises
> > questions such as
> >=20
> > a) "should kaddr by checked for IS_ERR like that"?
>=20
> AFAICT, no. page_address() returns NULL on error.

Ok, so I did change below to patch it up. I'll release it as
4.4-cip-rt if I get testing to cooperate.=20

> > b) "am I comfortable changing code we are not testing"?
>=20
> Given that that is what this backport does and how well that worked, I gu=
ess the answer is no...
>=20
> When maintaining file systems for 4.4, nilfs2 is the biggest effort by a =
mile. From what I can tell it's used in only one config (moxa_mxc_defconfig=
). Is there any way to find out if it is actually used or just happens to b=
e enabled?
>

Ok, I believe backporting more is not a solution here. I don't believe
we do any runtime nilfs2 testing. I guess we should talk about it on
irc (am I wrong and somebody is using/testing this?), but I believe we
should simply avoid this kind of intrusive changes. It is "only" a
robustness in case of error, so not something I'll lose sleep over.

Best regards,
								Pavel


commit 193ce60475afc15ceeb572c4f750c1d793e598ae
Author: Pavel Machek <pavel@ucw.cz>
Date:   Wed Dec 11 22:58:24 2024 +0100

    nilfs2: fix backport of "propagate directory read errors from nilfs_fin=
d_entry()"
   =20
    I believe 3ab089df2d674 was backported wrong. Types are confused and
    that causes compile error. This fixes compile problems.
   =20
    Signed-off-by: Pavel Machek <pavel@denx.de>

diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
index 61ca998ac8013..9b9e6235819e2 100644
--- a/fs/nilfs2/dir.c
+++ b/fs/nilfs2/dir.c
@@ -347,10 +347,15 @@ nilfs_find_entry(struct inode *dir, const struct qstr=
 *qstr,
 		start =3D 0;
 	n =3D start;
 	do {
-		char *kaddr =3D nilfs_get_page(dir, n);
+		char *kaddr;
=20
-		if (IS_ERR(kaddr))
-			return ERR_CAST(kaddr);
+		page =3D nilfs_get_page(dir, n);
+		if (IS_ERR(page))
+			return ERR_CAST(page);
+
+		kaddr =3D page_address(page);
+		if (!kaddr)
+			return ERR_PTR(-ENOMEM);
=20
 		de =3D (struct nilfs_dir_entry *)kaddr;
 		kaddr +=3D nilfs_last_byte(dir, n) - reclen;



--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--v5kQwqKIiidlGarC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ1rOuwAKCRAw5/Bqldv6
8hwpAKCslCw1BFKrRmJF2yffZ5gzVlYyXACgrL9V1n5i+7s1jtl5WDJKGaWToJE=
=PUOu
-----END PGP SIGNATURE-----

--v5kQwqKIiidlGarC--

