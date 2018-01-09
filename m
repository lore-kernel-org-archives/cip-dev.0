From: chris.paterson2@renesas.com (Chris Paterson)
Date: Tue,  9 Jan 2018 11:48:37 +0000
Subject: [cip-dev] [PATCH] ARM: shmobile: r8a7743: Fix Watchdog timer clock
Message-ID: <1515498517-23722-1-git-send-email-chris.paterson2@renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

R8A7743_CLK_RWDT should be 2 as specified in the hardware manual.

Fixes: 9683f2eba952bc0d ("ARM: shmobile: r8a7743: Add clock index macros for DT sources")
Reported-by: Thong Ho <thong.ho.px@rvc.renesas.com>
Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
---
 include/dt-bindings/clock/r8a7743-clock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/r8a7743-clock.h b/include/dt-bindings/clock/r8a7743-clock.h
index a5c7e387e66dfd55..53f54dfce59245d8 100644
--- a/include/dt-bindings/clock/r8a7743-clock.h
+++ b/include/dt-bindings/clock/r8a7743-clock.h
@@ -71,7 +71,7 @@
 #define R8A7743_CLK_USBDMAC1		31
 
 /* MSTP4 */
-#define R8A7743_CLK_RWDT		4
+#define R8A7743_CLK_RWDT		2
 #define R8A7743_CLK_USB_DDM		6
 #define R8A7743_CLK_IRQC		7
 #define R8A7743_CLK_INTC_SYS		8
-- 
1.9.1
