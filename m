From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Mon, 11 Nov 2019 09:22:05 +0000
Subject: [cip-dev] Build fail for linux-4.4.y-rc
Message-ID: <TYAPR01MB2285C54E0BFE44F1970EFA7DB7740@TYAPR01MB2285.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello maintainers,

I've seen a failure this morning with our linux stable-rc build testing.

Version: 4cb9b88c651a2fff886dd64b6d797343e7ddb4dd Linux 4.4.201-rc1
Arch: arm
Config: moxa_mxc_defconfig

Pipeline: https://gitlab.com/cip-playground/linux-stable-rc-ci/pipelines/95016985
Failure: https://gitlab.com/cip-playground/linux-stable-rc-ci/pipelines/95016985/failures
Log: https://gitlab.com/cip-playground/linux-stable-rc-ci/-/jobs/346974180
Config: https://gitlab.com/cip-playground/linux-stable-rc-ci/-/jobs/346974180

All other configurations that we build were successful.

Kind regards, Chris
