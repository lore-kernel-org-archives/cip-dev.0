Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A66DC02198
	for <webhook@archiver.kernel.org>; Tue, 11 Feb 2025 02:14:36 +0000 (UTC)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
 by mx.groups.io with SMTP id smtpd.web11.2555.1739240074503128686
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Feb 2025 18:14:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=hZxLcESg;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=jl+h7sS7;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.54, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1739240064; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=g5FSxG3AdRsNmbFEEMmeT5cZ92ERu2WPBN+o1Y6T/yJ/N74cnjrQ1YdJwe9vsWS1T5
    U9u+ngB97K0bamAy/a4HhczEFKup6vNnoUuZaHDvvV9jrDWhDyjpfmwNIIblkTFciYjP
    4NdMFTI/o9on0xDBwHVqV2lEqlAnHkSp8W7py87ZGYhrWoH7U5uUlmKtiXX1IuxtNYGE
    HGG0yb4W5nKMhqnK4a3+gRE3PpPzWcqRWvkV0v9usYBC5UnEwufokiw7HqqdVjoz/Q2Q
    HPbEbxmWDeNxZprLVIWbqw6IUUd8t6ylcN3pMSeQqtVLm6LmwMr7PQ23LzgupqLa+nIz
    Igow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1739240064;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=AN6+QWY8DR3xfKgBCR8ONFLel4q/OvVLd3lUbJNhN/4=;
    b=oyQrGfZZ50Us/4eEBMNi79Tm9mtB1i0k74Kvkx1jfdqNGjG+KPECQ0njk01/vU3Mph
    7B5OOIFUx725eYI7vSwiZ79QX2Sg9+oy8lkIsxgo5vgSumZIF71pyq31T4FOX6JOfIra
    3TsNzhtgEZUPi7Md/7ef/l5L6HnZDqHyYwpwcBE2z4xAC7CF+QP1EORyNjC1SpSlmScr
    ecvY/Fhsz8QChhgN54uI73phLzWPsr0yj7kAwJmjJSCZbO30VeNKKn11A8iZfVgOgmTq
    vUnzoJp6fH3SQF2o6687NchD4D4M3H4WglZHRM+xrjRCbHb11KxdyHvqR5nZwA7Ty9d1
    jW5A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1739240064;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=AN6+QWY8DR3xfKgBCR8ONFLel4q/OvVLd3lUbJNhN/4=;
    b=hZxLcESg5Zttl7TFIJUSuJlGiVBsriW5GjkvjXKrPnwAY+uVVpW79ix+w82MY7AcXp
    Q1/i+9Nb54ppzmw0ZvWIDUrC3T0VjL6Lb0L08P9hVeG4sCCLhpy9gEV8cAqGeWwGuyn5
    GvYX1iWeFpyf7yZX9gG/m/rgouBwxesbWIX2ffiaiqxu8FjlpQGhH/QtpjMMFhExCG4f
    Vrt+Ns96VqA4s5EnJLo9fRushx0pucAQ8W8B39hrhDeMxwJFGY0in1F+BKv1X18FVsEB
    Gg6BkAPrJus4wKmL1EE1B6i05hxsYn4qF6GmNwuwWEP8fellDWfI3hJ7lRH0IiC8nW0D
    +K3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1739240064;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=AN6+QWY8DR3xfKgBCR8ONFLel4q/OvVLd3lUbJNhN/4=;
    b=jl+h7sS70Jzb3/1qlhNQgaF0/9IZBqRXytruCJFquToiG5xNHlv7Voog6A+7czVex2
    6YTHquGdbBp13zaTwwCw==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvtHhj3fsqaR1GvSyJdw=="
Received: from ox-live-app205.back.ox.d0m.de
    by smtp-ox.front (RZmta 51.2.23 AUTH)
    with ESMTPSA id z0a38411B2EOEQK
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Tue, 11 Feb 2025 03:14:24 +0100 (CET)
Date: Tue, 11 Feb 2025 03:14:24 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <707882010.596091.1739240064075@webmail.strato.de>
Subject: Request for reviews for 4.4-st61, 4.4-cip96
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev73
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Feb 2025 02:14:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17801

Hi!

Here's the manual backports for the next 4.4 kernel release. They can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.4.y-st-rc

Seems like all manual backports to 4.19 applied cleanly, so there is nothing to re-review.

65a3da457f648 phy: core: Fix an OF node refcount leakage in of_phy_provider_lookup()
fbb00ee18cfb9 batman-adv: Remove uninitialized data in full table TT response
b317a37e42dbc leds: class: Protect brightness_show() with led_cdev->led_access mutex
20e3dfc5e6312 net: inet: do not leave a dangling sk pointer in inet_create()
9f3769378767d af_packet: avoid erroring out after sock_init_data() in packet_create()
dc4d74d36b1bc nilfs2: fix potential out-of-bounds memory access in nilfs_find_entry()
e2f28a0cb0a81 netfilter: x_tables: fix LED ID check in led_tg_check()

Thanks for having a look.

CU
Uli

