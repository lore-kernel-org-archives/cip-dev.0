Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D2FD4115A
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 10:08:32 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.32351.1768471705580655050
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Jan 2026 02:08:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=eFns7PJt;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B7D4710BB5F
	for <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 11:08:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1768471703; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=fsIw/Q0krR/34K6ODbdG4qxri4NkVQFkHEkmxH0bbpE=;
	b=eFns7PJts1HlMB7CfUzPAXwFvyxkKCMnJxrOtssqco86eXNKU5FXcHFGcAcURwMHKtMNmO
	xH5VOdCz9WLjY7pdczmfAIqWnEsEtqtxoRhDnmsVwaNipYk4XJIPZjHPiSHvSHlKDI738t
	GqD8ecKHO8g4AtjjxG6fWU/CvsTwjbGCH7ccJYdkloZyqfQdCMU5lKXZPHuH1SVTO2Wmyq
	dtSdLBxulZ4D2Av4AHBrjV2olpNMdua9kGkmOtI7inoIOafIhzSHL+AoJ1loqlsV6mwVZ6
	X/DEKWbonEMMXs7J1GjbOt/br2N89+naSHyE4n00oc4hAM55RqGCag+3riPfcA==
Date: Thu, 15 Jan 2026 11:08:20 +0100
From: Pavel Machek <pavel@nabladev.com>
To: cip-dev@lists.cip-project.org
Subject: CIP IRC weekly meeting today on libera.chat
Message-ID: <aWi8lGOWijOzLCXC@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="t8r18yURIh/A7LNp"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 10:08:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21621


--t8r18yURIh/A7LNp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

USWest    USEast    UK        DE        TW        JP
04:00     07:00     12:00     13:00     20:00     21:00

Or in about 2 hours.

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2026/01/cip.2026-01-08-1=
2.02.log.html

* Action items
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Best regards,
									Pavel
--=20
In cooperation with Nabla.

--t8r18yURIh/A7LNp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaWi8lAAKCRAw5/Bqldv6
8mcaAJ4hhl68MWVaQGwGAFS+kY7PiJMW2wCfcgjnKclfe5YO5brMBruo1cZC2vs=
=rcaZ
-----END PGP SIGNATURE-----

--t8r18yURIh/A7LNp--

