From: pavel@denx.de (Pavel Machek)
Date: Fri, 22 Nov 2019 11:51:20 +0100
Subject: [cip-dev] [PATCH linux-4.4.y-cip] gitlab-ci: Use external
 linux-cip-pipelines repository to define CI
In-Reply-To: <20191121160008.4886-3-chris.paterson2@renesas.com>
References: <20191121160008.4886-1-chris.paterson2@renesas.com>
 <20191121160008.4886-3-chris.paterson2@renesas.com>
Message-ID: <20191122105120.GE30479@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
>  .gitlab-ci.yml | 283 +------------------------------------------------
>  1 file changed, 3 insertions(+), 280 deletions(-)

Thanks, I applied this, too, and I already see the green ticks.

I won't touch the -rt branches for now, they'll get the updates when
merging from -cip.

Best regards,
								Pavel

> +include:
> +  - https://gitlab.com/cip-project/cip-testing/linux-cip-pipelines/raw/master/linux-cip-pipeline.yml
> +  - https://gitlab.com/cip-project/cip-testing/linux-cip-pipelines/raw/master/trees/linux-4.4.y-cip.yml

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191122/1be64a04/attachment.sig>
