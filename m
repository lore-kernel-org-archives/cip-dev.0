From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Wed, 03 Apr 2019 14:53:11 +0100
Subject: [cip-dev] isar error log
In-Reply-To: <OSAPR01MB37634FC9265275C1F909D27AD0570@OSAPR01MB3763.jpnprd01.prod.outlook.com>
References: <OSAPR01MB3763A7998474AB7ABEB3DDF3D0560@OSAPR01MB3763.jpnprd01.prod.outlook.com>
	<0c1b977d-cd7e-34aa-8d7e-1569b313f75d@siemens.com>
	<OSAPR01MB37634FC9265275C1F909D27AD0570@OSAPR01MB3763.jpnprd01.prod.outlook.com>
Message-ID: <1554299591.3557.13.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Wed, 2019-04-03 at 00:56 +0000, daniel.sangorrin at toshiba.co.jp wrote:
> Hi Jan,
> 
> Yes I am following the Readme.
> 
> The docker image id for kasproject/kas-isar is 9e9fe44e68d3 (I am using kas-docker script). And I am using
> kas-docker --isar build kas.yml:board-qemu-amd64.yml
> 
> Yes, it seems there are multiple errors:
> /proc/sys/fs/binfmt_misc/register: Invalid argument
> /test-dev-null: Permission denied
> 
> Probably this is a bug or misconfiguration in Ubuntu. I will try to figure it out.

Might this be restricted by an AppArmor profile?  aa-logprof should
show you AppArmor denials and change the relevant profile(s) to allow
the operations.

Ben.

-- 
Ben Hutchings, Software Developer                ?        Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
