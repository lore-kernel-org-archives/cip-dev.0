Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F121EC48260
	for <webhook@archiver.kernel.org>; Tue, 13 Feb 2024 13:16:34 +0000 (UTC)
Received: from a27-52.smtp-out.us-west-2.amazonses.com (a27-52.smtp-out.us-west-2.amazonses.com [54.240.27.52])
 by mx.groups.io with SMTP id smtpd.web11.11141.1707829575670061635
 for <cip-dev@lists.cip-project.org>;
 Tue, 13 Feb 2024 05:06:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ciplatform.org header.s=tec6x6pest4rapwo4hg3yjqz7t7qwsf4 header.b=LEVKtIFR;
 dkim=pass header.i=@amazonses.com header.s=hsbnp7p3ensaochzwyq5wwmceodymuwv header.b=Pg/EgNqt;
 spf=pass (domain: us-west-2.amazonses.com, ip: 54.240.27.52, mailfrom: 0101018da2933c61-b9142f0f-7829-4271-b5e8-8b23faae1592-000000@us-west-2.amazonses.com)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=tec6x6pest4rapwo4hg3yjqz7t7qwsf4; d=ciplatform.org; t=1707829574;
	h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:To:Date:Message-ID;
	bh=cy3NMilwIuR0lSp+9wwqrpwxAq9r9KjfCI/cY56ck9A=;
	b=LEVKtIFRhmdcev2vdTl8Cf5h9Gnjm47q4mZl1SIode0c6RY5AHKnXel42ZOdw+hQ
	DHimUpeqRpO2h9Pi75Weqtt/z5nd72qVVLeywu4BraLohqk1YGHGUPXijSWmt5osUfO
	2qfK/0eAlaqwAZDg1XygAMkTV3I+TYR5dVh5yeyU=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1707829574;
	h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:To:Date:Message-ID:Feedback-ID;
	bh=cy3NMilwIuR0lSp+9wwqrpwxAq9r9KjfCI/cY56ck9A=;
	b=Pg/EgNqtnNEtznQFFB28cJ+bLPCcm1SmpuOsKA0E2O9/eHSMMDCQWG1XkAAml1TI
	tOGHJ5OGcHuKBV71wAjE2eYBO8sLWUdKMKGSKNC3bj5Jhtu3tCcTkovkZButoK5pXEb
	pFtoSPcK3QNuBVQh3y00gM/T/NsSgGF6XXNFEys4=
MIME-Version: 1.0
Subject: LAVA notification for Test Job 1092229 qemu x86_64 software update testing
From: noreply@ciplatform.org
To: cip-dev@lists.cip-project.org
Date: Tue, 13 Feb 2024 13:06:14 +0000
Message-ID: <0101018da2933c61-b9142f0f-7829-4271-b5e8-8b23faae1592-000000@us-west-2.amazonses.com>
Feedback-ID: 1.us-west-2.dpZ3+4zb8Tw1/c7xkFZPskvGKx/SAg98+h1xxHxUxV4=:AmazonSES
X-SES-Outgoing: 2024.02.13-54.240.27.52
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 13 Feb 2024 13:16:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14939


Hello,

The job with ID # 1092229 is now in state Finished and health Canceled. Job was submitted by sathujodas.

Job details and log file: http://lava.ciplatform.org/scheduler/job/1092229




Device details:
Hostname: qemu-renesas-02
Type: qemu
Owner: None
Worker: lab-cip-renesas
Job details:
Priority: High
Description: qemu x86_64 software update testing
Submitted: 2024-02-13 12:59:49 (+0000 UTC)
Started: 2024-02-13 12:59:54 (+0000 UTC)
Finished: 2024-02-13 13:06:14 (+0000 UTC)
Duration: 0:06:19

--
LAVA
Linaro Automated Validation Architecture

