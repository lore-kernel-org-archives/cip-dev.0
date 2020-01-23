From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Thu, 23 Jan 2020 11:43:31 +0000
Subject: [cip-dev] gitlab Test artifacts
In-Reply-To: <a2d7cda0-1858-fa1c-add2-70916e4df493@siemens.com>
References: <48886b9e-ea2d-504b-507f-8eaecff3517d@siemens.com>
 <TYAPR01MB2285E33230A0A605168E590BB7350@TYAPR01MB2285.jpnprd01.prod.outlook.com>
 <a2d7cda0-1858-fa1c-add2-70916e4df493@siemens.com>
Message-ID: <OSBPR01MB228045EBD443807F92D64CA0B70F0@OSBPR01MB2280.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Quirin,

> From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
> Sent: 23 January 2020 09:32
> 
> Hi Chris,
> 
> Is there a reason to upload the artifacts from gitlab to aws. Currently
> the artifacts in gitlab do not expire and are public accessible.

Currently the artifacts (Kernel image/DTBs) from a 'build' job are stored as artifacts in GitLab so that they are easily available for 'test' jobs to use.
These test jobs then upload the artifacts to AWS where they can be accessed by the LAVA labs.

Why don't the LAVA labs just fetch the binaries from GitLab? Good question.
Partly because CIP was already using AWS and partly because I never got around to trying.

> 
> For example
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/270427371
> 
> If only aws should be used as longt erm storage then maybe we should add
> an expire date or use caches instead of artifacts for the gitlab ci builds.

The benefit of using artifacts over caches in GitLab is that objects stored as artifacts can be easily accessed by users through the GitLab website or API.
Perhaps useful if someone wants to run some tests locally, and easier to do then finding the appropriate files in AWS.

Yes, there should probably be an expiry on these artifacts (artifacts:expire_in), but as the storage is all controlled/payed for by GitLab it's not a direct issue for CIP.
I'll add a 1 month limit for now.

One thing I haven't tried yet is playing around with using a cache for build objects to speed up build times, perhaps useful to store the SSTATE CACHE from OE builds.

Kind regards, Chris

> 
> Kind regards,
> Quirin
