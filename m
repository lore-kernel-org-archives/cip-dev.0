From: pavel@denx.de (Pavel Machek)
Date: Fri, 28 Jun 2019 14:59:05 +0200
Subject: [cip-dev] [ANNOUNCE] v4.19.50-cip3-rt1
In-Reply-To: <20190623203704.GA12734@amd>
References: <20190623203704.GA12734@amd>
Message-ID: <20190628125904.GA24508@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

4.19.50-cip3-rt1 should be available at kernel.org. I did limited
testing, but it seems to have some bugs fixed relative to
4.19.13-cip1-rt1. (Boots on x86-32 and cyclictest on iwg20m does not
hit WARN_ON). 

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.19.y-cip-rt-rebase

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.19.y-cip-rt

And their content should be identical.

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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190628/a63beb23/attachment.sig>
