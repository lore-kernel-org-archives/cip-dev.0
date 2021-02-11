Return-Path: <SRS0=gfMf=HN=lists.cip-project.org=bounce+64572+6167+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CBDC433E6
	for <cip-dev@archiver.kernel.org>; Thu, 11 Feb 2021 08:50:48 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FA0F64E66
	for <cip-dev@archiver.kernel.org>; Thu, 11 Feb 2021 08:50:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FA0F64E66
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6167+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Poe9YY4521723xqfeiDQFXNK; Thu, 11 Feb 2021 00:50:46 -0800
X-Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
 by mx.groups.io with SMTP id smtpd.web10.5996.1613033445771406720
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Feb 2021 00:50:46 -0800
X-Received: by mail-lj1-f182.google.com with SMTP id v6so1788255ljh.9
        for <cip-dev@lists.cip-project.org>; Thu, 11 Feb 2021 00:50:45 -0800 (PST)
X-Gm-Message-State: glyhXtuBWwes7dFDnYBauggax4520388AA=
X-Google-Smtp-Source: ABdhPJwcEIWaFaIi3TdHLV9UgSEY+9AJxXTuT9TAg38LZ1gIRDE2BpgT+y3v4s4gIHxXRJGV7S7kqg==
X-Received: by 2002:a2e:8706:: with SMTP id m6mr4361431lji.254.1613033443758;
        Thu, 11 Feb 2021 00:50:43 -0800 (PST)
X-Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id n5sm583986lfl.245.2021.02.11.00.50.43
        for <cip-dev@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Feb 2021 00:50:43 -0800 (PST)
X-Received: by mail-lf1-f51.google.com with SMTP id w36so7002074lfu.4
        for <cip-dev@lists.cip-project.org>; Thu, 11 Feb 2021 00:50:43 -0800 (PST)
X-Received: by 2002:ac2:5452:: with SMTP id d18mr3882766lfn.233.1613033443076;
 Thu, 11 Feb 2021 00:50:43 -0800 (PST)
MIME-Version: 1.0
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
Date: Thu, 11 Feb 2021 16:50:30 +0800
X-Gmail-Original-Message-ID: <CAGb2v64SEFQBXfGhC_WDP-2SyJbtAdzmsdZjbiygUhP9pE4a0g@mail.gmail.com>
Message-ID: <CAGb2v64SEFQBXfGhC_WDP-2SyJbtAdzmsdZjbiygUhP9pE4a0g@mail.gmail.com>
Subject: [cip-dev] Cip-kernel-sec Updates for Week of 2021-02-11
To: cip-dev@lists.cip-project.org
Cc: Pavel Machek <pavel@denx.de>, Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, 
	masashi.kudo@cybertrust.co.jp
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="Vl0HVNFL0u67voPRqFvI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1613033446;
 bh=Jt/gsyws1EYO66mcEehBGMPsav2sDOoiX/uvTWtSDiQ=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=cj+OJ/3ytN6HgI6lMyTr17PbhVf1QqPad4hbZwpW6RpkhXT+NUqOhU0pmSoURtewQzB
 KdfxW3hyWLmauohiZz8eypDU9+Z5mQWlsMbsQqckUOK0o33XLpJQM0VleQwgQV8RQ+qA6
 E+qQvB63pQ0FZDMf8QRxkRfkfT4LnLu4w3Y=

--Vl0HVNFL0u67voPRqFvI
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

Six new issues this week:
- CVE-2020-12362, CVE-2020-12363, CVE-2020-12364:
  CVEs from Intel Advisory affecting Intel Graphics Driver. Details unknown

- CVE-2021-20194 [bpf heap overflow] - fixed for relevant kernels
- CVE-2021-20226 [io_uring UAF] - likely a duplicate of
CVE-2020-29534, already fixed
- CVE-2021-26708 [AF_VSOCK: local priv. escalation] - fixed for relevant kernels

Additionally, CVE-2021-3347 is fixed for 4.4 and 4.9.
I still need to match patches for 4.4 against 4.9, but it looks like
the fixes are there.


Regards
ChenYu

--Vl0HVNFL0u67voPRqFvI
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6167): https://lists.cip-project.org/g/cip-dev/message=
/6167
Mute This Topic: https://lists.cip-project.org/mt/80553474/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--Vl0HVNFL0u67voPRqFvI--
