Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DB8C71153
	for <webhook@archiver.kernel.org>; Mon,  4 Sep 2023 09:44:02 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.20])
 by mx.groups.io with SMTP id smtpd.web10.44360.1693820639367031626
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 Sep 2023 02:44:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=srRyk2VO;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=OBQubo+2;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.20, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1693820637; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=WX0Wuuw3snUE8lc1lbygw6T9MnHKIfy5IRQ1BCnvhKnVxHMQj9g7ptRcfgvuIJ//1n
    rIud0vGXyS1JjCrqCUoH0ra7zB/drL1/xkH5U5dlsL+FUtgdiFNsYM5TsKI+1ySlZ1ze
    qfvCof9cuaFYO8jO0g5BAfEm2Y9Fn5B9dFCGvGSig5ImBIIhMYAevNe1g1QeYMKwFa9A
    faD7TNOK+88jTEmGhMNVdCnvzICGQ9ZK/dgRaq9a2KPv66yxpFImn2RVg4145z5EvVBX
    VP/8UxJZ2px8UynAIIbrTsofMtc3NRW8OY0/cyWz08YdTc+nbl57tUlTKs6ld7BjRQYx
    Sx0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1693820637;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=GqUH0bSOsL+2PigHeSB7OcVwzIGWPHI3a+SzdvEWIUA=;
    b=eaGJ6flAzTSNv0gRu7h4gsYAdvRB2dlhhFP0IKPmBdx1jW67nvw6kH+12WmXkuPOzJ
    JVoEm6lTTpw7+80Rq/mEJqTH5i0pDHArnIt+44fUZkBaPgUJRBUN4OpqtK742e89Twv1
    om3E5K9i/FDM9a009hL5TFO4X305g1ns8uJqBd6lWtx5BpMBIvEAx78APIvK2hvMxSPV
    aiAx3us/X0j5KKuuAbS0bja1VCVz1Cg1gfepnXeiwgbciCXTI2vG6mOgwX8kYN9pcJdR
    nTl7J4D1XezNR1woA1xY+etqkWwyJxIi4Lfp930i03NiDiGeGWy4cTopbWUDNpi9U8qH
    hy6A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1693820637;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=GqUH0bSOsL+2PigHeSB7OcVwzIGWPHI3a+SzdvEWIUA=;
    b=srRyk2VO/U3mEOxZanoY+udHFv2ReD6iB0kT/5b4PoW7+Kos3xPAEvegdzCsja2yXm
    6S+dmjckYbs6PUop3SPfHDY0egz2yPNtULYqhiB8cho4zSN35NtN0ErnGMB/mIVXkeiv
    Eltp+06qsEq5rUJdQvc194T+AJU87fVfXkiOllPlhnMoglSyDFkZUBVDe/DpwFAg20GO
    cL07pMgUc/awLNFNxmmR/q4Rwo6+N+o4Y6xhq1nBSn30U4r7Ks4kG2KuyE7uxYRV7S33
    FALJA2FYhqUq7rsWytjUokBrUCMuyoAXpV8MxbQOTsNTvra6YDz2RvT8zAuZZtHGAzGX
    sKfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1693820637;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=GqUH0bSOsL+2PigHeSB7OcVwzIGWPHI3a+SzdvEWIUA=;
    b=OBQubo+2zQfrVeW/Sk/3jNaSrpxvFBM8UkkVEc3gXkeri3NSnGs3SxRbtbqTHJI2J+
    p1H5gciHkePiavdmwbBg==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv3qxio1R8fGl/w2B+Io="
Received: from ox-live-app401.back.ox.d0m.de
    by smtp-ox.front (RZmta 49.8.2 AUTH)
    with ESMTPSA id eb482fz849hvEAL
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Mon, 4 Sep 2023 11:43:57 +0200 (CEST)
Date: Mon, 4 Sep 2023 11:43:57 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "pavel@denx.de" <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Message-ID: <1583308606.3395319.1693820637255@webmail.strato.com>
Subject: Request for reviews for 4.4-st44 4.4-cip79
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev49
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Sep 2023 09:44:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12939

Hi!

Here are the manual backports for the upcoming 4.4-st44 and 4.4-cip79 releases that should be reviewed, and that can currently be found in
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.4.y-st-rc

My apologies, this is a big one. Thankfully, most backports are of the trivial sort:

** m-| 9559a3e60 f9c998 o  | x86/smp: Use dedicated cache-line for mwait_play_dead()
** m-| f175f567b f8ef12 .+ | ARM: orion5x: fix d2net gpio initialization
** m-| 4ee69c91c 6eef7a o+ | netfilter: conntrack: Avoid nf_ct_helper_hash uses after free
** m-| f66069f9d 247c3d o  | ext4: fix wrong unit use in ext4_mb_clear_bb
** m-| b3e17e6e6 a82d62 o+ | Revert "8250: add support for ASIX devices with a FIFO bug"
** m-| f35bd94b4 af73f2 o  | scsi: qla2xxx: Check valid rport returned by fc_bsg_to_rport()
** m-| 005961bd8 00eca1 o  | scsi: qla2xxx: Pointer may be dereferenced
** m-| 11b8e27ed 55c3b9 o+ | can: bcm: Fix UAF in bcm_proc_show()
** m-| 8dc52c200 8ce884 f  | posix-timers: Ensure timer ID search-loop limit is valid
** m-| 4793f9802 1aeb87 o+ | tcp: annotate data-races around tp->notsent_lowat
** m-| a276d17dc c55afc .  | usb: ohci-at91: Fix the unhandle interrupt when resume
** m-| d3009700f c2a88e o+ | drm/client: Fix memory leak in drm_client_target_cloned
** m-| f0f874147 3044b1 o+ | net/sched: cls_u32: No longer copy tcf_result on update to avoid use-after-free
** m-| 005f68d6b 949ad6 o+ | tcp_metrics: annotate data-races around tm->tcpm_stamp
** m-| 38f1f09dc 8c4d04 o+ | tcp_metrics: annotate data-races around tm->tcpm_vals[]
** m-| e28208e21 404615 o  | ext2: Drop fragment support
** m-| 368684d3b 048c79 o  | ipv6: adjust ndisc_is_useropt() to also return true for PIO
** m-| 8fad4df94 8a9896 o+ | net/packet: annotate data-races around tp->status
** m-| 4eb1fca13 d6a95d    | quota: fix warning in dqgrab()

These might need a closer look:

** mo| 70cc55f6c 1cba6c o+ | kexec: fix a memory leak in crash_shrink_memory()
** mo| 6fb4b3443 504a10 o  | gfs2: Don't deref jdesc in evict
** mo| 5df411bb8 8cda3e o+ | dmaengine: pl330: Return DMA_PAUSED when transaction is paused

There is also "x86/msr-index: remove duplicate definition of MSR_AMD64_DE_CFG", a minor fixup for a warning introduced in the previous release.

Thanks for having a look.

CU
Uli

