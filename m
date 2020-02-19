Return-Path: <pavel@ucw.cz>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5505FC013E
 for <cip-dev@lists.cip-project.org>; Wed, 19 Feb 2020 21:38:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 436AC84808
 for <cip-dev@lists.cip-project.org>; Wed, 19 Feb 2020 21:38:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Hc1jraHJ6K2e for <cip-dev@lists.cip-project.org>;
 Wed, 19 Feb 2020 21:38:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id DA7DB847C4
 for <cip-dev@lists.cip-project.org>; Wed, 19 Feb 2020 21:38:07 +0000 (UTC)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
 id 1D82B1C0139; Wed, 19 Feb 2020 22:38:06 +0100 (CET)
Date: Wed, 19 Feb 2020 22:38:05 +0100
From: Pavel Machek <pavel@denx.de>
To: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Message-ID: <20200219213805.GB17284@amd>
References: <1582034720-5249-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
 <1582034720-5249-5-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
 <20200219075114.GB31996@amd>
 <OSAPR01MB502856456636C79D7F6490ADAE100@OSAPR01MB5028.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <OSAPR01MB502856456636C79D7F6490ADAE100@OSAPR01MB5028.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [PATCH 4.19.y-cip 04/23] usb: roles: Find the muxes by also matching against the device node
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
X-List-Received-Date: Wed, 19 Feb 2020 21:38:09 -0000
X-Groupsio-MsgNum: 4419
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="WYTEVAkct0FjGQmd"
Content-Disposition: inline

--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > @@ -84,7 +85,12 @@ enum usb_role usb_role_switch_get_role(struct
> > > usb_role_switch *sw)  }
> > EXPORT_SYMBOL_GPL(usb_role_switch_get_role);
> > >
> > > -static int __switch_match(struct device *dev, const void *name)
> > > +static int switch_fwnode_match(struct device *dev, const void
> > > +*fwnode) {
> > > +	return dev_fwnode(dev) =3D=3D fwnode;
> > > +}
> > > +
> > > +static int switch_name_match(struct device *dev, const void *name)
> > >  {
> > >  	return !strcmp((const char *)name, dev_name(dev));  }
> >=20
> > This renames  __switch_match -> switch_name_match. That is welcome
> > cleanup for mainline, but not quite neccessary change here. As the func=
tion
> > is static and local to the file, we can live with that, but I hope you =
have not
> > had to do extra effort to backport it :-).
>=20
> Unfortunately, this patch is necessary for the following patches as it in=
troduces
> the necessary fwnode. Generally, yes, I had to find the minimum set of ch=
anges,
> not to modify too much the USB core code. I opted for complete backport
> of the upstream patches, not to chop them off and also not to add much co=
de on
> top of them (only some minor checkpatch fixes). I think it is better not =
to increase
> the delta between linux-cip and upstream too much.
>=20
> But, looking retrospectively, this might not be the best strategy.

Just to be clear, I believe we can use this patch as-is. No need to
change it.

Best regards,
       	       			     	       	      	   Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--WYTEVAkct0FjGQmd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl5Nqr0ACgkQMOfwapXb+vLdWACeN/hNpeaIW8rnbyIjWdxELkKh
/xoAnjkrotIEJjNGsOY/17F6gbVAZIXP
=dyXf
-----END PGP SIGNATURE-----

--WYTEVAkct0FjGQmd--

