Return-Path: <SRS0=R1Aq=7J=lists.cip-project.org=bounce+64572+4646+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867A5C433DF
	for <cip-dev@archiver.kernel.org>; Wed, 27 May 2020 08:28:11 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FBF82084C
	for <cip-dev@archiver.kernel.org>; Wed, 27 May 2020 08:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="dL0TmQas"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FBF82084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4646+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id zc0NYY4521723xU5ZGb4lQrH; Wed, 27 May 2020 01:28:10 -0700
X-Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web10.1977.1590568088937236992
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 May 2020 01:28:09 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 04R8Roj4027730
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 May 2020 10:27:50 +0200
X-Received: from [167.87.6.205] ([167.87.6.205])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 04R8RmxV031900;
	Wed, 27 May 2020 10:27:49 +0200
Subject: Re: [cip-dev] [ANNOUNCE] v4.19.120-cip25-rt10
To: Pavel Machek <pavel@denx.de>
Cc: Angelo Compagnucci <angelo.compagnucci@gmail.com>,
        cip-dev@lists.cip-project.org, SZ.Lin@moxa.com,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Chris.Paterson2@renesas.com
References: <20200511150426.GA18173@duo.ucw.cz>
 <CA+TH9Vm8dN918_yu0reQCHzh7hu62F8SefD96tx5T_XrEy634g@mail.gmail.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <94f92587-9b2e-1b1e-021b-348aa16e1463@siemens.com>
Date: Wed, 27 May 2020 10:27:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CA+TH9Vm8dN918_yu0reQCHzh7hu62F8SefD96tx5T_XrEy634g@mail.gmail.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: frbeWtPMo2x3BwRuv4gPHJ9Ix4520388AA=
Content-Type: multipart/mixed; boundary="6PI7V1B5cNf6JO6tGMAe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1590568090;
 bh=umVIG9DyviOtWHBFVBkOReOWtmyJVd1jxJHaeYZUquY=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=dL0TmQasZx5kL2+TiwCTy181wznKLq/AH9ijTJZEEuKaSoPhjl6S8+Op2M6HSAc94Du
 zTeU71qF8VY+TJuZi9EDYrJ+lbESH115MlKKlvCpG24Aq4GfAbq2DER/y9DJAv1SFHvy3
 50jJncXqW/XzD9gLDujR84klFVDSq/3DUYQ=

--6PI7V1B5cNf6JO6tGMAe
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 16.05.20 15:45, Angelo Compagnucci wrote:
> Il giorno lun 11 mag 2020 alle ore 17:04 Pavel Machek <pavel@ucw.cz> ha scritto:
>>
>> Hi!
>>
>> v4.19.120-cip25-rt10 should be available at kernel.org. (-cip26 was
>> not available when I started the -rt update, thus it is based on
>> -cip25 patches forward ported to 4.19.120. There should not be big
>> difference besides the version number.)
>>
>> Trees are available at
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.19.y-cip-rt
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.19.y-cip-rt-rebase
>>
>> And their content should be identical.
> 
> Tag 4.19.120-cip25-rt10 doesn't seem to be there (only
> v4.19.120-cip25-rt10-rebase)
> 

Pavel, please fix!

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

--6PI7V1B5cNf6JO6tGMAe
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4646): https://lists.cip-project.org/g/cip-dev/message=
/4646
Mute This Topic: https://lists.cip-project.org/mt/74137657/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--6PI7V1B5cNf6JO6tGMAe--
