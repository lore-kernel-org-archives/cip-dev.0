Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275D7C25B76
	for <webhook@archiver.kernel.org>; Mon,  3 Jun 2024 09:48:16 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.217])
 by mx.groups.io with SMTP id smtpd.web11.79418.1717408088088678291
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Jun 2024 02:48:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=F84i1Vyd;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=iX4GmWlS;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.217, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1717408079; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=JGvAt/ztul0d20gV30ALgDOGYKyDyQ+M+Z+l3CL0B4Vbx99PZFmy7tWp3fAFkok/Mc
    3lvzW8U4ydSTcvNGTCfXfmWMRFPrLR74fOrHLcelt4ekghI/yC1u6LvGIh03TEcR/y3T
    1kqu04Wb6TBTv3PTBLNgsfSvZkDTYw7kImOMDwPc57TrfWMKzaAoehrq9Qwxo3VucBdd
    f6cip3zdYApBvq+i8ZBzr5Y5C1NslmPXfS2aFZvGAowr+HxggqJ4f6Hgbek/fXzhUbYF
    2RNjw8eQ8Vz7w0ey1ZOUJbiQuhQ6jQN9XthcTgOn8EbG/DYVmjbbZ0/XKkGDQXOf9M6j
    wIvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1717408079;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=k0h1Tm5ueJdd2IrvVG8rZo8Oqp3HjCudMecUGYIFq14=;
    b=iyvbX9U9E9RU/gjRTp3GbtraoHkRSBVsfr2bqw4PBUrWJfGlJaXFVfH+Yytny0QZcG
    ixwdIdvRW7ErTK4wTOXGlNuKENafQ6R/FJCyeLBSw5+lDcFIbOHX377axl7YFsNlQkee
    g0GDEYFITkeShn/IcVF7azHkl6+VQ7DxusXn3cBSvF+wVQPV05hTLs9UuC6ObLANIjr+
    YIhcXb4hYycAcsq4ejlxR+BJEedZ5y3Xc69VdLm8iICs+rsXi0nfXMVtE5RyAKYtUH7a
    jQ8vXvCiXxWrncfvC0cgHxmo+m1uQ+/PyvtxJwu4sUWjECrkzz5Sp3MB8/I059QFcIJf
    XZmQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1717408079;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=k0h1Tm5ueJdd2IrvVG8rZo8Oqp3HjCudMecUGYIFq14=;
    b=F84i1VydXMjysgJLWY3auhF43FSOBtawg7a1Wv1s+9sMYpKx9I58q2qld98BMoXesI
    sjzSTKI43x+FJsR4j5eIHdijD8Oa93NBD4oh9CZLDXWzXijlCF/iRODn/gqRmBSyEWYm
    PiNhvoHps9NcX8MUoKUWDVG8ddixAO5kIgK8lwsSgc7OeXTTJGYM084IGKT79zN2SL8s
    x7+FA1QEfSTyivN9SNUQdZ6HNSITbR2aa9fRaBraY/f6JN+PQrA/LM8+zQ44nDnC0Cef
    3rVAaJyFFLUfV3lm5KEaVSf40dYRexHIBK0X6eo3a0v9wq9WNTr3epTMg3tpzW6Z/l7u
    mISg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1717408079;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=k0h1Tm5ueJdd2IrvVG8rZo8Oqp3HjCudMecUGYIFq14=;
    b=iX4GmWlSYJ0JO8YjkljHLT3l/rMp0JTBYnNfGn9h/McWvxqJSyZOnk3YzHNkJre52f
    E2ulsp2Y7XwEb2ExAaCw==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzstnjV5GU9c7sKNcZuec1/lEjXyi1DCFOscFCe8bGtzH2tsY51y9cL"
Received: from ox-live-app302.back.ox.d0m.de
    by smtp-ox.front (RZmta 50.5.0 AUTH)
    with ESMTPSA id z08c3e0539lxGLP
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Mon, 3 Jun 2024 11:47:59 +0200 (CEST)
Date: Mon, 3 Jun 2024 11:47:59 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "pavel@denx.de" <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <1638796688.696518.1717408079442@webmail.strato.com>
Subject: Request for reviews for 4.4-st53, 4.4-cip88
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev64
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Jun 2024 09:48:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16094

Hi!

Here's the manual backports to review for the next 4.4 release which, as always, can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.4.y-st-rc

** m | 4a5a57338 d10129 o+ | ipv6: fib6_rules: avoid possible NULL dereference in fib6_rule_action()
** m | 6ffbcb370 9af503 o+ | btrfs: add missing mutex_unlock in btrfs_relocate_sys_chunks()
** m | 1f959e564 008ab3  + | speakup: Fix sizeof() vs ARRAY_SIZE() bug
** m | 8a4d133b7 e57b7d o+ | wifi: ath10k: poll service ready message before failing
** m | 7c251ae91 d301a7 .+ | macintosh/via-macii: Fix "BUG: sleeping function called from invalid context"
** m | e3291754f 59162e f+ | x86/insn: Fix PUSH instruction in x86 instruction decoder opcode map

Thanks for having a look!

CU
Uli

