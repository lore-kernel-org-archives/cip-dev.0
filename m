From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Wed, 28 Jun 2017 12:06:50 +0900
Subject: [cip-dev] Renesas dev CIP repository announcement
In-Reply-To: <TY1PR06MB0702667AD2F56BEBDFFCF9A1B7C50@TY1PR06MB0702.apcprd06.prod.outlook.com>
References: <TY1PR06MB0702667AD2F56BEBDFFCF9A1B7C50@TY1PR06MB0702.apcprd06.prod.outlook.com>
Message-ID: <001c01d2efbb$9603f410$c20bdc30$@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Chris,

> -----Original Message-----
> From: cip-dev-bounces at lists.cip-project.org [mailto:cip-dev-bounces at lists.cip-project.org] On Behalf Of Chris Paterson
> Sent: Tuesday, June 20, 2017 5:49 PM
> To: cip-dev at lists.cip-project.org
> Subject: [cip-dev] Renesas dev CIP repository announcement
> 
> Dear CIP friends,
> 
> 
> 
> I?d like to announce the availability of a development repo [1] based on the CIP Kernel for the iWave RZ/G1M Qseven Development
> Platform [2].
> 
> 
> 
> The main aim of this repository is to allow CIP users to get up and running with the Renesas CIP reference platform. Please note that
> this is just an interim step as support for the platform is added upstream/backported to the CIP Kernel.
> 
> 
> 
> Currently there are two branches, one based on v4.4.55-cip3, and the other based on v4.4.69-cip4.
> 
> 
> 
> Please use the ?shmobile_defconfig? configuration when compiling, and use r8a7743-iwg20m.dtb. uImage LOADADDR should be set
> to "0x40008000". For u-boot environment settings, please see the iWave documentation that should come with the boards.
> 
> 
> 
> 
> 
> [1] https://github.com/renesas-rz/renesas-cip
> 
> [2] http://www.iwavesystems.com/rz-g1m-qseven-development-kit.html <http://www.iwavesystems.com/rz-g1m-qseven-
> development-kit.html>

I just wanted to tell you that I managed to build and boot the CIP kernel on the iwg20m board from tftpboot.

The only problem I had was that the original u-boot environment (kernel 3.10) used /dev/mmcblk2p2, whereas
for kernel CIP 4.4 (using the same original filesystem) I had to change that to root=/dev/mmcblk0p2.

Apart from that:
   - the upper blue usb 3 connector doesn't seem to work. (it didn't work either on the factory kernel 3.10)
   - reboot doesn't seem to work (it works on the factory kernel 3.10).

By the way, do you have some test script to check that every module is working fine?

Thanks,
Daniel
