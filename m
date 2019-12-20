From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Fri, 20 Dec 2019 12:04:35 +0000
Subject: [cip-dev] [cip-core:deby] failed switching to "builder":
 operation not permitted
In-Reply-To: <OSAPR01MB2113D396C63C4FB19D94FE00E1520@OSAPR01MB2113.jpnprd01.prod.outlook.com>
References: <OSAPR01MB2113D396C63C4FB19D94FE00E1520@OSAPR01MB2113.jpnprd01.prod.outlook.com>
Message-ID: <TYAPR01MB2285EECEA85E66931F893F9DB72D0@TYAPR01MB2285.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Hayashi-san,

> From: cip-dev <cip-dev-bounces@lists.cip-project.org> On Behalf Of
> kazuhiro3.hayashi at toshiba.co.jp
> Sent: 19 December 2019 11:48
> 
> Hello,
> 
> In the latest CI for cip-core/deby/cip-core-buster,
> I got the following error (and warnings), probably related to kas/docker-
> entrypoint.
> 
> $ /kas/docker-entrypoint
> useradd: user 'builder' already exists
> error: failed switching to "builder": operation not permitted

I've submitted a MR that fixes this issue:
https://gitlab.com/cip-project/cip-core/deby/merge_requests/3

Note that there is still a build failure as it seems that one of the packages the build tries to download is no longer available:
http://ftp.debian.org/debian/pool/main/b/base-files/base-files_10.3+deb10u1.dsc

Kind regards, Chris

> 
> Example of the failure (the latest):
> https://gitlab.com/cip-project/cip-core/deby/-/jobs/384499394
> 
> Example of the success (1 month ago):
> https://gitlab.com/cip-project/cip-core/deby/-/jobs/333094418
> 
> Do anyone know related changes which happen recently?
> 
> Best regards,
> Kazu
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev
