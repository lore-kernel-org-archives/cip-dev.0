Return-Path: <SRS0=Yvut=F4=lists.cip-project.org=bounce+64572+5975+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8619EC433E0
	for <cip-dev@archiver.kernel.org>; Thu, 24 Dec 2020 17:13:46 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B025522288
	for <cip-dev@archiver.kernel.org>; Thu, 24 Dec 2020 17:13:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B025522288
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5975+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id wQ5KYY4521723xzTxBy2luyV; Thu, 24 Dec 2020 09:13:45 -0800
X-Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
 by mx.groups.io with SMTP id smtpd.web08.134.1608830024253072394
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Dec 2020 09:13:44 -0800
X-Received: by mail-lf1-f41.google.com with SMTP id m12so5930180lfo.7
        for <cip-dev@lists.cip-project.org>; Thu, 24 Dec 2020 09:13:43 -0800 (PST)
X-Gm-Message-State: BPrJeEKxAJXT96rFafMHBfAgx4520388AA=
X-Google-Smtp-Source: ABdhPJw7EtdjeH6G8P8WuZqIdfdcR433pQoc+q4EH83Mkf7lbiYE3/7flwGMWqj9SRBiqRH6Qit91g==
X-Received: by 2002:ac2:5597:: with SMTP id v23mr7369292lfg.649.1608830022223;
        Thu, 24 Dec 2020 09:13:42 -0800 (PST)
X-Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id 136sm3663267lfi.136.2020.12.24.09.13.41
        for <cip-dev@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Dec 2020 09:13:41 -0800 (PST)
X-Received: by mail-lf1-f51.google.com with SMTP id 23so5889789lfg.10
        for <cip-dev@lists.cip-project.org>; Thu, 24 Dec 2020 09:13:41 -0800 (PST)
X-Received: by 2002:ac2:4d44:: with SMTP id 4mr13571589lfp.296.1608830021696;
 Thu, 24 Dec 2020 09:13:41 -0800 (PST)
MIME-Version: 1.0
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
Date: Fri, 25 Dec 2020 01:13:30 +0800
X-Gmail-Original-Message-ID: <CAGb2v6721zRU0CxzQOMT_=n56AVdjMYxWmfR=VmumzdvPHAJuw@mail.gmail.com>
Message-ID: <CAGb2v6721zRU0CxzQOMT_=n56AVdjMYxWmfR=VmumzdvPHAJuw@mail.gmail.com>
Subject: [cip-dev] Cip-kernel-sec Updates for Week of 2020-12-24
To: cip-dev@lists.cip-project.org
Cc: Pavel Machek <pavel@denx.de>, Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, 
	masashi.kudo@cybertrust.co.jp
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="slW15EVPkqo2pm0WfvOf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1608830025;
 bh=8V5hX1M/Hxne023/7g2sfgirEfX5aTEOyd8GQp9FvCE=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=bnb3rOTTbcPVlc0MqIlUkWUkyfYtyxnEGV7n+gRW/Sf033QjGwRWmL66jPys22OAUE8
 Tpcq5n94rHu5wPRMkzbYJXjWO2naWkCTyFROJWpxBJAXSb+x45MVwt/ylzLZrr2B1qrg6
 xvcLb42TYDfY3KoCKpPQ0NrVw+jX4Jikojg=

--slW15EVPkqo2pm0WfvOf
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

Here is the cip-kernel-sec report for this week.

This week we have two new issues:

- CVE-2020-29568 [xen/blkdev/backend] - fixed
- CVE-2020-29569 [xen/blkdev/backend] - fixed

Both are currently only fixed in mainline, without any backports
attempts recorded yet.


Regards
ChenYu

--slW15EVPkqo2pm0WfvOf
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5975): https://lists.cip-project.org/g/cip-dev/message=
/5975
Mute This Topic: https://lists.cip-project.org/mt/79206046/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--slW15EVPkqo2pm0WfvOf--
