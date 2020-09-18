Return-Path: <SRS0=UXm+=C3=lists.cip-project.org=bounce+64572+5465+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9798C43463
	for <cip-dev@archiver.kernel.org>; Fri, 18 Sep 2020 17:36:26 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2391721734
	for <cip-dev@archiver.kernel.org>; Fri, 18 Sep 2020 17:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="LxpzbrOI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2391721734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5465+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 38yPYY4521723xRY599ZJHP6; Fri, 18 Sep 2020 10:36:25 -0700
X-Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web12.2251.1600450583501270780
 for <cip-dev@lists.cip-project.org>;
 Fri, 18 Sep 2020 10:36:24 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 08IHaI4q005660
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2020 19:36:18 +0200
X-Received: from [139.22.39.21] ([139.22.39.21])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 08IHaGKt007524;
	Fri, 18 Sep 2020 19:36:16 +0200
Subject: Re: [cip-dev] Is CVE-2020-25284 backporting needed for 4.4-rt x86?
To: masashi.kudo@cybertrust.co.jp, cip-dev@lists.cip-project.org
References: <TY2PR01MB49720A7CA0EC8E349A473CFFA03F0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <3d774462-6c19-a68a-7101-0183c1c9467d@siemens.com>
Date: Fri, 18 Sep 2020 19:36:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <TY2PR01MB49720A7CA0EC8E349A473CFFA03F0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 5EPLqERGpM7tnjBmYkqwTDCpx4520388AA=
Content-Type: multipart/mixed; boundary="VdjEhKx49NjfnWC1V4hk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1600450585;
 bh=4cwF+mG84MmmIT5eAxixBRhX0C77WJgwDntFxEtu/mo=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=LxpzbrOI+t/qbS4iix5rPpZSy7etlQFUw0WNahM2ZRaplPoS0KF6v3/CMR83yMg7LRq
 dWKsJeev0f3ylYZf8PdUvxczu14QeVbQngkBIlcUEzY5BG7gOCBsMzBLtdwE3oObD4YQj
 +kO8dYVZJB0ohaFdYxTz05V5/b4wO3vTBRU=

--VdjEhKx49NjfnWC1V4hk
Content-Type: text/plain; charset=iso-2022-jp; format=flowed; delsp=yes
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 18.09.20 15:58, masashi.kudo@cybertrust.co.jp wrote:
> Hi, Jan-san, Siemens team,
> 
> There was some query to Siemens about the need of CVE-2020-25284 backporting.
> 
> - CVE-2020-25284 is in rbd ( Ceph block device ).
> - it is only fixed for v4.19 and later stable kernels
> - Siemens has this built as a module in their 4.4-rt x86 config, but not their 4.19 one
> 
> So the question from the Kernel Team is whether Siemens needs its backporting to 4.4-rt or not.
> 

Not to my best knowledge. This is very likely an accidental choice.

Is that the only config in our repo carrying rbd/ceph? The we should  
likely drop that, to be clear also in the future.

Jan

> Please take a look about the discussion at the IRC meeting yesterday.
> 
> https://irclogs.baserock.org/meetings/cip/2020/09/cip.2020-09-17-09.00.log.html
> 
> Best regards,
> --
> M. Kudo
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

--VdjEhKx49NjfnWC1V4hk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5465): https://lists.cip-project.org/g/cip-dev/message=
/5465
Mute This Topic: https://lists.cip-project.org/mt/76930681/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--VdjEhKx49NjfnWC1V4hk--
