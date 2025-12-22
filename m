Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE08E674A0
	for <webhook@archiver.kernel.org>; Mon, 22 Dec 2025 11:17:21 +0000 (UTC)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.78199.1766402234502399619
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 Dec 2025 03:17:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ULEzwKZu;
 spf=pass (domain: gmail.com, ip: 209.85.218.43, mailfrom: biju.das.au@gmail.com)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so872424366b.2
        for <cip-dev@lists.cip-project.org>; Mon, 22 Dec 2025 03:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766402232; x=1767007032; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UoC2fhV3hEv5I9aHzFDK+nxFRs9j2ycgljJtid/LEYc=;
        b=ULEzwKZu/o7qbDhuXbbfEwLFlF42kdgBII8Gw7sDR8Jr0SMTAB554wUVuk3lbQoeJ5
         qeCcvSj4GCcM2y2//fns4Cf+ARpNnTVSyyLer+rvAzTLigjOMyHqK0MmozRf4iU7rWEg
         4jgmgoSzawAP5DUUJ0eoo4opa1uYMn/mQX2P7Jky0By1TMU5+g2H4VApDK8BPC2DwsgV
         qlt6w9tVCvK46u9P/8pp6y2R6m6BHHuKEiGPeXNsZ/LW1ShXne1fbHgacHPF9cXP9RNr
         s3FP8WFZSC2odBts6IHo4oM0hQIOciuyXYNkHbB6kqRL7Zid7jgu4xMoqdX5oscwqs1Y
         0MvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766402232; x=1767007032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UoC2fhV3hEv5I9aHzFDK+nxFRs9j2ycgljJtid/LEYc=;
        b=s6K1jDkFnM1Xxu81lW9RTa3kS/CoNR9cfKa8Mlof9N/3sQ/4Ev5MW8cgrXSAaJMahe
         +bgBrTt4L2B9n/5+c4zjClmoN5On0/KGXhk2TB3A8c+NSiVLmH7Gh3WISdQ2ruaxrg7+
         FOEyUbaLxm0DymOL/X59XmMm1zMIyur6V2gF7oNffrMUyicTwF41zr5m2jrNefaPEa3F
         71v1Ys/3b8ldah9RwuTqfYtarmoWOXX5leNwqisjGSJaRNAqwD1/HvgAQ5nuhKZmGq8s
         5OgwZ5Is/xXWKptLVlwgy9SigGdh5QMRRRq/+bBFiZpRUu4D5C43tqkHKBVHLSnzoFxj
         4ESA==
X-Gm-Message-State: AOJu0YwFKYg0hRQ/7zA5hCUEkedlMkcBepILEtIWd1H/IHbLZ258MC1s
	5pK1czwpHjd/CnttZcBc9vtKPdMiw/nv77TWkzm2iYPYfAkBb+jYIZvZAk3pdA==
X-Gm-Gg: AY/fxX4ZyHaQfXasf7HY08TFtcdluWt32NVIsPvz/Cctd+IHEVutxDun80o4zvYfLL5
	QI/II620g8vK3417anwM8PzstS6X1vVk8GubYbxbET/sTtR5lroEVgFP3z5pvGBa4ixvtl2GHXg
	Y/HVRbPfuqv57z17K6LkNy/ysM82ZjHfSX6EK1M8x6kOKY62z/bctNHq6WHPIfbmda9Y1kwD0DD
	Aj//4vrAmsFp8oxk3+GN8KCyrgXuas4we9w72sh5MPvrFm9GS0Gshod6XdjAyx4nK4D6YDHt7ZO
	f8AdcjjaeNX/RMspc6iJTqGs0teEpXTLwr2AJvGrLw2yp5XRqDspgSZ/3vp4jLfgJYfGkkgz7im
	09MhX78qruqP+SMNJ0HZbREKgWB6iRNyHuqSGjRvMkbFFlBSQ7tFYAVu2uOBBbYfXS2OHZgZqC3
	M911NKmc21YaGH89M/LhH/RHo1xx2PA03wy9I=
X-Google-Smtp-Source: AGHT+IEJ5AlAZxNX0PQkX+A3kgqArIwXv8nr/DxuLnml44OiCF35HBugkZNICnsiyskUHFmkVeTOrw==
X-Received: by 2002:a17:906:99c3:b0:b79:f9b4:4c5d with SMTP id a640c23a62f3a-b803715359emr1190843166b.39.1766402232317;
        Mon, 22 Dec 2025 03:17:12 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:46ab:7c54:6a94:818c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f13847sm1023592566b.57.2025.12.22.03.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 03:17:12 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 12/24] can: rcar_canfd: Drop unused macros
Date: Mon, 22 Dec 2025 11:16:44 +0000
Message-ID: <20251222111705.27028-13-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251222111705.27028-1-biju.das.jz@bp.renesas.com>
References: <20251222111705.27028-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Dec 2025 11:17:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21198

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 0e6639c8505d70e821bc27f951a0ff6303f10d4d ]

Drop unused macros from the rcar_canfd.c.

Reported-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Closes: https://lore.kernel.org/all/7ff93ff9-f578-4be2-bdc6-5b09eab64fe6@wanadoo.fr/
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://patch.msgid.link/20250702120539.98490-1-biju.das.jz@bp.renesas.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 93 -------------------------------
 1 file changed, 93 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 2c1b0f0912bf..51bdeb8ef3a2 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -224,8 +224,6 @@
 
 /* RSCFDnCFDRFPTRx */
 #define RCANFD_RFPTR_RFDLC(x)		(((x) >> 28) & 0xf)
-#define RCANFD_RFPTR_RFPTR(x)		(((x) >> 16) & 0xfff)
-#define RCANFD_RFPTR_RFTS(x)		(((x) >> 0) & 0xffff)
 
 /* RSCFDnCFDRFFDSTSx */
 #define RCANFD_RFFDSTS_RFFDF		BIT(2)
@@ -257,12 +255,9 @@
 /* RSCFDnCFDCFIDk */
 #define RCANFD_CFID_CFIDE		BIT(31)
 #define RCANFD_CFID_CFRTR		BIT(30)
-#define RCANFD_CFID_CFID_MASK(x)	((x) & 0x1fffffff)
 
 /* RSCFDnCFDCFPTRk */
 #define RCANFD_CFPTR_CFDLC(x)		(((x) & 0xf) << 28)
-#define RCANFD_CFPTR_CFPTR(x)		(((x) & 0xfff) << 16)
-#define RCANFD_CFPTR_CFTS(x)		(((x) & 0xff) << 0)
 
 /* RSCFDnCFDCFFDCSTSk */
 #define RCANFD_CFFDCSTS_CFFDF		BIT(2)
@@ -328,59 +323,6 @@
 #define RCANFD_CFPCTR(gpriv, ch, idx) \
 	((gpriv)->info->regs->cfpctr + (0x0c * (ch)) + (0x04 * (idx)))
 
-/* RSCFDnCFDFESTS / RSCFDnFESTS */
-#define RCANFD_FESTS			(0x0238)
-/* RSCFDnCFDFFSTS / RSCFDnFFSTS */
-#define RCANFD_FFSTS			(0x023c)
-/* RSCFDnCFDFMSTS / RSCFDnFMSTS */
-#define RCANFD_FMSTS			(0x0240)
-/* RSCFDnCFDRFISTS / RSCFDnRFISTS */
-#define RCANFD_RFISTS			(0x0244)
-/* RSCFDnCFDCFRISTS / RSCFDnCFRISTS */
-#define RCANFD_CFRISTS			(0x0248)
-/* RSCFDnCFDCFTISTS / RSCFDnCFTISTS */
-#define RCANFD_CFTISTS			(0x024c)
-
-/* RSCFDnCFDTMCp / RSCFDnTMCp */
-#define RCANFD_TMC(p)			(0x0250 + (0x01 * (p)))
-/* RSCFDnCFDTMSTSp / RSCFDnTMSTSp */
-#define RCANFD_TMSTS(p)			(0x02d0 + (0x01 * (p)))
-
-/* RSCFDnCFDTMTRSTSp / RSCFDnTMTRSTSp */
-#define RCANFD_TMTRSTS(y)		(0x0350 + (0x04 * (y)))
-/* RSCFDnCFDTMTARSTSp / RSCFDnTMTARSTSp */
-#define RCANFD_TMTARSTS(y)		(0x0360 + (0x04 * (y)))
-/* RSCFDnCFDTMTCSTSp / RSCFDnTMTCSTSp */
-#define RCANFD_TMTCSTS(y)		(0x0370 + (0x04 * (y)))
-/* RSCFDnCFDTMTASTSp / RSCFDnTMTASTSp */
-#define RCANFD_TMTASTS(y)		(0x0380 + (0x04 * (y)))
-/* RSCFDnCFDTMIECy / RSCFDnTMIECy */
-#define RCANFD_TMIEC(y)			(0x0390 + (0x04 * (y)))
-
-/* RSCFDnCFDTXQCCm / RSCFDnTXQCCm */
-#define RCANFD_TXQCC(m)			(0x03a0 + (0x04 * (m)))
-/* RSCFDnCFDTXQSTSm / RSCFDnTXQSTSm */
-#define RCANFD_TXQSTS(m)		(0x03c0 + (0x04 * (m)))
-/* RSCFDnCFDTXQPCTRm / RSCFDnTXQPCTRm */
-#define RCANFD_TXQPCTR(m)		(0x03e0 + (0x04 * (m)))
-
-/* RSCFDnCFDTHLCCm / RSCFDnTHLCCm */
-#define RCANFD_THLCC(m)			(0x0400 + (0x04 * (m)))
-/* RSCFDnCFDTHLSTSm / RSCFDnTHLSTSm */
-#define RCANFD_THLSTS(m)		(0x0420 + (0x04 * (m)))
-/* RSCFDnCFDTHLPCTRm / RSCFDnTHLPCTRm */
-#define RCANFD_THLPCTR(m)		(0x0440 + (0x04 * (m)))
-
-/* RSCFDnCFDGTINTSTS0 / RSCFDnGTINTSTS0 */
-#define RCANFD_GTINTSTS0		(0x0460)
-/* RSCFDnCFDGTINTSTS1 / RSCFDnGTINTSTS1 */
-#define RCANFD_GTINTSTS1		(0x0464)
-/* RSCFDnCFDGTSTCFG / RSCFDnGTSTCFG */
-#define RCANFD_GTSTCFG			(0x0468)
-/* RSCFDnCFDGTSTCTR / RSCFDnGTSTCTR */
-#define RCANFD_GTSTCTR			(0x046c)
-/* RSCFDnCFDGLOCKK / RSCFDnGLOCKK */
-#define RCANFD_GLOCKK			(0x047c)
 /* RSCFDnCFDGRMCFG */
 #define RCANFD_GRMCFG			(0x04fc)
 
@@ -398,12 +340,6 @@
 /* RSCFDnGAFLXXXj offset */
 #define RCANFD_C_GAFL_OFFSET		(0x0500)
 
-/* RSCFDnRMXXXq -> RCANFD_C_RMXXX(q) */
-#define RCANFD_C_RMID(q)		(0x0600 + (0x10 * (q)))
-#define RCANFD_C_RMPTR(q)		(0x0604 + (0x10 * (q)))
-#define RCANFD_C_RMDF0(q)		(0x0608 + (0x10 * (q)))
-#define RCANFD_C_RMDF1(q)		(0x060c + (0x10 * (q)))
-
 /* RSCFDnRFXXx -> RCANFD_C_RFXX(x) */
 #define RCANFD_C_RFOFFSET	(0x0e00)
 #define RCANFD_C_RFID(x)	(RCANFD_C_RFOFFSET + (0x10 * (x)))
@@ -423,17 +359,6 @@
 #define RCANFD_C_CFDF(ch, idx, df) \
 	(RCANFD_C_CFOFFSET + 0x08 + (0x30 * (ch)) + (0x10 * (idx)) + (0x04 * (df)))
 
-/* RSCFDnTMXXp -> RCANFD_C_TMXX(p) */
-#define RCANFD_C_TMID(p)		(0x1000 + (0x10 * (p)))
-#define RCANFD_C_TMPTR(p)		(0x1004 + (0x10 * (p)))
-#define RCANFD_C_TMDF0(p)		(0x1008 + (0x10 * (p)))
-#define RCANFD_C_TMDF1(p)		(0x100c + (0x10 * (p)))
-
-/* RSCFDnTHLACCm */
-#define RCANFD_C_THLACC(m)		(0x1800 + (0x04 * (m)))
-/* RSCFDnRPGACCr */
-#define RCANFD_C_RPGACC(r)		(0x1900 + (0x04 * (r)))
-
 /* R-Car Gen4 Classical and CAN FD mode specific register map */
 #define RCANFD_GEN4_GAFL_OFFSET		(0x1800)
 
@@ -452,12 +377,6 @@ struct rcar_canfd_f_c {
 /* RSCFDnCFDGAFLXXXj offset */
 #define RCANFD_F_GAFL_OFFSET		(0x1000)
 
-/* RSCFDnCFDRMXXXq -> RCANFD_F_RMXXX(q) */
-#define RCANFD_F_RMID(q)		(0x2000 + (0x20 * (q)))
-#define RCANFD_F_RMPTR(q)		(0x2004 + (0x20 * (q)))
-#define RCANFD_F_RMFDSTS(q)		(0x2008 + (0x20 * (q)))
-#define RCANFD_F_RMDF(q, b)		(0x200c + (0x04 * (b)) + (0x20 * (q)))
-
 /* RSCFDnCFDRFXXx -> RCANFD_F_RFXX(x) */
 #define RCANFD_F_RFOFFSET(gpriv)	((gpriv)->info->regs->rfoffset)
 #define RCANFD_F_RFID(gpriv, x)		(RCANFD_F_RFOFFSET(gpriv) + (0x80 * (x)))
@@ -482,23 +401,11 @@ struct rcar_canfd_f_c {
 	(RCANFD_F_CFOFFSET(gpriv) + 0x0c + (0x180 * (ch)) + (0x80 * (idx)) + \
 	 (0x04 * (df)))
 
-/* RSCFDnCFDTMXXp -> RCANFD_F_TMXX(p) */
-#define RCANFD_F_TMID(p)		(0x4000 + (0x20 * (p)))
-#define RCANFD_F_TMPTR(p)		(0x4004 + (0x20 * (p)))
-#define RCANFD_F_TMFDCTR(p)		(0x4008 + (0x20 * (p)))
-#define RCANFD_F_TMDF(p, b)		(0x400c + (0x20 * (p)) + (0x04 * (b)))
-
-/* RSCFDnCFDTHLACCm */
-#define RCANFD_F_THLACC(m)		(0x6000 + (0x04 * (m)))
-/* RSCFDnCFDRPGACCr */
-#define RCANFD_F_RPGACC(r)		(0x6400 + (0x04 * (r)))
-
 /* Constants */
 #define RCANFD_FIFO_DEPTH		8	/* Tx FIFO depth */
 #define RCANFD_NAPI_WEIGHT		8	/* Rx poll quota */
 
 #define RCANFD_NUM_CHANNELS		8	/* Eight channels max */
-#define RCANFD_CHANNELS_MASK		BIT((RCANFD_NUM_CHANNELS) - 1)
 
 #define RCANFD_GAFL_PAGENUM(entry)	((entry) / 16)
 #define RCANFD_CHANNEL_NUMRULES		1	/* only one rule per channel */
-- 
2.43.0


