Return-Path: <SRS0=BeNl=AK=lists.cip-project.org=bounce+64572+4866+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45327C433E0
	for <cip-dev@archiver.kernel.org>; Mon, 29 Jun 2020 20:14:48 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7E3020760
	for <cip-dev@archiver.kernel.org>; Mon, 29 Jun 2020 20:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Ds4Mv4mV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7E3020760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4866+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id RCtAYY4521723x9kraLXunPI; Mon, 29 Jun 2020 13:14:47 -0700
X-Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web10.4517.1593461686176203130
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Jun 2020 13:14:47 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 05TKEhV1005933
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Mon, 29 Jun 2020 22:14:44 +0200
X-Received: from [167.87.72.204] ([167.87.72.204])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 05TKEgCP028930
	for <cip-dev@lists.cip-project.org>; Mon, 29 Jun 2020 22:14:43 +0200
To: cip-dev <cip-dev@lists.cip-project.org>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Subject: [cip-dev] VulnerableCode
Message-ID: <224f9930-c698-ee7f-4c32-b230f45ddf45@siemens.com>
Date: Mon, 29 Jun 2020 22:14:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: qf3sW3SiwmnMiZiHjbZyMUbkx4520388AA=
Content-Type: multipart/mixed; boundary="OrI1fEUPbQfr4TQcUdYz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1593461687;
 bh=YaTbTS/yf4DPVfKq9s8bQQ4CUeAnAUT4u8MlChrMgVA=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=Ds4Mv4mV/On5N3XqVNxCSgpkr0ZMs6Z0rkUnYDjqeNXnie+PCo/0KTXJh+VpVvU2kJe
 6l7qy7RIFd+xbLgtFITdyzBEPAiT+QAMEkB4PRxFzeAIermChuZSZZR1uo0aTn6laG30o
 ADy4rVyAetzWhs/to5Dv9NIrZpO6GdNge/A=

--OrI1fEUPbQfr4TQcUdYz
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

Hi all,

just a note after watching https://sched.co/c46p, 
https://github.com/nexB/vulnerablecode: Still early, but might be worth 
looking at if we can benefit from it for vulnerability management.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

--OrI1fEUPbQfr4TQcUdYz
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4866): https://lists.cip-project.org/g/cip-dev/message=
/4866
Mute This Topic: https://lists.cip-project.org/mt/75200121/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--OrI1fEUPbQfr4TQcUdYz--
