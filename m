Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B365C4167B
	for <webhook@archiver.kernel.org>; Fri,  8 Dec 2023 12:10:03 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.30878.1702037402214289545
 for <cip-dev@lists.cip-project.org>;
 Fri, 08 Dec 2023 04:10:02 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id BA4D01C0080; Fri,  8 Dec 2023 13:09:59 +0100 (CET)
Date: Fri, 8 Dec 2023 13:09:59 +0100
From: Pavel Machek <pavel@denx.de>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "pavel@denx.de" <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: Request for reviews for 4.4-st47, 4.4-cip82
Message-ID: <ZXMHlwmUqhF+8bsv@duo.ucw.cz>
References: <1721610604.312805.1701935625001@webmail.strato.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="D1UpYCLSPOCchyNs"
Content-Disposition: inline
In-Reply-To: <1721610604.312805.1701935625001@webmail.strato.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Dec 2023 12:10:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13937


--D1UpYCLSPOCchyNs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Here are the manual backports for the upcoming 4.4-st47 and 4.4-cip82 rel=
eases that should be reviewed and that can currently be found in
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=
=3Dlinux-4.4.y-st-rc

Thanks for doing this. I went through the patches, and they look ok to me.

a -| 6112a326f a5feba o+ | r8152: Increase USB control msg timeout to 5000m=
s as per spec
a| 75e4376b6 128b0c o+ | x86/i8259: Skip probing when ACPI/MADT advertises =
PCAT compatibility
a  | 3b6a41708 0618c0 .  | dmaengine: ste_dma40: Fix PM disable depth imbal=
ance in d40_probe
a -| 568e546fc 081480 o+ | tcp_metrics: properly set tp->snd_ssthresh in tc=
p_init_metrics()
a -| eef0a4b2e 3391ee .+ | wifi: rtlwifi: fix EDCA limit set by BT coexiste=
nce
a just a robustness  m-| e3ced1fe3 a5d14f .+ | clk: keystone: pll: fix a co=
uple NULL vs IS_ERR() checks
a -| 2b391eb17 974757 .+ | USB: usbip: fix stub_dev hub disconnect
a  | 6744008c3 19b3f7 o+ | tipc: Change nla_policy for bearer-related names=
 to NLA_NUL_STRING
a  | 33690eb1a dec96f o+ | btrfs: use u64 for buffer sizes in the tree sear=
ch ioctls
a -| e52e324a2 760efb f  | drm/amd: Fix UBSAN array-index-out-of-bounds for=
 SMU7
a  | 930f0aaba 4df105 o  | scsi: libfc: Fix potential NULL pointer derefere=
nce in fc_lport_ptp_setup()
a -| 69bba6260 099be1 .  | media: gspca: cpia1: shift-out-of-bounds in set_=
flicker
a -| 01d004afb 2770d4 o  | KVM: x86: Ignore MSR_AMD64_TW_CFG access
a +| 5f4531a12 5fba5a o  | btrfs: fix off-by-one when checking chunk map in=
cludes logical address


Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--D1UpYCLSPOCchyNs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZXMHlwAKCRAw5/Bqldv6
8h7iAKCc7rT9z0Vk2okGXrlagQu2uiLKbwCdF4YUGRsb+8v6c4aJIJz2t1Svt0Y=
=tmBi
-----END PGP SIGNATURE-----

--D1UpYCLSPOCchyNs--

