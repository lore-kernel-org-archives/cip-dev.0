Return-Path: <SRS0=WvfZ=K2=lists.cip-project.org=bounce+64572+6484+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9E7C47080
	for <cip-dev@archiver.kernel.org>; Mon, 31 May 2021 12:49:38 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBC8C61279
	for <cip-dev@archiver.kernel.org>; Mon, 31 May 2021 12:49:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBC8C61279
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6484+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id hdSCYY4521723x39XQ2XSzJX; Mon, 31 May 2021 05:49:37 -0700
X-Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web09.43838.1622465376355695616
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 May 2021 05:49:36 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 14VCnYTK014233
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Mon, 31 May 2021 14:49:34 +0200
X-Received: from [167.87.247.112] ([167.87.247.112])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 14VCnY3i006540;
	Mon, 31 May 2021 14:49:34 +0200
Subject: Re: [cip-dev][isar-cip-core][PATCH 0/5] Add ci for secure-boot and swupdate
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>,
        cip-dev@lists.cip-project.org
References: <20210527131741.8828-1-Quirin.Gylstorff@siemens.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <f9cb353c-bf8a-452d-9d59-4713cd0feaa4@siemens.com>
Date: Mon, 31 May 2021 14:49:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210527131741.8828-1-Quirin.Gylstorff@siemens.com>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: alSNeDE1uMqqmrl66XGe9A3bx4520388AA=
Content-Type: multipart/mixed; boundary="tuR2KzpRK2UmK8B9MW1L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1622465377;
 bh=uiWVsygtJPA2PKlnxWKS+h+3EfTlYAIRyHIrwY998qQ=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=sXaF+6DgYIw5WtCYpek9DNWf+PVwPtSI6gsxTVr59BAdyOCeSWJeW5jXb19zxGCiWCf
 O7S9vcYZvI6cKjeVwCUrKNGYz5xpW/jOgZrEJJHhlvq0zyNOscbFkcrh7W+81meRFAlg0
 YELKw4EsSUq8TNEKSw+l6bTRCWoxVvWYHnU=

--tuR2KzpRK2UmK8B9MW1L
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 27.05.21 15:17, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Add the following ci builds:
>  - qemu-amd64 ebg-secure-boot-snakeoil
>  - qemu-amd64 ebg-swu (efibootguard + swupdate)
>  - qemu-amd65 ebg-snakeoil-swu (efibootguard + secure-boot + swupdate)
> 
> This patch set also fixes issues for these ci builds.
> 
> Quirin Gylstorff (5):
>   swupdate-config: add dependency to u-boot-${MACHINE}-config
>   kas/opt: Allow override of WKS_FILE in swupdate option
>   .gitlabci.yml: add secureboot build
>   .gitlabci.yml: add swupdate build
>   .gitlabci.yml: Add secure-boot and swupdate build
> 
>  .gitlab-ci.yml                  | 33 +++++++++++++++++++++++++++++++++
>  classes/swupdate-config.bbclass |  4 +++-
>  kas/opt/ebg-snakeoil-swu.yml    | 17 +++++++++++++++++
>  kas/opt/ebg-swu.yml             | 16 ++++++++++++++++
>  kas/opt/efibootguard.yml        |  2 ++
>  kas/opt/swupdate.yml            |  4 ++--
>  6 files changed, 73 insertions(+), 3 deletions(-)
>  create mode 100644 kas/opt/ebg-snakeoil-swu.yml
>  create mode 100644 kas/opt/ebg-swu.yml
> 

Thanks, applied to next, with weak IMAGE_TYPE in patch 2 (complain if
that is not appropriate).

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--tuR2KzpRK2UmK8B9MW1L
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6484): https://lists.cip-project.org/g/cip-dev/message=
/6484
Mute This Topic: https://lists.cip-project.org/mt/83123858/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--tuR2KzpRK2UmK8B9MW1L--
