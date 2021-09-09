Return-Path: <SRS0=fncx=N7=lists.cip-project.org=bounce+64572+6721+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB640C433EF
	for <cip-dev@archiver.kernel.org>; Thu,  9 Sep 2021 07:14:16 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FD0260F13
	for <cip-dev@archiver.kernel.org>; Thu,  9 Sep 2021 07:14:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6FD0260F13
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 6qCZYY4521723xR01nafiwSq; Thu, 09 Sep 2021 00:14:16 -0700
X-Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web10.4107.1631170055674195449
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Sep 2021 23:47:36 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 1896lWem002806
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Thu, 9 Sep 2021 08:47:33 +0200
X-Received: from [167.87.244.119] ([167.87.244.119])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1896lWfU008427
	for <cip-dev@lists.cip-project.org>; Thu, 9 Sep 2021 08:47:32 +0200
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Subject: [cip-dev] CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Message-ID: <3f482ab5-6b7e-f847-ab75-b075954bec9b@siemens.com>
Date: Thu, 9 Sep 2021 08:47:31 +0200
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
X-Gm-Message-State: hevWdZwwTJzJhE2QrsiisE59x4520388AA=
Content-Type: multipart/mixed; boundary="3tznZtvwIizqfUVR12cr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1631171656;
 bh=WiySrAwSTletcav08j3te7wYRFRgdx6GuS9wVy/sfuQ=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=S7N1OT894K3yw6OBNW7G3J95fhdvz3eLtG6J8oQtmNqR/bO59Ofp/sRkjfAO/c9wepp
 xx+MHtE64+kEM8xtagbgOkrWbAIqrONCzTJqzWHuIDjXv8RFyhueElero9uFWHvD/U0oT
 azn0MwOE4XcmiS2nO/qPJC32UbAFjJrN1fE=

--3tznZtvwIizqfUVR12cr
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

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2021&month=9&day=9&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     14:00     15:00     21:00     22:00

Last meeting minutes:

https://irclogs.baserock.org/meetings/cip/2021/09/cip.2021-09-02-13.00.log.html

* Action item
  1. Combine root filesystem with kselftest binary - iwamatsu & alicef

* Kernel maintenance updates
* Kernel testing
* AOB

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--3tznZtvwIizqfUVR12cr
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6721): https://lists.cip-project.org/g/cip-dev/message/=
6721
Mute This Topic: https://lists.cip-project.org/mt/85478916/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--3tznZtvwIizqfUVR12cr--
