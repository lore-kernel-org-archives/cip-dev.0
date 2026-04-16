Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46344F8D77E
	for <webhook@archiver.kernel.org>; Thu, 16 Apr 2026 20:57:33 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.26060.1776373044666970596
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Apr 2026 13:57:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=M+9Un1sa;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5B20511411C;
	Thu, 16 Apr 2026 22:57:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1776373042;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=LrixOOSLZwSqHaM5n8ywBSJy70NtaxaL11I06PINPg4=;
	b=M+9Un1saWwqgKHx/9hYS1z2mcFLLXY7uJDlj0S6WfjIAgDsV6/qjnV/+cbc6zf8G/oL8tI
	CYaIqOAxbnhfeedWiJw9tJX1pC/spVUhLcGbDcrcV3UqGMOcnwK/7hGcoaJoAa2N+1CYfR
	20vQjCExCFHT19JQg+2Z56MBBJibCWdaPB5wQ4aYIQ91hQD52Iz9fO10ugGOtjM4+83hPL
	CXSyyXWF8lmkFbA1DnA5iuMtItd3K9zH6vlwXp8CdJlrZa+fPyBcblAtqstCwbjdwR8i+h
	Xgo+VkT8eUdmRBNofwgViM22LkoM/C512BIULe2434q3zF8Da88sd4FeutvXsw==
Date: Thu, 16 Apr 2026 22:57:20 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Chris Brandt <chris.brandt@renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Subject: Re: [PATCH 6.12.y-cip 1/7] drm: renesas: rz-du: Add atomic_pre_enable
Message-ID: <aeFNMOPdsv5EJ6rf@duo.ucw.cz>
References: <20260413171733.3088070-1-chris.brandt@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jDpoFiM13avL/eLy"
Content-Disposition: inline
In-Reply-To: <20260413171733.3088070-1-chris.brandt@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Apr 2026 20:57:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22753


--jDpoFiM13avL/eLy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> When drm_panel.prepare_prev_first is set to true in a panel driver, the
> panel expects the MIPI DSI hardware to be already configured before the
> panel's prepare function is called because it might need to send DCS
> commands.

For whole series: I had some minor comments here, but those should be
fixed in mainline, first, so they should not block the merge.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel


--jDpoFiM13avL/eLy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaeFNMAAKCRAw5/Bqldv6
8mRIAJ9TrpAicEYGfIqqPrB9VqdBG0G52QCcCdEJh0UhFWdD1tzMfcen0JFmsCs=
=m0U6
-----END PGP SIGNATURE-----

--jDpoFiM13avL/eLy--

