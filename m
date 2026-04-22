Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C114F9B5F7
	for <webhook@archiver.kernel.org>; Wed, 22 Apr 2026 09:34:14 +0000 (UTC)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.76996.1776850452354324307
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Apr 2026 02:34:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=E9qvxIf4;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=BqWJM3o3;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.52, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1776850440; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=IqKDAhdeG0oKl7/pg0SGg5AtsOQI7veMPwawN/RKmaZxZLjJkQB8z/v7jJ9WG0grjQ
    nNy5OOE+DZO7HbXMrTRhpPRKwzjKGP+8srK7epA3le7PGP1FEubDhflGoNIMZtc1MzXZ
    am3agsiHY1riqkXS3GOKVfuV0bav+Alt3Q4rsB/Vc82QArD3Vd4Fadsu2y0snDnayXwc
    WGR/WgrFu5Z0jqyiZ4o2HxIHZBEMZRi0w/L4xEv42K2rj6Wl3NubkcZ9cz5HJQbKEoj8
    w4yThmBLHDfofk2N4hENi6bj+ujysoiNRIj+JrHIPra5U0XZmQcRO54KPDhxOtB+3KUF
    YAYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1776850440;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=Mt4NDki7xWN/jbDLt/bsnm1Q8czdoQMVYJRdynPe9yA=;
    b=MFgQPgFT8hw6rWIMAHIpw4dtKmGJJPWtkHio2KkFpIOoQg8x8+YIyH6UCW38ov/wB9
    KJOtzNsklXluM83tRJc55h6xjq7kkRaWSPlIdjIKOYTJ4EwDC2Zc1CzngRLarHjkL2d4
    bew44g634ly42k9ofk9qW4t8V0oX0Q8rUZsJGQoWs1Qu9ZQlh7iyzOACQ5JNlWQvmpsU
    k/rIMyHE2zBcESL/T9AyWfutpUs4Qum1TNbPSgtTUkzUApYLYwl+vaRyMM1qvxe10+yL
    K+7PW4sb6RZT6b7Hi3n4EgWZei7v2X3r2eAXQ4wwWdAf3lXF9Ohn+lgACr/EwqvTskxk
    iEjg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1776850440;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=Mt4NDki7xWN/jbDLt/bsnm1Q8czdoQMVYJRdynPe9yA=;
    b=E9qvxIf4TMfboV+EcIWG5DCopHaYnLeK93oqkZvKjRHazY+NzYsnM5pg28FnCKwxAM
    BC7mjWRcsuLKkpxZMCGHun7Rxpx9HZDJhb0u4NJQttjmP37Ujg3yqpaLj0sXtztYGGEJ
    Ic+aVJd+ItiEbEoLmcqtTfEPBQgrmpT/oYOCNRhknhKvkew8gOGxvx+Kqhu+PIPW9TMK
    j5w3+TPBei/sP/XGNykfDNjYh6inGHTF8FB6sozEC/gwDOJfgpMJdENCKP+KzV3V3CFr
    i/H+7MZaVLXrfw+nE2pNq9ISGKtnkSLo3cmHDcG4WBAAxcndUAfaW5NyVreoMbwwjp6p
    b3wg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1776850440;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=Mt4NDki7xWN/jbDLt/bsnm1Q8czdoQMVYJRdynPe9yA=;
    b=BqWJM3o3nu+ckjfvkaYRU1jmYdB3lCUMyr8cWP4BdI1w1ghL/r+qHkiA781o+RvCtb
    8cY7nwK3oGEvaKt9qJCQ==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hexKDG+LdTmA=="
Received: from open-xchange-core-mw-gw-10.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 55.0.1 AUTH)
    with ESMTPSA id z7806e23M9XxAmK
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 22 Apr 2026 11:33:59 +0200 (CEST)
Date: Wed, 22 Apr 2026 11:33:59 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Message-ID: <310741778.1030622.1776850439887@webmail.strato.de>
Subject: Request for review for 4.4-st75, 4.4-cip110
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.42.88
X-Originating-Port: 46874
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Apr 2026 09:34:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22784

Hi!

Here are the manual backports for the upcoming 4.4 kernel release. As always they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.4.y-st-rc

7c091280e3bb2 net: usb: pegasus: enable basic endpoint checking
e2727eb73284b ceph: supply snapshot context in ceph_zero_partial_object()
2574b34a8eb2d xen-netback: reject zero-queue configuration from guest
14894a8decc71 net: atm: fix crash due to unvalidated vcc pointer in sigd_send()
de412dd7471d2 PCI/portdrv: Fix potential resource leak
1837000f16f5e hrtimer: Fix trace oddity
5525cf4093568 md/raid10: fix any_working flag handling in raid10_sync_request
554c2968593e9 net: usb: catc: enable basic endpoint checking

Thanks for having a look!

CU
Uli

