From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Wed, 10 Jul 2019 18:45:38 +0100
Subject: [cip-dev] [RFC] Script to find used sources in the kernel
In-Reply-To: <20190622200714.GA19211@amd>
References: <1561048077.21054.46.camel@codethink.co.uk>
	<20190622200714.GA19211@amd>
Message-ID: <eb159ff054eb285eeb0ed93d95b917bf3ef7b2f8.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Sat, 2019-06-22 at 22:07 +0200, Pavel Machek wrote:
> Hi!
> 
> > There are a couple of open questions, on which I would like to hear
> > other's opinions:
> > 
> > * Should the source lists be added to the repository or not?  If they
> >   are added, then they should not be changed by the standard "all" and
> >   "clean" targets.
> >   I tend to think that they should be added, because they take a long
> >   time to generate and require cross-compilers etc. to be installed.
> 
> I believe they should go to the repository, because we may want to
> manually adjust the lists.

I've implemented that option.

> I don't believe "example" configurations we have necessarily have
> enabled all the options "final products" may need. If some common
> option (vfat?) is not enabled in our configurations, because it is not
> hardware specific and not needed for testing, we may still want to
> review it, because it is common enough that someone will need it...

I hadn't thought of that, but it does seem possible.  However, I think
that rather than editing a generated list it would be better to have a
separate manually maintained list that is merged into the generated
list.

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
