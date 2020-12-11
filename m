Return-Path: <SRS0=5NHI=FP=lists.cip-project.org=bounce+64572+5951+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A927C4361B
	for <cip-dev@archiver.kernel.org>; Fri, 11 Dec 2020 13:54:54 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E474D23ECD
	for <cip-dev@archiver.kernel.org>; Fri, 11 Dec 2020 13:54:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E474D23ECD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5951+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id dLztYY4521723x1ckjbRrlce; Fri, 11 Dec 2020 05:54:53 -0800
X-Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web11.7008.1607694892377190672
 for <cip-dev@lists.cip-project.org>;
 Fri, 11 Dec 2020 05:54:52 -0800
X-Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 0BBDsoUh023435
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Fri, 11 Dec 2020 14:54:50 +0100
X-Received: from md2dvrtc.fritz.box ([139.22.37.41])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 0BBDsnjE015801;
	Fri, 11 Dec 2020 14:54:50 +0100
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, Jan.Kiszka@siemens.com
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev][isar-cip-core][PATCH 2/2] add pycache to .gitignore
Date: Fri, 11 Dec 2020 14:54:48 +0100
Message-Id: <20201211135448.17147-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20201211135448.17147-1-Quirin.Gylstorff@siemens.com>
References: <20201211135448.17147-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: fmI9EkqljnjgmYJntr7imdqrx4520388AA=
Content-Type: multipart/mixed; boundary="8zJsN83PA0Cwbximt8H9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1607694893;
 bh=lhjzIoaiHgabN/m33wur7Wc9kN0XGwcG3EXWXHL1xrc=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=CikIvOavL10fV2oRcBriYzCEwckWIubKPLIN9F+85d9zZsitiK+WUhiU/HJMxHqenv5
 IgXAtUkr7dGyI1gjNeP8nOJqnm3exhSaAvzy+G+HPDd/RUZ8YWxo4cThY7g13YqWuSgHs
 +lL8bTNwWzoPhW3YdJZ83O6wkX3RJPU7z7E=

--8zJsN83PA0Cwbximt8H9
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

If a project derives from isar-cip-core and needs to patch isar-cip-core
the patching fails after a build as the repository is dirty. Fix by
ignoring the pycache directory.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 5142933..b73840f 100644
--- a/.gitignore
+++ b/.gitignore
@@ -2,3 +2,4 @@ build/
 isar/
 kas-docker
 kas-container
+__pycache__
-- 
2.20.1


--8zJsN83PA0Cwbximt8H9
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5951): https://lists.cip-project.org/g/cip-dev/message=
/5951
Mute This Topic: https://lists.cip-project.org/mt/78879162/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--8zJsN83PA0Cwbximt8H9--
