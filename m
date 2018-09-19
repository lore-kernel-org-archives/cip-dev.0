From: agustin.benito@codethink.co.uk (=?ISO-8859-1?Q?Agust=EDn?= Benito Bethencourt)
Date: Wed, 19 Sep 2018 17:59:53 +0200
Subject: [cip-dev] Linux 4.4.154-cip28
In-Reply-To: <1536783932.3024.208.camel@codethink.co.uk>
References: <1536783932.3024.208.camel@codethink.co.uk>
Message-ID: <5034259.PfxreIE8h7@linux-if6s>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Ben,

On Wednesday, 12 September 2018 22:25:32 CEST Ben Hutchings wrote:
> I've released Linux version 4.4.154-cip28.  A summary of the changes
> since 4.4.138-cip25:
> 
> - Add alignment quirk for USB network gadget drivers on Renesas USBHS,
>   so they can use DMA
> - Fix log level for an error message in PM/OPP core
> - Add support for critical clocks
> - Add support for the Renesas R8A7745 (RZ/G1E) and iW-RainboW-G22D
> - Merge fixes from stable versions 4.4.139-4.4.154 inclusive
> - Fix some stable regressions
> 
> I also tagged two intermediate versions:
> - 4.4.138-cip26: before merging from 4.4-stable
> - 4.4.154-cip27: missing R8A7745 sound support (which I accidentally
>   dropped while rebasing)
> 
> Apologies for the long wait.

for those who are not following the kernel maintenance process closely, what is the current state of the CIP kernel when it comes to the mitigation of the L1 Terminal Fault[1]?

[1] https://software.intel.com/security-software-guidance/software-guidance/l1-terminal-fault

Best Regards
-- 
Agust?n Benito Bethencourt
Principal Consultant
Codethink Ltd
We respect your privacy.   See https://www.codethink.co.uk/privacy.html
