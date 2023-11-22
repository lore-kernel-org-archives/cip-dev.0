Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA237C61D9B
	for <webhook@archiver.kernel.org>; Wed, 22 Nov 2023 16:51:20 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.24593.1700671876361325693
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Nov 2023 08:51:16 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.04,219,1695654000"; 
   d="scan'208";a="183895830"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 23 Nov 2023 01:51:14 +0900
Received: from localhost.localdomain (unknown [10.226.92.150])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 1C21E402D12C;
	Thu, 23 Nov 2023 01:51:12 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 2/3] dt-bindings: timer: renesas,rz-mtu3: Improve documentation
Date: Wed, 22 Nov 2023 16:51:05 +0000
Message-Id: <20231122165106.235838-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231122165106.235838-1-biju.das.jz@bp.renesas.com>
References: <20231122165106.235838-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Nov 2023 16:51:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13637

commit b121e7881b8975cf8dc24d9bd71a5af81ed8a6b1 upstream.

Fix the documentation issues pointed by Pavel while backporting
it to 6.1.y-cip.
 - Replace '32- bit'->'32-bit'
 - Consistently remove '.' at the end of line for the specifications
 - Replace '          (excluding MTU8)'-> '(excluding MTU8)'

Reported-by: Pavel Machek <pavel@denx.de>
Closes: https://lore.kernel.org/all/ZH79%2FUjgYg+0Ruiu@duo.ucw.cz
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20230727081848.100834-3-biju.das.jz@bp.renesas.com
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../bindings/timer/renesas,rz-mtu3.yaml       | 28 +++++++++----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml b/Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml
index fbac40b958dd..670a2ebaacdb 100644
--- a/Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml
+++ b/Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml
@@ -11,8 +11,8 @@ maintainers:
 
 description: |
   This hardware block consists of eight 16-bit timer channels and one
-  32- bit timer channel. It supports the following specifications:
-    - Pulse input/output: 28 lines max.
+  32-bit timer channel. It supports the following specifications:
+    - Pulse input/output: 28 lines max
     - Pulse input 3 lines
     - Count clock 11 clocks for each channel (14 clocks for MTU0, 12 clocks
       for MTU2, and 10 clocks for MTU5, four clocks for MTU1-MTU2 combination
@@ -23,11 +23,11 @@ description: |
         - Input capture function (noise filter setting available)
         - Counter-clearing operation
         - Simultaneous writing to multiple timer counters (TCNT)
-          (excluding MTU8).
+          (excluding MTU8)
         - Simultaneous clearing on compare match or input capture
-          (excluding MTU8).
+          (excluding MTU8)
         - Simultaneous input and output to registers in synchronization with
-          counter operations           (excluding MTU8).
+          counter operations (excluding MTU8)
         - Up to 12-phase PWM output in combination with synchronous operation
           (excluding MTU8)
     - [MTU0 MTU3, MTU4, MTU6, MTU7, and MTU8]
@@ -40,26 +40,26 @@ description: |
     - [MTU3, MTU4, MTU6, and MTU7]
         - Through interlocked operation of MTU3/4 and MTU6/7, the positive and
           negative signals in six phases (12 phases in total) can be output in
-          complementary PWM and reset-synchronized PWM operation.
+          complementary PWM and reset-synchronized PWM operation
         - In complementary PWM mode, values can be transferred from buffer
           registers to temporary registers at crests and troughs of the timer-
           counter values or when the buffer registers (TGRD registers in MTU4
-          and MTU7) are written to.
-        - Double-buffering selectable in complementary PWM mode.
+          and MTU7) are written to
+        - Double-buffering selectable in complementary PWM mode
     - [MTU3 and MTU4]
         - Through interlocking with MTU0, a mode for driving AC synchronous
           motors (brushless DC motors) by using complementary PWM output and
           reset-synchronized PWM output is settable and allows the selection
-          of two types of waveform output (chopping or level).
+          of two types of waveform output (chopping or level)
     - [MTU5]
-        - Capable of operation as a dead-time compensation counter.
+        - Capable of operation as a dead-time compensation counter
     - [MTU0/MTU5, MTU1, MTU2, and MTU8]
         - 32-bit phase counting mode specifiable by combining MTU1 and MTU2 and
-          through interlocked operation with MTU0/MTU5 and MTU8.
+          through interlocked operation with MTU0/MTU5 and MTU8
     - Interrupt-skipping function
         - In complementary PWM mode, interrupts on crests and troughs of counter
           values and triggers to start conversion by the A/D converter can be
-          skipped.
+          skipped
     - Interrupt sources: 43 sources.
     - Buffer operation:
         - Automatic transfer of register data (transfer from the buffer
@@ -68,9 +68,9 @@ description: |
         - A/D converter start triggers can be generated
         - A/D converter start request delaying function enables A/D converter
           to be started with any desired timing and to be synchronized with
-          PWM output.
+          PWM output
     - Low power consumption function
-        - The MTU3a can be placed in the module-stop state.
+        - The MTU3a can be placed in the module-stop state
 
     There are two phase counting modes. 16-bit phase counting mode in which
     MTU1 and MTU2 operate independently, and cascade connection 32-bit phase
-- 
2.25.1


