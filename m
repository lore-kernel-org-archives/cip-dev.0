From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Tue, 6 Aug 2019 08:33:54 +0000
Subject: [cip-dev] [PATCH linux-4.19.y-cip-rt] Update to run all CIP arm,
 arm64 and x86 configs
In-Reply-To: <20190805153558.5926-1-chris.paterson2@renesas.com>
References: <20190805153558.5926-1-chris.paterson2@renesas.com>
Message-ID: <TYAPR01MB228595574342F7D73B58113BB7D50@TYAPR01MB2285.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Pavel, all,

> From: Chris Paterson <chris.paterson2@renesas.com>
> Sent: 05 August 2019 16:36
> 
> Also update to use new linux-cip-ci repository location.
> 
> Support for real-time will be added later.

We've hit a failure [1] for one of the builds on the linux-4.19.y-cip-rt branch for the siemens_am57xx-pxm3 config.

siemens_am57xx-pxm3 builds fine with the linux-4.19.y-cip branch [2].

Looking at the logs we see the same build warning [3] from both jobs but it looks like warnings are being set to trigger errors in the -rt branch, but not in the non-rt branch [4].

Is it possible to get these build warnings fixed?
Do we need to fail on such build warnings?

[1] https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/266288367
[2] https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/266288345
[3] grep for cpdma_desc_pool_create
[4] "cc1: some warnings being treated as errors"

Kind regards, Chris

<snip>
