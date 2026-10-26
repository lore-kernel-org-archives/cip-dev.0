Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.34490.1792979253884698597
 for <cip-dev@lists.cip-project.org>;
 Sun, 25 Oct 2026 18:47:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=DCrUnzA0;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.131, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id;i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=
	1792979246;x=1794188846;bh=/xBbiR+lpULiUO/lnLogY3DPbywlpo41+o8F2X+FTKw=;b=DCr
	UnzA0zwL302zf55F/yxwuiqrFyBSI+aBs+yPWoR+aTifw+t+/C0n9YWFP8o5aUdLVsgEzUTksdSdN
	xS77Os/bhxpibTHWQB65am39g1M6HT46d/V3QCl0wvgUbh/UZtuv0vAIUNQ1pNAqAp2yjbXbQhEIt
	sdo/KCLlzQxOkDixAZOaOtOnvKdtZCBGOgoUQwViTs0C80UCp2b573CyQxBK7qy2xH2a6NAN8Ej2r
	CQZug5on3Xd4Vaxod7e+QuDM7N3SgJECvq8T79tE9FNokVFDt+c3rYLUiMiRbwWi9QzzYXR+LibpY
	HR0Qaa4feZCF59RygrwqsiVO/LNzCLg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 69Q1lPOr773060; Mon, 26 Oct 2026 10:47:25 +0900
X-Iguazu-Qid: 2rWgw8g3r5cHXPAAhQ
X-Iguazu-QSIG: v=2; s=1; t=1792979244; q=2rWgw8g3r5cHXPAAhQ; m=UvEL6MfGVcR+k+1rChn0AmiwB69nTBZguQAhccm6Izs=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jCc240dpjz4vym; Mon, 26 Oct 2026 10:47:24 +0900 (JST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: cip-dev@lists.cip-project.org
Cc: pavel@nabladev.com, uli@fpond.eu, tommaso.merciai.xr@bp.renesas.com,
        fabrizio.castro.jz@renesas.com, claudiu.beznea.uj@bp.renesas.com,
        cosmin-gabriel.tanislav.xa@renesas.com
Subject: [PATCH 6.1.y-cip 0/5] Fix CVEs related to patches backported to the CIP kernel
Date: Mon, 26 Oct 2026 10:47:17 +0900
X-TSB-HOP2: ON
Message-Id: <1792979242-32127-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailer: git-send-email 2.7.4
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 26 Oct 2026 01:47:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

This is a patch series that fixes CVEs related to patches backported to
CIP kernel.
The following CVEs and commits are addressed in this:

- CVE-2026-53030:
    introduced-commits:
    - 0bea5c0e39992654677bb6e94d276c14bf75c2f8
- CVE-2025-71187:
    introduced-commits:
    - 282d5dfb9147694b8ba1a6528d38450d2f7addda
- CVE-2025-39774:
    introduced-commits:
    - ffe4a44bf16c17a26124536533179c12239668de
- CVE-2026-31740:
    introduced-commits:
    - 6ae52685cb60989ed37870bb7f9d2e2d96a6e509
- CVE-2026-31741:
    introduced-commits:
    - 6ae52685cb60989ed37870bb7f9d2e2d96a6e509

Best regards,
  Nobuhiro

Claudiu Beznea (1):
  iio: adc: rzg2l_adc: Set driver data before enabling runtime PM

Cosmin Tanislav (2):
  counter: rz-mtu3-cnt: prevent counter from being toggled multiple
    times
  counter: rz-mtu3-cnt: do not use struct rz_mtu3_channel's dev member

Felix Gu (1):
  i3c: master: renesas: Fix memory leak in renesas_i3c_i3c_xfers()

Johan Hovold (1):
  dmaengine: sh: rz-dmac: fix device leak on probe failure

 drivers/counter/rz-mtu3-cnt.c    | 67 +++++++++++++++++---------------
 drivers/dma/sh/rz-dmac.c         | 13 ++++++-
 drivers/i3c/master/renesas-i3c.c |  4 +-
 drivers/iio/adc/rzg2l_adc.c      |  4 +-
 4 files changed, 50 insertions(+), 38 deletions(-)

-- 
2.55.0

