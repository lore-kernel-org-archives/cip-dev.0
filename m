From: quirin.gylstorff@siemens.com (Gylstorff Quirin)
Date: Thu, 23 Jan 2020 10:32:16 +0100
Subject: [cip-dev] gitlab Test artifacts
In-Reply-To: <TYAPR01MB2285E33230A0A605168E590BB7350@TYAPR01MB2285.jpnprd01.prod.outlook.com>
References: <48886b9e-ea2d-504b-507f-8eaecff3517d@siemens.com>
 <TYAPR01MB2285E33230A0A605168E590BB7350@TYAPR01MB2285.jpnprd01.prod.outlook.com>
Message-ID: <a2d7cda0-1858-fa1c-add2-70916e4df493@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Chris,

Is there a reason to upload the artifacts from gitlab to aws. Currently 
the artifacts in gitlab do not expire and are public accessible.

For example 
https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/270427371

If only aws should be used as longt erm storage then maybe we should add 
an expire date or use caches instead of artifacts for the gitlab ci builds.

Kind regards,
Quirin
