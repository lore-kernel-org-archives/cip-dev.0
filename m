From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Fri, 28 Jun 2019 07:14:59 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip] Add gitlab-ci.yaml
In-Reply-To: <bc898cd0-bd5d-b4d6-7274-74a6d4690234@siemens.com>
References: <20190627131250.7932-1-chris.paterson2@renesas.com>
	<20190627131250.7932-2-chris.paterson2@renesas.com>
	<OSBPR01MB30776A1D153EA8FBDCCD5B89D0FC0@OSBPR01MB3077.jpnprd01.prod.outlook.com>
	<bc898cd0-bd5d-b4d6-7274-74a6d4690234@siemens.com>
Message-ID: <TYAPR01MB2285B5765A58F1AFCE66ED26B7FC0@TYAPR01MB2285.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org


> From: Jan Kiszka <jan.kiszka@siemens.com>
> Sent: 28 June 2019 06:48
> 
> On 28.06.19 02:20, daniel.sangorrin at toshiba.co.jp wrote:
> > It seems that a lot of people have the same problem.
> > https://gitlab.com/gitlab-org/gitlab-ce/issues/15041
> 
> Maybe a combination of a CI-only repo and a hook that triggers a build on
> changes in the external (and unchanged) source repo can do the trick.

Yes this is one solution, however you wouldn't get the pretty green ticks that show a commit has been verified.

Chris

> 
> Jan
> 
> >
> >> -----Original Message-----
> >> From: cip-dev-bounces at lists.cip-project.org <cip-dev-bounces@lists.cip-
> project.org> On Behalf Of Chris Paterson
> >> Sent: Thursday, June 27, 2019 10:13 PM
> >> To: cip-dev at lists.cip-project.org
> >> Subject: [cip-dev] [PATCH 4.4.y-cip] Add gitlab-ci.yaml
> >>
> >> This is configured to build and test for the following configuration:
> >>
> >> 1. ARCH: arm
> >>     CONFIGS: shmobile_defconfig
> >>     BOARDS: r8a7743-iwg20d
> >>
> >> Build/test Docker containers and scripts are created by the
> >> https://gitlab.com/cip-playground/linux-cip-ci repository.
> >>
> >> Over time support will be added for all CIP supported architectures and
> >> configurations. At the moment only simple boot tests are run. Real tests
> >> will be added in the future. These changes should all all be handled in
> >> the linux-cip-ci repository.
> >>
> >> Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
> >> ---
> >>
> >> In theory this file is only required in our GitLab repository. However if
> >> we add it there the automatic mirroring from the kernel.org repository
> >> will be broken.
> >>
> >> I also tried the GitLab option to create a new repository for CI/CD
> >> 'only'. However this also has the exact same problem.
> >>
> >> This means that the best/easiest approach will be to just add the
> >> .gitlab-ci.yml file directly to the kernel.org repository. Most people can
> >> ignore it.
> >>
> >> There may well be some chrun in this file as linux-cip-ci improves, but
> >> this is a good starting point.
> >>
> >>   .gitlab-ci.yml | 27 +++++++++++++++++++++++++++
> >>   1 file changed, 27 insertions(+)
> >>   create mode 100644 .gitlab-ci.yml
> >>
> >> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> >> new file mode 100644
> >> index 000000000000..4e949ac75b7b
> >> --- /dev/null
> >> +++ b/.gitlab-ci.yml
> >> @@ -0,0 +1,27 @@
> >> +variables:
> >> +  GIT_STRATEGY: none
> >> +  DOCKER_DRIVER: overlay2
> >> +
> >> +before_script:
> >> +  - cd /opt/linux
> >> +  - git fetch origin
> >> +  - git checkout $CI_COMMIT_SHA
> >> +
> >> +build_arm_shmobile_defconfig:
> >> +  stage: build
> >> +  image: registry.gitlab.com/cip-playground/linux-cip-ci:build-latest
> >> +  script:
> >> +    - /opt/build_kernel.sh arm shmobile_defconfig
> >> +  artifacts:
> >> +    name: "$CI_JOB_NAME"
> >> +    when: on_success
> >> +    paths:
> >> +      - output
> >> +
> >> +run_tests:
> >> +  stage: test
> >> +  image: registry.gitlab.com/cip-playground/linux-cip-ci:test-latest
> >> +  when: always
> >> +  before_script: []
> >> +  script:
> >> +    - /opt/submit_tests.sh
> >> --
> >> 2.17.1
> >>
> >> _______________________________________________
> >> cip-dev mailing list
> >> cip-dev at lists.cip-project.org
> >> https://lists.cip-project.org/mailman/listinfo/cip-dev
> > _______________________________________________
> > cip-dev mailing list
> > cip-dev at lists.cip-project.org
> > https://lists.cip-project.org/mailman/listinfo/cip-dev
> >
> 
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux
