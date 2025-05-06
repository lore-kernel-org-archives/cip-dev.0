Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC61C3ABAC
	for <webhook@archiver.kernel.org>; Tue,  6 May 2025 15:14:05 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.221])
 by mx.groups.io with SMTP id smtpd.web11.78797.1746544444356085068
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 May 2025 08:14:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=o5aqm/UY;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=dvA5Yb+2;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.221, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1746544433; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=OOU0vi8w2VoFgrH+pPlEtEgAYEdxdvEV0iRRsZiyQ6M6f+ak/HdIQAX8g5TQes2/PD
    pkeomy5YnB25gNVNTgiQUs3r4gLH/KvYdQf+HMB9zXLnUBrAOkRD4UV7BW8I3GQI41qC
    CMipSWH6u+2cUS+22C5XJFkk5gcO2CdlCcE7C8o6Yn3pRHeLmmbdYJCJ/3V+gCzupR1/
    oiifOwdfLZNPEumJmj7gFCP3Kpm4A0cjpkH5Sx4uvZAL9RW1XoNRsvBU17974E2Ri7vQ
    amCwbPDP/B5tUE/Gpt3BkhUJkdq6Y/ue3/kj2hiQGVlV/D4JWozXs2HDt6XduUbLwC5X
    rizw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1746544433;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=KYea+3MzBf/R+M5OdIrNNm43BYE4/QCiTwl0fH1iWYQ=;
    b=jjZwruDNS5SGwGeV6W/GH1Y4SgH2b+n3C940FMi/MlTE+z99zEXhdb/t1li/7n6ixg
    TCseZ8eRiz6RvRKFsP5e1lQ6Z1LUsSlmCbFafINrMkAkNA5Glmt9+XhOWLeO1/CXcLva
    5KPJqqeladjg1y4PqEEZe+VlbKS7RP56KSalKX12foVroj+/eOoj3mLfuXV4Dwp3tP3X
    G4ZxoBRm94Y9bhCCKKnRb+6/M32+6FvRv8Zhvh+Z6OKlyDentWYglC2d/ZN8jmpk19Fa
    133VjY0na/bZHjzrUQzKq3ztMHRWyIPKu9XzNLqQC4PsgeTy8TgO60FqGJa0KkGX6X2V
    1p2w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1746544433;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=KYea+3MzBf/R+M5OdIrNNm43BYE4/QCiTwl0fH1iWYQ=;
    b=o5aqm/UYFjZkyb+hfHIp10oBsOdOQwugU6YjLyG8/G8fohdEpjUiTR0dSA2GzLAMX7
    d2x7XbmTz//ltz7SLzmdZcOyk/mm/fr1UBD3Z3FJ+u2jd0NLsrOC+vzB86VTDQ1R/CKB
    IUGs5h2e0wiJkUqNpA0MqZqHKxIOsSHlNV+P0p8yQ7Vdxa3BQ1DpNOumIT4pYbudrSyS
    qLFMUuHpbkDfnkAQAsrKe6LSZydbnENDOqYttkUudHqCurje2aZ8idWIFYahv2UeZMhD
    kpu1No/io36lL+AIkmST1xl+9XAdCx1rDxEhCfUwZ3qHzBK0fReUzUAKUEjc44N+4ltb
    E6ww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1746544433;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=KYea+3MzBf/R+M5OdIrNNm43BYE4/QCiTwl0fH1iWYQ=;
    b=dvA5Yb+2UO1KqUqg/hk7SJXgVouwu6apP5mVT8vuiNsUNW/br0S7RQxId3W92a3Ikk
    WmHEfapnBi2Bg0JCUABA==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hexKfB+MdtjA=="
Received: from open-xchange-core-mw-gw-24.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 51.3.0 AUTH)
    with ESMTPSA id z2a340146FDrtVM
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 6 May 2025 17:13:53 +0200 (CEST)
Date: Tue, 6 May 2025 17:13:53 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <781807518.215591.1746544433020@webmail.strato.de>
Subject: Request for review for 4.19-st4, 4.19-cip120
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.33.60
X-Originating-Port: 46026
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 May 2025 15:14:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18769

Hi!

Here's the single manual backport for the upcoming 4.19 kernel release. As always it can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.19.y-st-rc

b6c3d672c55ea net: dsa: mv88e6xxx: propperly shutdown PPU re-enable timer on destroy

Thanks for having a look!

CU
Uli

