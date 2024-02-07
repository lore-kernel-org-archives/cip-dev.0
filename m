Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37BEC4828D
	for <webhook@archiver.kernel.org>; Wed,  7 Feb 2024 12:39:01 +0000 (UTC)
Received: from a27-42.smtp-out.us-west-2.amazonses.com (a27-42.smtp-out.us-west-2.amazonses.com [54.240.27.42])
 by mx.groups.io with SMTP id smtpd.web11.18008.1707304813944690159
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Feb 2024 03:20:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ciplatform.org header.s=tec6x6pest4rapwo4hg3yjqz7t7qwsf4 header.b=Z+GPdsKP;
 dkim=pass header.i=@amazonses.com header.s=hsbnp7p3ensaochzwyq5wwmceodymuwv header.b=EDsZpTSx;
 spf=pass (domain: us-west-2.amazonses.com, ip: 54.240.27.42, mailfrom: 0101018d834c0135-6147a8f3-30fd-452c-8eb6-f818145f04d7-000000@us-west-2.amazonses.com)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=tec6x6pest4rapwo4hg3yjqz7t7qwsf4; d=ciplatform.org; t=1707304813;
	h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:To:Date:Message-ID;
	bh=o6li0pRk1tovlOo1WaITHvDf+r5IhQm4k+mWMebypkA=;
	b=Z+GPdsKPnOrOFrTMhnjK/78t7kbP0rEkakvv5yiv9CP85AUA4ILIQHLMSKJzgbRT
	xWxdvwetQ/x0WhJ3oJxeO0+rQbzO1U/DAq3t3XKajCFR4mOFasZ0cF8NFVYr9W9Hweo
	1ncbEMOKjmp0wCHmMBCIBlYj8BzOV5leD8wY6EDU=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1707304813;
	h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:To:Date:Message-ID:Feedback-ID;
	bh=o6li0pRk1tovlOo1WaITHvDf+r5IhQm4k+mWMebypkA=;
	b=EDsZpTSxohrUQiXQOEpr/DnNnaeawnh1WgnwRvxpOjP/Ooqy0Ten1VuM9pNRFSUT
	ITzlIOjcJGYxeqTfpn6XTOLsyKXUsC6FkfCxBKR6JtNdg71/o+1UAe+CzFNHV3OHe9u
	B6Ssw0LemBssWbz+Yp8/wJVRSWJjAOui/NNU6diI=
MIME-Version: 1.0
Subject: LAVA notification for Test Job 1089996 qemu arm64 secure boot testing
From: noreply@ciplatform.org
To: cip-dev@lists.cip-project.org
Date: Wed, 7 Feb 2024 11:20:12 +0000
Message-ID: <0101018d834c0135-6147a8f3-30fd-452c-8eb6-f818145f04d7-000000@us-west-2.amazonses.com>
Feedback-ID: 1.us-west-2.dpZ3+4zb8Tw1/c7xkFZPskvGKx/SAg98+h1xxHxUxV4=:AmazonSES
X-SES-Outgoing: 2024.02.07-54.240.27.42
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Feb 2024 12:39:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14880


Hello,

The job with ID # 1089996 is now in state Finished and health Canceled. Job was submitted by sathujodas.

Job details and log file: http://lava.ciplatform.org/scheduler/job/1089996




Device details:
Hostname: qemu-patersonc-02
Type: qemu
Owner: None
Worker: lab-patersonc
Job details:
Priority: Medium
Description: qemu arm64 secure boot testing
Submitted: 2024-02-07 11:19:47 (+0000 UTC)
Started: 2024-02-07 11:19:52 (+0000 UTC)
Finished: 2024-02-07 11:20:12 (+0000 UTC)
Duration: 0:00:19

--
LAVA
Linaro Automated Validation Architecture

