Return-Path: <SRS0=l4gP=PC=lists.cip-project.org=bounce+64572+6823+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCB1C433EF
	for <cip-dev@archiver.kernel.org>; Thu, 14 Oct 2021 06:10:33 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1217261152
	for <cip-dev@archiver.kernel.org>; Thu, 14 Oct 2021 06:10:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1217261152
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id W4D4YY4521723x11riKQL7xH; Wed, 13 Oct 2021 23:10:32 -0700
X-Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web09.5574.1634191831340002076
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Oct 2021 23:10:32 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 19E6ASU5015128
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Thu, 14 Oct 2021 08:10:28 +0200
X-Received: from [167.87.2.42] ([167.87.2.42])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 19E6ARnF004158
	for <cip-dev@lists.cip-project.org>; Thu, 14 Oct 2021 08:10:28 +0200
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Subject: [cip-dev] CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Message-ID: <84786ae4-0286-050a-5206-770eae06edc6@siemens.com>
Date: Thu, 14 Oct 2021 08:10:27 +0200
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
X-Gm-Message-State: ULuFgziSuNzNXDHf9mbCBy1lx4520388AA=
Content-Type: multipart/mixed; boundary="tfrFP4kprkttJTEhAhfE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1634191832;
 bh=e1ClFfpLjIanTOjlKkmI3qoLAKOiu+sLJbK4GPOVw3A=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=wyrdhxPNp+1GeJjQizjsjaClA3ZHIFe8AXpURT3NrfWqToHCdHUFJBcWsox59B3J+36
 0OwzCwnXSKe2X4VR0lzHGR188j6j/o6brXmdKSlK9EXwfuTyKoEroReHp+zW1FImYTJ/D
 vXOVyoUUcSP1PCHsqFZ+zIdOdAhyDs9fiDA=

--tfrFP4kprkttJTEhAhfE
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

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2021&month=10&day=14&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     14:00     15:00     21:00     22:00

Last meeting minutes:

https://irclogs.baserock.org/meetings/cip/2021/10/cip.2021-10-07-13.01.log.html

* Action item
  1. Combine root filesystem with kselftest binary - iwamatsu & alicef
  2. Document new LAVA domains in wiki - patersonc
  3. Look into S3 artifact upload issues - patersonc
* Kernel maintenance updates
* Kernel testing
* AOB

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux


--tfrFP4kprkttJTEhAhfE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6823): https://lists.cip-project.org/g/cip-dev/message/=
6823
Mute This Topic: https://lists.cip-project.org/mt/86306600/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--tfrFP4kprkttJTEhAhfE--
