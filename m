Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BA4C5DF8C
	for <webhook@archiver.kernel.org>; Sat, 22 Aug 2026 08:11:41 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2961.1787386294051383044
 for <cip-dev@lists.cip-project.org>;
 Sat, 22 Aug 2026 01:11:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=K3KUciRb;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E770611C00C;
	Sat, 22 Aug 2026 10:11:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1787386287;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Z02VWeCjN0F5KbzcFzE+8ak/8k8TV1RbDnGXZT9Ifh0=;
	b=K3KUciRbL2+cLyjjC/x0FZRPRH6VxfVPZ2gz1upKZEVro6SxsX29AAzf0kzudX35HrhAle
	8Zkz8mn5C/abb1MEic6QEQZ0Op0yHY5X82smNV+L/lc6fvlsSj57/ZLbCzC79U1Y/rhRXs
	7Zb4i/TOHLvwa4rEi/3Ljh44ZyDY2CyBfZbeVflnuebi9Qx3kCMMKthoc4KcGqFCBEOjRP
	/O5bRF3OXD5gzbyVoIaApmgX7PIJ4V3un446WIyL+8m212vRvvY98wM7sX92X6qLQ14NHG
	ja005H81BFySj7rVebprlRxQRiJpfDWmteMILFrA+wLxdbSa1ba9irUcbB/LUw==
Date: Sat, 22 Aug 2026 10:11:23 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [PATCH 6.12.y-cip 00/18] Add ICU support for RZ/T2H and RZ/N2H
 SoCs
Message-ID: <aolZq2gonRLG4U4k@duo.ucw.cz>
References: <20260821131554.638741-1-cosmin-gabriel.tanislav.xa@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YjvsGpg+EkZqs7fv"
Content-Disposition: inline
In-Reply-To: <20260821131554.638741-1-cosmin-gabriel.tanislav.xa@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 22 Aug 2026 08:11:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23976


--YjvsGpg+EkZqs7fv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This patch series adds support for the ICU block, including
> software-triggered interrupts and error interrupts, as found in the
> Renesas RZ/T2H and RZ/N2H SoCs.

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel

--YjvsGpg+EkZqs7fv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaolZqwAKCRAw5/Bqldv6
8qKaAKCxAP9OgAV9nw7cKS5sKgoKDk5w/wCaAih7/yPqfXggK+lq9+H/9GkY5Qw=
=Yd58
-----END PGP SIGNATURE-----

--YjvsGpg+EkZqs7fv--

