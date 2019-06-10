From: daniel.sangorrin@toshiba.co.jp (daniel.sangorrin at toshiba.co.jp)
Date: Mon, 10 Jun 2019 06:52:36 +0000
Subject: [cip-dev] gitlab-ci for CIP tiny profile (Deby)
In-Reply-To: <20190606143934.cttthxnvwjfxtsrp@demogorgon>
References: <20190606065138.ggobgsedasddp2v2@demogorgon>
	<20190606143934.cttthxnvwjfxtsrp@demogorgon>
Message-ID: <TY2PR01MB3323861584A80E70010AC415D0130@TY2PR01MB3323.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Michael,

> From: Adler, Michael <michael.adler@siemens.com>
[snip]
> Meanwhile, various workarounds are possible:
> 
> * Use su/sudo in your gitlab-ci.yml to run bitbake as non-root user

I tried but I got this weird behavior:
https://gitlab.com/cip-project/cip-core/deby/-/jobs/228110647

$ export USER_ID=30000
$ /bin/bash /kas/docker-entrypoint
$ whoami
root
$ cat /etc/passwd
builder:x:30000:30000::/builder:/bin/sh
$ su - builder
$ whoami
root <-- not builder!
$ kas build --target core-image-minimal meta-cip-bbb/kas-bbb.yml
    Do not use Bitbake as root.
ERROR: Job failed: command terminated with exit code 1

> * Fork the kas Docker image and insert a USER directive [4]
> * ...
> 
> As usual, it is better to push the fix upstream instead of downstream and fix the bug in Gitlab runner.
> Then I could also get rid of this [5] ugly workaround :-)
> 
> I should be back on Tuesday here. So long, Michael.

Happy Pfingstmontag ;)

Thanks,
Daniel

> 
> [1] https://gitlab.com/cip-project/cip-core/deby/-/jobs/226291592
> [2]
> https://github.com/siemens/kas/blob/90ae592ff1b835bb7a8ee5999fe0d619242972c5/docker-entrypoint
> [3] https://gitlab.com/gitlab-org/gitlab-runner/issues/4125
> [4] https://docs.docker.com/engine/reference/builder/#user
> [5]
> https://gitlab.com/cip-playground/gitlab-cloud-ci/blob/master/share/k8s/setup-host-binfmt/daemonset.yaml
> 
> --
> Michael Adler
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE, Otto-Hahn-Ring 6, 81739 Munich, Germany
> 
> Siemens Aktiengesellschaft: Chairman of the Supervisory Board: Gerhard Cromme; Managing Board: Joe Kaeser,
> Chairman, President and Chief Executive Officer; Roland Busch, Lisa Davis, Klaus Helmrich, Janina Kugel,
> Siegfried Russwurm, Ralf P. Thomas; Registered offices: Berlin and Munich, Germany; Commercial registries:
> Berlin Charlottenburg, HRB 12300, Munich, HRB 6684; WEEE-Reg.-No. DE 23691322
