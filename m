From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Tue, 20 Jun 2017 16:14:59 +0100
Subject: [cip-dev] Backporting to the CIP Kernel
In-Reply-To: <TY1PR06MB07026D57AD5E2BD2F2BEBFCCB7C50@TY1PR06MB0702.apcprd06.prod.outlook.com>
References: <TY1PR06MB07026D57AD5E2BD2F2BEBFCCB7C50@TY1PR06MB0702.apcprd06.prod.outlook.com>
Message-ID: <1497971699.1935.21.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Tue, 2017-06-20 at 14:53 +0000, Chris Paterson wrote:
> Hello Ben,
>
> I hope the move went okay.

Thanks.  It didn't entirely, but the worst is over.

> I plan to start backporting some patches to the CIP Kernel soon, to
> begin adding support for the Renesas CIP reference platform.
>
> I?ve had a look at [1] and have a few of queries?
>
> 1)
> >11. It or an equivalent fix must already exist in Linus' tree (upstream).
> Is this rule set in stone? Or can patches that have been accepted into
> the relevant maintainer?s branches be backported?
>
> Positive: We don?t have to wait up to 10 weeks for the new merge window before backporting patches
> Negative: There is a small chance that the patches will be rebased in the move from linux-next to linux

I think it would be fine to relax this for new hardware support.  There
isn't the same risk of regression if the kernel didn't support the
hardware before.

> 2)
> For submitting patches, I assume you would like them sent to cip-dev?

Yes.  You can send a git pull request, but I would like to see the
patches on the list even then.

> 3)
> For patches that add support for a new platform, would you like them
> submitted in small series, as they were upstreamed? Or in one big pull
> request once major support for the platform has been added upstream?

Shorter series are more easy for me to digest.

Ben.

> [1] https://wiki.linuxfoundation.org/civilinfrastructureplatform/cipkernelmaintenance


-- 
Ben Hutchings
Software Developer, Codethink Ltd.
