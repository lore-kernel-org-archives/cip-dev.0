From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Wed, 30 Aug 2017 20:52:31 +0200
Subject: [cip-dev] [PATCH 4/8] mfd: intel_quark_i2c_gpio: Use dmi_system_id
	table for retrieving frequency
In-Reply-To: <cover.1504119155.git.jan.kiszka@siemens.com>
References: <cover.1504119155.git.jan.kiszka@siemens.com>
Message-ID: <8390a78fe3b4f6af247a1be34eb156272bcd77d8.1504119155.git.jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Jan Kiszka <jan.kiszka@siemens.com>

commit b518d4adb83e3e139d3de96d172d9b4dec6def09 upstream.

Avoids reimplementation of DMI matching in intel_quark_i2c_setup.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/intel_quark_i2c_gpio.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/mfd/intel_quark_i2c_gpio.c b/drivers/mfd/intel_quark_i2c_gpio.c
index 042137465300..57d4396dab5d 100644
--- a/drivers/mfd/intel_quark_i2c_gpio.c
+++ b/drivers/mfd/intel_quark_i2c_gpio.c
@@ -60,19 +60,18 @@ struct intel_quark_mfd {
 	struct clk_lookup	*i2c_clk_lookup;
 };
 
-struct i2c_mode_info {
-	const char *name;
-	unsigned int i2c_scl_freq;
-};
-
-static const struct i2c_mode_info platform_i2c_mode_info[] = {
+static const struct dmi_system_id dmi_platform_info[] = {
 	{
-		.name = "Galileo",
-		.i2c_scl_freq = 100000,
+		.matches = {
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "Galileo"),
+		},
+		.driver_data = (void *)100000,
 	},
 	{
-		.name = "GalileoGen2",
-		.i2c_scl_freq = 400000,
+		.matches = {
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "GalileoGen2"),
+		},
+		.driver_data = (void *)400000,
 	},
 	{}
 };
@@ -167,8 +166,7 @@ static void intel_quark_unregister_i2c_clk(struct pci_dev *pdev)
 
 static int intel_quark_i2c_setup(struct pci_dev *pdev, struct mfd_cell *cell)
 {
-	const char *board_name = dmi_get_system_info(DMI_BOARD_NAME);
-	const struct i2c_mode_info *info;
+	const struct dmi_system_id *dmi_id;
 	struct dw_i2c_platform_data *pdata;
 	struct resource *res = (struct resource *)cell->resources;
 	struct device *dev = &pdev->dev;
@@ -188,14 +186,9 @@ static int intel_quark_i2c_setup(struct pci_dev *pdev, struct mfd_cell *cell)
 	/* Normal mode by default */
 	pdata->i2c_scl_freq = 100000;
 
-	if (board_name) {
-		for (info = platform_i2c_mode_info; info->name; info++) {
-			if (!strcmp(board_name, info->name)) {
-				pdata->i2c_scl_freq = info->i2c_scl_freq;
-				break;
-			}
-		}
-	}
+	dmi_id = dmi_first_match(dmi_platform_info);
+	if (dmi_id)
+		pdata->i2c_scl_freq = (uintptr_t)dmi_id->driver_data;
 
 	cell->platform_data = pdata;
 	cell->pdata_size = sizeof(*pdata);
-- 
2.12.3
