From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Fri, 26 Jan 2018 17:42:32 +0000
Subject: [cip-dev] Linux 4.4.112-cip18
Message-ID: <1516988552.3417.54.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

I've released Linux version 4.4.112-cip18.??A summary of the changes
since 4.4.105-cip15:

- Merge fixes from stable versions 4.4.106-4.4.112 inclusive
  - Includes mitigation for Meltdown on x86_64 only
- Apply related fixes to hpsa driver and deadline scheduler
- Fix regressions in nfsd, x86 microcode loader, and x86_64 vsyscall
- Fix r8a7743 watchdog timer clock definition

I also tagged intermediate versions 4.4.109-cip16 and 4.4.112-cip17.

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
