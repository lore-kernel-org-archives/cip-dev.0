From: michael.adler@siemens.com (Adler, Michael)
Date: Thu, 6 Jun 2019 14:39:35 +0000
Subject: [cip-dev] gitlab-ci for CIP tiny profile (Deby)
In-Reply-To: <20190606065138.ggobgsedasddp2v2@demogorgon>
Message-ID: <20190606143934.cttthxnvwjfxtsrp@demogorgon>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Alright, the token exchange was successful this morning and gitlab-cloud-ci runner should be visible to all child
projects now.  However, we ran into an issue [1] when executing Daniel's CI pipeline:

Gitlab runner does not execute the container's entrypoint [2] which in the above scenario is responsible for switching
to a non-privileged user. This is actually a bug in the Gitlab Kubernetes runner itself [3].  Maybe someone here is
eager enough to fix it :-)? The fix itself should be just a few lines of code, but testing will require some time and
effort.

Meanwhile, various workarounds are possible:

* Use su/sudo in your gitlab-ci.yml to run bitbake as non-root user
* Fork the kas Docker image and insert a USER directive [4]
* ...

As usual, it is better to push the fix upstream instead of downstream and fix the bug in Gitlab runner.
Then I could also get rid of this [5] ugly workaround :-)

I should be back on Tuesday here. So long, Michael.

[1] https://gitlab.com/cip-project/cip-core/deby/-/jobs/226291592
[2] https://github.com/siemens/kas/blob/90ae592ff1b835bb7a8ee5999fe0d619242972c5/docker-entrypoint
[3] https://gitlab.com/gitlab-org/gitlab-runner/issues/4125
[4] https://docs.docker.com/engine/reference/builder/#user
[5] https://gitlab.com/cip-playground/gitlab-cloud-ci/blob/master/share/k8s/setup-host-binfmt/daemonset.yaml

-- 
Michael Adler
Siemens AG, Corporate Technology, CT RDA IOT SES-DE, Otto-Hahn-Ring 6, 81739 Munich, Germany

Siemens Aktiengesellschaft: Chairman of the Supervisory Board: Gerhard Cromme; Managing Board: Joe Kaeser, Chairman, President and Chief Executive Officer; Roland Busch, Lisa Davis, Klaus Helmrich, Janina Kugel, Siegfried Russwurm, Ralf P. Thomas; Registered offices: Berlin and Munich, Germany; Commercial registries: Berlin Charlottenburg, HRB 12300, Munich, HRB 6684; WEEE-Reg.-No. DE 23691322
