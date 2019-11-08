From: pavel@denx.de (Pavel Machek)
Date: Fri, 8 Nov 2019 12:32:09 +0100
Subject: [cip-dev] [PATCH 4.4.y-cip 00/83] Add RZ/G1C SD/eMMC support
In-Reply-To: <TYAPR01MB2285DD15243063CDEA363B91B77B0@TYAPR01MB2285.jpnprd01.prod.outlook.com>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
	<20191107210149.GA26444@amd>
	<TYAPR01MB2285DD15243063CDEA363B91B77B0@TYAPR01MB2285.jpnprd01.prod.outlook.com>
Message-ID: <20191108113209.GQ1017@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> Thank you for your work on reviewing this series.

(For the record, I'm now done with the review... with exception of
renames&modifications in 66-69).

> Looking at some of your comments, it looks like there are lots of issues to do with the original patches that were upstreamed, rather than changes that were made specifically for the CIP Kernel.
> 
> My understanding is that the CIP project follows an upstream first policy, i.e. code must all be upstreamed before being backported to the CIP kernel(s).
> 
> For the changes that you're pointing out, should we be upstreaming the relevant fixes, waiting for them to be released upstream, then re-submitting the whole patch series? Or should we be modifying the patches that we're submitting to the CIP kernel directly?
>

It really depends on case by case basis -- on severity of the problem.

I can take explanations, maybe I'm just misunderstanding the code.

Or perhaps code is really right, but unclear/needs additional comment,
etc... In such case I guess we can take patch as is, and just queue
cleanups/comments to the mainline.

But patch 34/ introduces data corrupting bug, which is only fixed at
the end of the series. I'd prefer having patches changed / reshuffled
/ something so that it does not corrupt someone's data during bisect.

Plus we need to figure out how to review the renames.

> If the former, I'm not actually sure this will always be technically possible.
> If the latter, do you want Biju to update each of the patches in his series? Or submit the new cip-specific changes in a new patch?
>

Not sure really.

One possible way forward would be to submit 1..33/ as separate series,
then figure out 34.. first rename, then figure out the rest.

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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191108/3e8f4f47/attachment.sig>
