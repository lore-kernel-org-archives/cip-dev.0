Return-Path: <raymond@kelvaneos.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E688EC531D0
	for <webhook@archiver.kernel.org>; Sat, 25 Jul 2026 15:36:00 +0000 (UTC)
Received: from mail-108-mta252.mxroute.com (mail-108-mta252.mxroute.com [136.175.108.252])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.339.1784993754210027839
 for <cip-dev@lists.cip-project.org>;
 Sat, 25 Jul 2026 08:35:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kelvaneos.eu header.s=x header.b=eOlB1Sap;
 spf=pass (domain: kelvaneos.eu, ip: 136.175.108.252, mailfrom: raymond@kelvaneos.eu)
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta252.mxroute.com (ZoneMTA) with ESMTPSA id 19f99eb1577000c8ef.001
 for <cip-dev@lists.cip-project.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sat, 25 Jul 2026 15:35:48 +0000
X-Zone-Loop: b2be2b1bfc3fc34d962292e3d6cfd50bb7562d5229fd
X-Originating-IP: [136.175.111.3]
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kelvaneos.eu; s=x; h=Content-Transfer-Encoding:Content-Type:Message-ID:
	Subject:To:From:Date:MIME-Version:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=191rcXTU0D5a7ScLFAt9rWWB+b7RmR2r2XSSe/ov2hI=; b=eOlB1Sap+dxGUeEb47WUniMuDn
	eRmvZJ8VSN3J8e3w90RatDEFyoqPuHkARvYx+n1aQUBSzEJBG1NrhFfopbSBRjAmt3IqJD2wLU0BR
	rMCxEa+E0XWkMrq+nicJfg9QRmlbGuFVX/IyKpnlVSui05uFk0BQnaHpyo5lBVRZh2wDQZ3ucpO/e
	lF3yJcmqNuzcut+qQgt0HN2ADKsu6VrPYVmPNa0586Fjs+MSrc1PcXK1f38jxX7xKjuN48hbN6ZJk
	X4prUkCjVJXNOp756RbeyioN95FHw1mrJvXkGs/5Awy6MOkEilxlSOVSm6adcjALD9ED3A7v6UbmP
	449rOK8A==;
MIME-Version: 1.0
Date: Sat, 25 Jul 2026 17:35:46 +0200
From: raymond@kelvaneos.eu
To: cip-dev@lists.cip-project.org
Subject: linux-6.12.y-cip: maintenance scope for EROFS Zstandard support
Message-ID: <9e61f628ca2331b2822aeaf82caa4ef7@kelvaneos.eu>
X-Sender: raymond@kelvaneos.eu
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Id: raymond@kelvaneos.eu
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 25 Jul 2026 15:36:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23748

Hello CIP kernel maintainers,

I am evaluating linux-6.12.y-cip for a non-member industrial Linux
distribution using a read-only EROFS root filesystem.

Our required configuration includes:

     CONFIG_EROFS_FS=y
     CONFIG_EROFS_FS_ZIP=y
     CONFIG_EROFS_FS_ZIP_ZSTD=y

I understand that:

1. EROFS and its Zstandard decoder are present in linux-6.12.y-cip.
2. EROFS is enabled in the CIP 6.12 merged and QEMU configurations,
    although not in the container defconfig.
3. Linux 6.12 describes EROFS Zstandard support as experimental.
4. Upstream commit 8f2fb72fd17e ("erofs: update compression algorithm
    status") subsequently promoted Zstandard out of experimental status
    after more than a year of testing.
5. The CIP maintenance policy says that features labelled experimental
    may potentially be excluded after upstream LTS maintenance ends.

Could you clarify the intended SLTS maintenance scope?

- Does CIP currently intend to carry applicable bug and security fixes
   for EROFS core and CONFIG_EROFS_FS_ZIP_ZSTD through the projected
   linux-6.12.y-cip EOL in June 2035?

- Does EROFS being enabled in the CIP merged configurations place it
   within the reference maintenance scope, or is that scope limited to
   configurations submitted by CIP members?

- Would an upstream contribution adding explicit EROFS-Zstd functional
   testing to the CIP test pipeline help clarify or strengthen its
   maintenance coverage?

I am asking about the intended public kernel maintenance scope, rather
than requesting commercial end-user support.

Thank you,
Raymond

