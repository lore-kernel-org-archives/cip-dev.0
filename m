Return-Path: <SRS0=BLSM=AT=lists.cip-project.org=bounce+64572+4911+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCD4C433E0
	for <cip-dev@archiver.kernel.org>; Wed,  8 Jul 2020 21:06:10 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50869206E9
	for <cip-dev@archiver.kernel.org>; Wed,  8 Jul 2020 21:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="wure09th"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50869206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mab-labs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4911+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id DKTsYY4521723xJm7G8ZTYZ4; Wed, 08 Jul 2020 14:06:10 -0700
Subject: Re: [cip-dev] Hawkbit docker image: Amqp connection refused
To: cip-dev@lists.cip-project.org
From: "Mohammed Billoo" <mab@mab-labs.com>
X-Originating-Location: Dumont, New Jersey, US (69.117.42.72)
X-Originating-Platform: Linux Firefox 78
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Wed, 08 Jul 2020 14:06:09 -0700
References: <CALkjhPoyD6ZLG7-OZWYTDy6veyG75KGvWivUYjGPSiswPAVMBQ@mail.gmail.com>
In-Reply-To: <CALkjhPoyD6ZLG7-OZWYTDy6veyG75KGvWivUYjGPSiswPAVMBQ@mail.gmail.com>
Message-ID: <11423.1594242369291447337@lists.cip-project.org>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: hD6n3amhDA2iEWktQc0now9Lx4520388AA=
Content-Type: multipart/mixed; boundary="LWGTG7wJTA2Blexql4Ci"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1594242370;
 bh=GodYsPmjPYLOTIPFdOMtaa4JdyysUNWucolWWLoEXDY=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=wure09thLQihkQkE11EaUXui3pg82jNBqloo0KXWXUicx4+TS2lXHY8lyDNEG/XVjYO
 SPNnR0ZkQfiSw/VQ80i8QUoR+gMsIDh9+Y5CU1GJLJWsIM4E13YEdZD7sAOqhNo0Gl4PG
 2vwFl9K7Cvgi/OLrUBCFes1qSIKPVfpDfoQ=

--LWGTG7wJTA2Blexql4Ci
Content-Type: multipart/alternative; boundary="PLZ1YBO5mavnSulBJs6y"

--PLZ1YBO5mavnSulBJs6y
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

I should clarify that I'm following the instructions in the cip-sw-updates/=
cip-sw-updates-demo repo.

--
Mohammed Billoo
MAB Labs, LLC
www.mab-labs.com

--PLZ1YBO5mavnSulBJs6y
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

I should clarify that I'm following the instructions in the cip-sw-updates/=
cip-sw-updates-demo repo.<br /><br />-- <br />Mohammed Billoo<br />MAB Labs=
, LLC<br />www.mab-labs.com

--PLZ1YBO5mavnSulBJs6y--

--LWGTG7wJTA2Blexql4Ci
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4911): https://lists.cip-project.org/g/cip-dev/message=
/4911
Mute This Topic: https://lists.cip-project.org/mt/75385668/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--LWGTG7wJTA2Blexql4Ci--
