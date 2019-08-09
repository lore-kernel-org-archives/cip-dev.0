From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Fri, 09 Aug 2019 14:23:40 +0100
Subject: [cip-dev] [PATCH linux-4.19.y-cip-rt] staging: m57621-mmc:
 delete driver from the tree.
In-Reply-To: <20190808215338.GA12892@amd>
References: <bff48726-afc7-0676-b189-dad8ca1d559a@siemens.com>
	<20190808215338.GA12892@amd>
Message-ID: <284fac5aa15c418fc77c37f3d50254e05e159940.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Thu, 2019-08-08 at 23:53 +0200, Pavel Machek wrote:
> Hi!
> 
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > The license text in this driver is "interesting" and not really obvious
> > that it is supposed to be able to be distributed in the kernel source
> > tree.  Yes, the MODULE_LICENSE() text says GPL, so it's probably ok, but
> > to be safe, I am deleting this driver.  I will be glad to add it back if
> > the license is properly sorted out, but for now, this isn't worth the
> > potential risk, I should have never taken it in the first place.
> > Found to be "interesting" also by our license analysis. I think it's
> > best to purge it in CIP as well. Staging is out of scope for us
> > anyway.
> 
> Greetings to your lawyers ;-). The code is clearly derived work of
> kernel, so it has to be GPL, if Mediatek wants it or not.

This might seem clear to you, but at least for source code I think it's
less clear.  Also, if the copyright holder is required to license it
under GPL to comply with the kernel's copyright license, that still
doesn't (so far as I know) happen automatically, at least not in the
jurisdictions where the GPL has been tested so far.

[...]
> On the other hand.... nobody is using that one. You are unlikely to
> build it into your product. And yes, I can apply the patch; I'd prefer
> to get it from -stable... But that will not solve the problem.
> 
> _We will be still distributing that driver_, even if I remove it. git
> will just mark it as removed, it will still be in
> repository. (Granted, it will help with generated tarballs).

Yes, it is not great to have such things in the history.  We have a
similar issue with firmware extracted from C sources labelled as "GPL"
but without real source for the firmware.

But the law doesn't usually deal in absolutes, and taking this step can
reduce the (probably already small) legal risk.  It should completely
remove the future risk for downstream distributors that provide source
snapshots, or that were previously distributing this driver in binary
form.

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
