Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2987.1795138181121969735
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Nov 2026 17:29:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@codewreck.org header.s=2 header.b=UTgDokha;
 spf=pass (domain: codewreck.org, ip: 62.210.214.84, mailfrom: asmadeus@codewreck.org)
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 6972414C2D6;
	Fri, 20 Nov 2026 02:29:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1795138178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=RhtWuipBG/+XBsup4Yf0nxGChgbI35kknOju+MDCQEo=;
	b=UTgDokhaazM5TJqJdowkW+j7cJEYXpx0HMEc++GHGk4Tq0wXu8ZQ3p3O0TNepxYaAh4aLB
	CrtId3fjAAvPNMJG2WehK5eluLKqSHzoV4BQSbiqOfxpv6dpoS5Yc7Dei2wz7HsqWaAW2L
	/bwm82Fu2uvLUtYNeylQd/3nFlf64qcjYmzFRgHtg1zbv1jr+4SBpoOLoSNRSTt6R+fbzS
	MYbmjonFjFiLJBWtSaDnKgB7ggJrhjm5+406Hfi8jJZ7FzrpfMEOhMb+hM5q6Y0zjOe8uU
	kltoRVR6Q0/FxmTyHqaMGzTuHseIVkqLibYpOB73hEw3ayESeQFJHBjD+NnAGw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id c00d2ebf;
	Fri, 20 Nov 2026 01:29:35 +0000 (UTC)
Date: Fri, 20 Nov 2026 10:29:20 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: cip-dev@lists.cip-project.org
Cc: Akihito Irie <akihito.irie@atmark-techno.com>,
	Dominique Martinet <dominique.martinet@atmark-techno.com>
Subject: Best practices to write CIP kernel details in a SBOM?
Message-ID: <av-icExXuq2zIc1g@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 20 Nov 2026 01:29:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25026

Hi,

I asked about SBOM on IRC a couple of days ago and got told "mailing
list" would be better - I hope I got the right one.. :)
(also note: my org (atmark-techno.com) is not a CIP member as far as I
know, we're not using CIP kernels yet but we do maintain a 5.10 kernel
and I intend to participate at least in reviews/testing starting next
month when upstream 5.10 goes EOL, as I've been doing with upstream 5.10
stable-rc tests. If it's a pre-requisite for discussion please let me
know)

Now for some more useful background and questions...
We're working on improving our SBOM, as it becomes mandatory in various
regulations, and in particular the linux kernel has been difficult to
describe in a useful manner so our users (we ship an OS) can act on the
SBOM.

As long as we stick to upstream kernel stable releases, we can
apparently write PURL/CPE tags as follow:
- pkg:generic/linux-kernel@[version]
- cpe:2.3:o:linux:linux_kernel:[version]:::::::*

and since the linux upstream CVEs are fed to NVD/OSV databases then
scanners will pick up the many CVEs still affecting the releases, so one
can triage them and export the result as VEX as seems to be the current
best practices; but if we don't provide a VEX there doesn't seem to be
any way to describe the kernel version as e.g. v5.10.272-cip79 with all
the fixes covered by CIP automatically covered.

I've found about cip-kernel-sec[1] and kernel-cve-triage[2] and we can
use it to automatically check boxes in a VEX, but would it make sense to
publish this data as well somewhere so that "standard" scanners
(dependency-track/grype/osv-scanner/etc) automatically do it in the
first place?
From what I've seen it's possible to setup a data source for OSV.dev
that they'd pick it up[3], I'm not sure if it'd be useful for CIP as a
project or if it's something that'd gather interest?

[1] https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec
[2] https://gitlab.com/cip-project/cip-kernel/kernel-cve-triage
[3] https://google.github.io/osv.dev/data/


Just to be clear I'm not asking for free lunch here:
- My main question is, if people here publish a SBOM, what do they use
to describe their kernel to others, is there any recommendation
somewhere I didn't see?
(I saw https://github.com/siemens/debsbom from cip-documents, but
there doesn't seem to be anything about the kernel there)
- Are there any plans going forward for kernel? If so is there anything
we can help with?


Thanks!
-- 
Dominique Martinet | Asmadeus
