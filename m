Return-Path: <SRS0=Bnu3=AL=lists.cip-project.org=bounce+64572+4873+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5698CC433E0
	for <cip-dev@archiver.kernel.org>; Tue, 30 Jun 2020 22:49:12 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3AEA2073E
	for <cip-dev@archiver.kernel.org>; Tue, 30 Jun 2020 22:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="NHy4oPsG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3AEA2073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mab-labs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4873+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id UxeJYY4521723x2JeHcIwqgm; Tue, 30 Jun 2020 15:49:11 -0700
X-Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
 by mx.groups.io with SMTP id smtpd.web10.9348.1593557349678355156
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jun 2020 15:49:10 -0700
X-Received: by mail-lj1-f177.google.com with SMTP id h19so24582260ljg.13
        for <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2020 15:49:09 -0700 (PDT)
X-Gm-Message-State: lEDYBCS0PrQ0XmS0RSiQaMg2x4520388AA=
X-Google-Smtp-Source: ABdhPJx7FR0rKe9dfskdGPAL90/9tytvYA3TkrHdgta++stG6LZGjA1k841Qgyvve/A6nq7QtE4dMQBnIBUzOuFAP+U=
X-Received: by 2002:a2e:80cc:: with SMTP id r12mr4183283ljg.344.1593557347423;
 Tue, 30 Jun 2020 15:49:07 -0700 (PDT)
MIME-Version: 1.0
From: "Mohammed Billoo" <mab@mab-labs.com>
Date: Tue, 30 Jun 2020 18:48:56 -0400
Message-ID: <CALkjhPqjz9E22YtzR+QkjmiMRE_w-jQdfgawmAsaZECfSLEgRQ@mail.gmail.com>
Subject: [cip-dev] Setting up SWUpdate
To: cip-dev@lists.cip-project.org
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="CMdi8FR6vSQwrVnjlpFJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1593557351;
 bh=YnQkKAs5JSfKJj/YGzhltqu+7DzuIGoJOF7QiqhPqIw=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=NHy4oPsGvUTl5UrP6i6O1Z8YQ3RT6Fz4ygjay71g/1U+4m0b/bgrjhLNEH51QVuxOrv
 ETwEjZcGx0TpUBtO68891veY1CWWaWtXRVac1uTqn3IpfWtE3sPTdiRmhA1mFrVIHS10t
 fmpP+aJicnph48JsKJhqrtzGITvtmlnaiNE=

--CMdi8FR6vSQwrVnjlpFJ
Content-Type: multipart/alternative; boundary="0000000000009f6af105a954fb89"

--0000000000009f6af105a954fb89
Content-Type: text/plain; charset="UTF-8"

Hello,

Should I be using the instructions outlined in
https://gitlab.com/cip-project/cip-sw-updates/cip-sw-updates-demo to run a
basic update of the CIP image on a BBB from hawkBit? Can the update process
be verified using hawkbit and/or the BBB?

Also, there looks to be a patchset to bring in swupdate to cip-core (
https://patchwork.kernel.org/project/cip-dev/list/?series=309741). Should I
wait for this patchset to be approved?

-- 
Mohammed A Billoo
Founder
MAB Labs, LLC
www.mab-labs.com
201-338-2022

--0000000000009f6af105a954fb89
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello,</div><div><br></div><div>Should I be using the=
 instructions outlined in <a href=3D"https://gitlab.com/cip-project/cip-sw-=
updates/cip-sw-updates-demo">https://gitlab.com/cip-project/cip-sw-updates/=
cip-sw-updates-demo</a> to run a basic update of the CIP image on a BBB fro=
m hawkBit? Can the update process be verified using hawkbit and/or the BBB?=
 <br></div><div><br></div><div>Also, there looks to be a patchset to bring =
in swupdate to cip-core (<a href=3D"https://patchwork.kernel.org/project/ci=
p-dev/list/?series=3D309741">https://patchwork.kernel.org/project/cip-dev/l=
ist/?series=3D309741</a>). Should I wait for this patchset to be approved?<=
/div><div><br></div><div>-- <br><div dir=3D"ltr" data-smartmail=3D"gmail_si=
gnature"><div dir=3D"ltr"><div>Mohammed A Billoo</div><div>Founder</div><di=
v>MAB Labs, LLC</div><div><a href=3D"http://www.mab-labs.com" target=3D"_bl=
ank">www.mab-labs.com</a></div><div>201-338-2022<br></div></div></div></div=
></div>
<br>-- <br>Mohammed Billoo<br />MAB Labs, LLC<br />www.mab-labs.com

--0000000000009f6af105a954fb89--

--CMdi8FR6vSQwrVnjlpFJ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4873): https://lists.cip-project.org/g/cip-dev/message=
/4873
Mute This Topic: https://lists.cip-project.org/mt/75224479/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--CMdi8FR6vSQwrVnjlpFJ--
