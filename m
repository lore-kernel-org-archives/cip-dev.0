Return-Path: <SRS0=3uO+=AH=lists.cip-project.org=bounce+64572+4841+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D3CC433E0
	for <cip-dev@archiver.kernel.org>; Fri, 26 Jun 2020 13:37:12 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40368207D8
	for <cip-dev@archiver.kernel.org>; Fri, 26 Jun 2020 13:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="edvlarEe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40368207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4841+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id vTh6YY4521723xUGIRsiX1Wu; Fri, 26 Jun 2020 06:37:11 -0700
X-Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web10.7927.1593178630356274183
 for <cip-dev@lists.cip-project.org>;
 Fri, 26 Jun 2020 06:37:11 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 05QDb7qu031620
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Fri, 26 Jun 2020 15:37:08 +0200
X-Received: from [167.87.75.117] ([167.87.75.117])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 05QDb7DV028341;
	Fri, 26 Jun 2020 15:37:07 +0200
Subject: Re: [cip-dev] [isar-cip-core RFC 1/4] recipes-bsp: Add efibootguard
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>,
        cip-dev@lists.cip-project.org
References: <20200625132111.16367-1-Quirin.Gylstorff@siemens.com>
 <20200625132111.16367-2-Quirin.Gylstorff@siemens.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <a8fae96e-2524-7b8b-c1dc-e498162f34be@siemens.com>
Date: Fri, 26 Jun 2020 15:37:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200625132111.16367-2-Quirin.Gylstorff@siemens.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: IRXVKiizkVFkW0kfDxFF7ndDx4520388AA=
Content-Type: multipart/mixed; boundary="2YHhoijrpr9oS1RD7fMJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1593178631;
 bh=np+TV3hdaXFdNbV6a5TJHftoLebaDLaHt2/nR8+77vc=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=edvlarEePyWaFTZBu2i+jrqKnq1/EHyZyPglkQOydaYBaJT0PoTGqoXaGmwjC7XqNTk
 DhSv2vlDLtK0O/ZV45RDpuTNuVPPcTUoTvDQf01gKZUO4xf3UIfWsv65pSCk4q5OwUcDn
 FUufwVkeGQnKUrc9EtJ2jrwf/yvfNGKSGuE=

--2YHhoijrpr9oS1RD7fMJ
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 25.06.20 15:21, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Add the bootloader efibootguard for A/B partition update
> on x86 with EFI.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>   .../efibootguard/efibootguard_0.6-git+isar.bb |  46 +++++

I just released 0.7. Maybe you could update when preparing v2.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

--2YHhoijrpr9oS1RD7fMJ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4841): https://lists.cip-project.org/g/cip-dev/message=
/4841
Mute This Topic: https://lists.cip-project.org/mt/75102473/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--2YHhoijrpr9oS1RD7fMJ--
