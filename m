From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Thu, 19 Dec 2019 12:39:05 +0000
Subject: [cip-dev] [cip-core:deby] failed switching to "builder":
 operation not permitted
In-Reply-To: <OSAPR01MB2113D396C63C4FB19D94FE00E1520@OSAPR01MB2113.jpnprd01.prod.outlook.com>
References: <OSAPR01MB2113D396C63C4FB19D94FE00E1520@OSAPR01MB2113.jpnprd01.prod.outlook.com>
Message-ID: <TYAPR01MB2285448766788F6F71B0E29AB7520@TYAPR01MB2285.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello,

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
> 
> Example of the failure (the latest):
> https://gitlab.com/cip-project/cip-core/deby/-/jobs/384499394
> 
> Example of the success (1 month ago):
> https://gitlab.com/cip-project/cip-core/deby/-/jobs/333094418
> 
> Do anyone know related changes which happen recently?

It doesn't look like there are any recent changes in the .gitlab-ci.yml file.

However the GitLab runner we use was upgraded to a newer version since your last build.
@Adler, Michael, @Gylstorff Quirin, any ideas?

Kind regards, Chris

> 
> Best regards,
> Kazu
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev
