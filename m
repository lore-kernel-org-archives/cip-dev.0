Return-Path: <SRS0=+6px=BB=lists.cip-project.org=bounce+64572+4959+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1335C433E0
	for <cip-dev@archiver.kernel.org>; Wed, 22 Jul 2020 14:07:18 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B83E20709
	for <cip-dev@archiver.kernel.org>; Wed, 22 Jul 2020 14:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="mmy+ugYx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B83E20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4959+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id B9CvYY4521723xTVVYYo5U1k; Wed, 22 Jul 2020 07:07:18 -0700
X-Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web10.19665.1595426836365165763
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jul 2020 07:07:17 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 06ME7Dxc025577
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jul 2020 16:07:13 +0200
X-Received: from [167.87.24.251] ([167.87.24.251])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 06ME7C8d004708;
	Wed, 22 Jul 2020 16:07:12 +0200
Subject: Re: [cip-dev] [isar-cip-core] tests: put all tests into a opt layer
To: cip-dev@lists.cip-project.org,
        Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>,
        nobuhiro1.iwamatsu@toshiba.co.jp
References: <20200721124242.1479495-1-daniel.sangorrin@toshiba.co.jp>
 <5cf9c07a-76a3-ab41-8d39-786876aa0c0d@siemens.com>
 <OSBPR01MB20537A054E7222BF5E1BC7E6D0790@OSBPR01MB2053.jpnprd01.prod.outlook.com>
 <b22e4826-c624-fe98-07ee-2d6d99bf55a1@siemens.com>
 <OSBPR01MB205393EC7EF5806AF88C6D39D0790@OSBPR01MB2053.jpnprd01.prod.outlook.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <001305cb-0a8e-f90d-2cae-9e7a358aa834@siemens.com>
Date: Wed, 22 Jul 2020 16:07:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB205393EC7EF5806AF88C6D39D0790@OSBPR01MB2053.jpnprd01.prod.outlook.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: KQ9anhqLSLXuOQRxm5EXnBhFx4520388AA=
Content-Type: multipart/mixed; boundary="YuTl61JZz6rT0DmbkdFU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595426838;
 bh=WO7vYNFQ1AxOJ6BH1ZC6uN0yi3eC6/IkMHTlFxhX6TA=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=mmy+ugYxoe6jt/7e7wHsMe60wIxYDEljmaQR5HPD4tq31hV4cH4SXRWcAEEXbD9uytt
 PjOAnpCV8gg/J0JdWj3kz/nJDuE7+qLoYOAUZI+hRdsXniOmXDoHkAiC+blucrjJRazbr
 MZWOeGQJaOdeiNRhR9C4xpPHaA1O1ILyOBw=

--YuTl61JZz6rT0DmbkdFU
Content-Type: text/plain; charset=iso-2022-jp; format=flowed; delsp=yes
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 22.07.20 12:46, Daniel Sangorrin wrote:
> Hi Jan
> 
>> -----Original Message-----
>> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Behalf Of Jan Kiszka
>> Sent: Wednesday, July 22, 2020 5:05 PM
>> To: sangorrin daniel(サンゴリン ダニエル □ＳＷＣ◯ＡＣＴ) <daniel.sangorrin@toshiba.co.jp>; cip-dev@lists.cip-project.org; iwamatsu
>> nobuhiro(岩松 信洋 □ＳＷＣ◯ＡＣＴ) <nobuhiro1.iwamatsu@toshiba.co.jp>
>> Subject: Re: [cip-dev] [isar-cip-core] tests: put all tests into a opt layer
>>
>> On 22.07.20 09:25, daniel.sangorrin@toshiba.co.jp wrote:
>>> ________________________________________
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>> Sent: Wednesday, July 22, 2020 3:44 PM
>>> To: cip-dev@lists.cip-project.org; sangorrin daniel(サンゴリン ダニエル
>>> □ＳＷＣ◯ＡＣＴ); iwamatsu nobuhiro(岩松 信洋 □ＳＷＣ◯ＡＣＴ)
>>> Subject: Re: [cip-dev] [isar-cip-core] tests: put all tests into a opt
>>> layer
>>>
>>> On 21.07.20 14:42, Daniel Sangorrin wrote:
>>>> having an opt-tests layer makes it easier to see what tests are
>>>> installed, and allows creating images without them as well
>>>
>>> JAN:
>>> "Having ... as well."
>>>
>>> Does this obsolete
>>> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/merge_requests
>>> /7,
>>> where I just commented on?
>>>
>>> DANIEL: Maybe you can apply Iwamatsu-san merge request first, and I will prepare a new patch on top of that to avoid confusion.
>>
>> That would confuse me now: What creating a separate test image first, just to remove it again?
> 
> Sorry for the confusion.
> 
> If you apply MR7, I will move the rt-tests and stress-ng packages from the customization "package" to the test image.
> If you instead apply MR5, I will move them to opt-testtools.yml
> 
> Or is there any special reason for rt-tests and stress-ng to be in the customization package?
> 

Nobuhiro, is something missing from your perspective in Daniels  
approach? If not, I'd like to have one patch that takes us to that level.

By now, I think an opt-testtools.yml is better (an "option", not a  
"layer") than a separate image. That allows to test the security image  
eventually as well.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

--YuTl61JZz6rT0DmbkdFU
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4959): https://lists.cip-project.org/g/cip-dev/message=
/4959
Mute This Topic: https://lists.cip-project.org/mt/75702560/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--YuTl61JZz6rT0DmbkdFU--
