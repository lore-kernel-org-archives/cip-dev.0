From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Tue, 19 Jun 2018 21:25:00 +0100
Subject: [cip-dev] Linux 4.4.138-cip25
Message-ID: <1529439900.19394.11.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

I've released Linux version 4.4.138-cip25.??A summary of the changes
since 4.4.130-cip23:

- Add video (DU, VSP, VIN), CAN, PCIe, audio, PWM, thermal, and
  clocksource (CMT) support for R8A7743 and iWave board
- Bug fixes for the sgtl5000 codec driver used on the iWave board
- Update shmobile_defconfig and multi_v7_defconfig to enable more
  of the above drivers
- Merge fixes from stable versions 4.4.131-4.4.138 inclusive
- Fix stable regressions and add missing dependencies

I also tagged an intermediate version?4.4.130-cip24 before merging from
4.4-stable.

Ben.

-- 
Ben Hutchings, Software Developer                ?        Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
