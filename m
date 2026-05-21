Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F3CCD5BA4
	for <webhook@archiver.kernel.org>; Thu, 21 May 2026 09:49:57 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.218])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.32990.1779356989534514618
 for <cip-dev@lists.cip-project.org>;
 Thu, 21 May 2026 02:49:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=RRJaBRga;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=BjN9gnlR;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.218, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1779356981; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=RKTY3S709eszhzeB/msV8gu2D88itZCZBPG8dxsI3HVH6i0M/OU1ASiHiuaLr8y8Co
    tvT5extwzcHjdyO6YIj6dyfOgP4cqQbkGcrc0o5iToROrYhiYaRd6WzCpbzel06yRw2y
    ccTc/R8wUH4Qhb9/NQnnpyxcSjr3NXY1Vuhx1gZknXPk6761d9yqs0afMX+/HbzAjRge
    I/HxzXdSXNVmpdlvT1OmaQ0ITO0SnQZwMuB6bBRGrFQCMI4SsYWd1wGByvt3Q4k6o8PN
    eyqGHbq6+ZoQzooCCounoBir6uSr8kgJ0hJ1qNKYky/Z8Ou96IITZTpPM0xfSnw2O1yS
    tvVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1779356981;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=rYpVTOcaVk4A8oNbSA1HHTGlBVDeZJCBN3PBEIPbjVw=;
    b=d49dd9HAL1RCQ9iwzcEH9LkTBAG2YL9QKhHxux6u6+P484YLreGKqONMH1H9EK4CAK
    fezcmzfmIGhJetoAXTx9M0+/GXwPyMDuoetGeAEBf67Ipc/HB6lRFfaq0eFhmTaUGRjQ
    8qpsEV86yza2X6HQzeAm/oNX2YtjU0T/vaqS/G9g1Egb5R5FMc21U56Q7bpYoxKL+m8m
    /wmn3LWIbTID1IgWP8dOvdSTVOrIPUAGDrI2p6Sc9JGWdxrB7YPQUmWfFdjngtDo2Ed3
    AyaVadfhdX/sVQsYOXgZmtLL/eQUMAEzrKSOkTE7H8uA3yX5kSgUG51TvRVUgtwHiEDg
    XcNQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1779356981;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=rYpVTOcaVk4A8oNbSA1HHTGlBVDeZJCBN3PBEIPbjVw=;
    b=RRJaBRgaLvywf1nM/TJYgvCu6VEr87G9DeUFFS/V/fwqGqkMzkY+ut/ULCnFr69wgY
    i7107TrLb5jf3uaOuay+zChE5JAYPt5pBAtPVooHI2yQlOODplCOrvztDYhWTSt9QLRc
    gUZsNIBeINx1q4zxfyyp6SRawSlLW3YaIKk0EvbAkr1MYJtEA7b86U04aa0EszlZCVbb
    EJ5z+7sJDHWaT/CT0krPlc9QLHEqC3V7y9ZJjTmIsexR9WnxAehS4LkZzqPHqCqq+r8i
    4sa4uXJT06wd2dWjsWqfNmYek05kUCymeYZCTQA0OxFGuuscBgWHkKldbwNkbTvmKLZ8
    6V3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1779356981;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=rYpVTOcaVk4A8oNbSA1HHTGlBVDeZJCBN3PBEIPbjVw=;
    b=BjN9gnlR+SNY//6AubCnWez7oPjO8qBCnXriM2RjqE3AlPpazL/ADUnE8NmsNK8iO4
    nVCpQ4MWy9x1X9fXL/CA==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hexKDG+LdTmA=="
Received: from open-xchange-core-mw-gw-16.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 55.0.1 AUTH)
    with ESMTPSA id z7806e24L9nfAKN
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 21 May 2026 11:49:41 +0200 (CEST)
Date: Thu, 21 May 2026 11:49:41 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Message-ID: <516262162.225768.1779356981051@webmail.strato.de>
Subject: Request for review for 4.19-st17, 4.19-cip133
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.46.134
X-Originating-Port: 43170
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 May 2026 09:49:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22989

Hi!

Here are the manual backports for the upcoming 4.19 kernel release. As always they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.19.y-st-rc

b7885f23ff4c9 x86/CPU/AMD: Prevent improper isolation of shared resources in Zen2's op cache
da51b237e7bbd x86/CPU/AMD: Add X86_FEATURE_ZEN1
e49d8098895b4 x86/CPU/AMD: Rename init_amd_zn() to init_amd_zen_common()
f7c75253044df x86/CPU/AMD: Add ZenX generations flags
874e7cb1436fc ptrace: slightly saner 'get_dumpable()' logic

Thank you!

CU
Uli

