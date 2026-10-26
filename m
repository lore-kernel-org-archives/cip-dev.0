Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.34081.1792979116239225776
 for <cip-dev@lists.cip-project.org>;
 Sun, 25 Oct 2026 18:45:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=Zd3IsUKE;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.134, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id;i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=
	1792979107;x=1794188707;bh=KnOvhulpDMGeYlueM/ZzjgmPKypTBfu+byMaVf1780I=;b=Zd3
	IsUKERVXoS9VmR+EWhc+Rb/PaZ0oa1oaJskk6wfsbk5WwzTjP/rCdhH0g+MIgm4MT4wMkLIlvGGNd
	j8+7SqzWZrIlkEQcj4YZ+tcR3CXbyX++DY0QPneK5o+cPqnbRr8ywuZER+m6lJjJXT6eFTWOjYHuX
	IO3cSpyVHN4SqnSsjTAXwo3F8mlIuNu8kaVC+gRClwJzzD7oYV/mBCx5HvQ+ydUG3m9nrg9fQWq0C
	IQpBuZEV0pGgvCaIVyGbfBokFFJaa1etWaWrIjSlYx/CrdH6pb0G9NWX7zqNEJyJO84Mk00ru7iFi
	imjjgNn3Ge51kjnWXVVgNrNljf4yfOw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 69Q1j73h337655; Mon, 26 Oct 2026 10:45:07 +0900
X-Iguazu-Qid: 2yAaKKNbLebNrxT1Iu
X-Iguazu-QSIG: v=2; s=1; t=1792979107; q=2yAaKKNbLebNrxT1Iu; m=zolf38/eO6w8LVKQ04eIT8UiBmd7cxRTYPts0LywRm8=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jCbzQ0QknzyPZ; Mon, 26 Oct 2026 10:45:06 +0900 (JST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: cip-dev@lists.cip-project.org
Cc: pavel@nabladev.com, uli@fpond.eu, claudiu.beznea.uj@bp.renesas.com
Subject: [PATCH 5.10.y-cip 0/1] Fix a CVE related to patches backported to the CIP kernel
Date: Mon, 26 Oct 2026 10:45:03 +0900
X-TSB-HOP2: ON
Message-Id: <1792979104-32023-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailer: git-send-email 2.7.4
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 26 Oct 2026 01:45:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24523
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

This is a patch series that fixes a CVE related to patches backported to
CIP kernel.
The following CVE and commit are addressed in this:

- CVE-2025-39774:
    introduced-commits:
    - 2e775fffefca9fe71cabdb4533f13598b29e9631

Best regards,
  Nobuhiro

Claudiu Beznea (1):
  iio: adc: rzg2l_adc: Set driver data before enabling runtime PM

 drivers/iio/adc/rzg2l_adc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.55.0


