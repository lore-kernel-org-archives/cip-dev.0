Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C86C433EF
	for <webhook@archiver.kernel.org>; Fri, 26 Nov 2021 10:03:03 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.22177.1637920982217912760
 for <cip-dev@lists.cip-project.org>;
 Fri, 26 Nov 2021 02:03:03 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 1BE0C1C0B77; Fri, 26 Nov 2021 11:02:57 +0100 (CET)
Date: Fri, 26 Nov 2021 11:02:55 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: CVE-2021-3640: UAF in sco_send_frame function was Re: [cip-dev]
 New CVE entries in this week
Message-ID: <20211126100255.GA13434@duo.ucw.cz>
References: 
 <CAODzB9qEJUBAGggEaTmc27Lr0opreM8wv5D_HStKT6UH=+a_UA@mail.gmail.com>
 <16BABF37827ACD8B.14741@lists.cip-project.org>
 <20211125095339.GC3327@amd>
 <CAODzB9r4uBS5bBKGbZBPST6V7OppONToGqdB8HxhJD8Kh3Nruw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
In-Reply-To: 
 <CAODzB9r4uBS5bBKGbZBPST6V7OppONToGqdB8HxhJD8Kh3Nruw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 26 Nov 2021 10:03:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7021


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!
> > > Interesting.
> > >
> > > commit 99c23da0eed4fd20cae8243f2b51e10e66aa0951
> > > Author: Takashi Iwai <tiwai@suse.de>
> > >
> > > Says:
> > >
> > >     This should be the last piece for fixing CVE-2021-3640 after a few
> > >     already queued fixes.
> > >
> > > Which means more than 99c23da0eed is needed to fix this one,
> > > unfortunately it does not give us good way to identify what commits
> > > are needed.
> >
> > Aha, but we have required information in
> > cip-kernel-sec/issues/CVE-2021-3640.yml. It lists patches that should
> > be fixing this.
> >
> > Some searching in the trees reveals that one of those patches is buggy
> > itself, and additionaly 49d8a5606428ca0962d09050a5af81461ff90fbb is
> > needed.
> >
> > The patches fixing this are:
> >
> > ~  stable/5.10: [4dfba42604f08a505f1a1efc69ec5207ea6243de,
> >                 f2f856b65ac4b77049c76c0e89ecd3a177e9fcd1,
> >                 98d44b7be6f1bcfd4f824c5f8bc2b742f890879f,
> >                 c20d8c197454068da758a83e09d93683f520d681,
> >                 a1073aad497d0d071a71f61b721966a176d50c08]
> >
> > But we still miss backport of 27c24fda62b6 ("Bluetooth: switch to
> > lock_sock in SCO") to 5.10, which has its own prerequisites
> > according to the changelog. AFAICT those prerequisites are
> > 734bc5ff783115aa3164f4e9dd5967ae78e0a8ab and
> > ba316be1b6a00db7126ed9a39f9bee434a508043, and both are in 5.10.
> >
> > I'm not sure how to express this in yml cleanly. I came with this:
> >
> > diff --git a/issues/CVE-2021-3640.yml b/issues/CVE-2021-3640.yml
> > index fb52d5a..d386093 100644
> > --- a/issues/CVE-2021-3640.yml
> > +++ b/issues/CVE-2021-3640.yml
> > @@ -23,9 +23,23 @@ comments:
> >      there is no fixed information as of 2021/07/26.
> >      Fixed in bluetooth-next tree. commit 99c23da0eed4fd20cae8243f2b51e=
10e66aa0951.
> >    ubuntu/sbeattie: Possibly addressed by Desmond Cheong Zhi Xi's patch=
set.
> > +  pavel: We are one patch away from fixing this 5.10, 27c24fda62b6 is =
needed.
> >  fixed-by:
> > -  mainline: [99c23da0eed4fd20cae8243f2b51e10e66aa0951]
> > -  stable/5.10: [4dfba42604f08a505f1a1efc69ec5207ea6243de]
> > +  mainline: [99c23da0eed4fd20cae8243f2b51e10e66aa0951,
> > +            e04480920d1eec9c061841399aa6f35b6f987d8b,
> > +            734bc5ff783115aa3164f4e9dd5967ae78e0a8ab,
> > +            49d8a5606428ca0962d09050a5af81461ff90fbb,
> > +            ba316be1b6a00db7126ed9a39f9bee434a508043,
> > +            27c24fda62b601d6f9ca5e992502578c4310876f,
> > +            734bc5ff783115aa3164f4e9dd5967ae78e0a8ab,
> > +            ba316be1b6a00db7126ed9a39f9bee434a508043]
> > +  stable/5.10: [4dfba42604f08a505f1a1efc69ec5207ea6243de,
> > +               f2f856b65ac4b77049c76c0e89ecd3a177e9fcd1,
> > +               98d44b7be6f1bcfd4f824c5f8bc2b742f890879f,
> > +               c20d8c197454068da758a83e09d93683f520d681,
> > +               a1073aad497d0d071a71f61b721966a176d50c08,
> > +               98d44b7be6f1bcfd4f824c5f8bc2b742f890879f,
> > +               a1073aad497d0d071a71f61b721966a176d50c08]
> >    stable/5.14: [2c2b295af72e4e30d17556375e100ae65ac0b896]
> >    stable/5.15: [b990c219c4c9d4993ef65ea9db73d9497e70f697]
> >    stable/5.4: [d416020f1a9cc5f903ae66649b2c56d9ad5256ab]
> >
>=20
> Thank you for your analysis result ! I applied it.
>=20
> I checked 27c24fda62b601d6f9ca5e992502578c4310876f is able to apply
> cleanly to stable/5.10 tree or not.  Unfortunately it need to fix
> conflicts. git-am shows following two errors.

As far as I can tell, logic is quite simple there and the patch would
look like this. Whether the final result works and closes the security
hole is different question.

Best regards,
								Pavel
commit e077740ddfa22385d53700898ea325068ca4cc6b
Author: Pavel Machek <pavel@ucw.cz>
Date:   Thu Nov 25 14:14:04 2021 +0100

    Cherry pick 27c24fda62b6 ("Bluetooth: switch to lock_sock in SCO") to
    close CVE-2021-3640.

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 2f2b8ddc4dd5..cf165b0d15f2 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -93,10 +93,10 @@ static void sco_sock_timeout(struct work_struct *work)
=20
 	BT_DBG("sock %p state %d", sk, sk->sk_state);
=20
-	bh_lock_sock(sk);
+	lock_sock(sk);
 	sk->sk_err =3D ETIMEDOUT;
 	sk->sk_state_change(sk);
-	bh_unlock_sock(sk);
+	release_sock(sk);
=20
 	sock_put(sk);
 }
@@ -193,10 +193,10 @@ static void sco_conn_del(struct hci_conn *hcon, int e=
rr)
=20
 	if (sk) {
 		sock_hold(sk);
-		bh_lock_sock(sk);
+		lock_sock(sk);
 		sco_sock_clear_timer(sk);
 		sco_chan_del(sk, err);
-		bh_unlock_sock(sk);
+		release_sock(sk);
 		sock_put(sk);
 	}
=20
@@ -1108,10 +1108,10 @@ static void sco_conn_ready(struct sco_conn *conn)
=20
 	if (sk) {
 		sco_sock_clear_timer(sk);
-		bh_lock_sock(sk);
+		lock_sock(sk);
 		sk->sk_state =3D BT_CONNECTED;
 		sk->sk_state_change(sk);
-		bh_unlock_sock(sk);
+		release_sock(sk);
 	} else {
 		sco_conn_lock(conn);
=20
@@ -1126,12 +1126,12 @@ static void sco_conn_ready(struct sco_conn *conn)
 			return;
 		}
=20
-		bh_lock_sock(parent);
+		lock_sock(parent);
=20
 		sk =3D sco_sock_alloc(sock_net(parent), NULL,
 				    BTPROTO_SCO, GFP_ATOMIC, 0);
 		if (!sk) {
-			bh_unlock_sock(parent);
+			release_sock(parent);
 			sco_conn_unlock(conn);
 			return;
 		}
@@ -1152,7 +1152,7 @@ static void sco_conn_ready(struct sco_conn *conn)
 		/* Wake up parent */
 		parent->sk_data_ready(parent);
=20
-		bh_unlock_sock(parent);
+		release_sock(parent);
=20
 		sco_conn_unlock(conn);
 	}


--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYaCwzwAKCRAw5/Bqldv6
8sYBAJ9FX+6foRN/4SEVReMxqrgE+NxS3QCeKNWxqj8JIufHf7kQOCIndSzqxSM=
=lDYx
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--

