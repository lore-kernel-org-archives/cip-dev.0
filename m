Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98A7C5DF82
	for <webhook@archiver.kernel.org>; Thu, 20 Aug 2026 06:04:35 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1047.1787205869514647584
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Aug 2026 23:04:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=XdGd0iI5;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 00F0F11B5DF;
	Thu, 20 Aug 2026 08:04:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1787205863; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=VS5p62Vbg6pWTOab3jTbbhWF1piBDftuBIjyOThrC4E=;
	b=XdGd0iI5a9Z+VCUIArtJewHvOG/OwCOp2QEDnc7vmNfzrkcMuZLMv2HC6RObuHo/wZFdy1
	FuTIOqHM45URcPjGI3RbUaOLC/4l0d+YGghBPs49HSeSlDP1DHSde3ELofE6PhtCNHFaH4
	hnCCyEOLaJmc5prFRzvXRB99iEA+UzWaN/Jp6u5zumCVKJLzeWsdqQUDA5MYOPAZd5dez/
	jAo/QXEqFqoLG8YAGBCrpX4r3z07gSWgIhoxJDxAIcNTGkrd+3D/YKJagkVEvEbC9qcmIC
	4ZRz45eZ56TuwcWzSTUyOwPFos/93PtbaS2IGAksRAHF3iUAdRxNiYfw9GDebg==
Date: Thu, 20 Aug 2026 08:04:20 +0200
From: Pavel Machek <pavel@nabladev.com>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com
Subject: [ANNOUNCE] v6.1.182-cip59-rt31
Message-ID: <aoaY5B3UAwmWNzI1@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oRqCMqlaW2llsden"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Aug 2026 06:04:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23954


--oRqCMqlaW2llsden
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

New realtime trees should be available at kernel.org.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-6.1.y-cip-rt
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-6.1.y-cip-rt-rebase

And their content should be identical. There are also tar archives, at:

https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/

Best regards,
                                                                Pavel

--oRqCMqlaW2llsden
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaoaY5AAKCRAw5/Bqldv6
8h0sAJ0c71zKufBnoSCL9tqUP94nWT93OgCfY/dcbRQlgVtxFI72j5ERM++7nFo=
=pDQ3
-----END PGP SIGNATURE-----

--oRqCMqlaW2llsden--

