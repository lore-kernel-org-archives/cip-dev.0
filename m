Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C473EB64DC
	for <webhook@archiver.kernel.org>; Tue, 11 Jul 2023 13:46:10 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.20])
 by mx.groups.io with SMTP id smtpd.web11.734.1689083165805398517
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Jul 2023 06:46:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=fXf3G8QJ;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.20, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1689083148; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Dh/TSqwFFfWE8Yj5rH39Z/qsmofMI1A4PtHucb7PnnFSsqAMVZC++RpP7Bt0GEfRpi
    sl4vkDJULfoESLqCRcg7E9myDGHJEBgpnHZmFhZpueFXvs7VkOVMp8NaG8Y0gxsEo1+D
    td0L/kI3agZ2SwL7tXYc/tm3fCBlKTp5+1akF7BaIOdXYlf+6ZWmheNJ9Au2BAhaxR1S
    GpWUfCDIVVUC6KIKALbiOvRh3y2OKnfKLxbQstMjS0r+mOWzpoWHflc8vKEK4adoqeii
    wjNDCW8PgQaiC1JAhgMTcO1r2KasaxvoKjy2wVc5lNruNwxW8/rdhQnEJRD6PzNRqg6H
    VPOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1689083148;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:Cc:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=CrU26XX07VCzGDFXE6NZJqPaMl6LRFCBKVKVLjiFRdw=;
    b=ma6cDHD0ptJjgjwUh8ehI18NmULRYn/w54qGYf1izps0u18EPjHynW7YfLboPESKCx
    cRo0bYA9HVdkbsfUDG0WhAu8ewc8l/kXrXQ9mIpFbnFfFdJH6Cfuu1T9GoWqAn8ER/nd
    +Befd977uResL29jk8szO1pHnS6eHkylKr00ypp2BjpZ+pDREH7VPCCjK4StRqcj+rfC
    RFlXB5W3wgevFwFG8rZ9kM5vGrqNMQmnTndrHukiW2+v//m1JBhSEuwrlz4vkwZH9hdO
    uE9vKxEDLcVH5IuPfUOm4P14Kr16Cm1bi2FNaGRz6IN+oNhNFTT09tSElpd0IdAR2eTI
    FlXQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1689083148;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:Cc:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=CrU26XX07VCzGDFXE6NZJqPaMl6LRFCBKVKVLjiFRdw=;
    b=fXf3G8QJOtrp3L6xVnYtGkMIM1T90bWj5OTATvVrpGdKUdv6JRQpgbtFGs8VHXs0Hb
    r7RV9XfiFlQNOk6KXhg08ba1fy0wqKgkoYDuU9+IM4vlNSDgWOI0nhLfs92ytcpwJI4k
    ubfO5eJiPlWwkUJwg1Bi4ewPN6dxe6z/k/UwPahPZY/jX2SXGxNC1L307eR9/jln2X5/
    2QpJUuyQxRXbdj84MKpQ3EBDeQDLkEmx31RvRwj4sxLL2dMJ4HYETg5efD8d89m/4OEu
    Ws0jSn+2LoWYFa9QXHod6tltAsae/NhX+92J+9zZWS5ETcmX3ul52hU60dOEa/cI+AQx
    4VZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1689083148;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:Cc:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=CrU26XX07VCzGDFXE6NZJqPaMl6LRFCBKVKVLjiFRdw=;
    b=IvxVWydJHuiql5xZ12z5HpwzTb0J8+qNcwnN5OlL44tnqzj/yrnkmNUIInAIkHCg3q
    TY6/u/36v8kHzB4KrLCw==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv3qxio1R8fCt/7N+P9k="
Received: from ox-live-app205.back.ox.d0m.de
    by smtp-ox.front (RZmta 49.6.0 AUTH)
    with ESMTPSA id K29863z6BDjlXri
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Tue, 11 Jul 2023 15:45:47 +0200 (CEST)
Date: Tue, 11 Jul 2023 15:45:47 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Cc: "pavel@denx.de" <pavel@denx.de>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <2051359736.2755351.1689083147890@webmail.strato.com>
Subject: [ANNOUNCE] Release v4.4.302-cip77
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev47
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Jul 2023 13:46:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12305

[ANNOUNCE] Release v4.4.302-cip77

Hi,

the CIP kernel team has released Linux kernel v4.4.302-cip77. The linux-4.4.y-cip tree's base version has been updated to v4.4-st42.

You can get this release via the git tree at:

  v4.4.302-cip77:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.4.y-cip
    commit hash:
      8dfbbc901d030767282dd3cef0254499fc5d108c
    Fixed CVEs:
      CVE-2022-2586: Linux kernel nf_tables cross-table reference UAF
      CVE-2023-31084: BUG: WARNING in dvb_frontend_get_event
      CVE-2023-3111: btrfs: unset reloc control if transaction commit fails in prepare_to_relocate()

Best regards,
Ulrich Hecht

