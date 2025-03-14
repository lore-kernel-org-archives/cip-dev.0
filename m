Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D555EC282EC
	for <webhook@archiver.kernel.org>; Fri, 14 Mar 2025 12:35:04 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.162])
 by mx.groups.io with SMTP id smtpd.web11.13165.1741955701789437213
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Mar 2025 05:35:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=m10xojIl;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=zWG4gbbA;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.162, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1741955689; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=jv99bxo8cK2VfxFsUBsIEBKEGlrhvszY5CBHcfTYGE8PvOPHHCjX7QouRFTmrQ+HAB
    Adt8r1d/MNsR3zg1sEY23AuzROaLyiME3OjltuC8IwpoEVsjZIDdbgqK8gV0fz+K2vth
    +jn43SyDZwqggQUZ03zW1j3Zxa/MQnNqyVdolFV/XPOniOVA9eG4QOjuxh6x9Rrmh9jo
    9OsqbHlO9u1X1xYjvgzRbuXneqU4qxX1ggbe0lM4F6NfMkpKGQq3Gs2M9kYu0dXmgMnA
    ybzx27VGWaEZMMdKJG99cjTZtokBvXiLVV/sl8tbuRvxK7Zw0aqiEBtW3iWkv5Gn3NWD
    /hLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1741955689;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=WBWMQSDHN1gTcVdmha2WFDhGhRylDsCZ5GJTJTNmjCU=;
    b=DCJ2kfQnp91ZpICOtUZul2c6jQjtEfasmdpD6d7wj7uYQ3bjjq7rCc5RiFGjHGa1j8
    hWs1NQjzWi1tItYo75cS3gia5cBifs+nNu5TKXhJjDniilSlM564J4chmapAnCJfgxXz
    7sdDlm/j4UCtyl+cGzWXJWCpwOER4KLPJypu8esNVLqK6mzM+55+v2WF0KGkuIVQ191t
    ti6mXhvb6KgiipR6E5UPDfIV/kLZB4sDGAO8tSFsJvOs7PRWM5yjcRCMwYaMqAZ8GKfO
    zqJQKn4hGs4/hfw72mxVI6JbzSfDF9w4+6oy8hvAUZ1BGBqQ/fGDObkVuegz8Bxa0No5
    XaPA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1741955689;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=WBWMQSDHN1gTcVdmha2WFDhGhRylDsCZ5GJTJTNmjCU=;
    b=m10xojIlOH5sJBVVjP8P4f21SWVFEraiCfF+Jpr0lsn+n2D/j9h2L4k7Lun1V12C93
    vi0MPMzKlvJcao90jNuBN6E4MwZTuvXVdggoZJ5n4xXNFwypkMrO4MaOcCH5qv0cR/y2
    idw/MfpFPHRaKi5a4cHAtyRv1lQhA+YB3rKXyRJUtX7HKy+KTNeCEdXhpgTqK2mYpbQr
    Yojqqqj8Aqc3wk39bwqqErwQ5kUzu463AN4wJ9mUjnY3nP1dj7pv3bj1kMZ4o0rD1Nqc
    sblK4zYbA0rNtJlRKf2adu//vSLP0urKDBZZFSBsofrIPcGvjBIQXzYbRMBhkzRCpkOF
    k+iQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1741955689;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=WBWMQSDHN1gTcVdmha2WFDhGhRylDsCZ5GJTJTNmjCU=;
    b=zWG4gbbA+lgTEF9NQPVtT5AyoU84B9i3A6ATmwCtAaTbG5zMF5YDp8Ro81iKALxw0I
    +C9ljo4X4eID8wX3NTCg==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzotGZsghGuyXrLvf2q/w=="
Received: from ox-live-app305.back.ox.d0m.de
    by smtp-ox.front (RZmta 51.3.0 AUTH)
    with ESMTPSA id z2a34012ECYnicm
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Fri, 14 Mar 2025 13:34:49 +0100 (CET)
Date: Fri, 14 Mar 2025 13:34:49 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <1265902513.5463957.1741955689526@webmail.strato.de>
Subject: Request for reviews for 4.4-st62, 4.4-cip97
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
 <cip-dev@lists.cip-project.org>; Fri, 14 Mar 2025 12:35:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18217

Here's two manual backports for the upcoming 4.4 release. They can be found in the tree at https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.4.y-st-rc

ed0c3fd887468 scsi: iscsi: Fix redundant response for ISCSI_UEVENT_GET_HOST_STATS request
30e94a5d266d9 irqchip/gic-v3: Handle CPU_PM_ENTER_FAILED correctly

Thanks for having a look!

CU
Uli

