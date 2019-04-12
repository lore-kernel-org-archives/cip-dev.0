From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Fri, 12 Apr 2019 12:39:36 +0100
Subject: [cip-dev] Supported kernel and Debian versions in Isar
In-Reply-To: <OSBPR01MB27743E33CB9ED2B9B5885577E12F0@OSBPR01MB2774.jpnprd01.prod.outlook.com>
References: <OSBPR01MB27743E33CB9ED2B9B5885577E12F0@OSBPR01MB2774.jpnprd01.prod.outlook.com>
Message-ID: <1555069176.3557.17.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Thu, 2019-04-11 at 08:33 +0000, kazuhiro3.hayashi at toshiba.co.jp wrote:
[...]
> Do you any plans to provide the kernel recipes for all CIP versions (4.4, 4.19, ...) in master branch
> and validate them with all Debian versions?
> I guess that the supported combinations would be limited to practical ones.
> For examples:
> 	4.4 + stretch => SUPPORTED
> 	4.4 + buster => NOT SUPPORTED
> 	4.4 + bullseye => NOT SUPPORTED

That makes sense to me.

> 	4.19 + stretch => SUPPORTED
> 	4.19 + buster => NOT SUPPORTED

That should be supported as Debian's official kernel packages for
buster are based on 4.19.

> 	4.19 + bullseye => SUPPORTED(?)
[...]

That should be supportable - Debian generally tries to support partial
upgrades including upgrading all of userland without the kernel, so
bullseye userland should be compatible with 4.19.

Ben.

-- 
Ben Hutchings, Software Developer                ?        Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
