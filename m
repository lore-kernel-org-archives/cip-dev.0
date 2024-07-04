Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B989C30653
	for <webhook@archiver.kernel.org>; Thu,  4 Jul 2024 19:25:02 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.2818.1720121100725435377
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Jul 2024 12:25:01 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 1BAC31C0098; Thu,  4 Jul 2024 21:24:57 +0200 (CEST)
Date: Thu, 4 Jul 2024 21:24:56 +0200
From: Pavel Machek <pavel@denx.de>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: Request for reviews for 4.4-st54, 4.4-cip89
Message-ID: <Zob3CMMN5xTB21pM@duo.ucw.cz>
References: <729272238.766733.1719933056170@webmail.strato.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FNmZO+IBvNUdI+l/"
Content-Disposition: inline
In-Reply-To: <729272238.766733.1719933056170@webmail.strato.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Jul 2024 19:25:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16375


--FNmZO+IBvNUdI+l/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Here's the manual backports to review for the next 4.4 release which, as =
always, can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip=
/linux-cip.git/log/?h=3Dlinux-4.4.y-st-rc
>

Thanks for series. This one is a bit crazy, and wrong. Crazy because
it moves code for staging, and wrong because... it turns -ERANGE into
success. It should use 6.1 version of param_set_uint_minmax AFAICT.

+int param_set_uint_minmax(const char *val, const struct kernel_param *kp,
+               unsigned int min, unsigned int max)
+{
+       unsigned int num;
+       int ret;
+
+       if (!val)
+               return -EINVAL;
+       ret =3D kstrtouint(val, 0, &num);
+       if (ret =3D=3D -EINVAL || num < min || num > max)
+               return -EINVAL;
+       *((unsigned int *)kp->arg) =3D num;
+       return 0;
+}
+EXPORT_SYMBOL_GPL(param_set_uint_minmax);


 ** m | 459de98d7 2a14c9 o  | params: lift param_set_uint_minmax to
    common code

The reset is okay AFAICT.=20

a | 62a95de44 30a92c o+ | openvswitch: Set the skbuff pkt_type for proper p=
mtud support.
a | 85b6bcf9d 52a2f0 o+ | net: usb: smsc95xx: fix changing LED_SEL bit valu=
e updated from EEPROM
a | 0049a623d b3dc6e o+ | ipvlan: Dont Use skb->sk in ipvlan_process_v{4,6}=
_outbound
a | 822ae5a8e f5d4e0 o+ | nilfs2: fix use-after-free of timer for log write=
r thread
a | f6141cbc2 1cd4bc o+ | vxlan: Fix regression when dropping packets due t=
o invalid src addresses
a | 1ea3de272 1ed447 o  | media: v4l2-core: hold videodev_lock until dev re=
g, finishes
a | 3c9ee8294 dfe6d1 o+ | KVM: arm64: Allow AArch32 PSTATE.M to be restored=
 as System mode
a | 72c5d8e41 25460d o+ | net/9p: fix uninit-value in p9_client_rpc()

Best regards,
							Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--FNmZO+IBvNUdI+l/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZob3CAAKCRAw5/Bqldv6
8vF5AKCCuhyBG8NGiB2Hp9VIZVqJbC44vQCfZOPhoyly0gZ6mbU69VW5A+j01zQ=
=Lz75
-----END PGP SIGNATURE-----

--FNmZO+IBvNUdI+l/--

