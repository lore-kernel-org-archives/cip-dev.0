Return-Path: <SRS0=a16a=FF=lists.cip-project.org=bounce+64572+5932+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC193C64E7A
	for <cip-dev@archiver.kernel.org>; Tue,  1 Dec 2020 16:35:19 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C26152151B
	for <cip-dev@archiver.kernel.org>; Tue,  1 Dec 2020 16:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Ge2F3G90"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C26152151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5932+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 7RTMYY4521723x3bSlmApTjd; Tue, 01 Dec 2020 08:35:17 -0800
X-Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web12.12839.1606840516122065795
 for <cip-dev@lists.cip-project.org>;
 Tue, 01 Dec 2020 08:35:17 -0800
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 0B1GZDQw021991
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Tue, 1 Dec 2020 17:35:13 +0100
X-Received: from [167.87.33.175] ([167.87.33.175])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 0B1GZDlf025675
	for <cip-dev@lists.cip-project.org>; Tue, 1 Dec 2020 17:35:13 +0100
Subject: Re: [cip-dev] [isar-cip-core][PATCH 0/3] Some updates
From: "Jan Kiszka" <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
References: <cover.1606764736.git.jan.kiszka@siemens.com>
Message-ID: <2bce9fc8-dc9c-dbc7-0195-89324c33391b@siemens.com>
Date: Tue, 1 Dec 2020 17:35:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <cover.1606764736.git.jan.kiszka@siemens.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 1l1EIidDV2Ppv0kjJA1AgXPsx4520388AA=
Content-Type: multipart/mixed; boundary="2KNZwvWhRbQftSic9bqn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606840517;
 bh=5LPzPLOtGW0cIVtIGPPQgDczp1C0ocEOa0908n/N5ag=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=Ge2F3G90iQn88filSIUwBSUth++fltt+FcOEYPwRgtyoBnqMx8dqr1ZzDEwwDcg//Lr
 xb5PeLb9gtQ44+Gq1NlmV7DTTxAUBIacSSzjvVlhB9SXUnhLd9eZP9vPZHl56fYLk1qaA
 wU7rEgqH/wVKQaw7DN5qEg88yfdp4BCS/q8=

--2KNZwvWhRbQftSic9bqn
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 30.11.20 20:32, Jan Kiszka wrote:
> The last patch has to wait until [1] is rolled out to our CI
> infrastructure.
> 

All in next now, Michael updated our gitlab-cloud-ci.

Jan

> Jan
> 
> [1] https://gitlab.com/cip-project/cip-testing/gitlab-cloud-ci/-/commit/1cd85bec680587b9410c56cdfebc3a4d6ba1bd8b
> 
> Jan Kiszka (3):
>   README: Add some community resources
>   Update Isar revision
>   Update to kas 2.3.3
> 
>  .gitignore                                    |   3 +-
>  .gitlab-ci.yml                                |   2 +-
>  README.md                                     |  29 ++-
>  conf/distro/cip-core-buster.conf              |   2 +
>  conf/distro/cip-core-stretch.conf             |   2 +
>  doc/README.secureboot.md                      |   4 +-
>  doc/README_iwg20m.md                          |  11 +-
>  .../0001-u-boot-add-libubootenv.patch         | 168 ------------------
>  kas-cip.yml                                   |   9 +-
>  kas/board/bbb.yml                             |   2 +-
>  kas/board/hihope-rzg2m.yml                    |   2 +-
>  kas/board/iwg20m.yml                          |   2 +-
>  kas/board/qemu-amd64.yml                      |   2 +-
>  kas/board/simatic-ipc227e.yml                 |   2 +-
>  kas/opt/4.4.yml                               |   2 +-
>  kas/opt/ebg-secure-boot-base.yml              |   2 +-
>  kas/opt/ebg-secure-boot-snakeoil.yml          |   2 +-
>  kas/opt/ebg-swu.yml                           |   2 +-
>  kas/opt/qemu-swupdate.yml                     |   2 +-
>  kas/opt/rt.yml                                |   2 +-
>  kas/opt/security.yml                          |   2 +-
>  kas/opt/stretch.yml                           |   2 +-
>  kas/opt/targz-img.yml                         |   2 +-
>  kas/opt/test.yml                              |   2 +-
>  .../wic/plugins/source/efibootguard-boot.py   |   2 +-
>  .../wic/plugins/source/efibootguard-efi.py    |   2 +-
>  26 files changed, 57 insertions(+), 207 deletions(-)
>  delete mode 100644 isar-patches/0001-u-boot-add-libubootenv.patch
> 
> 
> 
> 
> 

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--2KNZwvWhRbQftSic9bqn
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5932): https://lists.cip-project.org/g/cip-dev/message=
/5932
Mute This Topic: https://lists.cip-project.org/mt/78616510/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--2KNZwvWhRbQftSic9bqn--
