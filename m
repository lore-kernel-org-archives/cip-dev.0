From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Wed, 19 Sep 2018 17:48:11 +0100
Subject: [cip-dev] Linux 4.4.154-cip28
In-Reply-To: <5034259.PfxreIE8h7@linux-if6s>
References: <1536783932.3024.208.camel@codethink.co.uk>
	<5034259.PfxreIE8h7@linux-if6s>
Message-ID: <1537375691.3024.237.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Wed, 2018-09-19 at 17:59 +0200, Agust?n Benito Bethencourt wrote:
> Hi Ben,
> 
> On Wednesday, 12 September 2018 22:25:32 CEST Ben Hutchings wrote:
> > I've released Linux version 4.4.154-cip28.??A summary of the changes
> > since 4.4.138-cip25:
> > 
> > - Add alignment quirk for USB network gadget drivers on Renesas USBHS,
> > ? so they can use DMA
> > - Fix log level for an error message in PM/OPP core
> > - Add support for critical clocks
> > - Add support for the Renesas R8A7745 (RZ/G1E) and iW-RainboW-G22D
> > - Merge fixes from stable versions 4.4.139-4.4.154 inclusive
> > - Fix some stable regressions
> > 
> > I also tagged two intermediate versions:
> > - 4.4.138-cip26: before merging from 4.4-stable
> > - 4.4.154-cip27: missing R8A7745 sound support (which I accidentally
> > ? dropped while rebasing)
> > 
> > Apologies for the long wait.
> 
> for those who are not following the kernel maintenance process
> closely, what is the current state of the CIP kernel when it comes
> to the mitigation of the L1 Terminal Fault[1]?

The initial mitigation for this was backported into 4.4.148.  Some
fixes for that were applied in subsequent updates, including 4.4.154
and 4.4.155.  I cherry-picked the two critical fixes from 4.4.155 into
4.4.154-cip27, so I believe we have a complete and stable mitigation
for this issue.

Ben.

> [1] https://software.intel.com/security-software-guidance/software-guidance/l1-terminal-fault
> 
> Best Regards
-- 
Ben Hutchings, Software Developer                ?        Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
