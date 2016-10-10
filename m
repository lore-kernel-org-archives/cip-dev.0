From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Mon, 10 Oct 2016 20:05:19 +0100
Subject: [cip-dev] Maintenance policies and early considerations IV
In-Reply-To: <390B4EACA1A32748BA6BC7F859F7D71655236EC1@GSjpTKYDCembx31.service.hitachi.net>
References: <57E3D5BA.2050905@codethink.co.uk>
	<57EA2E02.9020604@codethink.co.uk>
	<390B4EACA1A32748BA6BC7F859F7D71655236EC1@GSjpTKYDCembx31.service.hitachi.net>
Message-ID: <1476126319.22569.3.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Fri, 2016-10-07 at 07:34 +0000, ???? / KOGUCHI?TAKUO wrote:
> Hi Agustin,
> Let me understand what you wrote.
> > > CIP should avoid making any such promise because:
> > >
> > > * Upstream fixes frequently change the kernel module API and/or ABI and
> > > backporting them in a way that does not is difficult and risky   - CIP
> > > users set their own kernel configurations, so there will not be a
> > > single kernel ABI for IHVs to target anyway
> > 
> > Correction:
> > 
> > Upstream fixes frequently change the kernel module API and/or ABI and
> > backporting them in a way that is difficult and risky   - CIP users set
> > their own kernel configurations, so there will not be a single kernel ABI for IHVs to
> > target anyway
> > 
> 
> Is the correction correct?

The first version is what I wrote, and the correction says something I
did not mean to say.

> I thought you wrote;
>  * Upstream fixes frequently change the kernel module API and/or ABI and
>  backporting them in a way that does not (change the kernel module API and/or ABI )is difficult and risky   - CIP
> Am I wrong?

No, you understand me rightly.

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
