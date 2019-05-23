From: daniel.sangorrin@toshiba.co.jp (daniel.sangorrin at toshiba.co.jp)
Date: Thu, 23 May 2019 03:00:48 +0000
Subject: [cip-dev] [ANNOUNCE] Introducing gitlab-cloud-ci. Perform
 ISAR-based CI builds in the cloud.
In-Reply-To: <20190521130917.hqjjbaoflstm7ycg@demogorgon>
References: <20190521130917.hqjjbaoflstm7ycg@demogorgon>
Message-ID: <TY2PR01MB3323A4409E75E7A36F45BA0AD0010@TY2PR01MB3323.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Michael,

> From: Adler, Michael
> I have created a little Python tool called gitlab-cloud-ci [1] which allows you to set up an AWS-based
> infrastructure to perform ISAR CI-builds.
> It does:
> 
> * Create a Kubernetes-cluster on AWS from scratch
> * Scale horizontally: run an (almost) arbitrary number of CI jobs in parallel
> * Scale dynamically: scale up and down based on the current workload situation
> * Support running privileged containers for CI pipelines (unlike the default Gitlab runners) which is required for
> Isar builds

Great work!!
# Looking at "share/k8s/setup-host-binfmt/daemonset.yaml" I see that you must have run into some difficult problems.

> The project gitlab-cloud-ci is still in a very early stage (the public release was just yesterday).
> 
> We (Siemens) would like to propose this tool for creating an AWS-based build infrastructure in CIP. As a first step,
> we
> could create a test cluster on AWS and demonstrate building cip-core (deby and isar-based), then discuss further
> steps.

That sounds good to me.
You can ask Jan for a user account on CIP AWS account.
If you are not able to allocate resources (e.g.: EC2, S3, Route53) for the test cluster please let us know.
Once you finish the initial test, we should be able to estimate the cost of using the cluster and probably ask the CIP board members to approve.

Thanks,
Daniel

> 
> Kind regards,
> Michael
> 
> [1] https://gitlab.com/cip-playground/gitlab-cloud-ci
> 
> --
> Michael Adler
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE, Otto-Hahn-Ring 6, 81739 Munich, Germany
> 
> Siemens Aktiengesellschaft: Chairman of the Supervisory Board: Gerhard Cromme; Managing Board: Joe Kaeser,
> Chairman, President and Chief Executive Officer; Roland Busch, Lisa Davis, Klaus Helmrich, Janina Kugel,
> Siegfried Russwurm, Ralf P. Thomas; Registered offices: Berlin and Munich, Germany; Commercial registries:
> Berlin Charlottenburg, HRB 12300, Munich, HRB 6684; WEEE-Reg.-No. DE 23691322
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev
