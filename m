From: pavel@denx.de (Pavel Machek)
Date: Sun, 23 Jun 2019 22:37:04 +0200
Subject: [cip-dev] [RFC/RFT] -cip-rt kernels for review/testing
Message-ID: <20190623203704.GA12734@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

I played a bit with -rt kernels, and here are the results.

v4.19.50-rt22-cip3-rebase was reasonably easy to do, as -cip1 was
empty. v4.4.179-rt181-cip34-rebase was more interesting.

Trees are at kernel.org:

https://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-cip.git/log/?h=v4.4.179-rt181-cip34-rebase
https://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-cip.git/log/?h=v4.19.50-rt22-cip3-rebase

Basically untested. Could I ask for reviews and testing?

I know that full preemption does not work on x86-32. I sent
"PREEMPT_RT_FULL on x86-32 machine" mail to the lists

I don't know how to release useful non-rebasing trees. Is someone
using those?

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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190623/bb4ed075/attachment.sig>
