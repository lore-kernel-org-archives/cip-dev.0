Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94455EFCD83
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 10:29:44 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.221])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11142.1773052178033127108
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Mar 2026 03:29:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=IAU5FiCi;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=8R0DGx3b;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.221, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1773052163; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=fyOhmJf7lqCDlgcWO3gqQpFe/B2zaq5YJbwA37mIINDX6urShR8eTngoeAZAD/Ei38
    DOIobT3GmP08rZmGd78kniG0o9osDNsWwpHc2VLZxmPFnQ5nmaL31z1OcGMvntsCGXRq
    WMvohp1C++jjcfwyV2QYFGQ1W8x05Wwd/fHQsi5C9wZ39SP4HL7ORPvxExxKkS8SJGzo
    urbKk1F2tQwtwvGFXH6LA+ugbpw/Jh2r+SlxlZA2cPyaAoUN3LO1baygtIyOIDN9yTF4
    SLtfS1YSZfzzjXhGSCKTRNOXkSPsphtBD2rxrLwgHWOk3S/M7FA7FCPaQ/2IA7uCJBd9
    tjhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1773052163;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=dmDbL/f85zqCtSDO6gRR/Htb4Q4Z+2266g7j2v1AQIs=;
    b=fC7Np6C3rRmr+66ZZ4H7PCy4kM3KjwJWwwawe3A65i1u2X9cim4P6icnLObAb66x3s
    mHcoFOt/NbEFFyuX8ZB8VAK6hJhtnOxBix4NslCZYHgNcvU1koTjLz3LfaElDZwQEeJw
    DhlOUencov3MlJDHdKKJlMtlD9pTgDGATy9pKxcPaDV0MfLO/6zQSfC6ycaRb9SHBTnf
    Ez2yPOCWu3W4OiVDyGDcuQBU2j0sU9bjB1tJ8uHkQ41k63QKa4iNEVOODfj1UbGyraAb
    TAxxAC9rdxeRzlXvwO52tfco1IJ/1Gg5KYpEY1rKErczD1tUn0+oicghZjwGm+cSY11v
    ojHQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1773052163;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=dmDbL/f85zqCtSDO6gRR/Htb4Q4Z+2266g7j2v1AQIs=;
    b=IAU5FiCieAAjCguvkGJaKb1gs7hx+gHa2uFu3djqb6q20Hi2Kzkj9IWkxp7gA0sSI2
    91xwToBuhVi1YkynZ3ffVJxeVmBNZYf9SkNBdtfDTrcfpzntTCze7wlVLuGBMGKNRk1f
    t+q1nZe1HQoPM6d/TKRSjk4CwqeTuN74H4cMtGpQGVPjRyOrwF/h1T7RzAE1lhk0lnES
    ApdhGpMIFbsrnoTI5uMcx0HF3W9ykc7oSLMQtH0j+S8nZ1RujSNVnaGmq6Y7v2Me/jrS
    3wYhnm02AhXAuyhn8lZ5ouEwblJSbXokAXVc6TZoACfsRZRZOWlXkQ+Ls/TO8pXXWwaN
    e4xg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1773052163;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=dmDbL/f85zqCtSDO6gRR/Htb4Q4Z+2266g7j2v1AQIs=;
    b=8R0DGx3bNJR3urT/L6Htc4nhBIhTkQ0OZyiRjdnTOW0Bwp/xvW3r4THBqW1Wi4b5Wv
    qYWG0bUyEfye7lzrtUBQ==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvtHhj3fsqaRJGu7ZycQ=="
Received: from open-xchange-core-mw-gw-2.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 55.0.1 AUTH)
    with ESMTPSA id z7806e229ATNGX6
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 9 Mar 2026 11:29:23 +0100 (CET)
Date: Mon, 9 Mar 2026 11:29:23 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Message-ID: <1176625679.56445.1773052163068@webmail.strato.de>
Subject: Request for review for 4.19-st14, 4.19-cip130
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.42.74
X-Originating-Port: 46370
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 10:29:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22167

Hi!

Here are the manual backports for the upcoming 4.19 kernel release. As always they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.19.y-st-rc

ae59d713843f7 f2fs: fix out-of-bounds access in sysfs attribute read/write
6df6a5fb43fb7 scsi: qla2xxx: Free sp in error path to fix system crash
^ note that this patch is incomplete and fixed up by fd6c9803c6324 ("scsi: qla2xxx: Validate sp before freeing associated memory")

Thanks for having a look!

CU
Uli

