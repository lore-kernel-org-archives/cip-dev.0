Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC1EC77B60
	for <webhook@archiver.kernel.org>; Mon,  3 Apr 2023 08:59:43 +0000 (UTC)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
 by mx.groups.io with SMTP id smtpd.web11.65476.1680512382355661500
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Apr 2023 01:59:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=VH5QeuYY;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.52, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1680512368; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=CgpND/XL5s0JjpCijqYVPzW5fkw4JKgov+m6rzG+T6uYR/zW9WbsqVgHnU7CghbmBc
    v5r1M9aBR9XtY21Q74FQCF5Dw3Q8rk8cOXWdXdWMVFizJrQnhxHMNUz7iWEsPEHI+at+
    xxo/Q0nUXndKj7M0FD4UEQr5bxqhhCWQXHdsbuOd41Ktdp0OUPtqO46NhQIww9infSbm
    NdyUcaLvXTyHDXm093DNTFKHLQsUPe9Uep2z5IfKRJCH4BBIqoNyY4r5euz82j+fA4K2
    h8pnTo5lr+C8rqFQXwfFtU6EyG1Lvgxj99mI78kw2v+A3mjrqH4MEEnPZaMsGyWB7XPp
    UBcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1680512368;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:Cc:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=AN7fG6wxG3ZhcvlgdQhZ5EYAOuU6zXPjTytG/4UvGFc=;
    b=V4L2BuW7W1bs1m0Ypfb9u9naD0QlGkpu1dOQUdCSDkfo07CfjO48Q+OcSBAt435pDA
    QEmtQ6nRUkTfUSZehBFQMM1Vb2CSmK/LFe0fLyCkOxQ/JilhzWst8K8EBA1n4tEDVMo0
    zZLnM2YKTIUvnBpWklyZbgjgbtIYEweuOHNr0GU3RhcLPiQKACrcpJvO5WTZwFD1uU5w
    JM1ViN4XbaZgVYTAWJL9okuJ+PXQ4CmQ4PSdUfeVMV2NLf0VUVm0xfxqgcI1X0Ls+4xB
    seXKNAjtIfLHdMJan5HsbypRrz+F1R9lJo8TO5mVgLWvp2Sw9RgGVtDfz/bAbeIDn7nb
    C+FA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1680512368;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:Cc:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=AN7fG6wxG3ZhcvlgdQhZ5EYAOuU6zXPjTytG/4UvGFc=;
    b=VH5QeuYYMazKvcaFvj1Ho8ViR6dCeP97LjO9OaLgmZTrKc6bll1aPf1GKnWeSgNbHD
    maQPRpkRZEE3Ra4vej29ebdDlrEYopunqtuPDLZZmBRZM8zBqKyADcuJlzQiT7AB3l7Q
    xE5qXQALoAeryaqxNHdc8DHHzBu2lZkgQuNpgQE9gJ4b/a6xdBOXxvUxnCaU1ROHbU2G
    lQ0gZGMpeqKKlsYNnp8tJX+/tlNSdWP5QHA6K6lYIGyfpOajUbEqL0hEt+GDfAacG0pS
    O8P7hHewn2uGWa1YX+bYWuCK3R0G5qU4wDvVl0lPx/1eYxc5kp+NMtAZ1rmY9oOslp8+
    eXoA==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv3qxio1R8fGk/2mpg+g="
Received: from ox-live-app202.back.ox.d0m.de
    by smtp-ox.front (RZmta 49.3.1 AUTH)
    with ESMTPSA id Uce81bz338xSvtM
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Mon, 3 Apr 2023 10:59:28 +0200 (CEST)
Date: Mon, 3 Apr 2023 10:59:28 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Cc: "pavel@denx.de" <pavel@denx.de>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <1264245209.1493726.1680512368021@webmail.strato.com>
Subject: [ANNOUNCE] Release v4.4.302-cip74
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev40
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Apr 2023 08:59:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11148

[ANNOUNCE] Release v4.4.302-cip74

Hi,

the CIP kernel team has released Linux kernel v4.4.302-cip74. The linux-4.4.y-cip tree's base version has been updated to v4.4-st39.

You can get this release via the git tree at:

  v4.4.302-cip74:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.4.y-cip
    commit hash:
      7958e4e7b503f647c4e7b345162db655e1c62e06
    Fixed CVEs:
      CVE-2023-1118: kernel: use-after-free in drivers/media/rc/ene_ir.c due to race condition

Best regards,
Ulrich Hecht

