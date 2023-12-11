Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68226C4167B
	for <webhook@archiver.kernel.org>; Mon, 11 Dec 2023 07:15:11 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.216])
 by mx.groups.io with SMTP id smtpd.web10.3206.1702278903640564481
 for <cip-dev@lists.cip-project.org>;
 Sun, 10 Dec 2023 23:15:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=O8E/gYL+;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=r/c5ouE1;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.216, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1702278883; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=APsLsSZgt6pZdewEYqPMyW+1apNFm97ffzkQhxLg9MsoZxYRKQZS+LJ2yRs/YyziNl
    09MPyfUkqP22GXdEM2aXl8wH42DuKZtraDSbgMpzXgdH9mF1wnemXuUEn2mgCCRM4NVx
    oaBMKtj4sudlF4cD4cVVaQqDT0dcKeirDdjuy/wKeHtEQSP6mIprHIGuzMadFNFBsWsF
    tVn3h7rR1ZNHnFHtYfzEoYg5NZIkcQC1EyFcsftkiDsNFPM0emmX+qocg0XQxiF6DiCE
    vkIldXLLjkDK0ue4VICy8O+r1miRhMvrboX6gfHePw3grc3+FM+bnDGbdIGGYW8fn/fc
    8B6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1702278883;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:Cc:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=odwJ1ES+C6d+prC2slThfDtmgKbye4kEW8MHcdN/7L0=;
    b=af3ssP934FRSgsg7YYIKRiH5rr/eZ+KqA/jKK4xDYlOGj+W8O3ZVsQRKYMdyYBJKEz
    x0zxd19ngls5CRkRlYoMB4VzRXxRmmUnPj0P6w9mO8WmTX8F8tTXBKt/zDrgaCqXz32+
    M/uVK9ZA5b9JqtFlDCGutfLCX6gLtcizpXt1xTmJUf0mT25P6G9ll2lzPOj7WDIl98Pb
    aMTKDQqpdOuO0LWsT+6XwLa6MDjV3fmLMnSObM+8D5OnY4Cr6JCRi9kP3WrFemxIYa7q
    qEuTA0Oocl78i4hLAduh3moeUnR+6Z1fXK77CsO2PeWKS134PB6a7oyIwE6je53wUa4U
    8wEA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1702278883;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:Cc:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=odwJ1ES+C6d+prC2slThfDtmgKbye4kEW8MHcdN/7L0=;
    b=O8E/gYL+GyNlJnn10zWZ9u8sdKwKRemKOCH7pRCqb+9NYlDZtQZSTSHcBekmOD0El5
    K/kGwEQgNme7liwg55x51glwgWRJnOE0b98S9+SWXl0ENUth8EfpIrGZJQTskX5sOOzE
    T//2fO7V4EJLRRFSjVoPInS/NfDGotEXPZMa9aX9LaJpQEFNIrMbXS0qgqub9ZXTjLdX
    YDcL3LA9bUb4eQDxdwORZdu7O9QJopTzHmvnKdYDG0+gj4Nfjflg3MZ+XeA8Wl4dbH5w
    1JRZvpQVep/Sq5DgX63Cx1JP+6pzPUQVzXJ1tEYLxPZrXLlhVA736GdDB422UU4y7Jpd
    fbkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1702278883;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:Cc:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=odwJ1ES+C6d+prC2slThfDtmgKbye4kEW8MHcdN/7L0=;
    b=r/c5ouE1ykavp7FWJu667mW9wlZ7DBi9njuviycKrz8ef6hE9ochUPXP0K5dznn+vL
    3vO0r+7KH5vz+v67+6Aw==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv3qxio1R8fGk/2mpg+g="
Received: from ox-live-app202.back.ox.d0m.de
    by smtp-ox.front (RZmta 49.10.0 AUTH)
    with ESMTPSA id d26e78zBB7EhLDO
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Mon, 11 Dec 2023 08:14:43 +0100 (CET)
Date: Mon, 11 Dec 2023 08:14:43 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Cc: "pavel@denx.de" <pavel@denx.de>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <2013592975.706537.1702278883600@webmail.strato.com>
Subject: [ANNOUNCE] Release v4.4.302-cip82
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev55
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Dec 2023 07:15:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13995

Hi,

the CIP kernel team has released Linux kernel v4.4.302-cip82. The linux-4.4.y-cip tree's base version has been updated to v4.4-st47.

You can get this release via the git tree or as a tarball from https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/4.4/

  v4.4.302-cip82:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.4.y-cip
    commit hash:
      657481329b53c9dc746b686cfa529666e967e8c8
    Fixed CVEs:
      CVE-2023-0590: net: sched: fix race condition in qdisc_graft()
      CVE-2023-3567: use-after-free in vcs_read in drivers/tty/vt/vc_screen.c
      CVE-2021-44879: f2fs: fix to do sanity check on inode type during garbage collection
      CVE-2023-45863: kobject: Fix slab-out-of-bounds in fill_kobj_path()

Best regards,
Ulrich Hecht

