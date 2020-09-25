Return-Path: <SRS0=qBPB=DC=lists.cip-project.org=bounce+64572+5473+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C38C4727D
	for <cip-dev@archiver.kernel.org>; Fri, 25 Sep 2020 04:00:06 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3074121D7F
	for <cip-dev@archiver.kernel.org>; Fri, 25 Sep 2020 04:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="A0MLN/vm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3074121D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5473+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id NmnmYY4521723xHEPLfnQVRK; Thu, 24 Sep 2020 21:00:05 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web12.83.1601006404940305385
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Sep 2020 21:00:05 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 08P3xWYY024706; Fri, 25 Sep 2020 12:59:33 +0900
X-Iguazu-Qid: 34trjq6AI9NyB3OFHT
X-Iguazu-QSIG: v=2; s=0; t=1601006372; q=34trjq6AI9NyB3OFHT; m=d8dLsnCum8a5B7LH7goYRFhaOyTTXuvVPFPzpPIDNZU=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1510) id 08P3xVtL039267;
	Fri, 25 Sep 2020 12:59:32 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 08P3xV83016924;
	Fri, 25 Sep 2020 12:59:31 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 08P3xVEX000476;
	Fri, 25 Sep 2020 12:59:31 +0900
From: "Daniel Sangorrin" <daniel.sangorrin@toshiba.co.jp>
To: sz.lin@moxa.com, ben.hutchings@codethink.co.u, wens@csie.org
Cc: cip-dev@lists.cip-project.org
Subject: [cip-dev] [cip-kernel-sec 2/3] report_affected: Delete extra blank lines between CVEs
Date: Fri, 25 Sep 2020 12:59:26 +0900
X-TSB-HOP: ON
Message-Id: <20200925035927.1958987-3-daniel.sangorrin@toshiba.co.jp>
In-Reply-To: <20200925035927.1958987-1-daniel.sangorrin@toshiba.co.jp>
References: <20200925035927.1958987-1-daniel.sangorrin@toshiba.co.jp>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: x06WM4ROti2eqKQUauNnQXVGx4520388AA=
Content-Type: multipart/mixed; boundary="i3xGRJPaE9ftB3wUYWpN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1601006405;
 bh=Z8j23V/7yOZJOhehKgweTyzVzmN0fUqofrqdF0jNRJQ=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=A0MLN/vm80ACgtmlaxznDPfCS43Nj8VtR/80XnsJfY1FFhotNS1OfnNPZz1QzaEk4KG
 yJ9c+pBk4nlIJFGE3pdbtkozGlM4TIoMTbs9rCdkUHKDSjnaXXE1ult3aVfpq0BeZen5W
 p19LgXIex/y4lkhO3yW4kLQwN0ZYn13i3zg=

--i3xGRJPaE9ftB3wUYWpN
Content-Transfer-Encoding: 8bit

From: nguyen van hieu <hieu2.nguyenvan@toshiba.co.jp>

When using the --show-description option CVEs had blank
lines between them. Remove them to make it more compact.

Signed-off-by: nguyen van hieu <hieu2.nguyenvan@toshiba.co.jp>
Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
---
 scripts/report_affected.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/report_affected.py b/scripts/report_affected.py
index a181d97..9894602 100755
--- a/scripts/report_affected.py
+++ b/scripts/report_affected.py
@@ -141,7 +141,7 @@ def main(git_repo, remotes, only_fixed_upstream,
                 wrap_description = ''
                 for line in textwrap.wrap(description, 80, break_long_words=False):
                     wrap_description += line + '\n  '
-                print(cve_id, '=>',wrap_description)
+                print(cve_id, '=>',wrap_description.strip())
         else:
             print('%s:' % branch['full_name'], *sorted_cve_ids)
 
-- 
2.25.1


--i3xGRJPaE9ftB3wUYWpN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5473): https://lists.cip-project.org/g/cip-dev/message=
/5473
Mute This Topic: https://lists.cip-project.org/mt/77073065/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--i3xGRJPaE9ftB3wUYWpN--
