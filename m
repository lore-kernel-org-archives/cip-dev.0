Return-Path: <SRS0=UzvX=CJ=lists.cip-project.org=bounce+64572+5335+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB69AC433E6
	for <cip-dev@archiver.kernel.org>; Mon, 31 Aug 2020 06:55:01 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EF282072D
	for <cip-dev@archiver.kernel.org>; Mon, 31 Aug 2020 06:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="akNtOoa5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EF282072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5335+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 3gyyYY4521723xT8PjBhfMJz; Sun, 30 Aug 2020 23:55:01 -0700
X-Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web11.48078.1598856899225359866
 for <cip-dev@lists.cip-project.org>;
 Sun, 30 Aug 2020 23:55:00 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 07V6sthq027610
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2020 08:54:56 +0200
X-Received: from [167.87.39.104] ([167.87.39.104])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 07V6ss99001120;
	Mon, 31 Aug 2020 08:54:55 +0200
Subject: Re: [cip-dev] [isar-cip-core][PATCH] ci: Change to single job
From: "Jan Kiszka" <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
References: <20200831010244.2629769-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <08d5685b-5e0a-7ac0-7564-df8df859588b@siemens.com>
Message-ID: <dd58b64c-cf7d-6322-6988-c17bb529cb3c@siemens.com>
Date: Mon, 31 Aug 2020 08:54:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <08d5685b-5e0a-7ac0-7564-df8df859588b@siemens.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: C0n1u0raOw5UMAYsD7dJiNjFx4520388AA=
Content-Type: multipart/mixed; boundary="OGLf5pB8TmpAXOUxBPUs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598856901;
 bh=NcuXV/i+2fGtG7wNNbXdy8kcnPWiH42thEqss08kxJI=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=akNtOoa5m9jDmj02iE8atI3EP2JLxHXLEwq6jCX3sBJC6s8jGmB3isUiibvv6jRbXH8
 hGr6vvUmoWwHoAXZIF2nM6tfzmh5Wt+cJdDRJLcvsfm5agtQWPg+BEfpTxpbBSm0IpGSy
 mYA01G8wIMF26cs/KEXDS6d9TelM7SpbOZU=

--OGLf5pB8TmpAXOUxBPUs
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 31.08.20 08:01, Jan Kiszka wrote:
> On 31.08.20 03:02, Nobuhiro Iwamatsu wrote:
>> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
>> ---
> 
> The reason should be documented in the commit log. How about
> 
> "Parallel fetching of git snapshots from kernel.org often failed, either
> due to throttling or some problem of the server. We need to avoid this
> for now."
> 
> ?
> 
> Also, this does not address the breakage of the hihope-rzg2m deployment.
> I'll send a patch, please double check it
> 

Meanwhile, kernel.org seems to handle our parallel fetches again, see
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/pipelines/183722607.
I'll drop this patch and focus on fixing the remaining fallouts (missed
on, namely the skipped deployment of the security image).

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

--OGLf5pB8TmpAXOUxBPUs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5335): https://lists.cip-project.org/g/cip-dev/message=
/5335
Mute This Topic: https://lists.cip-project.org/mt/76525805/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--OGLf5pB8TmpAXOUxBPUs--
