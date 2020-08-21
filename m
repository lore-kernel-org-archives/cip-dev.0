Return-Path: <SRS0=DLJL=B7=lists.cip-project.org=bounce+64572+5167+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E940DC433E1
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 05:38:38 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93615214F1
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 05:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="vr6Sqo5b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93615214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5167+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 5U3PYY4521723x6k4C2U9WrN; Thu, 20 Aug 2020 22:38:38 -0700
X-Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web10.128695.1597988316384221951
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Aug 2020 22:38:37 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 07L5cXs8022566
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2020 07:38:33 +0200
X-Received: from [167.87.31.209] ([167.87.31.209])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 07L5cW60023849;
	Fri, 21 Aug 2020 07:38:32 +0200
Subject: Re: [cip-dev] [isar-cip-core][PATCH 2/2] ci: Add support for test image
To: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        cip-dev@lists.cip-project.org
References: <20200820082434.1302460-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20200820082434.1302460-2-nobuhiro1.iwamatsu@toshiba.co.jp>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <7e2e3c1e-cbb0-1767-2774-84377c8e109e@siemens.com>
Date: Fri, 21 Aug 2020 07:38:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200820082434.1302460-2-nobuhiro1.iwamatsu@toshiba.co.jp>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 4hy7cVCKsPOiDnrKW2BZvVofx4520388AA=
Content-Type: multipart/mixed; boundary="mFdVk8QZISeLAtSMWG4u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1597988318;
 bh=vSlWAjdfmKfLAaMNTAALQ+jAdi4VZl/isKQyHq3bPRY=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=vr6Sqo5bIgB05VOdTejGu13oyzcnOZoZYwXtmLgVRlx8FgNkiqXpTCdF36spv1tTJkx
 H2iJZMWsQuiKcQAiDJSKpUWWbmft6rqAzhhY1j0cI3WpE/HXLVNwuYlm0SRAfHYaHzE3M
 lKK6unG2W3duRer7Xd5bnDvky+k+I8yp0yQ=

--mFdVk8QZISeLAtSMWG4u
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 20.08.20 10:24, Nobuhiro Iwamatsu wrote:
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---
>  .gitlab-ci.yml | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index e23345f..802dbcd 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -68,3 +68,35 @@ build:qemu-amd64-base:
>      extention: security
>      use_rt: disable
>      targz: disable
> +
> +# test
> +build:simatic-ipc227e-test:
> +  extends:
> +    - .build_base
> +  variables:
> +    target: simatic-ipc227e
> +    extention: test
> +
> +build:bbb-test:
> +  extends:
> +    - .build_base
> +  variables:
> +    target: bbb
> +    extention: test
> +    dtb: am335x-boneblack.dtb
> +
> +build:iwg20m-test:
> +  extends:
> +    - .build_base
> +  variables:
> +    target: iwg20m
> +    extention: test
> +    dtb: r8a7743-iwg20d-q7-dbcm-ca.dtb
> +
> +build:hihope-rzg2m-test:
> +  extends:
> +    - .build_base
> +  variables:
> +    target: rzg2m
> +    extention: test
> +    dtb: renesas/r8a774a1-hihope-rzg2m-ex.dtb
> 

Thanks, both applied to next.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

--mFdVk8QZISeLAtSMWG4u
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5167): https://lists.cip-project.org/g/cip-dev/message=
/5167
Mute This Topic: https://lists.cip-project.org/mt/76304033/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--mFdVk8QZISeLAtSMWG4u--
