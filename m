Return-Path: <SRS0=xOr6=FE=lists.cip-project.org=bounce+64572+5905+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F5CC64E7B
	for <cip-dev@archiver.kernel.org>; Mon, 30 Nov 2020 18:41:15 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B518220725
	for <cip-dev@archiver.kernel.org>; Mon, 30 Nov 2020 18:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Xv3tMs4i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B518220725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5905+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id XUDCYY4521723x50hcv6XjQJ; Mon, 30 Nov 2020 10:41:13 -0800
X-Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web11.1299.1606761671917037169
 for <cip-dev@lists.cip-project.org>;
 Mon, 30 Nov 2020 10:41:13 -0800
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 0AUIf9h8008968
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Mon, 30 Nov 2020 19:41:09 +0100
X-Received: from [167.87.39.132] ([167.87.39.132])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 0AUIf8NN013095;
	Mon, 30 Nov 2020 19:41:09 +0100
Subject: Re: [cip-dev] [isar-cip-core][PATCH v2 0/2] Secureboot fixes
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>,
        cip-dev@lists.cip-project.org
References: <20201130144842.4221-1-Quirin.Gylstorff@siemens.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <8a383584-586f-feb4-8256-4a51ce141da4@siemens.com>
Date: Mon, 30 Nov 2020 19:41:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201130144842.4221-1-Quirin.Gylstorff@siemens.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 5NBvP1KGLGWQZDBJruK9AaISx4520388AA=
Content-Type: multipart/mixed; boundary="gE8iwDia6qEn4ya9Z9Ky"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606761673;
 bh=7rGB5HWhKp//h8Pw6hTr2oCcUOZG4O+haGUjheRmJXM=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=Xv3tMs4ikx5IHqoObr0KCm6k6hC6wHr6rCvO0DeiPdJlrdHA7VyIkrZw9AC50CoTbmX
 2sEzm4R1hNNGACmIAprG3KBgR4d97XIw1PF8+rwUamnjZ5kjnOUFdO6zyKH29bFYXh26A
 9Z5gVuwgBPNrRbc0U239S2Lk0Zes6wsFOAA=

--gE8iwDia6qEn4ya9Z9Ky
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 30.11.20 15:48, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Adapt OVMF binaries to new upstream names.
> Repeat scan for rootfs until udev finished populating /dev or a timeout occurs.
> Build at:
> https://gitlab.com/Quirin.Gy/isar-cip-core/-/pipelines/223158898
> 
> --
> Changes Version 2:
> - fix author and commit message
> 
> Vijai Kumar K (2):
>   start-qemu.sh: Change OVMF binary names
>   Secureboot:  Wait until udev populates /dev
> 
>  doc/README.secureboot.md                      |  12 +-
>  .../files/secure-boot-debian-local-patch      | 104 +++++++++++-------
>  start-qemu.sh                                 |   4 +-
>  3 files changed, 72 insertions(+), 48 deletions(-)
> 

Thanks, applied.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--gE8iwDia6qEn4ya9Z9Ky
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5905): https://lists.cip-project.org/g/cip-dev/message=
/5905
Mute This Topic: https://lists.cip-project.org/mt/78609367/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--gE8iwDia6qEn4ya9Z9Ky--
