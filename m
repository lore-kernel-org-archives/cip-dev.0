Return-Path: <SRS0=36R5=7B=lists.cip-project.org=bounce+64572+4633+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5B2C433E0
	for <cip-dev@archiver.kernel.org>; Tue, 19 May 2020 05:20:03 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E74AE2075F
	for <cip-dev@archiver.kernel.org>; Tue, 19 May 2020 05:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="P9foA/xc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E74AE2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4633+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id TMCVYY4521723xWtxmqtqox6; Mon, 18 May 2020 22:20:02 -0700
X-Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web12.6775.1589865600785287546
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 May 2020 22:20:01 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 04J5Jv5o000974
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 May 2020 07:19:58 +0200
X-Received: from [167.87.128.2] ([167.87.128.2])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 04J5Jt8Z028233;
	Tue, 19 May 2020 07:19:56 +0200
Subject: Re: [cip-dev][isar-cip-core] version management
To: daniel.sangorrin@toshiba.co.jp, dinesh.kumar@toshiba-tsip.com
Cc: cip-dev@lists.cip-project.org
References: <TYAPR01MB2064041238490898AD56BF62D0B90@TYAPR01MB2064.jpnprd01.prod.outlook.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <8b13f4ba-2ab4-1b7f-94a5-65aaabd11620@siemens.com>
Date: Tue, 19 May 2020 07:19:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <TYAPR01MB2064041238490898AD56BF62D0B90@TYAPR01MB2064.jpnprd01.prod.outlook.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: PkiZB4R8P4TVOney9EIhNDoZx4520388AA=
Content-Type: multipart/mixed; boundary="RkrOqp20b87bJkzvivM0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1589865602;
 bh=gUqY8DS3EnKeDnN0tBWN4ERfB8ZPhpVukBisT3Mdu6I=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=P9foA/xcbDnjFlD+W1iRNzw/0C6NTb95gAbPybW0SCcc1+RTCtCkrZBnU4IoUeq5XnW
 PuBqbOjGqKdDaCObFoh0JwXv/RrDkpyBJ5ZPyqisdz7zrYqsfBk3396Z23T6u70iQv1UA
 s9rwMFcJ57st3Vrveo4aA3MvYi8tqn6nyKw=

--RkrOqp20b87bJkzvivM0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 19.05.20 05:11, daniel.sangorrin@toshiba.co.jp wrote:
> Hello Dinesh, Jan, all
> 
> Dinesh raised an important issue on another thread. I created a new thread to discuss about it.
> 
>> From: Dinesh Kumar <Dinesh.Kumar@TOSHIBA-TSIP.COM>
> [...]
>> I have a question, while planning this activity can we define some version for CIP Core itself? As currently we have
>> CIP Kernel versions and versions for individual application packages.
>> e.g. If we want to share CIP Kernel and CIP Core version for IEC assessment we lack CIP Core version.
>> May be we can discuss it in upcoming CIP Core meeting.
> 
> I agree that we need to version our releases. In Debian there are point versions, but I don't think we need to follow that. Maybe we can just use a number such as the date of the release (eg. 20200519 <-- yearmonthday).

Or the more common pattern "2020.05".

How often should we release? What would be the required quality criteria?

> 
> Some questions regarding versioning:
>     * should we also store metadata associated with a release?
> 	* a package list manifest for each release (dpkg -l)?
>          * the cip-core branch and commit
>          * the cip-kernel branch and commit
>          * md5sum of the image

When using a meta layer for generating the image - like isar-cip-core -, 
almost everything is described that way already, except for...

>     * do we need repository management infrastructure?
>         * mirror part of the debian repository (only the packages that we need)
>         * create snapshots for each release including the source code packages
> 

...the binary packages. So the second piece would be a versioned repo 
for those.

That can be snapshot.debian.org, like we do in [1][2], but that this not 
a very reliable source (took me hours recently to rebuild [1] from 
there, you want a better mirror).

> Storing metadata should not be too difficult, just add some script code to gitlab-ci.
> 
> Keeping snapshots would require much more work and resources. I think this is not necessary since we are not going to rebuild images, and if we wanted we could do it somehow from the package list manifest and the upstream Debian ftp servers.

The repo is required if we want to be serious regarding releases.

Jan

[1] https://github.com/siemens/meta-iot2050
[2] 
https://github.com/siemens/meta-iot2050/blob/master/conf/distro/debian-snapshot.list

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

--RkrOqp20b87bJkzvivM0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4633): https://lists.cip-project.org/g/cip-dev/message=
/4633
Mute This Topic: https://lists.cip-project.org/mt/74318282/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--RkrOqp20b87bJkzvivM0--
