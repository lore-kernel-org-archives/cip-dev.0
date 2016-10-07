From: takuo.koguchi.sw@hitachi.com (=?iso-2022-jp?B?GyRCPi44fUJ2SVcbKEIgLyBLT0dVQ0hJGyRCISQbKEJUQUtVTw==?=)
Date: Fri, 7 Oct 2016 07:34:55 +0000
Subject: [cip-dev] Maintenance policies and early considerations IV
In-Reply-To: <57EA2E02.9020604@codethink.co.uk>
References: <57E3D5BA.2050905@codethink.co.uk>
	<57EA2E02.9020604@codethink.co.uk>
Message-ID: <390B4EACA1A32748BA6BC7F859F7D71655236EC1@GSjpTKYDCembx31.service.hitachi.net>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Agustin,
Let me understand what you wrote.
> > CIP should avoid making any such promise because:
> >
> > * Upstream fixes frequently change the kernel module API and/or ABI and
> > backporting them in a way that does not is difficult and risky   - CIP
> > users set their own kernel configurations, so there will not be a
> > single kernel ABI for IHVs to target anyway
> 
> Correction:
> 
> Upstream fixes frequently change the kernel module API and/or ABI and
> backporting them in a way that is difficult and risky   - CIP users set
> their own kernel configurations, so there will not be a single kernel ABI for IHVs to
> target anyway
> 

Is the correction correct?
I thought you wrote;
 * Upstream fixes frequently change the kernel module API and/or ABI and
 backporting them in a way that does not (change the kernel module API and/or ABI )is difficult and risky   - CIP
Am I wrong?

Takuo Koguchi
