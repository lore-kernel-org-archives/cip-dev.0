Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B06AE7719F
	for <webhook@archiver.kernel.org>; Mon, 13 Jan 2025 12:08:26 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.15308.1736770096677462081
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Jan 2025 04:08:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=XWtcbndz;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E5E2A10408F8C;
	Mon, 13 Jan 2025 13:08:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1736770094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7fZu6sHWSNtOdb0pJ7W3P/obv3OLWovoCfwVMU3MG8I=;
	b=XWtcbndzKDaiR9nJds32ObY37bVifd7dFLve7soI77oh0yEF62PNdR/EtpKMXeO9LxPfXI
	unc1BtOcZQEjmBvSCbSKNC/oEZMqK2GCgXq6aj005MbuIwt1TpEinVjRuFx92Ij6FEYpxe
	5QuB5dLNPWyvGjaCIixZ1/1N1RUwu07rttjW1UWFqo1JbVu9C90ZAvRdHIK36BXGCE557g
	eIKSyvZ1jiUr3PE5QXdhT5gTU6tr79TQhO2AgzKvozJBDkMPhtfEoXa3+ZimUSt2ivIyDT
	FcZ0LEdqk5UHN6ogoP99c3GuAak120fbvWoJbia++fs3fEB+kVyPBMmsACMzPg==
Date: Mon, 13 Jan 2025 13:08:11 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com
Subject: Re: [cip-dev][isar-cip-core][PATCH v3] initramfs-crypt-hook: clarify
 resize error
Message-ID: <Z4UCKwNrHLXO7+V+@duo.ucw.cz>
References: <20250110165253.77676-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yDvZsdqw8LJ8TE9h"
Content-Disposition: inline
In-Reply-To: <20250110165253.77676-1-Quirin.Gylstorff@siemens.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Jan 2025 12:08:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17532


--yDvZsdqw8LJ8TE9h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>=20
> Add context to the resizing error as it is was unclear why the
> encryption can not continue.

or fstype: '$partition_fstype'"
>  		;;
>  	*)
> -		panic "cannot resize parition. unsupport fstype: $partition_fstype"
> +		panic "cannot resize partition. unsupport fstype: $partition_fstype"
>  		;;

Should this say "unsupported"?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--yDvZsdqw8LJ8TE9h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ4UCKwAKCRAw5/Bqldv6
8muJAJsFUa/cOjKDr/tMtJSLJKhU81sqJQCghYl0m+lplZqJW2sEAJJOSSynICo=
=bpSB
-----END PGP SIGNATURE-----

--yDvZsdqw8LJ8TE9h--

