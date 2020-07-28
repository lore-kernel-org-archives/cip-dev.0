Return-Path: <SRS0=wowy=BH=lists.cip-project.org=bounce+64572+5041+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F372C433E0
	for <cip-dev@archiver.kernel.org>; Tue, 28 Jul 2020 20:40:26 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D7972065E
	for <cip-dev@archiver.kernel.org>; Tue, 28 Jul 2020 20:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="kLXk6DUM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D7972065E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5041+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ELBQYY4521723xUJlreSXdrm; Tue, 28 Jul 2020 13:40:24 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.1976.1595968822577229928
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Jul 2020 13:40:23 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 301711C0BD8; Tue, 28 Jul 2020 22:40:17 +0200 (CEST)
Date: Tue, 28 Jul 2020 22:40:15 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Chris Paterson <chris.paterson2@renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip 0/9] Add LCD Panel support for RZ/G1E board
Message-ID: <20200728204015.GA1012@bug>
References: <20200728104330.6182-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20200728104330.6182-1-biju.das.jz@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: aS6Pi5yTBYQUHdXnGnvumgcsx4520388AA=
Content-Type: multipart/mixed; boundary="NaYGKbPbViP4wfZvmpqS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595968824;
 bh=+65qrKNaeRyBPy9YESl5kpfKWMYm3EWNukV0oulOyYg=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=kLXk6DUMX4goJWXW1KDhftya1BkqrSVxPUY9flEDf0krTcRjbQFxFttowDmEVovAKqd
 MsiifVhVRpms8XdyAQNuVJM2L+6CWJDuJwm+GR0xtP1E8J7lCiPn7tH2MERZSyo3352qN
 QYaU297wkAxL8DHPvi1GOAlE2UdFMQhJDFk=

--NaYGKbPbViP4wfZvmpqS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> Add LCD Panel support for iWave RZ/G1E board based on r8a7745 SoC.
> 
> Backporting the panel patch as it is, requires drm bridge Api changes, 
> which is not present at 4.4 kernel. So used the 4.4 rm framework to attach
> the simple panel driver with rgb connector driver. The rgb connector is
> based on the workdone for the lvds connector. The display panel binding
> patch is backported to 4.4 kernel,since the mainline uses yaml file and
> it conflict with corresponding .txt in 4.4 kernel.
> 
> Other patches in this series are cherry picked from mainline.

I don't see anything wrong with this, so I'll test/apply it if noone objects.

I guess we could like patches for cip-kernel-config repository to actually enable this in 
our testing...

Best regards,
									Pavel


--NaYGKbPbViP4wfZvmpqS
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5041): https://lists.cip-project.org/g/cip-dev/message=
/5041
Mute This Topic: https://lists.cip-project.org/mt/75842037/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--NaYGKbPbViP4wfZvmpqS--
