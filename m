From: daniel.sangorrin@toshiba.co.jp (daniel.sangorrin at toshiba.co.jp)
Date: Tue, 9 Apr 2019 09:59:55 +0000
Subject: [cip-dev] CIP testing
Message-ID: <OSAPR01MB3763C9B23B56954E255FEF96D02D0@OSAPR01MB3763.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

Last week I went to the Linaro connect in Bangkok and had very interesting meetings and conversations with other test engineers. 
I also gave a talk [1] that included several Demos using the CIP testing infrastracture.
# Thanks to Renesas for providing the lab, everything worked great!

Summarizing, this is what I got working on our infrastructure:
- I showed how to convert Fuego tests into LAVA/Linaro test-definitions
https://lava.ciplatform.org/scheduler/job/1051/definition
https://github.com/sangorrin/test-definitions/tree/master/automated/linux/fuego
- I showed how to run any Fuego test from LAVA natively (I used Debos for the file system, but ISAR should work too)
https://lava.ciplatform.org/scheduler/job/1050/definition

[Note] apart from that I also showed how to run Fuego with Gitlab, Ktest (any Fuego test, including some LTP test case, can be used to bisect or check a series of patches), Yocto Ptests, and Linaro test definitions.

Other than that, I thought that it would be great if we can collaborate a bit more with other LTS kernel testing efforts such as LKFT (or KernelCI in the future). Not sure where to start that collaboration but I will give a few hints (some links provided by Naresh Kamboju):

- Test definitions
  - LKFT: https://github.com/Linaro/test-definitions/
  - CIP: https://gitlab.com/cip-project/cip-testing/cip-kernel-tests/tree/master

- Jobs definitions using templates (useful when you manage multiple devices)
  - https://git.linaro.org/ci/job/configs.git/tree/openembedded-lkft/lava-job-definitions

- Jenkins interface (maybe we can collaborate on using Gitlab instead)
  - https://ci.linaro.org/job/openembedded-lkft-linux-stable-rc-4.19/131/DISTRO=lkft,MACHINE=intel-corei7-64,label=docker-lkft/

Thanks,
Daniel

[1] https://static.sched.com/hosted_files/bkk19/5f/linaro-connect-sangorrin-april2019.pdf
