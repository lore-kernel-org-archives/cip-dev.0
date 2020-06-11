Return-Path: <SRS0=b8i0=7Y=lists.cip-project.org=bounce+64572+4794+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D039C433E0
	for <cip-dev@archiver.kernel.org>; Thu, 11 Jun 2020 11:24:06 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACA02207C3
	for <cip-dev@archiver.kernel.org>; Thu, 11 Jun 2020 11:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="v7yJFV13"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACA02207C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4794+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id XqBeYY4521723xcASVS8Pl7G; Thu, 11 Jun 2020 04:24:05 -0700
X-Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 by mx.groups.io with SMTP id smtpd.web12.5205.1591874642958450260
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Jun 2020 04:24:03 -0700
X-Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 49jM1s1jZcz1rsMj
	for <cip-dev@lists.cip-project.org>; Thu, 11 Jun 2020 13:24:01 +0200 (CEST)
X-Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
	by mail.m-online.net (Postfix) with ESMTP id 49jM1s0Q9dz1qqkW
	for <cip-dev@lists.cip-project.org>; Thu, 11 Jun 2020 13:24:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
X-Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
	with ESMTP id U7ixIsKt9vXA for <cip-dev@lists.cip-project.org>;
	Thu, 11 Jun 2020 13:24:00 +0200 (CEST)
X-Auth-Info: OCXPAYnuowhy/pj316YMq/UKdZEHczTOjNChsNzpi3M=
X-Received: from mail-internal.denx.de (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA
	for <cip-dev@lists.cip-project.org>; Thu, 11 Jun 2020 13:24:00 +0200 (CEST)
X-Received: from pollux.denx.de (pollux [192.168.1.1])
	by mail-internal.denx.de (Postfix) with ESMTP id 06241186141
	for <cip-dev@lists.cip-project.org>; Thu, 11 Jun 2020 13:23:59 +0200 (CEST)
X-Received: by pollux.denx.de (Postfix, from userid 561)
	id D720D1A8BDD; Thu, 11 Jun 2020 13:23:58 +0200 (CEST)
Date: Thu, 11 Jun 2020 13:23:58 +0200
From: "Pavel Machek" <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] CIP IRC weekly meeting today
Message-ID: <20200611112358.GA1148998@pollux.denx.de>
References: <TY2PR01MB49724F8BC9AB8EF4DBB23A7DA0830@TY2PR01MB4972.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <TY2PR01MB49724F8BC9AB8EF4DBB23A7DA0830@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: AnVEuL2R08IFH98s3PFZLylmx4520388AA=
Content-Type: multipart/mixed; boundary="LJ3mC5dtLoZyejsmfR3t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591874645;
 bh=c6vUvCH1WY8zmm9ipIctoNIpoqKmdkdOSE22MyUFy8s=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=v7yJFV13BBpr+AHfdVN+TQrLe7Jj8qRxMHa/tJP5bPXN8EhyuVHDWqM4DfOR0u0SjuO
 bKgW7GLaqlOV+yZl/GyZy3wzHwCRvS5u0oZRnvRAQexvlNAfRBmTd1dqb5ziNgf83v895
 V3mkopylysTpNgh5zYH9bem/cy/XR4egoOo=

--LJ3mC5dtLoZyejsmfR3t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!


> Kindly be reminded to attend the weekly meeting through IRC to discuss technical topics with CIP kernel today.
> 

I'm sorry I missed the meeting. I'll go	through	the IRC	logs.

My activity last week: reviews on 4.19.127 and patches queued for 4.19.128.

Best regards,
     								Pavel


--LJ3mC5dtLoZyejsmfR3t
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4794): https://lists.cip-project.org/g/cip-dev/message=
/4794
Mute This Topic: https://lists.cip-project.org/mt/74808947/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--LJ3mC5dtLoZyejsmfR3t--
