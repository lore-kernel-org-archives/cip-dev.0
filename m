Return-Path: <SRS0=1KgV=C4=lists.cip-project.org=bounce+64572+5467+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F93C43464
	for <cip-dev@archiver.kernel.org>; Sat, 19 Sep 2020 12:15:36 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E00A4208DB
	for <cip-dev@archiver.kernel.org>; Sat, 19 Sep 2020 12:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="IqCzZLSc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E00A4208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toshiba-tsip.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5467+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id U7StYY4521723xYkOYrEEu7J; Sat, 19 Sep 2020 05:15:35 -0700
Subject: Re: [cip-dev] [cip-core:deby 2/3] security-configuration: apply security polcies using package bbappend
To: cip-dev@lists.cip-project.org
From: "Venkata Pyla" <venkata.pyla@toshiba-tsip.com>
X-Originating-Location: Hyderabad, Telangana, IN (157.44.66.200)
X-Originating-Platform: Windows Chrome 85
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Sat, 19 Sep 2020 05:15:34 -0700
References: <ae0a8274c42447e59694998d04c7c519@toshiba-tsip.com>
In-Reply-To: <ae0a8274c42447e59694998d04c7c519@toshiba-tsip.com>
Message-ID: <31646.1600517734673900961@lists.cip-project.org>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 75iALbhjlr6gdIsYiad4aN8zx4520388AA=
Content-Type: multipart/mixed; boundary="ZXwiPDWSuf6Hcct2sfPW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1600517735;
 bh=Ro7eEhVDLP3Sh5xTgMHXFKP5hRz1+KAhemXVz2p2A4w=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=IqCzZLScUouJGQGKoN+sGXcBQDsXYXrz9FFc6NVY1CQi7c1rkg/Uq5hB8u/UxucTJ0q
 LWq6NXQb9AjQsps6Fo813fy5J1UTBfxVvJcrXL5/or7QaidbBtoeP+0rht48s2E0ZVMY1
 G/DHKb4UdkfsLW98jdI1763Pyv9VmIhsTMk=

--ZXwiPDWSuf6Hcct2sfPW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2020 at 10:23 AM, Venkata Pyla wrote:
Hi Daniel-san,

I  have created the merge request for all the security layer changes inclu=
ding your suggestions.
Kindly review and letme know if you have any more suggestions.

Thanks
venkata.

--ZXwiPDWSuf6Hcct2sfPW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5467): https://lists.cip-project.org/g/cip-dev/message=
/5467
Mute This Topic: https://lists.cip-project.org/mt/76865928/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--ZXwiPDWSuf6Hcct2sfPW--
