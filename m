From: pavel@denx.de (Pavel Machek)
Date: Mon, 16 Dec 2019 12:22:46 +0100
Subject: [cip-dev] [ANNOUNCE] Release v4.19.88-cip16 and v4.4.206-cip40
In-Reply-To: <OSAPR01MB323483390F138C52C363126492540@OSAPR01MB3234.jpnprd01.prod.outlook.com>
References: <OSAPR01MB323483390F138C52C363126492540@OSAPR01MB3234.jpnprd01.prod.outlook.com>
Message-ID: <20191216112246.GA17029@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> CIP kernel team has released Linux kernel v4.19.88-cip16 and v4.4.206-cip40.
> The linux-4.19.y-cip tree has been updated base version from 4.19.85 to 4.19.88,
> and The linux-4.4.y-cip tree has been updated base version from 4.4.199 to 4.4.206.

>   v4.4.206-cip40:
>     repository:
>       https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
>     branch:
>       linux-4.4.y-cip
>     commit:
>       0cddb349320426954582511b95e7d31873941aad

I attempted to get this tested, but failed:

https://gitlab.com/cip-project/cip-kernel/linux-cip/pipelines/103361420

Found errors in your .gitlab-ci.yml:
Resolving config took longer than expected
You can also test your .gitlab-ci.yml in CI Lint

Best regards,
								Pavel
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191216/460722e2/attachment.sig>
