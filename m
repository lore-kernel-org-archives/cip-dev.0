Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07EC4E6FE20
	for <webhook@archiver.kernel.org>; Fri,  6 Sep 2024 15:07:26 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.23])
 by mx.groups.io with SMTP id smtpd.web11.1183.1725635241513224164
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Sep 2024 08:07:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=KrLIUvOz;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=aeuvwrl4;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.23, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1725635226; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=sIn3nPQK/xN7shRiIwM+ma2llZEWSsT+b8SAKZlLRIezAPT27ku9GMCgso3HUhAIgt
    ax8J9cuDqSNRKhjNC645NEFQobIjIG6a5CaYXWRpLmrGL38nbA8EX3iZi+aWAKW9gebx
    whfcO6qPS6elS2ie7k/nRjHIJ1vmINPlQsmUT2uABwzzd8QY5mnmbqTWEwjWDwKWvdPK
    V/yvvfcW+ZWkSyATDYYh/k1rXewc7IFew/Ei9cFLcONB99UiBYhT0aaK/MFNvA6i98Mw
    +/7em9fKGZYPbtd6ET8Fz05noifBv+dxaCwuh+TSt20B1kPcxjsUOuwpLmDnOF8gqctI
    FZgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1725635226;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=dAvsExRkEC/gpdIxl+jXKFt9EqMsEXEAWQntwtcus14=;
    b=e/NF0NRA+FT3wp/lfjvZc507+vJqREFRRwD9Zk4DklsFYRzNIAgJdmfhj/VTHrAMYR
    BsPIvZ4RcVT6ZOkNENxdugu9kwvjk3Q4VWdb0Y0Y+gAyuNwldQ+SAoXqhJMpihDxTaB1
    6cKPHuk4BCnGgb6GRv/t6x/QuZTMW+YnSV6A4DB7m0+aHxlc6flgfWTTFAwHlPMsWqxp
    qfsZFsCpvW1FW0Tc3OFGVG1MI9mU8jF60+GXw54Qdx1o5GQRi5nqFBIAWYlcoEeWPykS
    2+0d8gc13B2avTB5AuN2YZug+l1cZhn7d81DPu7qwM8eITZJx8MqrXHOoGzCTwNLMLCn
    m8QQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1725635226;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=dAvsExRkEC/gpdIxl+jXKFt9EqMsEXEAWQntwtcus14=;
    b=KrLIUvOzN8ZpxNwFP14qnaB38QR5CBZm1YPCfF1Kt1z0sKr0nh57w994dsI9V+o/UH
    8fuwBo4In9x8ZaClw1Digf8svEZ8eeLAokegfjSrROaSRdzmllLUM4FL++YmVhyUZXX5
    PDwbcISZPde41RYSy3AEV1MiGbPvp1wEDNVDvuuwjnQdtPTNIprsSTpPQiwC5Y/IyTyP
    2yhKTp4eLuWDtjxEt/H8jx/fbjOgx12c32zYUOobRfBgBM+zvrkeJLPbo4X80039oBLD
    z29nrAFVNPeMfAb/iMv/ME/V8vrK8mT0VRgH6ufTlq5eIYQM5pyfnFUnz4A+2frf8CMG
    JnfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1725635226;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=dAvsExRkEC/gpdIxl+jXKFt9EqMsEXEAWQntwtcus14=;
    b=aeuvwrl4pid31IhEuOkJQvJnfF3eAJPxm1auX8D441LDgxcPS0CFic6hv4LCZAYiV3
    urEY7223EYzkQehbatBQ==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzstnjV5GU9c7oKNYMuRfGHqIHiuLmP1Lpd+UesJUZWVaudd1Gjb1n0"
Received: from ox-live-app401.back.ox.d0m.de
    by smtp-ox.front (RZmta 51.2.3 AUTH)
    with ESMTPSA id z960a6086F75HL4
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Fri, 6 Sep 2024 17:07:05 +0200 (CEST)
Date: Fri, 6 Sep 2024 17:07:05 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <2014275107.6543393.1725635225881@webmail.strato.de>
Subject: [ANNOUNCE] Release v4.4.302-cip91
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev67
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 06 Sep 2024 15:07:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16858

Hi,

the CIP kernel team has released Linux kernel v4.4.302-cip91. The linux-4.4.y-cip tree's base version has been updated to v4.4-st56. The trees are up-to-date with kernel 4.19.320.

You can get this release via the git tree or as a tarball from https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/4.4/

  v4.4.302-cip91:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.4.y-cip
    commit hash:
      309cb0b211f91a4c480ee93f99e73b723bea2c4a
    Fixed CVEs:
      CVE-2024-42131: mm: avoid overflows in dirty throttling logic
      CVE-2024-42265: protect the fetch of ->fd[fd] in do_dup2() from mispredictions
      CVE-2024-42271: net/iucv: fix use after free in iucv_sock_close()
      CVE-2024-42280: mISDN: Fix a use after free in hfcmulti_tx()
      CVE-2024-42284: tipc: Return non-zero value from tipc_udp_addr2str() on error
      CVE-2024-42295: nilfs2: handle inconsistent state in nilfs_btnode_create_block()
      CVE-2024-42305: ext4: check dot and dotdot of dx_root before making dir indexed
      CVE-2024-42309: drm/gma500: fix null pointer dereference in psb_intel_lvds_get_modes
      CVE-2024-42310: drm/gma500: fix null pointer dereference in cdv_intel_lvds_get_modes
      CVE-2024-42311: hfs: fix to initialize fields of hfs_inode_info after hfs_alloc_inode()
      CVE-2024-43839: bna: adjust 'name' buf size of bna_tcb and bna_ccb structures
      CVE-2024-43858: jfs: Fix array-index-out-of-bounds in diFree
      CVE-2024-43882: exec: Fix ToCToU between perm check and set-uid/gid usage
      CVE-2024-43883: usb: vhci-hcd: Do not drop references before new references are gained
      CVE-2024-43893: serial: core: check uartclk for zero to avoid divide by zero
      CVE-2024-43914: md/raid5: avoid BUG_ON() while continue reshape after reassembling
      CVE-2024-44944: netfilter: ctnetlink: use helper function to calculate expect ID
      CVE-2024-44948: x86/mtrr: Check if fixed MTRRs exist before saving them
      CVE-2024-44954: ALSA: line6: Fix racy access to midibuf

Best regards,
Ulrich Hecht

