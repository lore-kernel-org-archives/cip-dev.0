Return-Path: <SRS0=1gUt=BG=lists.cip-project.org=bounce+64572+5029+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8787FC433E3
	for <cip-dev@archiver.kernel.org>; Mon, 27 Jul 2020 14:25:22 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E819207FC
	for <cip-dev@archiver.kernel.org>; Mon, 27 Jul 2020 14:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="IP0dbhrH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E819207FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mab-labs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5029+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id dfWHYY4521723xGUl4ygxGAb; Mon, 27 Jul 2020 07:25:21 -0700
X-Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
 by mx.groups.io with SMTP id smtpd.web10.56841.1595859920372415699
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Jul 2020 07:25:20 -0700
X-Received: by mail-pf1-f172.google.com with SMTP id k18so1921051pfp.7
        for <cip-dev@lists.cip-project.org>; Mon, 27 Jul 2020 07:25:20 -0700 (PDT)
X-Gm-Message-State: tAoc1QAWdTMtGtdO936Jk9Kbx4520388AA=
X-Google-Smtp-Source: ABdhPJwQDGJoThqhvCpummhjzqks45MSKGc38y3qDl6ymLQY1vJWueMqkreKUrUKEiL62nnIg96qw1PKxjBCA2Ufse0=
X-Received: by 2002:aa7:8513:: with SMTP id v19mr19958780pfn.74.1595859919638;
 Mon, 27 Jul 2020 07:25:19 -0700 (PDT)
MIME-Version: 1.0
From: "Mohammed Billoo" <mab@mab-labs.com>
Date: Mon, 27 Jul 2020 10:25:08 -0400
Message-ID: <CALkjhPpZKd_qwAJhSdNTND_pLUv1LhnzKzRRRYxLCKP0-e+QpA@mail.gmail.com>
Subject: [cip-dev] CIP embedded platform Internet connection?
To: cip-dev@lists.cip-project.org
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="SSnqzX08y4VYPrEMgoSU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595859921;
 bh=pSOgnIqYEV0UV5wOhRE8cap27/x1gQGXdBxkvZgVFZo=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=IP0dbhrH9m1Wr49feWzyYqZSm0qLDI1Z5bO1QFFLvQqcQi/xR/c+C33sRaR14LWttwE
 PkQcoK+kl6JrLhBMbxyUJ0f+2wzAtVREZPYXjQqX11faobBviF/peK9kbNkyjYx9fHFRY
 7KPt5a9thEoz4jUkcAyD7wQnc23zt7JA9Rg=

--SSnqzX08y4VYPrEMgoSU
Content-Type: multipart/alternative; boundary="0000000000009f27bb05ab6d1795"

--0000000000009f27bb05ab6d1795
Content-Type: text/plain; charset="UTF-8"

Hi,

This question stems from the thread titled "The security of NTP". If we do
go with NTS, it looks like we're going to need an Internet connection to
the embedded platform. Is that acceptable? The work that I've seen so far
related to CIP SWUpdate has assumed that the Hawkbit server is on the local
network. It isn't obvious if that has been an intentional decision (due to
security requirements) or just to ease development.

-- 
Mohammed A Billoo
Founder
MAB Labs, LLC
www.mab-labs.com
201-338-2022

--0000000000009f27bb05ab6d1795
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>This question stems from=
 the thread titled &quot;The security of NTP&quot;. If we do go with NTS, i=
t looks like we&#39;re going to need an Internet connection to the embedded=
 platform. Is that acceptable? The work that I&#39;ve seen so far related t=
o CIP SWUpdate has assumed that the Hawkbit server is on the local network.=
 It isn&#39;t obvious if that has been an intentional decision (due to secu=
rity requirements) or just to ease development. <br></div><br>-- <br><div d=
ir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><di=
v dir=3D"ltr"><div>Mohammed A Billoo</div><div>Founder</div><div>MAB Labs, =
LLC</div><div><a href=3D"http://www.mab-labs.com" target=3D"_blank">www.mab=
-labs.com</a></div><div>201-338-2022<br></div></div></div></div>
<br>-- <br>Mohammed Billoo<br />MAB Labs, LLC<br />www.mab-labs.com

--0000000000009f27bb05ab6d1795--

--SSnqzX08y4VYPrEMgoSU
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5029): https://lists.cip-project.org/g/cip-dev/message=
/5029
Mute This Topic: https://lists.cip-project.org/mt/75823534/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--SSnqzX08y4VYPrEMgoSU--
