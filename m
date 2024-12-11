Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5E0E7717D
	for <webhook@archiver.kernel.org>; Wed, 11 Dec 2024 21:56:46 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.6541.1733954204478128779
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Dec 2024 13:56:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=Ke66QIHj;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C35B710408FAE;
	Wed, 11 Dec 2024 22:56:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1733954202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=lvltzT1CZ1SeieEpk3l/CYniy4CnSO7uxLP7Dkthnbc=;
	b=Ke66QIHjuN/1LegVTQxvAvGZHYOPDJ5F4HqWc/nWlQKThmYpP6Bm4W8afaGlfC/0FLL2iC
	gxXEqVxWUz7Tjx8I/qju9jd1lPn5HR7TaLjAH7lCMJdKyxM3vf/Ilh6eYpMoGhbn8AK/xd
	MD9VrJ42J3SKyvXevstJeXsURukh9uCRVUKZebwgfXY0yWAkWeW6CMscHbFWMf8KMx2QuP
	xZ0K2LNZfTDUvsW62u2zUHV0dF/3ZVGJtiEK4o88zt1as+qHsxUsDtryyuK1eSHcjMlMKV
	aJjKusfB54L/vySTtpeTsR1vbUg8qXxENXzHXjzSUgzuZPsNIa7pih/n6ANqAg==
Date: Wed, 11 Dec 2024 22:56:39 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org, uli@fpond.eu
Subject: 4.4-rt nilfs problem
Message-ID: <Z1oKlyKZkSw0Bhq0@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mejblDUu0KV7R3nW"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Dec 2024 21:56:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17408


--mejblDUu0KV7R3nW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

This 4.4-rt release is proving more "fun" then average. Last problem I
hit is this one:

https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/8612057735

fs/nilfs2/dir.c: In function 'nilfs_find_entry':
2705
fs/nilfs2/dir.c:350:31: error: initialization of 'char *' from incompatible=
 pointer type 'struct page *' [-Werror=3Dincompatible-pointer-types]
2706
  350 |                 char *kaddr =3D nilfs_get_page(dir, n);
2707
      |                               ^~~~~~~~~~~~~~
2708

And I believe it is caused by 3ab089df2d67491785a5bdaab01cfab8eb35dab5
:

    nilfs2: propagate directory read errors from nilfs_find_entry()

@@ -345,25 +347,26 @@ nilfs_find_entry(struct inode *dir, const struct qstr=
 *qstr,
                start =3D 0;
        n =3D start;
        do {
-               char *kaddr;
-               page =3D nilfs_get_page(dir, n);
-               if (!IS_ERR(page)) {
-                       kaddr =3D page_address(page);
=2E..
+               char *kaddr =3D nilfs_get_page(dir, n);

Compiler does not like page * assigned into char *, and I don't blame
him.

I could probably hack something up -- like below -- but it raises
questions such as

a) "should kaddr by checked for IS_ERR like that"?

and

b) "am I comfortable changing code we are not testing"?

Best regards,
								Pavel

diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
index 61ca998ac8013..ea0df90626a0d 100644
--- a/fs/nilfs2/dir.c
+++ b/fs/nilfs2/dir.c
@@ -347,8 +347,13 @@ nilfs_find_entry(struct inode *dir, const struct qstr =
*qstr,
 		start =3D 0;
 	n =3D start;
 	do {
-		char *kaddr =3D nilfs_get_page(dir, n);
+		char *kaddr;
+	=09
+		page =3D nilfs_get_page(dir, n);
+		if (IS_ERR(page))
+			return ERR_CAST(page);
=20
+		kaddr =3D page_address(page);
 		if (IS_ERR(kaddr))
 			return ERR_CAST(kaddr);
=20



--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--mejblDUu0KV7R3nW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ1oKlwAKCRAw5/Bqldv6
8nl1AJ9Hwtebn/49ti/hWc3IIjqwg/b1nQCaAsghlcYkHm0Giye5ylB6tBpdXb4=
=xsjn
-----END PGP SIGNATURE-----

--mejblDUu0KV7R3nW--

