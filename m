From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Wed, 30 May 2018 19:44:06 +0100
Subject: [cip-dev] [PATCH v2 07/11] ARM: dts: r8a7743: Add thermal
	device to DT
In-Reply-To: <1527701767-41785-8-git-send-email-biju.das@bp.renesas.com>
References: <1527701767-41785-1-git-send-email-biju.das@bp.renesas.com>
	<1527701767-41785-8-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1527705846.2289.31.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Wed, 2018-05-30 at 18:36 +0100, Biju Das wrote:
> This patch instantiates the thermal sensor module with thermal-zone
> support.

The thermal-zones node this adds was later moved by commit b9db3affbcdc
("ARM: dts: r8a7743: move timer and thermal-zones nodes out of bus"). 
Do you think that is worth applying too?

Ben.

> This patch is based on the commit cac68a56e34b
> ("ARM: dts: r8a7791: enable to use thermal-zone") by Kuninori Morimoto.
> 
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> (cherry picked from commit 6c76b4f7d89e89f0ae405dfc7a64c6d2b5d02813)
> (updated clocks and power-domains property.removed resets property)
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
[...]

-- 
Ben Hutchings, Software Developer                ?        Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
We respect your privacy.?? See https://www.codethink.co.uk/privacy.html
