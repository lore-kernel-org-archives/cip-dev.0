From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Thu, 19 Apr 2018 13:04:08 +0100
Subject: [cip-dev] ARM64 and Debian LTS
In-Reply-To: <87efjcjudi.fsf@mid.deneb.enyo.de>
References: <1536891.WlvLrdFcEH@linux-if6s>
	<606a799a-cf5c-4f10-3789-19084d3f38e4@siemens.com>
	<3200087.i7ITxrmn3d@linux-if6s>
	<1524062830.2587.7.camel@codethink.co.uk>
	<87efjcjudi.fsf@mid.deneb.enyo.de>
Message-ID: <1524139448.2587.14.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Wed, 2018-04-18 at 19:29 +0200, Florian Weimer wrote:
> * Ben Hutchings:
> 
> > The list of architectures for jessie LTS is not decided and I haven't
> > seen any discussion of it yet.??The starting point for discussion would
> > be the list of architectures included in Debian 7 LTS, and that didn't
> > include arm64 because it wasn't in Debian 7 to start with.
> > 
> > I think that a proposal to include arm64 in Debian 8 LTS would probably
> > be accepted.??There should be no practical issues with maintaining the
> > infrastructure for it as arm64 hardware is only becoming more easily
> > available.
> 
> Does it???I don't think there is any commercially viable, server-class
> arm64 hardware you can buy today.??How can you promise long-term
> support for hardware that does not actually exist?

Debian prefers but doesn't absolutely require server type systems. 
None of the existing ARM (32-bit) or MIPS systems used as Debian
buildds or porterboxes appear to be designed as servers.

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
