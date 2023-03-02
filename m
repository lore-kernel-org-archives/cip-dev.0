Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F88C7EE30
	for <webhook@archiver.kernel.org>; Thu,  2 Mar 2023 20:31:01 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web10.5531.1677789059901941510
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Mar 2023 12:31:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=e6NLt/8W;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-294854-202303022030556e25ebefa3f88c36b2-xehj04@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202303022030556e25ebefa3f88c36b2
        for <cip-dev@lists.cip-project.org>;
        Thu, 02 Mar 2023 21:30:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=KJxJH/dJRg9vRURAUlnfccPsaSNqypdcWk1paQIdtDA=;
 b=e6NLt/8Wn+IxmdKEtZBPNLRwYQ+y0gyE5vFkXneyqlDuNde/F/dNOkGqlxU5rqgn0wUtxc
 DkFgRCYcI6vnRMTcUJCDoru6ssSIO047mRr7ECTX7cmWUJDl4Yc+IYKEfC7rq/EbcZHIEZNU
 pR8gQSyp9mV2CWeZ619Fw4Cu3UaUo=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Sai <Sai.Sathujoda@toshiba-tsip.com>,
	dinesh.kumar@toshiba-tsip.com,
	kazuhiro3.hayashi@toshiba.co.jp,
	quirin.gylstorff@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH 0/5] Enable feature combinations of test and security extensions
Date: Thu,  2 Mar 2023 21:30:49 +0100
Message-Id: <cover.1677789054.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Mar 2023 20:31:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10887

This allows to build SWupdate/secure boot images with test extensions as
well as security extensions.

Jan

Jan Kiszka (5):
  swupdate: Avoid open-coding IMAGE_FULLNAME
  initramfs-*-hook: Avoid open-coding IMAGE_FULLNAME
  start-qemu: Add support for booting test-extended images
  cip-core-image-security: Add support for SWUpdate
  security-customizations: Fix password hint

 classes/swupdate.bbclass                                    | 2 +-
 kas/opt/security.yml                                        | 3 +++
 recipes-core/images/cip-core-image-security.bb              | 3 +++
 recipes-core/security-customizations/files/postinst         | 2 +-
 .../initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.1.bb  | 6 +++++-
 .../initramfs-verity-hook/initramfs-verity-hook_0.1.bb      | 6 +++++-
 start-qemu.sh                                               | 6 +++++-
 7 files changed, 23 insertions(+), 5 deletions(-)

-- 
2.35.3


