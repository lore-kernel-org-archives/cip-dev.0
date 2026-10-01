Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20679CA5FB3
	for <webhook@archiver.kernel.org>; Thu,  1 Oct 2026 10:21:21 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7744.1790850075496143936
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Oct 2026 03:21:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=AY5EJXCy;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E8E911072CD
	for <cip-dev@lists.cip-project.org>; Thu, 01 Oct 2026 12:21:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1790850070; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=7oBb8GUR77ThBNk7XfFslFOlIJ/kWkNMvw97qV7LHUg=;
	b=AY5EJXCyy/bKcJ0uGH2W01nqPt5u2sQ5aW9JZGDjgjLOyAmLSJz/twZqR40QJP8hq+AF1P
	aqHLixaw2imDpGutiiMHM0PuJDDeb1NfYuTUl3DfC6hsFI/GHYI6ex96m8SEIkSbML21a1
	QN7K1becItXoiWRCXShWpFlv+8TKfPkpfzkUTdtWhB8IvF1zTK/e4wLFsMqRlIOc+S49L8
	Jww21TpE66mnM0Qk6NErtq/Dyh99fxRy1xbTuLnW4v4222vMXW/Wu2MFvNLri3L/YqgGtG
	O6EzO7wU1dqeqhmj6a1gHnrYbSLJeanAKLGLfdMz2N/0kCcL422VqHbP6UGkuA==
Date: Thu, 1 Oct 2026 12:21:08 +0200
From: Pavel Machek <pavel@nabladev.com>
To: cip-dev@lists.cip-project.org
Subject: CIP IRC weekly meeting today on libera.chat
Message-ID: <ar40FL_gpdBAE367@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R0WdI8+TPmDhf0Dn"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Oct 2026 10:21:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24395


--R0WdI8+TPmDhf0Dn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6697/cip

The IRC meeting is scheduled to UTC (GMT) 12:00.

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2026/09/cip.2026-09-24-12.01.log.html

Best regards,
									Pavel

--R0WdI8+TPmDhf0Dn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCar40FAAKCRAw5/Bqldv6
8o/HAJ9pHcz+yCQ5JFXGoDaRvoz3okhheQCfd4uljB4LwXMoKGQoEbR2Nl3iiQE=
=7AxM
-----END PGP SIGNATURE-----

--R0WdI8+TPmDhf0Dn--

