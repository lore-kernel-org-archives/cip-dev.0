Return-Path: <SRS0=Ztwc=AK=lists.cip-project.org=bounce+64572+4865+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F00C433DF
	for <cip-dev@archiver.kernel.org>; Mon, 29 Jun 2020 16:57:40 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C630A255A1
	for <cip-dev@archiver.kernel.org>; Mon, 29 Jun 2020 16:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="pyxlQD+e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C630A255A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mab-labs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4865+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id oxvzYY4521723x4mFC4E1jwv; Mon, 29 Jun 2020 09:57:39 -0700
X-Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com [209.85.208.193])
 by mx.groups.io with SMTP id smtpd.web10.969.1593449857710342520
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Jun 2020 09:57:38 -0700
X-Received: by mail-lj1-f193.google.com with SMTP id s1so18863106ljo.0
        for <cip-dev@lists.cip-project.org>; Mon, 29 Jun 2020 09:57:37 -0700 (PDT)
X-Gm-Message-State: 3cXEdMNEPQlsLNU1e8oVucHqx4520388AA=
X-Google-Smtp-Source: ABdhPJxIh/FLaTEEH6qBwdkCTp2VxJ3t9u++EtNDWqMY9CCXxeFCWHuwe7wL+3Xtdph/+fA/hSOMdgAOFg69cix+oTU=
X-Received: by 2002:a2e:9e92:: with SMTP id f18mr8878799ljk.16.1593449855477;
 Mon, 29 Jun 2020 09:57:35 -0700 (PDT)
MIME-Version: 1.0
From: "Mohammed Billoo" <mab@mab-labs.com>
Date: Mon, 29 Jun 2020 12:57:24 -0400
Message-ID: <CALkjhPpsdM8ZoC4QcT1EL8iQob4-pj3MWkesEvnNEFBOZ6LVOw@mail.gmail.com>
Subject: [cip-dev] Working on HTTPS connection
To: cip-dev@lists.cip-project.org
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="etzOb9kwKfxuCQwAPlcz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1593449859;
 bh=MaWvbL8oiFcpI0MmyqM95eqSTaWgeGTAvp44oM26GXQ=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=pyxlQD+eXicks5FAGR+KF51NhyQAmForSCiidwOd+bK/nJdFy+llTAppTdBmLCCG5LR
 Aaa0zKHSL1+1T7v597g7f/0e1QBEO7xCeNBUYh4vBz3ps2M8PZUt9dN+1WDykZKc2itMu
 ZlFOfZNGDPL0G1NIRNK5he2UssB5A3dUntk=

--etzOb9kwKfxuCQwAPlcz
Content-Type: multipart/alternative; boundary="0000000000009a7d0a05a93bf422"

--0000000000009a7d0a05a93bf422
Content-Type: text/plain; charset="UTF-8"

Hello!

I joined the mailing list from the recommendation on the IRC channel (after
viewing the CIP talk at ELC). I'd like to work on the following issue:
https://gitlab.com/cip-project/cip-sw-updates/cip-sw-updates-tasks/-/issues/8

I've written applications + drivers for u-boot, have worked on SSL (albeit
for Amazon FreeRTOS), and have HW handy to hit the ground running (I have a
DE1-SoC).

Is there any update on this task that should I be aware of?

Looking forward to contributing to this project!

-- 
Mohammed A Billoo
Founder
MAB Labs, LLC
www.mab-labs.com
201-338-2022

--0000000000009a7d0a05a93bf422
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello!</div><div><br></div><div>I joined the mailing =
list from the recommendation on the IRC channel (after viewing the CIP talk=
 at ELC). I&#39;d like to work on the following issue: <a href=3D"https://g=
itlab.com/cip-project/cip-sw-updates/cip-sw-updates-tasks/-/issues/8">https=
://gitlab.com/cip-project/cip-sw-updates/cip-sw-updates-tasks/-/issues/8</a=
></div><div><br></div><div>I&#39;ve written applications + drivers for u-bo=
ot, have worked on SSL (albeit for Amazon FreeRTOS), and have HW handy to h=
it the ground running (I have a DE1-SoC). <br></div><div><br></div><div>Is =
there any update on this task that should I be aware of?</div><div><br></di=
v><div>Looking forward to contributing to this project!<br></div><div><div>=
<br>-- <br><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gma=
il_signature"><div dir=3D"ltr"><div>Mohammed A Billoo</div><div>Founder</di=
v><div>MAB Labs, LLC</div><div><a href=3D"http://www.mab-labs.com" target=
=3D"_blank">www.mab-labs.com</a></div><div>201-338-2022<br></div></div></d=
iv></div></div></div>
<br>-- <br>Mohammed Billoo<br />MAB Labs, LLC<br />www.mab-labs.com

--0000000000009a7d0a05a93bf422--

--etzOb9kwKfxuCQwAPlcz
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4865): https://lists.cip-project.org/g/cip-dev/message=
/4865
Mute This Topic: https://lists.cip-project.org/mt/75196049/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--etzOb9kwKfxuCQwAPlcz--
