Return-Path: <SRS0=tI8H=DC=lists.cip-project.org=bounce+64572+5474+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70B9C4363D
	for <cip-dev@archiver.kernel.org>; Fri, 25 Sep 2020 04:00:06 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1793B20EDD
	for <cip-dev@archiver.kernel.org>; Fri, 25 Sep 2020 04:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="MzGX83ff"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1793B20EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5474+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id qFp4YY4521723xJWqVmaQgyk; Thu, 24 Sep 2020 21:00:05 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web12.84.1601006404984444884
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Sep 2020 21:00:05 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 08P3xWJW022861; Fri, 25 Sep 2020 12:59:33 +0900
X-Iguazu-Qid: 34trwK96OzdGqIiWJg
X-Iguazu-QSIG: v=2; s=0; t=1601006372; q=34trwK96OzdGqIiWJg; m=0A6v3RRok59zAY2jTxX/hBnIkFRpU7/C4tA/vZCQLwI=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1513) id 08P3xVcT040152;
	Fri, 25 Sep 2020 12:59:31 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 08P3xVPC016919;
	Fri, 25 Sep 2020 12:59:31 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 08P3xVZd000452;
	Fri, 25 Sep 2020 12:59:31 +0900
From: "Daniel Sangorrin" <daniel.sangorrin@toshiba.co.jp>
To: sz.lin@moxa.com, ben.hutchings@codethink.co.u, wens@csie.org
Cc: cip-dev@lists.cip-project.org
Subject: [cip-dev] [cip-kernel-sec 1/3] report_affected: word-wrap for the 'description'
Date: Fri, 25 Sep 2020 12:59:25 +0900
X-TSB-HOP: ON
Message-Id: <20200925035927.1958987-2-daniel.sangorrin@toshiba.co.jp>
In-Reply-To: <20200925035927.1958987-1-daniel.sangorrin@toshiba.co.jp>
References: <20200925035927.1958987-1-daniel.sangorrin@toshiba.co.jp>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: yPyjLxiVvN6I8RHWhUWuSA1Jx4520388AA=
Content-Type: multipart/mixed; boundary="GsM8pP8hu7kY2TOtGOJY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1601006405;
 bh=HJltvtQg/HpM4eajXCjY8b6onA6XQK7WjNP+Ab9v/XY=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=MzGX83ff9474J/pz9gb5cYVbfKoHlTbwujv99iKzxbd822hn8n131TKT5/31nL5CwhG
 jJElE/l1KXtZOmf0fC1iK2tUg31B3TjpmUeJHYwovYcQoO4z8t1h31Kn1iwhTJ+HEGvgq
 2IAoXxkU4E/1rR19uIOuEwUO69eRb72AYhY=

--GsM8pP8hu7kY2TOtGOJY
Content-Transfer-Encoding: 8bit

From: Nguyen Van Hieu <hieu2.nguyenvan@toshiba.co.jp>

Currently some descriptions are quite long, and it is hard to read.
Add line-breaks so every line is at most 80 characters long.

Signed-off-by: Nguyen Van Hieu <hieu2.nguyenvan@toshiba.co.jp>
Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
---
 scripts/report_affected.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/scripts/report_affected.py b/scripts/report_affected.py
index a97b700..a181d97 100755
--- a/scripts/report_affected.py
+++ b/scripts/report_affected.py
@@ -19,6 +19,7 @@ import kernel_sec.branch
 import kernel_sec.issue
 import kernel_sec.version
 
+import textwrap
 
 def main(git_repo, remotes, only_fixed_upstream,
          include_ignored, show_description, *branch_names):
@@ -136,8 +137,11 @@ def main(git_repo, remotes, only_fixed_upstream,
         if show_description:
             print('%s:' % branch['full_name'])
             for cve_id in sorted_cve_ids:
-                print(cve_id, '=>',
-                      kernel_sec.issue.load(cve_id).get('description', 'None'))
+                description=kernel_sec.issue.load(cve_id).get('description', 'None')
+                wrap_description = ''
+                for line in textwrap.wrap(description, 80, break_long_words=False):
+                    wrap_description += line + '\n  '
+                print(cve_id, '=>',wrap_description)
         else:
             print('%s:' % branch['full_name'], *sorted_cve_ids)
 
-- 
2.25.1


--GsM8pP8hu7kY2TOtGOJY
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5474): https://lists.cip-project.org/g/cip-dev/message=
/5474
Mute This Topic: https://lists.cip-project.org/mt/77073066/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--GsM8pP8hu7kY2TOtGOJY--
