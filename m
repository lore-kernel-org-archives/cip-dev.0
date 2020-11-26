Return-Path: <SRS0=tFpe=FE=lists.cip-project.org=bounce+64572+5889+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB7DC64E7B
	for <cip-dev@archiver.kernel.org>; Mon, 30 Nov 2020 13:56:13 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F90820855
	for <cip-dev@archiver.kernel.org>; Mon, 30 Nov 2020 13:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="so8yoqfM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F90820855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5889+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Ron2YY4521723xB8YLeDW6qL; Mon, 30 Nov 2020 05:56:11 -0800
X-Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
 by mx.groups.io with SMTP id smtpd.web08.2064.1606376958726693448
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Nov 2020 23:49:18 -0800
X-Received: by mail-vs1-f50.google.com with SMTP id u133so473140vsu.12
        for <cip-dev@lists.cip-project.org>; Wed, 25 Nov 2020 23:49:18 -0800 (PST)
X-Gm-Message-State: yoMRcU7ZLNsmcLNw4WZGIjROx4520388AA=
X-Google-Smtp-Source: ABdhPJzm/y5TcMVOKCzK41vSxlhFVoO5SEee9WQSSE9z0NFZqH7Sw9tPPPUDA0awPzCh607n6PN6jVyLcjX+JWWG9vg=
X-Received: by 2002:a05:6102:832:: with SMTP id k18mr1075173vsb.2.1606376957480;
 Wed, 25 Nov 2020 23:49:17 -0800 (PST)
MIME-Version: 1.0
From: Chen-Yu Tsai <wens213@gmail.com>
Date: Thu, 26 Nov 2020 15:49:05 +0800
Message-ID: <CAGb2v64N6X=xYeRG2yOMzCKPveXsisqgmSmBwGrVV-rETNhk4w@mail.gmail.com>
Subject: [cip-dev] Cip-kernel-sec Updates for Week of 2020-11-26
To: cip-dev@lists.cip-project.org
Cc: Pavel Machek <pavel@denx.de>, Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="grImQCdA2ySA0ae4guqI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606744571;
 bh=iCRX5zH682zmJZYHDEh0J/jNuzVhj2KxjoxnmGIeGPk=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=so8yoqfM9q9BP6CVCd0oUpVQm6wo1UEfrCOy55yEFqgbZkQsuC/eoRc1mqly/yaMZ7W
 Fdy3wGK6xrziZX2dHe2+orjr8zkgG5cj6V5VBCoAzfYSlQl+Zm5xJBdjHGVeu1dVLW9k+
 XeVBHZ8hB1xiHxj0Sn2XiT/g33hqct7Fd3g=

--grImQCdA2ySA0ae4guqI
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

This week we have six new issues:

- CVE-2020-15436 [blockdev UAF] - Fixed in all stable kernels

- CVE-2020-15437 [serial/8250 NULL pointer dereference] -
  Fixed in all stable kernels

- CVE-2020-27777 [powerpc/rtas usage check] - Fix backported to 4.14+

Since no member requires ppc support, we can ignore this.
Though if anyone wishes to look into this, this might require backporting
to 4.4 and 4.9.

- CVE-2020-28915 [fbcon_get_font() global-out-of-bounds] -
  Fixed in all stable kernels

- CVE-2020-28941 [accessibility/speakup] - Fixed in relevant stable kernels

- CVE-2020-4788 [powerpc/power9 speculation] - Fixed in 4.9, 4.19, and mainline

The stable commits were imported from Debian, which only tracks 4.9 and 4.19.
4.9 requires one less commit compared to 4.19 and mainline. I suspect 4.14
and 5.4 might also contain the fixes, but manual matching would be required.


Regarding old issues:

CVE-2020-27673 is fixed for 4.9 with one less commit than mainline, due to
a feature introduced later. I suspect 4.4 might be the same, but this will
require some manual matching.

CVE-2019-12881 marked as fixed for all stable kernels.

CVE-2020-slab-out-of-bounds-read-fbcon is now CVE-2020-28974.


Regards
ChenYu

--grImQCdA2ySA0ae4guqI
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5889): https://lists.cip-project.org/g/cip-dev/message=
/5889
Mute This Topic: https://lists.cip-project.org/mt/78608275/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--grImQCdA2ySA0ae4guqI--
