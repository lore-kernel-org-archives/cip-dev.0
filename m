From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Fri, 24 Aug 2018 20:04:46 +0100
Subject: [cip-dev] [PATCH] ARM: dts: r8a7745: add VIN dt support
In-Reply-To: <1532523993-32635-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1532523993-32635-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1535137486.2902.44.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Wed, 2018-07-25 at 14:06 +0100, Fabrizio Castro wrote:
> Add VIN[01] support to SoC dt. Also, add aliases.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> (cherry picked from commit 1a20f21899e7ae886675874b5b5fb03eb43ea69b)
> (moved nodes to a better location to allow for better sorting.
> updated clocks and power-domains properties. removed resets property)
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> ---
> Hello Ben,
> 
> This patch depends on series "Add CAN support to iwg22d":
> https://lists.cip-project.org/pipermail/cip-dev/2018-July/001403.html
> 
> and it applies on top of branch linux-4.4.y-cip, commit
> 4d769b2b8749e89dfc7ea179a44f652dcfbedb37 ("PM / OPP: Move error
> message to debug level").
[...]

Applied, thanks.

Ben.

-- 
Ben Hutchings, Software Developer                ?        Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
