From: pavel@denx.de (Pavel Machek)
Date: Tue, 26 Nov 2019 20:31:19 +0100
Subject: [cip-dev] [RFC] Script to find used sources in the kernel
In-Reply-To: <eb159ff054eb285eeb0ed93d95b917bf3ef7b2f8.camel@codethink.co.uk>
References: <1561048077.21054.46.camel@codethink.co.uk>
 <20190622200714.GA19211@amd>
 <eb159ff054eb285eeb0ed93d95b917bf3ef7b2f8.camel@codethink.co.uk>
Message-ID: <20191126193119.GA4125793@pollux.denx.de>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

(Ressurecting old discussion).

On Wed 2019-07-10 18:45:38, Ben Hutchings wrote:
> On Sat, 2019-06-22 at 22:07 +0200, Pavel Machek wrote:
> > Hi!
> > 
> > > There are a couple of open questions, on which I would like to hear
> > > other's opinions:
> > > 
> > > * Should the source lists be added to the repository or not?  If they
> > >   are added, then they should not be changed by the standard "all" and
> > >   "clean" targets.
> > >   I tend to think that they should be added, because they take a long
> > >   time to generate and require cross-compilers etc. to be installed.
> > 
> > I believe they should go to the repository, because we may want to
> > manually adjust the lists.
> 
> I've implemented that option.

Are the lists stored somewhere? I see the scripts in "cip-kernel-config"
but I guess it needs non-trivial setup. I'd eventually like filtered version
in lts-commit-list repository.

> > I don't believe "example" configurations we have necessarily have
> > enabled all the options "final products" may need. If some common
> > option (vfat?) is not enabled in our configurations, because it is not
> > hardware specific and not needed for testing, we may still want to
> > review it, because it is common enough that someone will need it...
> 
> I hadn't thought of that, but it does seem possible.  However, I think
> that rather than editing a generated list it would be better to have a
> separate manually maintained list that is merged into the generated
> list.

I guess first step would be to select few subsystems with large
ammounts of -stable patches that we don't need (s390), get the approval
and then create automated tools to mark patches as "ignored" when
they are not interesting.

Best regards,
								Pavel
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
