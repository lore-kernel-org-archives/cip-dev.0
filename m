Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4765C3064D
	for <webhook@archiver.kernel.org>; Tue,  2 Jul 2024 15:11:09 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.216])
 by mx.groups.io with SMTP id smtpd.web11.27319.1719933065371741639
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Jul 2024 08:11:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=X145siMx;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=3av4yCUK;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.216, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1719933056; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=b8OpFBR/TxDFiMgf/cWIWiAXN+1HQ21IrZm48glk/kAo4vrxK+pZnhL02UYbKfXGee
    +qV13ttIdov1V3Qa5TJC7fDdxk9rVS0ffITzE59o1F7aHiyKKnF8gDhIBFiHpCckFUxX
    ka+W/b9/r9Y7C0iUJL1ra5cQbPuaS9niTXrhN83Iz8xEAYBTcQKOGL7qyqeAj4pyQI01
    7DA0q7e3lHZOI+rTsv4fjvkxCDnumRos/rCpL5PswyE/uuhqfHP4mwoFBKByy2AUMkMo
    RAdtbz8KqOEUSSD0O9gojZPSGf2XupwxP8NxeyhaNMoCMiRTsGFGYJI3ny9mIZuI7DEx
    naVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1719933056;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=REyrrKtrtB1EkOaUuN/GbuvmruVIyGEAsDfny8fcDQ4=;
    b=BxUdwVvkjjZMQ3wm+V278oi4ubyfXaH4AvgxeREcSnmJttX/NdXhbagZZs7mtilcah
    E1y8f4/Zhof1fUT/u0ZDFf62dVoaIagO3xTfJUgY/3VEooVlomaGMFKIGmCDl8MYUcvB
    8bfVQYf1UoKCgGwX7hYMUo+PPdthKMy7LCcNUioqB9B6pmVj0nz3HSBY5dY9yTAoChzU
    ZrvcTOE7b300MW9PhKcVrZ6lsuyo0SHuMHuudN77koN3M9dHt58kC3qmVdsAlLhS77YB
    u02hmYYJXfoKio8mk9S/MN1p/H1p63KkK53AM30RZgxN8AlfdfXa82ZuaQ6UqYkVcSOJ
    Uong==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1719933056;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=REyrrKtrtB1EkOaUuN/GbuvmruVIyGEAsDfny8fcDQ4=;
    b=X145siMx5ItrUPiMbJtJQPR/go5XmkrZuu3GVdzgt7JuB5H0r/w+aUBMjXNGIgiPZV
    LMaDZMzMrojHhimaOEnDVyT0JYr9CNbMPLvglIm9Vkrvfr8qouo5gMNLmzZHd+BXFziT
    muvZADI1EI3rJeNIfvrra3MwgRGBdzqgGZSkU2EWRKmh5MvuNAg/IT4nbpbigrUMJztt
    GUhsH1vkcIfixy6mFdZUFyLoLYFVP7aemSliwq66p15OqqvRYlu6WujbXY9TVB/1+wWk
    iZpjl0XV74TxCz3AsC+nCCYZP4npcVBJwufViG9/zC0aYvq2AdlNFBangixV6ETAQD7Z
    NklA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1719933056;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=REyrrKtrtB1EkOaUuN/GbuvmruVIyGEAsDfny8fcDQ4=;
    b=3av4yCUKPNf4X1U9Yvt0e0g8X96OVn9/XjKB9zdj8Cb09EyOofuCloYaRyTL+DAAcz
    RRpK7eeU1icg6EnZeXCA==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzstnjV5GU9c7oKNYMuRfGHqtq89k3mYUlHMXIUnKaGpnZCxmxho2QT"
Received: from ox-live-app104.back.ox.d0m.de
    by smtp-ox.front (RZmta 50.5.0 AUTH)
    with ESMTPSA id z07fa7062FAuYX5
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Tue, 2 Jul 2024 17:10:56 +0200 (CEST)
Date: Tue, 2 Jul 2024 17:10:56 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <729272238.766733.1719933056170@webmail.strato.com>
Subject: Request for reviews for 4.4-st54, 4.4-cip89
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev66
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Jul 2024 15:11:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16361

Hi!

Here's the manual backports to review for the next 4.4 release which, as always, can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.4.y-st-rc

** m | 459de98d7 2a14c9 o  | params: lift param_set_uint_minmax to common code
** m | 62a95de44 30a92c o+ | openvswitch: Set the skbuff pkt_type for proper pmtud support.
** m | 85b6bcf9d 52a2f0 o+ | net: usb: smsc95xx: fix changing LED_SEL bit value updated from EEPROM
** m | 0049a623d b3dc6e o+ | ipvlan: Dont Use skb->sk in ipvlan_process_v{4,6}_outbound
** m | 822ae5a8e f5d4e0 o+ | nilfs2: fix use-after-free of timer for log writer thread
** m | f6141cbc2 1cd4bc o+ | vxlan: Fix regression when dropping packets due to invalid src addresses
** m | 1ea3de272 1ed447 o  | media: v4l2-core: hold videodev_lock until dev reg, finishes
** m | 3c9ee8294 dfe6d1 o+ | KVM: arm64: Allow AArch32 PSTATE.M to be restored as System mode
** m | 72c5d8e41 25460d o+ | net/9p: fix uninit-value in p9_client_rpc()

Thanks for having a look!

CU
Uli

