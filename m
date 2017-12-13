From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Wed, 13 Dec 2017 17:37:15 +0000
Subject: [cip-dev] Linux 4.4.105-cip15
Message-ID: <1513186635.18523.262.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

I've released Linux version 4.4.105-cip15.??A summary of the changes
since 4.4.98-cip13:

- Update spi-pxa2xx driver to support the IOT2000 platform
- Disable verbose loging in the wireless regulatory code
- Merge fixes from stable versions 4.4.99-4.4.105 inclusive
- Revert a change made in 4.4-stable to the x86 EFI calling code that
  would cause regressions

I also tagged a version 4.4.98-cip14 immediately before merging from
the 4.4-stable branch.

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
