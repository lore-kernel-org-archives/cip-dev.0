Return-Path: <SRS0=HAiU=GV=lists.cip-project.org=bounce+64572+6107+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F35C433DB
	for <cip-dev@archiver.kernel.org>; Mon, 18 Jan 2021 17:17:29 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 978FD222BB
	for <cip-dev@archiver.kernel.org>; Mon, 18 Jan 2021 17:17:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 978FD222BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6107+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ccsDYY4521723x5M5WlippRU; Mon, 18 Jan 2021 09:17:27 -0800
X-Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web11.36760.1610990246640265489
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 Jan 2021 09:17:27 -0800
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 10IHHO3C010031
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Mon, 18 Jan 2021 18:17:24 +0100
X-Received: from [167.87.43.136] ([167.87.43.136])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 10IHHNdK020518;
	Mon, 18 Jan 2021 18:17:23 +0100
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 0/4] Updates & Fixes
To: cip-dev@lists.cip-project.org,
        Quirin Gylstorff <quirin.gylstorff@siemens.com>
References: <20210118150625.20155-1-Quirin.Gylstorff@siemens.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <749081eb-95b1-6d2d-facb-fb23eaa34a8f@siemens.com>
Date: Mon, 18 Jan 2021 18:17:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210118150625.20155-1-Quirin.Gylstorff@siemens.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: TXwfGWqb5of6l8Q6NcngBlA2x4520388AA=
Content-Type: multipart/mixed; boundary="kPYK9AJTiYBzaO46Nyck"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1610990247;
 bh=sGZ5WW2ECeFKHgbGp/5BYFLCvFlvdyYPpmwANhxpx9o=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=QwJyuuMzZ4hWfV7u7rjCh3uxKTYVJ1fkutN7FyXQNvT5QnQnCRFeN/Vw09l6mlKa3Nu
 HEWjeScjFKg8b1F4+UVIirg7fZOySRj+DmVEORqHidOLeO16Jku0FoeBeq+GhsZZH/rsF
 y8N9yZA4e5PJt7CxvNJfDRVr9qsvVDCPnMY=

--kPYK9AJTiYBzaO46Nyck
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 18.01.21 16:06, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> 
> - Update Kernel releases
> - Update ISAR to current HEAD of next
> 
> - fix swupdate cross-compile
> - use libubootenv for swupdate & u-boot this works only with upstream u-boot-tools
>   newer than 2019.10. The isar build is fixed with commit e77d030ed0ac5b122aa7b798131062946cb36699.
> 
> Changes V2:
> - fix recipe name,  add missing rt
> 
> Quirin Gylstorff (4):
>   swupdate: enable cross-compile by setting PKG_CONFIG_PATH
>   swupdate: use libubootenv
>   update linux kernels
>   kas: update ISAR
> 
>  classes/swupdate-config.bbclass                             | 6 +++---
>  kas-cip.yml                                                 | 2 +-
>  recipes-core/swupdate/files/debian/rules.tmpl               | 1 +
>  recipes-core/swupdate/swupdate.bb                           | 2 +-
>  ...35-cip31-rt13.bb => linux-cip-rt_4.19.160-cip39-rt17.bb} | 4 ++--
>  ...231-cip47-rt30.bb => linux-cip-rt_4.4.244.cip51-rt32.bb} | 4 ++--
>  ...ux-cip_4.19.140-cip33.bb => linux-cip_4.19.165-cip41.bb} | 4 ++--
>  ...inux-cip_4.4.230-cip47.bb => linux-cip_4.4.249-cip53.bb} | 4 ++--
>  8 files changed, 14 insertions(+), 13 deletions(-)
>  rename recipes-kernel/linux/{linux-cip-rt_4.19.135-cip31-rt13.bb => linux-cip-rt_4.19.160-cip39-rt17.bb} (54%)
>  rename recipes-kernel/linux/{linux-cip-rt_4.4.231-cip47-rt30.bb => linux-cip-rt_4.4.244.cip51-rt32.bb} (54%)
>  rename recipes-kernel/linux/{linux-cip_4.19.140-cip33.bb => linux-cip_4.19.165-cip41.bb} (53%)
>  rename recipes-kernel/linux/{linux-cip_4.4.230-cip47.bb => linux-cip_4.4.249-cip53.bb} (53%)
> 

Thanks, applied.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--kPYK9AJTiYBzaO46Nyck
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6107): https://lists.cip-project.org/g/cip-dev/message=
/6107
Mute This Topic: https://lists.cip-project.org/mt/79924716/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--kPYK9AJTiYBzaO46Nyck--
