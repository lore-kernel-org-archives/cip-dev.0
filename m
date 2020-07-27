Return-Path: <SRS0=h9wK=BG=lists.cip-project.org=bounce+64572+5019+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDC4C433DF
	for <cip-dev@archiver.kernel.org>; Mon, 27 Jul 2020 11:32:30 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E17A420663
	for <cip-dev@archiver.kernel.org>; Mon, 27 Jul 2020 11:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="IAGrSB5d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E17A420663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mab-labs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5019+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id os3vYY4521723xYJ6hjnDTdI; Mon, 27 Jul 2020 04:32:29 -0700
Subject: Re: [cip-dev] The security of NTP
To: cip-dev@lists.cip-project.org
From: "Mohammed Billoo" <mab@mab-labs.com>
X-Originating-Location: Dumont, New Jersey, US (69.117.42.72)
X-Originating-Platform: Linux Firefox 78
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Mon, 27 Jul 2020 04:32:28 -0700
References: <OSBPR01MB2053682B08257AC2230531FDD0720@OSBPR01MB2053.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB2053682B08257AC2230531FDD0720@OSBPR01MB2053.jpnprd01.prod.outlook.com>
Message-ID: <7438.1595849548430257093@lists.cip-project.org>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: yI9WiYgf0vOA5P1dEjCyEzowx4520388AA=
Content-Type: multipart/mixed; boundary="r0us3TkU0qdVPpzbbPDo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595849549;
 bh=xaUZxWg74WWZrOcH6JHfIke+Qw9KJE/r/rgOGfhFfAI=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=IAGrSB5dMcb/Odslo0YBSEw207rNuCzkvL7eJeOP1fc7RAeoC5lHNZjmCwpZpRxSnD+
 CMKCUXgYqsDRm4/9BlPUlWcewVNZUqEgtRCLD5ZxWNNvS2ApJ2ClhM/stS/kqzrmLGIoV
 REBbHLIK8lIUsscoMMhUpszWkc6wA27LH38=

--r0us3TkU0qdVPpzbbPDo
Content-Type: multipart/alternative; boundary="ucOtfsJqQvNJFogqgDHr"

--ucOtfsJqQvNJFogqgDHr
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Daniel, Pavel:

Thanks for the feedback. Is tlsdate a better alternative ( https://github.=
com/ioerror/tlsdate/ )? The only caveat if using tlsdate (or any sort of ti=
me mechanism that relies on a "well-known" server) is that an Internet conn=
ection is necessary. It isn't obvious to me whether this is acceptable or n=
ot. Can someone chime in?

Thanks
--
Mohammed Billoo
MAB Labs, LLC
www.mab-labs.com

--ucOtfsJqQvNJFogqgDHr
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Daniel, Pavel:<br /><br />Thanks for the feedback. Is tlsdate a better alte=
rnative (<a href=3D"https://github.com/ioerror/tlsdate/" target=3D"_blank" =
rel=3D"noopener">https://github.com/ioerror/tlsdate/</a>)? The only caveat =
if using tlsdate (or any sort of time mechanism that relies on a "well-know=
n" server) is that an Internet connection is necessary. It isn't obvious to=
 me whether this is acceptable or not. Can someone chime in?<br /><br />Tha=
nks<br />-- <br />Mohammed Billoo<br />MAB Labs, LLC<br />www.mab-labs.com

--ucOtfsJqQvNJFogqgDHr--

--r0us3TkU0qdVPpzbbPDo
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5019): https://lists.cip-project.org/g/cip-dev/message=
/5019
Mute This Topic: https://lists.cip-project.org/mt/75814887/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--r0us3TkU0qdVPpzbbPDo--
