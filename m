Return-Path: <SRS0=rHKy=BC=lists.cip-project.org=bounce+64572+4987+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1075EC433E1
	for <cip-dev@archiver.kernel.org>; Thu, 23 Jul 2020 12:48:02 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 911D622B47
	for <cip-dev@archiver.kernel.org>; Thu, 23 Jul 2020 12:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Ir4YK+OA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 911D622B47
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mab-labs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4987+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 54D8YY4521723xljm1TeSnir; Thu, 23 Jul 2020 05:48:01 -0700
Subject: [cip-dev] Resource on Debt workflow?
To: cip-dev@lists.cip-project.org
From: "Mohammed Billoo" <mab@mab-labs.com>
X-Originating-Location: Newark, New Jersey, US (172.58.236.52)
X-Originating-Platform: Android Phone Chrome 83
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Thu, 23 Jul 2020 05:48:00 -0700
Message-ID: <8I6k.1595508480388680654.KVuI@lists.cip-project.org>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 3ioJueTFKcp7A9JMAEtLDlQVx4520388AA=
Content-Type: multipart/mixed; boundary="D8w3pIsx0W7eIpz6JVYM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595508481;
 bh=DI8NHsqsXJdh8miKn6T3diAKzUGIpuAA7Z9S7EkCt0I=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=Ir4YK+OAcnix1guFErN8pQf9herpo5VCXXQi6vgwSckfUtbpRuxiJ7QRBW639ZdtgHF
 6hwvY4D9tSExSY0RiyRTHdkDqWqTydEwCn9AVCznVo07uN/32aO5WGXZV6Zo4/clYn9s6
 FTZ+J6XBeedrH9qdNmdnN6pqN3iU37XdP9I=

--D8w3pIsx0W7eIpz6JVYM
Content-Type: multipart/alternative; boundary="KRAgz1jQudrLcZVPEkoI"

--KRAgz1jQudrLcZVPEkoI
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I'm almost done getting SSL working between the BBB and hawkbit. The last =
piece of the puzzle is to get NTP working on the BBB (since I need valid ti=
me to ensure that the server certificate is valid). Unfortunately, I'm havi=
ng a hard time understanding the proper way to add utilities or modify conf=
igurations in Deby. It's similar enough to Yocto where I tried creating bba=
ppend recipes and failed miserably. I stumbled upon successfully adding ope=
nssl to the rfs, but don't know why it worked. Can anybody point me to a go=
od resource that can describe the proper Deby workflow?

As an example, I want to install NTP and then modify its configuration so =
that it points to the hawkbit server.

Thanks
--
Mohammed Billoo
MAB Labs, LLC
www.mab-labs.com

--KRAgz1jQudrLcZVPEkoI
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div style=3D"color: #000000; font-family: sans-serif; font-size: 12.8px;">=
Hi,</div>
<div style=3D"color: #000000; font-family: sans-serif; font-size: 12.8px;"=
>&nbsp;</div>
<div style=3D"color: #000000; font-family: sans-serif; font-size: 12.8px;"=
>I'm almost done getting SSL working between the BBB and hawkbit. The last =
piece of the puzzle is to get NTP working on the BBB (since I need valid ti=
me to ensure that the server certificate is valid). Unfortunately, I'm havi=
ng a hard time understanding the proper way to add utilities or modify conf=
igurations in Deby. It's similar enough to Yocto where I tried creating bba=
ppend recipes and failed miserably. I stumbled upon successfully adding ope=
nssl to the rfs, but don't know why it worked. Can anybody point me to a go=
od resource that can describe the proper Deby workflow?</div>
<div style=3D"color: #000000; font-family: sans-serif; font-size: 12.8px;"=
>&nbsp;</div>
<div style=3D"color: #000000; font-family: sans-serif; font-size: 12.8px;"=
>As an example, I want to install NTP and then modify its configuration so =
that it points to the hawkbit server.</div>
<div style=3D"color: #000000; font-family: sans-serif; font-size: 12.8px;"=
>&nbsp;</div>
<div style=3D"color: #000000; font-family: sans-serif; font-size: 12.8px;"=
>Thanks</div>
-- <br />Mohammed Billoo<br />MAB Labs, LLC<br />www.mab-labs.com

--KRAgz1jQudrLcZVPEkoI--

--D8w3pIsx0W7eIpz6JVYM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4987): https://lists.cip-project.org/g/cip-dev/message=
/4987
Mute This Topic: https://lists.cip-project.org/mt/75744690/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--D8w3pIsx0W7eIpz6JVYM--
