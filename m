Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21917C43334
	for <webhook@archiver.kernel.org>; Mon, 18 Jul 2022 09:04:11 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by mx.groups.io with SMTP id smtpd.web10.24793.1658135049300078802
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 Jul 2022 02:04:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=phobos-20191101 header.b=wIvz2+cG;
 spf=pass (domain: denx.de, ip: 85.214.62.61, mailfrom: pavel@denx.de)
Received: from mail-internal.denx.de (p578adb1c.dip0.t-ipconnect.de
 [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: noc@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 470C58118A
	for <cip-dev@lists.cip-project.org>; Mon, 18 Jul 2022 11:04:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1658135047;
	bh=d1TAr+C4LWbMqJOjynebxSbuhQjIHE5jig6CA8pVcJg=;
	h=Date:From:To:Subject:From;
	b=wIvz2+cGWLTHy19PwgKupEUGjV+3LCI6pOAbGHU7xWeuFX0+RPejHnth1eBSHs6Lq
	 //ExwFcCR//Qi8Axiudsr9ZVjwr3p0gzkqSB6ivpWgPa/WQbjT1JP3L+mHnxtJrWb0
	 1z/mKAq7YP8rgwdihqSvCV04NCikVQcA8l/GvopIw4ob5/1Fc34xVl0xltlhnJ2mNM
	 0bg5kVZONKkebgMsauj71m5pwGLt8UiebvF4iUdqoi4/6Z8SuIL52PJo0pYipiS75d
	 0swcLLAvczIrt6X+N8ojyjWFlySC7npcP9nrvCmIrqywV0OtNXxc34kRNoVUsdmJ5v
	 gyEI2JXMh75Yg==
Received: from pollux.denx.de (pollux [192.168.1.1])
	by mail-internal.denx.de (Postfix) with ESMTPS id E40161811A2
	for <cip-dev@lists.cip-project.org>; Mon, 18 Jul 2022 11:04:05 +0200 (CEST)
Received: by pollux.denx.de (Postfix, from userid 561)
	id C13261A8BA8; Mon, 18 Jul 2022 11:04:05 +0200 (CEST)
Date: Mon, 18 Jul 2022 11:04:05 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: 4.4 & my availability this week
Message-ID: <YtUiBYCvJvdgdiBS@pollux.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 18 Jul 2022 09:04:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8845

Hi!

It would not be bad to do 4.4 release this week, but Ill be traveling without internet 
access. 4.4-st tree and -cip trees are up-to-date with 4.9.320, with exceptions of random 
(and we should probably ignore those) and some TCP changes. I believe we can turn that 
into -cip release.

Best regards,
								Pavel

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

