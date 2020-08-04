Return-Path: <SRS0=BQj4=BO=lists.cip-project.org=bounce+64572+5092+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6441C433DF
	for <cip-dev@archiver.kernel.org>; Tue,  4 Aug 2020 13:25:01 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EA042067D
	for <cip-dev@archiver.kernel.org>; Tue,  4 Aug 2020 13:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="jh3WpnkW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EA042067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5092+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id MDyIYY4521723xk5lVm8V351; Tue, 04 Aug 2020 06:25:00 -0700
X-Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web11.5149.1596547499363456343
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Aug 2020 06:25:00 -0700
X-Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 074DOulJ019463
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Tue, 4 Aug 2020 15:24:56 +0200
X-Received: from [167.87.19.206] ([167.87.19.206])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 074DOtJb007398;
	Tue, 4 Aug 2020 15:24:55 +0200
Subject: Re: [cip-dev] [isar-cip-core] remove remaining configs from isar-cip-core
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com
References: <20200804044724.629026-1-daniel.sangorrin@toshiba.co.jp>
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
Message-ID: <0eca9df0-675d-ab68-f199-d029f4d779aa@siemens.com>
Date: Tue, 4 Aug 2020 15:24:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200804044724.629026-1-daniel.sangorrin@toshiba.co.jp>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 1gQ4y2KzsDpNP5MTO7TONYUfx4520388AA=
Content-Type: multipart/mixed; boundary="wzLxOZXoZEipR6C1pqtb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1596547500;
 bh=8OY8vRGB0FOmpDoRi92trc5v1RnN9i6CTKlYhGa/jo0=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=jh3WpnkWGjvmeDRdHAr2BUQra6v1SJgVCL6BABGIzQ5ZdbPDTPrhabn/GRBsQB6JlDL
 MSGXnFNtwj5C+1Y1rj070Y1I47TttI/G9KtNxySW8OMZ3hHB3njLIM8b2Y3NAgarfwS4Q
 aUEIqW0jjUurD2FjJ/kY1jOj5LN2q/oxjYE=

--wzLxOZXoZEipR6C1pqtb
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit



On 8/4/20 6:47 AM, Daniel Sangorrin wrote:
> Hi Jan,
> 
> This patch just removes the already unused defconfigs from isar-cip-core
> 
> [isar-cip-core] kernel: remove configs that are already in
> 
> I didn't know what to do with bbb_defconfig because it does not seem to
> be used at all by isar-cip-core (maybe it is in a rather obscure way).
> However, that should also be removed and use cip_bbb_defconfig.
> 
> Thanks,
> Daniel
> 


In 
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/tree/cip-sw-updates/swupdate 
bbb is used as demo system.

Quirin


--wzLxOZXoZEipR6C1pqtb
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5092): https://lists.cip-project.org/g/cip-dev/message=
/5092
Mute This Topic: https://lists.cip-project.org/mt/75981585/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--wzLxOZXoZEipR6C1pqtb--
