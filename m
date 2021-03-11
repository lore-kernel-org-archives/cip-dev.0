Return-Path: <SRS0=L6cK=IJ=lists.cip-project.org=bounce+64572+6274+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6E3C433E0
	for <cip-dev@archiver.kernel.org>; Thu, 11 Mar 2021 09:24:13 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B12864E76
	for <cip-dev@archiver.kernel.org>; Thu, 11 Mar 2021 09:24:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B12864E76
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6274+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id KEzwYY4521723xINEUqzow9z; Thu, 11 Mar 2021 01:24:11 -0800
X-Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
 by mx.groups.io with SMTP id smtpd.web10.3736.1615454650781531218
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Mar 2021 01:24:11 -0800
X-Received: by mail-lf1-f48.google.com with SMTP id 18so38550214lff.6
        for <cip-dev@lists.cip-project.org>; Thu, 11 Mar 2021 01:24:10 -0800 (PST)
X-Gm-Message-State: HAVCkT96F4amGr4vgPzgdr9Ex4520388AA=
X-Google-Smtp-Source: ABdhPJzIjXDDJYkBdPhYn6xN73W5Xwtyhjzz3Nz8Pk5MIaTgt8P8SXVkQWZpw+IZlxAj3wrMRVGWXQ==
X-Received: by 2002:a05:6512:47b:: with SMTP id x27mr1815071lfd.37.1615454648479;
        Thu, 11 Mar 2021 01:24:08 -0800 (PST)
X-Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id q16sm665302lfu.153.2021.03.11.01.24.08
        for <cip-dev@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Mar 2021 01:24:08 -0800 (PST)
X-Received: by mail-lf1-f42.google.com with SMTP id v2so25556368lft.9
        for <cip-dev@lists.cip-project.org>; Thu, 11 Mar 2021 01:24:08 -0800 (PST)
X-Received: by 2002:ac2:41d6:: with SMTP id d22mr1773126lfi.496.1615454647946;
 Thu, 11 Mar 2021 01:24:07 -0800 (PST)
MIME-Version: 1.0
Reply-To: cip-dev@lists.cip-project.org
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
Date: Thu, 11 Mar 2021 17:23:55 +0800
X-Gmail-Original-Message-ID: <CAGb2v66-bSg43E7k+HYJv0CniGDwrW3GP4ewysjr-zX1y2fo1g@mail.gmail.com>
Message-ID: <CAGb2v66-bSg43E7k+HYJv0CniGDwrW3GP4ewysjr-zX1y2fo1g@mail.gmail.com>
Subject: [cip-dev] Cip-kernel-sec Updates for Week of 2021-03-11
To: cip-dev@lists.cip-project.org
Cc: Pavel Machek <pavel@denx.de>, Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, 
	masashi.kudo@cybertrust.co.jp
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Content-Type: multipart/mixed; boundary="unljlO9dcuN4b9jnDbXc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1615454651;
 bh=zOshc/d0/hsMTPzsJeWDtRWIYuIe+56g3CZqW2c11cQ=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=PE/xIkPkk8RjNsDlHpnsdi3X/vGpxueR6HiVu285nhMe66TcG2V+3vLdZ1deY8aMZb+
 +IIM4mRNF85DauB8s38Wvqi7dTBkntc/LCQ/s/fYojM6kF9TdNUZtCi0DwMnsybDvE9V5
 Fl+TAT1xJMEhXcTcg8DIl9WTNhk7Ltvlsls=

--unljlO9dcuN4b9jnDbXc
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

Seven new CVEs this week:
- CVE-2021-20265 [af_unix: memory leak] - fixed
- CVE-2021-20268 [ebpf: signed type overflow] - fixed
- CVE-2021-27363 [iscsi: iscsi_host_get_param() allows sysfs params
larger than 4k] - fixed
- CVE-2021-27364 [iscsi: iscsi_if_recv_msg allows non-root user] - fixed
- CVE-2021-27365 [iscsi: heap buffer overflow] - fixed
- CVE-2021-28038 [xen: netback: fails to honor errors] - fixed
- CVE-2021-28039 [xen: incorrect foreign pages mapping under special
config] - fixed

All fixes have been backported to all relevant stable kernels.

Also, 4.9.y specific follow-up patch for CVE-2020-29368 was merged in 4.9.259.


Regards
ChenYu

--unljlO9dcuN4b9jnDbXc
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6274): https://lists.cip-project.org/g/cip-dev/message=
/6274
Mute This Topic: https://lists.cip-project.org/mt/81249415/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--unljlO9dcuN4b9jnDbXc--
