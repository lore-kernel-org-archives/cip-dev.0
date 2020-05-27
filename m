Return-Path: <SRS0=mQQJ=7J=lists.cip-project.org=bounce+64572+4647+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029C2C433E0
	for <cip-dev@archiver.kernel.org>; Wed, 27 May 2020 08:55:43 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A36AA20723
	for <cip-dev@archiver.kernel.org>; Wed, 27 May 2020 08:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="xEiUbAy9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A36AA20723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4647+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id dda5YY4521723xoe1kzVmxSO; Wed, 27 May 2020 01:55:42 -0700
X-Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web10.2273.1590569740857555731
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 May 2020 01:55:41 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 04R8tVMU030180
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 May 2020 10:55:32 +0200
X-Received: from [167.87.6.205] ([167.87.6.205])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 04R8tV10004431;
	Wed, 27 May 2020 10:55:32 +0200
Subject: Re: [cip-dev] FW: Needs of security patches on reference platforms
To: masashi.kudo@cybertrust.co.jp, cip-dev <cip-dev@lists.cip-project.org>
References: <TY2PR01MB497299162A4205C540691913A0B70@TY2PR01MB4972.jpnprd01.prod.outlook.com>
 <TY2PR01MB497220F7BDB51660FF9B221FA0B10@TY2PR01MB4972.jpnprd01.prod.outlook.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <e6529e13-4bb7-1105-9bc8-f84bc0b3132f@siemens.com>
Date: Wed, 27 May 2020 10:55:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <TY2PR01MB497220F7BDB51660FF9B221FA0B10@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: XiFuOowJTmzh5KBxSCSIxgEUx4520388AA=
Content-Type: multipart/mixed; boundary="XNWT224VMzOLubnriqtK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1590569742;
 bh=Dhi6prZvUYrRuB20HVN2wV3QqwiBq/DqKUFtmr9aKnw=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=xEiUbAy9h2GCB3IZi6CeczPMUOqR/etZ9fLqtalv6S/bN/uMpvzY8gju9t5l+PWQ04D
 llPcJxO9n9NQS6uHmEy0kZohRllOZND9fQyr5HRFMsTADfU59LItc/ZoZMoGXBxI/DPtZ
 kbFyWn0TmGyva048Tl/W7EqovplJovgFRzw=

--XNWT224VMzOLubnriqtK
Content-Type: text/plain; charset=iso-2022-jp
Content-Language: en-US
Content-Transfer-Encoding: 7bit

Hi Kudo-san,

On 27.05.20 10:34, masashi.kudo@cybertrust.co.jp wrote:
> Hello, Jan-san,
> 
> I wonder whether you can respond to the following query.
> If you know an appropriate person to answer the below, I would appreciate it if you can point him/her.

Just CC me on the list. I'm not receiving all emails of the list directly.

> 
> Best regards,
> --
> M. Kudo
> 
> -----Original Message-----
> From: 工藤　雅司（CTJ　OSS事業推進室） 
> Sent: Thursday, May 21, 2020 9:52 AM
> To: cip-dev@lists.cip-project.org
> Subject: Needs of security patches on reference platforms
> 
> Hi, board owners,
>  
> At the IRC meeting (May 14th), the following two security patches were discussed. 
> 
>  a. CVE related to KVM SVM on x86,
>  b. XDP sockets enabled for Cyclone V
> 
> They were recently ported to upstream, and we would like to decide whether they should be backported to CIP or not.

Why did not stable pick them up? Because they require active backporting
work to make them apply?

> 
> Regarding a., SVM is for AMD CPUs only, so it might not actually be used.
> If it is the case, we would like to ignore this patch.

In general, KVM on AMD was surely a niche over the past years. Since
Ryzen, this changed again, also for embedded.

That said, I'm not aware of active use on our side at this point, but I
may not have the full overview, and I can't speak for other members.

> 
> Regarding b., XDP (express data path) is used for network intensive workloads to bypass certain parts of the network stack So, it may be used by big tech / web stuff, not embedded.

XDP plays an essential role in deterministic networking, thus is
absolutely an embedded thing as well. But that usually goes along with
TSN, though it may not be limited to it.

For the Cyclone V, you likely need to ask the config contributor for the
concrete background.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

--XNWT224VMzOLubnriqtK
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4647): https://lists.cip-project.org/g/cip-dev/message=
/4647
Mute This Topic: https://lists.cip-project.org/mt/74496040/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--XNWT224VMzOLubnriqtK--
