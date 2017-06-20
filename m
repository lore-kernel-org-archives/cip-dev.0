From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Tue, 20 Jun 2017 08:49:11 +0000
Subject: [cip-dev] Renesas dev CIP repository announcement
Message-ID: <TY1PR06MB0702667AD2F56BEBDFFCF9A1B7C50@TY1PR06MB0702.apcprd06.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Dear CIP friends,

I'd like to announce the availability of a development repo [1] based on the CIP Kernel for the iWave RZ/G1M Qseven Development Platform [2].

The main aim of this repository is to allow CIP users to get up and running with the Renesas CIP reference platform. Please note that this is just an interim step as support for the platform is added upstream/backported to the CIP Kernel.

Currently there are two branches, one based on v4.4.55-cip3, and the other based on v4.4.69-cip4.

Please use the "shmobile_defconfig" configuration when compiling, and use r8a7743-iwg20m.dtb. uImage LOADADDR should be set to "0x40008000". For u-boot environment settings, please see the iWave documentation that should come with the boards.


[1] https://github.com/renesas-rz/renesas-cip
[2] http://www.iwavesystems.com/rz-g1m-qseven-development-kit.html

Kind regards, Chris
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20170620/5f769766/attachment.html>
