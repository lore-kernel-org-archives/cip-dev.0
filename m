Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25A9E77171
	for <webhook@archiver.kernel.org>; Thu,  5 Dec 2024 06:56:31 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.219])
 by mx.groups.io with SMTP id smtpd.web11.5062.1733381783829298008
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Dec 2024 22:56:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=nvyBXy7j;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=ZK9HchP6;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.219, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1733381767; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=RjlNrOXmT5aEDf8g8X1axeXZogvU0W4XXiTJSY98A3I9KwupwFR0YzlVWu5nWT7w4v
    D/fodPCuaORNXKP5Hs/tNdktqGPEcL5ZMwQ+6/W/mbB/FZrnFmR8XzE/b0b0Ie0Bs4VW
    98xKbzmlqWL53So/PdujbtBc0VMjWjUYGRx9eLYpDx2lwZ9RjVh9QkJ/iSoq0UI/y9Po
    woPkd4/AunOxcamFLepkyTgN+nPEyveodUBLvSJaOHM2eGSU80+8MF9+UZfMIjejP8Z9
    y/UXkF3oLfqgnZ09NiUoEF9vUEwpKmhtFxVaVhxO5F9ske6PacCmJgZDeikxX2uc2xHF
    K/yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1733381767;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=YDXxkFnDiCXtD1WPjbWmKaeB3IE79ilRZllJ0TYXk/w=;
    b=l64gjtvwPoCOTphStYlI8hmKv8jNs1haSiC5yRjOxDtiSnNXEoaNPHGSEsZvvwIk09
    COGTBzzzJv4Ih4EolFwoIQTFAoig2Qt1vd08a6kH/OUMIiJ1Hrj1sHpqD+uiKPks150y
    lpzY2UhCCjSdNurBr7McT4ZztUc3t8DJUZwOb5Jtq5ic8RWyJosy25U412v7JAp9DjW8
    HzUPT+Lifpt7djWEk/HzCYlFwAdyDxQxwvXHYRNxcoGKsGAtfjKJQRlhrPwfChlpynwI
    xgYFwNJ+LlOwP3nBedjbS2VNLwmPi7A9pytZv2Y+dfs1xW9i1uZqvPZ4AVVdobgZ3P9M
    fd9Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1733381767;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=YDXxkFnDiCXtD1WPjbWmKaeB3IE79ilRZllJ0TYXk/w=;
    b=nvyBXy7jqpSbNYmDykQmNy59eWSBBdHWskXSvxxz5l8FOjKtZC+XJ8nlyh+9C07TTU
    N/8HmkLuPi5yl7eeJAdz4vPgmgSz2fXBaNpUL8n+Y2ZtUR8Bl/E71paT78NqPC5vlPxy
    d53KW8aIddnC6CQQu358LqmHR5NC4N6VH8l/dgKu348iILumrn64Swsu1ZljdQ00qJyg
    NLmxri+QRoLMeXNh3phdYCSI2Q9wLLMA4V3aduH5C35Wjl2rVVrNh0scVI8vMgDogVZJ
    HB2bO1Lxd4IIBPgcn716D43ZMsu5oYShfQp+RmA+5E236ctao9sejjD3Fa7GDc108NBV
    pM9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1733381767;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=YDXxkFnDiCXtD1WPjbWmKaeB3IE79ilRZllJ0TYXk/w=;
    b=ZK9HchP64lOuk5ATqOVbFwvddkq1c/xlLvTQMBlJ3RYFtGsu1IHYg0dPJTKTxxbod5
    aA1+FpT3sQ1nQmNQ2qCA==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvtHhj3fsqaR1GvSyJdw=="
Received: from ox-live-app202.back.ox.d0m.de
    by smtp-ox.front (RZmta 51.2.11 AUTH)
    with ESMTPSA id z9fbae0B56u78SF
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Thu, 5 Dec 2024 07:56:07 +0100 (CET)
Date: Thu, 5 Dec 2024 07:56:06 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <1480600060.1131781.1733381766972@webmail.strato.de>
Subject: [ANNOUNCE] Release v4.4.302-cip94
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev70
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 Dec 2024 06:56:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17329

Hi,

the CIP kernel team has released Linux kernel v4.4.302-cip94. The linux-4.4.y-cip tree's base version has been updated to v4.4-st59. The trees are up-to-date with kernel 4.19.324.

You can get this release via the git tree or as a tarball from https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/4.4/

  v4.4.302-cip94:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.4.y-cip
    commit hash:
      3ed48e91c838a2d00d06c208590a48ce96ce0d00
    Fixed CVEs:
      CVE-2024-50265: ocfs2: remove entry once instead of null-ptr-dereference in ocfs2_xa_remove()
      CVE-2024-50267: USB: serial: io_edgeport: fix use after free in debug printk
      CVE-2024-50269: usb: musb: sunxi: Fix accessing an released usb phy
      CVE-2024-50278: dm cache: fix potential out-of-bounds access on the first resume
      CVE-2024-50279: dm cache: fix out-of-bounds access to the dirty bitset when resizing
      CVE-2024-50287: media: v4l2-tpg: prevent the risk of a division by zero
      CVE-2024-50290: media: cx24116: prevent overflows on SNR calculus
      CVE-2024-50299: sctp: properly validate chunk size in sctp_sf_ootb()
      CVE-2024-50301: security/keys: fix slab-out-of-bounds in key_task_permission
      CVE-2024-50302: HID: core: zero-initialize the report buffer
      CVE-2024-53060: drm/amdgpu: prevent NULL pointer dereference if ATIF is not supported
      CVE-2024-53061: media: s5p-jpeg: prevent buffer overflows
      CVE-2024-53066: nfs: Fix KMSAN warning in decode_getfattr_attrs()

Best regards,
Ulrich Hecht

