From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Tue, 07 Nov 2017 17:21:48 +0000
Subject: [cip-dev] Next CIP kernel: CIP - Debian alignment
In-Reply-To: <5A01E24F.506@codethink.co.uk>
References: <5A01E24F.506@codethink.co.uk>
Message-ID: <1510075308.2465.28.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Tue, 2017-11-07 at 17:41 +0100, Agustin Benito Bethencourt wrote:
> Hi Ben,
> 
> one of the recurrent questions at ELCE, that also was done at the TSC?
> meeting is when will we pick the following kernel. The following?
> variables apply to this decision:
> 
> * Some time ago, you made clear that, in order to keep the maintenance?
> effort affordable, we should not pick kernels in tight cadence. TSC?
> agreed to assume that advice.
> 
> * Since we have agreed to base CIP-Core in Debian sources and during?
> ELCE 2017 we picked Debian as the default distro for CIP, it seems a?
> natural choice to pick LTS kernels that are also selected by Debian as?
> preferred choice.
> 
> Based on your understanding about the Debian project:
> 
> - When do you expect the next Debian kernel to be selected?

I take it that you mean the kernel for the next Debian stable release
(10/buster).

Debian is aiming to release roughly every 2 years.  The last freeze was
delayed at my request, to allow inclusion of the LTS kernel selected at
the end of 2016, which was 4.9.  So I would expect that the next Debian
release will include the LTS kernel selected at the end of 2018.

> - Based on that answer, which ones are the best candidates?

The kernel release cycle is 9-10 weeks, so I would expect the 2018 LTS
kernel to be 4.19 or 4.20/5.0.  (I think I heard Linus say 4.19 will be
followed by 5.0, the same way 3.19 was followed by 4.0.)

> - Do you expect LTS and Debian selection to be aligned?

Absolutely.

> - If not, if this something you would like to see happening?
> - If yes, how can CIP help to make it happen?

I don't think CIP needs to do anything to encourage this.

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
