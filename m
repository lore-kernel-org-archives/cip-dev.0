Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5357C43458
	for <webhook@archiver.kernel.org>; Tue, 14 Jul 2026 20:47:40 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.218])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3511.1784062054335789692
 for <cip-dev@lists.cip-project.org>;
 Tue, 14 Jul 2026 13:47:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=qycAXiTp;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=Cv3jjJkB;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.218, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1784062046; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=pVasKsZFhIy6brpL4r/WN/l8EE2GrXyyS2oPRAipHz+wuYBgnjz2Q8YPXD4UfVSSsA
    Q8vW3JEAYDAhK69YLgMAjflce5/fMeHe3DbM2zmpGKsyDbznciZbHZhhN31hX+mBZreh
    6ZSS5RzL8RQ8FvX7Qdg5yNd+4kb2m1JCe4xZFPkY5NVVx9UbdjfOZCHglQoPsV55NEwf
    lw+LDXoOtgjqfebPjQT2VSy7hcYdcI5VG9BJbbh9cvGYXr9u4ns1EgIIzVyhDbq0eHDO
    laZIPfsjmYUfO6lY69lscfsw2s5kokRHeChSrgeobMp1Sy6AcaUzqalhROAtDA7E67BV
    hJQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784062046;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=vxFGF4C08p9eVuHRaT6oMTCPFXjC+6PqfHqQ8NcGy14=;
    b=Pmp9+bTYBBMdkZJsZxv6abJ0GV+vz2PD6lH9YfunxVcRYDzsyMSPwbDKM/3xgKEaIc
    Jr8AXfIXQSRGgJcA8IcjG0unx5BJjNl2ia5nm4xPaP9wMFYeN9/+9drUTYy3JbrM+qGH
    PmtQKOD9YsD3ku8ZxAa3jjIRwEo4VlLl+QWcBo/iG6ghTq6rfZ5M/SEoLxHs19+1SSNi
    wlIhpUtEdnGCXRSo/jKLm0q74AMrEd/mCJDXnZPT/fmBY5wBbeRNYAWTVzyZ2bjsYP+k
    5e7m2kmfcPTPf4G6txMgcQnDcHPt/FcF5vYtM/mZ3q2NimGZ8jVs37Fs1aAJx9v3XQxz
    YTbQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784062046;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=vxFGF4C08p9eVuHRaT6oMTCPFXjC+6PqfHqQ8NcGy14=;
    b=qycAXiTpqEC2tc+jvrYQqlKR14QEgvM4hj69zbRYYh3X18Fjn9u1nTR18HFX9981aR
    3OPT/Qlm7t/ZVRaL20x9qqYxhopmZq7VXlinW1zlxxNC2L3bZ6mSKPmlUSI/1Jbe/xFw
    6dAF66GnPwc1kdqtlaCE3eTWyRlO5SxPSWepvTs3hlAbuB7uctQ3lm5CbjBGasVE1suo
    7rALiyZ4Oa+UAaLglG7pGr3EsYY7chVJpPB3xDP7drrJu9vKllhu6H952294zOvUbZnp
    6RBsebsf/arIex+lh6FVZue4uLIHqsdAhhOPZGBCXB0A+DQ6g1awcLiOmtyAP0rcYTtA
    YQCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784062046;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=vxFGF4C08p9eVuHRaT6oMTCPFXjC+6PqfHqQ8NcGy14=;
    b=Cv3jjJkB65oHthMqF6SwHVmZizIGgr0MNulSwcjMPx0mHk9VM5uGdq/6Lo//ar4e5N
    xTHYshu0IuGsMeoB5CDw==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hexKHE+Dw/YsQ="
Received: from open-xchange-core-mw-gw-10.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 55.5.6 AUTH)
    with ESMTPSA id z4c16d26EKlQT0D
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 14 Jul 2026 22:47:26 +0200 (CEST)
Date: Tue, 14 Jul 2026 22:47:26 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: pavel@nabladev.com
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Message-ID: <1138844765.324155.1784062046046@webmail.strato.de>
In-Reply-To: <alS_410BkUAadIMY@duo.ucw.cz>
References: <396580511.533337.1783432236611@webmail.strato.de>
 <alS_410BkUAadIMY@duo.ucw.cz>
Subject: Re: [cip-dev] Request for review for 4.4-st78, 4.4-cip113
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.46.142
X-Originating-Port: 53274
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 14 Jul 2026 20:47:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23585

Hi!

Thanks for the reviews.

> On 07/13/2026 12:37 PM CEST Pavel Machek via lists.cip-project.org <pavel=nabladev.com@lists.cip-project.org> wrote:
> For now, I have not checked the batman-adv stuff. Two comments below.
[...]
> ! no dec in munmap? , c/e, will we now have framebuffer refusing resize? > 0bd353e476ab2 fbdev: udlfb: add vm_ops to dlfb_ops_mmap to prevent use-after-free
> 
> I don't see how this works. mmap_count is increased in mmap, but I
> don't see corresponding decrease in munmap. 

Yup, same issue in mainline, it seems. I'll drop it.

> a > e27540595d282 md/raid5: fix soft lockup in retry_aligned_read()
> ! check_mul_overflow -- is it generic for all types? does sizeof > return size_t?...? > 16b4cbdf426d7 lib/ts_kmp: fix integer overflow in pattern length calculation
> 
> +       unsigned int prefix_tbl_len;
> +       if (unlikely(check_mul_overflow(len, sizeof(*kmp->prefix_tbl),
> +                                       &prefix_tbl_len) ||
> 
> AFAICT sizeof returns size_t, so I'd be much if prefix_tbl_len was
> size_t, too.

Fair enough, but that's how it is in mainline, and unless there is something actually broken I'd prefer to keep it that way to avoid conflicts with future patches.

CU
Uli

