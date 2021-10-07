Return-Path: <SRS0=SMto=O3=lists.cip-project.org=bounce+64572+6801+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD014C433FE
	for <cip-dev@archiver.kernel.org>; Thu,  7 Oct 2021 06:38:19 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61A8861076
	for <cip-dev@archiver.kernel.org>; Thu,  7 Oct 2021 06:38:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 61A8861076
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 0xBxYY4521723xHzEvfGnuBR; Wed, 06 Oct 2021 23:38:19 -0700
X-Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web11.8186.1633588697792316006
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Oct 2021 23:38:18 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 1976cD6E022511
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Thu, 7 Oct 2021 08:38:14 +0200
X-Received: from [167.87.4.198] ([167.87.4.198])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1976cD8d026362
	for <cip-dev@lists.cip-project.org>; Thu, 7 Oct 2021 08:38:13 +0200
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Subject: [cip-dev] CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Message-ID: <c84315d9-d373-df23-6671-29c4a327a45d@siemens.com>
Date: Thu, 7 Oct 2021 08:38:13 +0200
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
X-Gm-Message-State: bC6wVhbgD30qrLRZ3u4OaJkex4520388AA=
Content-Type: multipart/mixed; boundary="Yeii7qHQ1dYISZ2crZEB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1633588699;
 bh=HQSsOg5eSmN59wXuOJKrerCUj8urNn1QtoJEIBiZc7U=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=U84O51O1UOnfBplTj0HUQa2wQxOzMu3EBUuJg3b8A35FBXFbievCsYl+/qsHGaZ7JRK
 ELSfXZ8dQaK7KTV/cvKok7q221WOq2f4FX73f68erkMlGn2uEONXsXaxOUIUFT3dq51Hl
 mP8H+tBo53dvVSYYDJNH3MSgg0uoLRMdDlE=
Message-ID: <20211007063813.j-UpoKBl6HGL6NPiDe99bDFxJ1NaYUWJ-676mQ-EG9c@z>

--Yeii7qHQ1dYISZ2crZEB
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

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2021&month=10&day=7&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     14:00     15:00     21:00     22:00

Last meeting minutes:

https://irclogs.baserock.org/meetings/cip/2021/09/cip.2021-09-30-13.00.log.html

* Action item
  1. Combine root filesystem with kselftest binary - iwamatsu & alicef
  2. Document new LAVA domains in wiki - patersonc
* Kernel maintenance updates
* Kernel testing
* AOB

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--Yeii7qHQ1dYISZ2crZEB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6801): https://lists.cip-project.org/g/cip-dev/message/=
6801
Mute This Topic: https://lists.cip-project.org/mt/86139189/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--Yeii7qHQ1dYISZ2crZEB--
