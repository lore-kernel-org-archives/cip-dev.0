From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Thu, 15 Feb 2018 11:44:51 +0000
Subject: [cip-dev] Meltdown and Spectre in CIP
In-Reply-To: <TY1PR06MB07021E0DE8BDB329DFC8A32FB7EA0@TY1PR06MB0702.apcprd06.prod.outlook.com>
References: <1515593818.12097.10.camel@codethink.co.uk>
	<TY1PR06MB07021E0DE8BDB329DFC8A32FB7EA0@TY1PR06MB0702.apcprd06.prod.outlook.com>
Message-ID: <1518695091.3422.24.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Tue, 2018-01-16 at 08:01 +0000, Chris Paterson wrote:
[...]
> > Meltdown:
> > - arm 32-bit: Not affected???(ARM reports that only the Cortex-A75 is
> > ? affected, but I haven't seen information from other architecture
> > ? licensees.)
> 
> ARM also lists that meltdown subvariant '3a' affects some arm 32-bit
> processors [1], but say that "In general, it is not believed that
> software mitigations for this issue are necessary".
> 
> The whitepaper ARM link to [2] implies that ARM don't think this is
> an issue worth worrying about as the information that can be obtained
> from the system registers is "not material".
> 
> Have you heard/seen anything to contradict this statement?

No I haven't.

[...]
> Will you be keeping an eye on Spectre patches on behalf of CIP as
> part of your maintainer role? I guess you may be in the loop a bit
> more than the rest of us?

I will look at the mitigations as they land upstream, but I still think
these are low priority security issues for CIP.

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
