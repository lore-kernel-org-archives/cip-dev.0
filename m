Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C03EC433F5
	for <webhook@archiver.kernel.org>; Wed, 17 Nov 2021 18:09:22 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.10974.1637172560483033828
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Nov 2021 10:09:21 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id DCAD01C0B76; Wed, 17 Nov 2021 19:09:09 +0100 (CET)
Date: Wed, 17 Nov 2021 19:09:08 +0100
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: pavel@denx.de, cip-dev@lists.cip-project.org, uli@fpond.eu,
	jan.kiszka@siemens.com, masami.ichikawa@cybertrust.co.jp
Subject: Re: New kernel patches review management
Message-ID: <20211117180908.GB32434@amd>
References: 
 <TYAPR01MB6252AE15ABA567A3301A9F4992949@TYAPR01MB6252.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xo44VMWPx7vlQ2+2"
Content-Disposition: inline
In-Reply-To: 
 <TYAPR01MB6252AE15ABA567A3301A9F4992949@TYAPR01MB6252.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Nov 2021 18:09:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6947


--xo44VMWPx7vlQ2+2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I considered using the gitlab wiki to switch the current patch review
> management to another.
>=20
> The gitlab wiki can be used as a regular git repository and can be
> viewed from his browser by writing its contents in markdown.
>=20
>   e.g. git clone git@gitlab.com:cip-project/cip-kernel/linux-cip.wiki.git

This looks good.

> It can be created using the API on the project wiki[0]. Since
> namespaces are available, we can also create hierarchies such as
> 5.10.y/v5.10.77 [1].
> The wiki page is first filled with the commit ID, then the CIP kernel
> developer writes the name after the commit they plan to review.

I believe this is too simple. We should include patch titles, so that
it is easier to review whole series. I also believe we should include
related patches from 4.19/4.4, so that they are reviewed together with
corresponding 5.10 change.

I'm currently using this format, and scripts to generate it are
already in the repository. Could we use that for review management,
too?
                            v-- patch title
                      v-- stable tree version
                   v-- "o" means we are building it in some
		       configuration, " " means likely not relevant to us
            v-- stable commit id, not quite reliable
  v-- upstream commit id
 |50d50ca00 88c42f  : 5.10| perf bpf: Add missing free to bpf_event__print_=
bpf_prog_info()
 |51444729b 8ac9df o: 5.10| llc: fix out-of-bound array index in llc_sk_dev=
_hash()
 |df8fa74a0 8ac9df o: 4.19| llc: fix out-of-bound array index in llc_sk_dev=
_hash()
 |bf70e4f7d 8ac9df o: 4.4| llc: fix out-of-bound array index in llc_sk_dev_=
hash()
 |3dd3e81ad 9fec40 .: 5.10| nfc: pn533: Fix double free when pn533_fill_fra=
gment_skbs() fails
 |b5cb963e8 9fec40 .: 4.19| nfc: pn533: Fix double free when pn533_fill_fra=
gment_skbs() fails
 |21e4958e2 9fec40 .: 4.4| nfc: pn533: Fix double free when pn533_fill_frag=
ment_skbs() fails
 |2a126e22e c7c386 o: 5.10| arm64: pgtable: make __pte_to_phys/__phys_to_pt=
e_val inline functions
 |f9ee3718b c7c386 o: 4.19| arm64: pgtable: make __pte_to_phys/__phys_to_pt=
e_val inline functions
 |78570c445 b8b831 .: 5.10| bpf, sockmap: Remove unhash handler for BPF soc=
kmap usage
 |dbe525054 e0dc3b o: 5.10| bpf: sockmap, strparser, and tls are reusing qd=
isc_skb_cb and colliding
 |c45dfa514 1c360c .: 5.10| gve: Fix off by one in gve_tx_timeout()
 |3737feeca 10a6de o: 5.10| seq_file: fix passing wrong private data
 |614a5f5c0 6dc254 .: 5.10| net/sched: sch_taprio: fix undefined behavior i=
n ktime_mono_to_any
 |25381c855 e140c7 .: 5.10| net: hns3: fix kernel crash when unload VF whil=
e it is being reset
 |14ec321cf 688db0 .: 5.10| net: hns3: allow configure ETS bandwidth of all=
 TCs
 |379d4165f f64ab8 o: 5.10| net: stmmac: allow a tc-taprio base-time of zero
 |3772974cc c7cd82 o: 5.10| vsock: prevent unnecessary refcnt inc for nonbl=
ocking connect
 |69eb06075 c7cd82 o: 4.19| vsock: prevent unnecessary refcnt inc for nonbl=
ocking connect
 |5a54ee129 c7cd82 o: 4.4| vsock: prevent unnecessary refcnt inc for nonblo=
cking connect
 |6ecbca5bf e5d5aa .: 5.10| net/smc: fix sk_refcnt underflow on linkdown an=
d fallback
 |38bf1ce3e 4ca110 o: 5.10| cxgb4: fix eeprom len when diagnostics not impl=
emented
 |41a958b00 4ca110 o: 4.19| cxgb4: fix eeprom len when diagnostics not impl=
emented

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--xo44VMWPx7vlQ2+2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmGVRUQACgkQMOfwapXb+vLjXACfbIqa9HiNqlxEYsGP6ygMGz/X
2+wAnRlXmdpOn7bp+EoRWoYfWmx6Q2YD
=FqrL
-----END PGP SIGNATURE-----

--xo44VMWPx7vlQ2+2--

