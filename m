From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Tue, 16 Jan 2018 08:01:44 +0000
Subject: [cip-dev] Meltdown and Spectre in CIP
In-Reply-To: <1515593818.12097.10.camel@codethink.co.uk>
References: <1515593818.12097.10.camel@codethink.co.uk>
Message-ID: <TY1PR06MB07021E0DE8BDB329DFC8A32FB7EA0@TY1PR06MB0702.apcprd06.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Ben,

Thank you for the summary.

> From: cip-dev-bounces at lists.cip-project.org [mailto:cip-dev-
> bounces at lists.cip-project.org] On Behalf Of Ben Hutchings
> Sent: 10 January 2018 14:17
> 
> I expect that everyone's heard about the above security issues and I
> understand there have been questions about how and when these will be
> addressed in CIP.
> 
> My thinking is that for these are *not* serious issues for embedded systems,
> though they do weaken the "defence in depth" that is normally provided by
> memory protection and user privilege separation.??We do need to get fixes
> out, but not urgently.
> 
> (When we discussed kernel configurations and maintainability, there was
> consensus that no-one using KVM was relying on it being secure against
> malicious guests - the guests were trusted.)
> 
> This is the current status of mitigations for these issues, as I understand it:
> 
> Meltdown:
> - arm 32-bit: Not affected?  (ARM reports that only the Cortex-A75 is
>   affected, but I haven't seen information from other architecture
>   licensees.)

ARM also lists that meltdown subvariant '3a' affects some arm 32-bit processors [1], but say that "In general, it is not believed that software mitigations for this issue are necessary".

The whitepaper ARM link to [2] implies that ARM don't think this is an issue worth worrying about as the information that can be obtained from the system registers is "not material".

Have you heard/seen anything to contradict this statement?


> - x86 32-bit: Not fixed, no plans to fix.  There are two affected
>   configurations that I'm aware of: Siemens' i386-rt and iot2000.
>   I doubt that the Quark processor in iot2000 is affected.
> - x86 64-bit: Fully mitigated in mainline and 4.4-stable.
> 
> Spectre: will be mitigated in mainline, but still under discussion.
> Based on what I've seen, I expect that it will be possible to backport most of
> these to 4.4.

Will you be keeping an eye on Spectre patches on behalf of CIP as part of your maintainer role? I guess you may be in the loop a bit more than the rest of us?


[1] https://developer.arm.com/support/security-update
[2] https://developer.arm.com/support/security-update/download-the-whitepaper

Kind regards, Chris
