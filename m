Return-Path: <SRS0=I6op=64=lists.cip-project.org=bounce+64572+4621+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C28DC433DF
	for <cip-dev@archiver.kernel.org>; Thu, 14 May 2020 21:56:00 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B3A820748
	for <cip-dev@archiver.kernel.org>; Thu, 14 May 2020 21:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="LTf8CxFi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B3A820748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4621+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id dzjWYY4521723xn4A4mf5qqz; Thu, 14 May 2020 14:55:59 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.2015.1589493357458628907
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 May 2020 14:55:58 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id B5FE11C0288; Thu, 14 May 2020 23:55:53 +0200 (CEST)
Date: Thu, 14 May 2020 23:55:52 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: cip-dev@lists.cip-project.org
Subject: [cip-dev] CVE-2020-12770: easy backport of sg code
Message-ID: <20200514215552.GA18872@amd>
MIME-Version: 1.0
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: kHzkL4yZKkQW0qzaxszp8Ig3x4520388AA=
Content-Type: multipart/mixed; boundary="n49P642GfU62cAb2pcFD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1589493359;
 bh=NpvSGobXvEuspn5fe4XZE/vPusCRu3XzpUyUPldU9xw=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=LTf8CxFiQZo39sb3xaP1TU0jW2JQ9P1qTb6Xly2GGYFjgVlo3V23B0heiOZmrQ3s/1u
 jJ7mlnzVGCjyauSpiK0DXJIxZkQq9RXvBzSWsNa6y7y9yaRIvg2mlR9kdnuiMNc2hzEiZ
 Daj6LUMgN5gHTcEdbxt3UQ6rv3CXUcX7FhI=

--n49P642GfU62cAb2pcFD
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline

--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

So let me investigate... Mainline fix is commit 83c6f2390040f188cc25b270b4b=
efeb5628c1aee.

Backport for 4.19 looks really easy, and I can't see anything wrong
there:

commit c45e3bcdebb204ef1ba1d00f41fe7ed39c4dd8cd
Author: Pavel Machek <pavel@ucw.cz>
Date:   Thu May 14 23:47:42 2020 +0200

    Backport.
   =20
    commit 83c6f2390040f188cc25b270b4befeb5628c1aee
    ...
        scsi: sg: add sg_remove_request in sg_write
   =20
        If the __copy_from_user function failed we need to call
        sg_remove_request
            in sg_write.
   =20
     Link: https://lore.kernel.org/r/610618d9-e983-fd56-ed0f-639428343af7@h=
uawei.com
     Acked-by: Douglas Gilbert <dgilbert@interlog.com>
     Signed-off-by: Wu Bo <wubo40@huawei.com>
     Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 8a254bb46a9b..4f00d3062bd6 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -694,8 +694,10 @@ sg_write(struct file *filp, const char __user *buf, si=
ze_t count, loff_t * ppos)
 	hp->flags =3D input_size;	/* structure abuse ... */
 	hp->pack_id =3D old_hdr.pack_id;
 	hp->usr_ptr =3D NULL;
-	if (__copy_from_user(cmnd, buf, cmd_size))
+	if (__copy_from_user(cmnd, buf, cmd_size)) {
+		sg_remove_request(sfp, srp);
 		return -EFAULT;
+	}
 	/*
 	 * SG_DXFER_TO_FROM_DEV is functionally equivalent to SG_DXFER_FROM_DEV,
 	 * but is is possible that the app intended SG_DXFER_TO_DEV, because there

And I don't see a problem with 4.4, either.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl69vmgACgkQMOfwapXb+vJT2QCfV2JAoFrdFwwVxwaISSw9YgIm
YwEAmwVKUxar4VUSh9u8bRIA8Gs7Iaqa
=wgdE
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--

--n49P642GfU62cAb2pcFD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4621): https://lists.cip-project.org/g/cip-dev/message=
/4621
Mute This Topic: https://lists.cip-project.org/mt/74215710/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--n49P642GfU62cAb2pcFD--
