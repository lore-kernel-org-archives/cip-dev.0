Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E23BC87FCB
	for <webhook@archiver.kernel.org>; Wed,  6 Aug 2025 07:13:30 +0000 (UTC)
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 by mx.groups.io with SMTP id smtpd.web10.19292.1754463932906109172
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Aug 2025 00:05:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=huaqian.li@siemens.com header.s=fm2 header.b=eEOkOAAh;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.228, mailfrom: fm-959203-20250806065523c4dbe171210894a4c9-_ueca3@rts-flowmailer.siemens.com)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20250806065523c4dbe171210894a4c9
        for <cip-dev@lists.cip-project.org>;
        Wed, 06 Aug 2025 08:55:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=huaqian.li@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=nKYMAhKv+3MQBloZp/dnw8s1AA/2vdFh9uixoBnJk0Y=;
 b=eEOkOAAhtl/O3aq0CEa6Ge5Sql44V6/QyT9CuJqOznq0gWLXrw/SGZjwNLLWJWZRkcPGB1
 eG+XPo7m3MKgtvu64R+80mI5BHov5G/HwcLIm0n0nGv382MkQl8FNur70BdCyvcjGibZU/V2
 t0b6pjMXgF6acKpiK9YHVb02mVJbqZXf3iuYKxfMFTi32S4NObNGdaJpHs98/zvvbobe1+kQ
 unQwYA89jGnPsveW4O1ZUFPcL1NirE2nCpMOHwPimdUUWswYcE4aQHPthqnMpLXAMWRLfXJ9
 Wwj1NX5YjjZeK/mA++qweoUXdvaRAly0Vi+VGYOSWmHj25WJtQGCFbfg==;
From: huaqian.li@siemens.com
To: cip-dev@lists.cip-project.org
Cc: baocheng.su@siemens.com,
	huaqian.li@siemens.com,
	jan.kiszka@siemens.com
Subject: Re: [isar-cip-core][PATCH] edk2-standalonemm-rpmb: Bump to 202505 and refresh crypto dependencies
Date: Wed,  6 Aug 2025 14:55:05 +0800
Message-Id: <20250806065505.1524960-1-huaqian.li@siemens.com>
In-Reply-To: <caf3732b-c31d-4cd0-b479-7a55d56973ef@siemens.com>
References: <caf3732b-c31d-4cd0-b479-7a55d56973ef@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-959203:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Aug 2025 07:13:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19685

Hi Jan, 

You are correct. I have conducted the test, and also confirmed the persistent data on the RPMB.
One of the test cases was to verify the UEFI keys and the UEFI Secure Boot functionality after the upgrade.

Thank you.
Li Hua Qian

