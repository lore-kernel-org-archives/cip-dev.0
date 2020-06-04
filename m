Return-Path: <SRS0=MMBG=7R=lists.cip-project.org=bounce+64572+4674+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506B8C433E0
	for <cip-dev@archiver.kernel.org>; Thu,  4 Jun 2020 03:48:48 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EDAA20679
	for <cip-dev@archiver.kernel.org>; Thu,  4 Jun 2020 03:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="ac2NQHu2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EDAA20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4674+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id RPCZYY4521723xt2IOhkaNW0; Wed, 03 Jun 2020 20:48:47 -0700
X-Received: from wens.tw (wens.tw [140.112.30.76])
 by mx.groups.io with SMTP id smtpd.web12.6790.1591242526472000324
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Jun 2020 20:48:46 -0700
X-Received: by wens.tw (Postfix, from userid 1000)
	id 7A2745FCA8; Thu,  4 Jun 2020 11:48:44 +0800 (CST)
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
To: cip-dev@lists.cip-project.org
Subject: [cip-dev] Git-send-email Test
Date: Thu,  4 Jun 2020 11:48:40 +0800
Message-Id: <20200604034840.16343-1-wens@csie.org>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: J5spg3eKo1GUxVcuYqEE8fybx4520388AA=
Content-Type: multipart/mixed; boundary="OihPAvcEEqEqJQNdz1e2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591242527;
 bh=Z5SoL8+tSwTVmtCnN2wWuFAAsTw7fhLbsh/lrRpLii4=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=ac2NQHu2CbbE30srmtVe3UQqIv36g78SLgas5aiGE1l8RdW2sQNFbZ74zwv5AX3uBR2
 MWqEbW9yIwwSFYPAjwZftB2idYetBUwUqiAHo8KuFffQALHNP4WT7ojpJc+Q6gWYfL7El
 HStR/SJMXfc98xTANaKMN3RE5um1qXFySFE=

--OihPAvcEEqEqJQNdz1e2
Content-Transfer-Encoding: quoted-printable

Testing git send-email ... please ignore.

--OihPAvcEEqEqJQNdz1e2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4674): https://lists.cip-project.org/g/cip-dev/message=
/4674
Mute This Topic: https://lists.cip-project.org/mt/74665374/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--OihPAvcEEqEqJQNdz1e2--
