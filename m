From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Mon, 3 Feb 2020 08:51:18 +0000
Subject: [cip-dev] [PATCH linux-4.19.y-cip] gitlab-ci: Use external
 linux-cip-pipelines repository to define CI
In-Reply-To: <a373951f-a300-d2c0-2fa2-e45e269d6600@siemens.com>
References: <20191121160008.4886-1-chris.paterson2@renesas.com>
 <a373951f-a300-d2c0-2fa2-e45e269d6600@siemens.com>
Message-ID: <TYAPR01MB228554BA1F639D4323DF6CD3B7000@TYAPR01MB2285.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Jan,

> From: Jan Kiszka <jan.kiszka@siemens.com>
> Sent: 31 January 2020 13:02
> 
> On 21.11.19 17:00, Chris Paterson wrote:
> > Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
> > ---

[...]

> > +include:
> > +  - https://gitlab.com/cip-project/cip-testing/linux-cip-
> pipelines/raw/master/linux-cip-pipeline.yml
> > +  - https://gitlab.com/cip-project/cip-testing/linux-cip-
> pipelines/raw/master/trees/linux-4.19.y-cip.yml
> >
> 
> This causes an interesting error scenario for gitlabs on private networks:
> 
> "This GitLab CI configuration is invalid: Resolving config took longer
> than expected"
> 
> The reason is that gitlab tries to process any found .gitlab-ci.yml
> file, in our case by fetching the includes. But when the gitlab instance
> is isolated from public networks, the above will happen, and the user
> will receive a notice about a failed pipeline on each update.

Hmmm this is a good point. TBH, I didn't even consider it when making the above changes.

> 
> The user can likely work around this by setting an invalid CI file for
> such projects (we are validating this ATM), but I wonder if we should
> rather set our .gitlab-ci.yml to a non-standard name. 

Moving .gitlab-ci.yml to another filename could be one approach to avoid failed CI jobs in local/offline GitLab instances.
It wouldn't have much impact on CIP, we'd just have to change the CI settings to look for the new filename.
Does anyone have any other opinions/ideas?

For an offline machine though you'd have to add a gitlab-ci file to point to an internal clone/fork of linux-cip-pipelines. You'd also have to store the Docker containers from linux-cip-ci somewhere local and update the links etc.

> Or are there
> sufficient scenarios where a user != us can make use of the CI file?

Others could use our current approach (assuming they have the relevant variables set up in the GitLab CI/CD settings). They may want to use different Kernel configurations with their builds, which they can do by updating the .gitlab-ci.yml with their options. For example, replacing the include to the 'tree' yml file with something else:

include:
  - https://gitlab.com/cip-project/cip-testing/linux-cip-pipelines/raw/master/linux-cip-pipeline.yml

build:arm_renesas_shmobile-rt_defconfig:
  extends: .build
  variables:
    BUILD_ARCH: arm
    CONFIG: renesas_shmobile-rt_defconfig
    CONFIG_LOC: url
    CONFIG_URL: https://gitlab.com/patersonc/cip-kernel-config/raw/chris/add_renesas_rt_configs/4.4.y-cip-rt/arm/

test:arm_renesas_shmobile-rt_defconfig:
  extends: .test
  needs: ["build:arm_renesas_shmobile-rt_defconfig"]
  variables:
    BUILD_ARCH: arm
    CONFIG: renesas_shmobile-rt_defconfig
    DEVICES: r8a7743-iwg20d-q7 r8a7745-iwg22d-sodimm r8a77470-iwg23s-sbc
    DTBS: r8a7743-iwg20d-q7-dbcm-ca.dtb r8a7745-iwg22d-sodimm-dbhd-ca.dtb r8a77470-iwg23s-sbc.dtb
    TESTS: boot smc

 
Kind regards, Chris


> 
> Jan
> 
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux
