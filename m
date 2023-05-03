Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51ADCC77B75
	for <webhook@archiver.kernel.org>; Wed,  3 May 2023 13:53:40 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.162])
 by mx.groups.io with SMTP id smtpd.web11.19885.1683122015683863480
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 May 2023 06:53:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=S8eNPwy8;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.162, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1683121996; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=M+SqaFWmLjFq26yZ4p8i/ZIzplulweJUXG8lG1Tvtp3zifC2nypnwzg5q1C1J5TeHA
    DBRUyXD/oV5WDJzHTp98N60QcG+L8e4aQU4fcYJCvNvpe4mZY678RuD9RtfgMuFOmhZ2
    Yu9Y/gLvZLZKPz5Fm+Qz7ThHioSW1maIn9cW7oxbI1kNGuVVk3A6Gk1Ql837WgZrSDv4
    lTZ6TNAEBd2x9TTwUDk+10QjkjjD5DElWBr6LaG6vM8tgVH7eiRAGYj3cjHalPVqXSOQ
    KkE0XdIMP60fAuzb5+1wsZXJFnRUY7xPVAYL9U9gHFweN9DVyEDIF90tQWtFBi6ZI4Ra
    eykg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1683121996;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:Cc:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=wIwlafPuhuvazXRvkjr9EGlj+MDl4BIpoM+CV8+QPg0=;
    b=jiKCQi7T7u3BWhMzCzm2nm4NQ6vS1sU+U11YoMzr0VbfixyZQT7iuxTzX8eMTX8whV
    Zhbxj3nXtoPJvD68AcHsI2dWbxEBbl6w1S/5qsCQ6mq98MZJvLbn+/cEsx5SPEmFb8bR
    BcXZsIFZ1czelGfRGjRia/jj7DAKiU0/8XaPOBZhjmaqOC0CJs1GZ2cNswj6tl4l0jlo
    swG2RSjA14jwRZ58XOVTJOGgQ1BB8mvE1T8J6YXZWyQEHlpBoWF447OQwsHftfeqJ9Kn
    ObuW2jo74F/rIdgqR0y9mdTPBcolKwc30BtYCE9aT/+ExZk+ihLhob6lepPCys7wVhaU
    vD4g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1683121996;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:Cc:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=wIwlafPuhuvazXRvkjr9EGlj+MDl4BIpoM+CV8+QPg0=;
    b=S8eNPwy8E+As4BfCMGCB69HIg5ODsX663vTgHoiSUPvebawOisj7SBZQj7TJQLYxvH
    LgS7NPfqzzmRzl3CEZvs67D5ulbgql57hRq546we9AJiJ3KIduJimtKoAwvNzJpHnrkm
    bgIO7vMheMrzY9Jq3vYRcSLb40TtNg7f7ve1fOw2aBHYw0RPLNfFzDsTJEZm8yoCrMGs
    dkpoMsQFi47gRyqHPYlOrrV54IDcIhPKcv7zoo3VHY+HC6kL76kvwDkbVr2KDQERq8it
    O85jgYzpFeVM4vQNOoeNLIfkL+LsN1J3RU4TWUpio4KLbdb8FWnwKU32gC07+ZO8N2Cf
    Pnfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1683121996;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:Cc:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=wIwlafPuhuvazXRvkjr9EGlj+MDl4BIpoM+CV8+QPg0=;
    b=1glQpUtOxDR6QjFTZC7/jh+vFYd1BcaL8+SaXCwQu6FjzkW1csEPhcqYhKNAJJ7xOQ
    b8zo7CmYJ7V9vgq6+CDg==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv3qxio1R8fGk/2mpg+g="
Received: from ox-live-app202.back.ox.d0m.de
    by smtp-ox.front (RZmta 49.4.0 AUTH)
    with ESMTPSA id N2af97z43DrETob
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Wed, 3 May 2023 15:53:14 +0200 (CEST)
Date: Wed, 3 May 2023 15:53:14 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Cc: "pavel@denx.de" <pavel@denx.de>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <454207083.1590436.1683121994845@webmail.strato.com>
Subject: [ANNOUNCE] Release v4.4.302-cip75
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev41
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 May 2023 13:53:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11397

[ANNOUNCE] Release v4.4.302-cip75

Hi,

the CIP kernel team has released Linux kernel v4.4.302-cip75. The linux-4.4.y-cip tree's base version has been updated to v4.4-st40.

You can get this release via the git tree at:

  v4.4.302-cip75:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.4.y-cip
    commit hash:
      a3bc58e64f55aa72a4c70a5e27ee369c025756dd
    Fixed CVEs:
      CVE-2023-1670: xirc2ps_cs: Fix use after free bug in xirc2ps_detach
      CVE-2023-1989: Bluetooth: btsdio: fix use after free bug in btsdio_remove due to unfinished work
      CVE-2023-2194: write in xgene_slimpro_i2c_xfer()
      CVE-2023-2248: net: sched: sch_qfq: prevent slab-out-of-bounds in qfq_activate_agg
      CVE-2023-23454: net: sched: cbq: dont intepret cls results when asked to drop
      CVE-2023-30772: power: supply: da9150: Fix use after free bug in da9150_charger_remove due to race condition
      CVE-2023-31436: net: sched: sch_qfq: prevent slab-out-of-bounds in qfq_activate_agg

Best regards,
Ulrich Hecht

