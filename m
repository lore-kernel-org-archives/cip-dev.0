Return-Path: <SRS0=5qsD=EL=lists.cip-project.org=bounce+64572+5752+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C291EC4742C
	for <cip-dev@archiver.kernel.org>; Thu,  5 Nov 2020 14:04:12 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3BBC2074B
	for <cip-dev@archiver.kernel.org>; Thu,  5 Nov 2020 14:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="TvhU+jev"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3BBC2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5752+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id I0peYY4521723xL7KqCFKqVV; Thu, 05 Nov 2020 06:04:10 -0800
X-Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
 by mx.groups.io with SMTP id smtpd.web11.7662.1604584557909712001
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Nov 2020 05:55:58 -0800
X-Received: by mail-lf1-f49.google.com with SMTP id y184so2376929lfa.12
        for <cip-dev@lists.cip-project.org>; Thu, 05 Nov 2020 05:55:57 -0800 (PST)
X-Gm-Message-State: W0xHgYWzooGCOyp16EEGeeVWx4520388AA=
X-Google-Smtp-Source: ABdhPJwf2WD/PKj1t/0nAAYdOr3ErbXyFDOSH79FY4IftN/hExJYXFw0EQqKGc87ofyYCFru8X+aAJ5RVRBY2UVXyvg=
X-Received: by 2002:a05:6512:322d:: with SMTP id f13mr967606lfe.571.1604584555366;
 Thu, 05 Nov 2020 05:55:55 -0800 (PST)
MIME-Version: 1.0
From: Chen-Yu Tsai <wens213@gmail.com>
Date: Thu, 5 Nov 2020 21:55:45 +0800
Message-ID: <CAGb2v67MYXSM9Jdk4-nEnEpzCOHPNqfQeFu0ZW-eM+3vpJLCmw@mail.gmail.com>
Subject: [cip-dev] cip-kernel-sec Updates for Week of 2020-11-05
To: cip-dev@lists.cip-project.org, 
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: Pavel Machek <pavel@denx.de>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="t4txYq2kTtUkOFe5NC2k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604585050;
 bh=PEwTVxxhkS377t4hUE5y3TymdLZmnkcLMd9BEkPpJIQ=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=TvhU+jev0Y88iOtOmEoXWHxIFMzXMqCa7vm2mKMTeyOEBZOVKIjmk+FLq3KXjInUGkk
 Wt66sEk4lnOiv0rjKXOqkHo6z8iTVh6rf/LL1wxXAZBzD/eLq4s3KYUZo079ViYkV+V3l
 HmaBq+A/VsmSnn/Os8f9f5vQgoQ9uOhTL9Y=

--t4txYq2kTtUkOFe5NC2k
Content-Type: text/plain; charset="UTF-8"

New CVEs:

- CVE-2020-25668 [concurrency use-after-free in vt] - fixed for v4.19 and later
- CVE-2020-25670 [net/nfc/llcp res. leak]
- CVE-2020-25671 [net/nfc/llcp res. leak]
- CVE-2020-25672 [net/nfc/llcp res. leak]
- CVE-2020-25673 [net/nfc/llcp res. leak]

No member enables NFC so we can ignore 25670 ~ 25673.

Old CVEs now fixed:

- CVE-2020-25656 [use-after-free in vt_do_kdgkb_ioctl] - fixed for
v4.14 and later

For CVE-2020-25668, the commit log says the bug has been around for at
least 12 years,
so likely needing a backport to older kernels.

For CVE-2020-25656, we still need to identify when it was introduced.

Regards,
ChenYu
Moxa

--t4txYq2kTtUkOFe5NC2k
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5752): https://lists.cip-project.org/g/cip-dev/message=
/5752
Mute This Topic: https://lists.cip-project.org/mt/78051192/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--t4txYq2kTtUkOFe5NC2k--
