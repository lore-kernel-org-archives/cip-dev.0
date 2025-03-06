Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3DAC282EC
	for <webhook@archiver.kernel.org>; Thu,  6 Mar 2025 12:43:22 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.21])
 by mx.groups.io with SMTP id smtpd.web10.12213.1741264992067608418
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Mar 2025 04:43:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=qqT89Etm;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=MFyyCagg;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.21, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1741264980; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=nSw0V96EqjTXipU6d48gIDlB0bwm8UE37mSBLWd4F7YSLX47N7z+KGNNdaMhcSu0ZQ
    TfS5mhU6GuSSXTHwb70AF1ZXi9J7Xn8XxPWbuf6LpHLP2QYPBFhgwNR7PD/WzmSfommL
    kCXyhP2p1kpbGRPUMLtFWSEIApuuOi8arbucbOI3eYZCxtE597UzczOhFYThOaO9xXRv
    BrZN3UpUceFUdqQt7B86BRv5ZjvDIBmzom7KiG+zN2UP1mxebpEClvUbzFO618Hceypl
    qi6Cn6A2kCMYx7m3i2cUM1Fkg7OxB8vQBgTdlg8BtLwpH/FD/fYoDLGMxnCRHEo3ILvI
    rgRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1741264980;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=QMnI3eCuz4mBdjmZJAguAONG3jwiCS86lA/2Uikrcg4=;
    b=D6Adha6Mt1H840eK6bk9hzV4sYujeSh57Htj+bWy4LjhTJxvKevixGP+Rf7CAGL1RF
    lDzdXZh/iUzbZL5CpGvi6t5cASMYVAJNLVKg1+IHrG9lPLuw02T4kfbUht6jIyY3HXpB
    LQsOsLXaHyL1RZlWVgGgBfcO9T+vYWwaxa/UBC6Qy4/GZRvUXr2ToPgSWgVWaXHfwspi
    4U0r7n52VQsbEoUFGMyG2alRm7PzZwyjjsxZk2/pTv9NtqWOpQP+22UZx9Ts5+brRQxZ
    R6YuL5mrfxigv9jEcKrp2mnxmjlXVtw6ws7ysXsz3UT9YTgSL5ktE731JDB1q0Vai+/w
    wFIg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1741264980;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=QMnI3eCuz4mBdjmZJAguAONG3jwiCS86lA/2Uikrcg4=;
    b=qqT89EtmCS9cMbBHl2RbzwsBuECrzNeUcp0x2CCeNqUGszpA6i2rqilOJn7Gw7JEKU
    +9ddacf2FQz6oq9Kd3hZwb7rGGoMbGAu166bnKaEE8j33omd/fWMSS+ECN2wWY5jOf0r
    nj6+d4DRCh4Mh/ov0Y6xSoXxbGGnah6vI8opV5mpL3xrrqGU0+NX8sjkCFfM8uIg+ym2
    U6HuwHMd7l3QkgLqOAxUouW0Xq3SXaghjNYi3TQlx3MniekLfqbDF74ouHubH4f2elGj
    XQPIHQTwG5lpshMO4WXO+5oHY7mArFa6EC7cOXdT+RdtO4WxOqf1SC0IIXELN4MnAFDl
    9Zzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1741264980;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=QMnI3eCuz4mBdjmZJAguAONG3jwiCS86lA/2Uikrcg4=;
    b=MFyyCagg2YoWV+tJEOhejUEgWyLK8sntdgvZdKErPbsgVDgLfABDkNJtPuASeHmFmj
    qnEO4wfVrx8FCuYgeDBQ==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvtHhj3fsqaR1GvSyJdw=="
Received: from ox-live-app402.back.ox.d0m.de
    by smtp-ox.front (RZmta 51.3.0 AUTH)
    with ESMTPSA id z2a340126Ch08zU
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Thu, 6 Mar 2025 13:43:00 +0100 (CET)
Date: Thu, 6 Mar 2025 13:43:00 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <1366376729.1771286.1741264980091@webmail.strato.de>
Subject: Request for reviews for 4.19-st2, 4.19-cip118
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
 <cip-dev@lists.cip-project.org>; Thu, 06 Mar 2025 12:43:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18059

Hi!

Here's the manual backports for the upcoming 4.19 kernel release. They can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.19.y-st-rc

These are from 5.4.290:

44f5f1d143972 net/xen-netback: prevent UAF in xenvif_flush_hash()
798365a11b40a arm64: dts: rockchip: add hevc power domain clock to rk3328
52b217274553c gtp: Use for_each_netdev_rcu() in gtp_genl_dump_pdp().

These are from 5.4.291-rc1; depending on whether that will be finalized in time for the CIP release, they may have to be pushed back to the next release.

2c7f55d97431c wifi: rtlwifi: rtl8192se: rise completion of firmware loading as last step
8e164688c2460 wifi: rtlwifi: remove unused check_buddy_priv
126ed64fa9b96 media: lmedm04: Handle errors for lme2510_int_read
c2f27f9cf7fac btrfs: fix use-after-free when attempting to join an aborted transaction
2327a1af58c0a net: rose: lock the socket in rose_bind()
6c4f057e9bf43 pps: Fix a use-after-free
95ead2805e80a tee: optee: Fix supplicant wait loop
3e7ba25c28a63 batman-adv: Drop unmanaged ELP metric worker

There is also a fixup for a mistake I introduced in one of the backports in the previous release:

d25f30bb83927 net/sched: netem: fix backport of "account for backlog updates from child qdisc"

Thanks for having a look!

CU
Uli

