Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F80C4345F
	for <webhook@archiver.kernel.org>; Thu,  2 May 2024 11:25:36 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web10.2024.1714645631095269823
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 May 2024 03:27:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=kumar.rakesh@siemens.com header.s=fm1 header.b=UZ+iotLx;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-1325885-202405021027081ed8465301d0df3dfe-4kskz7@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202405021027081ed8465301d0df3dfe
        for <cip-dev@lists.cip-project.org>;
        Thu, 02 May 2024 12:27:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=kumar.rakesh@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=6EUoShhywqt8jfNesKr+sSg/zsuE08Ht4deR7C+8WFU=;
 b=UZ+iotLxEx5CTFmYagvewJmhQmtl8/qFg/Gtr7ZBVro4e2GUaUi1dBMgXs/PTRKTUkdblk
 p0bQsbv5qFxC2e15/c58u28n6wHox6T04CRMIg1a1H/pHPvxrTfrVf6Jo7n5UBXDXhJQ3dzZ
 Bk7l1wES/cTC8zy5RGezbHz85o9ss=;
From: Rakesh Kumar <kumar.rakesh@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Cc: kumar.rakesh@siemens.com
Subject: [isar-cip-core] [PATCH v3] update ISAR to latest version
Date: Thu,  2 May 2024 15:56:36 +0530
Message-Id: <20240502102636.909130-1-kumar.rakesh@siemens.com>
In-Reply-To: <321d6c65-fe1a-4714-98dc-5e496cf6d22a@siemens.com>
References: <321d6c65-fe1a-4714-98dc-5e496cf6d22a@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1325885:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 May 2024 11:25:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15804

From: kumar.rakesh@siemens.com


Yes, I think we can wait for the mentioned patch.

https://patchwork.isar-build.org/project/isar/patch/aa9baf96-98d8-41fb-9297-9d9b20d1520e@siemens.com/

Regards,
Rakesh

