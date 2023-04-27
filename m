Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8608AC77B61
	for <webhook@archiver.kernel.org>; Thu, 27 Apr 2023 15:21:03 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.216])
 by mx.groups.io with SMTP id smtpd.web11.23541.1682608852998298710
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Apr 2023 08:20:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=syqrc1AY;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.216, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1682608850; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Y2hkRDDunxekN8elP8XmbqyBYNAjgRJA18RTzZH3NhP4MNlCSajSEWToSS8IqZjVRI
    Mp64d2y4DLTBsIfMwCl0LNHztzU8ktdq5g4FZ9icSWuC0uWw5TSftu2DEO0v4w7PE3An
    twnb/AtYTKTVCE67DQchSSKv8kqw2voWqHV1oFS2i6QE0lI8ys6y00HcKXCTbGawWE21
    VIZTRw38/5xuG93VCCJdZSgxzjcsFTOFgR2Jh9hrSvaSIyOsPAxq+l4T1v1X7lGtJiwg
    i+CjEe0S07m/Y2i2PTgXx+jiji6mVkpOEGTpiew2Thal5GNQ+JPWxfNwiA8BldfCIzdm
    VeuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1682608850;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=SDrfV0pj2E9NSuXlbltK+pJLEOr/L3M1MhY/9S0nNRo=;
    b=Ak6OYc2xeRJoqz4MZiY2ex58jK3hV/eObc2nw/9hy7D3eRbnSCCdRKhxFF6e589zVd
    OZh2r1Y2jpOPhRsmmXs2QGEqHzX199C7tKGKiJ1kPKzvvpCqM6GL7lJvSyikXOX3+KbK
    nZYBUenIBSEJeaMMHptoFCJPL7q+nVh0N+dD5SoCJtKu7hRACjyPu0/J7AZ0SkpNW862
    BPIRJ3gE/azkWrMenFo8DMK4uwdeT1IJjsRyyXjCqlWVn9GcHAkQ4tvdAgIGQ2TRVefu
    4XcXBQyCIeLuRU+/u8gGhvMTeS3KhIF7OelqqA58W3Q8ZPveg2LE2MX5Rg9X0cAlNVSd
    qZtA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1682608850;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=SDrfV0pj2E9NSuXlbltK+pJLEOr/L3M1MhY/9S0nNRo=;
    b=syqrc1AY6PXol46Mff7c1CrAE84Usy5duE0em7unY+ZC7zblFA0242OU7Ag54lOcjY
    8S6xaH2+ywbZHLJDH0dcM24IUMoM1o4UAwScayqJslFjGUGdN6eUd55HgP3eP8bWPR8E
    9r4Z1IGHn8yoInYLmgfRYl5RK0LnJysLmH0ksZ/JOuLIKoWORrF0PKo/UKVl8DZ9xKKb
    G7eCwJ/2cyNJo5unW7Q0SERvNVhVOCtxFEllojSE+FDbdnVuTEgzpGacgMprUErQd65j
    giVrYgjYGwIKr3uck9U++dhxyca/pQuZjl2EwJdMHEtk7lYNIMN2OFDwwn53PzG3PkNb
    NNMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1682608850;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=SDrfV0pj2E9NSuXlbltK+pJLEOr/L3M1MhY/9S0nNRo=;
    b=acaE8qYJM7lRHS4o7vwS7u1cF4WD5cdFV+7NX05A8qFcLl4w2HXVhF83q2AZuNPyGY
    zlqNXy5kIXHxfxOdobCg==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv3qxio1R8fGl/wuMlg=="
Received: from ox-live-app101.back.ox.d0m.de
    by smtp-ox.front (RZmta 49.4.0 AUTH)
    with ESMTPSA id N2af97z3RFKoCou
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Thu, 27 Apr 2023 17:20:50 +0200 (CEST)
Date: Thu, 27 Apr 2023 17:20:50 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "pavel@denx.de" <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Message-ID: <1785763423.1934045.1682608850821@webmail.strato.com>
Subject: Request for reviews for 4.4-st40, 4.4-cip75
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
 <cip-dev@lists.cip-project.org>; Thu, 27 Apr 2023 15:21:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11368

Hi!

Here are the manual backports for the upcoming 4.4-st40 and 4.4-cip75 releases that should be reviewed, and that can currently be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.4.y-st-rc

Trivial backports:

** m | 3c29c13c3 968b66 o+ | hwmon (it87): Fix voltage scaling for chips with 10.9mV ADCs
** m | 36bfbaa29 b871cb .+ | ALSA: hda/conexant: Partial revert of a quirk for Lenovo
** m | 1487976d3 c17f8f f  | ALSA: hda/sigmatel: add pin overrides for Intel DP45SG motherboard
** m | 078465f34 bf8493 .+ | coresight-etm4: Fix for() loop drvdata->nr_addr_cmp range bug
** m | e10703fd5 5d8d4a o+ | arm64: KVM: Fix system register enumeration
** m | 3d081d862 c86c00 o+ | i40e: fix i40e_setup_misc_vector() error handling
** m | bff19445c ef8327 o  | nilfs2: initialize unused bytes in segment summary blocks

Not completely trivial backports:

** m | 38d976de6 621489 o+ | hvc/xen: prevent concurrent accesses to the shared ring
** m | 1629f6f52 90410b o+ | ocfs2: fix data corruption after failed write

This is a rather convoluted way to insert a missing prerequisite. It had to be backported because the reverted patch was also a manual backport:

** m | 65cb67402 67d7d8 o  | Revert "ext4: fix use-after-free in ext4_xattr_set_entry"
** m | 0a8cff7f0 310c09 o  | ext4: remove duplicate definition of ext4_xattr_ibody_inline_set()
** m | 322d238b7 67d7d8 o  | ext4: fix use-after-free in ext4_xattr_set_entry

Thanks!

CU
Uli

