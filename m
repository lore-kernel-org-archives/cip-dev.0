Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1499.1794209973030256102
 for <cip-dev@lists.cip-project.org>;
 Sun, 08 Nov 2026 23:39:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=N5k24Rqy;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.131, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding;
	i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=1794209966;x=1795419566;bh=
	p3ykfl4JkP5qTY9fIEpAxQ9VbOULy7yOhwCvsQmqc7w=;b=N5k24RqyFjnGSH9sfGfdLsU1eCG5Ls
	/JpmE+JpJB/QZeRjOK/xAvzdna0H0laAhbEs7Dzmt8I4kYEaMzmBsu4r/WgtmZauWD5e1r6CHgg0r
	xt3LxXHxeYrdFfT07866P72OMI5RTM2DDkG3MeT6CY94MdJBZdNhNU+itpfBeEXsmNdsOCRkQjCtf
	ImchNGfiW56qYT1yYcG2wbSIcVSMv11RaSQ3ZT9haTzSEHZfI8NlQhAJ3i7gs//oZRIKEgJe3dNjd
	6DLlExHRKwZnyTdEJFAL4sW6vqlX0wbUKQ1uax8ZxJmVqJLINICAOHGfLLDMNDH17qLSLSIFMtaPp
	sVqw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 6A97dOne4163824; Mon, 9 Nov 2026 16:39:24 +0900
X-Iguazu-Qid: 2rWgW6kWPKNpIgrR6e
X-Iguazu-QSIG: v=2; s=1; t=1794209964; q=2rWgW6kWPKNpIgrR6e; m=fFpijFpQMW3hO4liRo1XBE4hQLtQ7KC28hKIeVZQsRg=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jNM9k3mTQz4w01; Mon,  9 Nov 2026 16:39:22 +0900 (JST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org, uli@fpond.eu, biju.das.jz@bp.renesas.com,
        tommaso.merciai.xr@bp.renesas.com
Subject: [PATCH 6.1.y-cip 0/5] Fix CVEs related to patches backported to the CIP kernel
Date: Mon,  9 Nov 2026 16:39:09 +0900
X-TSB-HOP2: ON
Message-Id: <1794209954-6205-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 09 Nov 2026 07:39:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24684
Content-Type: text/plain; charset="utf-8"

Hi all,

This is patch series that fixes CVEs related to patches backported to
CIP kernel.
The following CVEs and commits are addressed:

- CVE-2026-80950:
    introduced-cip-commits:
    - 0bea5c0e39992654677bb6e94d276c14bf75c2f8

- CVE-2026-98408:
    introduced-cip-commits:
    - e7be3130426e3a807b36f67672c483be40149ece

- CVE-2026-93168:
    introduced-cip-commits:
    - 45d1a8483d570ddd1017945c730d82beda702006

- CVE-2026-90147:
    introduced-cip-commits:
    - ec6f6aa0c2897b4f0cfda06a10489137d78f1894

- CVE-2026-89728:
    introduced-cip-commits:
    - 8b01676f5130eb96966a155b3d62247592c0600c

Best regards,
  Nobuhiro

Alex Bereza (1):
  dmaengine: xilinx_dma: Fix CPU stall in xilinx_dma_poll_timeout

Claudiu Beznea (2):
  i3c: renesas: Check that the transfer is valid before accessing it
  i3c: renesas: Fix out-of-bounds access for newdevs mask

Onur Özkan (1):
  clk: devres: fix cleanup in devm_clk_get_optional_enabled_with_rate()

Tzung-Bi Shih (1):
  watchdog: rzv2h: Avoid division by zero

 drivers/clk/clk-devres.c         | 12 +++++--
 drivers/dma/xilinx/xilinx_dma.c  | 14 +++++---
 drivers/i3c/master/renesas-i3c.c | 58 +++++++++++++++++++++++++++-----
 drivers/watchdog/rzv2h_wdt.c     |  7 +++-
 4 files changed, 76 insertions(+), 15 deletions(-)

-- 
2.55.0


