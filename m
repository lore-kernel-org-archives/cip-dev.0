Return-Path: <SRS0=u2LX=NY=lists.cip-project.org=bounce+64572+6714+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B04CC432BE
	for <cip-dev@archiver.kernel.org>; Thu,  2 Sep 2021 05:41:14 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58FFF60C3E
	for <cip-dev@archiver.kernel.org>; Thu,  2 Sep 2021 05:41:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 58FFF60C3E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id hlNTYY4521723xMs1Mr6P8w3; Wed, 01 Sep 2021 22:41:12 -0700
X-Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web12.3122.1630561271686072398
 for <cip-dev@lists.cip-project.org>;
 Wed, 01 Sep 2021 22:41:12 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 1825f8RV023306
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Thu, 2 Sep 2021 07:41:09 +0200
X-Received: from [167.87.3.52] ([167.87.3.52])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1825f8Mc003002
	for <cip-dev@lists.cip-project.org>; Thu, 2 Sep 2021 07:41:08 +0200
To: cip-dev <cip-dev@lists.cip-project.org>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Subject: [cip-dev] CIP IRC weekly meeting today on libera.chat
Message-ID: <ebfdd343-044b-9605-8785-9efbf1d258c3@siemens.com>
Date: Thu, 2 Sep 2021 07:41:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: BEcQdlRU7Lb8cMRIqUVGU1z0x4520388AA=
Content-Type: multipart/mixed; boundary="XwJKIeMZdclqbWOJ2EEW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1630561272;
 bh=spCx6M1qbE8hgCZ7k/kTNP5bni0IxtvWvIMKW1hvaxs=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=f9H9e7aeqfnXpY8pkJhiCJVWuevxeyqa5FcVBNV9LpxpwUTl0VIaY+G0K/h8EaoKcnF
 3CuSi3yr8C/L1NkBmOjAV67gfbfuRJeGsCfdcjk1IGCZ2bgktKC0+bsLj5c6sv3HA1CJV
 62ebyxc4lvFw1Uhs1OiK3QpamCfuNNw6RNU=

--XwJKIeMZdclqbWOJ2EEW
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today.

Please note that we moved from Freenode to libera.chat. Our channel is
the following:

    irc:irc.libera.chat:6667/cip

Furthermore note that the IRC meeting is now scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2021&month=9&day=2&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     14:00     15:00     21:00     22:00

Last meeting minutes:

https://irclogs.baserock.org/meetings/cip/2021/08/cip.2021-08-26-13.00.log.html

* Action item
  1. Combine root filesystem with kselftest binary - iwamatsu & alicef
  2. Do some experiment to lower burdens on CI - patersonc

* Kernel maintenance updates
* Kernel testing
* AOB

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--XwJKIeMZdclqbWOJ2EEW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6714): https://lists.cip-project.org/g/cip-dev/message/=
6714
Mute This Topic: https://lists.cip-project.org/mt/85321777/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--XwJKIeMZdclqbWOJ2EEW--
