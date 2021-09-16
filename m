Return-Path: <SRS0=VlhX=OG=lists.cip-project.org=bounce+64572+6741+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7290FC433EF
	for <cip-dev@archiver.kernel.org>; Thu, 16 Sep 2021 06:11:12 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03C71611C8
	for <cip-dev@archiver.kernel.org>; Thu, 16 Sep 2021 06:11:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 03C71611C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id fH79YY4521723xKRE6L8uDaj; Wed, 15 Sep 2021 23:11:11 -0700
X-Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web12.7507.1631772670327402960
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Sep 2021 23:11:11 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 18G6B6iO001143
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Thu, 16 Sep 2021 08:11:07 +0200
X-Received: from [167.87.38.101] ([167.87.38.101])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 18G6B6R1001533
	for <cip-dev@lists.cip-project.org>; Thu, 16 Sep 2021 08:11:06 +0200
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Subject: [cip-dev] CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Message-ID: <9b032547-c6df-a419-fedf-75e5ec8a93a8@siemens.com>
Date: Thu, 16 Sep 2021 08:11:06 +0200
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
X-Gm-Message-State: bcSXbvY1b0QX2e6XMlsfOgVhx4520388AA=
Content-Type: multipart/mixed; boundary="8i9gHEIASS1aHJu7n8EH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1631772671;
 bh=0G4qSj/ylog29JIjP2nvdCPHUr2nd23NxpLNepr93YU=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=ZId7PqiBaaSu1V4/Pvh4wDpMOL1YLacODuA34zVuN+cwGRWWlffeF+z7LNibK5oTeAm
 Uu8ilUbknW2rm53q2TUVSPMyLPLl3Z/1OpOuNcC+q7CfbEPFpFh0r84NBP2UgT8mEu4DE
 67+ME3zLd9wtnAMy0XP681y8np8M3cYRtAs=

--8i9gHEIASS1aHJu7n8EH
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

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2021&month=9&day=16&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     14:00     15:00     21:00     22:00

Last meeting minutes:

https://irclogs.baserock.org/meetings/cip/2021/09/cip.2021-09-09-13.02.log.txt

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


--8i9gHEIASS1aHJu7n8EH
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6741): https://lists.cip-project.org/g/cip-dev/message/=
6741
Mute This Topic: https://lists.cip-project.org/mt/85645942/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--8i9gHEIASS1aHJu7n8EH--
