Return-Path: <florian.bezdeka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251DAD18130
	for <webhook@archiver.kernel.org>; Mon, 14 Oct 2024 16:35:17 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web10.1640.1728923712252579915
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Oct 2024 09:35:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=florian.bezdeka@siemens.com header.s=fm2 header.b=IT/+p7jh;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-68982-202410141635089a542c344f0aa413ac-k60zwh@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202410141635089a542c344f0aa413ac
        for <cip-dev@lists.cip-project.org>;
        Mon, 14 Oct 2024 18:35:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=vFaTCjsqmMBCJg1g9rXPx4LSaMkS2oqWh6XkJIbFOUM=;
 b=IT/+p7jh0Pj8Z153UbhNABb9OlluFfByfPd5LhDFlNN1/HkD+eoC30o4Qan+O0nZ5mTIB8
 LuUAZV16J+mw4EqlmTn/R8I0Gfd9jCt09Q8+a09e2tth2NrpqfHSWqek04t84Y8x9cJFKUmI
 dRM2hER3EW4Q8kPxtAP5uxf25y6Z7apobBR4p1pFaeSgdq+3UWB3kyZh3uedbf6IMQj1sZfl
 JfrT37185LCTkhq3I8IQlhasbRWfqodSbv9euu12UsMgo/jNUd3pnQlW3EmHcNAwscDulGux
 OMZmBXJNj/T7g24oNRl++SJaneb1yF027MstF06tVt+HM4nHck2OXwIA==;
Message-ID: <8e39db0082a1279609fbd3d9ceb60ed3abc1c1bf.camel@siemens.com>
Subject: Re: [cip-dev] [isar-cip-core][PATCH] distro: add preliminary
 support for the upcoming Debian 13 (trixie)
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Cedric Hombourger <cedric.hombourger@siemens.com>
Date: Mon, 14 Oct 2024 18:35:05 +0200
In-Reply-To: <20241014155604.569003-1-cedric.hombourger@siemens.com>
References: <20241014155604.569003-1-cedric.hombourger@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Oct 2024 16:35:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17035

On Mon, 2024-10-14 at 17:56 +0200, cedric.hombourger@siemens.com via
lists.cip-project.org wrote:
> Debian will probably start freezing packages next year (first a soft free=
ze
> then a hard freeze). It is important that the CIP community starts testin=
g
> Debian 13 to provide feedback upstream while we may still influence versi=
ons
> that the distribution will select for their new major version.
>=20
> Signed-off-by: Cedric Hombourger <cedric.hombourger@siemens.com>

Might be a bit to early. Expect build failures for any kind of cross
builds. Package versions (at least for glibc) are currently out of
sync.

