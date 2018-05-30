From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Wed, 30 May 2018 16:45:57 +0100
Subject: [cip-dev] [PATCH 4/7] ARM: dts: iwg20d-q7-dbcm-ca: Add HDMI
 video output
In-Reply-To: <1526383197-5913-5-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1526383197-5913-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<1526383197-5913-5-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1527695157.2289.13.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Tue, 2018-05-15 at 12:19 +0100, Fabrizio Castro wrote:
> Although there is a HDMI connector on the q7 carrier board it is not
> connected to the RZ/G1M SoC. One must use the HDMI connector on the
> camera daughter board.
> 
> This patch adds support for this connector.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> (cherry picked from commit 55cce0a07678e5fe21c7f81cc437653b485a712c)
> (taken out interrupt support)

Why is that?  Is it a limitation of the GPIO driver in 4.4?

Ben.

> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>
[...]

-- 
Ben Hutchings, Software Developer                ?        Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
We respect your privacy.?? See https://www.codethink.co.uk/privacy.html
