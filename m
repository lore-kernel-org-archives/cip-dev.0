From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Wed, 14 Mar 2018 22:26:23 +0000
Subject: [cip-dev] [PATCH 06/10] phy: rcar-gen2: add fallback binding
In-Reply-To: <1520249954-29357-7-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1520249954-29357-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<1520249954-29357-7-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1521066383.23626.109.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Mon, 2018-03-05 at 11:39 +0000, Fabrizio Castro wrote:
> From: Simon Horman <horms+renesas@verge.net.au>
> 
> In the case of Renesas R-Car hardware we know that there are generations of
> SoCs, e.g. Gen 2 and Gen 3. But beyond that its not clear what the
> relationship between IP blocks might be. For example, I believe that
> r8a7790 is older than r8a7791 but that doesn't imply that the latter is a
> descendant of the former or vice versa.
> 
> We can, however, by examining the documentation and behaviour of the
> hardware at run-time observe that the current driver implementation appears
> to be compatible with the IP blocks on SoCs within a given generation.
> 
> For the above reasons and convenience when enabling new SoCs a
> per-generation fallback compatibility string scheme being adopted for
> drivers for Renesas SoCs.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
[...]

This is missing a reference to the upstream commit
(7777cb8ba08dabcab8dc0e91ac0a26dde675edb6).

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
