From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Fri, 09 Aug 2019 14:03:29 +0100
Subject: [cip-dev] Testing CIP kernel with Debian gcc
In-Reply-To: <TYAPR01MB228561299852241F36E8328BB7D70@TYAPR01MB2285.jpnprd01.prod.outlook.com>
References: <TYAPR01MB4286F48F657C60E5BBF5341DE1D70@TYAPR01MB4286.jpnprd01.prod.outlook.com>
	<TYAPR01MB228561299852241F36E8328BB7D70@TYAPR01MB2285.jpnprd01.prod.outlook.com>
Message-ID: <5087d1355a38d5a1cb4c1e9e07bf64a0fddb625e.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Thu, 2019-08-08 at 12:05 +0000, Chris Paterson wrote:
[...]
> Do Debian make any changes/fixes in their gcc package?

Yes, they are usually snapshots of a release branch, with some cherry-
picked fixes e.g. for gcc-8 in buster the latest changelog entry is:

gcc-8 (8.3.0-6) unstable; urgency=medium

  * Update to SVN 20190406 (r270182) from the gcc-8-branch.
    - Fix PR middle-end/89934, PR lto/89896.
  * Fix PR fortran/89981, taken from the trunk.

 -- Matthias Klose <doko@debian.org>  Sat, 06 Apr 2019 16:44:55 +0200

Older gcc packages also have backports of retpoline support.

> The packages provided in the links above are presumably for compiling in the native system.
> Does Debian provide suitable packages for cross-compiling?
[...]

Yes, starting with stretch there are cross-compilers for x86 and arm64
targetting most release architectures.  They are named gcc-<major>-
<triplet>, e.g. gcc-8-arm-linux-gnueabihf (except that x86_64 is
changed to x86-64 since underscores aren't allowed in package names).

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
