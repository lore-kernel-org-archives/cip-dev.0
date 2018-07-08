From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Sun, 08 Jul 2018 20:04:09 +0100
Subject: [cip-dev] [PATCH 02/86] dt: Add of_device_compatible_match()
In-Reply-To: <1530283167-14050-3-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<1530283167-14050-3-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1531076649.21552.5.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Fri, 2018-06-29 at 15:38 +0100, Fabrizio Castro wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> This provides an equivalent of of_fdt_match() for non-flat trees.
> 
> This is more practical than matching an array of of_device_id structs
> when converting a bunch of existing users of of_fdt_match().
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> (cherry picked from commit b9c13fe32faaa71c4e4f8a426d79f8c93495e9f9)
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
[...]

There is a related fix which I'll apply along with this:

commit 3bc1630774bc9f202308ae04608a32c366b41caf
Author: Geert Uytterhoeven <geert+renesas@glider.be>
Date:???Tue Apr 25 19:38:48 2017 +0200

????of: Provide dummy of_device_compatible_match() for compile-testing

Ben.

-- 
Ben Hutchings, Software Developer                ?        Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
