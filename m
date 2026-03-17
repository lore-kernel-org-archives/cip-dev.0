Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B58EFD7099
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 20:21:23 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.86203.1773778879038520295
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Mar 2026 13:21:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=j8I7D2Vs;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1096210CFB3;
	Tue, 17 Mar 2026 21:21:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1773778876;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=e8dvM6XGRbE3Kz/lZ13do9r+yEfQXPQWLekrUONlLxI=;
	b=j8I7D2VsVuWxfNOdQJ0B2l33si9i+gqLMn4wewC+eb9ogjiyiMrFXxcpV+RJEmo8jFYdgP
	2C2ebmfzdNCNKQudxqyxLcBeZ2kWXgbqJ0eXQB1a6sik3sZzsdC05prXH6fhXyyorCe5Y/
	9iHxR1DYMjOIW7yXFXLyRaAjefF9DOirPnazzrTSg/4WQNfRVQ/JO2OYml+mPl2N5sn+kG
	2d8c+mtIgpBQjqcwPB2FLL1eRAOrZWwtX7JiJJ0iJi4ixEVjQGWlbYREN/IkIUSX9+6DtX
	f30C3E9TnuwiLg1FpmrMhY62P3qZ2Zxwa5krA88zC/SWW1XGKwisPOpQf07TnA==
Date: Tue, 17 Mar 2026 21:21:11 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Chris Paterson <Chris.Paterson2@renesas.com>
Cc: "nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	uli <uli@fpond.eu>
Subject: Re: [ANNOUNCE] Release v5.10.251-cip70
Message-ID: <abm3t5Ru21AyjXlP@duo.ucw.cz>
References: <TY7PR01MB14818C5A866AAFB66A71EA103CD45A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <OSZPR01MB81230F9D0E8455689D3C7A1FB741A@OSZPR01MB8123.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rZHrm0CdQJ4mI9l/"
Content-Disposition: inline
In-Reply-To: <OSZPR01MB81230F9D0E8455689D3C7A1FB741A@OSZPR01MB8123.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 20:21:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22490


--rZHrm0CdQJ4mI9l/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > CIP kernel team has released Linux kernel v5.10.251-cip70.
> > The linux-5.10.y-cip tree has been updated base version from v5.10.249 =
to
> > v5.10.251.
>=20
> Our KernelCI pipeline has reported a build issue for this release:
> https://dashboard.kernelci.org/tree/cip/linux-5.10.y-cip/99e8b9912822c35e=
388d236d0aadca61195f75e6
>=20
> Specifically, the riscv cip_merged_defconfig build has " error: =E2=80=98=
phys_ram_base=E2=80=99 undeclared (first use in this function) "
> https://dashboard.kernelci.org/build/maestro%3A69b3acb5e8c48c93579bdc61
> https://dashboard.kernelci.org/issue/maestro%3A51c12e2d53ea10cd0ae264568f=
82d96b2dbc0245?iv=3D1
>

Let me take a look:

=2E/arch/riscv/include/asm/pgtable.h:47:58: error: =E2=80=98phys_ram_base=
=E2=80=99
undeclared (first use in this function) in init/initramfs.o
(init/initramfs.c) [logspec:kbuild,kbuild.compiler.error]

That should be this line:

9f40b6e77d2f888 (Atish Patra       2020-02-24 11:34:36 -0800  46)  */
8af1c121b010204 (Dimitris Vlachos  2024-02-29 21:17:23 +0200  47) #define v=
memmap               ((struct page *)VMEMMAP_START - (phys_ram_base >> PAGE=
_SHIFT))
9f40b6e77d2f888 (Atish Patra       2020-02-24 11:34:36 -0800  48)=20

And this is the blamed commit. But... that's from 2024.

commit 8af1c121b0102041809bc137ec600d1865eaeedd
Author: Dimitris Vlachos <dvlachos@ics.forth.gr>
Date:   Thu Feb 29 21:17:23 2024 +0200

    riscv: Sparse-Memory/vmemmap out-of-bounds fix
   =20
    [ Upstream commit a11dd49dcb9376776193e15641f84fcc1e5980c9 ]
   =20
    Offset vmemmap so that the first page of vmemmap will be mapped
    to the first page of physical memory in order to ensure that
    vmemmap=E2=80=99s bounds will be respected during
    pfn_to_page()/page_to_pfn() operations.
    The conversion macros will produce correct SV39/48/57 addresses
    for every possible/valid DRAM_BASE inside the physical memory limits.
   =20
=2E..
    Fixes: d95f1a542c3d ("RISC-V: Implement sparsemem")
=2E..

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgta=
ble.h
index b16304fdf44898..5ab13570daa537 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -44,7 +44,7 @@
  * Define vmemmap for pfn_to_page & page_to_pfn calls. Needed if kernel
  * is configured with CONFIG_SPARSEMEM_VMEMMAP enabled.
  */
-#define vmemmap                ((struct page *)VMEMMAP_START)
+#define vmemmap                ((struct page *)VMEMMAP_START - (phys_ram_b=
ase >> PAGE_SHIFT))

I don't see anything obvious at the moment. Was v5.10.249-cip69 ok in
the same test? Would it be possible to test v5.10.250, v5.10.251?

Thanks and best regards,
								Pavel

--rZHrm0CdQJ4mI9l/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCabm3twAKCRAw5/Bqldv6
8uohAJ9aySPOEMAmjHL9bm7S49Qs9n/QSQCfSEbZqNwHj6nIt4PhVTkZHPLADCQ=
=Q+iP
-----END PGP SIGNATURE-----

--rZHrm0CdQJ4mI9l/--

