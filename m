From: dan.rue@linaro.org (Dan Rue)
Date: Fri, 24 May 2019 09:30:04 -0500
Subject: [cip-dev] [ANNOUNCE] Introducing gitlab-cloud-ci. Perform
 ISAR-based CI builds in the cloud.
In-Reply-To: <20190521130917.hqjjbaoflstm7ycg@demogorgon>
References: <20190521130917.hqjjbaoflstm7ycg@demogorgon>
Message-ID: <20190524143004.usdvezwd46ied6i4@xps.therub.org>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Tue, May 21, 2019 at 01:09:19PM +0000, Adler, Michael wrote:
> Hi everyone,

Hi! I just lurk here (I primarily work on LKFT and kernelci), but this
is really interesting! Thanks for sharing, I'll be following this
closely.

One question, based on something I read in the README: "By default,
unneeded nodes are removed after being idle for 55 minutes. This is
because AWS billing is usually done on an hourly usage."

I thought they billed per-second now days, but looking into it, it seems
that may only be for amazon linux and ubuntu AMIs? I'm not sure what
distro you're using, but it may be a good reason to favor one of those
two. If it is in fact billed hourly, 55 minutes may only cause you to
buy an extra hour most of the time.

Do your builds take advantage of any caching, and if so, how are you
making it persistent?

I'm also really curious about your experience with k8s, but mostly I'm
interested to find out how it works for this project over time in terms
of stability, cost, complexity, etc.

Thanks again! If there is any place else I can follow information about
this let me know.

Dan

> 
> I have created a little Python tool called gitlab-cloud-ci [1] which allows you to set up an AWS-based infrastructure to perform ISAR CI-builds.
> It does:
> 
> * Create a Kubernetes-cluster on AWS from scratch
> * Scale horizontally: run an (almost) arbitrary number of CI jobs in parallel
> * Scale dynamically: scale up and down based on the current workload situation
> * Support running privileged containers for CI pipelines (unlike the default Gitlab runners) which is required for Isar builds
> 
> The project gitlab-cloud-ci is still in a very early stage (the public release was just yesterday).
> 
> We (Siemens) would like to propose this tool for creating an AWS-based build infrastructure in CIP. As a first step, we
> could create a test cluster on AWS and demonstrate building cip-core (deby and isar-based), then discuss further steps.
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
> Siemens Aktiengesellschaft: Chairman of the Supervisory Board: Gerhard Cromme; Managing Board: Joe Kaeser, Chairman, President and Chief Executive Officer; Roland Busch, Lisa Davis, Klaus Helmrich, Janina Kugel, Siegfried Russwurm, Ralf P. Thomas; Registered offices: Berlin and Munich, Germany; Commercial registries: Berlin Charlottenburg, HRB 12300, Munich, HRB 6684; WEEE-Reg.-No. DE 23691322
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev

-- 
Linaro - Kernel Validation
