Return-Path: <SRS0=u10o=GK=lists.cip-project.org=bounce+64572+6051+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D335C433E0
	for <cip-dev@archiver.kernel.org>; Thu,  7 Jan 2021 06:43:37 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5026D22E00
	for <cip-dev@archiver.kernel.org>; Thu,  7 Jan 2021 06:43:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5026D22E00
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6051+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id rTLeYY4521723xlncbWh042N; Wed, 06 Jan 2021 22:43:35 -0800
X-Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
 by mx.groups.io with SMTP id smtpd.web09.5066.1610001814422972625
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Jan 2021 22:43:34 -0800
X-Received: by mail-lf1-f48.google.com with SMTP id l11so12278727lfg.0
        for <cip-dev@lists.cip-project.org>; Wed, 06 Jan 2021 22:43:34 -0800 (PST)
X-Gm-Message-State: ZNF31sUZTPQ8syN8WgsvigO1x4520388AA=
X-Google-Smtp-Source: ABdhPJwZOfpLlteWT582hm4d/fM3MA6RakR2Moi4x6xIEIxQVcT328VqAA8I3mzlHxLDj0WY0nSbBQ==
X-Received: by 2002:a2e:4c11:: with SMTP id z17mr3739165lja.364.1610001812190;
        Wed, 06 Jan 2021 22:43:32 -0800 (PST)
X-Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id b7sm991766ljf.76.2021.01.06.22.43.31
        for <cip-dev@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jan 2021 22:43:32 -0800 (PST)
X-Received: by mail-lf1-f49.google.com with SMTP id o17so12215807lfg.4
        for <cip-dev@lists.cip-project.org>; Wed, 06 Jan 2021 22:43:31 -0800 (PST)
X-Received: by 2002:a2e:89d7:: with SMTP id c23mr3428351ljk.282.1610001811845;
 Wed, 06 Jan 2021 22:43:31 -0800 (PST)
MIME-Version: 1.0
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
Date: Thu, 7 Jan 2021 14:43:20 +0800
X-Gmail-Original-Message-ID: <CAGb2v65+1w18yz2R=GbxrFtq_RZO4afHry-DMgj83NGKsttBgQ@mail.gmail.com>
Message-ID: <CAGb2v65+1w18yz2R=GbxrFtq_RZO4afHry-DMgj83NGKsttBgQ@mail.gmail.com>
Subject: [cip-dev] Cip-kernel-sec Updates for Week of 2021-01-07
To: cip-dev@lists.cip-project.org
Cc: Pavel Machek <pavel@denx.de>, Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, 
	masashi.kudo@cybertrust.co.jp
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="6G0z19WiLwj9TOHnQ48u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1610001815;
 bh=7rVuXWgAhv1gRuGU4g22vfw/6M2zfknhJ96ca5VN8V8=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=IfCJSiX+t9u+HM6Dde+GgWDVwoiOZvhmQvfN6tGW6cc/DPQ+b3H9YmV1KmPnM4KQIxB
 TP4y37ebGoZRc0wx3yygkbPuJTs8HFs9m4BDdy75FZrT6mMQ29R9Qfo1FzWZW5TQIeLcH
 Ij9hRh+e+AqXJljzwKLGgTQfLU2EBSQ7oL0=

--6G0z19WiLwj9TOHnQ48u
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

Three new issues this week:

- CVE-2020-35499 [bluetooth/sco] - fixed in all relevant kernels
- CVE-2020-36158 [mwifiex] - fixed in mainline; needs backport
- CVE-2021-0342 [net/tun] - fixed in all relevant kernels


Regards
ChenYu

--6G0z19WiLwj9TOHnQ48u
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6051): https://lists.cip-project.org/g/cip-dev/message=
/6051
Mute This Topic: https://lists.cip-project.org/mt/79494128/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--6G0z19WiLwj9TOHnQ48u--
