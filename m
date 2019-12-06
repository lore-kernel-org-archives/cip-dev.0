From: biju.das@bp.renesas.com (Biju Das)
Date: Fri,  6 Dec 2019 12:12:21 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 05/12] thermal: trip_point_temp_store()
	calls thermal_zone_device_update()
In-Reply-To: <1575634348-10954-1-git-send-email-biju.das@bp.renesas.com>
References: <1575634348-10954-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1575634348-10954-6-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

commit ad74e46cb3ba9e706f91f3f71baf816d2d8e45db upstream.

trip_point_temp_store() updates trip temperature. It should call
thermal_zone_device_update() immediately.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/thermal/thermal_core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 929092f..0e919c3 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -700,8 +700,12 @@ trip_point_temp_store(struct device *dev, struct device_attribute *attr,
 		return -EINVAL;
 
 	ret = tz->ops->set_trip_temp(tz, trip, temperature);
+	if (ret)
+		return ret;
 
-	return ret ? ret : count;
+	thermal_zone_device_update(tz);
+
+	return count;
 }
 
 static ssize_t
-- 
2.7.4
