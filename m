From: hung.tran.jy@renesas.com (Hung Tran)
Date: Fri, 18 Oct 2019 03:02:18 +0000
Subject: [cip-dev] Related to spectre-meltdown-checker test
In-Reply-To: <TY2PR01MB22014D2886FCA8BD532AC95AC6BA0@TY2PR01MB2201.jpnprd01.prod.outlook.com>
References: <OSAPR01MB1827FAE9FE172BCA8672D862D9BA0@OSAPR01MB1827.jpnprd01.prod.outlook.com>
	<TYAPR01MB22859CF112D5AA31C497332FB7BA0@TYAPR01MB2285.jpnprd01.prod.outlook.com>
	<TYAPR01MB2285D79214DDB8C511FCA577B7BA0@TYAPR01MB2285.jpnprd01.prod.outlook.com>
	<TY2PR01MB22014D2886FCA8BD532AC95AC6BA0@TY2PR01MB2201.jpnprd01.prod.outlook.com>
Message-ID: <TY2PR01MB22019CCA70066DE2B891475AC66C0@TY2PR01MB2201.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Iwamatsu-san, Chris,

I would like to inform my progress in the Spectre Meltdown test.
In Aug, Iwamatsu-san had added spectre-meltdown-checker test to CIP LAVA.
I checked the result on Renesas board https://lava.ciplatform.org/scheduler/job/3473#L745, and see some problems.

The test show result Unknown in Spectre Variant 1, and Vulnerable in Variant 3B and Variant 4.
Unknown result for Variant 1 comes from missing tool. We have to add kernel Image and binutils to rootfs.
I have tried that and result for Variant 1 is Vulnerable too.

I spend some times to check the test script, which come from https://github.com/speed47/spectre-meltdown-checker
After checked, I concluded that this is actually mistake of the script.
I have reported this issue to original github repo https://github.com/speed47/spectre-meltdown-checker/issues/308
Unfortunately, there is no response from script developer until now...


Regards,
Hung.


-----Original Message-----
From: cip-dev-bounces@lists.cip-project.org [mailto:cip-dev-bounces at lists.cip-project.org] On Behalf Of Hung Tran
Sent: Friday, September 6, 2019 4:48 PM
To: Chris Paterson <Chris.Paterson2@renesas.com>; Kazuhiro Fujita <kazuhiro.fujita.jg@renesas.com>; cip-dev at lists.cip-project.org
Subject: Re: [cip-dev] Related to spectre-meltdown-checker test

Hello Fujita-san, Chris,

I believe Spectre patches are NOT provided by ARM.
They are contributed by community.
According to test result from Chris, only Spectre Variant 2 is migrated on G2M 4.19.
Other vulnerabilities are still remain.

Regards,
Hung.


-----Original Message-----
From: cip-dev-bounces@lists.cip-project.org [mailto:cip-dev-bounces at lists.cip-project.org] On Behalf Of Chris Paterson
Sent: Friday, September 6, 2019 4:28 PM
To: Kazuhiro Fujita <kazuhiro.fujita.jg@renesas.com>; cip-dev at lists.cip-project.org
Subject: Re: [cip-dev] Related to spectre-meltdown-checker test

> From: cip-dev-bounces at lists.cip-project.org
> <cip-dev-bounces@lists.cip- project.org> On Behalf Of Chris Paterson
> Sent: 06 September 2019 10:10
> 
> Hello,
> 
> > From: cip-dev-bounces at lists.cip-project.org
> > <cip-dev-bounces@lists.cip- project.org> On Behalf Of Kazuhiro 
> > Fujita
> >
> > Hello all,
> >
> > As far as we checked, status of mitigation of Spectre/Meltdown on 
> > Arm processors seems as below:
> >
> > - For 4.4 kernel, patches have not been provided by Arm.
> >   4.4-cip has not been mitigated.
> > - For 4.19 kernel, patches are provided by Arm and upstreamed.
> >   4.19-cip inherited the patches.
> >
> > Is there anyone who knows whether above is correct or not?
> 
> I don't, but for the record here are the most recent results from the 
> Spectre/Meltdown checker:
> 
> Kernel: 4.19.66-cip9_aa6c3bd08
> RZ/G1E (Arm Cortex-A7):
> https://lava.ciplatform.org/results/3483/0_spectre-meltdown-checker-te
> st
> RZ/G1M (Arm Cortex-A15):
> https://lava.ciplatform.org/results/3481/0_spectre-meltdown-checker-te
> st
> RZ/G2E (Arm Cortex-A53):
> https://lava.ciplatform.org/results/3475/0_spectre-meltdown-checker-te
> st
> RZ/G2M (Arm Cortex-A57 + Cortex-A53):
> https://lava.ciplatform.org/results/3473/0_spectre-meltdown-checker-te
> st
> 
> Kernel: 4.4
Kernel: 4.4.188-cip36_7b0f2e14

> RZ/G1E (Arm Cortex-A7):
> https://lava.ciplatform.org/results/3487/0_spectre-meltdown-checker-te
> st
> RZ/G1M (Arm Cortex-A15):
> https://lava.ciplatform.org/results/3485/0_spectre-meltdown-checker-te
> st
> 
> Kind regards, Chris
> 
> >
> > Thanks,
> > Fujita
> >
> >
> > > -----Original Message-----
> > > From: cip-dev-bounces at lists.cip-project.org
> > > <cip-dev-bounces@lists.cip- project.org> On Behalf Of Nobuhiro 
> > > Iwamatsu
> > > Sent: Wednesday, August 28, 2019 11:26 AM
> > > To: Chris Paterson <Chris.Paterson2@renesas.com>
> > > Cc: cip-dev at lists.cip-project.org
> > > Subject: [cip-dev] [PATCH 3/3] Add spectre-meltdown-checker test
> > >
> > > Signed-off-by: Nobuhiro Iwamatsu
> <nobuhiro1.iwamatsu@toshiba.co.jp>
> > > ---
> > >  lava_templates/r8a7743-iwg20d-q7_smc.yaml     | 69
> > +++++++++++++++++++
> > >  lava_templates/r8a7745-iwg22d-sodimm_smc.yaml | 69
> > +++++++++++++++++++
> > >  lava_templates/r8a774c0-ek874_smc.yaml        | 69
> > +++++++++++++++++++
> > >  submit_tests.sh                               |  1 +
> > >  4 files changed, 208 insertions(+)  create mode 100644 
> > > lava_templates/r8a7743-iwg20d-q7_smc.yaml
> > >  create mode 100644 lava_templates/r8a7745-iwg22d-sodimm_smc.yaml
> > >  create mode 100644 lava_templates/r8a774c0-ek874_smc.yaml
> > >
> > > diff --git a/lava_templates/r8a7743-iwg20d-q7_smc.yaml
> > > b/lava_templates/r8a7743-iwg20d-q7_smc.yaml
> > > new file mode 100644
> > > index 0000000..0e10584
> > > --- /dev/null
> > > +++ b/lava_templates/r8a7743-iwg20d-q7_smc.yaml
> > > @@ -0,0 +1,69 @@
> > > +# Copyright (C) 2019, Renesas Electronics Europe GmbH, Chris 
> > > +Paterson
> > > <chris.paterson2@renesas.com>
> > > +# SPDX-License-Identifier:	AGPL-3.0
> > > +# This program is free software: you can redistribute it and/or 
> > > +modify it
> > > under the terms of the GNU Affero General Public License as 
> > > published
> by
> > > the Free Software Foundation, version 3.
> > > +# This program is distributed in the hope that it will be useful, 
> > > +but
> > > WITHOUT ANY WARRANTY; without even the implied warranty of
> > MERCHANTABILITY
> > > or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General
> > Public
> > > License for more details.
> > > +# You should have received a copy of the GNU Affero General 
> > > +Public
> > > License along with this program. If not, see 
> > > <http://www.gnu.org/licenses/>.
> > > +
> > > +device_type: r8a7743-iwg20d-q7
> > > +job_name: JOB_NAME
> > > +
> > > +timeouts:
> > > +  job:
> > > +    minutes: 15
> > > +  action:
> > > +    minutes: 10
> > > +  connection:
> > > +    minutes: 5
> > > +priority: medium
> > > +visibility: public
> > > +
> > > +notify:
> > > +  criteria:
> > > +    status: finished
> > > +  verbosity: verbose
> > > +  recipients:
> > > +  - to:
> > > +     method: email
> > > +     email: cip-testing-results at lists.cip-project.org
> > > +
> > > +# ACTION_BLOCK
> > > +actions:
> > > +- deploy:
> > > +    timeout:
> > > +      minutes: 10
> > > +    to: tftp
> > > +    os: oe
> > > +    kernel:
> > > +      url: KERNEL_URL
> > > +      type: uimage
> > > +    nfsrootfs:
> > > +      url: https://s3-us-west-2.amazonaws.com/download.cip-
> > > project.org/cip-core/iwg20m/core-image-minimal-iwg20m.tar.gz
> > > +      compression: gz
> > > +    dtb:
> > > +      url: DTB_URL
> > > +
> > > +# BOOT_BLOCK
> > > +- boot:
> > > +    auto_login:
> > > +      login_prompt: 'ciphost login:'
> > > +      username: root
> > > +    prompts:
> > > +      - 'cip-project#'
> > > +    method: u-boot
> > > +    commands: nfs
> > > +    timeout:
> > > +      minutes: 5
> > > +
> > > +# Spectre meltdown checker
> > > +# TEST_BLOCK
> > > +- test:
> > > +   timeout:
> > > +     minutes: 10
> > > +   definitions:
> > > +   - repository: https://github.com/Linaro/test-definitions.git
> > > +     from: git
> > > +     path: automated/linux/spectre-meltdown-checker-test/spectre-
> > > meltdown-checker-test.yaml
> > > +     name: spectre-meltdown-checker-test
> > > +     timeout:
> > > +       minutes: 10
> > > +
> > > diff --git a/lava_templates/r8a7745-iwg22d-sodimm_smc.yaml
> > > b/lava_templates/r8a7745-iwg22d-sodimm_smc.yaml
> > > new file mode 100644
> > > index 0000000..180d94a
> > > --- /dev/null
> > > +++ b/lava_templates/r8a7745-iwg22d-sodimm_smc.yaml
> > > @@ -0,0 +1,69 @@
> > > +# Copyright (C) 2019, Renesas Electronics Europe GmbH, Chris 
> > > +Paterson
> > > <chris.paterson2@renesas.com>
> > > +# SPDX-License-Identifier:	AGPL-3.0
> > > +# This program is free software: you can redistribute it and/or 
> > > +modify it
> > > under the terms of the GNU Affero General Public License as 
> > > published
> by
> > > the Free Software Foundation, version 3.
> > > +# This program is distributed in the hope that it will be useful, 
> > > +but
> > > WITHOUT ANY WARRANTY; without even the implied warranty of
> > MERCHANTABILITY
> > > or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General
> > Public
> > > License for more details.
> > > +# You should have received a copy of the GNU Affero General 
> > > +Public
> > > License along with this program. If not, see 
> > > <http://www.gnu.org/licenses/>.
> > > +
> > > +device_type: r8a7745-iwg22d-sodimm
> > > +job_name: JOB_NAME
> > > +
> > > +timeouts:
> > > +  job:
> > > +    minutes: 15
> > > +  action:
> > > +    minutes: 10
> > > +  connection:
> > > +    minutes: 5
> > > +priority: medium
> > > +visibility: public
> > > +
> > > +notify:
> > > +  criteria:
> > > +    status: finished
> > > +  verbosity: verbose
> > > +  recipients:
> > > +  - to:
> > > +     method: email
> > > +     email: cip-testing-results at lists.cip-project.org
> > > +
> > > +# ACTION_BLOCK
> > > +actions:
> > > +- deploy:
> > > +    timeout:
> > > +      minutes: 10
> > > +    to: tftp
> > > +    os: oe
> > > +    kernel:
> > > +      url: KERNEL_URL
> > > +      type: uimage
> > > +    nfsrootfs:
> > > +      url: https://s3-us-west-2.amazonaws.com/download.cip-
> > > project.org/ciptesting/cip-lava/rfs/core-image-minimal-iwg22m-
> > > 20181126155628.rootfs.tar.gz
> > > +      compression: gz
> > > +    dtb:
> > > +      url: DTB_URL
> > > +
> > > +# BOOT_BLOCK
> > > +- boot:
> > > +    auto_login:
> > > +      login_prompt: 'iwg22m login: '
> > > +      username: root
> > > +    prompts:
> > > +      - 'root at iwg22m'
> > > +    method: u-boot
> > > +    commands: nfs
> > > +    timeout:
> > > +      minutes: 5
> > > +
> > > +# Spectre meltdown checker
> > > +# TEST_BLOCK
> > > +- test:
> > > +   timeout:
> > > +     minutes: 10
> > > +   definitions:
> > > +   - repository: https://github.com/Linaro/test-definitions.git
> > > +     from: git
> > > +     path: automated/linux/spectre-meltdown-checker-test/spectre-
> > > meltdown-checker-test.yaml
> > > +     name: spectre-meltdown-checker-test
> > > +     timeout:
> > > +       minutes: 10
> > > +
> > > diff --git a/lava_templates/r8a774c0-ek874_smc.yaml
> > > b/lava_templates/r8a774c0-ek874_smc.yaml
> > > new file mode 100644
> > > index 0000000..e244a0e
> > > --- /dev/null
> > > +++ b/lava_templates/r8a774c0-ek874_smc.yaml
> > > @@ -0,0 +1,69 @@
> > > +# Copyright (C) 2019, Renesas Electronics Europe GmbH, Chris 
> > > +Paterson
> > > <chris.paterson2@renesas.com>
> > > +# SPDX-License-Identifier:	AGPL-3.0
> > > +# This program is free software: you can redistribute it and/or 
> > > +modify it
> > > under the terms of the GNU Affero General Public License as 
> > > published
> by
> > > the Free Software Foundation, version 3.
> > > +# This program is distributed in the hope that it will be useful, 
> > > +but
> > > WITHOUT ANY WARRANTY; without even the implied warranty of
> > MERCHANTABILITY
> > > or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General
> > Public
> > > License for more details.
> > > +# You should have received a copy of the GNU Affero General 
> > > +Public
> > > License along with this program. If not, see 
> > > <http://www.gnu.org/licenses/>.
> > > +
> > > +device_type: r8a774c0-ek874
> > > +job_name: JOB_NAME
> > > +
> > > +timeouts:
> > > +  job:
> > > +    minutes: 15
> > > +  action:
> > > +    minutes: 10
> > > +  connection:
> > > +    minutes: 5
> > > +priority: medium
> > > +visibility: public
> > > +
> > > +notify:
> > > +  criteria:
> > > +    status: finished
> > > +  verbosity: verbose
> > > +  recipients:
> > > +  - to:
> > > +     method: email
> > > +     email: cip-testing-results at lists.cip-project.org
> > > +
> > > +# ACTION_BLOCK
> > > +actions:
> > > +- deploy:
> > > +    timeout:
> > > +      minutes: 10
> > > +    to: tftp
> > > +    os: oe
> > > +    kernel:
> > > +      url: KERNEL_URL
> > > +      type: image
> > > +    nfsrootfs:
> > > +      url: https://s3-us-west-2.amazonaws.com/download.cip-
> > > project.org/ciptesting/cip-lava/rfs/core-image-bsp-ek874.tar.gz
> > > +      compression: gz
> > > +    dtb:
> > > +      url: DTB_URL
> > > +
> > > +# BOOT_BLOCK
> > > +- boot:
> > > +    auto_login:
> > > +      login_prompt: 'ek874 login:'
> > > +      username: root
> > > +    prompts:
> > > +      - 'root at ek874'
> > > +    method: u-boot
> > > +    commands: nfs
> > > +    timeout:
> > > +      minutes: 5
> > > +
> > > +# Spectre meltdown checker
> > > +# TEST_BLOCK
> > > +- test:
> > > +   timeout:
> > > +     minutes: 10
> > > +   definitions:
> > > +   - repository: https://github.com/Linaro/test-definitions.git
> > > +     from: git
> > > +     path: automated/linux/spectre-meltdown-checker-test/spectre-
> > > meltdown-checker-test.yaml
> > > +     name: spectre-meltdown-checker-test
> > > +     timeout:
> > > +       minutes: 10
> > > +
> > > diff --git a/submit_tests.sh b/submit_tests.sh index 
> > > 5f83182..b1a275e 100755
> > > --- a/submit_tests.sh
> > > +++ b/submit_tests.sh
> > > @@ -150,6 +150,7 @@ find_jobs () {
> > >
> > >  			print_kernel_info
> > >  			create_job healthcheck
> > > +			create_job smc
> > >  		done < $jobfile
> > >  	done
> > >  }
> > > --
> > > 2.20.1
> > >
> > > _______________________________________________
> > > cip-dev mailing list
> > > cip-dev at lists.cip-project.org
> > > https://lists.cip-project.org/mailman/listinfo/cip-dev
> > _______________________________________________
> > cip-dev mailing list
> > cip-dev at lists.cip-project.org
> > https://lists.cip-project.org/mailman/listinfo/cip-dev
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev
_______________________________________________
cip-dev mailing list
cip-dev at lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev
_______________________________________________
cip-dev mailing list
cip-dev at lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev
