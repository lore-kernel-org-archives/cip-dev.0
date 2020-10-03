Return-Path: <SRS0=qmG9=DK=lists.cip-project.org=bounce+64572+5492+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80491C41604
	for <cip-dev@archiver.kernel.org>; Sat,  3 Oct 2020 15:17:54 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E87720709
	for <cip-dev@archiver.kernel.org>; Sat,  3 Oct 2020 15:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="ScBpalvU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E87720709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5492+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id b0nHYY4521723xW1jANZuVFi; Sat, 03 Oct 2020 08:17:52 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.9043.1601738271231776013
 for <cip-dev@lists.cip-project.org>;
 Sat, 03 Oct 2020 08:17:51 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 95A321C0B7D; Sat,  3 Oct 2020 17:17:45 +0200 (CEST)
Date: Sat, 3 Oct 2020 17:17:45 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: cip-dev@lists.cip-project.org
Subject: [cip-dev] arm64/renesas test failing for v4.19.148-cip35-rt15 (-rt64)
Message-ID: <20201003151745.GA1399@duo.ucw.cz>
MIME-Version: 1.0
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: vW2WLTP3zmJ6Zlgz7nycpmbjx4520388AA=
Content-Type: multipart/mixed; boundary="lweM2jk7hHs9dZhQSlZc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1601738272;
 bh=d8FRI0DhpnzPjuHdStzGlQUMyP5KOuxC71YpHJe9Y98=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=ScBpalvUshuHN2EQfWcVtMhnX4f+BkabUSaokpuE4qPzd5GcdNH54tx8LPaocbdl1jS
 4u4RezT2Ns61GY4V+Jlg66FXHf+Yx+FynavM7E1uQUp4eyt9t+Ct1eVU7ZuhrHVOcbGe9
 /MvIYnzeERkumiir7VW5Rj+XqlaU49rETQA=

--lweM2jk7hHs9dZhQSlZc
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline

--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I got test failure when I submitted -rt branch for testing.

https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/197703780

This seems to be "real" failure:

[    2.791351] asoc-audio-graph-card sound: ASoC: no DMI vendor name!
[    2.798301] [drm] Cannot find any crtc or sizes
[    2.805866] hctosys: unable to open rtc device (rtc0)
[    2.811937] libphy: ravb_mii: probed
[    2.821001] RTL8211E Gigabit Ethernet e6800000.ethernet-ffffffff:00: att=
ached PHY driver [RTL8211E Gigabit Ethernet] (mii_bus:phy_addr=3De6800000.e=
thernet-ffffffff:00, irq=3D190)
[    2.838052] RTL8211E Gigabit Ethernet e6800000.ethernet-ffffffff:00: Mas=
ter/Slave resolution failed, maybe conflicting manual settings?
[   12.841484] Waiting up to 110 more seconds for network.
[   22.853482] Waiting up to 100 more seconds for network.
[   32.865482] Waiting up to 90 more seconds for network.
[   42.877482] Waiting up to 80 more seconds for network.
[   52.889482] Waiting up to 70 more seconds for network.
[   62.901482] Waiting up to 60 more seconds for network.
[   72.913482] Waiting up to 50 more seconds for network.
[   82.925482] Waiting up to 40 more seconds for network.
[   92.937482] Waiting up to 30 more seconds for network.
[  102.949482] Waiting up to 20 more seconds for network.
[  112.961482] Waiting up to 10 more seconds for network.
[  122.861490] Sending DHCP requests ...... timed out!
[  209.890289] IP-Config: Retrying forever (NFS root)...
[  209.895535] libphy: ravb_mii: probed
[  209.899386] mdio_bus e6800000.ethernet-ffffffff: MDIO device at address =
0 is missing.
[  209.910604] ravb e6800000.ethernet eth0: failed to connect PHY
[  209.916705] IP-Config: Failed to open eth0
[  219.925483] Waiting up to 110 more seconds for network.
[  229.937481] Waiting up to 100 more seconds for network.
[  239.949481] Waiting up to 90 more seconds for network.
[  249.961481] Waiting up to 80 more seconds for network.

With no network, it is easy to understand that tests would fail.

x86_siemens, OTOH, seems to be infrastructure error
(bootloader-interrupt timed out after 599 seconds).

Let me investigate it some more.

Best regards,
							Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX3iWGQAKCRAw5/Bqldv6
8lSjAKCk4PI6xYwc2wr2aVf7ULWQhNWaOACgsAl5MwA8HdNpOSjtXq/YdTFXEnc=
=qlq5
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--

--lweM2jk7hHs9dZhQSlZc
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5492): https://lists.cip-project.org/g/cip-dev/message=
/5492
Mute This Topic: https://lists.cip-project.org/mt/77282618/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--lweM2jk7hHs9dZhQSlZc--
