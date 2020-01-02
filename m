From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Thu, 2 Jan 2020 16:20:07 +0000
Subject: [cip-dev] CIP Testing update
Message-ID: <TYAPR01MB22856DAAD2439D6C7F6CDED0B7200@TYAPR01MB2285.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Happy new year to you all!

Just a quick update to go through the latest status and some recent changes to the CIP testing for the Linux Kernel.

# LAVA Labs
We currently have two LAVA labs, lab-cip-renesas and lab-cip-mentor. In total we now host 10 devices plus 2 qemu machines.
See [1] for details.

[1] https://lava.ciplatform.org/scheduler/alldevices


# Continuous Integration
## GitLab CI configuration
CI configuration (specified in .gitlab-ci.yml files) has (mostly) been moved out of the CIP Kernel branches and into a new repository called cip-linux-pipelines [2].
This means that changes can be easily made without getting in the way of the Kernel source maintenance. It also means that there won't be any merge problems for the different branches (e.g. -rt).

[2] https://gitlab.com/cip-project/cip-testing/linux-cip-pipelines/


## stable-rc builds
We are now actively testing stable release candidates for the linux-4.19.y and linux-4.4.y Linux kernels.
Two repositories have been created to manage CI testing of Greg's stable-rc releases.
linux-stable-rc [3] is a simple mirror of Greg's linux-stable-rc repository [4] on kernel.org. However, I've added some webhooks that trigger CI jobs in the linux-stable-rc-ci repository [5], which is where we can view the actual build and test jobs.
As part of the above process, commits are created that mimic the latest commit on the linux-4.[19|4].y branches so that it's clear what has been tested (there is no longer a need to look through the build logs). See [6] for an example of what it looks like.
Any issues are (manually) reported to the linux-stable mailing list.

[3] https://gitlab.com/cip-project/cip-testing/linux-stable-rc/
[4] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/
[5] https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/
[6] https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/commits/linux-4.19.y


## Testing
We now support boot, smc (spectre/meltdown checker) and ltp (Linux Test Project) test cases. (See [7]).
Boot and smc tests are run on every push to the linux-4.[19|4].y-cip branches. LTP tests are run on "release candidates" (see [8]).
Currently the LTP tests are only being run on the Renesas platforms, but hopefully this will change soon.

[7] https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptesting/centalisedtesting/cioverview#tests
[8] https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptesting/centalisedtesting/releasecandidatetesting


## Configurations
The DE0-Nano-SoC and SIMATIC IPC227E boards are now being built for and tested with the CIP branches.
See [9] for an up to date list of all of the configurations that are now built, and what they are tested with.

[9] https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptesting/centalisedtesting/cioverview#cip_kernel_configurations


# Documentation
Various pages have been updated on the CI Wiki. Some listed below:
* CIP Testing working group: https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptesting/ciptestingwg
* CIP Centralised Testing: https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptesting/centalisedtesting
* Continuous Integration overview: https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptesting/centalisedtesting/cioverview
* Release candidate testing: https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptesting/centalisedtesting/releasecandidatetesting
* Reference platforms: https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptesting/cipreferencehardware
* RZ/G2M platform/software info: https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptesting/cipreferencehardware/hihope-rzg2m
* Kanban board: https://gitlab.com/cip-project/cip-testing/linux-cip-ci/-/boards


Let me know if you have any queries.

Kind regards, Chris
