Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD8DC3ABCC
	for <webhook@archiver.kernel.org>; Tue, 13 May 2025 13:59:32 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.77227.1747144762122583836
 for <cip-dev@lists.cip-project.org>;
 Tue, 13 May 2025 06:59:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=gsKS9JN7;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 568EF102E13DA
	for <cip-dev@lists.cip-project.org>; Tue, 13 May 2025 15:59:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1747144760; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=+VvO/qP1AF60aDVP+5PcBA3GHpxpxtnwciXS1ZObZvk=;
	b=gsKS9JN7IuKaiLgIlW9SKy8fxMh3ESBRBHL7eN1wmw0nfPNs5xNCoZ5Y9YerY4wAvjuAXa
	CN336pV5jY0vtj9anwXHEYMs4dAEk/N9pc+dQCnx5r9B3bNpy6LJ1XR1uZZ4zmQZa1iDbe
	ENSb8wK5OaTLFMkKYFG3sH6N4o1W4If+C6bbKOuxZXhbSz+g3bnuBJHAFL3jkpcZAcRHrE
	Nc8QTAuLVTMWlpCSR+1p/1qz1LfQAT8UtIxRv2PiyozHFzvMiMqOHJMz4JejAKpCLebYkS
	Z58oxc3GyUWAtkcyxikrZS08NG+b6qvgCjqKxfs97jA6tL9qit25Q6KcPqgVIw==
Date: Tue, 13 May 2025 15:59:15 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Spectre-class CPU bugs on Intel CPUs
Message-ID: <aCNQMy/MNNRHLf9G@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bjU+kRYF2SBZTid8"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 13 May 2025 13:59:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18901


--bjU+kRYF2SBZTid8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Courtesy of Intel, here's periodic reminder, that superscalar,
out-of-order CPUs will leak secret data. Last non-broken CPU from
Intel is Pentium MMX and probably some Atom models.

+++ b/Documentation/admin-guide/hw-vuln/indirect-target-selection.rst
@@ -0,0 +1,168 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Indirect Target Selection (ITS)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
+
+ITS is a vulnerability in some Intel CPUs that support Enhanced IBRS and w=
ere
+released before Alder Lake. ITS may allow an attacker to control the predi=
ctio\
n
+of indirect branches and RETs located in the lower half of a cacheline.
+
+ITS is assigned CVE-2024-28956 with a CVSS score of 4.7 (Medium).

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--bjU+kRYF2SBZTid8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaCNQMwAKCRAw5/Bqldv6
8tvaAJ9iMBA3gMpCUqnXnKIte+pRTpGndACeNYc9OSgWo85lJb6itqAKSOPsR7s=
=ybYq
-----END PGP SIGNATURE-----

--bjU+kRYF2SBZTid8--

