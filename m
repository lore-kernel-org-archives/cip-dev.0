Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5309.1795179408782829320
 for <cip-dev@lists.cip-project.org>;
 Fri, 20 Nov 2026 04:56:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@codewreck.org header.s=2 header.b=zeqAT26b;
 spf=pass (domain: codewreck.org, ip: 62.210.214.84, mailfrom: asmadeus@codewreck.org)
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 2A3D614C2DE;
	Fri, 20 Nov 2026 13:56:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1795179405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VsV/cf9C0e4xQdiOW4a2wCsmrjB/JTEv348JTr7sj7U=;
	b=zeqAT26bWqQrFaHlHAwFIyUDteoxjr20O5ZENTbkZzGb2XMuaxMF/PnBU2nZVos/fXA3sJ
	IN37OX2lH5SNmZhAB0XAcwiLzYb5Ta7NcKeRJ91vElGiJG0EzP3D8mGBFALnb+hZR5bwxJ
	Y7fMZg/7G3K1CAW0GSWRW/lNlmsb+ISFO1GDUQgcht/5KyzoZfAMu6Ift/rh9EMFV261sq
	dOIkjXi2NWv5kzuxnRnSgWas20aARYR3b2mO9b3FYGe5GpqcNZ7bC9I53HYy5DfEXHUYBR
	XR6kgfGbeLcPwsVchuiV7mXgrsdCPzxyYPFdgVslXQo7kTEo9vYGGw6ZMgC9Kg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id af652a1a;
	Fri, 20 Nov 2026 12:56:42 +0000 (UTC)
Date: Fri, 20 Nov 2026 21:56:27 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: christoph.steiger@siemens.com
Cc: cip-dev@lists.cip-project.org,
	Akihito Irie <akihito.irie@atmark-techno.com>,
	Dominique Martinet <dominique.martinet@atmark-techno.com>,
	Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [cip-dev] Best practices to write CIP kernel details in a SBOM?
Message-ID: <awBDeyRZVzpnrQIy@codewreck.org>
References: <av-icExXuq2zIc1g@codewreck.org>
 <5a903376-5387-4836-9878-12db2e79afab@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5a903376-5387-4836-9878-12db2e79afab@siemens.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 20 Nov 2026 12:56:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25044

Christoph Steiger via cip-dev wrote on Fri, Nov 20, 2026 at 01:01:09PM +0100:
> > and since the linux upstream CVEs are fed to NVD/OSV databases then
> > scanners will pick up the many CVEs still affecting the releases, so one
> > can triage them and export the result as VEX as seems to be the current
> > best practices; but if we don't provide a VEX there doesn't seem to be
> > any way to describe the kernel version as e.g. v5.10.272-cip79 with all
> > the fixes covered by CIP automatically covered.
>
> It is true there currently is no globally understood way to reference CIP
> kernels. It would be simple enough to use something similar to the kernel
> e.g. pkg:generic/linux-cip-kernel@<version>. The second step would then be
> to start integration with all the scanners. I dont think there are currently
> any efforts in that direction though.

Right, just deciding on a pkg format won't do much unless we start using
it for data feeds scanners pick up, the question is how useful that
would be given the state most scanners are in...
Just adding pkg:generic/linux-kernel@<version> will make scanners report
hundreds of problems with no way to automatically filter out what isn't
built in or what isn't used, check by category etc; that needs specific
tooling.

But to be fair that's not a problem with the CIP kernel - the tools just
haven't caught up yet, and I'm not sure how much will be done by whom...

> > I've found about cip-kernel-sec[1] and kernel-cve-triage[2] and we can
> > use it to automatically check boxes in a VEX, but would it make sense to
> > publish this data as well somewhere so that "standard" scanners
> > (dependency-track/grype/osv-scanner/etc) automatically do it in the
> > first place?
> 
> Is there any information you are missing from the data published in
> cip-kernel-sec? It is not integrated with all the scanners, but I think
> everything that we need should already be public.

I honestly haven't spent enough time with it yet to say, sorry.

As far as data goes, it's even properly tracking CVEs introduced by
cip-specific backports (e.g. CVE-2025-38656), so it's really quite
good - thank you!
I'm curious about how we could track a vuln introduced by the backport
process itself (e.g. bringing in patch X without patch Y caused a bug
not present in any upstream kernel, thus without assigned CVE by the
kernel CNA), but I don't think there's much we can do about it, and it's
a bit off topic... :)

Since kernel-cve-triage makes use of "affected files" I assume the data
is not meant to be standalone, but to complete kernel's vulns.git that
has this info, is that correct?


But anyway, my problem isn't triaging locally than deciding what we want
to tell our users.
The main problem with local triage is that it only knows about the
vunlerabilities public at the time of the triage, our users need to have
enough information in the SBOM we publish to be able to reproduce the
triage and get useful information regarding new vulnerabilities that
came out after we published our data.

That means that either we need to document in our product manual how to
use CIP's kernel-cve-triage, providing the necessary information to run
it, and have our users run these scripts manually, or we need to work on
some standardized SBOM that will be enough for "any tooling" to provide
useful information (but as said above we're not there yet)

I think the kernel SBOMs you pointed at is a great way in that
direction - since triage needs to know which source files were used for
build and things like that it should be a good input file for it, and
eventually other tools will pick it up (eventually with a bit of help :-))

> > Just to be clear I'm not asking for free lunch here:
> > - My main question is, if people here publish a SBOM, what do they use
> > to describe their kernel to others, is there any recommendation
> > somewhere I didn't see?
> 
> I actually posted a lengthy idea about including kernel SBOMs as part of
> standard CIP kernel builds on this mailing list yesterday, but that is stuck
> in limbo somewhere.

Great timing, I'll wait for this to get unstuck!

> Since v7.2 the mainline kernel provides scripts to generate kernel SBOMs
> [1]. That is as close as we can get to a standard way of describing your
> kernel, and it is conveniently already in the correct format for all of the
> compliance stuff. My suggestion is to backport the SBOM generation to all
> CIP SLTS kernels and generate them as part of a standard build.
> 
> The kernel SBOM can also be used for CVE triaging, very similar to what is
> done in kernel-cve-triage. Yocto for example is using their kernel SBOMs for
> exactly that purpose.

Thanks for bringing this up, I saw it when it was added, noted to have a
closer look and promptly forgot.
I didn't test it yet, but from a quick look at the documentation it's
definitely a great step forward from what we're shipping (which is
basically useless, scan of the built binary kernel/modules only)

We'll definitely want to use this as well, the standalone version could
probably be used without any backport but it makes sense to pick it up.

> > - Are there any plans going forward for kernel? If so is there anything
> > we can help with?
> 
> I hoped to start a discussion about this exact topic with my post yesterday.
> @Jan can we do anything to get it unstuck? I can repost too if it is not
> recoverable for whatever reason.

I'm on the list, I'll check it out when it goes through, thanks again!

-- 
Dominique Martinet | Asmadeus
