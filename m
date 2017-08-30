From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Wed, 30 Aug 2017 20:52:32 +0200
Subject: [cip-dev] [PATCH 5/8] mfd: intel_quark_i2c_gpio: Add support for
	SIMATIC IOT2000 platform
In-Reply-To: <cover.1504119155.git.jan.kiszka@siemens.com>
References: <cover.1504119155.git.jan.kiszka@siemens.com>
Message-ID: <712e8e9c9880af0e704757c99725a514ac901cbf.1504119155.git.jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Jan Kiszka <jan.kiszka@siemens.com>

commit 842086d2b5a6cec23d598edffb5137c72b265c50 upstream.

The SIMATIC IOT2020 and IOT2040 are derived from the Galileo Gen2 board
and share its I2C frequency.

Signed-off-by: Sascha Weisenberger <sascha.weisenberger@siemens.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/intel_quark_i2c_gpio.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/mfd/intel_quark_i2c_gpio.c b/drivers/mfd/intel_quark_i2c_gpio.c
index 57d4396dab5d..1c09604978d3 100644
--- a/drivers/mfd/intel_quark_i2c_gpio.c
+++ b/drivers/mfd/intel_quark_i2c_gpio.c
@@ -73,6 +73,22 @@ static const struct dmi_system_id dmi_platform_info[] = {
 		},
 		.driver_data = (void *)400000,
 	},
+	{
+		.matches = {
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "SIMATIC IOT2000"),
+			DMI_EXACT_MATCH(DMI_BOARD_ASSET_TAG,
+					"6ES7647-0AA00-0YA2"),
+		},
+		.driver_data = (void *)400000,
+	},
+	{
+		.matches = {
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "SIMATIC IOT2000"),
+			DMI_EXACT_MATCH(DMI_BOARD_ASSET_TAG,
+					"6ES7647-0AA00-1YA2"),
+		},
+		.driver_data = (void *)400000,
+	},
 	{}
 };
 
-- 
2.12.3
