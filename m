Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E613AC4167B
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 07:53:54 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.217])
 by mx.groups.io with SMTP id smtpd.web11.78570.1701935633923049945
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Dec 2023 23:53:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=hHTHG109;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=N6VPmnRj;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.217, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1701935625; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=IsHYcuCpvHHijEnd/TfgdgAaxZV8tirn4krqNcvo4s8mHVEOf9uX+xsG4u+bmRh75T
    hF6GRPIQHzRnoU0cUiN8t9iIxsaenmYKjdUuU5DAzoAPwicLkE0USrEzl2pzQ1dBNQLO
    NY6tWKewWEro4GBYRiaKeXfRFKcO8qcFTtedPIDCNdQICdd1Z4shUomvAcXPXuWpMNrD
    drR7RvMhzZpAsPGYLDhCuUOJKZ25/VhE8VPZi9tqTDNPCXuelEgp2HHoA47XkzjiHdCL
    WA3ym8KUyD2m0WD0Ssp6xrZR12UoB3li5BTYoKRofXY3szApWIkrQ1HSpaOrnbN0hHMj
    uoeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1701935625;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=G5z2Q+mSBj/Wule5/14fH8k8l+MweDEFNVzFchGdbZs=;
    b=H9dOBtvHmDk0EYUsOHgs0ZUqCUwbhHly2Is7k9Oqpxtqw0/N2V4eia8dhIIOLaycNX
    JrrJpF83ltyDrDjeRYls1l6yqFwGf55ve/s2osCG/l2Ye3SxABIOJRG7rFXBTd0b1/Zm
    sC2AzD+m9PPkaPfvK5ZwFhFF3oK1bjTb0OhHIbsCu/Ydf1Fb3rYquXrIdFAEujLx9gTW
    4l+Ynmtk6UGyc9bx6qn/z+jEMoYccb6kB59mupdb7iReZNYDOPJ9scSecgKSvhRj8T7R
    mxhWMhPuaHIK+2hihufBQpctB7ADA+2nu4QdlvgCQmspdFKAf2VxGjjrMdqA/56YIqzv
    PDtw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1701935625;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=G5z2Q+mSBj/Wule5/14fH8k8l+MweDEFNVzFchGdbZs=;
    b=hHTHG1090FTacVSV6hQVhkfetOOUcHVRVsCxOeqJHB+lt/oi7alDUp6ud623w8qncM
    QZ3+LweSBcmBTNVkgibVRritF+q7xI3hnUVV8KR7uyyGb2pa63hes7aty3ezAQZ8g5QO
    UT60gGonCLruVnCeAavSEtcDON1YycyOk2S5ZayB1S0tsMD/D2XFWA6D/xRfOFdPo2Wq
    heezWR8TAxyqZMrqnxwoSi1YOnhznsDppcqtBIBqlxgATdosTvFKLUDEZYnTFn29NhY+
    wo++ySjLR/1icMQFJo6uK34iYzRTENl4thd1WFhOSBkHBgBeb7dLf+D/j7CZ6K+FSLwX
    D0pw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1701935625;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=G5z2Q+mSBj/Wule5/14fH8k8l+MweDEFNVzFchGdbZs=;
    b=N6VPmnRjOackegxj+anltYvsCC0Cselr4ErxdvESAkEG+pteKYRPvHiW89fX7I2wIh
    G17ap4VeVToLBwNhhwDA==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv3qxio1R8fGk/2mpg+g="
Received: from ox-live-app202.back.ox.d0m.de
    by smtp-ox.front (RZmta 49.10.0 AUTH)
    with ESMTPSA id d26e78zB77rj8VM
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Thu, 7 Dec 2023 08:53:45 +0100 (CET)
Date: Thu, 7 Dec 2023 08:53:44 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: "pavel@denx.de" <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <1721610604.312805.1701935625001@webmail.strato.com>
Subject: Request for reviews for 4.4-st47, 4.4-cip82
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev55
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 07:53:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13811

Hi!

Here are the manual backports for the upcoming 4.4-st47 and 4.4-cip82 releases that should be reviewed and that can currently be found in
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.4.y-st-rc

** m-| 6112a326f a5feba o+ | r8152: Increase USB control msg timeout to 5000ms as per spec
** m-| 75e4376b6 128b0c o+ | x86/i8259: Skip probing when ACPI/MADT advertises PCAT compatibility
** mo| 3b6a41708 0618c0 .  | dmaengine: ste_dma40: Fix PM disable depth imbalance in d40_probe
** m-| 568e546fc 081480 o+ | tcp_metrics: properly set tp->snd_ssthresh in tcp_init_metrics()
** m-| eef0a4b2e 3391ee .+ | wifi: rtlwifi: fix EDCA limit set by BT coexistence
** m-| e3ced1fe3 a5d14f .+ | clk: keystone: pll: fix a couple NULL vs IS_ERR() checks
** m-| 2b391eb17 974757 .+ | USB: usbip: fix stub_dev hub disconnect
** mo| 6744008c3 19b3f7 o+ | tipc: Change nla_policy for bearer-related names to NLA_NUL_STRING
** m-| 33690eb1a dec96f o+ | btrfs: use u64 for buffer sizes in the tree search ioctls
** m-| e52e324a2 760efb f  | drm/amd: Fix UBSAN array-index-out-of-bounds for SMU7
** mo| 930f0aaba 4df105 o  | scsi: libfc: Fix potential NULL pointer dereference in fc_lport_ptp_setup()
** m-| 69bba6260 099be1 .  | media: gspca: cpia1: shift-out-of-bounds in set_flicker
** m-| 01d004afb 2770d4 o  | KVM: x86: Ignore MSR_AMD64_TW_CFG access
** m+| 5f4531a12 5fba5a o  | btrfs: fix off-by-one when checking chunk map includes logical address

Thanks for having a look.

CU
Uli

