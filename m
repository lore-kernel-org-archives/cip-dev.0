Return-Path: <SRS0=xsQm=6A=lists.cip-project.org=bounce+64572+4579+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C1DC2D0EF
	for <cip-dev@archiver.kernel.org>; Thu, 16 Apr 2020 07:22:03 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4279F214D8
	for <cip-dev@archiver.kernel.org>; Thu, 16 Apr 2020 07:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="pBXUfOgl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4279F214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4579+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id q1nTYY4521723xrvRG2fAlQJ; Thu, 16 Apr 2020 00:22:02 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web10.2069.1587021720626417249
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Apr 2020 00:22:02 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 03G7Lt7j013445; Thu, 16 Apr 2020 16:21:55 +0900
X-Iguazu-Qid: 34tr8v5ehKnqj2tj0B
X-Iguazu-QSIG: v=2; s=0; t=1587021714; q=34tr8v5ehKnqj2tj0B; m=zp2ynYFazJAZpppy1Jda4pSl9eUaaun+5+agrWjIrFQ=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1511) id 03G7Lsd2002819;
	Thu, 16 Apr 2020 16:21:54 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 03G7LrF2010495;
	Thu, 16 Apr 2020 16:21:53 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 03G7Lrn5013948;
	Thu, 16 Apr 2020 16:21:53 +0900
From: punit1.agrawal@toshiba.co.jp
To: "masashi.kudo\@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
Cc: <cip-dev@lists.cip-project.org>,
        Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
Subject: Re: [cip-dev] CIP IRC weekly meeting today
References: <TY2PR01MB497244C4E5B3D48167AFF5ADA0D80@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Date: Thu, 16 Apr 2020 16:21:52 +0900
In-Reply-To: <TY2PR01MB497244C4E5B3D48167AFF5ADA0D80@TY2PR01MB4972.jpnprd01.prod.outlook.com>
	(masashi's message of "Thu, 16 Apr 2020 02:02:49 +0000")
X-TSB-HOP: ON
Message-ID: <87r1wnuc8f.fsf@kokedama.swc.toshiba.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: jwePjYgih5vsJttCDyw2dLOix4520388AA=
Content-Type: multipart/mixed; boundary="XRDoiET9lip3J4pTUWmw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1587021722;
 bh=IOrCgxwg3LtTSkm9f57hPP1isYfh4tq/1TW98cd9mKY=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=pBXUfOglWSTVt/bYmE7O10EFDw9GDibyyw9TABuSblGpy2hsgyqvyg8jXrmOCbriK3p
 9R5C8EF/ZDGvIyk/kkqYf3EfjcnlDzRbPjkqXH6XR+JPo5m2G5xLf0s6OvY9RUk+W3ZuI
 LbxsY1Lojho3UslC5eKlE6+ZUs8SaS5hfrY=

--XRDoiET9lip3J4pTUWmw
Content-Type: text/plain

Hi Kudo-san,

I won't be able to attend the meeting today. Some updates below -

"masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp> writes:

[...]

> * CIP Core

- Discussion around projected EOL for CIP core support on cip-dev. Based
  on the comments in the TSC I will update the proposal to YYYY-MM
  format.
- Daniel to take over CIP Core activities going forward

Thanks,
Punit

[...]


--XRDoiET9lip3J4pTUWmw
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4579): https://lists.cip-project.org/g/cip-dev/message=
/4579
Mute This Topic: https://lists.cip-project.org/mt/73047683/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--XRDoiET9lip3J4pTUWmw--
