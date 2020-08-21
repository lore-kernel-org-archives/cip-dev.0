Return-Path: <SRS0=pLxm=B7=lists.cip-project.org=bounce+64572+5222+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9AB9C433E1
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 14:48:17 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8784D2075E
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 14:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="U+yv7+HL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8784D2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5222+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id hD4kYY4521723xMQCBIShb1g; Fri, 21 Aug 2020 07:48:17 -0700
X-Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web10.135951.1598021296154753080
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Aug 2020 07:48:16 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 07LEmExH019403
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Fri, 21 Aug 2020 16:48:14 +0200
X-Received: from [139.22.122.86] ([139.22.122.86])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 07LEmCl4016585;
	Fri, 21 Aug 2020 16:48:13 +0200
Subject: Re: [cip-dev][isar-cip-core][PATCH v4 2/6] isar-patch: Add initramfs-config patch
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>,
        cip-dev@lists.cip-project.org
References: <20200821095559.28467-1-Quirin.Gylstorff@siemens.com>
 <20200821095559.28467-3-Quirin.Gylstorff@siemens.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <644acb9a-97af-2043-d1ff-6a659bf0fa8d@siemens.com>
Date: Fri, 21 Aug 2020 16:48:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200821095559.28467-3-Quirin.Gylstorff@siemens.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: OBnJYKQO6ffdnY1O2Gb2Eni0x4520388AA=
Content-Type: multipart/mixed; boundary="4KcMehZIjr2BpAdqIrsl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598021297;
 bh=oGJni6LQ/TgxrReIhKLd0W92dHdCraxZcz5XR6lRUdI=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=U+yv7+HLLl6SHM8jSyHh36AvJehw7nztOocUaLVOxJWtbq5gslAL0qrIGUDlAJeGmIs
 JVpFbk/utgYb1IL3ZUk4kuQZkFyWEtQruuw5zgeUG/lGq2AOR5YZI0iT0YUiDFK3/ZgwJ
 C5J8RGV4s9JHNyy1JMjrZ7AU95ck3lG0x0Y=

--4KcMehZIjr2BpAdqIrsl
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 21.08.20 11:55, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Adapt the initramfs generation to set for example the root device
> in the initramfs
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .../0001-u-boot-add-libubootenv.patch         | 161 +++++++-------

The upstream patch still has several style issues that are now reported
on every build start. Could you fix them for a new upstream version? Not
critical here, we will get the proper one once Isar merged and we updated.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

--4KcMehZIjr2BpAdqIrsl
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5222): https://lists.cip-project.org/g/cip-dev/message=
/5222
Mute This Topic: https://lists.cip-project.org/mt/76326084/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--4KcMehZIjr2BpAdqIrsl--
