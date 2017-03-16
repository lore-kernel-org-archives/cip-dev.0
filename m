From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Thu, 16 Mar 2017 12:07:03 +0000
Subject: [cip-dev] u-boot policy for CIP
Message-ID: <HK2PR0601MB13296740334D8058F10B1919B7260@HK2PR0601MB1329.apcprd06.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello all,

I'm bringing a discussion I've started in other places here as it will benefit from wider participation.

As you know the aim of CIP is to maintain not just the Kernel, but a number of other 'core packages'. One of these is u-boot.

For the Kernel the project will provide super long term support for a chosen version. For u-boot this will be harder to achieve as

a)      there are no 'LTS' versions of u-boot to base our 'SLTS' version on;

b)      a lot of hardware providers tend to use forks for their platforms, rather than add full functionality upstream.

Ideally CIP should choose a version of u-boot and use it when testing/verifying the CIP Kernel on the reference hardware. How we actively maintain that version (bug fixes/security patches/features?) is another question. Given that most devices in the field won't have a way to update u-boot in the field (security issues/practicalities), I think 'SLTS' support for u-boot may not be required. Perhaps we just tag a version of u-boot at the launch of a new CIP Kernel and stick with it?

How do we decide what u-boot version to support? Currently it looks like the BBB platform are shipped with 2014.04 and the Renesas platform is shipped with 2013.01. That said, it looks like there is upstream support for BBB [1], but how the feature set compares to the version shipped with the platform I don't know. There is also support for some Renesas platforms [2], but not for the exact board CIP will be using.

Do we want to push Ti/Renesas to ensure there is full support for their boards upstream? When this is done do we pick the first version that includes this support to work with? Or do we just stick with the vendor provided forks?

Is there a particular feature set that CIP requires?

Forgive my random ramblings, I appreciate there are a lot of different questions here!


[1] https://github.com/u-boot/u-boot/tree/master/board/ti/am335x
[2] https://github.com/u-boot/u-boot/tree/master/board/renesas

Kind regards, Chris
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20170316/6726176d/attachment.html>
