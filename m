Return-Path: <SRS0=Cmxa=BD=lists.cip-project.org=bounce+64572+4996+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 163A9C433E8
	for <cip-dev@archiver.kernel.org>; Fri, 24 Jul 2020 13:29:45 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCF6D2065F
	for <cip-dev@archiver.kernel.org>; Fri, 24 Jul 2020 13:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="BpsNOXRv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCF6D2065F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mab-labs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4996+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id X4BWYY4521723xYqjUnwplm5; Fri, 24 Jul 2020 06:29:43 -0700
Subject: Re: [cip-dev] Resource describing the Deby workflow?
To: cip-dev@lists.cip-project.org
From: "Mohammed Billoo" <mab@mab-labs.com>
X-Originating-Location: Dumont, New Jersey, US (69.117.42.72)
X-Originating-Platform: Linux Firefox 78
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Fri, 24 Jul 2020 06:29:42 -0700
References: <20200724085829.GB28645@amd>
In-Reply-To: <20200724085829.GB28645@amd>
Message-ID: <8775.1595597382550569925@lists.cip-project.org>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: ZxmiGcTuUXVHWJj8hP1YhtCXx4520388AA=
Content-Type: multipart/mixed; boundary="g6DeluSfEv2A3Vn4FIbL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595597383;
 bh=WVbrCRyUP8q/a4f2RzdrZnbQt5TtIRjbvMP1yquNaGw=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=BpsNOXRvj/HQxk2+Zu3ENQdMq8VAuv1V1gZxEH/BR/lY0gLKEvCQ1gVif1uKI9AOaIe
 /X+e8i8bdLirFUUOG0XyHzE17c4qf9Aq+fCGFBXXJ8PThA5GYZBtxbacBvd/kaIqk2t39
 nyg0SEbduHvJCw65xiiianSAfAB6EPtj6NQ=

--g6DeluSfEv2A3Vn4FIbL
Content-Type: multipart/alternative; boundary="gxHPoeoZpYaQ1YGpXOpg"

--gxHPoeoZpYaQ1YGpXOpg
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Is tlsdate a better alternative?

--
Mohammed Billoo
MAB Labs, LLC
www.mab-labs.com

--gxHPoeoZpYaQ1YGpXOpg
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Is tlsdate a better alternative?<br /><br />-- <br />Mohammed Billoo<br />M=
AB Labs, LLC<br />www.mab-labs.com

--gxHPoeoZpYaQ1YGpXOpg--

--g6DeluSfEv2A3Vn4FIbL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4996): https://lists.cip-project.org/g/cip-dev/message=
/4996
Mute This Topic: https://lists.cip-project.org/mt/75736954/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--g6DeluSfEv2A3Vn4FIbL--
