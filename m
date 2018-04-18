From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Wed, 18 Apr 2018 15:47:10 +0100
Subject: [cip-dev] ARM64 and Debian LTS
In-Reply-To: <3200087.i7ITxrmn3d@linux-if6s>
References: <1536891.WlvLrdFcEH@linux-if6s>
	<606a799a-cf5c-4f10-3789-19084d3f38e4@siemens.com>
	<3200087.i7ITxrmn3d@linux-if6s>
Message-ID: <1524062830.2587.7.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Mon, 2018-04-16 at 17:07 +0200, Agust?n Benito Bethencourt wrote:
> Hi,
> 
> On Monday, 16 April 2018 16:23:19 CEST Jan Kiszka wrote:
> > On 2018-04-16 15:52, Agust?n Benito Bethencourt wrote:
> > > Hi Ben,
> > > 
> > > is there any discussion going on about when ARM64 can make it as supported
> > > architecture? Is it something expected for 2019 or is it not on the
> > > roadmap
> > > yet?
> > 
> > /me confused: https://wiki.debian.org/SupportedArchitectures and
> > https://www.debian.org/ports/#portlist-released list arm64 as supported
> > already.
> 
> Sorry, referred to LTS supported architecture.

The list of architectures for jessie LTS is not decided and I haven't
seen any discussion of it yet.  The starting point for discussion would
be the list of architectures included in Debian 7 LTS, and that didn't
include arm64 because it wasn't in Debian 7 to start with.

I think that a proposal to include arm64 in Debian 8 LTS would probably
be accepted.  There should be no practical issues with maintaining the
infrastructure for it as arm64 hardware is only becoming more easily
available.

So I suggest that the interested organisations speak up on the debian-
lts mailing list.  For reference, here's the discussion of adding armel
and armhf back in 2016:
<https://lists.debian.org/debian-lts/2016/04/msg00045.html>.  Note in
particular that there is some sensitivity about companies paying for
development work while being "free-riders" on Debian infrastructure. 
These organisations should consider sponsoring Debian, or pledging to
contribute development or testing effort directly, instead of or as
well as paying Freexian or other contractors working on Debian LTS.

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
