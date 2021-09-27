Return-Path: <SRS0=Qva8=OR=lists.cip-project.org=bounce+64572+6752+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C310C433EF
	for <cip-dev@archiver.kernel.org>; Mon, 27 Sep 2021 10:17:37 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9820760F6C
	for <cip-dev@archiver.kernel.org>; Mon, 27 Sep 2021 10:17:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9820760F6C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id VcZuYY4521723xDhsE8uROp9; Mon, 27 Sep 2021 03:17:36 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.29204.1632737854766208098
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Sep 2021 03:17:35 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id D015B1C0B7A; Mon, 27 Sep 2021 12:17:29 +0200 (CEST)
Date: Mon, 27 Sep 2021 12:17:28 +0200
From: "Pavel Machek" <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Cc: uli@fpond.eu
Subject: Re: [cip-dev] Coordinating stable reviews
Message-ID: <20210927101728.GB11971@amd>
References: <16A8A6032C9B7813.26412@lists.cip-project.org>
MIME-Version: 1.0
In-Reply-To: <16A8A6032C9B7813.26412@lists.cip-project.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: sJCjmboa1A7HIpE393qfBCGcx4520388AA=
Content-Type: multipart/mixed; boundary="2ZwSwzLY2yzfWDSXJ139"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1632737856;
 bh=bwj5Nlvd7+gLAn3C8kHQqKK0ZPTE5YjJtsvE/RhOSXQ=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=vswb5c9YE8f8c06w3ZaoU3mzMO1xbQy6GR682QHm+FSBG80i5K7Im/GAS+DhNMDlmbR
 THPj4uHga3ZvF/I7pGEkQ+ETeBr85/VvFjBgVY1rVwktuIIHQX2ST6zUtONQfrbLsSxgQ
 vEkSDGFzvMhwbwK3QiE8rTTbqgZqhDXKmKY=
Message-ID: <20210927101728.iRtCBSNHkIeC7xljzISh7Vcxy0o0T6ZNYji9S5uFKtQ@z>

--2ZwSwzLY2yzfWDSXJ139
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xgyAXRrhYN0wYx8y"
Content-Disposition: inline

--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> We don't really need commit messages for this. Actually, we don't
> really need to keep history, either. It would be good if system could
> be controlled from command line for easy scripting.
>=20
> Any ideas what kind of service could be used for this?

I guess I should mention alternate possibilities. We could try to
somehow "hash" the commits... Perhaps I'd review all the patches where
upstream sha begins with 0-6. But patches in -stable often come in
series that depend on each other, and it would be good if single
person reviewed them.

We could also split based on first character of subject, or on
subsystem patch touches. I guess that would have other disadvantages
like uneven distribution of work when big ammount of btrfs fixes hits
the -stable.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--xgyAXRrhYN0wYx8y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmFRmjgACgkQMOfwapXb+vIHYACdFtvruKiKg/Mz7PcHXhiuC/Ik
mQAAn1rdG4RtRio9uBNiW79vdbe2h4ha
=3dgf
-----END PGP SIGNATURE-----

--xgyAXRrhYN0wYx8y--

--2ZwSwzLY2yzfWDSXJ139
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6752): https://lists.cip-project.org/g/cip-dev/message/=
6752
Mute This Topic: https://lists.cip-project.org/mt/85896746/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--2ZwSwzLY2yzfWDSXJ139--
