Return-Path: <SRS0=TDvK=BB=lists.cip-project.org=bounce+64572+4957+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768E4C433E6
	for <cip-dev@archiver.kernel.org>; Wed, 22 Jul 2020 08:04:59 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08B502080D
	for <cip-dev@archiver.kernel.org>; Wed, 22 Jul 2020 08:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="bJ2+0I7i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08B502080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4957+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Q1DiYY4521723xjscBT2fgiK; Wed, 22 Jul 2020 01:04:58 -0700
X-Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web11.14045.1595405096343285891
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jul 2020 01:04:57 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 06M84r1F009321
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jul 2020 10:04:53 +0200
X-Received: from [167.87.24.251] ([167.87.24.251])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 06M84p9A018973;
	Wed, 22 Jul 2020 10:04:52 +0200
Subject: Re: [cip-dev] [isar-cip-core] tests: put all tests into a opt layer
To: daniel.sangorrin@toshiba.co.jp, cip-dev@lists.cip-project.org,
        nobuhiro1.iwamatsu@toshiba.co.jp
References: <20200721124242.1479495-1-daniel.sangorrin@toshiba.co.jp>
 <5cf9c07a-76a3-ab41-8d39-786876aa0c0d@siemens.com>
 <OSBPR01MB20537A054E7222BF5E1BC7E6D0790@OSBPR01MB2053.jpnprd01.prod.outlook.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <b22e4826-c624-fe98-07ee-2d6d99bf55a1@siemens.com>
Date: Wed, 22 Jul 2020 10:04:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB20537A054E7222BF5E1BC7E6D0790@OSBPR01MB2053.jpnprd01.prod.outlook.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: jUhZ7nJx0zajpUKjBXjRrjsTx4520388AA=
Content-Type: multipart/mixed; boundary="qgMKqvczKOHkc3UjEfTe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595405098;
 bh=VkPA2I7UAPp2+lKmNVgAegvIfmWUbnVGU4aI5LxpDY4=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=bJ2+0I7itIFRX9DCBwaw/nF16SzVgv9p3sbZMVn+9WxDuZm6OUqs7pWDUPnzXXPx6Pl
 gTprZabwHeDF2CLVKiISjWfCiXuOZVNDTAbEcK6NtKUnsFy+IGo7g9Ex6F66TgRF0yxU2
 iF+Ob/Jhm+qJkh1ESRvO1QKqJv2t2GcZ13s=

--qgMKqvczKOHkc3UjEfTe
Content-Type: text/plain; charset=iso-2022-jp; format=flowed; delsp=yes
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 22.07.20 09:25, daniel.sangorrin@toshiba.co.jp wrote:
> ________________________________________
> From: Jan Kiszka <jan.kiszka@siemens.com>
> Sent: Wednesday, July 22, 2020 3:44 PM
> To: cip-dev@lists.cip-project.org; sangorrin daniel(サンゴリン ダニエル □ＳＷＣ◯ＡＣＴ); iwamatsu nobuhiro(岩松 信洋 □ＳＷＣ◯ＡＣＴ)
> Subject: Re: [cip-dev] [isar-cip-core] tests: put all tests into a opt layer
> 
> On 21.07.20 14:42, Daniel Sangorrin wrote:
>> having an opt-tests layer makes it easier to see what
>> tests are installed, and allows creating images without
>> them as well
> 
> JAN:
> "Having ... as well."
> 
> Does this obsolete
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/merge_requests/7,
> where I just commented on?
> 
> DANIEL: Maybe you can apply Iwamatsu-san merge request first, and I will prepare a new patch on top of that to avoid confusion.

That would confuse me now: What creating a separate test image first,  
just to remove it again?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

--qgMKqvczKOHkc3UjEfTe
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4957): https://lists.cip-project.org/g/cip-dev/message=
/4957
Mute This Topic: https://lists.cip-project.org/mt/75702560/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--qgMKqvczKOHkc3UjEfTe--
