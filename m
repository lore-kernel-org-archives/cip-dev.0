From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 10 Aug 2018 10:52:45 +0100
Subject: [cip-dev] [PATCH 02/19] rcar: src: skip disabled-SRC nodes
In-Reply-To: <1533894782-26239-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1533894782-26239-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1533894782-26239-3-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

The current device tree representation of the R-Car Sample Rate Converters
(SRC) assumes that they are numbered consecutively, starting from 0. Alas,
this  is not  the case with the R8A7794 SoC where SRC0 isn't present.  In
order to keep the existing  device trees working, I'm suggesting to use a
disabled node for SRC0.  Teach the SRC probe  to just skip disabled nodes.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
(cherry picked from commit de1965159a34951a86267d13db4f2a67234139d3)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 sound/soc/sh/rcar/src.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index 2fcd3d3..68d46e1d 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -1011,6 +1011,9 @@ int rsnd_src_probe(struct platform_device *pdev,
 
 	i = 0;
 	for_each_child_of_node(node, np) {
+		if (!of_device_is_available(np))
+			goto skip;
+
 		src = rsnd_src_get(priv, i);
 
 		snprintf(name, RSND_SRC_NAME_SIZE, "%s.%d",
@@ -1034,6 +1037,7 @@ int rsnd_src_probe(struct platform_device *pdev,
 		if (ret)
 			goto rsnd_src_probe_done;
 
+skip:
 		i++;
 	}
 
-- 
2.7.4
