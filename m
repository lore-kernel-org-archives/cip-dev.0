Return-Path: <SRS0=4O5l=D3=lists.cip-project.org=bounce+64572+5622+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D8BC4363A
	for <cip-dev@archiver.kernel.org>; Tue, 20 Oct 2020 14:58:14 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1416821D7B
	for <cip-dev@archiver.kernel.org>; Tue, 20 Oct 2020 14:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="g0ezEAnw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1416821D7B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5622+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id fqCWYY4521723xEMqRRTBM75; Tue, 20 Oct 2020 07:58:13 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web09.8069.1603205878331425469
 for <cip-dev@lists.cip-project.org>;
 Tue, 20 Oct 2020 07:58:13 -0700
X-IronPort-AV: E=Sophos;i="5.77,397,1596466800"; 
   d="scan'208";a="60088241"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 20 Oct 2020 23:58:12 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id A7088433DEA0;
	Tue, 20 Oct 2020 23:58:11 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 25/26] tools: PCI: Exit with error code when test fails
Date: Tue, 20 Oct 2020 15:57:31 +0100
Message-Id: <20201020145732.30343-26-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201020145732.30343-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201020145732.30343-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Izz9cC95mZG0EcUwLEVKMZq5x4520388AA=
Content-Type: multipart/mixed; boundary="Wvohyc2qz2YH8s1CdLdX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603205893;
 bh=nH8DaVFtHZFVUXfq1kamUPbVXc+h/+hfefwGBsZxvjQ=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=g0ezEAnw32yh82ROo3NjzGaTLLi4QpIb42psZK37i1UuqpeMuvFRlkpQh8IqPT9PCZ4
 sRKyl2ELMCHFacZ40BtHCXTeBYHZ9eLsXV/xegEvt5O2oANh80kQ2FBjwPQYPy0wxpS2J
 OyZPzqiHCNm8aA56ZXAi5O97MR0vsbrVuJQ=

--Wvohyc2qz2YH8s1CdLdX

From: Jean-Jacques Hiblot <jjhiblot@ti.com>

commit b71f0a0b1e3fea212a6a5042ced8b48a81738ac9 upstream.

This makes it easier to use pcitest in automated setups.

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@ti.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 tools/pci/pcitest.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
index 4c5be77c211f..b7e3b6a64956 100644
--- a/tools/pci/pcitest.c
+++ b/tools/pci/pcitest.c
@@ -140,6 +140,7 @@ static int run_test(struct pci_test *test)
 	}
 
 	fflush(stdout);
+	return (ret < 0) ? ret : 1 - ret; /* return 0 if test succeeded */
 }
 
 int main(int argc, char **argv)
@@ -228,6 +229,5 @@ int main(int argc, char **argv)
 		return -EINVAL;
 	}
 
-	run_test(test);
-	return 0;
+	return run_test(test);
 }
-- 
2.17.1


--Wvohyc2qz2YH8s1CdLdX
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5622): https://lists.cip-project.org/g/cip-dev/message=
/5622
Mute This Topic: https://lists.cip-project.org/mt/77683545/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--Wvohyc2qz2YH8s1CdLdX--
