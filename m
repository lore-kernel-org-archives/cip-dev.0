From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Tue, 03 Dec 2019 11:40:04 +0000
Subject: [cip-dev] [RFC] Script to find used sources in the kernel
In-Reply-To: <20191126193119.GA4125793@pollux.denx.de>
References: <1561048077.21054.46.camel@codethink.co.uk>
 <20190622200714.GA19211@amd>
 <eb159ff054eb285eeb0ed93d95b917bf3ef7b2f8.camel@codethink.co.uk>
 <20191126193119.GA4125793@pollux.denx.de>
Message-ID: <45be3f5986a1c19dfb65fc5c4d2d104ef757a0ae.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Tue, 2019-11-26 at 20:31 +0100, Pavel Machek wrote:
> Hi!
> 
> (Ressurecting old discussion).
> 
> On Wed 2019-07-10 18:45:38, Ben Hutchings wrote:
> > On Sat, 2019-06-22 at 22:07 +0200, Pavel Machek wrote:
> > > Hi!
> > > 
> > > > There are a couple of open questions, on which I would like to hear
> > > > other's opinions:
> > > > 
> > > > * Should the source lists be added to the repository or not?  If they
> > > >   are added, then they should not be changed by the standard "all" and
> > > >   "clean" targets.
> > > >   I tend to think that they should be added, because they take a long
> > > >   time to generate and require cross-compilers etc. to be installed.
> > > 
> > > I believe they should go to the repository, because we may want to
> > > manually adjust the lists.
> > 
> > I've implemented that option.
> 
> Are the lists stored somewhere?

Yes they are the *.sources files.

> I see the scripts in "cip-kernel-config"
> but I guess it needs non-trivial setup. I'd eventually like filtered version
> in lts-commit-list repository.
[...]

They require a kernel repository with the CIP branches, and suitable
compilers installed.

Ben.
								Pavel
-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
