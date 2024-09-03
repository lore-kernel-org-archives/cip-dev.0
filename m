Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214EDCD37AA
	for <webhook@archiver.kernel.org>; Tue,  3 Sep 2024 17:39:12 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.163])
 by mx.groups.io with SMTP id smtpd.web11.29696.1725385142278107532
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Sep 2024 10:39:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=aCoLggTJ;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=e6gXvSZz;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.163, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1725385132; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=e8FrDYVT0AiGN1ujHwgIPMJlvjLU0LIzIb7LvlRnFGwEzBeYWgNspymdxpaPVmsIMj
    kA3h+VzJyXeIAAHiLeH486SuRb8JmktKsrRnP9UpTcLdcQlHFQXnwTRuhFam8l9eeVF5
    Y/sc5eSrKhw362+wPChvrraGOQEmuwfBGk1s3zp00mET2wfWWpCBSevOcd5dr8UQXRKI
    jh+72NymfCWXpY7d5Gwpx+y/aRAl4QYKkaOUWpDGTbX46UaGQR3SPp69NzsxZ8A9Ufvy
    CY3zwVCrOf1uL1w8kkjrQwovXiZBBJntxNdNYGFjmcrhq6Ah7BzqibWuSoEI7kAWuPFi
    3FuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1725385132;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=B9sb/jLkjTZC/aBQNv6z46jzN2OL/QWrCaEzGjd4Hvs=;
    b=oOrG4UO6vPKefeLEUlxoLlyxfcEV98UkhifiUaVENcQSY+LfnJhGf2OBL7JES1W1di
    HtblVYFn0ybJ8UygW+y5onRSk+ajLMcDQ7fZsLRZItMdIdCs8XTUWunp5bIglOMQOjkO
    9WbA32u1IalD8pJwOOA/6CdvirJqxVvhZ1oxaZIi+JzQO4RA9gfVldbFvSlPni38t+2s
    xWsjYqIB3rdPOT3AbnOwWKA/L5WSiQIyzQxliqAs9AMSZxOg6U96cFjCrHcZFAYpjfz/
    cFTTZoC8KQ7XW7P0xd3ZO14ZTFmg58ibftWoBXhfbWx+mp2uxI6KMdD38JyJWFYq60iv
    bUDw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1725385132;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=B9sb/jLkjTZC/aBQNv6z46jzN2OL/QWrCaEzGjd4Hvs=;
    b=aCoLggTJsGBXD4GHOvlGUuLLR5XdRcDBth+mpgrqXjEiy4lQHcI3YiLU499Jtot+eI
    J66YZTBXijQ7UYcTlykDf6yzbNHD2Pd5NS+zhd40Ey6SUzWCCgcFNmdapFV2MwBOEuC7
    azNwT8lKG3lX31A3c5ZNnM3ZzmVk5kTKgNdAzLyBQOY0rGLb5ZSMAj3kT2Pq1ihfyuPN
    Yn/lSW8FcOuSgHZJ3YrBXnrVozvZi+LjLZCN2HNCzOrtykPIUNNAuvki50x5z2pNTNSf
    AMTpKjCQvx+CedyXVKkTqYQVLmKvINYqBDvEL3CrW6oynQsTty3HFqVoT2wAwHkW90Zb
    j8FA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1725385132;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=B9sb/jLkjTZC/aBQNv6z46jzN2OL/QWrCaEzGjd4Hvs=;
    b=e6gXvSZzKbwP5xl2cf6NUgEugGRwQxkSH03/5aUBTAGEMpmg7pQTZSJ0x701g00pwd
    tUEBuBmUQnsqqw/LMpCw==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzstnjV5GU9c7oKNYMuRfGHqIHiuLmP1Lpd+UesJUZWVaudd1Gjb1n0"
Received: from ox-live-app405.back.ox.d0m.de
    by smtp-ox.front (RZmta 51.2.3 AUTH)
    with ESMTPSA id z960a6083Hcq4vl
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Tue, 3 Sep 2024 19:38:52 +0200 (CEST)
Date: Tue, 3 Sep 2024 19:38:52 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <1429823644.5400616.1725385132328@webmail.strato.com>
Subject: Request for reviews for 4.4-st56, 4.4-cip91
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev67
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Sep 2024 17:39:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16843

Hi!

Here's the manual backports to review for the next 4.4 release which, as always, can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.4.y-st-rc

72982c66626c7 exec: Fix ToCToU between perm check and set-uid/gid usage
8a5da8b6126e2 USB: serial: debug: do not echo input by default
4af9a95deab1a ALSA: line6: Fix racy access to midibuf
e8ec978a784ee i2c: smbus: Send alert notifications to all devices if source not found
ad01acb964a7f i2c: smbus: Improve handling of stuck alerts
733e3de52985d SUNRPC: Fix a race to wake a sync task
52bcba99c1772 udf: prevent integer overflow in udf_bitmap_free_blocks()
9f1f1bc701217 dev/parport: fix the array out-of-bounds risk
067c903b48150 tipc: Return non-zero value from tipc_udp_addr2str() on error
d9b7eda8938fd hwrng: amd - Convert PCIBIOS_* return codes to errnos
c75ed93ef09eb net: fec: Refactor: #define magic constants

Thanks for having a look.

CU
Uli

