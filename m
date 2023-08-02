Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F66FC001DF
	for <webhook@archiver.kernel.org>; Wed,  2 Aug 2023 13:58:59 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.21])
 by mx.groups.io with SMTP id smtpd.web10.15966.1690984729513172860
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Aug 2023 06:58:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=LfH6lWiv;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=BU2vkgZx;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.21, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1690984727; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=qIvBEfRTke4e25WB6tgwI7sQKi8DU7Z8OLB/zJn5+qpbpwFuXZQffSYZMV3GH31EZJ
    eVjW3YYSdPvPgRdMMORuu2tvykuKOnQi9SiMVjFQb/InTzITR3TrALjIQaMZQfvN+TRI
    TUJzQddQ3ynp32iCxjVC1mfi/M42mnwbtCLayyQ2+sz00oQm8dU776do9Z0JtjvOML/M
    z28ENYPEaCKXR8RecYmMcXBpl3FtezBJR6AtTKxhGKGDUxKEAMaFFqVX7RnHxyEPrdn0
    BZcRcA1jS3qPLbq00m2beVSKHl1LUsDftr3WdqC6v05X699jRnEE0ZEuCwrVSfmXMsAC
    V1Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1690984727;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=V+qZs/k2aEEMSB8S1FXBpq67sBq/BOBMJ7pNmAV0T0A=;
    b=Mbc0Y4CgJBy7FnRlVBOvreQ5PX3HqVB69m52HuO43dMSzwIYrklSeNtFRGEGs61c7Q
    KbjSee/Nq1f2BEorfYcNHEhs9AOfg6r/+AuaA5fXmlJ7kzKd3L3q6RqXcFgJX3mtWRlo
    GGHuyrU29ZvtlGO+fNxWjb/IfoA0LXcrtj8yztzXLb6GdYhgV9tP0Qg8ZjtUC6RxQPMH
    Zr/7Yh9lS0HwYW6u5I01RYRZAZjOtK4l71I0ZrP/1rlS5r5ykbj+ECNImjZ8p8rUHXco
    BhSdiH7IgoMye4hXmGWelNcBVALyl57EtiMrEw5egiuuqYCjd8zB1VGKwfDEsO8Ts6Nt
    F2TQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1690984727;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=V+qZs/k2aEEMSB8S1FXBpq67sBq/BOBMJ7pNmAV0T0A=;
    b=LfH6lWivBYVl5wzIqjnJAqt4f1Y/5wzGAhjKLpvqYEN4fBR7wii/A+NHkiL5/iguww
    LvN7Pq3hTHX8+IA+LVofKOEJdDgPLOpXC3RD5K6XXmFEEx7+UVnOlABWJbkKIbklP7K6
    bBa90nDXyTIDGvRrroVIQ6axoPyS2gmM3ZSBSmhNKvx6fzJUgesl/LfPeY6JSR+4VxXN
    oMYNR7dac2tety7A7FRs3qRhGUEBr4iO/tBPwlojlhBCHZEZPDhRNvldKFG5K6KxoDAm
    0e9BRigbeLxGBOQUKsgn3uRrFFWJKJW/5FrDC1Y1xg4eaX+ClrODLiE9ebUKdvDLTpAs
    Sy3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1690984727;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=V+qZs/k2aEEMSB8S1FXBpq67sBq/BOBMJ7pNmAV0T0A=;
    b=BU2vkgZxtFuBgGneavFvxbOgTKoI+QHGxsUURUAYzBfgHIca1aK5ZaDa+d3jf3OBq0
    A6niOKcXUFJfF5ttzzCQ==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv3qxio1R8fCt/7N+P9k="
Received: from ox-live-app205.back.ox.d0m.de
    by smtp-ox.front (RZmta 49.6.6 AUTH)
    with ESMTPSA id wba236z72DwkZjj
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Wed, 2 Aug 2023 15:58:46 +0200 (CEST)
Date: Wed, 2 Aug 2023 15:58:46 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "pavel@denx.de" <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Message-ID: <536431671.1986977.1690984726917@webmail.strato.com>
Subject: Request for reviews for 4.4-st43, 4.4-cip78
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev48
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Aug 2023 13:58:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12537

Hi!

Here are the manual backports for the upcoming 4.4-st43 and 4.4-cip78 releases that should be reviewed, and that can currently be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.4.y-st-rc

Standard backports:

** m | 9d7178c75 62fab3  + | IB/uverbs: Fix to consider event queue closing also upon non-blocking mode
** m | fb7bc3baa 8d8406 .+ | mmc: mvsdio: fix deferred probing
** m | bd9621108 2174a0 o+ | sch_netem: acquire qdisc lock in netem_change()

Then there's the Zenbleed workaround:

** m | 17a67740c a32b0f o  | x86/microcode/AMD: Load late on both threads too
** m | 5bb1e29bf None o  | x86/cpu/amd: Move the errata checking functionality up
** m | cfef7bbf0 None o  | x86/cpu/amd: Add a Zenbleed fix

This stuff also has some dependencies that had to be picked up/backported:

** m | 3f1f576a1 | x86/microcode: Propagate return value from updating functions
** m | 1008c52c0 | x86/CPU: Add a microcode loader callback
** a | 42ca8082e | x86/CPU: Check CPU feature bits after microcode upgrade

It all looks relatively harmless to me, with the exception of "x86/microcode: Propagate return value from updating functions", in which something could easily be missed.

CU
Uli

