From: mosipov@ilbers.de (Maxim Yu. Osipov)
Date: Mon, 27 Nov 2017 17:07:04 +0100
Subject: [cip-dev] [PATCH] thermal: imx: Temperature could be not read out
	from on-SOC temp sensor.
Message-ID: <20171127160704.25280-1-mosipov@ilbers.de>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This patch was accepted but still not merged upstream
[see https://patchwork.kernel.org/patch/9856949]

In imx_thermal_probe() thermal alarm interrupt is
enabled before device's 'mode' field is set to THERMAL_DEVICE_ENABLED while
the sensor hardware is already powered up. If alarm condition is met -
the interrupt immediately fires up. During (threaded) interrupt processing
imx_get_temp() is called. The field 'mode' is still set to DISABLED,
so imx_get_temp() processes such case by special way: sensor is powered up,
measurement is enabled, a reading is taken, after that measurement is
DISABLED and temperature sensor is POWERED DOWN.

When processing of alarm interrupt ends, imx_thermal_probe() continues
and sets mode field to ENABLED, but in fact the device is powered off!

This leads to broken logic of further calls of imx_get_temp().

Note, that explicit enabling of mode via sysfs
(echo enabled > /sys/sys/class/therma/thermal_zone0/mode)
leads to powering up of the sensor hardware (see sensor_set_mode())
The same applies to suspend/resume cycles - after resume the temperature
sensor will start reading the temperature w/o errors.

I sent the patch to i.MX list <linux-arm-kernel@lists.infradead.org>
and Philipp Zabel <p.zabel@pengutronix.de> additionally suggested:

>>>>>>
Thank you for the patch and the analysis. I have some comments below.

I think the data->irq_enabled assignment should be moved up before the
call to devm_request_threaded_irq as well. If the interrupt triggers
immediately (and sets data->irq_enabled=false), and then
imx_thermal_probe returns (after setting data->irq_enabled=true) before
the threaded irq handler gets to run, imx_get_temp will not reenable the
interrupt at the end, if the temperature has just fallen below the alarm
temperature.

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
<<<<<<

Signed-off-by: Maxim Yu. Osipov <mosipov@ilbers.de>
---
 drivers/thermal/imx_thermal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index c5547bd711db..253c3ea6ff08 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -588,6 +588,8 @@ static int imx_thermal_probe(struct platform_device *pdev)
 
 	regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_POWER_DOWN);
 	regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_MEASURE_TEMP);
+	data->irq_enabled = true;
+	data->mode = THERMAL_DEVICE_ENABLED;
 
 	ret = devm_request_threaded_irq(&pdev->dev, data->irq,
 			imx_thermal_alarm_irq, imx_thermal_alarm_irq_thread,
@@ -600,8 +602,6 @@ static int imx_thermal_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	data->irq_enabled = true;
-	data->mode = THERMAL_DEVICE_ENABLED;
 
 	return 0;
 }
-- 
2.11.0
