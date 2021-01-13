Return-Path: <SRS0=jl0p=GQ=lists.cip-project.org=bounce+64572+6065+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8C5C433E0
	for <cip-dev@archiver.kernel.org>; Wed, 13 Jan 2021 11:33:20 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6F78233F6
	for <cip-dev@archiver.kernel.org>; Wed, 13 Jan 2021 11:33:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6F78233F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6065+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 3EQ6YY4521723xnOOtUHFfBS; Wed, 13 Jan 2021 03:33:19 -0800
X-Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web10.6704.1610537598001251276
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Jan 2021 03:33:18 -0800
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 10DBXDYA017392
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Jan 2021 12:33:13 +0100
X-Received: from [167.87.43.185] ([167.87.43.185])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 10DBXD7e014822;
	Wed, 13 Jan 2021 12:33:13 +0100
Subject: Re: [cip-dev] [isar-cip-core] [PATCH] swupdate-img.bbclass: add checksum in non signed case as well
To: Claudius Heine <ch@denx.de>, cip-dev@lists.cip-project.org,
        Henning Schild <henning.schild@siemens.com>
References: <20210111154856.6636-1-henning.schild@siemens.com>
 <59f30d0b-d20a-8087-4b28-5c0fd1f7853c@siemens.com>
 <5e854316-1b0c-face-c11f-380b556da8d2@denx.de>
 <e63169ec-9054-8a8f-730e-8de2addbb259@siemens.com>
 <2d5779df-0f43-4041-5ce2-c5a736364182@denx.de>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <29f3df18-a458-98cf-f2f9-d8493035dadb@siemens.com>
Date: Wed, 13 Jan 2021 12:33:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <2d5779df-0f43-4041-5ce2-c5a736364182@denx.de>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: eiooARWO5Y2N7s8SbqVmrGPDx4520388AA=
Content-Type: multipart/mixed; boundary="PPKzmPLX4Q6KzksPqZWp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1610537599;
 bh=Fy5Q2TN6PjdBKJiys1Vzt0f0NUI+JvNJzj/09imArs0=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=l0KAoocGkVDiyLH/LqrLhwJrh7wp1ao9/TTqm9wESx478/3+t3vhlNuFOj7Z4+AOk7m
 0bXexFuc4nNZc9FTVkQ73sp52NhRlSYWUuwoubvfjGd+igDuIZVNqZPrCH0EewLQ1ROlj
 m1bF5CRWjk7QCLYnU4cFp3+Qfui6JFIIgjc=

--PPKzmPLX4Q6KzksPqZWp
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 13.01.21 12:02, Claudius Heine wrote:
> On 2021-01-13 11:55, Jan Kiszka wrote:
>> On 13.01.21 11:52, Claudius Heine wrote:
>>> Hi Jan,
>>>
>>> On 2021-01-13 11:46, Jan Kiszka wrote:
>>>> On 11.01.21 16:48, Henning Schild wrote:
>>>>> From: Claudius Heine <ch@denx.de>
>>>>>
>>>>
>>>> Can you also provide a reasoning here?
>>>
>>> I can, but I guess you mean that a commit message should be added here.
>>>
>>
>> ...or that you provide me a text I can fill in on merge.
> 
> Ok here is my take:
> 
> ```
> Also unsigned images should contain a checksum in the swdescription, for
> instance in case `DISABLE_CPIO_CRC=y` is set in swupdate and a USB stick
> is used for update delivery, only such a checksum would protect against
> file corruption.
> ```
> 

Thanks, applied with this text.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--PPKzmPLX4Q6KzksPqZWp
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6065): https://lists.cip-project.org/g/cip-dev/message=
/6065
Mute This Topic: https://lists.cip-project.org/mt/79598691/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--PPKzmPLX4Q6KzksPqZWp--
