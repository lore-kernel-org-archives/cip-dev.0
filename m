From: pavel@denx.de (Pavel Machek)
Date: Tue, 16 Jul 2019 22:14:31 +0200
Subject: [cip-dev] [ANNOUNCE] 4.4.176-cip31-rt23
In-Reply-To: <58c8af26-00ce-827d-999f-ccd545a0d974@monom.org>
References: <20190329110611.1B897500722@mail.monom.org>
	<a86d4f19-790d-58ab-94b4-523a759d87b4@siemens.com>
	<20190715134336.GB16268@amd>
	<58c8af26-00ce-827d-999f-ccd545a0d974@monom.org>
Message-ID: <20190716201431.GA9557@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> >>Is there a chance to update 4.4-rt based on Daniel' 4.4.179-rt181 release, but
> >>then to 4.4.182 in order to have SACK fixes in?
> >
> >Do you want 4.4.184, too, which fixes the SACK fixes? :-).
> >
> >I'm up-to 4.4.179-rt181-cip32.
> >
> >If I attempt to move forward to 4.4.181-cip3, I get some conflicts in
> >rather core files.
> >
> >Auto-merging kernel/cpu.c
> >CONFLICT (content): Merge conflict in kernel/cpu.c
> >Auto-merging include/linux/sched.h
> >CONFLICT (content): Merge conflict in include/linux/sched.h
> >Auto-merging arch/x86/include/asm/thread_info.h
> >CONFLICT (content): Merge conflict in
> >
> >I can attempt something, but I'd feel safer waiting for -stable-rt to
> >solve it for me.
> 
> FWIW, I am updating the stable-rt tree right now. As noted there are a
> couple of merge conflicts ahead. Right now I am testing the result of the
> v4.4.180 merge. So far all looks good and now I am waiting for the test
> results from the CI system. After that I keep merging.

Thanks for good news. You have privat CI system, right?

If sources are available somewhere, I can try to help with testing.

Best regards,
								Pavl
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190716/dd18a9fc/attachment.sig>
