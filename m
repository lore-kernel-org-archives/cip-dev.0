Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78E0C6FD1D
	for <webhook@archiver.kernel.org>; Thu, 30 Mar 2023 08:52:40 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.161])
 by mx.groups.io with SMTP id smtpd.web10.20460.1680166353703171674
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Mar 2023 01:52:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=QophP6Y8;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.161, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1680166351; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=snEpHbf3t+4Qbqr0sHZS16dwcW5F1x8ZbUNqlJF0Ha0ZJMeB/XF6gZNmmjotfOAJ0O
    V5oc2hBwHjrjdaXI6b5tUw89KOV2B5a0/G0/Atus/aQj2ymDAXfq8T2ID2l5MzU847gj
    dNmBA073fIJUOEfAgcka2XgQV94HC8Pl6fLnmxkNO06jPBNqd9LQzd1mg5D3OJ5F/rFm
    YWomVnbNBcPQNuZWNbYs+cKVhCJjOd4Hwi5Gn0usJuSTeMEZFSt4QqBuhOlq2eTm3QmW
    CW+9M4+sWSarX7Df7LAl3e5NyUPbqPRx6Qeyu6n9lvo71MAL/Vyx0zMnErE9ppKM3sfO
    i4FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1680166351;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=RJQr2yPsJa2cuEPYixMJuno8+/qfO7jFpPsF0ZZGekw=;
    b=cBJ090e/GuekwLhLa+YqtYg1oN+11FVQKpci+VRDYM59I+vc28m8hwrCbLnESNHfQ0
    68yyyBHhaZh3kHygDmLe4+W7AlS10sHrbqObIP8TRqJZl7oKAvHazOAmbt1jR+gYtg7e
    pkSf5eKUFFyQVw24hAg/zJJclhMxMdq5Skqsb2nD09YdBDnH3IS4agidDlNaKgdQU9l4
    FRsoa3WpkYT+WMS3UQFR2JKN0AOrCTFPNK+YPnJaGvonfkq45RNrXm8LYEnb3YXYMNK8
    fwv7/dNifnNhCKFV7PRUDRknduGxWxpZn2tcnPcdL1OqDSJKQmDlC/tzz3+7hjo+UHb2
    cOMg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1680166351;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=RJQr2yPsJa2cuEPYixMJuno8+/qfO7jFpPsF0ZZGekw=;
    b=QophP6Y8tRXaBS12YzpAkvgJRehRLcnOWZGM0pw/ZlM1OlJ80G/KDxHvfMtJ5ZllVq
    XD4vuqG9gNFI0XxUqxjXl0LeMFc01OrYtMxVFO7Q0xxCPJTrGnHiq17zrqJxHmSHIWop
    z234x4jAShYbn72Oz5TxBJ39gSdtNJSmEzBYr3LxqmhsJsUdD5Nxv4UqifA4F/wkWuEw
    y5G36cQLGEn0u6hK3mFPB9cifn/qLwRuN3USBbjJN2Lp68ImChFvcY6zA6L6XKeEC+rL
    gNV6UkC1FMfknRG3N0Bpn8sAfJyFCHvxWJJAdMYivEknPRDD9SXSgz8hra1v2jDD0lkM
    7g5A==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv3qxio1R8fCt/7VzVw=="
Received: from ox-live-app201.back.ox.d0m.de
    by smtp-ox.front (RZmta 49.3.1 AUTH)
    with ESMTPSA id Uce81bz2U8qVkvp
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Thu, 30 Mar 2023 10:52:31 +0200 (CEST)
Date: Thu, 30 Mar 2023 10:52:31 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "pavel@denx.de" <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Message-ID: <1611211333.1066638.1680166351379@webmail.strato.com>
Subject: Request for reviews for 4.4-st39, 4.4-cip74, 4.4-cip74-rt43
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev40
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Mar 2023 08:52:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11134

Hi!

Here are the manual backports for the upcoming 4.4-st39, 4.4-cip74 and 4.4-cip74-rt43 releases that should be reviewed, and that can currently be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.4.y-st-rc

Trivial backports:

** m | d2d3052d9 6f8ecb o+ | gpio: vf610: connect GPIO label to dev name
** m | c075aa346 5d5aa2 o  | ARM: dts: exynos: Use Exynos5420 compatible for the MIPI video phy
** m | 09fa241bc 4971c2 o+ | ima: Align ima_file_mmap() parameters with mmap_file LSM hook
** m | 38345d84e aa56b9 o  | dm flakey: fix logic when corrupting a bio
** m | c214be981 709fca o  | Bluetooth: hci_sock: purge socket queues in the destruct() callback
** m | 9acadaf26 a98fc2    | staging: rtl8192e: Remove function ..dm_check_ac_dc_power calling a script
** m | 1c4293ded fe413a    | staging: rtl8192e: Remove call_usermodehelper starting RadioPower.sh
** m | 85f922f42 c22c3b o+ | net: phy: smsc: bail out in lan87xx_read_status if genphy_read_status fails

Not completely trivial backports, and/or stuff that touches important subsystems:

** m | 4e3b4b170 9a5571 o+ | f2fs: fix information leak in f2fs_move_inline_dirents()
** m | 5621f7a81 256fe4 o  | udf: Do not update file length for failed writes to inline files
** m | 11790a4fa b06730 o+ | irqdomain: Fix association race
** m | 30b560087 3f883c o+ | irqdomain: Fix disassociation race
** m | b40d2fbf4 4d57a7 o+ | ubi: ubi_wl_put_peb: Fix infinite loop when wear-leveling work failed
** m | 3df6f492f db4df8 o  | tty: fix out-of-bounds access in tty_driver_lookup_tty()
** m | 438d62a68 c4c81d o  | tty: serial: fsl_lpuart: disable the CTS when send break signal

I would also like an opinion or two on the importance of this patch:

** i | d5cf15857 e88b2c o+ | bpf: Fix 32 bit src register truncation on div/mod

I have chosen not to include it because it would require backporting quite a bit of infrastructure. According to the bug report at https://bugzilla.redhat.com/show_bug.cgi?id=1981954, the issue is not exploitable for out-of-bounds accesses on 4.4.

Thanks!

CU
Uli

