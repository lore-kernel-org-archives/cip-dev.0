Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E431DC433F5
	for <webhook@archiver.kernel.org>; Thu, 11 Nov 2021 09:21:53 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.8288.1636622511845474761
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Nov 2021 01:21:53 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 4A9AF1C0BB0; Thu, 11 Nov 2021 10:21:40 +0100 (CET)
Date: Thu, 11 Nov 2021 10:21:38 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] New CVE entries in this week
Message-ID: <20211111092138.GA8515@amd>
References: 
 <CAODzB9okpxqQ9ezVD0ua8wKqCjo=j1zw0pU18v7gmE=r1KGOQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
In-Reply-To: 
 <CAODzB9okpxqQ9ezVD0ua8wKqCjo=j1zw0pU18v7gmE=r1KGOQg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Nov 2021 09:21:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6876


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> CVE-2021-0929: staging: ion: move buffer kmap from begin/end_cpu_access()
>=20
> CVSS v3 score is not provided.
>=20
> ION is a memory manager which is used by Android. This CVE may affect
> 4.4, 4.19, and 5.10 however according to the cip-kernel-config, no cip
> member enabled ION. The ION driver has been removed since 5.11.
>=20
> Fixed status
>=20
> mainline: [3e9e0c5c764704218c0960ffdb139de075afaadf]

Furthermore, CIP members should really not be using code from staging.

> * Updated CVEs
>=20
> CVE-2021-42739: media: firewire: firedtv-avc: fix a buffer overflow in
> avc_ca_pmt()
>=20
> 4.19 and 5.X kernels have been fixed in this week. However, appliying
> patch to 4.4 and 4.9 are failed.
> According to the cip-kernel-config repo, no CIP member uses firewire driv=
er.

This one looks rather easy to backport. It failed only because
reformatting of the printk.

> CVE-2021-3640: UAF in sco_send_frame function
>=20
> Fixed commit is 99c23da0eed4fd20cae8243f2b51e10e66aa0951 ("Bluetooth:
> sco: Fix lock_sock() blockage by memcpy_from_msg()"). Backport patches
> for 4.19, 5.4, 5.10, 5.14, and 5.15 have been sent to stable mailing
> list on Nov 9. This fix can be applied to 4.4 by git-am without error.
>=20
> mainline: [99c23da0eed4fd20cae8243f2b51e10e66aa0951]

Would it make sense to ask why it was not applied?

Best regards,
								Pavel

diff --git a/drivers/media/firewire/firedtv-avc.c b/drivers/media/firewire/=
firedtv-avc.c
index 280b5ffea592..3a373711f5ad 100644
--- a/drivers/media/firewire/firedtv-avc.c
+++ b/drivers/media/firewire/firedtv-avc.c
@@ -1169,7 +1169,11 @@ int avc_ca_pmt(struct firedtv *fdtv, char *msg, int =
length)
 		read_pos +=3D program_info_length;
 		write_pos +=3D program_info_length;
 	}
-	while (read_pos < length) {
+	while (read_pos + 4 < length) {
+		if (write_pos + 4 >=3D sizeof(c->operand) - 4) {
+			ret =3D -EINVAL;
+			goto out;
+		}
 		c->operand[write_pos++] =3D msg[read_pos++];
 		c->operand[write_pos++] =3D msg[read_pos++];
 		c->operand[write_pos++] =3D msg[read_pos++];
@@ -1181,13 +1185,17 @@ int avc_ca_pmt(struct firedtv *fdtv, char *msg, int=
 length)
 		c->operand[write_pos++] =3D es_info_length >> 8;
 		c->operand[write_pos++] =3D es_info_length & 0xff;
 		if (es_info_length > 0) {
+			if (read_pos >=3D length) {
+				ret =3D -EINVAL;
+				goto out;
+			}
 			pmt_cmd_id =3D msg[read_pos++];
 			if (pmt_cmd_id !=3D 1 && pmt_cmd_id !=3D 4)
 				dev_err(fdtv->device, "invalid pmt_cmd_id %d "
 					"at stream level\n", pmt_cmd_id);
=20
-			if (es_info_length > sizeof(c->operand) - 4 -
-					     write_pos) {
+			if (es_info_length > sizeof(c->operand) - 4 - write_pos ||
+			    es_info_length > length - read_pos) {
 				ret =3D -EINVAL;
 				goto out;
 			}
diff --git a/drivers/media/firewire/firedtv-ci.c b/drivers/media/firewire/f=
iredtv-ci.c
index e63f582378bf..f07482fb8010 100644
--- a/drivers/media/firewire/firedtv-ci.c
+++ b/drivers/media/firewire/firedtv-ci.c
@@ -138,6 +138,8 @@ static int fdtv_ca_pmt(struct firedtv *fdtv, void *arg)
 	} else {
 		data_length =3D msg->msg[3];
 	}
+	if (data_length > sizeof(msg->msg) - data_pos)
+		return -EINVAL;
=20
 	return avc_ca_pmt(fdtv, &msg->msg[data_pos], data_length);
 }

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmGM4KIACgkQMOfwapXb+vLjiQCguI7h76rwfavvbFHDYR5XxFm+
tyYAn1RBsOqU0jAiIeBCUIiKSafX1I4V
=sNYK
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--

