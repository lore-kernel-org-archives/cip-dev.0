Return-Path: <SRS0=t+AH=BW=lists.cip-project.org=bounce+64572+5112+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56901C433E1
	for <cip-dev@archiver.kernel.org>; Wed, 12 Aug 2020 20:28:30 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4D2520781
	for <cip-dev@archiver.kernel.org>; Wed, 12 Aug 2020 20:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="HMFY59tb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4D2520781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5112+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id kXOpYY4521723xS38e7XsVOe; Wed, 12 Aug 2020 13:28:29 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.39.1597264107557618190
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Aug 2020 13:28:28 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 1A9671C0BD2; Wed, 12 Aug 2020 22:28:22 +0200 (CEST)
Date: Wed, 12 Aug 2020 22:28:21 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Pavel Machek <pavel@denx.de>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [linux-cip:linux-4.19.y-cip 7/17] drivers/gpu/drm/drm_atomic.c:1264:1: warning: no previous prototype for 'drm_atomic_get_old_private_obj_state'
Message-ID: <20200812202821.GC19363@amd>
References: <202008092247.i5TR1Oel%lkp@intel.com>
 <TYBPR01MB53096578ABB1E74E2E2153DA86450@TYBPR01MB5309.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <TYBPR01MB53096578ABB1E74E2E2153DA86450@TYBPR01MB5309.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: ZuG50qmSAZPNqYQ9aEAtOuwwx4520388AA=
Content-Type: multipart/mixed; boundary="6ooErfYqPy3Y8Ebhy2re"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1597264109;
 bh=7yApIQAqQMEJ57nIv0ttsNkRrgJBAUY8p54fdP8dlsI=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=HMFY59tbbz5LntWUm6Pz5lnqiYA6s8X3ZH5G+jS7BHJR8RjQ/IwRwqgGPe0W38W5xSo
 s7SE2bMkklvF0MYNKKdZh7tI9Hg+lLVTLygAPDAtMz3v8lEkfBZovuRJFlysIv5V1xeDT
 MYhbgUhZyKDMeDJo3Zcz6/1jcVqxVs4szeo=

--6ooErfYqPy3Y8Ebhy2re
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LwW0XdcUbUexiWVK"
Content-Disposition: inline

--LwW0XdcUbUexiWVK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I have received a warning message mail from Kernel test robot. I have inv=
estigated this issue and found there were lots of warnings with architectur=
e by following the steps mentioned in this mail.
>=20
> Then I investigated this particular issue and found that issue is caused =
by bad commit done by me while backporting. The below backport commit has
> extra functions from patch1(0001-drm-Add-drm_atomic_get_old-new_private_o=
bj_state.patch), but the corresponding header is missing.
>=20
> cip commit: cacc2a81b9872aa8830353110b1252021f124ae8
> upstream commit: 1b27fbdde1df172dba604855c45078d741f8c858
>=20
> I have attached 3 patches, that looks like fixes the issue mentioned by k=
ernel robot.
>=20
> How do we proceed here?
> drop cip commit: cacc2a81b9872aa8830353110b1252021f124ae8 and apply the 3=
 patches to fix this issue?
>=20

No, let's not revert anything.

This is trivial fix for first issue, make it into patch:

diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index c0b48e25a620..9042fdae9211 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -402,6 +402,12 @@ void drm_atomic_private_obj_fini(struct drm_private_ob=
j *obj);
 struct drm_private_state * __must_check
 drm_atomic_get_private_obj_state(struct drm_atomic_state *state,
 				 struct drm_private_obj *obj);
+struct drm_private_state *
+drm_atomic_get_old_private_obj_state(struct drm_atomic_state *state,
+				     struct drm_private_obj *obj);
+struct drm_private_state *
+drm_atomic_get_new_private_obj_state(struct drm_atomic_state *state,
+				     struct drm_private_obj *obj);
=20
 struct drm_connector *
 drm_atomic_get_old_connector_for_encoder(struct drm_atomic_state
 *state,

And this is somehow strange / non-trivial thingie. Make it into second
patch, and maybe try to explain what is going on there.

Best regards,
								Pavel

@@ -656,6 +662,7 @@ void drm_state_dump(struct drm_device *dev, struct drm_=
printer *p);
 	     (__i)++)								\
 		for_each_if ((__state)->connectors[__i].ptr &&			\
 			     ((connector) =3D (__state)->connectors[__i].ptr,	\
+			     (void)(connector) /* Only to avoid unused-but-set-variable warning=
 */, \
 			     (old_connector_state) =3D (__state)->connectors[__i].old_state,	\
 			     (new_connector_state) =3D (__state)->connectors[__i].new_state, 1))
=20
@@ -677,6 +684,7 @@ void drm_state_dump(struct drm_device *dev, struct drm_=
printer *p);
 	     (__i)++)								\
 		for_each_if ((__state)->connectors[__i].ptr &&			\
 			     ((connector) =3D (__state)->connectors[__i].ptr,	\
+			     (void)(connector) /* Only to avoid unused-but-set-variable warning=
 */, \
 			     (old_connector_state) =3D (__state)->connectors[__i].old_state, 1))
=20
 /**
@@ -697,7 +705,9 @@ void drm_state_dump(struct drm_device *dev, struct drm_=
printer *p);
 	     (__i)++)								\
 		for_each_if ((__state)->connectors[__i].ptr &&			\
 			     ((connector) =3D (__state)->connectors[__i].ptr,	\
-			     (new_connector_state) =3D (__state)->connectors[__i].new_state, 1))
+			     (void)(connector) /* Only to avoid unused-but-set-variable warning=
 */, \
+			     (new_connector_state) =3D (__state)->connectors[__i].new_state, \
+			     (void)(new_connector_state) /* Only to avoid unused-but-set-variab=
le warning */, 1))
=20
 /**
  * for_each_oldnew_crtc_in_state - iterate over all CRTCs in an atomic upd=
ate
@@ -717,7 +727,9 @@ void drm_state_dump(struct drm_device *dev, struct drm_=
printer *p);
 	     (__i)++)							\
 		for_each_if ((__state)->crtcs[__i].ptr &&		\
 			     ((crtc) =3D (__state)->crtcs[__i].ptr,	\
+			      (void)(crtc) /* Only to avoid unused-but-set-variable warning */,=
 \
 			     (old_crtc_state) =3D (__state)->crtcs[__i].old_state, \
+			     (void)(old_crtc_state) /* Only to avoid unused-but-set-variable wa=
rning */, \
 			     (new_crtc_state) =3D (__state)->crtcs[__i].new_state, 1))
=20
 /**
@@ -756,7 +768,9 @@ void drm_state_dump(struct drm_device *dev, struct drm_=
printer *p);
 	     (__i)++)							\
 		for_each_if ((__state)->crtcs[__i].ptr &&		\
 			     ((crtc) =3D (__state)->crtcs[__i].ptr,	\
-			     (new_crtc_state) =3D (__state)->crtcs[__i].new_state, 1))
+			     (void)(crtc) /* Only to avoid unused-but-set-variable warning */, \
+			     (new_crtc_state) =3D (__state)->crtcs[__i].new_state, \
+			     (void)(new_crtc_state) /* Only to avoid unused-but-set-variable wa=
rning */, 1))
=20
 /**
  * for_each_oldnew_plane_in_state - iterate over all planes in an atomic u=
pdate
@@ -776,6 +790,7 @@ void drm_state_dump(struct drm_device *dev, struct drm_=
printer *p);
 	     (__i)++)							\
 		for_each_if ((__state)->planes[__i].ptr &&		\
 			     ((plane) =3D (__state)->planes[__i].ptr,	\
+			      (void)(plane) /* Only to avoid unused-but-set-variable warning */=
, \
 			      (old_plane_state) =3D (__state)->planes[__i].old_state,\
 			      (new_plane_state) =3D (__state)->planes[__i].new_state, 1))
=20
@@ -836,7 +851,9 @@ void drm_state_dump(struct drm_device *dev, struct drm_=
printer *p);
 	     (__i)++)							\
 		for_each_if ((__state)->planes[__i].ptr &&		\
 			     ((plane) =3D (__state)->planes[__i].ptr,	\
-			      (new_plane_state) =3D (__state)->planes[__i].new_state, 1))
+			      (void)(plane) /* Only to avoid unused-but-set-variable warning */=
, \
+			      (new_plane_state) =3D (__state)->planes[__i].new_state, \
+			      (void)(new_plane_state) /* Only to avoid unused-but-set-variable =
warning */, 1))
=20
 /**
  * for_each_oldnew_private_obj_in_state - iterate over all private objects=
 in an atomic update



--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--LwW0XdcUbUexiWVK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl80UOUACgkQMOfwapXb+vKLuQCdFG5DV7JX5KfA3tqocL+U+gAd
DsUAoIBc0XUH5KFCa4rovcVLOCaLAu34
=MEep
-----END PGP SIGNATURE-----

--LwW0XdcUbUexiWVK--

--6ooErfYqPy3Y8Ebhy2re
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5112): https://lists.cip-project.org/g/cip-dev/message=
/5112
Mute This Topic: https://lists.cip-project.org/mt/76126617/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--6ooErfYqPy3Y8Ebhy2re--
