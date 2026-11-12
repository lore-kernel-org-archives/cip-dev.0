Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8132.1794466780810830640
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Nov 2026 22:59:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=ggnO0293;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.158, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id:In-Reply-To:References;i=
	nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=1794466777;x=1795676377;bh=+R
	NAy3Y68x16NJ2he56u43uEwttVLJCT9k34+C8gWaE=;b=ggnO029366ijtsfqrsglijICqBOgXw1S
	52N54nojmDDUY8oKj2cArGSsv8OaIFw43pGY59n9o4ynRSIvbesxX14CPeWJlf+BYJC0Mz+k4oQEy
	uWvZC2uZ8TwNoi4B/XdAnqifqwYgCNys4KOM+k923v4rukwWacbFLDDgGAvOIxiK5ABOeJPGF3oFc
	R1jlAdQapnPpVXKAOB8sHc35GKPyqIBeiFOFJhPMAJkLBlILWvSCKmRoRzs5yQ+El35uydMI/hhwo
	S7PokNSB9J0GksnLuYnCpPD8u1L9iamu6Pw24rAAyep/QNJQqJJznL/uxGxpSfJoLFYYSZRU+vspD
	lg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 6AC6xbbs1831280; Thu, 12 Nov 2026 15:59:37 +0900
X-Iguazu-Qid: 2rWh7O15Amq0YuSzFA
X-Iguazu-QSIG: v=2; s=1; t=1794466777; q=2rWh7O15Amq0YuSzFA; m=ycn6BtfDEA+VawyGmhXBjZ1Wl6kuskChNlLzonVM3Rg=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jQB8S6pvdz1xnf; Thu, 12 Nov 2026 15:59:36 +0900 (JST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: jan.kiszka@siemens.com
Cc: cip-dev@lists.cip-project.org,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: [isa-cip-core][PATCH v3 8/8] Kconfg: Add '!TARGET_TI_AM62PX_SK' to the dependencies for 'buster'.
Date: Thu, 12 Nov 2026 15:59:18 +0900
X-TSB-HOP2: ON
Message-Id: <1794466758-28304-9-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1794466758-28304-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
References: <1794466758-28304-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 12 Nov 2026 06:59:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24778
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Since U-Boot for AM62Px SK is not supported on 'buster', this adds
'!TARGET_TI_AM62PX_SK' to the dependencies.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
---

v3:
  new patch.

 Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Kconfig b/Kconfig
index 163813b..23e5d01 100644
--- a/Kconfig
+++ b/Kconfig
@@ -232,7 +232,7 @@ choice
 
 config DEBIAN_BUSTER
 	bool "buster (10)"
-	depends on !ARCH_RISCV64
+	depends on !ARCH_RISCV64 && !TARGET_TI_AM62PX_SK
 
 config DEBIAN_BULLSEYE
 	bool "bullseye (11)"
-- 
2.55.0


