Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3195C28B28
	for <webhook@archiver.kernel.org>; Mon, 17 Mar 2025 21:21:55 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.2713.1742246510359360120
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Mar 2025 14:21:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=FNoydmAw;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BFE97103BC67A;
	Mon, 17 Mar 2025 22:21:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1742246508; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=izvxqwBasrSNcLlDGWPDpaNBJRCOSKksUkSjTn0qguA=;
	b=FNoydmAweXka8hWu6BndbXKXe0P7e/lQWbJC6VZDvNxM2agzhbELqxiL6pLXqq/6cjWAfF
	bhg3PW6ywgsyfYBljaMUMWtpaPtjkXC5qy/wns/Mykr0BhfZYo0ianojeutIURHoRXD9fV
	gWUR1SUjb2kfT28q6Jgsy5CL2opuPkGbkfn8KzQIY7bRqI+KEeHoGaJol1LzOoB4nVdbEi
	wkU3c2FFCZuhpJukbkG0n2hvnH1WMFzALwziKrTg2J011dQa9anzB9XjxhcncGfc5gu9GZ
	j+Eguq/IwhflHWaOMaJzu6dnwrIyynziIKu3cWLYiHR8VXzqNTfc9L/mtLsa1g==
Date: Mon, 17 Mar 2025 22:21:41 +0100
From: Pavel Machek <pavel@denx.de>
To: Ulrich Hecht <uli@fpond.eu>, kazuhiro3.hayashi@toshiba.co.jp
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: Request for reviews for 4.4-st62, 4.4-cip97
Message-ID: <Z9iSZXvdZiMmPX3e@duo.ucw.cz>
References: <1265902513.5463957.1741955689526@webmail.strato.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8OKf9qnuDa9c5Ofi"
Content-Disposition: inline
In-Reply-To: <1265902513.5463957.1741955689526@webmail.strato.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 17 Mar 2025 21:21:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18235


--8OKf9qnuDa9c5Ofi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi1

> Here's two manual backports for the upcoming 4.4 release. They can be fou=
nd in the tree at https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux=
-cip.git/log/?h=3Dlinux-4.4.y-st-rc
>=20
> ed0c3fd887468 scsi: iscsi: Fix redundant response for
> ISCSI_UEVENT_GET_HOST_STATS request

I'm not sure this causes real problems, but at least it is simple.

> 30e94a5d266d9 irqchip/gic-v3: Handle CPU_PM_ENTER_FAILED correctly

This looks ok to me.

Could we get

[PATCH 4.4 4.9 v1 1/2] init: Introduce system_scheduling flag for allocate_=
slab()
[PATCH 4.4 4.9 v1 2/2] mm: slub: allocate_slab() enables IRQ right after sc=
heduler starts

Merged into 4.4-st, too? They are simple enough and fix real problem
for Toshiba.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--8OKf9qnuDa9c5Ofi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ9iSZQAKCRAw5/Bqldv6
8tncAJ9kMbD1LGwwXg+BM4xJbUxt0+2CIwCgpc+bK/lG4NlpROb4KyLnIpmm69U=
=Sho3
-----END PGP SIGNATURE-----

--8OKf9qnuDa9c5Ofi--

