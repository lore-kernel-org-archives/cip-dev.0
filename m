Return-Path: <benedikt.niedermayr@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DAF2EC01B8
	for <webhook@archiver.kernel.org>; Mon, 23 Mar 2026 10:01:31 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13490.1774260080472227733
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Mar 2026 03:01:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=benedikt.niedermayr@siemens.com header.s=fm1 header.b=LxQn1yXH;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-1323861-202603231001170ebc01c42000020778-p1xnq_@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202603231001170ebc01c42000020778
        for <cip-dev@lists.cip-project.org>;
        Mon, 23 Mar 2026 11:01:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=benedikt.niedermayr@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=VsCP7qyro734FvGtZ4HMmvWfwGfFPiNqoxcNZQvO9+8=;
 b=LxQn1yXHQdwJAV2DLIzzgDHli1yaRjzWd72V2bzPpAVLDnjtOGw2DAYeffMqgR3GfQtCqn
 BhyZ3hf5plFiUdnESor3dSjxqpQovw2F2QRjLmmtjzyFEtxQigObQpd9sKeTBHAM1dsFZuAw
 HP5iL05c/clU3qEzRu+kZPB8tG/NaW7FjMh5NCk1PYKKhnpam2SHFqEJOfQI5dq0fbfrd9DH
 DKdmcinOW/Sw0aSKNOk2euZKcYAB59fx6fYe4aE8jdRHMmS/54jt4mFMYKkwPinOzWYzo7FK
 ONAER0DdgpaUgKpTx1VwFINVP9NVcPmuAeWELsWpac/J+Puh+oDYp6WQ==;
From: Benedikt Niedermayr <benedikt.niedermayr@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH v2 0/1]  start-qemu: allow more variable injections
Date: Mon, 23 Mar 2026 11:01:11 +0100
Message-ID: <20260323100115.3263956-1-benedikt.niedermayr@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1323861:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Mar 2026 10:01:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22522

Changes since v1:

- Additionally allow to inject IMAGE_DATA_ENCRYPTION and IMAGE_PREFIX
  via environment variables.
- Adjusted commit message accordingly.
- Adjusted usage output accordingly.

Benedikt Niedermayr (1):
  start-qemu: allow more variable injections

 start-qemu.sh | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

--
2.43.0

