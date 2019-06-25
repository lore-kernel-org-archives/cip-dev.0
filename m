From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Tue, 25 Jun 2019 13:29:15 +0100
Subject: [cip-dev] [Git][cip-project/cip-kernel/cip-kernel-sec][master]
 Import more data
In-Reply-To: <TY2PR01MB33234EA30D2934C21A792F2AD0E30@TY2PR01MB3323.jpnprd01.prod.outlook.com>
References: <5d0bebf82257_470e3fd2b3244620356163@sidekiq-asap-03-sv-gprd.mail>
	<TY2PR01MB33234EA30D2934C21A792F2AD0E30@TY2PR01MB3323.jpnprd01.prod.outlook.com>
Message-ID: <1561465755.21054.60.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Tue, 2019-06-25 at 06:10 +0000, daniel.sangorrin at toshiba.co.jp wrote:
> Hello Ben,
> 
> I'm not sure where the script that imports new issues and sends these e-mails is located, but it looks like it is not calling "scripts/cleanup.py".
> I run cleanup.py, and I noticed that it modified most yaml issue files.

I run the same scripts that are in the repo.  Whenever I push, Gitlab
sends the mail.

If cleanup.py is reformatting then that suggests there may have been a
change in the default format used by yamllib.  We might need to
override that.

Ben.

-- 
Ben Hutchings, Software Developer                ?        Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
