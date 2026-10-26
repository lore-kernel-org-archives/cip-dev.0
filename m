Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.34127.1792979293229753152
 for <cip-dev@lists.cip-project.org>;
 Sun, 25 Oct 2026 18:48:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=maSaftMJ;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.134, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id;i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=
	1792979288;x=1794188888;bh=BED5RY6Q/UNYxMOp15TVPI7v9w/GDFGapcC5GvGjoZU=;b=maS
	aftMJLKoQHZQDDSnlFvsBRRgiDXWkW/fRg2gaqTIBb1hnlpJr/EXtEK/qsewhXw+Z6AJLjaDSv5rQ
	TffEqqacxsRjGjniHrBBAW02ZkZJT9lFLqwrU6Wrd4aNhfnKLbvRXBFyGG+yjwDFemtT6BjBdncW+
	O/FzFsZjFOR5pVe0AIJIvqod/aQ8+IoQrJpmJc8KyrrpwJwGPp+KH/I69kH6XktTyWS9DxCjMGJT4
	w2ssyi2ZIwf1A8XX7R/IXZiQFsRprwh4b4OeEmkuewR/opm79W+JJbxquqdIHcecGXSuLkIRY1al6
	FvBWN9v3B464bVdBusuUYiVDljPmgjQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 69Q1m7mL350543; Mon, 26 Oct 2026 10:48:08 +0900
X-Iguazu-Qid: 2yAawho6h4Mr8wuOR1
X-Iguazu-QSIG: v=2; s=1; t=1792979287; q=2yAawho6h4Mr8wuOR1; m=ELT8wqCBFtmGbP/8ZMV3Z6sLaQRAMtrEYxWUI97hnKM=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jCc2v4XF7zyPZ; Mon, 26 Oct 2026 10:48:07 +0900 (JST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: cip-dev@lists.cip-project.org
Cc: pavel@nabladev.com, uli@fpond.eu, tommaso.merciai.xr@bp.renesas.com,
        claudiu.beznea.uj@bp.renesas.com
Subject: [PATCH 6.12.y-cip 0/2] Fix CVEs related to patches backported to the CIP kernel
Date: Mon, 26 Oct 2026 10:48:04 +0900
X-TSB-HOP2: ON
Message-Id: <1792979286-32200-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailer: git-send-email 2.7.4
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 26 Oct 2026 01:48:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24531
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

This is a patch series that fixes CVEs related to patches backported to
CIP kernel.
The following CVEs and commits are addressed in this:

- CVE-2026-53030:
    introduced-commits:
    - 4e9ffb135571f135dd568b23624cfc1f75a73364

- CVE-2025-39774:
    introduced-commits:
    - 194e2729165e61c0d2b54f377f55fb4624a7b751

Best regards,
  Nobuhiro

Claudiu Beznea (1):
  iio: adc: rzg2l_adc: Set driver data before enabling runtime PM

Felix Gu (1):
  i3c: master: renesas: Fix memory leak in renesas_i3c_i3c_xfers()

 drivers/i3c/master/renesas-i3c.c | 4 ++--
 drivers/iio/adc/rzg2l_adc.c      | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.55.0

