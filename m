Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7520EC4332F
	for <webhook@archiver.kernel.org>; Thu,  2 Nov 2023 12:12:57 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.217])
 by mx.groups.io with SMTP id smtpd.web11.29123.1698927176077279707
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Nov 2023 05:12:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=epHyCkvk;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=aMW+x+85;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.217, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1698927166; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=YY69Iruu8mf4d+XiK7jVrFs64Tc8qlZZyKnS7zqAoAUgeIJw9ADpkQqojvHWHdm2Li
    +WUXiwtGuhxZmX1xeEUAHCjj1VZZhwWUWr4qc2vg/zKOD0xi26LPeu0HJgFqlrAkyS/y
    jeuPPDXzrAuk1QMpQ2prM3tcV6KV/ug48y1hz4tYeIb1y1CY8I3i1ZAEGx0+09DDSepU
    qXh0K/ffN+0a40hgE1DZh3uY/qTD073NnTfvIs4WgoofUEI12BvZ8a/UEHlNsg3jp2tk
    KyE2IcIAYHua3k9lJjsS7YoLOKOmo2/vxlbrpShBaYJC+p1Cg2eNTrrIH++ibYKEm9lp
    dGNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1698927166;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=x57qwfjCilIgc55GCryICd5o86QiVlJkU7akYR0E0H0=;
    b=kKW90jNnB1vSvwjKmoHdNXinF9AurYU0p1H3sEDyIlSlYL8XsXijPgiU0DxZmZj+Kw
    1nW0sstHgTdfdEjTCR3QkoVAVShlvyabOyclCRoAr/9nGnybAbksFRE0G8swWLYyYae/
    ISdbX3gSICoKMgzjCggXSCT6s6DbhbOMFddW7nkgRt21aSjko1Cm7uPBRvijsC9/J/Yb
    XwabCGC7eWqBZdpysmsuJrcK/rdYKGwQO6H+/62y7kQJvokY2UbUmmpbjw86YkQ1Opgy
    eQF8EyYlSUy/2fnfWklmSb/PXnEmuqQuXYSicgwhskqxFdL9j+UmC/Q1MWLnjipPtLOl
    DIZA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1698927166;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=x57qwfjCilIgc55GCryICd5o86QiVlJkU7akYR0E0H0=;
    b=epHyCkvkCHjdKhXNmDqlGgDwrODh66IhFllNAk2vYZwoQpuYyfrcdkBE4KTP50NAjO
    mrRF5gvbYQdzlhiTMp/ZhZrvsQrKaftJ3U5WHG4MkxK5G0pDPiZ6EKvsDu55pBVaF+es
    vqybQBCnh0QoJVGS4YX69eQgzGtTuDgfhtbfCMHZegFJfLRobsCO+jkl8G0ePWrpYwP9
    /NIX0QUsd6Dgwzt6uQiAXrUacbTEXYS/BfNCjmM3lHxD1T+/+Jf6S9eleyAI38iLeqAU
    GsBJyEOsRnH36WYRwejHyFLYmO/W3+Sud0fwFQjjo399QYfb6bfNNabBGy4TZN4oK8K0
    KdXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1698927166;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=x57qwfjCilIgc55GCryICd5o86QiVlJkU7akYR0E0H0=;
    b=aMW+x+85BwpzqEf5gF1Ix8uwPEjgMEjAnuRVTUVTCXHbyjvgIlKkl3WAvLNjWrYQIf
    rZwBTB8lZngXIOxtKNAg==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv3qxio1R8fCv/x64iFM="
Received: from ox-live-app403.back.ox.d0m.de
    by smtp-ox.front (RZmta 49.9.1 AUTH)
    with ESMTPSA id V6209fzA2CCkQNn
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Thu, 2 Nov 2023 13:12:46 +0100 (CET)
Date: Thu, 2 Nov 2023 13:12:46 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: Pavel Machek <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Cc: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"masami.ichikawa@miraclelinux.com" <masami.ichikawa@miraclelinux.com>
Message-ID: <1467992071.19758.1698927166477@webmail.strato.com>
In-Reply-To: <ZUOHFBqa5PycOF8x@duo.ucw.cz>
References: <1974154422.1865436.1698902356282@webmail.strato.com>
 <ZUOHFBqa5PycOF8x@duo.ucw.cz>
Subject: Re: about "x86/cpu: Fix AMD erratum #1485 on Zen4-based CPUs" in
 4.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev54
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Nov 2023 12:12:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13515

[Cc cip-dev to get more input]

> On 11/02/2023 12:25 PM CET Pavel Machek <pavel@denx.de> wrote:
> > I'm not sure if that should be in 4.4; maybe somebody can offer some opinions:
> > 
> > 1. The platform affected is post-2022. Do we care about such things?
> > 2. It requires backporting of the whole AMD cpu erratum
> > stuff. Annoying, but doable.
> 
> I guess it might be possible to re-do the erratum stuff with less changes.
> 
> > 3. Not sure if it is actually required or not:
> >    It's a fix for an actual issue (spurious undefined instruction exception) that is triggered if STIBP mitigation is _not_ enabled.
> >    AFAICT we are indeed not enabling it (not backported), so unless that is done by the firmware, we're affected.
> >
> 
> I'd guess we are affected. But as we were not backporting previous CPU
> bug workarounds, it will not be easy to backport this one.
> 
> We have "KNOWN-BUGS" file explaining
> 
> "
> Not all speculation fixes from 4.9.306, 4.9.310, 4.9.319 and subsequent
> kernel version were merged here. These affect mostly x86 and arm64
> architectures.
> "
> 
> I guess explaining that listed AMD cpus actually need speculation
> fixes for stable operation, and thus are not suitable for 4.4, would
> be an acceptable solution.

Sounds like an attractive solution to me if nobody actually needs those chips supported.

Does anybody know of any use case for Zen4 chips on 4.4?

CU
Uli

