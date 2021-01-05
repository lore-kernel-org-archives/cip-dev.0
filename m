Return-Path: <SRS0=5zRr=GI=lists.cip-project.org=bounce+64572+6042+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D90C433E0
	for <cip-dev@archiver.kernel.org>; Tue,  5 Jan 2021 17:47:23 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31E8220449
	for <cip-dev@archiver.kernel.org>; Tue,  5 Jan 2021 17:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org; dmarc=permerror header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6042+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id n1JVYY4521723xAUF9f85iIK; Tue, 05 Jan 2021 09:47:22 -0800
X-Received: from imap3.hz.codethink.co.uk (imap3.hz.codethink.co.uk [176.9.8.87])
 by mx.groups.io with SMTP id smtpd.web10.317.1609868841487531625
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Jan 2021 09:47:21 -0800
X-Received: from host-92-5-250-55.as43234.net ([92.5.250.55] helo=[192.168.1.13])
	by imap3.hz.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
	id 1kwqQ8-0001Xt-TU; Tue, 05 Jan 2021 17:47:00 +0000
Subject: Re: [cip-dev] [PATCH v3 4.19.y-cip 08/17] spi: spi-mem: export spi_mem_default_supports_op()
To: cip-dev@lists.cip-project.org, Pavel Machek <pavel@denx.de>,
 Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210105135757.11069-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20210105135757.11069-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20210105165146.GB361@amd>
From: "Sudip Mukherjee" <sudip.mukherjee@codethink.co.uk>
Message-ID: <91eb8a79-a7e5-542a-b3d7-f54d17c29f47@codethink.co.uk>
Date: Tue, 5 Jan 2021 17:47:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20210105165146.GB361@amd>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: XkmPZdVMHG3E9v8S3NFIBgimx4520388AA=
Content-Type: multipart/mixed; boundary="OiPonoFmoC9LAm5KvwMl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1609868842;
 bh=1t6zjOD9D1Hm0WAMz6pt+mXXXXV/DLNQJEPLuKVonhs=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=eVM558LIcAk3EtX7syA4JDDWhTjPmC8Pf3GKgW7W0FzgSis8z017XKnKKKqYdRlnqaD
 R5oU6mFdbkw39ku2vk4L+02Jt/MGIl6LO8uH946E7llWxr4Pvxn6SybMElgPV/EL5LJW0
 Qmc2XTEM1A96/9eWwttgcW8y6vyTGbuO4Zo=

--OiPonoFmoC9LAm5KvwMl
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit



On 05/01/2021 16:51, Pavel Machek wrote:
> Hi!
> 
>> From: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
>  
>> This patch also squashes upstream commit 72e6841608b9 ("spi: spi-mem: Fix
>> build error without CONFIG_SPI_MEM")' in the current patch as commit
>> 46109648052f ("spi: spi-mem: export spi_mem_default_supports_op()")'
>> introduced below build error when built without CONFIG_SPI_MEM:
> 
> This puts function definition directly into header file; I don't think
> that will work when multiple files include it.
> 
> Adding "static inline" is the usual solution for this.

Has been done upstream by b5881b153bc8 ("spi: spi-mem: Make
spi_mem_default_supports_op() static inline")

I was once raising this concern internally that when commits are
backported not all of them are backported but since I did not know
enough about how CIP wants to do the backporting so never raised the
issue. But this is an example what I was concerned about.



-- 
Regards
Sudip

--OiPonoFmoC9LAm5KvwMl
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6042): https://lists.cip-project.org/g/cip-dev/message=
/6042
Mute This Topic: https://lists.cip-project.org/mt/79450068/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--OiPonoFmoC9LAm5KvwMl--
