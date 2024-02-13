Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98F8C4829A
	for <webhook@archiver.kernel.org>; Tue, 13 Feb 2024 13:16:44 +0000 (UTC)
Received: from a27-42.smtp-out.us-west-2.amazonses.com (a27-42.smtp-out.us-west-2.amazonses.com [54.240.27.42])
 by mx.groups.io with SMTP id smtpd.web11.10994.1707829171726896039
 for <cip-dev@lists.cip-project.org>;
 Tue, 13 Feb 2024 04:59:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ciplatform.org header.s=tec6x6pest4rapwo4hg3yjqz7t7qwsf4 header.b=KP0H3SHs;
 dkim=pass header.i=@amazonses.com header.s=hsbnp7p3ensaochzwyq5wwmceodymuwv header.b=lqJlilQc;
 spf=pass (domain: us-west-2.amazonses.com, ip: 54.240.27.42, mailfrom: 0101018da28d1322-ff85d3d2-a3fc-413d-b0c1-82d4d4455fa2-000000@us-west-2.amazonses.com)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=tec6x6pest4rapwo4hg3yjqz7t7qwsf4; d=ciplatform.org; t=1707829171;
	h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:To:Date:Message-ID;
	bh=RwfWxKG8T8IbOP8lRGM1gSWur+9mDHZGTHCNOtXNY3c=;
	b=KP0H3SHsW+D5Ilf/oD7kAL/YCLY+9Ncd4e65vDDwFHoCaD6HwaRdmuM+Gf9ZMLlr
	B7zsiLbTpRd3UNnSIm9gqvp+mU6tAcy0o/yyUUPvn1qGXhxj+p8qrImgAK1XygF2FQt
	j32MTiBnMDTNc9IJ8fFegOBbm/fywFrk9xthpueM=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1707829171;
	h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:To:Date:Message-ID:Feedback-ID;
	bh=RwfWxKG8T8IbOP8lRGM1gSWur+9mDHZGTHCNOtXNY3c=;
	b=lqJlilQcKO0pzmvfYifBsrORQXWoeXiHOgHupqjJz64+GL3A3sq7eE6Esu5prU/e
	G0dzxTkk75Fk0nS9d1u2o1Q1L5vL+g+F5o4qGO0kUo9Yq6OsCCImaxzdtqDg06+4woc
	mcku4/vyuAmB1PiwxU7sTmDRuVnVdNAcFXSKl35w=
MIME-Version: 1.0
Subject: LAVA notification for Test Job 1092228 qemu x86_64 software update testing
From: noreply@ciplatform.org
To: cip-dev@lists.cip-project.org
Date: Tue, 13 Feb 2024 12:59:30 +0000
Message-ID: <0101018da28d1322-ff85d3d2-a3fc-413d-b0c1-82d4d4455fa2-000000@us-west-2.amazonses.com>
Feedback-ID: 1.us-west-2.dpZ3+4zb8Tw1/c7xkFZPskvGKx/SAg98+h1xxHxUxV4=:AmazonSES
X-SES-Outgoing: 2024.02.13-54.240.27.42
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 13 Feb 2024 13:16:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14940


Hello,

The job with ID # 1092228 is now in state Finished and health Canceled. Job was submitted by sathujodas.

Job details and log file: http://lava.ciplatform.org/scheduler/job/1092228




Device details:
Hostname: qemu-patersonc-01
Type: qemu
Owner: None
Worker: lab-patersonc
Job details:
Priority: High
Description: qemu x86_64 software update testing
Submitted: 2024-02-13 12:59:04 (+0000 UTC)
Started: 2024-02-13 12:59:11 (+0000 UTC)
Finished: 2024-02-13 12:59:30 (+0000 UTC)
Duration: 0:00:19

--
LAVA
Linaro Automated Validation Architecture

