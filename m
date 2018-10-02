From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Wed, 3 Oct 2018 08:33:27 +0900
Subject: [cip-dev] Kernel configurations in the CIP project
In-Reply-To: <6D182B05-3DE6-4377-9BFA-AF45139C9960@bmw-carit.de>
References: <6D182B05-3DE6-4377-9BFA-AF45139C9960@bmw-carit.de>
Message-ID: <005801d45aa8$51f7b1e0$f5e715a0$@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Lukas,

> -----Original Message-----
> From: cip-dev-bounces at lists.cip-project.org
> Hi Robert,
> 
> If I recall our conversation and follow the discussion on cip-dev correctly, you are still
> maintaining the test builds and infrastructure from the CIP project, right?
> 
> Could you provide to Markus Kreidl, Nicholas McGuire (see CC) and me the kernel
> configurations you use in the test builds for the different CIP members?

Not sure about the configs that Robert uses for testing, but the configurations from CIP members can be found here.
https://gitlab.com/cip-project/cip-kernel/cip-kernel-config

> Background:
> 
> Markus Kreidl has written a tool that determines which patches, which hunks of
> those patches are relevant to a given configuration. We would be interested in
> providing an overview of which patches are especially relevant for the given configs
> of a new CIP kernel patchlevel release, and hence, the CIP maintainers (hopefully, it
> is not just Ben) are informed about those and can have a good look at those specific
> patches when they provide a new kernel release version.
> 
> If it useful, we would follow-up how to make that fit nicely into the existing review
> and reporting process. If it not useful, we learned a lesson about our tool.

That sounds very interesting indeed.
It would be nice if you could also map the patches to the LTP tests that need to be run.

Thanks,
Daniel
