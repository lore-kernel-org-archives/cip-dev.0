From: biju.das@bp.renesas.com (Biju Das)
Date: Tue, 16 Jul 2019 07:42:19 +0100
Subject: [cip-dev] [PATCH 4.4.y-cip 3/5] mtd: spi-nor: Add support for
	is25lp016d
In-Reply-To: <1563259341-37180-1-git-send-email-biju.das@bp.renesas.com>
References: <1563259341-37180-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1563259341-37180-4-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit b422847877e35d6818f65cb359a60f529fe22c4b upstream.

The is25lp016d is found on the iwg23s from iWave, therefore
add driver support for it so that we can upstream board support.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 276998e..f26e735 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -708,6 +708,8 @@ static const struct flash_info spi_nor_ids[] = {
 
 	/* ISSI */
 	{ "is25cd512", INFO(0x7f9d20, 0, 32 * 1024,   2, SECT_4K) },
+	{ "is25lp016d", INFO(0x9d6015, 0, 64 * 1024,  32,
+			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ "is25wp032", INFO(0x9d7016, 0, 64 * 1024,  64,
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ "is25wp064", INFO(0x9d7017, 0, 64 * 1024, 128,
-- 
2.7.4
