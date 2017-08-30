From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Wed, 30 Aug 2017 15:52:14 +0100
Subject: [cip-dev] How to back-port upstream BSP patches to CIP kernel
In-Reply-To: <5aff707e-f641-4e1f-81c7-81669ae4c439@siemens.com>
References: <90c61c7e-2459-b2dd-56e9-f07b1d5770bd@siemens.com>
	<1503081064.2047.130.camel@codethink.co.uk>
	<32309b11-388a-b43f-6297-60e9a7c9a22f@siemens.com>
	<5aff707e-f641-4e1f-81c7-81669ae4c439@siemens.com>
Message-ID: <1504104734.2047.161.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Wed, 2017-08-30 at 14:11 +0200, Jan Kiszka wrote:
> On 2017-08-30 09:59, Jan Kiszka wrote:
> > On 2017-08-18 20:31, Ben Hutchings wrote:
> >>
> >>> - the whole series of EFI capsule changes
> >>
> >> As this is all new stuff, I think it's OK.  However you should remove
> >> the "default y" for EFI_CAPSULE_QUIRK_QUARK_CSH (upstream too!).
> >>
> 
> Forgot to comment on this: We had this discussion during the merge, and
> the EFI maintainer accepted the point that this will only be enabled on
> 32-bit kernels that are potentially Quark-targeting. Plus, there are
> strong runtime measures that enable it only on Quark hardware. I would
> recommend to not deviate from this decision for CIP.

I agree that CIP shouldn't deviate.

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
