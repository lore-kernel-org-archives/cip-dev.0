Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBEDCD98D5
	for <webhook@archiver.kernel.org>; Thu, 11 Jun 2026 11:04:09 +0000 (UTC)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.42919.1781175848867352472
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Jun 2026 04:04:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=E9WXtKNF;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=UmMtrf7q;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.167, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1781175818; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=RdsjLno+XoyC44b5GD5LD8ZdMy5tggq+WmVABkLDMMutAZxjxrEdSei5lREpaFcPMV
    TDIeLVneW41kMGFTYBwadOknW9J/YqEEePUl5VGPvkUn4UHYekCWFOpfWRg0Vo+UGVem
    YoERomX4SAWBPoCuK/RKXIH6RnRNFUAdnLe7V2CS/5Qh2IlCpOX2VWsArvXFInAf017y
    dKkZ57n5+1nqJW+gP8q4nHVTni8LmXE6dyjn9yHwS1aAx7xFAtX5dE+NuWMbtKM31qXw
    4AVvUYrwegczFjmv8i/3kUBG7Z2paz583KJ7+OgvVwTH5vmrZ7/MgyBYhHHCWf02O5kh
    NWUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1781175818;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=8kJZj04XI6wm2+JOPEHmfV2r54AvswR3gMQlpWwFNgE=;
    b=bIBAEasX4AKSDzvixdpwbYBKUbg4KZc7PueOreyldtKG9fiAZV/lsCwlwnVWQIUAyu
    2F6OppgoOjBrWoFfbJCAAZr20/D9+Nd6dyfTBoH1neEHNvHH7DLzjbxfG/UNiycksSIE
    FIdR+sF4jeKTM0iraqoHz/EFw/pGDsQa7Ldszsavvu739C+nxCCYqCJ9dMTNvQqf1O8U
    xVA51R4wPzAi8/Gft/T/e/4n3XIsh18SYV+gZFb4S7k378zXUexESZ8mXVNT8WTY0+Cm
    zsJEx1ptZr5EC7CAEBp/e+LZVUIyjtixXN6PX+rsVuTFT9Wu/Js8BCvrblTE+8lFLUa8
    4gGA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1781175818;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=8kJZj04XI6wm2+JOPEHmfV2r54AvswR3gMQlpWwFNgE=;
    b=E9WXtKNFLpOvh/ULQFyunU2K4EEC9kPsPnffK6SxcxdawhbCizX1W0l88KlhLQ1RAg
    Waay21NxB0ar1wkQof4XujIQP5iGKvakpqMtJOwSRwDrUzePgTRsn8QC/aAvtQy2kIrq
    D8Yzu82N+538KncFyhUL1V6wS2pxypoWPdRtGX8q7hUybgjzAKipjRYpZDsjrjRgm74Y
    eD6phukAVOyEyUVpefwZC/9QyRVFdoVyH1Z7f+IvThcoOtMQJSREYKbvDelX1PZtkR47
    YkXqDtwLIFqU3FQJj/Sd3GpXhJQ+ZFc2SdaAiFlsM7hqkhz/JCwFxUv3cXv8ds3tt4bv
    xt6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1781175818;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=8kJZj04XI6wm2+JOPEHmfV2r54AvswR3gMQlpWwFNgE=;
    b=UmMtrf7q7n6YDFkHulpIeMzO7Xkf157RsyBYX/gdWD6VJdJP3fvMusH+atZREJYdFh
    m0+rb8cEj9Jxa6QsfdCA==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hexKDK+NL2bA=="
Received: from open-xchange-core-mw-gw-4.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 55.0.1 AUTH)
    with ESMTPSA id z7806e25BB3cLDr
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 11 Jun 2026 13:03:38 +0200 (CEST)
Date: Thu, 11 Jun 2026 13:03:38 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Message-ID: <2096828768.335498.1781175818065@webmail.strato.de>
Subject: [ANNOUNCE] Release v4.4.302-cip112
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.46.142
X-Originating-Port: 39830
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Jun 2026 11:04:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23129

Hi,

the CIP kernel team has released Linux kernel v4.4.302-cip112. The linux-4.4.y-cip tree's base version has been updated to v4.4-st77. The trees are up-to-date with kernel 4.19-st17.

You can get this release via the git tree or as a tarball from https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/4.4/

  v4.4.302-cip112:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.4.y-cip
    commit hash:
      56627e4054266cea66abc1e4c86fe10f90a5da96
    Fixed CVEs:
      CVE-2025-54518: Improper isolation of shared resources within the CPU operation cache on Zen 2-based products.
      CVE-2026-46174: x86/CPU/AMD: Prevent improper isolation of shared resources in Zen2's op cache
      CVE-2026-46333: ptrace: slightly saner 'get_dumpable()' logic

Best regards,
Ulrich Hecht

