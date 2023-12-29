Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65955C46CD4
	for <webhook@archiver.kernel.org>; Fri, 29 Dec 2023 06:20:44 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.219])
 by mx.groups.io with SMTP id smtpd.web10.140734.1703830843066248981
 for <cip-dev@lists.cip-project.org>;
 Thu, 28 Dec 2023 22:20:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=b9AK30xb;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=kZMGeXqz;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.219, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1703830832; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=gv4Sb39bFTI8XrHkd1MEmQIoI/EWgSYjnZ9G+C4RA71+AnTtHe6HBOQQQXIcrlgIZl
    mPAmIy0S9x9uqBqp2ba8cpqzFl+aaDqSMId03pDLdn7SxPpfGxEpaq3WT7S3G0lBoGJ3
    4T+8HHdDLcU+oBJ+PiCczXoH+Vgv2S/hEdkjrbEuTCm4985hpoA9kqyAnO/W9/Riqh4G
    CFlj+tVtQ+qZjgY48uVwzDfqYg6UhT7ChjNQ6WdC7RZurLdkIh/uz8XGWkaH6UOamesX
    WtCUo1ndFVngzGQRhvVETrWaMjMegpLlh1Lt4ED1Y8MkNgQKbRf1IsNyMabdCCVmVNq3
    8xJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1703830832;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=B81bqPGp+/8EOtmf8Xx/9MnqRawJjpZzNm5mNg3iE6E=;
    b=MBRwwQ9ls/hG9+fIiz8OBfvGKhKZjRX/i0AH5LtLWUHpxWSmuqI5pST6Mik2yfr2pW
    WweRZkP7myPn0927kou9Tkny61WSSG5Wbj4ImhwUWqyTpmb2m+8FZ7jO3iCNG2cXn2TR
    YKP1InCe6vHTvN6fjRY7hE2UZ+WeEtmJTHsKRhezgXMdvWOLnTQRShtkh4d6mffh7sPi
    U46ISDFvvhtEpS9Y3MDD2mWj20INhN3/gmW7d3A6h/TxizYiwMTJo0a7/oPriyZbiDn4
    7BMlktpPrW1AGkQZ3XizW6pHMj+AL77Rc6epGRUqwmIg5iqbHkwbTiEjdxWvVwT0zYX6
    mcLQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1703830832;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=B81bqPGp+/8EOtmf8Xx/9MnqRawJjpZzNm5mNg3iE6E=;
    b=b9AK30xbe21rMIoJidpqYi4VOXpEHnAuTzGybQJbRVsl6FvA8TFZurOmu2kVBtdCCc
    DyFx/NcAyCtxk2tIDV94gPUcnYjcjGASihhFd+bLhnA5pgahAp5fd64rI0frnLbaszID
    1irZVEoYiaTzGS7JhqNKNr+TdSV6nomuZDMK/1gRprYmVLD07ZDeAEyXmky1tFiPPNf4
    Pba1elxuny0zkDBr2tf2CzZFcIJCHtvLcjbLkjsfRul2WZm9lWCltgGLqjB1ja0fIYpn
    56X6uEBxcmvm8jnoGTKUXH2PrKu40jteuywVymq7c8p5/GLj7p7IOJAwkF1weIIyH0yl
    tmjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1703830832;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=B81bqPGp+/8EOtmf8Xx/9MnqRawJjpZzNm5mNg3iE6E=;
    b=kZMGeXqz/knHndLVvM86sDhDSgUUn7nO8L7T2jw5gh5akXcBN1Gt2W1cMJoCzKJaRy
    h7A5n5RVl5KVpyFYU+Ag==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv3qxio1R8fCv/x64iFM="
Received: from ox-live-app403.back.ox.d0m.de
    by smtp-ox.front (RZmta 49.10.0 AUTH)
    with ESMTPSA id d26e78zBT6KVTa3
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Fri, 29 Dec 2023 07:20:31 +0100 (CET)
Date: Fri, 29 Dec 2023 07:20:31 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: "pavel@denx.de" <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <2066622315.1550936.1703830831509@webmail.strato.com>
Subject: Request for reviews for 4.4-st48, 4.4-cip83
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev56
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 29 Dec 2023 06:20:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14215

Hi!

Here are two manual backports for the upcoming 4.4-st48 and 4.4-cip83 releases that should be reviewed and that can currently be found in
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.4.y-st-rc

** m+| eafbd69ab f4e606 .+ | qca_debug: Prevent crash on TX ring changes
** mo| 400b4a6fd 27b13e o  | blk-throttle: fix lockdep warning of "cgroup_mutex or RCU read lock required!"

There is also a revert that fixes a crash in a non-CIP configuration:

24e9edbce704e Revert "md: fix a crash in mempool_free"

Thanks for having a look.

CU
Uli

