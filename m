Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBAEEC1EA1
	for <webhook@archiver.kernel.org>; Thu,  5 Feb 2026 11:17:50 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.220])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18345.1770290267082099074
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Feb 2026 03:17:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=c9IXHZNm;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=VcxNRSJQ;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.220, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1770290265; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=rC9wnOYJqpBWL352t9VLjZ7q8jPGn1cMJ//EZIXWAjpwccQxigjPIvMP/kZaRiMXQj
    5rEM1zaW1gwAPMg/uX+yxaE5KzgrbrEoiwLkVei/jNqX7XLuy4jx/GYI0WQlVflHOelU
    XL2Oh3gjDEE0NVygYFFMjGdgKdqC2yj9S8sdN+nKcQ5S1dXaztaaYLvc4INtsXesaUkV
    mPoa6piVcahbeaSwrtb9s1u9pSMByixC5em8NOtFs5hPHmRpgWHQlrMrW4Sf4mvgt2fs
    ZrqjStxA1M7ctCmQOxUJmh7zW+8DJGYBfgnQKV3dzHN/v6p3crk5CFcDYShImosghxEr
    DeFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1770290265;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=SiGbYTCBOMZK5pNxORzk2pziSQ4REyuczwPwAlEsW98=;
    b=c01faYzC6Oh84a20yy3yuNRZkXdgbFvOI6wrFrLmpK2URyO5GZ/ACirsrKalH4GJUi
    XxQ/RMKXVxWP6V5H4X2kfy2nkak7UxICiY1RhH+pfhdZe2P3BZ0ptr8HrxT66Npzdhny
    dtK1yAgBYHPNNQy9Lv/NwXhLAWUSvbfNC7gqwP241Tcf1+9FjLhTocDSwgoFtWHWPK8n
    XpGb8MA115v5vj0T479bcGMrurxqLS8KXP4OKEtymg8NdSGlv1W2kTSYzNUVAk5DS9hj
    q5b6FLheTOtPe0e/4caR+PNgDQRMhaAZJXuPrGrw2F00N1BoSlRQyyJkaOjq3otvIM+e
    MBpQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1770290265;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=SiGbYTCBOMZK5pNxORzk2pziSQ4REyuczwPwAlEsW98=;
    b=c9IXHZNmlIDGOrO89WdazOZvIPiQJKiX55GklVP+3TtF0geJr8+RQVyLSdqln1Q9CV
    DSc8jLrLyZ57ttPI1SSCoL3U7M3FFRpkoEvI0atgbE+Dwe9QKdiXkbWViOi4YJh+v1IE
    1tGF/axDFFpK2K3FohB/T7pPLGpZn78UKVmqddV+Ug7pHlpPqFN5ZayCgs/C/uAAYybt
    z4zEqEscjsJw610zNu/GegFTvBr6hIyGXhcH7pS3iK3/OOhjFsbyUEs+f0j/edfibaS4
    d6s0oyLPk582ngcX8BL7zue6oOqWUS0HaB2ext5y2Cg0EOQyQOidU+3X2TtpqbVDqWT0
    i5IQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1770290265;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=SiGbYTCBOMZK5pNxORzk2pziSQ4REyuczwPwAlEsW98=;
    b=VcxNRSJQ1ZbTKvGc6Opxon/HB8KHImq02lvI6DhmLPzSmqUt4/KD1mV1Skqv0DbK0E
    5j69jITtm4c+KJ7VHYDg==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvsX0yGC6oc7HiUIiXwbo="
Received: from open-xchange-core-mw-gw-38.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 55.0.1 AUTH)
    with ESMTPSA id z92cbd215BHja6V
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 5 Feb 2026 12:17:45 +0100 (CET)
Date: Thu, 5 Feb 2026 12:17:44 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: jan.kiszka@siemens.com, cip-dev <cip-dev@lists.cip-project.org>
Message-ID: <491377161.396738.1770290265045@webmail.strato.de>
In-Reply-To: <584f457b-2d06-4074-9f0b-22d967f11847@siemens.com>
References: <584f457b-2d06-4074-9f0b-22d967f11847@siemens.com>
Subject: Re: [cip-dev] CIP IRC weekly meeting today on libera.chat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.42.74
X-Originating-Port: 52262
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 Feb 2026 11:17:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21836

Hi!

Unfortunately I won't be able to join today.

> On 02/05/2026 8:01 AM CET Jan Kiszka via lists.cip-project.org <jan.kiszka=siemens.com@lists.cip-project.org> wrote:

> * Kernel maintenance updates

I pushed 4.4.

CU
Uli

