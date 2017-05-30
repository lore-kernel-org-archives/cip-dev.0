From: agustin.benito@codethink.co.uk (Agustin Benito Bethencourt)
Date: Wed, 31 May 2017 07:36:08 +0900
Subject: [cip-dev] CIP Project releases a tool-box based on LAVA and
 KernelCI to test Linux kernels locally: Board At Desk v0.9.1
Message-ID: <592DF3D8.1080006@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Dear CIP friends,

The Civil Infrastructure Platform project[1], a Linux Foundation 
Initiative, is happy to announce the publication of Board At Desk - 
Single Dev. (B at D) v0.9.1, a customised and easy to deploy instance of 
KernelCI[2] and LAVA[3] projects that should allow developers to test 
Linux kernels on boards connected to their own development machines, 
using the tooling provided by one of the most successful Open Source and 
distributed testing projects, http://www.kernelci.org .

This instance is provided in this first release in two forms:
* As a vagrant VM image/recipe.
* As a VM image, widely called box.

Please visit the CIP Testing project Download page[4] to download the 
first release of Board At Desk - Single Dev. (B at D v0.9.1).

With this effort, the CIP project is trying to create a first step 
towards "shared and trusted testing" by every member and the CIP kernel 
maintainer. It also has as a goal to extend and simplify the current use 
case satisfied by kernelci.org, focusing on those embedded developers 
that have direct access to boards, by reducing the deployment, 
configuration and maintenance effort. Finally, CIP intends to increase 
the number of developers and organizations willing to participate in 
http://www.kernelci.org by providing a simple mechanism to evaluate the 
technologies involved in what CIP consider B at D's upstream projects (LAVA 
and KernelCI).

Some of the most important actions taken by the team behind B at D have 
been focused in two areas:

1. Merged the KernelCI and LAVAv2 Virtual Machines together into one.

KernelCI was based on Ubuntu v14.04, it used Nginx as the Web Server and 
SimpleHTTPServer for the Storage Server which is where the builds are 
stored. LAVA was based on Debian and used the Apache Web Server and the 
Django Content Management System for the Frontend Web Framework. Both 
web servers wanted to use port 80.

The current VM uses Debian Jessie only. It runs KernelCI on Nginx and 
LAVA on Apache on reassigned ports. The KernelCI Storage Server has been 
migrated over to use Nginx on a reassigned port.

2. Connection to the board.

The released VM assumes the usage of an FTDI USB-to-Serial cable to 
connect the host machine to the Beaglebone Black. It uses ser2net to 
route the /dev/ttyUSB0 serial port to a TCP port on the host machine 
which allows the user to use telnet to communicate to the Beaglebone 
Black console for remote login and boot messages. It also allows LAVA to 
use tftp to transfer the kernel directly over to the board eMMC without 
needing to burn an SD Card.

This B at D version supports Beaglebone Black. Renesas RZ/G1M support is in 
progress and the rest of the CIP reference boards will be supported in 
the near future.

Further information about what you will find in B at D v0.9.1 can be found 
in the B at D Feature Page[5].

If you are interested in testing kernels using this version of the 
tooling please meet the developers at the cip-dev mailing list[6]. If 
you find bugs in KernelCI or LAVAv2 themselves, please report them 
upstream. If you find them in the configuration or any of the previously 
described topics, please report them in the CIP-testing bug tracker[7]. 
More general information about the CIP testing project can be found in 
the CIP wiki[8].

You can also read this release announcement on the CIP project blog[9]

[1] https://www.cip-project.org/
[2] https://github.com/kernelci/
[3] https://validation.linaro.org/
[4] https://wiki.linuxfoundation.org/civilinfrastructureplatform/cipdownload
[5] 
https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptestingboardatdesksingledevfeaturepage
[6] https://lists.cip-project.org/mailman/listinfo/cip-dev
[7] https://gitlab.com/cip-project/cip-testing/testing/boards
[8] https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptesting
[9] http://bit.ly/2rhSILs
-- 
Agustin Benito Bethencourt
Principal Consultant - FOSS at Codethink
agustin.benito at codethink.co.uk
