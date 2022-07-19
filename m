Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD7DC433EF
	for <webhook@archiver.kernel.org>; Tue, 19 Jul 2022 19:43:01 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by mx.groups.io with SMTP id smtpd.web10.45304.1658259772813890639
 for <cip-dev@lists.cip-project.org>;
 Tue, 19 Jul 2022 12:42:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=phobos-20191101 header.b=P1sZ6ZWD;
 spf=pass (domain: denx.de, ip: 85.214.62.61, mailfrom: pavel@denx.de)
Received: from mail-internal.denx.de (p578adb1c.dip0.t-ipconnect.de
 [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: noc@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 49F7B8036E;
	Tue, 19 Jul 2022 21:42:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1658259770;
	bh=uzjhXc78QxSKtUL2QbWr9zAfeDpTFcMuMM6uHthmbUE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P1sZ6ZWD+U+XLXn1vFKSult0nQRhDYpoY+fpQH5oVH+P+tORYyJ5qbBp+zlLBFlcv
	 AYkikTItHu2ZHxhYjGPvwdmGyNtKCo2r8Gso5SAG/px7A5tqQ+c69AhAGlVCV136VZ
	 2AWtUH9EdwqUEQc8ayhmf+AbXte6UxiyebeVRtjtENu9AosdssLbaaD5ol8cRa55hl
	 c6foJLCjQxk7Y1E7p/RgP2ilrYs/iQawWMY3FOIcMA+khTj7ZcDgG0HSrylXlyzbwx
	 3NJM2ctNf18AM/cMQVE7tR0uy3rLDjejkT+p0Kjl5qOirxpzx62CqroB7lH98OdCva
	 KihX5dvVCbRYw==
Received: from pollux.denx.de (pollux [192.168.1.1])
	by mail-internal.denx.de (Postfix) with ESMTPS id B3B341811C2;
	Tue, 19 Jul 2022 21:42:43 +0200 (CEST)
Received: by pollux.denx.de (Postfix, from userid 561)
	id 8267A1A0042; Tue, 19 Jul 2022 21:42:43 +0200 (CEST)
Date: Tue, 19 Jul 2022 21:42:43 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Pavel Machek <pavel@denx.de>, nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: Re: [PATCH v2 5.10.y-cip 00/12] Add thermal driver and watchdog
 driver enhancements
Message-ID: <YtcJMyA+/T0z+FWS@pollux.denx.de>
References: <20220718092430.382889-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220718092430.382889-1-biju.das.jz@bp.renesas.com>
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 19 Jul 2022 19:43:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8862

Hi!

> This patch series aims to add thermal driver support and watchdog driver enhancments
> for RZ/G2L platform.
> 
> v1->v2:
>  * Removed patch#1 and updated rzg2l_thermal.c to use kernel.h.

Thanks for the series and for the fixes headed for mainline. The patches look good to me 
(but I can't test/apply them due to poor network access at the moment). I can probably do 
that on Friday, but I suspect Iwamatsu may be faster.

Best regards,
								Pavel
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

