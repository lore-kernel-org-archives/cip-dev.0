Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BEBC4345F
	for <webhook@archiver.kernel.org>; Sun,  5 May 2024 18:21:49 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.21])
 by mx.groups.io with SMTP id smtpd.web11.3554.1714933296668006910
 for <cip-dev@lists.cip-project.org>;
 Sun, 05 May 2024 11:21:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=QMkFcRfS;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=cK2WTgV2;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.21, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1714933280; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=CobEG8jDjtmH1IdxzVio6uwaaovjpkWFdo/YzxJzAs52IVdRSspXDaoFGBBV93MecK
    BqJv8tCjTaK92UOkW9etaUkJa6AU8qrpH32Z+Xb7TOzTCaj1nm826hoLeMyU989K7lVq
    BTR+Na2zLHOtm6f2mn52D1eEBZd/57bd0sdefNTUcLCoCk9+pFpo4rOMw3dN0EeCdtgx
    fdWk3zF/Kzn5ijphSEIL023AXT+qZQv98Y3N0nSUCTsDqiNpsAm9r2On2Vu6vRkmTRfY
    Oqu2lU+U0WauNk9dcHQO6/DPn/W7jAH+Yy9Lh8xHGvltoOUMJGpYQwIfq3a7++GNqrvr
    tm+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1714933280;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=pXBEcQbctvSTJOENiTwQ52towtBJDRLTTF1nS9qKEuU=;
    b=XCPwAdo8V8MbTZDcnL4YSIx2I/j/nfj5ZBXMh4811RSK48zKYfwf+tf1e0sfxCIzIv
    4oU+TYeTlrFSvBeGfC9GzFvxfJhQqTNaTNtEZWsbkpz9431AYHb7n9gGLKRbZyetkrlk
    Rr9Ls2iC3SU1Mzlgw5Ehi7cAGEzo2mcoVlTIR87j0uO1Ny4lCq7gBoex6l0Lc9t6kuTg
    Q4XKcDRxi5p8kWjfegoX9KeyRGubbIhL7Abve3EUUuYwEveIMxAwQsF5ojKtTaA0M9W4
    MRxdH8w9qQYR03AQYUWYBQA7kOVmFeabdgLTzWHmWUk/F19z9eL4Do4lrHxnhze1zAV7
    lYZg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1714933280;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=pXBEcQbctvSTJOENiTwQ52towtBJDRLTTF1nS9qKEuU=;
    b=QMkFcRfScz0Ts5j9WdKmZH1o0tZ7uwdhvcmi5NEdArNrWAWgfSIYtsIocyL1y33GJh
    UAh/Dft6qPZjsilwFRKzxndCNJxH/R7OBPs68C9gLpdLCWGQwKCKBTqkLJNehwMiPWzg
    7vCttsCaOrMXQYf7SznShzRz+AES+1oGpApAySg/g4K+7S6jW78MXGSecig3dCnCF7OJ
    ygaiAc1odHdlr3FusNQHfq3g23FSHTPU1d1L76el4NYllLMcwqsC1+VP8IF0kgMaqjuK
    UzlXUEekwWvMaP7l9eJqMEVZe37c4OZ8JzEv9//OgfWlcMeTjXFf5Rhef3rPCjD4ePVt
    5JMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1714933280;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=pXBEcQbctvSTJOENiTwQ52towtBJDRLTTF1nS9qKEuU=;
    b=cK2WTgV2ya0zNVXhcADETPhVwXvFtcc2xRN5aTK7UuoLHwmk9vXnhF2ISdGz99j3ID
    qIn0PXMuWMoC38S6qNAw==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzstnjV5GU9c7oKNYMuRvGHqNa13GvhtWeC6CRd93ajscjvWFwDo3mP"
Received: from ox-live-app204.back.ox.d0m.de
    by smtp-ox.front (RZmta 50.5.0 AUTH)
    with ESMTPSA id z08c3e045ILJh1X
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Sun, 5 May 2024 20:21:19 +0200 (CEST)
Date: Sun, 5 May 2024 20:21:19 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "pavel@denx.de" <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <1349258714.2876496.1714933279789@webmail.strato.com>
Subject: Request for reviews for 4.4-st52, 4.4-cip87
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev61
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 05 May 2024 18:21:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15825

Hi!

Here's the manual backports to review for the next 4.4 release which, as always, can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.4.y-st-rc

** m | c8686c014 39cdb6 o+ | vt: fix memory overlapping when deleting chars in the buffer
** m | 590441121 339f83 o+ | usb: cdc-wdm: close race between read and workqueue
** m | 116b0e8e4 e26d30 o  | netfilter: nf_tables: disallow timeout for anonymous sets
** m | b8f1a89a2 7633c4 o+ | ipv6: fix race condition between ipv6_get_ifaddr and ipv6_del_addr
** m | 88b00d18a 0958b3 o  | Revert "tracing/trigger: Fix to return error if failed to alloc snapshot"
** m | a9a5d0706 f8bbc0 o+ | tun: limit printing rate when illegal packet received by tun dev
** m | 894d5fe38 cf92bb o+ | drm: nv04: Fix out of bounds access
** m | 4908a696d c8d2f3  + | speakup: Avoid crash on very long word
** m | 5b56e2b0f f58f45 o+ | vxlan: drop packets from invalid src-address
** m | ff7599067 54c4ec .+ | serial: mxs-auart: add spinlock around changing cts state
** m | 068e635e2 2f7ef5 o  | btrfs: fix information leak in btrfs_ioctl_logical_to_ino()

Thanks for having a look!

CU
Uli

