From: daniel.sangorrin@toshiba.co.jp (daniel.sangorrin at toshiba.co.jp)
Date: Thu, 6 Jun 2019 05:41:26 +0000
Subject: [cip-dev] gitlab-ci for CIP tiny profile (Deby)
Message-ID: <TY2PR01MB332348D30D9AD1A6D62523E0D0170@TY2PR01MB3323.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Michael,

I have added an initial, very simple, gitlab-ci yaml script for building CIP tiny profile (Deby for BBB).
https://gitlab.com/cip-project/cip-core/deby/blob/master/.gitlab-ci.yml

I have tested it with Gitlab's shared runners. I set the timeout to be 4h, but the shared runner seems to have a timeout of 3h.
Hopefully it will finish in time:
https://gitlab.com/cip-project/cip-core/deby/-/jobs/226174734

I read that for public open source projects, the maximum amount of CI time is 2000 minutes per month.
This is clearly not enough for Deby.

For that reason, I would like to register our Runner. Please let me know what should I do.

Thanks,
Daniel
