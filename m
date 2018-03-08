From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Thu, 08 Mar 2018 22:45:06 +0000
Subject: [cip-dev] Meltdown and Spectre in CIP
In-Reply-To: <1515593818.12097.10.camel@codethink.co.uk>
References: <1515593818.12097.10.camel@codethink.co.uk>
Message-ID: <1520549106.23626.67.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Here's the status of these issues, as of today's kernel release
(4.4.120-cip20).

On Wed, 2018-01-10 at 14:16 +0000, Ben Hutchings wrote:
> Meltdown:
> - arm 32-bit: Not affected???(ARM reports that only the Cortex-A75 is
> ? affected, but I haven't seen information from other architecture
> ? licensees.)

As Chris pointed out, some 32-bit ARM cores are affected by a variant
of Meltdown, though ARM claims that this variant is unlikely to leak
sensitive information.  In any case, there is no sign of any mitigation
in mainline, which would be a prerequisite for addressing it in the CIP
kernel.

> - x86 32-bit: Not fixed, no plans to fix.??There are two affected
> ? configurations that I'm aware of: Siemens' i386-rt and iot2000.
> ? I doubt that the Quark processor in iot2000 is affected.
> - x86 64-bit: Fully mitigated in mainline and 4.4-stable.

This is not quite accurate.  The 4.14-stable branch and later versions
use per-CPU entry stacks, allowing normal kernel stacks to be excluded
from the user-mode page tables.  KAISER, used in older branches
including 4.4, does not do this, so kernel stacks are still vulnerable
to information leaks.

> Spectre: will be mitigated in mainline, but still under discussion.?
> Based on what I've seen, I expect that it will be possible to backport
> most of these to 4.4.

Spectre variant 1 is being mitigated by adding a masking operation
after each sensitive range check, mostly using the generic
array_index_nospec() function.  This has been done for some generic and
x86-specific code, and backported to the 4.4 CIP kernel.

Spectre variant 2 is being mitigated for x86 using "retpoline" (for
indirect calls) and filling the return stack buffer (for returns). 
This has been backported to the 4.4 CIP kernel.  The retpoline feature
requires a new compiler - gcc 7.3, or a version with retpoline support
backported.  The default versions of gcc in Debian 8 (jessie) and 9
(stretch) include this.

Mainline Linux has additional mitigations for Spectre variant 2 on x86,
using new microcoded CPU features (IBPB and IBRS).  These have *not*
been backported to 4.4 and are not included in the CIP kernel.  There
have also been some changes to the kernel entry code that clear several
registers.  These have also not been backported.

I don't see any sign of Spectre being addressed for 32-bit ARM yet.

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
