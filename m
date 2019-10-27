From: pavel@denx.de (Pavel Machek)
Date: Sun, 27 Oct 2019 08:47:40 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 49/57] ASoC: rsnd: src: fix
	compiler warnings
In-Reply-To: <1571295929-47286-50-git-send-email-biju.das@bp.renesas.com>
References: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
	<1571295929-47286-50-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20191027074740.GC28383@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> From: Jiada Wang <jiada_wang@mentor.com>
> 
> commit 399706df420ea8bc8b31283a919e6475f737d0ea upstream.
> 
> compiler complains about following declarations
> 
> sound/soc/sh/rcar/src.c:174:1: warning: 'static' is not at beginning of declaration [-Wold-style-declaration]
>  const static u32 bsdsr_table_pattern1[] = {

I'd prefer this to be need the patch it fixes, too.

Thanks,
								Pavel
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191027/45aee3e2/attachment.sig>
