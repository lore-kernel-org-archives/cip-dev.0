Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3679D6204A
	for <webhook@archiver.kernel.org>; Tue, 19 Nov 2024 09:09:58 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web11.16816.1732007396346156876
 for <cip-dev@lists.cip-project.org>;
 Tue, 19 Nov 2024 01:09:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=QVDv8icQ;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.134, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key2.smx;t=
	1732007378;x=1733216978;bh=6pBdnN6Zoi2eU1Mm6KXcstXF0NwqnIo8dzrjU3kE7V4=;b=QVD
	v8icQB9j7PGHh6W81CRzZaUdCZSDLwy//3gSY4/6pPhckjRklDryWcEyfB8a7fLmiWUqFC6ZKzARd
	9gzKRwFJzI17kq8npIuyomPyKNsfm802bBB2uBSi00x+BHti20p3KJo8qAZTg9c2meIekh2flmqPT
	3yLch9lL+3C0arID9Kl4nTg9cRgPXQMf8aBx2q3CSZTV6nHfxzF1XCSLGeJPQ9XvjgV6P1RQSjryh
	qXetg5WKCrDZUxPiX4/3i3VGabLrMiipngSdtJfIJS2kv2DUfEWoK15cbWo5lgW34p1FC8Dy12vm4
	g90O3kLD64pOdpsJ7IK4dPFcg5+KyzA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 4AJ99ckG2096737; Tue, 19 Nov 2024 18:09:38 +0900
X-Iguazu-Qid: 2yAbJ1jgy1oJa7HaYH
X-Iguazu-QSIG: v=2; s=0; t=1732007377; q=2yAbJ1jgy1oJa7HaYH; m=bXE/sG8bpXPgK3Atp/+cc1HTBTYuqNg9TuuSHzJ/0rQ=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1800) id 4AJ99Zn91625578
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 18:09:36 +0900
From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To: Ulrich Hecht <uli@fpond.eu>
Cc: cip-dev@lists.cip-project.org, pavel@denx.de,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH for 4.4] net: qualcomm: prepare frame decoding for UART driver
Date: Tue, 19 Nov 2024 18:09:34 +0900
X-TSB-HOP2: ON
Message-Id: <1732007374-15710-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 19 Nov 2024 09:09:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17262

From: Stefan Wahren <stefan.wahren@i2se.com>

commit  60d6702464b9d667312035eb3bd9d390af9626dd upstream.

Unfortunately the frame format is not exactly identical between SPI
and UART. In case of SPI there is an additional HW length at the
beginning. So store the initial state to make the decoding state machine
more flexible and easy to extend for UART support.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 drivers/net/ethernet/qualcomm/qca_framing.c | 12 ++++++------
 drivers/net/ethernet/qualcomm/qca_framing.h |  8 ++++++--
 drivers/net/ethernet/qualcomm/qca_spi.c     |  2 +-
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/qca_framing.c b/drivers/net/ethernet/qualcomm/qca_framing.c
index faa924c85e293..b168f6ed30c48 100644
--- a/drivers/net/ethernet/qualcomm/qca_framing.c
+++ b/drivers/net/ethernet/qualcomm/qca_framing.c
@@ -83,7 +83,7 @@ qcafrm_fsm_decode(struct qcafrm_handle *handle, u8 *buf, u16 buf_len, u8 recv_by
 
 		if (recv_byte != 0x00) {
 			/* first two bytes of length must be 0 */
-			handle->state = QCAFRM_HW_LEN0;
+			handle->state = handle->init;
 		}
 		break;
 	case QCAFRM_HW_LEN2:
@@ -97,7 +97,7 @@ qcafrm_fsm_decode(struct qcafrm_handle *handle, u8 *buf, u16 buf_len, u8 recv_by
 	case QCAFRM_WAIT_AA4:
 		if (recv_byte != 0xAA) {
 			ret = QCAFRM_NOHEAD;
-			handle->state = QCAFRM_HW_LEN0;
+			handle->state = handle->init;
 		} else {
 			handle->state--;
 		}
@@ -119,7 +119,7 @@ qcafrm_fsm_decode(struct qcafrm_handle *handle, u8 *buf, u16 buf_len, u8 recv_by
 		len = handle->offset;
 		if (len > buf_len || len < QCAFRM_ETHMINLEN) {
 			ret = QCAFRM_INVLEN;
-			handle->state = QCAFRM_HW_LEN0;
+			handle->state = handle->init;
 		} else {
 			handle->state = (enum qcafrm_state)(len + 1);
 			/* Remaining number of bytes. */
@@ -135,7 +135,7 @@ qcafrm_fsm_decode(struct qcafrm_handle *handle, u8 *buf, u16 buf_len, u8 recv_by
 	case QCAFRM_WAIT_551:
 		if (recv_byte != 0x55) {
 			ret = QCAFRM_NOTAIL;
-			handle->state = QCAFRM_HW_LEN0;
+			handle->state = handle->init;
 		} else {
 			handle->state = QCAFRM_WAIT_552;
 		}
@@ -143,11 +143,11 @@ qcafrm_fsm_decode(struct qcafrm_handle *handle, u8 *buf, u16 buf_len, u8 recv_by
 	case QCAFRM_WAIT_552:
 		if (recv_byte != 0x55) {
 			ret = QCAFRM_NOTAIL;
-			handle->state = QCAFRM_HW_LEN0;
+			handle->state = handle->init;
 		} else {
 			ret = handle->offset;
 			/* Frame is fully received. */
-			handle->state = QCAFRM_HW_LEN0;
+			handle->state = handle->init;
 		}
 		break;
 	}
diff --git a/drivers/net/ethernet/qualcomm/qca_framing.h b/drivers/net/ethernet/qualcomm/qca_framing.h
index 5d965959c978e..2b7fcf841facd 100644
--- a/drivers/net/ethernet/qualcomm/qca_framing.h
+++ b/drivers/net/ethernet/qualcomm/qca_framing.h
@@ -61,6 +61,7 @@
 #define QCAFRM_ERR_BASE -1000
 
 enum qcafrm_state {
+	/* HW length is only available on SPI */
 	QCAFRM_HW_LEN0 = 0x8000,
 	QCAFRM_HW_LEN1 = QCAFRM_HW_LEN0 - 1,
 	QCAFRM_HW_LEN2 = QCAFRM_HW_LEN1 - 1,
@@ -101,6 +102,8 @@ enum qcafrm_state {
 struct qcafrm_handle {
 	/*  Current decoding state */
 	enum qcafrm_state state;
+	/* Initial state depends on connection type */
+	enum qcafrm_state init;
 
 	/* Offset in buffer (borrowed for length too) */
 	s16 offset;
@@ -113,9 +116,10 @@ u16 qcafrm_create_header(u8 *buf, u16 len);
 
 u16 qcafrm_create_footer(u8 *buf);
 
-static inline void qcafrm_fsm_init(struct qcafrm_handle *handle)
+static inline void qcafrm_fsm_init_spi(struct qcafrm_handle *handle)
 {
-	handle->state = QCAFRM_HW_LEN0;
+	handle->init = QCAFRM_HW_LEN0;
+	handle->state = handle->init;
 }
 
 /*   Gather received bytes and try to extract a full Ethernet frame
diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/ethernet/qualcomm/qca_spi.c
index 7e71a9e37a05e..5d5ad522694b0 100644
--- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -631,7 +631,7 @@ qcaspi_netdev_open(struct net_device *dev)
 	qca->intr_req = 1;
 	qca->intr_svc = 0;
 	qca->sync = QCASPI_SYNC_UNKNOWN;
-	qcafrm_fsm_init(&qca->frm_handle);
+	qcafrm_fsm_init_spi(&qca->frm_handle);
 
 	qca->spi_thread = kthread_run((void *)qcaspi_spi_thread,
 				      qca, "%s", dev->name);
-- 
2.45.2



