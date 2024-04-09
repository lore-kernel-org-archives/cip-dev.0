Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443F6C67861
	for <webhook@archiver.kernel.org>; Tue,  9 Apr 2024 09:15:19 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.131674.1712654117136333069
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Apr 2024 02:15:17 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 943381C0080; Tue,  9 Apr 2024 11:15:13 +0200 (CEST)
Date: Tue, 9 Apr 2024 11:15:13 +0200
From: Pavel Machek <pavel@denx.de>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "pavel@denx.de" <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: Request for reviews for 4.4-st51, 4.4-cip86
Message-ID: <ZhUHIa7hW+5VNtEY@duo.ucw.cz>
References: <1155634901.1549797.1712565256786@webmail.strato.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xZXhVk3vxxPQffh8"
Content-Disposition: inline
In-Reply-To: <1155634901.1549797.1712565256786@webmail.strato.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 09 Apr 2024 09:15:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15510


--xZXhVk3vxxPQffh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Here's the manual backports to review for the next 4.4 release which, as =
always, can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip=
/linux-cip.git/log/?h=3Dlinux-4.4.y-st-rc :
>

Thanks for patches, they look ok to me. I'd not bother with GFP_KERNEL
fails, printk and READ_ONCE stuff, as they are not user-triggerable
or not really serious bugs, but this is within what stable does.

Best regards,
								Pavel

a | 575689f40 1eecc7 o+ | net: lan78xx: fix runtime PM count underflow on l=
ink stop
a | 98db42191 767146 o+ | netfilter: nf_conntrack_h323: Add protection for =
bmp length out of range
a does that mean we only moved lockup to the unlikely case? | c96f49d3a f7e=
c1c o  | getrusage: use sig->stats_lock rather than lock_task_sighand()
a GFP_KERNEL never fails, anyway | 70a33a629 3693bb .  | x86/xen: Add some =
null pointer checking to smp.c
a driver uses -EFAULT wrongly | 6cc96148d ee0017 o  | scsi: mpt3sas: Preven=
t sending diag_reset when the controller is ready
a just a printk fix | a215f042a 963465 o  | Input: gpio_keys_polled - suppr=
ess deferred probe error for gpio
a just a printk fix | d619f175f 96e202 .  | ASoC: wm8962: Fix up incorrect =
error message in wm8962_set_fll
a just a _ONCE annotation | cffd4a7c9 efd402 o+ | sock_diag: annotate data-=
races around sock_diag_handlers[family]
a | 085f36c31 167faa o  | media: dvbdev: Fix memleak in dvb_register_device
a | d0f5c2833 8c64f4 o+ | media: edia: dvbdev: fix a use-after-free
a | 578eb0d0f 0f7352 F+ | wifi: brcmfmac: Fix use-after-free bug in brcmf_c=
fg80211_detach
a | 1fac009e1 3d75b8 o+ | KVM: Always flush async #PF workqueue when vCPU i=
s being destroyed
a just a preparation | dbc478390 097d9d o  | PCI: Drop pci_device_remove() =
test of pci_dev->driver
a | 8ef8bdb2b 269cdf o+ | nilfs2: prevent kernel bug at submit_bh_wbc()
a | 114fd53bc 6b959b o  | perf/core: Fix reentry problem in perf_output_rea=
d_group()
a looks tricky | 1830e5b0b f45812 o  | efivarfs: Request at most 512 bytes =
for variable names

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--xZXhVk3vxxPQffh8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZhUHIQAKCRAw5/Bqldv6
8pjvAJ9Q2hqC7jFKkuZ5eUNiJr3pF6ivEgCcCM7OEBc73JEMKeGwo5oXAfwfvRw=
=JIeP
-----END PGP SIGNATURE-----

--xZXhVk3vxxPQffh8--

