Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.812.1792698364988715250
 for <cip-dev@lists.cip-project.org>;
 Thu, 22 Oct 2026 12:46:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=bO+ZCZ5F;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6DEDC10AB40
	for <cip-dev@lists.cip-project.org>; Thu, 22 Oct 2026 21:45:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1792698358; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=5jNfA3Sd3P3d0QCoJ/Bizat40bFiCxsranggiI5kITI=;
	b=bO+ZCZ5FRJCKg4BEe05+oQq3GJsZHBMS8jKU40dfXqm6j8Xm3lmKcdH++NHoNbM+IhdWjV
	vZD2JujVwlA6Tkl5ZOeEFmIhuFppaiwlLHPerb8vJy+Fn8cc+zdeNJ38eGkDi3Y/9frbia
	YwTCnuFfQyIRpydLgYURtNostPyaZA/Je24FvzIP90XsEY3sE81CrytUUL5TumTummpfUC
	wMmsE5nbtgodvsz50/vxkti2Rvlmf0UuJQ49qmqUYbXR1KFfhtKrAL/hydzW2JCt2IbaQc
	1TDf8WreK9MKqvFtSkDTgqCDNC4XkLlyUei/SORt6mdlNnR7gzckaXBbPUtvPQ==
Date: Thu, 22 Oct 2026 21:45:55 +0200
From: Pavel Machek <pavel@nabladev.com>
To: cip-dev@lists.cip-project.org
Subject: CVE-2026-99999: pwnescape -- bug in IP checksumming allows KVM
 priviledge escalation
Message-ID: <atpn809_xK8l4EmO@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ATAmT5PkUNCfv0fF"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 22 Oct 2026 19:46:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24515


--ATAmT5PkUNCfv0fF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

There's a new CVE, with a nice name and nice number. If you are
running untrusted code in KVM sandbox (you really should not) this is
important for you, and you should really let us know ASAP.

Description from security researchers is at
https://pwn.ai/blog/pwnescape . Logo is not too cool this time.

Commit 6785011f8b16abf40b1e9d8b2e332232b3e68822 "ipv4: validate
checksum_start before completing checksum" in mainline should stop the
exploit, but states more work is pending:

"We really shouldn't allow such packets in, but as a defence
in depth measure, let's also check before we complete the checksum.

A more complete validation at input is forthcoming, but needs more work."

Stable kernels should be fixed, down to 5.10.272; that was released on
Oct 15. Unfortunately, we did releases soon after that, so the fix is
not there:

v6.12.112-cip33: does not contain the fix
linux-6.1.y-cip: does not contain the fix
v5.10.271-cip78: does not contain the fix

I believe we don't need to do early -cip-rt releases for this.

I'd be inclined not to do early -cip releases, either, but that is
less clear, and others feel otherwise (on irc: iwamatsu> I think a
special release is necessary.). I can help with early -cip releases if
we decide to do them.

If you rely on KVM sandboxing for any -cip or -cip-rt version, please let
us know, and we will simply do the releases.

Best regards,
								Pavel
--ATAmT5PkUNCfv0fF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCatpn8wAKCRAw5/Bqldv6
8gyRAKCQAFtG4cXDFMCYDU1XT18Bp8ccDQCdHyoXdBj2U5dyTJbq0WtdnasG+UE=
=mHK6
-----END PGP SIGNATURE-----

--ATAmT5PkUNCfv0fF--
