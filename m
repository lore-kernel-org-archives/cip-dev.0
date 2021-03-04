Return-Path: <SRS0=TP6T=IC=lists.cip-project.org=bounce+64572+6207+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7838DC433E0
	for <cip-dev@archiver.kernel.org>; Thu,  4 Mar 2021 04:38:37 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB3F064EDF
	for <cip-dev@archiver.kernel.org>; Thu,  4 Mar 2021 04:38:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB3F064EDF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6207+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id WDHeYY4521723xqD8hK2ULKN; Wed, 03 Mar 2021 20:38:36 -0800
X-Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
 by mx.groups.io with SMTP id smtpd.web12.2562.1614832715272310638
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Mar 2021 20:38:35 -0800
X-Received: by mail-lj1-f169.google.com with SMTP id t9so2492793ljt.8
        for <cip-dev@lists.cip-project.org>; Wed, 03 Mar 2021 20:38:34 -0800 (PST)
X-Gm-Message-State: 96TKOKlVD82c4Z2RGEwanr3Zx4520388AA=
X-Google-Smtp-Source: ABdhPJzmKZlEzMX3dFCVSO7nqkv/2AJIGV4Da70EheTTn+48v9zzQuY0g9DGxZbkR5oaYbMNgQ1jDQ==
X-Received: by 2002:a05:651c:1067:: with SMTP id y7mr1216252ljm.429.1614832713072;
        Wed, 03 Mar 2021 20:38:33 -0800 (PST)
X-Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id r3sm1580056ljn.13.2021.03.03.20.38.32
        for <cip-dev@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Mar 2021 20:38:32 -0800 (PST)
X-Received: by mail-lf1-f49.google.com with SMTP id 18so32400751lff.6
        for <cip-dev@lists.cip-project.org>; Wed, 03 Mar 2021 20:38:32 -0800 (PST)
X-Received: by 2002:a19:e12:: with SMTP id 18mr1259274lfo.296.1614832712567;
 Wed, 03 Mar 2021 20:38:32 -0800 (PST)
MIME-Version: 1.0
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
Date: Thu, 4 Mar 2021 12:38:21 +0800
X-Gmail-Original-Message-ID: <CAGb2v66D2t0asUDNafOi+fLwAyt0sLqZ2TMjEuz=JtTaPA6GLw@mail.gmail.com>
Message-ID: <CAGb2v66D2t0asUDNafOi+fLwAyt0sLqZ2TMjEuz=JtTaPA6GLw@mail.gmail.com>
Subject: [cip-dev] Cip-kernel-sec Updates for Week of 2021-03-04
To: cip-dev@lists.cip-project.org
Cc: Pavel Machek <pavel@denx.de>, Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, 
	masashi.kudo@cybertrust.co.jp
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="7B60X4fFNNZuGCEopPDM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1614832716;
 bh=/8OqD/0GVZwJNvx40hDJOheVdv+eQLb++URGfPLrTpM=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=lU5TLJQuUg0QpHQsdrRf0paZSxnMs3qp3lULiUg0HdUCuoHqkhFErtdKnZaWSSysUiS
 WR6BTcPLYpeS+Vp7LdCTze8u2urt0tG+vMpwdYUT9QgUuXElo2i8/9JNFg/vrn6ve6ZXR
 3etQBrkMZnrC/Qzc12Pm0TXbFoyV4/VrhYw=

--7B60X4fFNNZuGCEopPDM
Content-Type: text/plain; charset="UTF-8"

Hi,

This week there are three new issues:

- CVE-2021-0399 [net/xt_qtaguid] - Android kernel only
- CVE-2021-0447 [l2tp] - Fixed in all kernels
- CVE-2021-0448 [netfilter/ctnetlink] - Duplicate of CVE-2020-25211.
                                        Fixed in all kernels.

In addition, CVE-2020-25639 (nVidia / nouveau) is now fixed.
CVE-2020-29368 requires another patch for 4.9, which is queued up for
4.9.259.

I also added CVE-2020-27067, which was missing from our archive.
This is a superset of CVE-2021-0447, and is already fixed.

Last, I fixed a bug in the Debian import script that I introduced
last week. Fixes spanning multiple releases should now be parsed
correctly. The Ubuntu import script was fixed to correctly parse
alternative comment styles. Comments from Ubuntu maintainers are
now correctly grouped.


Regards
ChenYu

--7B60X4fFNNZuGCEopPDM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6207): https://lists.cip-project.org/g/cip-dev/message=
/6207
Mute This Topic: https://lists.cip-project.org/mt/81070928/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--7B60X4fFNNZuGCEopPDM--
