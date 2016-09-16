From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Fri, 16 Sep 2016 18:24:26 +0900
Subject: [cip-dev] Introduction
In-Reply-To: <354376874ab6de30b7d0c02134775fda@codethink.co.uk>
References: "<1473851440.4719.37.camel@codethink.co.uk>	<005e01d20f1d$64afb270$2e0f1750$@toshiba.co.jp>"
	<57DA5C43.5010001@codethink.co.uk>
	<2db652238ec32fb02f30541a75454292@codethink.co.uk>
	<005d01d20fd9$5a18a490$0e49edb0$@toshiba.co.jp>
	<354376874ab6de30b7d0c02134775fda@codethink.co.uk>
Message-ID: <007201d20ffc$1ec18560$5c449020$@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org


> -----Original Message-----
> From: Paul Sherwood [mailto:paul.sherwood at codethink.co.uk]
> Sent: Friday, September 16, 2016 4:41 PM
> To: Daniel Sangorrin
> Cc: cip-dev at lists.cip-project.org
> Subject: RE: [cip-dev] Introduction
> 
> On 2016-09-16 06:15, Daniel Sangorrin wrote:
> >> Greg K-H, Ben Hutchings and others have contributed a huge amount to
> >> Long Term Stable and followon initiatives in the community over the
> >> years. But when I first started exploring how things like LTS and
> >> LTSI
> >> can work for embedded and automotive in 2012/2013, I hit some
> >> fundamental questions, not least - how in practice can a complex
> >> embedded project consume a 'stable' kernel that's being released **
> >> every couple of weeks ** with the words 'users of this series must
> >> upgrade'? I presented some work at an  automotive GENIVI event in
> >> Oct
> >> 2013 [1] but the audience at that time literally refused to accept
> >> that
> >> the idea of whole-of-life  updates.
> >
> > As for the embedded systems I deal with, a 2-weeks release is
> > definitely not
> > required. A 6 six months cycle, complemented with aperiodic patch
> > releases
> > for really *important* issues, would be good enough.
> > Of course, different use cases may have different requirements so we
> > will probably need to reach a consensus on that.
> 
> I expect there are multiple usecases/scenarios and a one-size-fits-all
> approach may not be possible. But note that even with six month cycle
> and periodic patch releases, it seems to me you imply requirements that
> 
> a) updates are relatively easy, low effort, low risk
> b) updates may be required for the whole production lifetime of the
> target
> 
> I've seen plenty of examples where the real-world LTSI BSP
> implementation has made the process of updating the kernel 'a
> nightmare'.
> 
> And I've had lots of pushback from people insisting that no updates
> will be required 'after the first couple of years, when the bugs have
> been ironed out'.
> 
> I'm not yet sure whether CIP usecases mostly involve devices which are
> connected to the internet or other third-party services. And I'm not
> sure whether security and integrity of the software over the longterm is
> expected to be a key concern or not.

Probably there are many different usecases. Sharing the requirements 
for each of them could be beneficial for limiting the scope of our work to
things that matter the most.

In the usecases I'm most familiar with, devices are working either standalone
(no physical connection to the Internet) or behind client's security hardened 
(e.g. VPNs, firewalls..) gateways that we don't control.  
These devices are usually updated (in practice reinstalled)  by hand after 
stopping the process they are controlling (which can't happen every day) 
and run tasks that need high predictability. 

For these usecases, we require software (e.g.: kernel, partitioned hypervisor, rootfs) 
that has been proved to be stable and reliable for a long-enough period of time, and
will keep being supported as long as our clients require. Note that it's not only about
making updates, but also about making new devices with software that is known
to work reliably across the different companies in the CIP project.

Cheers,
Daniel 

> >> And as Greg said at the time:
> >>
> >> "The patches that apply for stuff after 2 years drops off
> >> dramatically,
> >> and the work involved in keeping stuff working and testing for
> >> problems
> >> increases greatly.?
> >> Just yesterday there was a very interesting post about backports and
> >> long term stable kernels on LWN [2]. Greg is quoted there
> >> considering:
> >>
> >> "But if we didn't provide an LTS, would companies constantly update
> >> their kernels to newer releases to keep up with the security and
> >> bugfixes? That goes against everything those managers/PMs have ever
> >> been
> >> used to in the past, yet it's actually the best thing they could
> >> do."
> >>
> >> I've been recommending the constant update route route to customers
> >> over the last few years, with some success, but many ecosystem
> >> members
> >> are extremely uncomfortable with the whole idea of aligning with
> >> mainline. I think this is broadly because as embedded engineers
> >> we've
> >> learned over many years that it's best to change the platform as
> >> little
> >> as possible.  I wrote an article trying to challenge this
> >> traditional
> >> embedded thinking earlier this year [3]
> >
> > Thanks, interesting article.
> >
> > " All of which makes perfect sense for traditional embedded
> > projects."
> >
> > I just wanted to clarify that these 'traditional embedded projects'
> > are actually
> > in the scope of the CIP project.
> 
> Yes, they are.
> 
> I'm just suggesting that once we are working with a connected device
> containing more than tens of millions of lines of code, the principles
> we learned on self-contained device projects with tens or hundreds of
> thousands of lines, even if they have worked successfully for decades,
> may no longer apply.

Devices that directly connect to the internet (e.g.: gateways) definitely 
need to be security hardened. However, I'm not sure about
the level of security required for devices that are only indirectly
connected (e.g.: behind the gateways). And I'm not sure if all
security mechanisms are compatible with the predictability 
required by these systems.


> 
> > I believe embedded systems where
> > continuous updates are hard to implement, should still benefit from
> > other
> > CIP activities (e.g. testing, RAS, real-time partitioning support or
> > kernel
> > self-protection).
> 
> Absolutely.
> 
