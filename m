From: pavel@denx.de (Pavel Machek)
Date: Wed, 5 Feb 2020 23:39:41 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 00/14] Renesas RZ/G2 extend
	peripheral support
In-Reply-To: <OSAPR01MB3667E28321D0C1E814401CA892030@OSAPR01MB3667.jpnprd01.prod.outlook.com>
References: <1580560022-26873-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200202184325.GA1870@duo.ucw.cz>
 <OSAPR01MB3667E28321D0C1E814401CA892030@OSAPR01MB3667.jpnprd01.prod.outlook.com>
Message-ID: <20200205223940.GA26511@duo.ucw.cz>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> > > From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > >
> > > This patch series adds support for for following peripherals supported
> > > by RZ/G2N:
> > > 1] I2C and IIC-DVFS
> > > 2] OPP's table for CPU nodes
> > > 3] Thermal zones
> > > 4] CMT and TMU
> > >
> > > This patch series is based on linux-4.19.y-cip and all the patches in
> > > this series are cherry-picked from upstream.
> > 
> > Looks good to me. I can apply it if there are no objections.
> 
> Looks good to me, too.
> Pavel, please apply this series.

Thanks for the series. Tests seem to pass, so applied.

https://gitlab.com/cip-project/cip-kernel/linux-cip/commit/6620dd338cfe63ffd0b9e3347b22880c2a58ea46/pipelines?ref=ci%2Fpavel%2Flinux-cip

Best regards,
								Pavel

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 195 bytes
Desc: not available
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20200205/4d29c96a/attachment.sig>
