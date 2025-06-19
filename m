Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F24C71155
	for <webhook@archiver.kernel.org>; Fri, 20 Jun 2025 06:15:54 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.web11.2809.1750347407913960672
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Jun 2025 08:36:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernel.org header.s=k20201202 header.b=tI9vi/G9;
 spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: conor@kernel.org)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id CD8C26154A;
	Thu, 19 Jun 2025 15:36:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA6FDC4CEEA;
	Thu, 19 Jun 2025 15:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750347406;
	bh=lnpmrhSBGFlnAsGZCyB2mOpXn0yoqpmz1bmtXXLbr5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tI9vi/G99gHZGb7Sz3t2Krygnm6uMFgZtNpDj22ULAe89eBxRb9Kfp5Wl2LP7tPWN
	 /gNw8GjIhZtHxZi3sJNGIjKckwfmHCp3Fv+CLdyDHHghiHsktVnzKsPjW1Dncb4z5M
	 MkQNK5EFuYxTy96/KGcj9lVBPySwx1nA8exXDGwk3NjSQkTT8TRsK2fO4VBTCzZ5Si
	 LeLmDoMp0u4evwkHh7Y18f9IPvcziHrU+KQX+iNg0WHC7cY56qA99q72+ZbBjFusFw
	 g5mnREtJMZ/V9rUEO6W4Bn9Kcl/KdcRgCtsVp9lICS78rBl2QNDypDH9mOqmGA937b
	 BbSYv4EFUnaIQ==
Date: Thu, 19 Jun 2025 16:36:42 +0100
From: Conor Dooley <conor@kernel.org>
To: LiangCheng Wang <zaq14760@gmail.com>
Cc: cip-dev@lists.cip-project.org, drm@lists.freedesktop.org,
	devicetree@vger.kernel.org, noralf@tronnes.org, robh+dt@kernel.org,
	krzk@kernel.org, onlywig@gmail.com
Subject: Re: [PATCH 1/3] dt-bindings: vendor-prefixes: Add Mayqueen name
Message-ID: <20250619-drainpipe-natural-8fa7d5b76a18@spud>
References: <20250618033731.171812-1-zaq14760@gmail.com>
 <20250618033731.171812-2-zaq14760@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20250618033731.171812-2-zaq14760@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tHigTYagu9ocJfGI"
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 20 Jun 2025 06:15:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19147

--tHigTYagu9ocJfGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 11:37:29AM +0800, LiangCheng Wang wrote:
> From: Wig Cheng <onlywig@gmail.com>
>=20
> Mayqueen is a Taiwan-based company primarily focused on the development
> of arm64 development boards and e-paper displays.
>=20
> Signed-off-by: Wig Cheng <onlywig@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--tHigTYagu9ocJfGI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaFQuigAKCRB4tDGHoIJi
0qZMAP40Ua2pL6PPyC/mTfAcXUOOSzQqFPwQf6YvTFCqR7Zo4gD9FuNU9bHPzn6S
qjNY1pv6YaXHGoTlTCQb971yjDZ1NAo=
=0GGU
-----END PGP SIGNATURE-----

--tHigTYagu9ocJfGI--

