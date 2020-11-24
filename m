Return-Path: <SRS0=Rr6S=E6=lists.cip-project.org=bounce+64572+5862+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B0CC2D0E4
	for <cip-dev@archiver.kernel.org>; Tue, 24 Nov 2020 18:47:31 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32214206E5
	for <cip-dev@archiver.kernel.org>; Tue, 24 Nov 2020 18:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="iEgh41WD"
Authentication-Results: mail.kernel.org; dmarc=permerror header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5862+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id lFwnYY4521723xFNX3mJv5GE; Tue, 24 Nov 2020 10:47:29 -0800
X-Received: from imap3.hz.codethink.co.uk (imap3.hz.codethink.co.uk [176.9.8.87])
 by mx.groups.io with SMTP id smtpd.web09.1504.1606243648777907868
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Nov 2020 10:47:29 -0800
X-Received: from host-92-5-241-147.as43234.net ([92.5.241.147] helo=[192.168.1.13])
	by imap3.hz.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
	id 1khdLZ-00025A-O3; Tue, 24 Nov 2020 18:47:25 +0000
Subject: Re: [cip-dev] A lot of compiles failing
To: cip-dev@lists.cip-project.org
Cc: chris.paterson2@renesas.com
References: <164A38B8F4B8DF4E.30699@lists.cip-project.org>
 <20201124184458.GA7488@duo.ucw.cz>
From: "Sudip Mukherjee" <sudip.mukherjee@codethink.co.uk>
Message-ID: <31572d3d-b4a5-e690-8ac0-d7b16141c6c6@codethink.co.uk>
Date: Tue, 24 Nov 2020 18:47:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20201124184458.GA7488@duo.ucw.cz>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: us3Sy9yvQoC5d1sHNdIEMFKQx4520388AA=
Content-Type: multipart/mixed; boundary="OgWYzoyRY2yw5f2YxQKW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606243649;
 bh=QRc1dWbb1rYXDJrP3h4gksah7q54sanLaOXGM3wTqrU=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=iEgh41WDgL+szUC+5nmvRR5sFpxTHArt9d9f+TuY3G5s3JFLAIfP6xwckf2c26QrSJZ
 AxGg05obj4OeV0FU1ciEnG0W5sEVSqzOTVgpSTCCalrgz6ejhQ3u27wYGUDA7W1n62Wii
 Kn7BT5HVnxmWljAm0mnWJ5ZxvyMiU1GjklM=

--OgWYzoyRY2yw5f2YxQKW
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

Hi Pavel,

On 24/11/2020 18:44, Pavel Machek wrote:
> Hi!
> 
>> This is going on for a few days now, but today it seems worse than
>> usual:
>>
>> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/220169843
>>
>> builds are failing, 'HTTP 500 curl 22' error, so not a real build
>> problem. I can probably just click restart... 6 times. But something
>> is not there, and it is getting worse.
> 
> Today I got new one....
> 
> Waiting for pod gitlab/runner-bcrayztp-project-2678032-concurrent-392fb6 to be running, status is Pending
> 217Running on runner-bcrayztp-project-2678032-concurrent-392fb6 via cip-project-v3-gitlab-runner-6dbd79945f-wdqqw...
> 219
> Fetching changes with git depth set to 10...
> 00:35
> 220Initialized empty Git repository in /builds/cip-project/cip-kernel/linux-cip/.git/
> 221Created fresh repository.
> 222error: RPC failed; curl 92 HTTP/2 stream 0 was not closed cleanly: INTERNAL_ERROR (err 2)
> 223fatal: the remote end hung up unexpectedly
> 224fatal: early EOF
> 225fatal: index-pack failed
> 227
> Uploading artifacts.
> 
> I wonder... Is each of our workers pulling full copy of kernel from
> gitlab?
> 
> If so, I understand that gitlab might be a bit unhappy. We probably
> should populate the initial version from our servers (or from
> kernel.org), or maybe include copy of recent linux directly into
> machine images... to reduce load on gitlab.

Maybe you can consider using git depth of 1.


-- 
Regards
Sudip

--OgWYzoyRY2yw5f2YxQKW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5862): https://lists.cip-project.org/g/cip-dev/message=
/5862
Mute This Topic: https://lists.cip-project.org/mt/78460850/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--OgWYzoyRY2yw5f2YxQKW--
