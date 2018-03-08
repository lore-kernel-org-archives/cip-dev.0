From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Thu, 08 Mar 2018 22:05:38 +0000
Subject: [cip-dev] Linux 4.4.120-cip20
Message-ID: <1520546738.23626.65.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

I've released Linux version 4.4.120-cip20.??A summary of the changes
since 4.4.112-cip18:

- Merge fixes from stable versions 4.4.113-4.4.120 inclusive
? - Includes some mitigations for Spectre v1 and v2 on x86
- Fix stable regressions in x86/apic, arm/omap2, tca8418_keypad, leds
- Backport additional mitigations for Spectre on x86, and related
  fixes
- Add SMP, I2C/IIC, RTC and SDHI support for R8A7743 and iWave board

I also tagged an intermediate version 4.4.112-cip19 before merging from
4.4-stable.

(If you were expecting this last week, I apologise - I came back from
holiday to a huge backlog of changes from 4.4-stable, and it's taken a
lot of time to review those and to find some missing pieces.)

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
