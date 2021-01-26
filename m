Return-Path: <SRS0=YdmZ=G5=lists.cip-project.org=bounce+64572+6143+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65E2C433E0
	for <cip-dev@archiver.kernel.org>; Tue, 26 Jan 2021 11:06:14 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A3CF23104
	for <cip-dev@archiver.kernel.org>; Tue, 26 Jan 2021 11:06:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A3CF23104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6143+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id EX83YY4521723xJ2jXgoTmrb; Tue, 26 Jan 2021 03:06:13 -0800
X-Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web09.10558.1611659172191688119
 for <cip-dev@lists.cip-project.org>;
 Tue, 26 Jan 2021 03:06:12 -0800
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 10QB68Nv024504
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Jan 2021 12:06:08 +0100
X-Received: from [167.87.60.231] ([167.87.60.231])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 10QB67TL025352;
	Tue, 26 Jan 2021 12:06:07 +0100
Subject: Re: [cip-dev] Siemens board failed to boot testing 5.10
To: cip-dev@lists.cip-project.org, Pavel Machek <pavel@ucw.cz>,
        Chris.Paterson2@renesas.com, "Bhola, Bikram" <Bikram_Bhola@mentor.com>
References: <20210125201734.GA26811@duo.ucw.cz>
 <20210125204403.GA4690@duo.ucw.cz>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <56263cba-5556-4960-a91f-62835783081c@siemens.com>
Date: Tue, 26 Jan 2021 12:06:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210125204403.GA4690@duo.ucw.cz>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: p831OBYqabKmD06WfMmbpSBtx4520388AA=
Content-Type: multipart/mixed; boundary="DxXowBLRlLaNmnYAUSBs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1611659173;
 bh=FY7AuW9r9PDZpKrTp1Rrq0ea/HQDG6IOR3oT7TbC3Z0=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=HXryfQPz0ghNB+L1bykTEdVxL789041hB1WonlZS7wUC/ruZeAXpaAkG2rOo2ernWRO
 Uh8BgM74NDiri5LjDjTvRxukVEu8pgYiTnYfJwLxuVjBBAzhl9EAR24bQeljqa9AivtaS
 /iBzsyuj0smjSs7oJirDE36ojuS/fLQRpno=

--DxXowBLRlLaNmnYAUSBs
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 25.01.21 21:44, Pavel Machek wrote:
> On Mon 2021-01-25 21:17:34, Pavel Machek wrote:
>> Hi!
>>
>> Something went wrong on siemens board... I'll try to resubmit the job.
>>
>> https://lava.ciplatform.org/scheduler/job/148648#L266
> 
> It still fails. https://lava.ciplatform.org/scheduler/job/148674. I'll
> retry one more time, but this looks like permanent problem.
> 

Do you mean the board does not come up with any job, or just with 5.10?
Doesn't it react at all (dead hw)?

And where is this one located? We have IPC227E at Mentor and at Denx now.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--DxXowBLRlLaNmnYAUSBs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6143): https://lists.cip-project.org/g/cip-dev/message=
/6143
Mute This Topic: https://lists.cip-project.org/mt/80114267/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--DxXowBLRlLaNmnYAUSBs--
