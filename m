From: don.brown@codethink.com (Don Brown)
Date: Mon, 30 Jan 2017 05:51:21 -0500
Subject: [cip-dev] Status Update on CIP - Continuous Integration of the CIP
 kernel using KernelCI and Testing the CIP kernel using LAVA Server v2
Message-ID: <66b290263f02290c10066cda87792e3e@codethink.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Civil Infrastructure Platform (CIP)
Continuous Integration of the CIP kernel using KernelCI and Testing the 
CIP kernel using LAVA Server v2

Hi Everyone,

I am writing to give you an update on where we stand with the Civil 
Infrastructure Platform (CIP).

As many of you know, we are using KernelCI for the Continuous 
Integration component and LAVA v2 for the kernel Testing platform. 
KernelCI performs the kernel builds against specific configurations and 
can verify boots and SOC's as well. Both come with complete results 
reporting to document what went wrong in the build, deployment or 
testing portion with a great level of granularity.

Our Focus:
We started working on this with the scenario of a "Single-Developer at 
their Desk with a Board" needing to build and test a kernel for a 
specific project. This has sharpened our focus on making it "just work," 
understanding that the developer does not have time to devote to the 
setup, configuration and maintenance of a KernelCI and LAVA server and 
cannot use a public service for whatever reason. However, in this day 
and age, we realize how desparately needed these tools are for embedded 
systems providers.

Where We Stand:
We currently have a KernelCI Virtual Machine running with a few sample 
test builds to verify that everything is working. We also have a LAVA v2 
Server Virtual Machine running with a QEMU device and a Beaglebone-Black 
device pre-loaded. Both have a YAML health-check job loaded into their 
respective device types.

This setup allows a developer to compile the kernel in multiple 
configurations to suit the specification of their particular project and 
to write tests for the appropriate actions in LAVA to thouroughly prove 
the kernel. The tests can help fulfill and properly document any 
customer specifications or regulatory requirements built into the 
specific project.

We are approaching a beta release of the CIP Kernel along with the 
KernelCI & LAVA v2 Virtual Machine in Week 6 of 2017 before the Embedded 
Linux Conference. For the early adopters, we've provided links to the 
CIP-Kernel[1], the KernelCI[2] project, and the LAVA v2[3] Project. 
Tutorials have been created for both the KernelCI[4] and LAVA v2[5] 
Virtual Machines setup and configuration.

On a technical note, we are working on merging the two Virtual Machines 
together to ease the burden on the "Single Developer at their Desk with 
a Board" scenario.

Links:
[1] The CIP Kernel: https://gitlab.com/cip-project/linux-cip

[2] The KernelCI Virtual Machine files: 
https://gitlab.com/cip-project/kernelci-debian

[3] The LAVA v2 Virtual Machine files: 
https://gitlab.com/cip-project/lava2-badsd

[4] Tutorial: How to Set up and Configure a KernelCI Virtual Machine: 
https://wiki.linuxfoundation.org/civilinfrastructureplatform/testingkernelcivmsetup

[5] Tutorial: How to Set up and Configure a LAVA v2 Virtual Machine: 
https://wiki.linuxfoundation.org/civilinfrastructureplatform/testinglavav2vmsetup

Thank you!


-- 
Don Brown
Codethink, Ltd.
Software Engineering Consultant
Indianapolis, IN USA
Email: don.brown at codethink.co.uk
Mobile: +1 317-560-0513
