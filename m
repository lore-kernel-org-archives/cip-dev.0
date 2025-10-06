Return-Path: <florian.bezdeka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042ABCAC5B8
	for <webhook@archiver.kernel.org>; Mon,  6 Oct 2025 12:23:39 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web10.32523.1759753410552021142
 for <cip-dev@lists.cip-project.org>;
 Mon, 06 Oct 2025 05:23:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=florian.bezdeka@siemens.com header.s=fm2 header.b=H7t7i950;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-68982-20251006122325b1931ad9a8000207d6-qa6vb3@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20251006122325b1931ad9a8000207d6
        for <cip-dev@lists.cip-project.org>;
        Mon, 06 Oct 2025 14:23:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=9BoFYRJ+pYdQTT8IX5jeVvu41a06RIfSoMyiwvZoWm8=;
 b=H7t7i950oL1ObOtGJbB3QkVAahGg3irfrJiYR054KdCTfHuC0UgU3mTmg+BPuGbExuEB+O
 UEqgClNr7x4rM1ImbIi//HIt9wxb3erCahjaTakAjNkfTeXB58jD6DMRse4BHDQGH/P6vySc
 cqIKZQeYyC2tbiRk89WFgx/Heu1Rmtm1kLRv4MHGFPQfe7ZQqavN1NKVv9f1fXTsu2chnFrF
 PWy2NmG5fUmrKvLfBlnc/EwwwdDDqvjRyquDj+oLoAU3VhtmtP83ZZyWSxuBGoAZuT8zdvUj
 ugyJvjaQjccW5MUWJUPomrC2E026z6hR5OQkfWzBvz/FSIABPIixe2mw==;
Message-ID: <a4d4c0af30fac7d969772bc80f8bfc1163c8d0d1.camel@siemens.com>
Subject: Question about git history - linux-5.10.y-cip-rt branch
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: pavel@denx.de, Jan Kiszka <jan.kiszka@siemens.com>, Quirin Gylstorff
	 <quirin.gylstorff@siemens.com>
Date: Mon, 06 Oct 2025 14:23:24 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 Oct 2025 12:23:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20159

Hi all,

in the git history of the linux-5.10.y-cip-rt branch I see


HEAD
...
502b544c ("Linux 5.10.240-rt134")
         tagged as v5.10.240-rt134

ff0116cd ("Merge tag 'v5.10.240' into v5.10-rt")
df639ede ("Mark this as 5.10.239-cip62-rt27 (rt133) release.")
         tagged as v5.10.239-cip62-rt27

c9ee35a3 ("Merge tag 'v5.10.239-cip62' into linux-5.10.y-cip-rt")
081888d8 ("Merge tag 'v5.10.239-rt133' into linux-5.10.y-cip-rt")
d5eca7eb ("Linux 5.10.240")
         tagged as v5.10.240
...


Why is there a .239 tag between .240 tags? Is that really intended?

Best regards,
Florian

--=20
Siemens AG, Foundational Technologies
Linux Expert Center



