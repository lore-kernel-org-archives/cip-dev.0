Return-Path: <SRS0=ot0q=A7=lists.cip-project.org=bounce+64572+4940+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC69C433E0
	for <cip-dev@archiver.kernel.org>; Mon, 20 Jul 2020 20:59:25 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38438208E4
	for <cip-dev@archiver.kernel.org>; Mon, 20 Jul 2020 20:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="jg81zOGX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38438208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4940+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id jLRcYY4521723xtDLX5Do313; Mon, 20 Jul 2020 13:59:24 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.5206.1595278762639719302
 for <cip-dev@lists.cip-project.org>;
 Mon, 20 Jul 2020 13:59:23 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 44C8C1C0BE2; Mon, 20 Jul 2020 22:59:17 +0200 (CEST)
Date: Mon, 20 Jul 2020 22:59:15 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Chris Paterson <chris.paterson2@renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 1/2] ASoC: rsnd: fixup SSI clock during suspend/resume modes
Message-ID: <20200720205915.GA9879@amd>
References: <1595267543-32854-1-git-send-email-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <1595267543-32854-1-git-send-email-biju.das.jz@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: GiBxo8o9u9T7ohvxrYt9uvhDx4520388AA=
Content-Type: multipart/mixed; boundary="vxLezU8lJYtjDmtqGMdI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595278764;
 bh=k4hUZ63Zz9N2EWe/hIq1Aghe7I2B64zFG8chWAETHZc=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=jg81zOGXch6tg+VTiK8fmrSGZSuaJ/7vGC6o/YgRfAwuEZtLXioB16TmbtIu8msZAYw
 JvXEoZ8RhzTTNXQ1fNWEDjvFI5yA0KfCWAjppfAtcTGf1APh7fZNGWYIl2AieOj2hEku1
 clALCj6wC90KQ8geheIjJZqy6RaZheZeY/s=

--vxLezU8lJYtjDmtqGMdI
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline

--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit 624d1a7cd8991e33dad96ab4629a52c412540e65 upstream.
>=20
> Prepare <-> Cleanup functions pair has balanced calls.
> But in case of suspend mode no call to rsnd_soc_dai_shutdown()
> function, so cleanup isn't called. OTOH during resume mode
> function rsnd_soc_dai_prepare() is called, but calling
> rsnd_ssi_prepare() is skipped (rsnd_status_update() returns zero,
> bacause was not cleanup before).
> We need to call rsnd_ssi_prepare(), because it enables SSI clocks
> by calling rsnd_ssi_master_clk_start().
>=20
> This patch allows to call prepare/cleanup functions always.

Ok, this is "interesting". It has something to do with rsnd_dai_call()
macro.

You really should not be programming drivers in preprocessor like
this.

OTOH patch is simple enough, and only affects "your" code, so ... I'll
apply it if there are no other comments.

>  #define __rsnd_mod_shift_hw_params	28 /* always called */
>  #define __rsnd_mod_shift_pointer	28 /* always called */
> +#define __rsnd_mod_shift_prepare	28 /* always called */
> +#define __rsnd_mod_shift_cleanup	28 /* always called */
> =20
>  #define __rsnd_mod_add_probe		0
>  #define __rsnd_mod_add_remove		0
> -#define __rsnd_mod_add_prepare		 1
> -#define __rsnd_mod_add_cleanup		-1
> +#define __rsnd_mod_add_prepare		0
> +#define __rsnd_mod_add_cleanup		0
>  #define __rsnd_mod_add_init		 1
>  #define __rsnd_mod_add_quit		-1
>  #define __rsnd_mod_add_start		 1
> @@ -365,7 +365,7 @@ struct rsnd_mod {
>  #define __rsnd_mod_call_probe		0
>  #define __rsnd_mod_call_remove		0
>  #define __rsnd_mod_call_prepare		0
> -#define __rsnd_mod_call_cleanup		1
> +#define __rsnd_mod_call_cleanup		0
>  #define __rsnd_mod_call_init		0
>  #define __rsnd_mod_call_quit		1
>  #define __rsnd_mod_call_start		0

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl8WBaMACgkQMOfwapXb+vLr0wCgjyXJimVAEhqwiWJIOs+op9rJ
zpwAmgKb8Ytcq/LZQbJeBJxOQe62xfng
=lTEw
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--

--vxLezU8lJYtjDmtqGMdI
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4940): https://lists.cip-project.org/g/cip-dev/message=
/4940
Mute This Topic: https://lists.cip-project.org/mt/75687530/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--vxLezU8lJYtjDmtqGMdI--
