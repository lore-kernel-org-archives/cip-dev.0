Return-Path: <gouravsingh@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DBCC5B572
	for <webhook@archiver.kernel.org>; Thu, 13 Aug 2026 17:44:36 +0000 (UTC)
Subject: Re: [isar-cip-core][PATCH] recipes-core: ltp: add python3 and jq runtime dependencies
To: cip-dev@lists.cip-project.org
From: "Gourav Singh" <gouravsingh@siemens.com>
X-Originating-Location: Chennai, Tamil Nadu, IN (167.103.7.17)
X-Originating-Platform: Windows Edge 151
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Thu, 13 Aug 2026 10:44:26 -0700
References: <20260813125157.877874-1-gouravsingh@siemens.com> <a14d818d-2cf6-45cc-9b10-8287842bfc9e@siemens.com>
In-Reply-To: <a14d818d-2cf6-45cc-9b10-8287842bfc9e@siemens.com>
Message-ID: <1489334.1786643066406456029@lists.cip-project.org>
Content-Type: multipart/alternative; boundary="lB3ej9mrKUX2Z0E20Wrq"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Aug 2026 17:44:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23932

--lB3ej9mrKUX2Z0E20Wrq
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Jan,

Thanks for the review.

This is not a long-pending generic issue.

With the latest LTP version (20260529), runltp is deprecated and the recomm=
ended LTP runner is kirk [1]. Since kirk is Python-based, python3 is requir=
ed to execute it. jq is needed for parsing/inspection of JSON reports produ=
ced by kirk, so this patch adds both as runtime dependencies.
[1]: Release LTP 20260529 =C2=B7 linux-test-project/ltp ( https://github.co=
m/linux-test-project/ltp/releases/tag/20260529 )

Also, thanks for pointing out the list delivery issue. I=E2=80=99ll check m=
y send-email setup/logs and resend so it properly reaches cip-dev.

Best regards,

--lB3ej9mrKUX2Z0E20Wrq
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>Hi Jan,<br /><br />Thanks for the review.<br /><br />This is not a lon=
g-pending generic issue.<br /><br />With the latest LTP version (20260529),=
 runltp is deprecated and the recommended LTP runner is kirk [1]. Since kir=
k is Python-based, python3 is required to execute it. jq is needed for pars=
ing/inspection of JSON reports produced by kirk, so this patch adds both as=
 runtime dependencies.<br />[1]: &nbsp;<a href=3D"https://github.com/linux-=
test-project/ltp/releases/tag/20260529">Release LTP 20260529 &middot; linux=
-test-project/ltp</a><br /><br />Also, thanks for pointing out the list del=
ivery issue. I&rsquo;ll check my send-email setup/logs and resend so it pro=
perly reaches cip-dev.<br /><br />Best regards,</div>

--lB3ej9mrKUX2Z0E20Wrq--

