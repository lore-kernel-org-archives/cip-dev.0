Return-Path: <SRS0=cnNx=IR=lists.cip-project.org=bounce+64572+6295+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE88C433DB
	for <cip-dev@archiver.kernel.org>; Fri, 19 Mar 2021 06:55:37 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D67F64F69
	for <cip-dev@archiver.kernel.org>; Fri, 19 Mar 2021 06:55:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D67F64F69
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=plathome.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6295+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 5H9ZYY4521723xiLdBuodmn2; Thu, 18 Mar 2021 23:55:35 -0700
X-Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.web10.2807.1616136935077289234
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Mar 2021 23:55:35 -0700
X-Received: by mail-pl1-f177.google.com with SMTP id v23so2505921ple.9
        for <cip-dev@lists.cip-project.org>; Thu, 18 Mar 2021 23:55:34 -0700 (PDT)
X-Gm-Message-State: CwRKTjsPYBOijvVfZSpGggLUx4520388AA=
X-Google-Smtp-Source: ABdhPJylGOrEhs7QKdLS/RckxOCqDJUtTLslc4yqh9QfWb61QhVx8uJJe8gR8eqQimPvprE+HdKjsw==
X-Received: by 2002:a17:90a:c902:: with SMTP id v2mr8421248pjt.144.1616136934004;
        Thu, 18 Mar 2021 23:55:34 -0700 (PDT)
X-Received: from [172.16.32.103] ([124.39.181.46])
        by smtp.gmail.com with ESMTPSA id d6sm4204585pfq.109.2021.03.18.23.55.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Mar 2021 23:55:33 -0700 (PDT)
Subject: Re: [cip-dev] [Feedback Requested] RE: Cip-kernel-sec Updates for Week of 2021-03-18
To: masashi.kudo@cybertrust.co.jp, cip-dev@lists.cip-project.org
Cc: pavel@denx.de, nobuhiro1.iwamatsu@toshiba.co.jp, wens@csie.org,
 jan.kiszka@siemens.com
References: <TY2PR01MB4972E1E07AE85D162237E83CA0699@TY2PR01MB4972.jpnprd01.prod.outlook.com>
From: "minmin@plathome.co.jp" <minmin@plathome.co.jp>
Message-ID: <bbaaff0c-aace-4c0d-2c48-00d93653416f@plathome.co.jp>
Date: Fri, 19 Mar 2021 15:55:31 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <TY2PR01MB4972E1E07AE85D162237E83CA0699@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="qdlzVtm2dkPuCy1fWloL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1616136935;
 bh=j0f7ccNk5SsOk3YK5rj1+MayQgha/gtq+BjzTSTXnVU=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=QD0rtl+ylYzq8LG9jNGAaVK3ot/+TnFBbgtgY/9hxyh0+CwFytJYJebY1b86WOmQbFQ
 rMzVv0MlRHIguBxSu8tuXZ6mh9BN1CVAw6Bz3pO0SAtFy51ECp/nbFkbbDTZRAdk7p9Kh
 jpug+YTo/g6hOJp9LerSpWr+7cTU5iXFV0E=

--qdlzVtm2dkPuCy1fWloL
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US

Hi, Kudo-san, CIP kernel members,

On 2021/03/18 18:33, masashi.kudo@cybertrust.co.jp wrote:
> - CVE-2020-35519 is relating to X.25.
> X.25 is enabled as follows, but we wonder whether X.25 is really used or not.
>>      4.4.y-cip/x86/plathome_obsvx1.config:CONFIG_X25=m

Oh!
This configuration, "plathome_obsvx1.config" is for the OpenBlocks IoT VX1. VX1 is the predecessor to VX2 and we do not currently support VX1. Also, VX2 has been the reference hardware for the CIP since the 4.19 kernel.

Therefore, I think "plathome_obsvx1.config" should be removed from the CIP kernel configuration.

By the way, VX1 has almost the same hardware configuration as VX2, so the kernel for VX2 will work as is.

Best Regards,
minmin





--qdlzVtm2dkPuCy1fWloL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6295): https://lists.cip-project.org/g/cip-dev/message=
/6295
Mute This Topic: https://lists.cip-project.org/mt/81425316/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--qdlzVtm2dkPuCy1fWloL--
