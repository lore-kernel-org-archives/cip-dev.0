Return-Path: <SRS0=9G4/=AM=lists.cip-project.org=bounce+64572+4877+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AE2C433E0
	for <cip-dev@archiver.kernel.org>; Wed,  1 Jul 2020 19:24:12 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 814BE20853
	for <cip-dev@archiver.kernel.org>; Wed,  1 Jul 2020 19:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="YKsy/AQT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 814BE20853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4877+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id GTM4YY4521723xAMZRT7G71E; Wed, 01 Jul 2020 12:24:12 -0700
X-Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
 by mx.groups.io with SMTP id smtpd.web10.5039.1593631451084336313
 for <cip-dev@lists.cip-project.org>;
 Wed, 01 Jul 2020 12:24:11 -0700
X-Received: by mail-qv1-f49.google.com with SMTP id di5so6612496qvb.11
        for <cip-dev@lists.cip-project.org>; Wed, 01 Jul 2020 12:24:10 -0700 (PDT)
X-Gm-Message-State: G5WDxB53Ww5HE9d4OKW3LIbrx4520388AA=
X-Google-Smtp-Source: ABdhPJz8DpNQWYO6dr56t8vBDo69YkHRmgc/W4iz1rUKxJA5/E8ZpqpApUZqmHe78xIiUzQ5nSguSLOckZkYBGpBRgM=
X-Received: by 2002:a0c:8284:: with SMTP id i4mr25737661qva.77.1593631449961;
 Wed, 01 Jul 2020 12:24:09 -0700 (PDT)
MIME-Version: 1.0
From: "Zoran" <zoran.stojsavljevic.de@gmail.com>
Date: Wed, 1 Jul 2020 21:23:58 +0200
Message-ID: <CAEss1EJ7j1FO-UvBBHs-GxoV0ag31PCUv1YasK6GxNjQvahDBQ@mail.gmail.com>
Subject: [cip-dev] Building generic initramfs for the various testing
To: cip dev <cip-dev@lists.cip-project.org>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="JTEqY5uqrIV9Rjh8X1wo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1593631452;
 bh=XwgYKiLLsQIWyr24HDndhM2Oi4nc4ycHDPpToTkkPOE=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=YKsy/AQTr5jrx9AzobIgEhnYKxR21NqtUM259iSSl9vzanXW7E8VGPH7W02667Dr/6e
 sDsey/EYQrwN5sgZ9zjvnHjo8epf7GBzhOgmFC0kOtij/JP54zKB6V05QvMYjSmT1N2sA
 JMTD6b48efWqXmFLHyRjeW6B4iS7X/cc778=

--JTEqY5uqrIV9Rjh8X1wo
Content-Type: text/plain; charset="UTF-8"

Hello list,

Long time no see... ;-)

Just for the sake of Reality: the generic initramfs building from the:
https://wiki.linuxfoundation.org/civilinfrastructureplatform/cipsystembuildhowto

Does not work (for me, at least) anymore.

Here is the new minimalistic script, since I needed it (and reworked
it, to be much more efficient):
https://github.com/ZoranStojsavljevic/BBB_Workshop_Examples/blob/master/Generic_Initrd_Porting_Guide/initramfs/create_initramfs.sh

Enjoy!
Zoran Stojsavljevic

--JTEqY5uqrIV9Rjh8X1wo
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4877): https://lists.cip-project.org/g/cip-dev/message=
/4877
Mute This Topic: https://lists.cip-project.org/mt/75243553/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--JTEqY5uqrIV9Rjh8X1wo--
