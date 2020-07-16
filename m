Return-Path: <SRS0=VKg+=A3=lists.cip-project.org=bounce+64572+4932+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FD9C433DF
	for <cip-dev@archiver.kernel.org>; Thu, 16 Jul 2020 13:31:56 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CE6D20760
	for <cip-dev@archiver.kernel.org>; Thu, 16 Jul 2020 13:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="OohljzJ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CE6D20760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4932+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id aAuNYY4521723xCqxZm01ANi; Thu, 16 Jul 2020 06:31:55 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.15302.1594906069013325874
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Jul 2020 06:27:49 -0700
X-IronPort-AV: E=Sophos;i="5.75,359,1589209200"; 
   d="scan'208";a="52308346"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 16 Jul 2020 22:27:46 +0900
X-Received: from be1yocto.ree.adwin.renesas.com (unknown [172.29.43.62])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 3911642BDD21;
	Thu, 16 Jul 2020 22:27:45 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip] serial: sh-sci: Make sure status register SCxSR is read in correct sequence
Date: Thu, 16 Jul 2020 14:24:07 +0100
Message-Id: <1594905847-54471-1-git-send-email-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 58cEdZZJDxyTaL55xkO97Acmx4520388AA=
Content-Type: multipart/mixed; boundary="xLTdk337DEArLluSuq8I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1594906315;
 bh=/FxXarK975b/FY1VajLND55vMSQ6MWRq26yYnRbjtQM=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=OohljzJ590P9h7DJ90o5jnxSoSygO5TJNyjJOAssMQtwSvBdwGvq8O7BNZCDjt8aHfD
 Z9CgeZFyJZIeT2zPel8M5ZgXI0uyc4MNWcPzib+J4O/pJL7P6ANR1I11WmW9n73TvDy4B
 p/rj9WRDIepPg8Jy9oBMqgFEkMTz+eIyTs0=

--xLTdk337DEArLluSuq8I

From: Kazuhiro Fujita <kazuhiro.fujita.jg@renesas.com>

commit 3dc4db3662366306e54ddcbda4804acb1258e4ba upstream.

For SCIF and HSCIF interfaces the SCxSR register holds the status of
data that is to be read next from SCxRDR register, But where as for
SCIFA and SCIFB interfaces SCxSR register holds status of data that is
previously read from SCxRDR register.

This patch makes sure the status register is read depending on the port
types so that errors are caught accordingly.

Cc: <stable@vger.kernel.org>
Signed-off-by: Kazuhiro Fujita <kazuhiro.fujita.jg@renesas.com>
Signed-off-by: Hao Bui <hao.bui.yg@renesas.com>
Signed-off-by: KAZUMI HARADA <kazumi.harada.rh@renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/1585333048-31828-1-git-send-email-kazuhiro.fujita.jg@renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 22f7201..2b5b342 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -793,9 +793,16 @@ static void sci_receive_chars(struct uart_port *port)
 				tty_insert_flip_char(tport, c, TTY_NORMAL);
 		} else {
 			for (i = 0; i < count; i++) {
-				char c = serial_port_in(port, SCxRDR);
-
-				status = serial_port_in(port, SCxSR);
+				char c;
+
+				if (port->type == PORT_SCIF ||
+				    port->type == PORT_HSCIF) {
+					status = serial_port_in(port, SCxSR);
+					c = serial_port_in(port, SCxRDR);
+				} else {
+					c = serial_port_in(port, SCxRDR);
+					status = serial_port_in(port, SCxSR);
+				}
 #if defined(CONFIG_CPU_SH3)
 				/* Skip "chars" during break */
 				if (sci_port->break_flag) {
-- 
2.7.4


--xLTdk337DEArLluSuq8I
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4932): https://lists.cip-project.org/g/cip-dev/message=
/4932
Mute This Topic: https://lists.cip-project.org/mt/75541395/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--xLTdk337DEArLluSuq8I--
