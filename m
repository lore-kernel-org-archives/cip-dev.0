Return-Path: <SRS0=+ZIx=DY=lists.cip-project.org=bounce+64572+5589+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86A7C433DF
	for <cip-dev@archiver.kernel.org>; Sat, 17 Oct 2020 09:36:11 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71F012074A
	for <cip-dev@archiver.kernel.org>; Sat, 17 Oct 2020 09:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="NrPDwtmt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71F012074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5589+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id KRhDYY4521723x4AKwF1rLhQ; Sat, 17 Oct 2020 02:36:09 -0700
X-Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web10.9531.1602927368669212599
 for <cip-dev@lists.cip-project.org>;
 Sat, 17 Oct 2020 02:36:09 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 09H9a5bf005708
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Oct 2020 11:36:06 +0200
X-Received: from [167.87.128.166] ([167.87.128.166])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 09H9a0JF030099;
	Sat, 17 Oct 2020 11:36:03 +0200
Subject: Re: [cip-dev] Camera CSI support for IMX
To: cip-dev@lists.cip-project.org,
        Rajashree Sankar <rajashree.sankar@sanmina.com>
References: <CA+UxhRrWr_1VNmcrujPKjPWxoZw47XCSpGY2sqbkein2vHtYug@mail.gmail.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <8ba7cf9c-7f55-7f06-4e34-6f4d92cce821@siemens.com>
Date: Sat, 17 Oct 2020 11:36:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CA+UxhRrWr_1VNmcrujPKjPWxoZw47XCSpGY2sqbkein2vHtYug@mail.gmail.com>
X-MIME-Autoconverted: from 8bit to quoted-printable by david.siemens.de id 09H9a5bf005708
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 4BnYkSrC05l4Kr2NoqGTwgOyx4520388AA=
Content-Type: multipart/mixed; boundary="RO9zL5ESLOTaQf5m4vbD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1602927369;
 bh=Qwepxqy/XfFN51J1m0kbe2Y3LuDPbIe7Y2N762l3atw=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=NrPDwtmt22+Mr/5q4UguLxr52DedmJCnEAHrxvP9ad5ttHVkrw/40xEgjgJ026xg4KK
 IfBisCKeabNd8S5SiU5xHzIem5xvWXWLCVyu/b9G6HS2UYGel44uoXsgTxCeL4oeTu7xS
 BRMtJkhpx608pyBQ9vPzU1cTiPUgW/7VKYE=

--RO9zL5ESLOTaQf5m4vbD
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Rajashree,

On 16.10.20 12:25, Rajashree Sankar wrote:
> =C2=A0Hello,
> We are using Linux-CIP Kernel Version 4.19.140-cip33. We do not find IM=
X
> files=C2=A0 in the Kernel supporting Camera Capture through CSI.Could y=
ou get
> us=C2=A0 how the support can be added?

Can you be more specific about what kernel driver(s) you are missing? Is
latest 5.9 supporting this? Then please provide a reference (driver
name, DT bindings or even commit list).

Or are you referring to a feature of the vendor tree (linux-imx)? Then
please talk to NXP and ask about the status of this, if there is an
upstream equivalent by now or if this has been abandoned by them.

CIP has a strict upstream-first policy, so we can't take any downstream
patches. However, if a feature is upstream and only missed the latest
CIP kernel, you can propose backported patches for integration into that
kernel. Preconditions:

 - they are not invasive to other drivers or the kernel as a whole

 - you are a CIP member, or the CIP member community supports the
   backport (as it may increase our workload)

> Thanks and Regards,
> Rajashree Sankar
>=20
> CONFIDENTIALITY
> This e-mail message and any attachments thereto, is intended only for
> [...]

If configurable on your client, please disable this footer when posting
to public lists. It's irrelevant here because the content can't be
confidential due to the target public audience. This only bloats your
messages.

Jan

--=20
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--RO9zL5ESLOTaQf5m4vbD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5589): https://lists.cip-project.org/g/cip-dev/message=
/5589
Mute This Topic: https://lists.cip-project.org/mt/77547893/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--RO9zL5ESLOTaQf5m4vbD--
