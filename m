Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06540C61DA4
	for <webhook@archiver.kernel.org>; Mon, 13 Mar 2023 16:05:26 +0000 (UTC)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
 by mx.groups.io with SMTP id smtpd.web10.23734.1678723519605508068
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Mar 2023 09:05:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=YgeVpdgS;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.167, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1678723494; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=fO/uaWtgHSNBQTzq67W+sJcRz7L4pUz4tHBP2fdwL2sYGSYpr1vFF1mGVUDa5F1RxS
    tD54HM+Y+PdB80zQzjqczdB7TqbO/EEAK0iK7fFzq3tz6NW0gyULvIs2QVy38IHS1Whd
    uotyiuiQCuA7jmnCso3uJN9qVAW4pSaME0OhnpPbQUA8ItWPd6kWv6Uw5P7sHxkIzK1S
    /Owwzj3/PFV4tbmrXgeBTlsuwImu18CmFsu0KZC97dDKdPS4w0X9A1UQ+sTXgGi7a+u0
    wBApP/GKBXBEc9d5D+0DflmRcs0182hzJ34VfAltu+dqjpGYP/gqhL/LvrORmdVwicK+
    UeCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1678723494;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:Cc:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=kFSUhNDFGZSlRqfzL7DvRuyS4hjyJE321n8yefUJF94=;
    b=sPCvEKArhU6yqveQlhR0QqNcRM1fabVPkc6ohIZIg7cHmbhfx9xVsz0fHMb2Naz/wJ
    FXaD26aWVrG5gsvSKHpLEzSyGVkYo5bgYHNgGoL8rfLF7A9sPnDFvXXDj46iqW+dmbjj
    hytzeiyc9XS3DdJ3XepSfGNCRtoMwMYqmbTX+dp9qXXTB+Iu8UQ9eeV/Jmf/9TFF/cZx
    rR8bRFlJDVhGu76LrxKCyPhWi7MkyNMCHFw5+icKTOfrFXtAz6FMyA9s3s6/99+kYkRc
    INs6XUtLJB/u5wdUWOCrii2faPQ/8sEevEE0rsz5Z20RJ8NBZdG1Q4Nr6m5vQFpmtYN5
    b9ug==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1678723494;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:Cc:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=kFSUhNDFGZSlRqfzL7DvRuyS4hjyJE321n8yefUJF94=;
    b=YgeVpdgSYrgd2mohtxoy5qxg+5NLtEgS4OF4POEFnJ1kPTHApEnQSJc5ogl+Dhu4JH
    mBxPGDfLB/hooydLRXvrV/IDKOzYxbhXP+UovH4Xuo0HC5FBN/Znz/ZCz0y8sQCyYFBY
    Zm+TmteD2JrIQ8lsJIb6nW25QXGwxhfnc7fOSposBWeaFyyv6pm0S7sGQhBsUfGb3E/t
    294r6x5t4+ocglZRUIffRfz+AcffgYa51VYdVIinkCUZsdFg1EIS4dXLHyQYuSsFnxZc
    eVn6tBJoXVTe6+dA7/yEcArqQBdhKJfmtPdOjgBAon1WKB8rn7EcbLocwySI/AqsvW3h
    PN0Q==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv3qxio1R8fGl/w2B+Io="
Received: from ox-live-app401.back.ox.d0m.de
    by smtp-ox.front (RZmta 49.3.0 AUTH)
    with ESMTPSA id 5ac80bz2DG4reCq
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Mon, 13 Mar 2023 17:04:53 +0100 (CET)
Date: Mon, 13 Mar 2023 17:04:53 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Cc: "pavel@denx.de" <pavel@denx.de>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <1401403437.1593044.1678723493760@webmail.strato.com>
Subject: [ANNOUNCE] Release v4.4.302-cip73
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev39
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Mar 2023 16:05:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11018

[ANNOUNCE] Release v4.4.302-cip73

Hi,

the CIP kernel team has released Linux kernel v4.4.302-cip73. The linux-4.4.y-cip tree's base version has been updated to v4.4-st38.

You can get this release via the git tree at:

  v4.4.302-cip73:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.4.y-cip
    commit hash:
      b58e18a67ac192c595acdaf67c2e666bf0433787
    Fixed CVEs:
      CVE-2022-47929: In the Linux kernel before 6.1.6, a NULL pointer dereference bug in the traffic control subsystem allows an unprivileged user to trigger a denial of service (system crash) via a crafted traffic control configuration that is set up with "tc qdisc" and "tc class" commands. This affects qdisc_graft in net/sched/sch_api.c.
      CVE-2023-0045: Bypassing Spectre-BTI User Space Mitigations
      CVE-2023-0394: ipv6: raw: Deduct extension header length in rawv6_push_pending_frames
      CVE-2023-1073: HID: check empty report_list in hid_validate_values()
      CVE-2023-1074: sctp: fail if no bound addresses can be used for a given scope
      CVE-2023-23455: net: sched: atm: dont intepret cls results when asked to drop
      CVE-2023-23559: rndis_wlan: Prevent buffer overflow in rndis_query_oid
      CVE-2023-26545: net: mpls: fix stale pointer if allocation fails during device rename

Best regards,
Ulrich Hecht

