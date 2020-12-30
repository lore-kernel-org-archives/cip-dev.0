Return-Path: <SRS0=V9/e=GC=lists.cip-project.org=bounce+64572+5983+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10729C433DB
	for <cip-dev@archiver.kernel.org>; Wed, 30 Dec 2020 15:30:44 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73EC2207B2
	for <cip-dev@archiver.kernel.org>; Wed, 30 Dec 2020 15:30:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73EC2207B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5983+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 8AwkYY4521723xA4z0oTenC3; Wed, 30 Dec 2020 07:30:42 -0800
X-Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
 by mx.groups.io with SMTP id smtpd.web10.7894.1609342242086639986
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Dec 2020 07:30:42 -0800
X-Received: by mail-vs1-f53.google.com with SMTP id u7so8708495vsg.11
        for <cip-dev@lists.cip-project.org>; Wed, 30 Dec 2020 07:30:41 -0800 (PST)
X-Gm-Message-State: 6iN4t8BSd6hFBLiKn9uvm3Hix4520388AA=
X-Google-Smtp-Source: ABdhPJx+Lywlwn2CJR8Vgy3z0Lzd2JUJgEpevceUn44Jh0Png4WIN7gNcpYatrPV1onDg+8Ipnr/Pg==
X-Received: by 2002:a67:e185:: with SMTP id e5mr32936687vsl.22.1609342240616;
        Wed, 30 Dec 2020 07:30:40 -0800 (PST)
X-Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id i17sm6529726vkn.38.2020.12.30.07.30.40
        for <cip-dev@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Dec 2020 07:30:40 -0800 (PST)
X-Received: by mail-vs1-f51.google.com with SMTP id e20so8692575vsr.12
        for <cip-dev@lists.cip-project.org>; Wed, 30 Dec 2020 07:30:40 -0800 (PST)
X-Received: by 2002:a67:fe92:: with SMTP id b18mr35591965vsr.30.1609342239962;
 Wed, 30 Dec 2020 07:30:39 -0800 (PST)
MIME-Version: 1.0
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
Date: Wed, 30 Dec 2020 23:30:28 +0800
X-Gmail-Original-Message-ID: <CAGb2v66uQDUj1fgn2j2mkHQzNXGrfjZ_ygA6ZoHw-sUK=ydJQQ@mail.gmail.com>
Message-ID: <CAGb2v66uQDUj1fgn2j2mkHQzNXGrfjZ_ygA6ZoHw-sUK=ydJQQ@mail.gmail.com>
Subject: [cip-dev] Cip-kernel-sec Updates for Week of 2020-12-31
To: cip-dev@lists.cip-project.org
Cc: Pavel Machek <pavel@denx.de>, Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, 
	masashi.kudo@cybertrust.co.jp
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="6cWlYt93DAtsnr6iKaXb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1609342242;
 bh=3NmAW+Rqul6ED/otMLqmBcRsuTjYJTEBc3muw5a90F4=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=NyJ7MlxBuiT5xr05ZbOrO1AeHXCFNBOoMdx/Ku4QIEf936ZYUCUMMQd1Xf5T2iuyLIC
 PgeCbke9GZdGqHCuUeTAEj+1ZkZzt5NmDBhbceZWKiNSJWBD9qX99kwg31wPJVVXAkaZS
 XcN1mGfpQCVHmMYxJnj49n0/ulbdBk/8O1U=

--6cWlYt93DAtsnr6iKaXb
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

One new issue this week, though information is scarce.

  - CVE-2020-27066 [ipv6/xfrm]

The issue is still undisclosed. It is stated to be fixed,
though ATM it is unknown what the exact fix is.


Regards
ChenYu

--6cWlYt93DAtsnr6iKaXb
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5983): https://lists.cip-project.org/g/cip-dev/message=
/5983
Mute This Topic: https://lists.cip-project.org/mt/79314005/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--6cWlYt93DAtsnr6iKaXb--
