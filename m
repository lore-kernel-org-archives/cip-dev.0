Return-Path: <SRS0=KH4w=AN=lists.cip-project.org=bounce+64572+4880+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF7BC433DF
	for <cip-dev@archiver.kernel.org>; Thu,  2 Jul 2020 08:24:53 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA72420720
	for <cip-dev@archiver.kernel.org>; Thu,  2 Jul 2020 08:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="S2C9efRz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA72420720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4880+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Fk4sYY4521723xCzhiKiETRG; Thu, 02 Jul 2020 01:24:52 -0700
X-Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web11.2225.1593678291035637660
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Jul 2020 01:24:51 -0700
X-Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 0628OlVJ014864
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Jul 2020 10:24:47 +0200
X-Received: from [167.87.25.4] ([167.87.25.4])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 0628Ok0f008884;
	Thu, 2 Jul 2020 10:24:46 +0200
Subject: Re: [cip-dev] Working on HTTPS connection
To: cip-dev@lists.cip-project.org, mab@mab-labs.com
References: <CALkjhPpsdM8ZoC4QcT1EL8iQob4-pj3MWkesEvnNEFBOZ6LVOw@mail.gmail.com>
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
Message-ID: <3e827924-5e07-2d2f-c714-7290b9574ab8@siemens.com>
Date: Thu, 2 Jul 2020 10:24:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CALkjhPpsdM8ZoC4QcT1EL8iQob4-pj3MWkesEvnNEFBOZ6LVOw@mail.gmail.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: XLyat4rBPPIa7Q8LUaHnOFXtx4520388AA=
Content-Type: multipart/mixed; boundary="BpM1GCFvsMQswZhQrtZH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1593678292;
 bh=GE1MGto9ta8T+GNS/PBFDzcxkc/cgOBt4fk8FTHceYY=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=S2C9efRzJbpgKt3UVo25ABoTUsqf/2iYH3QtW+/qVoBTEsjSzFXeuBDFtNhnQ6auJ1G
 Pr2T5jGFvmJHt0BIQHu896Xprv8f8BXG4yvR4minY20TINLnkguMH06UPWd6ZZbHZp4SG
 3nrQh54kN6ekW+KwzNj/3kIBfs2F3HgqqDU=

--BpM1GCFvsMQswZhQrtZH
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit



On 6/29/20 6:57 PM, Mohammed Billoo wrote:
> Hello!
> 
> I joined the mailing list from the recommendation on the IRC channel 
> (after viewing the CIP talk at ELC). I'd like to work on the following 
> issue: 
> https://gitlab.com/cip-project/cip-sw-updates/cip-sw-updates-tasks/-/issues/8
> 
> I've written applications + drivers for u-boot, have worked on SSL 
> (albeit for Amazon FreeRTOS), and have HW handy to hit the ground 
> running (I have a DE1-SoC).
> 
> Is there any update on this task that should I be aware of?
> 

Hi,

if you add the following elements to the swupdate build config. HTTPS 
works more or less. I did not test it in all configurations, only for a 
short demo. And some of the options may not be necessary.

...
CONFIG_CURL=y
CONFIG_CURL_SSL=y
CONFIG_SSL_IMPL_OPENSSL=y
CONFIG_DOWNLOAD=y
CONFIG_DOWNLOAD_SSL=y
CONFIG_CHANNEL_CURL=y
CONFIG_CHANNEL_CURL_SSL=y
CONFIG_SURICATTA=y
CONFIG_SURICATTA_STATE_CHOICE_NONE=y
CONFIG_SURICATTA_HAWKBIT=y
CONFIG_SURICATTA_SSL=y
CONFIG_HASH_VERIFY=y
CONFIG_JSON=y
...

Quirin

> Looking forward to contributing to this project!
> 
> -- 
> Mohammed A Billoo
> Founder
> MAB Labs, LLC
> www.mab-labs.com <http://www.mab-labs.com>
> 201-338-2022
> 
> -- 
> Mohammed Billoo
> MAB Labs, LLC
> www.mab-labs.com
> 

-- 
Quirin

--BpM1GCFvsMQswZhQrtZH
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4880): https://lists.cip-project.org/g/cip-dev/message=
/4880
Mute This Topic: https://lists.cip-project.org/mt/75196049/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--BpM1GCFvsMQswZhQrtZH--
