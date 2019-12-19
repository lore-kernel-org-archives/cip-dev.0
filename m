From: kazuhiro3.hayashi@toshiba.co.jp (kazuhiro3.hayashi at toshiba.co.jp)
Date: Thu, 19 Dec 2019 11:48:20 +0000
Subject: [cip-dev] [cip-core:deby] failed switching to "builder": operation
 not permitted
Message-ID: <OSAPR01MB2113D396C63C4FB19D94FE00E1520@OSAPR01MB2113.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello,

In the latest CI for cip-core/deby/cip-core-buster,
I got the following error (and warnings), probably related to kas/docker-entrypoint.

$ /kas/docker-entrypoint
useradd: user 'builder' already exists
error: failed switching to "builder": operation not permitted

Example of the failure (the latest):
https://gitlab.com/cip-project/cip-core/deby/-/jobs/384499394

Example of the success (1 month ago):
https://gitlab.com/cip-project/cip-core/deby/-/jobs/333094418

Do anyone know related changes which happen recently?

Best regards,
Kazu
