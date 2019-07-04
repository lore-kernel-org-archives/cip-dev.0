From: pavel@denx.de (Pavel Machek)
Date: Thu, 4 Jul 2019 20:20:42 +0200
Subject: [cip-dev] [ANNOUNCE] v4.19.50-cip3-rt1
In-Reply-To: <d3b02a62-7931-17aa-ea81-e7a3554346ee@siemens.com>
References: <20190623203704.GA12734@amd> <20190628125904.GA24508@amd>
	<d3b02a62-7931-17aa-ea81-e7a3554346ee@siemens.com>
Message-ID: <20190704182042.GA4117@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> >4.19.50-cip3-rt1 should be available at kernel.org. I did limited
> >testing, but it seems to have some bugs fixed relative to
> >4.19.13-cip1-rt1. (Boots on x86-32 and cyclictest on iwg20m does not
> >hit WARN_ON).
> >
> >Trees are available at
> >
> >https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.19.y-cip-rt-rebase
> >
> >https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.19.y-cip-rt
> >
> >And their content should be identical.
> >
> 
> Shouldn't this be 4.19.50-cip3-rt2? It's the second -rt release for 4.19-cip.

Its first realtime release based on 4.19.50-cip3 :-). It is also based
on 4.19.50-rt22. So yes, the naming is a bit confusing.

If such version would previously be named -rt2, I'll obviously need to
fix it.

Best regards,
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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190704/080465ba/attachment.sig>
