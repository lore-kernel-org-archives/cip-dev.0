Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34261CCF9E0
	for <webhook@archiver.kernel.org>; Tue, 28 Oct 2025 09:58:47 +0000 (UTC)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
 by mx.groups.io with SMTP id smtpd.web10.7663.1761645510685061810
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Oct 2025 02:58:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=sKEjy+8n;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.52, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1761645499; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=I2hYGZXVTAISWYQ41+C+ClQaTFm2yusrkuPwjqKm5aTBv4tvfoiEfjc27LWGiqq5ii
    VCCVj4H51D+tzoqjAo/eigugshk3J0+W/yC/R2COCBSyg1Lhd7ldz3BV8HS8kq2tbeeY
    feQih/A8mn41oIoiY4h2YrTwGNSNFLO6K4eQe55B/RagHPQ9Keixmwt+cgTh5br174Po
    uGx8CWb2WSUzvEMxZd3fUTekmih17d7CBXQXzTwqYsZrGHJyxLH4g0r6c6LD/fiJT2Lo
    u6DLFuC86NRw1DsIlo6BqN8d/jg0UnUOVkDM0b3P88inrNRfPGxsI+8tpzgYVQ8P+0Ps
    lyBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1761645499;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=UMfgIwiQdcuK4vj/9twj4vYRHhn5bnd51tBG42MGn3E=;
    b=BCDfgrAkAJoR9z0gBUmV+NmjCdRNOoWqMuJKJybwPmuYWgfJDPeFEjPo0imEH8IDNE
    8Y9yrlHDQD3XVdiNNs9pAUu7wFl8GZOTdGRCY6Wesa46t9NBWuRgaufxcbAocszcyDuh
    IhaR6UqRaB9dc+4zEkxk6HPfCaaR+F2wxYnHg4LLLbHjSTjhOQm3yueHTZtb1lZ/iqgy
    ffpG+FeLnfoT4Ih4KfQWS3CtH1nVWKvWbeOIo4/Otpn77JhWUrOgW8EMvkot9/SGjzl8
    ILqebUW134khQBc7M3mcXxVgHLkl2L2xtlj6CZaks93uecAceQ2FFDERfqcp8amO6t6o
    Ia3w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1761645499;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=UMfgIwiQdcuK4vj/9twj4vYRHhn5bnd51tBG42MGn3E=;
    b=sKEjy+8n6CXPQ8rfP7C9JKA6ViPC77H4LfkDnkFyfy/vw/auXh1HzyepPe7+DHa1J8
    7wQSy99h5QeERVWMFAC9vnu3QyvmICVbZFtyftjfVA87M82AEYsgSG44HKIYqb8/4uDS
    vA2uZOrGhNrBw5eEcLMVngYYi1+Ve3WGEsZQFT6wtviBpqwR+27kpgd5PHJuq6DBhnFz
    rGIou+2FG1XIYaOcLav/261AVC/eP/MLghNovkMGdRWqQE+qhDZEEqwpOwqt9FJ1Zkch
    gDkMwp0Y0k6Bii/c1o5syPMhn/nq00mNtfQ+YXOG6xnC1zHp0Kkf1AkVk5Rs1pOc9ge6
    yuEg==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hexKHG+OxMWg=="
Received: from open-xchange-core-mw-gw-36.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 53.4.2 AUTH)
    with ESMTPSA id z2815319S9wJBva
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 28 Oct 2025 10:58:19 +0100 (CET)
Date: Tue, 28 Oct 2025 10:58:18 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <1483065062.11009.1761645498941@webmail.strato.de>
Subject: Request for review for 4.4-st69, 4.4-cip104
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.38.93
X-Originating-Port: 49668
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Oct 2025 09:58:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20252

Hi!

Here are the manual backports for the upcoming 4.4 kernel release. As always they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.4.y-st-rc

d019e4ada7f80 mmc: mvsdio: Fix dma_unmap_sg() nents value
86d6a790a96af i40e: fix IRQ freeing in i40e_vsi_request_irq_msix error path
67a69099af991 igb: fix link test skipping when interface is admin down
caeb615c0f733 net: Fix null-ptr-deref by sock_lock_init_class_and_name() and rmmod.
c7cf401d1bffb fbcon: fix integer overflow in fbcon_do_set_font
1bdd492e312c1 ocfs2: fix recursive semaphore deadlock in fiemap call
9ba58127984b1 e1000e: fix heap overflow in e1000_set_eeprom

Thanks for having a look.

CU
Uli

