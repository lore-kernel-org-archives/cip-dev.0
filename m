From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 26 Jul 2018 15:28:05 +0100
Subject: [cip-dev] [PATCH 1/3] selftests/timers: make loop consistent with
	array size
In-Reply-To: <1532615287-1183-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1532615287-1183-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1532615287-1183-2-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Benjamin Gaignard <benjamin.gaignard@linaro.org>

clocksource_list array is defined as char [10][30] so
to initialise it we only have to iterate 10 times.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
(cherry picked from commit 8f14e26b63b1b6c7c681409e9db1bbf054e00b32)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 tools/testing/selftests/timers/clocksource-switch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/timers/clocksource-switch.c b/tools/testing/selftests/timers/clocksource-switch.c
index 627ec74..ad55426 100644
--- a/tools/testing/selftests/timers/clocksource-switch.c
+++ b/tools/testing/selftests/timers/clocksource-switch.c
@@ -61,7 +61,7 @@ int get_clocksources(char list[][30])
 
 	close(fd);
 
-	for (i = 0; i < 30; i++)
+	for (i = 0; i < 10; i++)
 		list[i][0] = '\0';
 
 	head = buf;
-- 
2.7.4
