Return-Path: <SRS0=QQkm=B5=lists.cip-project.org=bounce+64572+5138+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1377C433DF
	for <cip-dev@archiver.kernel.org>; Wed, 19 Aug 2020 06:17:57 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 419C320772
	for <cip-dev@archiver.kernel.org>; Wed, 19 Aug 2020 06:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="rDs6F2Zi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 419C320772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5138+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 3qDUYY4521723xcsFVw7Xp5R; Tue, 18 Aug 2020 23:17:57 -0700
X-Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web12.83005.1597817875258142768
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Aug 2020 23:17:56 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 07J6HpKE021486
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Aug 2020 08:17:51 +0200
X-Received: from [167.87.31.209] ([167.87.31.209])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 07J6HoLS001261;
	Wed, 19 Aug 2020 08:17:50 +0200
Subject: Re: [cip-dev] [isar-cip-core][PATCH v2 3/3] testing: Add test.yml
To: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        cip-dev@lists.cip-project.org
References: <20200819044201.1255803-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20200819044201.1255803-3-nobuhiro1.iwamatsu@toshiba.co.jp>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <436e7176-7fd0-086e-6aad-784e3ea1e68f@siemens.com>
Date: Wed, 19 Aug 2020 08:17:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200819044201.1255803-3-nobuhiro1.iwamatsu@toshiba.co.jp>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: M5NCrkYoRD43lXtqYHzHO8fxx4520388AA=
Content-Type: multipart/mixed; boundary="fLZdeWskNa0036qkK5UM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1597817877;
 bh=wi8h2rZmPQPLg9/7pTeo506NFthHmPMDlM6cJxxvqnM=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=rDs6F2ZieRSRzi25WAxu8SmpHP6nby1gNqUMOlWFY1HepHJSg45oBQdVxh7Ta7ZCOoN
 COcdz8FxmlZiN6AH7aVthtC4YaLV5TU5MhaKYN2s9b2yy/Dz7Vic4zEJ0LDCdRboAVn+1
 nwzn4cSVXkVPQOk6BJkXvfX4gVlusF6Yqys=

--fLZdeWskNa0036qkK5UM
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 19.08.20 06:42, Nobuhiro Iwamatsu wrote:
> Add YAML to add the test application to each images.
> The following test applications will be added.
>  - ltp
>  - rt-tests
>  - stress-ng
> 
> And this appends '-test' to the generated image filename.
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---
>  kas/opt/test.yml | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 kas/opt/test.yml
> 
> diff --git a/kas/opt/test.yml b/kas/opt/test.yml
> new file mode 100644
> index 0000000..75b257d
> --- /dev/null
> +++ b/kas/opt/test.yml
> @@ -0,0 +1,20 @@
> +#
> +# Copyright (c) Siemens AG, 2019
> +# Copyright (c) Toshiba Corporation, 2020
> +#
> +# Authors:
> +#  Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +header:
> +  version: 8
> +
> +local_conf_header:
> +  testing: |
> +    IMAGE_INSTALL += "ltp-full"
> +    IMAGE_PREINSTALL += "rt-tests stress-ng"
> +    DESCRIPTION_append = " with test packages"
> +    IMAGE_FULLNAME_append = "-test"
> +
> 

Ah, nice solution with the _append.

Can you follow up with a patch for CI that adds the test feature at
least to some of your images? I actually wonder if we shouldn't add it
to all, or even have to in case the CI images are directly used for testing.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

--fLZdeWskNa0036qkK5UM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5138): https://lists.cip-project.org/g/cip-dev/message=
/5138
Mute This Topic: https://lists.cip-project.org/mt/76280651/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--fLZdeWskNa0036qkK5UM--
