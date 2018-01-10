From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Wed, 10 Jan 2018 14:16:58 +0000
Subject: [cip-dev] Meltdown and Spectre in CIP
Message-ID: <1515593818.12097.10.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

I expect that everyone's heard about the above security issues and I
understand there have been questions about how and when these will be
addressed in CIP.

My thinking is that for these are *not* serious issues for embedded
systems, though they do weaken the "defence in depth" that is normally
provided by memory protection and user privilege separation.??We do
need to get fixes out, but not urgently.

(When we discussed kernel configurations and maintainability, there was
consensus that no-one using KVM was relying on it being secure against
malicious guests - the guests were trusted.)

This is the current status of mitigations for these issues, as I
understand it:

Meltdown:
- arm 32-bit: Not affected?  (ARM reports that only the Cortex-A75 is
  affected, but I haven't seen information from other architecture
  licensees.)
- x86 32-bit: Not fixed, no plans to fix.  There are two affected
  configurations that I'm aware of: Siemens' i386-rt and iot2000.
  I doubt that the Quark processor in iot2000 is affected.
- x86 64-bit: Fully mitigated in mainline and 4.4-stable.

Spectre: will be mitigated in mainline, but still under discussion. 
Based on what I've seen, I expect that it will be possible to backport
most of these to 4.4.

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
