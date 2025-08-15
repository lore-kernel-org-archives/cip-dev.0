Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E6A2CA0EE4
	for <webhook@archiver.kernel.org>; Fri, 15 Aug 2025 09:22:09 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.7876.1755249726802073374
 for <cip-dev@lists.cip-project.org>;
 Fri, 15 Aug 2025 02:22:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=Cs8GMfXK;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 960BF1038C11C;
	Fri, 15 Aug 2025 11:22:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1755249724; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=xPPIuhqqbbXMqmyrzu+4FK9ttbEV1/ZsyFrqR79M2sg=;
	b=Cs8GMfXKkCBG/FuANdJECPbmPC8bwQTK9wHGODpLdTwS3WJRMWRs6I8+PFMNoeJTEClhPw
	VkW2D3MDHIOquLj65M1YVqs7ikj4xGUA+3haM9HTJJq2QZPMODzD7Dw6RwgnDVK5GeSm7d
	7Puaj1xK1CGzJV3YsnoHlGgVQuURFrXWirWj/9/NojPdmUhwHSDS9CFMhUPAhZzSMfdKI5
	sE1lgIu3aLEBHSlYbfUiBe2JN/v+e2rMaFWSuOvgDTWDwuYAnPiloSW4/pvGX29hTupwWx
	5M6D8xCvGJQSkLi8qO/Bg532itd/djBNqjAsBHCdUgOdllpnFxMSxqtMQrXkSg==
Date: Fri, 15 Aug 2025 11:21:58 +0200
From: Pavel Machek <pavel@denx.de>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: Request for review for 4.19-st7 4.19-cip123
Message-ID: <aJ78NuGofKFATgv+@duo.ucw.cz>
References: <2044856947.285232.1755072787301@webmail.strato.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XevS3IRhfj73pCS6"
Content-Disposition: inline
In-Reply-To: <2044856947.285232.1755072787301@webmail.strato.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 15 Aug 2025 09:22:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19750


--XevS3IRhfj73pCS6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Here are the manual backports for the upcoming 4.19 kernel release. As al=
ways they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/c=
ip/linux-cip.git/log/?h=3Dlinux-4.19.y-st-rc
>

Thanks for backports. I have one comment.

a > 2d06b88d7b674 net/sched: Abort __tc_modify_qdisc if parent class does n=
ot exist
a > 81ef51e1ea6d3 mtk-sd: Prevent memory corruption from DMA map failure
a preparation > 20521203f5e28 mmc: mediatek: use data instead of mrq parame=
ter from msdc_{un}prepare_data()
a > 3048009716dad scsi: qla4xxx: Fix missing DMA mapping error in qla4xxx_a=
lloc_pdu()
a > 8589bbe304882 btrfs: don't abort filesystem when attempting to snapshot=
 deleted subvolume
a > 6bffeee62f0d8 VMCI: fix race between vmci_host_setup_notify and vmci_ct=
x_unset_notify

!! > 466ceb3aaec13 tty: serial: uartlite: register uart driver in init

As far as I can tell:

ulite_init() is just a cleanup. No real change.

ulite_exit() simply removes "-if (ulite_uart_driver.state)".

I don't see how it matches changelog, and not sure how to verify
this. I'd be inclined to just drop this one.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--XevS3IRhfj73pCS6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaJ78NgAKCRAw5/Bqldv6
8rddAKC3a/VpOuMl0Oukse+Amikpvwu8wACgkivUt70/uDDAag0Z0HsnyFn19R8=
=+tkG
-----END PGP SIGNATURE-----

--XevS3IRhfj73pCS6--

