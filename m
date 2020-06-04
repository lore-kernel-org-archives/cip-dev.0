Return-Path: <SRS0=XQDY=7R=lists.cip-project.org=bounce+64572+4720+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E40C433E0
	for <cip-dev@archiver.kernel.org>; Thu,  4 Jun 2020 11:55:53 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2408820738
	for <cip-dev@archiver.kernel.org>; Thu,  4 Jun 2020 11:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="W2Ph0XAj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2408820738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4720+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ZUXUYY4521723x0pjPoQxFfc; Thu, 04 Jun 2020 04:55:52 -0700
X-Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
 by mx.groups.io with SMTP id smtpd.web10.7625.1591246051764452750
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Jun 2020 21:47:31 -0700
X-Received: by mail-pl1-f194.google.com with SMTP id bh7so1636258plb.11
        for <cip-dev@lists.cip-project.org>; Wed, 03 Jun 2020 21:47:31 -0700 (PDT)
X-Gm-Message-State: 47V86WLUxHOoPoCdpY2IGehmx4520388AA=
X-Google-Smtp-Source: ABdhPJyJRsOh5hsEdThq0rQK/ATF5CSsnVkJT4EHLQ6Cvdiw5FvqmXh7QCDZHc0IdlFMNHB43kGp6A==
X-Received: by 2002:a17:90a:d104:: with SMTP id l4mr3702913pju.25.1591246051200;
        Wed, 03 Jun 2020 21:47:31 -0700 (PDT)
X-Received: from localhost ([122.172.62.209])
        by smtp.gmail.com with ESMTPSA id w192sm3348359pff.126.2020.06.03.21.47.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jun 2020 21:47:30 -0700 (PDT)
Date: Thu, 4 Jun 2020 10:17:28 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, pavel@denx.de,
	cip-dev@lists.cip-project.org, JohnsonCH.Chen@moxa.com,
	Stephen Boyd <sboyd@codeaurora.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [cip-dev] [4.4.y-cip 01/15] PM / OPP: Add debugfs support
Message-ID: <20200604044728.fcj72dgnwbds26hw@vireshk-i7>
References: <20200604031829.3254-1-wens@csie.org>
 <20200604031829.3254-2-wens@csie.org>
MIME-Version: 1.0
In-Reply-To: <20200604031829.3254-2-wens@csie.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="ZRkAVjPOk7B48EK4lYw8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591271752;
 bh=9ZUggrhgVRZnCi1Ul/Ng/Zybs6zqJRbKzeWqCutEFcc=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=W2Ph0XAjPGe5iiKxhT/peVKRNZvZQlyrMvacFQF85/ygaIt6776Pi7erfzoV/g5b8Cv
 m5YeRY2ev87IgXrZbIBYDLQbdooJZp367lV4LZqHMlb4mQ3JZgHrvMBcEBWcZyG9wy+R4
 bIJek7FN/q/E3DP2qDbCkz3MaTAYaPcIqrs=

--ZRkAVjPOk7B48EK4lYw8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 04-06-20, 11:18, Chen-Yu Tsai (Moxa) wrote:
> From: Viresh Kumar <viresh.kumar@linaro.org>
> 
> commit deaa51465105a7eda19a627b10372f4f7c51a4df upstream.
> 
> This patch adds debugfs support to OPP layer to export OPPs and their
> properties for all the devices.
> 
> This creates a top level directory: /sys/kernel/debug/opp and then
> device specific directories (based on device names) inside it. For
> example: 'cpu0', 'cpu1', etc..
> 
> If multiple devices share the OPP table, then the real directory is
> created only for the first device. For all others, links are created to
> the real directory.
> 
> Inside the device specific directory, a separate directory is created
> for each OPP. And within that files per opp property.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Chen-Yu Tsai (Moxa) <wens@csie.org>

Please use --suppress-cc=all while sending patches internally.

-- 
viresh

--ZRkAVjPOk7B48EK4lYw8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4720): https://lists.cip-project.org/g/cip-dev/message=
/4720
Mute This Topic: https://lists.cip-project.org/mt/74669312/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--ZRkAVjPOk7B48EK4lYw8--
