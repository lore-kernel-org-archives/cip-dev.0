Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FC1C79FB9
	for <webhook@archiver.kernel.org>; Thu, 10 Sep 2026 08:09:34 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.20])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8832.1789027767990618524
 for <cip-dev@lists.cip-project.org>;
 Thu, 10 Sep 2026 01:09:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=d1X3+y+n;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=7dYWZTUg;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.20, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1789027760; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=VBLE5vVDW9Jck0AdbImlmO2a3KE6Cie/L6aCTPl/cmzyR65pBZezRN5efYEjz+b2XO
    G7aVvNGk/jKShtD08pZXrfQu/dl18W1m0pU53CQpnsmhQxb/e6afRL22ftXQsKbnO8Ux
    1l4R5sC37lT5SlAJDI/T0uN7Nv2JpP8LApgHwEuNtiew0uslKDoVD+CX/UkpJIfSN2Sd
    G6goR+me82sbQxnZNxCUm9pBdQNiXdCGz22A2OvaCHQ1Pi3ZrCNd2gMBJcL3kDsbVES4
    Skur0sNDSsqwM+ukIHRtTdYSxsoAIVxd2Fhre0y3PDgUUuGzVZYAeF8RAmMx6aPKAsdU
    RJkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1789027760;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=60GIFsxpGSp8mYKHVPeCAP3qfQI/8SNlqlwcC0P/hFw=;
    b=VO2BtLLZtyaN5jdrJIXUdZFqhNK7up8nhwSmECelYiGTvv2if0SASmx8xOB8EIZV++
    K5neSTKYYonJthaQX054+l6M6QXhOuQAaSqK7c82k4VxtPWgJ01v/Hfoe+NJLiUvfGKz
    X0cgi47hxhiQgIMXPqRlwQNd2AFzMjRI1vBOYZqaB5/DSIdTCvqVnCjRGOYyFoVfZXdu
    MX/qfkpPmfCkOPiDmEd5aMvZOOvdlSTmWApUV0tyOtxu8YmKiC2Q6LZccFSNecWs4sIe
    IDNjWYq/odGDFIL9V/ZfmsRQr4Uyf97AGpUeHfNXDzLFic88DRFghYpeFqiJrKAc5sCX
    BrUA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1789027760;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=60GIFsxpGSp8mYKHVPeCAP3qfQI/8SNlqlwcC0P/hFw=;
    b=d1X3+y+nK04ARd1Tzr47oIzjgAXR24g8YX0VGJUJyR/pJthU6LAt41hbNyccKiqDak
    IDuMufQN7zrGoZpy9hp+QaHrrsOymLKhHyqLvUM9RU1kyMYiL2gV8/khBiO7ZY3FNkLq
    QEiQYVCpU+uNNeQCWOVMsaObaoHFuK0KWPGT512IxYYKa8eyoCk4sLBiu1B014u1iDah
    iBes3t/TApUGkbWyVajCvcDPmGLB7DC2ns9RmQxsN8WK8gDdXKcmbrLrJoWUlc0kXx+n
    9cARcqgPcJocX6AmTOFCIzxHlucx6b6MbA4ExjUhKA0tlvzt3ejH6Ceu2F3Jg0mZBLdv
    G/iw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1789027760;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=60GIFsxpGSp8mYKHVPeCAP3qfQI/8SNlqlwcC0P/hFw=;
    b=7dYWZTUg8eOp9MAVBI2lzNNBeVptc3RHFlZHAxXUzbr6r2PvjmZVvxAWUrCofPhhhq
    7lyFaamO4+kYmBzVVTAg==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hexKHK+AR2fLw="
Received: from open-xchange-core-mw-gw-14.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 55.6.2 AUTH)
    with ESMTPSA id ze24d928A89KbxH
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 10 Sep 2026 10:09:20 +0200 (CEST)
Date: Thu, 10 Sep 2026 10:09:19 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: pavel@nabladev.com
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Message-ID: <2140465127.285274.1789027759987@webmail.strato.de>
In-Reply-To: <aplhBK04CTRBNOBE@duo.ucw.cz>
References: <588742173.259606.1788373971804@webmail.strato.de>
 <aplhBK04CTRBNOBE@duo.ucw.cz>
Subject: Re: [cip-dev] Request for review for 4.19-st20, 4.19-cip136
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.46.154
X-Originating-Port: 45748
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 10 Sep 2026 08:09:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24114


> On 09/03/2026 1:59 PM CEST Pavel Machek via lists.cip-project.org <pavel=nabladev.com@lists.cip-project.org> wrote:
> I have some comments here. I'll try to continue review soon.

Thanks, this is very helpful!

> a > 27bcd94232ddc ipv6: mcast: Fix potential UAF in MLD delayed work
> !! should return -EINVAL > d03436150e4a9 drm/edid: fix OOB read in drm_parse_tiled_block()

The argument that the LLM brings forward is that returning -EINVAL would abort parsing of the DisplayID extension and thus any valid blocks that may exist down the line will be ignored. I'm not an expert on DRM, but I think the fact that in upstream drm_parse_tiled_block() doesn't even have a return value anymore supports that view.

> !! it fails to return error > 6fe1ea5d01613 hwmon: (adt7470) Fix PWM auto temp state array and bounds check

I would not consider that wrong. The 4.19 code does not check for or propagate any errors here, and adding that is beyond the scope of a minimum viable fix.

> !! should VMXNET3_RCD_HDR_INNER_SHIFT be 13? > e05a9dca311e3 vmxnet3: fix BUG_ON in vmxnet3_get_hdr_len() for Geneve packets

It should. Looking into it I found that because the LLM only had access to one branch (4.19), when it had to find out what that value is and couldn't, it made an educated guess. One tiny complete tool rewrite later, and with access to both branches, that mistake is gone. (Fixed it in the tree, too.)

I have also added instructions to the prompt to separate established facts (things determined by looking at actual code) from assumptions made by the LLM, which should help identify fails like this one.

CU
Uli

