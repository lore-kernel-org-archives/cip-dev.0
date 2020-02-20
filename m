Return-Path: <SRS0=6jSD=4I=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575B3C11D05
	for <cip-dev@archiver.kernel.org>; Thu, 20 Feb 2020 15:46:54 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25E4B2071E
	for <cip-dev@archiver.kernel.org>; Thu, 20 Feb 2020 15:46:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25E4B2071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id F1D2987D75;
	Thu, 20 Feb 2020 15:46:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Noliidj0Zv4U; Thu, 20 Feb 2020 15:46:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id ABD35879A6;
	Thu, 20 Feb 2020 15:46:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77366C1D8F;
	Thu, 20 Feb 2020 15:46:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 40B7AC013E
 for <cip-dev@lists.cip-project.org>; Thu, 20 Feb 2020 15:46:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 29BB387277
 for <cip-dev@lists.cip-project.org>; Thu, 20 Feb 2020 15:46:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6LuDxHuhHlbf for <cip-dev@lists.cip-project.org>;
 Thu, 20 Feb 2020 15:46:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 2A16A86B2F
 for <cip-dev@lists.cip-project.org>; Thu, 20 Feb 2020 15:46:47 +0000 (UTC)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
 id EF8461C0195; Thu, 20 Feb 2020 16:46:43 +0100 (CET)
Date: Thu, 20 Feb 2020 16:46:43 +0100
From: Pavel Machek <pavel@denx.de>
To: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Message-ID: <20200220154643.GA26735@duo.ucw.cz>
References: <1582034720-5249-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
 <1582034720-5249-16-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
 <20200219081234.GD31996@amd>
 <OSAPR01MB502894683145EEC15BD1DDD7AE130@OSAPR01MB5028.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <OSAPR01MB502894683145EEC15BD1DDD7AE130@OSAPR01MB5028.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 15/23] usb: typec: driver for TI
 HD3SS3220 USB Type-C DRP port controller
X-BeenThere: cip-dev@lists.cip-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: <cip-dev.lists.cip-project.org>
List-Unsubscribe: <https://lists.cip-project.org/mailman/options/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=unsubscribe>
List-Archive: <http://lists.cip-project.org/pipermail/cip-dev/>
List-Post: <mailto:cip-dev@lists.cip-project.org>
List-Help: <mailto:cip-dev-request@lists.cip-project.org?subject=help>
List-Subscribe: <https://lists.cip-project.org/mailman/listinfo/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6030034403742639420=="
Errors-To: cip-dev-bounces@lists.cip-project.org
Sender: "cip-dev" <cip-dev-bounces@lists.cip-project.org>


--===============6030034403742639420==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > +static enum usb_role hd3ss3220_get_attached_state(struct hd3ss3220
> > > +*hd3ss3220) {
> > > +	unsigned int reg_val;
> > > +	enum usb_role attached_state;
> > > +	int ret;
> > > +
> > > +	ret =3D regmap_read(hd3ss3220->regmap,
> > HD3SS3220_REG_CN_STAT_CTRL,
> > > +			  &reg_val);
> > > +	if (ret < 0)
> > > +		return ret;
> >=20
> > This function claims to return "enum usb_role", but here it returns err=
no
> > from regmap_read.

######### HERE

> > > +static int hd3ss3220_dr_set(const struct typec_capability *cap,
> > > +			    enum typec_data_role role)
> > > +{
> > ...
> > > +	ret =3D hd3ss3220_set_source_pref(hd3ss3220, pref);
> > > +	usleep_range(10, 100);
> >=20
> > Would udelay() make more sense here? Are your CPUs / timer subsystem so
> > fast that sleeping for 10usec is possible and reasonable to do?
>=20
> I think Biju followed the overall indications from:
> Documentation/timers-howto.txt (.rst)
>=20
> According to the documentation the inflection point is at 10us, so this i=
s kind
> of a grey area. Just to put it in context, the RZ/G2E has 2x1.2Ghz ARM Co=
rtex A53.
> Therefore this is kind of a high-performance embedded platform. At least,=
 we
> like to advertise it like that =F0=9F=98=8A
>=20
> So, I am inclined to keep this as it is if you agree.=20

It is not a big deal to keep it. What about the "returning -errno but
return type is enum" issue above? (Marked with "HERE").

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXk6p4wAKCRAw5/Bqldv6
8iaiAJ4niFchewZuLm1HyGVcMRr1G+bd6ACgrBMWaLlblbfn/QEYHETEer+HlKI=
=EMlf
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--

--===============6030034403742639420==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev

--===============6030034403742639420==--
